--[[
-----------------------------------------------------
@filename       : DormitoryManager
@Description    : 宿舍数据管理
@date           : 2021-07-28 14:45:43
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.manager.DormitoryManager', Class.impl(Manager))

-- 宿舍数据初始化
EVENT_DORMITORY_INIT = "EVENT_DORMITORY_INIT"
-- 宿舍入住战员改变
-- EVENT_DORMITORY_HERO_UPDATE = "EVENT_DORMITORY_HERO_UPDATE"

--构造
function ctor(self)
    super.ctor(self)
    self:init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:init()
end

--初始化
function init(self)
    -- 当前宿舍id
    self.m_CurDormitoryId = 0

    -- 有选中家具
    self.hasSelectFurniture = false
    -- 格子展示列表
    self.mTileShowList = {}
    -- 宿舍数据
    self.mDormitoryData = {}
    -- 移动数据
    self.mMoveInfo = {}
    -- -- 入住战员数据
    -- self.mDormitoryHeroData = {}
    -- 选择入住的战员
    -- self.mSelectHeroIdData = nil

    -- 是否编辑状态
    self.isEditState = false

    --是否正在操作移动的战员ID
    self.mCurControllerLiveTid = nil

    --当前宿舍所有的家具（使用中的跟未使用中的,所有在场景上的家具）
    self.mAllFurnitureDic = nil

    -- 播放脚步声的战员id（仅播放一个）
    -- self.playFsHeroId = nil
end

function parseConfigData(self)
    self.mDormitoryBaseData = {}
    local baseData = RefMgr:getData("dormitory_data")
    for key, data in pairs(baseData) do
        local baseVo = dormitory.DormitoryBaseVo.new()
        baseVo:parseCogfigData(key, data)
        self.mDormitoryBaseData[key] = baseVo
    end

    self.mFurnitureMenuBaseList = {}
    local baseData = RefMgr:getData("furniture_data")
    for key, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(dormitory.DormitoryMenuVo)
        ro:parseData(key, data)
        table.insert(self.mFurnitureMenuBaseList, ro)
    end

    self.mWallStyleData = {}
    local baseData = RefMgr:getData("dormitory_wall_data")
    for key, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(dormitory.DormitoryWallVo)
        ro:parseData(key, data)
        self.mWallStyleData[key] = ro
    end

    self.mLiveBubbleTxtConfig = {}
    local baseData = RefMgr:getData("bubble_data")
    for liveTid, v1 in pairs(baseData) do
        if not table.empty(v1.bubble_txt) then
            if not self.mLiveBubbleTxtConfig[liveTid] then
                self.mLiveBubbleTxtConfig[liveTid] = {}
            end

            for _, v2 in pairs(v1.bubble_txt) do
                if not self.mLiveBubbleTxtConfig[liveTid][v2.type] then
                    self.mLiveBubbleTxtConfig[liveTid][v2.type] = {}
                end
                table.insert(self.mLiveBubbleTxtConfig[liveTid][v2.type], v2.txt)
            end
        end
    end
end

-- 解析宿舍信息
function parseDormitoryInfoMsg(self, msg)
    -- for i, dormitory_info in ipairs(msg.dormitory_list) do

    local dormitory_Info = {}
    dormitory_Info.dormitory_id = msg.dormitory_info.dormitory_id --宿舍id
    dormitory_Info.furniture_list = {} --家具列表
    dormitory_Info.comfort = msg.dormitory_info.comfort --舒适度
    dormitory_Info.add_hero_stamina_speed = msg.dormitory_info.add_hero_stamina_speed --加成的战员疲劳恢复速度

    for i, pt_furniture_info in ipairs(msg.dormitory_info.furniture_list) do
        local vo = dormitory.DormitoryFurnitureVo.new()
        vo:parseMsg(pt_furniture_info)
        table.insert(dormitory_Info.furniture_list, vo)
    end
    self.mDormitoryData[msg.dormitory_info.dormitory_id] = dormitory_Info
    -- end

    self:dispatchEvent(self.EVENT_DORMITORY_INIT)
end

-- -- 解析入住战员信息
-- function parseSettledHeroMsg(self, msg)
--     self.mDormitoryHeroData[self.m_CurDormitoryId] = {}
--     for i, heroInfo in ipairs(msg.hero_list) do
--         self.mDormitoryHeroData[self.m_CurDormitoryId][heroInfo.id] = heroInfo.pos
--     end
--     self:dispatchEvent(self.EVENT_DORMITORY_HERO_UPDATE)
-- end

---------------------------------------------------------------
--获取站员的AI气泡文本，站员id、AI状态
function getLiveBubbleText(self, liveTid, state)
    if not self.mLiveBubbleTxtConfig then
        self:parseConfigData()
    end
    if table.empty(self.mLiveBubbleTxtConfig[liveTid]) then return nil end

    local textConfig = self.mLiveBubbleTxtConfig[liveTid][state]
    if textConfig and not table.empty(textConfig) then
        local random_index = math.random(1, #textConfig)
        return textConfig[random_index]
    end
end

-- 获取某个宿舍里入住的战员列表
function getSettledHeroDataById(self)
    local buildBaseMsgVo = buildBase.BuildBaseManager:getBuildBaseData(self.m_CurDormitoryId)
    local heroList = buildBaseMsgVo.heroList
    return heroList
end

-- 获取选择的入住战员列表
function getSelectHeroDic(self, dormitoryId)
    if not self.mSelectHeroIdData then
        self.mSelectHeroIdData = {}
        for pos, id in pairs(self:getSettledHeroDataById()) do
            self.mSelectHeroIdData[id] = pos
        end
    end
    return self.mSelectHeroIdData
end

-- -- 缓存选择的入住战员id
function setSettledHeroId(self, heroTid)
    if self:getSettledHeroPos(heroTid) then
        self.mSelectHeroIdData[heroTid] = nil
    else
        local posList = table.values(self.mSelectHeroIdData)

        local roomConfigData = buildBase.BuildBaseManager:getBuildBasePosDataByPos(self.m_CurDormitoryId)
        local levelsData = buildBase.BuildBaseManager:getBuildBaseLevelNeedData(roomConfigData.buildType)

        local roomData = buildBase.BuildBaseManager:getBuildBaseData(self.m_CurDormitoryId)
        local roomLevelConfigData = levelsData:getLevelDataVo(roomData.lv)

        local maxNum = roomLevelConfigData:getNum()
        for i = 1, maxNum do
            if table.indexof(posList, i) == false then
                self.mSelectHeroIdData[heroTid] = i
                break
            end
        end
    end
end

-- 获取战员是否选择入住
function getSettledHeroPos(self, heroTid)
    local heroInfo = self:getSelectHeroDic()
    return heroInfo[heroTid]
end

-- 重置选择入住战员列表
function resetSelectHero(self)
    self.mSelectHeroIdData = nil
end
-------------------------------------------------

function initAllFurnitureDic(self)
    self.mAllFurnitureDic = {}

    local use_list = self:getFurnitureListByDormitory()
    if use_list then
        for i, furnitureVo in ipairs(use_list) do
            local propsVo = props.PropsVo:poolGet()
            propsVo:setTid(furnitureVo.tid)
            propsVo.id = furnitureVo.id
            if furnitureVo.move ~= 1 then
                propsVo.useing = 1
            end

            if not self.mAllFurnitureDic[propsVo.subType] then
                self.mAllFurnitureDic[propsVo.subType] = {}
            end
            self.mAllFurnitureDic[propsVo.subType][propsVo.id] = propsVo
        end
    end
end

--获取指定页签的家具
function getSubtypeFurniture(self, subType)
    if not self.mAllFurnitureDic then
        self:initAllFurnitureDic()
    end

    if not self.mAllFurnitureDic[subType] then
        self.mAllFurnitureDic[subType] = {}
    end

    local propList = self:getAllTempBag()
    if propList then
        for id, propsVo in pairs(propList) do
            if propsVo.subType == subType and self.mAllFurnitureDic[subType][propsVo.id] == nil then
                if not propsVo.useing then
                    propsVo.useing = 1
                end
                self.mAllFurnitureDic[subType][propsVo.id] = propsVo
            end
        end
    end

    local list = self:getPropsList(subType)
    if list then
        for k, propsVo in pairs(list) do
            if self.mAllFurnitureDic[subType][propsVo.id] == nil then
                if not propsVo.useing then
                    propsVo.useing = nil
                end
                self.mAllFurnitureDic[subType][propsVo.id] = propsVo
            end
        end
    end

    return self.mAllFurnitureDic[subType]
end
--使用某个家具
function useingFurniture(self, subType, useProp_id)
    self:getSubtypeFurniture(subType)

    local propsVo = self.mAllFurnitureDic[subType][useProp_id]
    if propsVo ~= nil then
        propsVo.useing = 1

    end
end

--不使用某个家具
function unUseingFurniture(self, subType, useProp_id)
    self:getSubtypeFurniture(subType)

    local propsVo = self.mAllFurnitureDic[subType][useProp_id]
    if propsVo ~= nil then
        propsVo.useing = nil
    end
end

--获取所有的家具(使用中的，没使用中的)
function getAllFurniture(self)
    if not self.mAllFurnitureDic then
        self:initAllFurnitureDic()

        local menuList = self:getFunitureMenuList()
        for i, v in ipairs(menuList) do
            self:getSubtypeFurniture(v.type)
        end
    end
    return self.mAllFurnitureDic
end

--清理所有家具
function clearAllFurniture(self, notClear)
    if not self.mAllFurnitureDic then return end

    for subtype, propList in pairs(self.mAllFurnitureDic) do
        for k, propVo in pairs(propList) do
            propVo.useing = nil
        end
    end
    if not notClear then
        self.mAllFurnitureDic = nil
    end
end

-- 家具基础数据
function getDormitoryBaseVo(self, cusTid)
    if not self.mDormitoryBaseData then
        self:parseConfigData()
    end
    return self.mDormitoryBaseData[cusTid]
end

--获取宿舍数据
function getDormitoryData(self, dormitoryId)
    dormitoryId = dormitoryId or self.m_CurDormitoryId
    return self.mDormitoryData[dormitoryId]
end

-- 获取宿舍的家具列表
function getFurnitureListByDormitory(self, dormitoryId)
    dormitoryId = dormitoryId or self.m_CurDormitoryId
    local dormitoryData = self:getDormitoryData(dormitoryId)
    if dormitoryData then
        return dormitoryData.furniture_list
    end
end

-- 取家具服务器数据
function getFurnitureInfo(self, propsId, dormitoryId)
    dormitoryId = dormitoryId or self.m_CurDormitoryId
    local list = self:getFurnitureListByDormitory(dormitoryId)
    for i, v in ipairs(list) do
        if v.id == propsId then
            return v
        end
    end
    return nil
end

-- 获取宿舍里家具的道具tid
function getFurnitruePropsTid(self, propsId, dormitoryId)
    local data = self:getMoveInfo(propsId)
    if data then
        return data.tid
    end

    dormitoryId = dormitoryId or self.m_CurDormitoryId
    local list = self:getFurnitureListByDormitory(dormitoryId)
    for i, v in ipairs(list) do
        if v.id == propsId then
            return v.tid
        end
    end
end

-- 获取家具菜单配置
function getFunitureMenuList(self)
    if not self.mFurnitureMenuBaseList then
        self:parseConfigData()
    end
    return self.mFurnitureMenuBaseList
end

-- 获取墙面样式数据
function getDormitoryWallData(self, tid)
    return self.mWallStyleData[tid]
end

function setCurDoorData(self, doordata)
    self.mWallDoorData = doordata
end

-- 获取当前门的厚度
function getCurDoorDeep(self)
    if self.mWallDoorData == nil then
        local list = self:getFurnitureListByDormitory(self.m_CurDormitoryId)
        for i, v in ipairs(list) do
            local propsVo = props.PropsVo:poolGet()
            propsVo:setTid(v.tid)
            if propsVo.subType == DormitoryCost.WALL_SUBTYPE then
                local wallData = self:getDormitoryWallData(propsVo.tid)
                return wallData.doorDeep
            end
        end
    else
        return self.mWallDoorData.doorDeep
    end
    return 2
end

-- 要走的格子是不是可以走
function getIsCanMove(self, tile, liveTid)
    local endCol = tile.col + 1
    local endRow = tile.row + 1
    local startCol = tile.col - 1
    local startRow = tile.row - 1

    for c = startCol, endCol do
        for r = startRow, endRow do
            local tileData = dormitory.DormitorySceneController:getTile(DormitoryCost.SITE_FLOOR, c, r)
            if not tileData then
                return false
            end

            local type, id = tileData:getState2()
            if id ~= nil and id > 0 and id ~= liveTid then
                return false
            end

        end
    end
    return true
end

-- 保存显示提示的格子位置
function addTileTip(self, site, col, row)
    local key = string.format("%s_%s_%s", site, col, row)

    if self.mTileShowList[key] == nil then
        self.mTileShowList[key] = {site = site, col = col, row = row}
    end
end

function getTileTipList(self)
    return self.mTileShowList
end

function clearTileTipList(self)
    self.mTileShowList = {}
end

-- 保存家具移动信息
function setMoveInfo(self, cusData)
    if cusData.move == 1 then
        self:unUseingFurniture(cusData.subType, cusData.id)
    elseif cusData.move == 2 or cusData.move == 0 then
        self:useingFurniture(cusData.subType, cusData.id)
    end

    local furnitureVo = nil
    for k, _vo in pairs(self.mDormitoryData[self.m_CurDormitoryId].furniture_list) do
        if _vo.id == cusData.id then
            furnitureVo = _vo
            break
        end
    end

    if furnitureVo then
        furnitureVo.move = cusData.move
    end

    local vo = {}
    vo.id = cusData.id
    vo.tid = cusData.tid
    vo.move = cusData.move
    vo.put_info = {}
    vo.put_info.row = cusData.row
    vo.put_info.columns = cusData.col
    vo.put_info.location = cusData.location
    vo.put_info.direction = cusData.dir

    self.mMoveInfo[vo.id] = vo
end
-- 取家具保存的移动信息
function getMoveInfo(self, cusId)
    local info = nil
    local vo = self.mMoveInfo[cusId]
    if vo then
        info = {tid = vo.tid, col = vo.put_info.columns, row = vo.put_info.row, dir = vo.put_info.direction}
    end
    return info
end
-- 删除家具移动信息
function removeMoveInfo(self, cusId)
    self.mMoveInfo[cusId] = nil
end
-- 获取移动家具的列表
function getMoveInfoList(self)
    local list = table.values(self.mMoveInfo)
    return list
end
-- 重置移动家具列表
function resetMoveInfoList(self)
    self.mMoveInfo = {}
end

function getPropsList(self, subType)
    local dic = self:getPropsDic()
    local list = {}

    -- "全部"选项
    if subType > 100 then
        local subTypeList = {}
        for k, v in pairs(self.mDormitoryBaseData) do
            if v.tabType == subType and table.indexof(subTypeList, v.subType) == false then
                table.insert(subTypeList, v.subType)
            end
        end

        for k, v in pairs(dic) do
            if table.indexof(subTypeList, v.subType) ~= false then
                table.insert(list, v)
            end
        end

        return list
    end

    -- 一般选项
    for k, v in pairs(dic) do
        if not subType or v.subType == subType then
            table.insert(list, v)
        end
    end
    return list
end

--获取当前正在操作的战员id
function getCurControllerLiveTid(self)
    return self.mCurControllerLiveTid
end

--设置当前正在操作的战员Id
function setCurControllerLiveTid(self, liveTid)
    self.mCurControllerLiveTid = liveTid
end

-- 获取背包家具列表缓存
function getPropsDic(self)
    if not self.propsDic then
        local list = bag.BagManager:getPropsListByType(PropsType.FURNITURE, nil, bag.BagType.Furniture)
        self.propsDic = {}
        for i, vo in ipairs(list) do
            self.propsDic[vo.id] = vo
        end
    end
    return self.propsDic
end

-- 清除背包家具列表缓存
function clearPropsList(self, isIgnore)
    -- 临时背包无道具时才能清除
    if not self.mTempDic or table.nums(self.mTempDic) <= 0 then
        self.propsDic = nil
    end
    if isIgnore then
        self.mTempDic = nil
        self.propsDic = nil
    end
end

-- 移动到临时背包
function moveToTempBag(self, cusId)
    local propsVo = self:getPropsDic()[cusId]
    if not self.mTempDic then
        self.mTempDic = {}
    end

    self.mTempDic[cusId] = propsVo
    self:getPropsDic()[cusId] = nil
end

function getAllTempBag(self)
    return self.mTempDic
end

-- 从临时背包还原到来源背包,无论临时背包有没有都存入来源背包
function moveToSourceBag(self, cusPropsVo)
    if self.mTempDic and self.mTempDic[cusPropsVo.id] then
        self.mTempDic[cusPropsVo.id] = nil
    end

    self:getPropsDic()[cusPropsVo.id] = cusPropsVo
end

-- 获取对应页签的道具红点状态
function getFurnitureSubTypeRedPointState(self, sub)
    local propsList = self:getPropsList(sub)
    for k, v in pairs(propsList) do
        if read.ReadManager:isModuleRead(ReadConst.FURNITURE, v.id) then
            return true
        end
    end
    return false
end

--设置当前宿舍的房间id
function setRoomId(self, roomId)
    self.m_CurDormitoryId = roomId
end

---获取当前宿舍的房间id
function getRoomId(self)
    return self.m_CurDormitoryId
end

--------------家具套装---------------
function parseSuitConfigData(self)
    if not gs.Application.isEditor then
        if not self.mFurnitureSuitBaseList then
            self.mFurnitureSuitBaseList = {}

            local baseData = RefMgr:getData("dormitory_suit_data")
            for key, data in pairs(baseData) do
                self.mFurnitureSuitBaseList[key] = data
            end
        end
    else
        self.mFurnitureSuitBaseList = {}

        local baseData = RefMgr:getData("dormitory_suit_data", true)
        for key, data in pairs(baseData) do
            self.mFurnitureSuitBaseList[key] = data
        end
    end
end
function getAllSuitCount(self)
    return table.nums(self:getSuitDic())
end

function isHaveSuit(self, suit_id)
    self:parseSuitConfigData()

    local suitDic = self:getSuitDic()
    return suitDic[suit_id] ~= nil
end

function getSuitDic(self)
    self:parseSuitConfigData()

    local list = {}
    for suitId, suitConfig in pairs(self.mFurnitureSuitBaseList) do
        local suitData =
        {
            id = suitId,
            land_id = suitConfig.land_id,
            icon_path = suitConfig.icon_path,
            furniture_list = {},
            aura = 0,
            useing = 1,
        }

        local allHave = true

        local furnitureList = self:getAllFurniture()

        local copy_list = {}
        for subtype, propList in pairs(furnitureList) do
            for propsId, propVo in pairs(propList) do
                copy_list[propsId] = {propVo = propVo, occupy_index = nil}
            end
        end

        for index, furnitureConfigInfo in pairs(suitConfig.furniture_list) do
            local furniture_info = nil

            for propsId, copy in pairs(copy_list) do
                if copy.occupy_index == nil or copy.occupy_index == index then
                    if copy.propVo.tid == furnitureConfigInfo.tid then
                        if furniture_info == nil or furniture_info.useing == nil then
                            if furniture_info ~= nil then
                                copy_list[furniture_info.id].occupy_index = nil
                            end

                            furniture_info =
                            {
                                tid = furnitureConfigInfo.tid,
                                id = propsId,
                                row = furnitureConfigInfo.row,
                                col = furnitureConfigInfo.col,
                                location = furnitureConfigInfo.location,
                                dir = furnitureConfigInfo.direction,
                                useing = copy.propVo.useing,
                                sort = 0,
                            }

                            copy.occupy_index = index

                            --优先墙壁地面
                            if copy.propVo.subType == DormitoryCost.FLOOR_SUBTYPE or copy.propVo.subType == DormitoryCost.TOP_SUBTYPE or copy.propVo.subType == DormitoryCost.WALL_SUBTYPE then
                                furniture_info.sort = 1
                            end

                            if furniture_info.useing == 1 then
                                break
                            end
                        end
                    end
                end
            end

            if furniture_info == nil then
                allHave = false
                break
            else
                if furniture_info.useing ~= 1 then
                    suitData.useing = nil
                end

                local base_furnitureData = dormitory.DormitoryManager:getDormitoryBaseVo(furniture_info.tid)
                suitData.aura = suitData.aura + base_furnitureData.aura

                table.insert(suitData.furniture_list, furniture_info)
            end
        end

        if allHave then
            table.sort(suitData.furniture_list, function (a, b)
                return a.sort > b.sort
            end)

            list[suitId] = suitData
        end

    end
    return list
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
