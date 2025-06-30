--[[
-----------------------------------------------------
@filename       : DormitoryScene
@Description    : 宿舍场景
@date           : 2021-07-21 11:07:25
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.utils.DormitoryScene', Class.impl())

function ctor(self)
    -- 宿舍初始化
    self.mIsInit = false
    -- 全部收纳操作
    self.mIsAllStorage = false
    -- 地板格子列表
    self.mFloorTiteDic = {}
    -- 天花板格子列表（没用）
    self.mTopTiteDic = {}
    -- 墙面格子列表
    self.mWallTiteDic = {}
    -- 家具列表
    self.mFurnitureDic = {}
    -- 墙面物体列表
    self.mWallGoList = {}

    -- 格子父节点
    self.mTileRoot = gs.GameObject.Find("tile")
    -- 墙面父节点
    self.mWallRoot = gs.GameObject.Find("wall")

    --家具数量
    self.mFurnitureNumDic = {}
    --已生成的家具数量
    self.createCount = 0
end

function setup(self)
    self:initTile()
    dormitory.DormitoryManager:addEventListener(dormitory.DormitoryManager.EVENT_DORMITORY_INIT, self.onDormitoryInitHandler, self)

    GameDispatcher:addEventListener(EventName.ENTER_DORMITORY_EDIT, self.onEnterEdit, self)
    GameDispatcher:addEventListener(EventName.QUIT_DORMITORY_EDIT, self.onQuitEdit, self)
    GameDispatcher:addEventListener(EventName.DORMITORY_ALL_STORAGE, self.onAllStorage, self)
    GameDispatcher:addEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE, self.onDormitoryHeroHandler, self)
end

-- 初始化宿舍
function onDormitoryInitHandler(self)
    if not self.m_IsFristCreated then
        local room_id = dormitory.DormitoryManager:getRoomId()
        local buildBaseMsgVo = buildBase.BuildBaseManager:getBuildBaseData(room_id)
        local heroList = buildBaseMsgVo.heroList
        for k, v in pairs(heroList) do
            self.createCount = self.createCount + 1
        end

        local list = dormitory.DormitoryManager:getFurnitureListByDormitory()
        for i, furnitureVo in ipairs(list) do
            local propsVo = props.PropsVo:poolGet()
            propsVo:setTid(furnitureVo.tid)
            propsVo.id = furnitureVo.id
            if propsVo.subType ~= DormitoryCost.FLOOR_SUBTYPE and propsVo.subType ~= DormitoryCost.TOP_SUBTYPE and propsVo.subType ~= DormitoryCost.WALL_SUBTYPE then
                self.createCount = self.createCount + 1
            end
        end

        self:closeForcibly()
    end

    self:initFurniture()
    self.mIsAllStorage = false
    if not self.mIsInit then
        self.mIsInit = true
        self:createQRoleLive()
    end
end

-- 战员入住变化
function onDormitoryHeroHandler(self)
    self:createQRoleLive()
end

-- 进入编辑模式
function onEnterEdit(self)
    dormitory.DormitoryAIManager:removeAllQRole()
end

-- 退出编辑模式
function onQuitEdit(self)
    if not self.mIsAllStorage then
        self:createQRoleLive()
    end
end

-- 全部收纳操作，因为走初始化流程，所以按初始化处理
function onAllStorage(self)
    self.mIsAllStorage = true
    self.mIsInit = false
end

-- 重置可爱战员模型
function createQRoleLive(self)
    if not dormitory.DormitoryManager.isEditState then

        local room_id = dormitory.DormitoryManager:getRoomId()
        local buildBaseMsgVo = buildBase.BuildBaseManager:getBuildBaseData(room_id)
        local heroList = buildBaseMsgVo.heroList

        if not table.empty(heroList) then
            for key, id in pairs(heroList) do
                dormitory.DormitoryAIManager:createQRoleLive(id, function ()
                    self:initCreateFurnituerWithLiveCall()
                end)
            end
        end
        dormitory.DormitoryAIManager:clearOldRoleLive()
    end
end

function initTile(self)
    local parent = gs.GameObject.Find(DormitoryCost.FLOOR_TILE_ROOT)
    for c = 1, DormitoryCost.COL_COUNT do
        for r = 1, DormitoryCost.ROW_COUNT do
            local tile = LuaPoolMgr:poolGet(dormitory.DormitoryTile)
            tile:createTite(DormitoryCost.SITE_FLOOR, DormitoryCost.TITE_SIZE * (c - 1) + DormitoryCost.TITE_SIZE / 2, 0, DormitoryCost.TITE_SIZE * (r - 1) + DormitoryCost.TITE_SIZE / 2, c, r)
            if parent then
                tile:setToParent(parent.transform)
            end
            if not self.mFloorTiteDic[c] then
                self.mFloorTiteDic[c] = {}
            end
            self.mFloorTiteDic[c][r] = tile
        end
    end

    for i = 3, 6 do
        for h = 1, DormitoryCost.HIGHT_COUNT do
            for c = 1, DormitoryCost.COL_COUNT do
                local tile = LuaPoolMgr:poolGet(dormitory.DormitoryTile)

                if i == DormitoryCost.SITE_WALL_FRONT then
                    tile:createTite(i, DormitoryCost.TITE_SIZE * (c - 1) + DormitoryCost.TITE_SIZE / 2, DormitoryCost.TITE_SIZE * (h - 1) + DormitoryCost.TITE_SIZE / 2, 0, c, h)
                elseif i == DormitoryCost.SITE_WALL_BACK then
                    tile:createTite(i, -DormitoryCost.TITE_SIZE * (c - 1) - DormitoryCost.TITE_SIZE / 2, DormitoryCost.TITE_SIZE * (h - 1) + DormitoryCost.TITE_SIZE / 2, 0, c, h)
                elseif i == DormitoryCost.SITE_WALL_LEFT then
                    tile:createTite(i, 0, DormitoryCost.TITE_SIZE * (h - 1) + DormitoryCost.TITE_SIZE / 2, DormitoryCost.TITE_SIZE * (c - 1) + DormitoryCost.TITE_SIZE / 2, c, h)
                elseif i == DormitoryCost.SITE_WALL_RIGHT then
                    tile:createTite(i, 0, DormitoryCost.TITE_SIZE * (h - 1) + DormitoryCost.TITE_SIZE / 2, -DormitoryCost.TITE_SIZE * (c - 1) - DormitoryCost.TITE_SIZE / 2, c, h)
                end

                tile:setToParent(gs.GameObject.Find(DormitoryCost.WALL_TILE_ROOT_LIST[i - 2]).transform)
                if not self.mWallTiteDic[i] then
                    self.mWallTiteDic[i] = {}
                end
                if not self.mWallTiteDic[i][c] then
                    self.mWallTiteDic[i][c] = {}
                end
                self.mWallTiteDic[i][c][h] = tile
            end
        end
    end
end

-- 初始化家具
function initFurniture(self)
    self:destroyFurniture()
    local list = dormitory.DormitoryManager:getFurnitureListByDormitory()
    if not list then
        return
    end

    if not table.empty(list) then
        for i, furnitureVo in ipairs(list) do
            local propsVo = props.PropsVo:poolGet()
            propsVo:setTid(furnitureVo.tid)
            propsVo.id = furnitureVo.id
            if propsVo.subType == DormitoryCost.FLOOR_SUBTYPE
                or propsVo.subType == DormitoryCost.TOP_SUBTYPE
                or propsVo.subType == DormitoryCost.WALL_SUBTYPE then
                local baseData = dormitory.DormitoryManager:getDormitoryBaseVo(propsVo.tid)
                self:replaceStyle(propsVo, baseData, true)
            else
                self:createFurniture(furnitureVo.location, propsVo, furnitureVo, nil, function ()
                    self:initCreateFurnituerWithLiveCall()
                end)
            end
        end
    end
end

--关闭load界面
function closeForcibly(self)
    if self.createCount <= 0 then
        UIFactory:closeForcibly()
        self.m_IsFristCreated = true
    end
end

--初始化家具完成
function initCreateFurnituerWithLiveCall(self)
    if self.m_IsFristCreated then return end

    self.createCount = self.createCount - 1
    self:closeForcibly()
end

-- 摆上家具
function putonFurniture(self, args)
    local propsVo = args.propsVo
    local config_info = args.config_info

    local baseData = dormitory.DormitoryManager:getDormitoryBaseVo(propsVo.tid)
    self.siteType = baseData.posType
    if baseData.subType == DormitoryCost.FLOOR_SUBTYPE or baseData.subType == DormitoryCost.TOP_SUBTYPE or baseData.subType == DormitoryCost.WALL_SUBTYPE then
        --判断正在摆放中的是不是有跟即将排放的相同
        local moveInfoFurnitureList = dormitory.DormitoryManager:getMoveInfoList()
        for id, info in ipairs(moveInfoFurnitureList) do
            if info.move == 2 then
                local _propsVo = props.PropsVo:poolGet()
                _propsVo:setTid(info.tid)
                _propsVo.id = info.id
                if _propsVo.subType == DormitoryCost.FLOOR_SUBTYPE or _propsVo.subType == DormitoryCost.TOP_SUBTYPE or _propsVo.subType == DormitoryCost.WALL_SUBTYPE then
                    if info.id == propsVo.id then
                        return
                    end
                end
            end
        end
        self:replaceStyle(propsVo, baseData)
        return
    end

    if self.siteType == DormitoryCost.SITE_WALL_FRONT or self.siteType == DormitoryCost.SITE_WALL_LEFT
        or self.siteType == DormitoryCost.SITE_WALL_BACK or self.siteType == DormitoryCost.SITE_WALL_RIGHT then
        local site = nil
        if config_info ~= nil then
            site = config_info.location
        else
            local id = self:getSelectSiteId()
            site = DormitoryCost.SITE_WALL_LIST[id]
        end

        self:createFurniture(site, propsVo, nil, config_info)
    else
        self:createFurniture(DormitoryCost.SITE_FLOOR, propsVo, nil, config_info)
    end
    dormitory.DormitoryManager:moveToTempBag(propsVo.id)
end

-- 替换地板、天花板、墙壁样式
function replaceStyle(self, cusPropsVo, baseData, isInit)
    if cusPropsVo.subType == DormitoryCost.FLOOR_SUBTYPE then

        if self.mFloorGo then
            gs.GameObject.Destroy(self.mFloorGo)
            self.mFloorGo = nil
        end

        self.mFloorGo = gs.ResMgr:LoadGO(UrlManager:getDormitoryWallPrefabUrl(baseData.resName))
        self.mFloorGo.transform:SetParent(self.mWallRoot.transform:Find(DormitoryCost.ROOT_WALL_FLOOR), false)

        if not gs.Application.isMobilePlatform then
            local reflectionTexture = self.mFloorGo:GetComponent(ty.ReflectionTexture)
            if reflectionTexture and not gs.GoUtil.IsCompNull(reflectionTexture) then
                reflectionTexture:SetRefTexSize(gs.ReflectionTexture.RefTextrueSize.size_512)
            end
        end
    end
    if cusPropsVo.subType == DormitoryCost.TOP_SUBTYPE then

        if self.mTopGo then
            gs.GameObject.Destroy(self.mTopGo)
            self.mTopGo = nil
        end

        self.mTopGo = gs.ResMgr:LoadGO(UrlManager:getDormitoryWallPrefabUrl(baseData.resName))
        self.mTopGo.transform:SetParent(self.mWallRoot.transform:Find(DormitoryCost.ROOT_WALL_TOP), false)
        gs.GoUtil.ChangeLayer02(self.mTopGo, self.mWallRoot.transform:Find(DormitoryCost.ROOT_WALL_TOP).gameObject.layer)

        local tran = self:getWallRootTran(5)
        local fadeComponent = tran:GetComponent(ty.FadeModelComponent)
        if not gs.GoUtil.IsCompNull(fadeComponent) then
            fadeComponent:Init()
        end
    end
    if cusPropsVo.subType == DormitoryCost.WALL_SUBTYPE then

        if self.mWallGoList then
            for i, go in ipairs(self.mWallGoList) do
                if go then
                    gs.GameObject.Destroy(go)
                end
            end
        end

        self.mWallGoList = {}

        local wallData = dormitory.DormitoryManager:getDormitoryWallData(baseData.tid)
        for i = 3, 6 do
            local resName = UrlManager:getDormitoryWallPrefabUrl(wallData:getWallResByWallId(i))
            local go = gs.ResMgr:LoadGO(resName)
            go.transform:SetParent(self:getWallRootTran(i - 2), false)
            gs.GoUtil.ChangeLayer02(go, self:getWallRootTran(i - 2).gameObject.layer)

            table.insert(self.mWallGoList, go)
        end

        self:addDoor(baseData, wallData)

        self:initWallFade()
    end

    if not isInit then
        self:opStyleDataHandler(cusPropsVo, baseData, 1)
    end

    GameDispatcher:dispatchEvent(EventName.UPDATE_FURNITURE)
end

function initWallFade(self)
    for k, name in pairs(DormitoryCost.ROOT_WALL_LIST) do
        local tran = self:getWallRootTran(k)
        local fadeComponent = tran:GetComponent(ty.FadeModelComponent)
        if not gs.GoUtil.IsCompNull(fadeComponent) then
            fadeComponent:Init()
        end
    end
end

-- 添加配套的门
function addDoor(self, baseData, wallData)
    -- 门
    if self.mDoorData then
        gs.GameObject.Destroy(self.mDoorData.doorGo)

        if self.mDoorData.startCol then
            for c = self.mDoorData.startCol, self.mDoorData.endCol do
                for r = self.mDoorData.startRow, self.mDoorData.endRow do
                    dormitory.DormitorySceneController:setTileHoldFurniture(self.mDoorData.wallId, c, r, 0)
                end
            end
        end

        self.mDoorData = nil
        dormitory.DormitoryManager:setCurDoorData(nil)
    end

    if not string.NullOrEmpty(wallData.doorRes) then
        local resName = UrlManager:getDormitoryWallPrefabUrl(wallData.doorRes)
        local doorGo = gs.ResMgr:LoadGO(resName)
        local doorRoot = self.mWallRoot.transform:Find(DormitoryCost.ROOT_WALL_LIST[wallData.wallId - 2]):Find("door_root")
        doorGo.transform:SetParent(doorRoot, false)
        gs.GoUtil.ChangeLayer02(doorGo, doorRoot.gameObject.layer)

        self.mDoorData = {}
        self.mDoorData.doorGo = doorGo
        self.mDoorData.wallId = wallData.wallId
        self.mDoorData.doorDeep = wallData.doorDeep

        local tile = dormitory.DormitorySceneController:getTile(wallData.wallId, wallData.col, 1)
        if tile then
            local pos = tile:getPosition()
            local posX = pos.x
            local posY = pos.y - DormitoryCost.TITE_SIZE / 2
            local posZ = pos.z

            local startCol = 0
            local startRow = 1
            local endRow = 0
            local endCol = 0

            if wallData.wallId == DormitoryCost.SITE_WALL_FRONT then
                startCol = math.ceil(math.ceil(posX / DormitoryCost.TITE_SIZE) - wallData.doorWidth / 2)
            end
            if wallData.wallId == DormitoryCost.SITE_WALL_BACK then
                startCol = math.ceil(math.ceil(-posX / DormitoryCost.TITE_SIZE) - wallData.doorWidth / 2)
            end
            if wallData.wallId == DormitoryCost.SITE_WALL_LEFT then
                startCol = math.ceil(math.ceil(posZ / DormitoryCost.TITE_SIZE) - wallData.doorWidth / 2)
            end
            if wallData.wallId == DormitoryCost.SITE_WALL_RIGHT then
                startCol = math.ceil(math.ceil(-posZ / DormitoryCost.TITE_SIZE) - wallData.doorWidth / 2)
            end

            gs.TransQuick:LPos(doorGo.transform, posX, posY, posZ)

            endCol = startCol + wallData.doorWidth - 1
            endRow = startRow + wallData.doorHeight - 1

            for c = startCol, endCol do
                for r = startRow, endRow do
                    dormitory.DormitorySceneController:setTileHoldFurniture(wallData.wallId, c, r, DormitoryCost.DOOR_CLIENT_ID)
                end
            end

            self.mDoorData.startCol = startCol
            self.mDoorData.endCol = endCol
            self.mDoorData.startRow = startRow
            self.mDoorData.endRow = endRow
            dormitory.DormitoryManager:setCurDoorData(self.mDoorData)
        end

        local angleList = {180, 90, 0, -90}
        gs.TransQuick:SetRotation(doorGo.transform, 0, angleList[wallData.wallId], 0)

    end
end

-- 处理墙面样式数据（传入的是要上去的那个）
function opStyleDataHandler(self, cusPropsVo, cusBaseData)
    local hasMoveInfo = false
    local list = dormitory.DormitoryManager:getMoveInfoList()
    for i, info in ipairs(list) do
        local baseData = dormitory.DormitoryManager:getDormitoryBaseVo(info.tid)
        if baseData.subType == cusPropsVo.subType then
            local propsVo = props.PropsVo:poolGet()
            propsVo:setTid(info.tid)
            propsVo.id = info.id
            dormitory.DormitoryManager:removeMoveInfo(info.id)
            if info.move == 1 then
                dormitory.DormitoryManager:moveToTempBag(cusPropsVo.id)
                self:setStyleInfo(cusPropsVo, cusBaseData.posType, 2)
            end
            if info.move == 2 then
                dormitory.DormitoryManager:moveToSourceBag(propsVo)
                self:setStyleInfo(propsVo, cusBaseData.posType, 1)
            end

            hasMoveInfo = true
        end
    end

    if hasMoveInfo then
        return
    end

    local list = dormitory.DormitoryManager:getFurnitureListByDormitory()
    for i, furnitureVo in ipairs(list) do
        local propsVo = props.PropsVo:poolGet()
        propsVo:setTid(furnitureVo.tid)
        propsVo.id = furnitureVo.id
        if propsVo.subType == cusPropsVo.subType then

            local baseData = dormitory.DormitoryManager:getDormitoryBaseVo(propsVo.tid)
            dormitory.DormitoryManager:moveToTempBag(cusPropsVo.id)
            dormitory.DormitoryManager:moveToSourceBag(propsVo)

            self:setStyleInfo(propsVo, baseData.posType, 1)
            self:setStyleInfo(cusPropsVo, cusBaseData.posType, 2)
            break
        end
    end
end

-- 设置移动信息到缓存列表 moveType 1-从宿舍到包，2-从包到宿舍
function setStyleInfo(self, propsVo, posType, moveType)
    local data = {}
    data.id = propsVo.id
    data.tid = propsVo.tid
    data.move = moveType
    data.row = 0
    data.col = 0
    data.location = posType
    data.dir = 0
    data.subType = propsVo.subType

    dormitory.DormitoryManager:setMoveInfo(data)
end

-- 列,行
function getTile(self, site, col, row)
    if site == DormitoryCost.SITE_FLOOR then
        if not self.mFloorTiteDic or not self.mFloorTiteDic[col] then
            logWarn("=======获取一个错误格子 col:" .. col .. " row:" .. row .. "======")
            return nil
        end
        return self.mFloorTiteDic[col][row]
    elseif site == DormitoryCost.SITE_TOP then
        -- 没用
        return self.mTopTiteDic[col][row]
    else
        if not self.mWallTiteDic or not self.mWallTiteDic[site] or not self.mWallTiteDic[site][col] then
            logWarn("=======获取一个错误格子 col:" .. col .. " row:" .. row .. "======")
            return nil
        end
        return self.mWallTiteDic[site][col][row]
    end
end

-- 设置格子纹理
function setTileMaterial(self, site, col, row, type)
    local tile = self:getTile(site, col, row)
    if tile then
        tile:setMaterial(type)
    end
end

-- 生成家具
function createFurniture(self, site, propsVo, furnitureVo, configInfo, finishCall)
    if gs.Application.isEditor then
        dormitory.DormitoryObject = require("game/dormitory/utils/DormitoryObject")
        dormitory.DormitoryObject01 = require("game/dormitory/utils/DormitoryObject01")
        dormitory.DormitoryObject02 = require("game/dormitory/utils/DormitoryObject02")
    end

    local obj = nil
    if site == DormitoryCost.SITE_FLOOR or site == DormitoryCost.SITE_TOP then
        obj = dormitory.DormitoryObject.new()
    elseif site == DormitoryCost.SITE_WALL_FRONT or site == DormitoryCost.SITE_WALL_BACK then
        obj = dormitory.DormitoryObject01.new()
    elseif site == DormitoryCost.SITE_WALL_LEFT or site == DormitoryCost.SITE_WALL_RIGHT then
        obj = dormitory.DormitoryObject02.new()
    else
    end
    obj:createObject(site, propsVo, furnitureVo, configInfo, finishCall)
    local id = furnitureVo and furnitureVo.id or propsVo.id
    self.mFurnitureDic[id] = obj

    if self.mFurnitureNumDic[propsVo.subType] == nil then
        self.mFurnitureNumDic[propsVo.subType] = {}
    end
    self.mFurnitureNumDic[propsVo.subType][propsVo.id] = 1

    GameDispatcher:dispatchEvent(EventName.DORMITORY_QUTACOUNTUPDATE)
end

-- 收纳家具
function storageFuniture(self, cusId, cusTid)
    -- logAll(cusTid, "收纳家具")
    local propsVo = props.PropsVo:poolGet()
    propsVo:setTid(cusTid)
    propsVo.id = cusId
    if propsVo.subType == DormitoryCost.FLOOR_SUBTYPE
        or propsVo.subType == DormitoryCost.TOP_SUBTYPE
        or propsVo.subType == DormitoryCost.WALL_SUBTYPE then

        local upPropsVo = nil
        local dic = dormitory.DormitoryManager:getPropsDic()
        for k, v in pairs(dic) do
            if v.subType == propsVo.subType and (v.tid == DormitoryCost.DEFAULT_FLOOR_TID or v.tid == DormitoryCost.DEFAULT_TOP_TID or v.tid == DormitoryCost.DEFAULT_WALL_TID) then
                upPropsVo = v
            end
        end
        if upPropsVo then
            local baseData = dormitory.DormitoryManager:getDormitoryBaseVo(upPropsVo.tid)
            self:replaceStyle(upPropsVo, baseData)
        end

        return
    end

    local obj = self.mFurnitureDic[cusId]
    if obj then
        obj:storageHanlder()
        self.mFurnitureDic[cusId] = nil
    end

    if self.mFurnitureNumDic[propsVo.subType] and self.mFurnitureNumDic[propsVo.subType][propsVo.id] then
        self.mFurnitureNumDic[propsVo.subType][propsVo.id] = nil
    end

    GameDispatcher:dispatchEvent(EventName.DORMITORY_QUTACOUNTUPDATE)
end

-- 重置场景
function reset(self)
    dormitory.DormitoryManager:removeEventListener(dormitory.DormitoryManager.EVENT_DORMITORY_INIT, self.onDormitoryInitHandler, self)

    GameDispatcher:removeEventListener(EventName.ENTER_DORMITORY_EDIT, self.onEnterEdit, self)
    GameDispatcher:removeEventListener(EventName.QUIT_DORMITORY_EDIT, self.onQuitEdit, self)
    GameDispatcher:removeEventListener(EventName.DORMITORY_ALL_STORAGE, self.onAllStorage, self)
    GameDispatcher:removeEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE, self.onDormitoryHeroHandler, self)

    -- self:removeRole()
    dormitory.DormitoryAIManager:removeAllQRole()
    self:destroyFurniture()

    for _, c in pairs(self.mFloorTiteDic) do
        for _, tile in pairs(c) do
            if tile then
                tile:destroy()
                LuaPoolMgr:poolRecover(tile)
            end
        end
    end
    self.mFloorTiteDic = {}
    for _, site in pairs(self.mWallTiteDic) do
        for _, col in pairs(site) do
            for _, tile in pairs(col) do
                if tile then
                    tile:destroy()
                    LuaPoolMgr:poolRecover(tile)
                end
            end
        end
    end
    self.mWallTiteDic = {}

    self.mIsInit = false
end

-- 销毁已有家具
function destroyFurniture(self)
    for k, v in pairs(self.mFurnitureDic) do
        v:removeFurniture()
    end
    self.mFurnitureDic = {}
    self.mFurnitureNumDic = {}
end

--通过Id获取对应家具
function getFurnitureById(self, id)
    if not self.mFurnitureDic then
        return
    end

    return self.mFurnitureDic[id]
end

--获取当前旋转的家具
function getCurSelectFurniture(self)
    for k, v in pairs(self.mFurnitureDic) do
        if v.isSelectState == true then
            return v
        end
    end
end

--获取跟当前位置重叠碰撞的家具交互点
function getCollideInteractPoint(self, pos)
    local interactPointList = {}
    for _, furnitureVo in pairs(self.mFurnitureDic) do
        if furnitureVo.mSite == DormitoryCost.SITE_FLOOR then
            local actionPointDataList = furnitureVo:getAllInteractData()
            for index, pointData in pairs(actionPointDataList) do
                if pointData.heroTid == 0 and pointData.tile then
                    if gs.Vector3.Distance(pointData.tile:getPosition(), pos) <= 0.6 then
                        table.insert(interactPointList, pointData)
                    end
                end
            end
        end
    end
    if table.empty(interactPointList) then return nil end

    local randomIndex = math.random(1, #interactPointList)
    return interactPointList[randomIndex]
end

---随机获取可以交互的家具
function getRandomCanInteractFurniturePointData(self)
    if table.empty(self.mFurnitureDic) then
        return nil
    end
    local furnitureList = {}
    for k, furnitureVo in pairs(self.mFurnitureDic) do
        if furnitureVo.mSite == DormitoryCost.SITE_FLOOR then
            if furnitureVo:getCanActionPoint() then
                table.insert(furnitureList, furnitureVo)
            end
        end
    end

    if table.empty(furnitureList) then
        return nil
    end

    local randomIndex = math.random(1, #furnitureList)
    local furnitureVo = furnitureList[randomIndex]

    local data = furnitureVo:getCanActionPoint()
    if data then
        return data
    end
end

-- 选择墙面
function getSelectSiteId(self)
    local sceneCameraTrans = gs.CameraMgr:GetSceneCameraTrans()
    local sceneCamera = gs.CameraMgr:GetSceneCamera()
    local maxDot = 0
    local selectId = 0
    for i = 1, 4 do
        local wallGo = gs.GameObject.Find(DormitoryCost.ROOT_WALL_LIST[i])
        if wallGo then
            local viewPos = sceneCamera:WorldToViewportPoint(wallGo.transform.position)
            local dir = (wallGo.transform.position - sceneCameraTrans.position).normalized
            local dot = gs.Vector3.Dot(sceneCameraTrans.forward, dir)--判断物体是否在相机前面
            if dot > maxDot then
                selectId = i
                maxDot = dot
            end
        end
    end
    return selectId
end

-- 获取墙面的父节点
function getWallRootTran(self, index)
    if not self.wallRootTranDic then
        self.wallRootTranDic = {}
    end

    local tran = self.wallRootTranDic[index]
    if tran == nil then
        local name = ""
        if index == 5 then
            name = DormitoryCost.ROOT_WALL_TOP
        else
            name = DormitoryCost.ROOT_WALL_LIST[index]
        end

        local wallRootTran = gs.GameObject.Find("wall").transform
        tran = wallRootTran:Find(name)
        self.wallRootTranDic[index] = tran
    end
    return tran
end
--获取家私挂点节点
function getSiteHanging(self, siteType)
    if not self.mSiteParentDic then
        self.mSiteParentDic = {}
    end

    local tran = self.mSiteParentDic[siteType]
    if tran == nil then
        tran = gs.GameObject.Find(DormitoryCost.SITE_ROOT_LIST[siteType]).transform
        self.mSiteParentDic[siteType] = wallRootTran
    end
    return tran
end

--获取场景中的所有的家具
function getFurnitureNum(self, subType)
    local count = 0
    if self.mFurnitureNumDic[subType] ~= nil then
        for k, v in pairs(self.mFurnitureNumDic[subType]) do
            count = count + 1
        end
    end
    return count
end

function deleteFurnitureNum(self, subType, id)
    if self.mFurnitureNumDic[subType] == nil or self.mFurnitureNumDic[subType][id] == nil then
        return
    end
    self.mFurnitureNumDic[subType][id] = nil

    GameDispatcher:dispatchEvent(EventName.DORMITORY_QUTACOUNTUPDATE)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
