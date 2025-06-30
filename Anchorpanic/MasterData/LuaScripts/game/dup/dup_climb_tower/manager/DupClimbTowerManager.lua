module('dup.DupClimbTowerManager', Class.impl(Manager))
--[[ 
    爬塔副本数据管理器
    @autor Jacob 
]]
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

--初始化
function __init(self)
    self.isInDeep = StorageUtil:getBool0("inDeep")
    self.isRoundEnd = false
    self.isPassAll = false
    self.hasDeepData = false

    self.isInElementFight = false
    self.isInTowerFight = false
    self.backToMain = false

    self.targetPos = nil
    self.ToPosIndex = nil
    self.mGotoNextLevel = false
    self.nowDupId = nil

    self.ToDeepPosIndex = nil
    self.nowDeepDupId = nil

    self.mAwardAreaList = {}
    self.mPassDup = {}
    self.mBaseData = {}
    self.mAreaData = {}
    self.mElementData = {}
    self.mElementDupData = {}
    self.mElementMsgData = {}

    -- gm设置跳过时间限制
    self.isGmOpen = false
end

function resetData(self)
    self:__init()
end

function setInDeep(self, isInDeep)
    self.isInDeep = isInDeep
    StorageUtil:saveBool0("inDeep", self.isInDeep)
end

function getInDeep(self)
    return self.isInDeep
end

function setGotoNextLevel(self, isToNextLevel, nowDupId)
    if (isToNextLevel) then
        self.nowDupId = tonumber(nowDupId)
    else
        self.nowDupId = nil
    end
    self.mGotoNextLevel = isToNextLevel
end

function getGotoNextLevel(self)
    if self.nowDupId ~= nil then
        local nextId = self:getDupVo(self.nowDupId).next_id
        local vo = self:getDupVo(nextId)
        local areaVo = self:getAreaVo(vo.areaId)
        if areaVo.level > role.RoleManager:getRoleVo():getPlayerLvl() or areaVo.areaId > self:maxAreaId() then
            gs.Message.Show("下一关未开放")
            return false
        end
    end

    return self.mGotoNextLevel
end

function setGotoNextDeepLevel(self, isToNextLevel, nowDupId)
    if (isToNextLevel) then
        self.nowDeepDupId = tonumber(nowDupId)
    else
        self.nowDeepDupId = nil
    end
    self.mGotoNextLevel = isToNextLevel
end

function getGotoNextDeepLevel(self)
    if self.nowDeepDupId ~= nil then
        local vo = self:getDeepDupVo(self.nowDeepDupId + 1)
        local areaVo = self:getDeepAreaData()[vo.areaId]
        if (areaVo == nil) then
            return false
        end
        if not areaVo:getIsOpen(GameManager:getServerTime()) then
            gs.Message.Show("下一关未开放")
            return false
        end
    end

    return self.mGotoNextLevel
end

-- 当前打完的副本id
function getNowDupId(self)
    return self.nowDupId
end

-- 当前打完的下一关副本id
function getNextDupId(self)
    if self.nowDupId ~= nil then
        local vo = self:getDupVo(tonumber(self.nowDupId))
        if vo then
            return vo.next_id
        end
    end
    return nil
end

function getNextDeepDupId(self)
    if self.nowDeepDupId ~= nil then
        local vo = self:getDeepDupVo(tonumber(self.nowDeepDupId))
        if vo then
            return vo.next_id
        end
    end
    return nil
end

function getIsInMainPanel(self)
    return self.ToPosIndex == nil
end

function getPosIndex(self)
    return self.ToPosIndex
end

function setPosIndex(self, index)
    self.ToPosIndex = index
end

function getIsInDeepMainPanel(self)
    return self.ToDeepPosIndex == nil
end

function getDeepPosIndex(self)
    return self.ToDeepPosIndex
end

function setDeepPosIndex(self, index)
    self.ToDeepPosIndex = index
end

function getCameraPos(self)
    return self.targetPos
end

function setCameraPos(self, pos)
    if (pos == nil) then
        self.targetPos = nil
        return
    end

    self.targetPos = pos
end

-- 初始化配置表
function parseConfigData(self)
    local baseData = RefMgr:getData('climb_tower_data')
    for key, data in pairs(baseData) do
        local areaVo = LuaPoolMgr:poolGet(dup.DupClimbTowerAreaVo)
        areaVo:parseData(key, data)
        self.mAreaData[key] = areaVo
    end

    baseData = RefMgr:getData('climb_tower_dup_data')
    for key, data in pairs(baseData) do
        local dupVo = LuaPoolMgr:poolGet(dup.DupClimbTowerDupVo)
        dupVo:parseData(key, data)
        self.mBaseData[key] = dupVo
    end

    baseData = RefMgr:getData("element_tower_data")
    for key, data in pairs(baseData) do
        local elementVo = LuaPoolMgr:poolGet(dup.DupClimbElementVo)
        elementVo:parseData(key, data)
        self.mElementData[key] = elementVo
    end

    baseData = RefMgr:getData("element_tower_dup_data")
    for key, data in pairs(baseData) do
        local elementDupVo = LuaPoolMgr:poolGet(dup.DupClimbElementDupVo)
        elementDupVo:parseData(key, data)
        self.mElementDupData[key] = elementDupVo
    end
end

function parseMsgData(self, msg)
    for k, v in pairs(msg.tower_info_list) do
        local vo = LuaPoolMgr:poolGet(dup.DupClimbElementMsgVo)
        vo:parseData(v)
        self.mElementMsgData[vo.id] = vo
        self.hasDeepData = true
    end
end

function updateMsgData(self, msg)
    self.mElementMsgData[msg.tower_info.id]:parseData(msg.tower_info)
end

-- 章节完成
function parseDupClimbTowerRoundEndMsg(self, msg)
    -- 是否全部通关0-章节通关1-所有通关
    if msg.is_all_pass == 1 then
        self.isPassAll = true
    else
        self.isRoundEnd = true
    end
end

--奖励区域列表 
function parseDupClimbTowerAwardList(self, msg)
    if (msg.map_list ~= nil) then
        self.mAwardAreaList = msg.map_list
        LoopManager:addTimer(0.1, 1, self, function()
            if #self.mAreaData == 0 then
                self:getAreaData()
            end
            local isBubbleClimb = self:getFlag()
            mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, isBubbleClimb, funcopen.FuncOpenConst.FUNC_ID_CHELLENGE_TOWER)
        end)
    end
end

-- 基础数据
function datas(self)
    if #self.mBaseData == 0 then
        self:parseConfigData()
    end
    return self.mBaseData
end

-- 区域配置
function getAreaData(self)
    if #self.mAreaData == 0 then
        self:parseConfigData()
    end
    return self.mAreaData
end

function getDeepAreaData(self)
    if #self.mElementData == 0 then
        self:parseConfigData()
    end
    return self.mElementData
end

function getDeepDetail(self, id)
    return self.mElementMsgData[id]
end

-- 当前可打副本
function curDupId(self)
    local dupInfo = dup.DupMainManager:getDupInfoData(DupType.DUP_CLIMB_TOWER)
    if not dupInfo then
        return 0
    end
    local dupVo = self:getDupVo(dupInfo.curId)
    if (dupVo) then
        local areaVo = self:getAreaVo(dupVo.areaId)
        local lock = areaVo.level > role.RoleManager:getRoleVo():getPlayerLvl()
        if (lock) then
            return self:getDupVo(dupInfo.curId).pre_id
        end
    end
    return dupInfo.curId
end

-- 通关的最高副本
function maxDupId(self)
    local dupInfo = dup.DupMainManager:getDupInfoData(DupType.DUP_CLIMB_TOWER)
    if not dupInfo then
        return 0
    end
    return dupInfo.maxId
end

function maxAreaId(self)
    local dupId = self:curDupId()
    if dupId == 0 then
        return self:getDupVo(self:maxDupId()).areaId
    else
        return self:getDupVo(dupId).areaId
    end
end

function passDup(self)
    self.mPassDup = {}
    local maxId = self:maxDupId()
    local data = self:datas()
    for k, v in pairs(data) do
        if k <= maxId then
            if not self.mPassDup[v.areaId] then
                self.mPassDup[v.areaId] = {}
            end
            table.insert(self.mPassDup[v.areaId], v)
        end
    end
end

function getPassDup(self, areaId)
    self:passDup()
    if self.mPassDup[areaId] then
        return self.mPassDup[areaId]
    end
    return {}
end

-- 获取某个副本数据
function getDupVo(self, cusId)
    if cusId == 0 then
        return nil
    end
    local vo = self:datas()[cusId]
    if not vo then
        Debug:log_error('DupClimbTowerManager', '爬塔副本不存在副本id：' .. cusId)
    end
    return vo
end

-- 获取某个副本数据
function getDeepDupVo(self, cusId)
    if #self.mElementDupData == 0 then
        self:parseConfigData()
    end
    return self.mElementDupData[cusId]
end

-- 获取某个区域数据
function getAreaVo(self, cusAreaId)
    local vo = self:getAreaData()[cusAreaId]
    if not vo then
        --Debug:log_error('DupClimbTowerManager', '爬塔副本不存在区域id：' .. cusAreaId)
    end
    return vo
end

-- 取区域副本列表
function getDupListByArea(self, cusAreaId)
    local dupList = {}
    local vo = self:getAreaData()[cusAreaId]
    for _, dupId in pairs(vo:dups()) do
        local dupVo = self:getDupVo(dupId)
        table.insert(dupList, dupVo)
    end
    table.sort(dupList, function(vo1, vo2)
        return vo1.dupId < vo2.dupId
    end)
    return dupList
end

-- 获取副本进度当前区域
function getDupProgressByAreaId(self, areaId)
    local passCount = #self:getPassDup(areaId)
    local allCount = #self:getAreaVo(areaId).mDupList
    return passCount / allCount
end

function getDeepProgressByAreaId(self, id)
    local info = self:getDeepDetail(id)
    local areaVo = self:getDeepAreaData()[id]
    if (info.curDup == 0) then
        return #areaVo.stageList, #areaVo.stageList, 1
    else
        local passIndex = table.indexof(areaVo.stageList, info.maxDup)
        if passIndex ~= false then
            return passIndex, #areaVo.stageList, passIndex / #areaVo.stageList
        end
        return 0, #areaVo.stageList, 0
    end
end


-- 获取副本章节名和副本名
function getDupName(self, cusId, battleType)
    if (battleType == PreFightBattleType.ElementTower) then
        local dupVo = self:getDeepDupVo(cusId)
        if dupVo == nil then
            return _TT(27142), ""
        end
        local areaVo = self:getDeepAreaData()[dupVo.areaId]
        return areaVo:getName(), dupVo:getName()
    else
        local dupVo = self:getDupVo(cusId)
        if dupVo == nil then
            return _TT(27142), ""
        end
        local areaVo = self:getAreaVo(dupVo.areaId)
        return areaVo:getName(), dupVo:getName()
    end
end

function getRecommandFight(self, cusId)
    local dupVo = self:getDupVo(cusId)
    return dupVo.recommend_force
end

function getFlag(self)
    for k, v in pairs(self.mAreaData) do
        if (self:canRecMainChapterAward(k)) then
            return true
        end
    end
    return false
end

--区域奖励是否可领取
function canRecMainChapterAward(self, areaId)
    local isFull = self:getDupProgressByAreaId(areaId) == 1
    return isFull and self:hasAreaAward(areaId) and not table.indexof(self.mAwardAreaList, areaId)
end

function canRecDeepAward(self, id)
    local isFull = self:getDeepProgressByAreaId(id) == 1
    return isFull and not table.indexof(self.mAwardAreaList, id)
end

--区域奖励是否已经领取
function hasRecChapterAward(self, areaId)
    return table.indexof(self.mAwardAreaList, areaId)
end

-- 是否有区域奖励
function hasAreaAward(self, areaId)
    local areaVo = self:getAreaVo(areaId)
    if areaVo and areaVo.awardList and not table.empty(areaVo.awardList) then
        return true
    end
    return false
end

-- 获取额外上阵的战员列表
function getExtraHeros(self, cusId, battleType)
    local dupVo = nil
    if (battleType == PreFightBattleType.ClimbTowerDup) then
        dupVo = self:getDupVo(cusId)
    elseif (battleType == PreFightBattleType.ElementTower) then
        dupVo = self:getDeepDupVo(cusId)
    end
    return dupVo.extraHeros
end


return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27142):	"已通关"
]]