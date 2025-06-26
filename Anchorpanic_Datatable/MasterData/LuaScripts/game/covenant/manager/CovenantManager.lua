module('covenant.CovenantManager', Class.impl(Manager))

-- 盟约助手助力英雄选择
COVENANT_HELP_HERO_SELECT = "COVENANT_HELP_HERO_SELECT"
-- 盟约信息更新
EVENT_FORCES_UPDATE = "EVENT_FORCES_UPDATE"
-- 研究所更新
EVENT_INSTITUTE_UPDATE = "EVENT_INSTITUTE_UPDATE"

function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    self.m_helperDataDic = nil
    self.m_helperInfoConfigDic = nil
    self.m_helperLvlUpConfigDic = nil
    self.m_convenantSelectConfigDic = nil
    self.m_prestigeConfigDic = nil
    self.instituteLv = 0
    self.mLineData = {}
end

function parseForcesInfo(self, msg)
    -- 势力id
    self.forces_id = msg.forces_id
    -- 声望等阶
    self.prestige_stage = msg.prestige_stage
    -- 声望经验
    self.prestige_exp = msg.prestige_exp
    -- 可变更势力时间戳
    self.change_time = msg.change_time
    -- 剩余天赋点数
    self.remainGeneNum = msg.remain_talent_point
    -- 更新势力信息
    self:dispatchEvent(self.EVENT_FORCES_UPDATE)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CONVENANT_RED_FLAG)
    -- 货币栏更新（统一）
    GameDispatcher:dispatchEvent(EventName.MONEY_BAR_UPDATE, MoneyTid.COVENANT_GENE_POINT_TID)

end

---解析服务器发来的研究所面板信息
function parseInstituteInfo(self, msg)
    self.instituteLv = msg.lv
    self.instituteAttr = msg.cur_lv_attr_list
    self.instituteNextAttr = msg.next_lv_attr_list
    self:dispatchEvent(self.EVENT_INSTITUTE_UPDATE)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CONVENANT_RED_FLAG)
end

function updateInstitute(self, msg)
    if msg.result == 1 then
        GameDispatcher:dispatchEvent(EventName.UPDATE_INSTITUTE_PANEL)
    end
end

function getInstituteServerInfo(self)
    return { id = self.instituteId, exp = self.instituteExp, lv = self.instituteLv, attr = self.instituteAttr, attrNext = self.instituteNextAttr }
end

-- 盟约选择界面配置
function parseCovenantSelectData(self)
    self.m_convenantSelectConfigDic = {}
    local baseData = RefMgr:getData("forces_data")
    for id, data in pairs(baseData) do
        local vo = covenant.CovenantSelectConfigVo.new()
        vo:parseConfigData(id, data)
        self.m_convenantSelectConfigDic[id] = vo
    end
end

function getCovenantSelectData(self, id)
    if self.m_convenantSelectConfigDic == nil then
        self:parseCovenantSelectData()
    end
    return self.m_convenantSelectConfigDic[id]
end

-- 获取助手Id id 盟约阵营
function getHelperIds(self, id)
    if self.m_convenantSelectConfigDic == nil then
        self:parseCovenantSelectData()
    end
    return self.m_convenantSelectConfigDic[id].helpersId
end

-- 盟约声望配置
function parseCovenantPrestigeData(self)
    self.m_prestigeConfigDic = {}
    local baseData = RefMgr:getData("forces_prestige_data")
    for id, data in pairs(baseData) do
        local vo = covenant.CovenantPrestigeConfigVo.new()
        vo:parseConfigData(id, data)
        self.m_prestigeConfigDic[id] = vo
    end
end

-- 获取盟约选择界面配置
function getSelectConfigData(self)
    if self.m_convenantSelectConfigDic == nil then
        self:parseCovenantSelectData()
    end
    return self.m_convenantSelectConfigDic
end

function getRedFlag(self)
    local isFlag = false
    return (self:getLevelRedPoint()) or (self:getInstituteRed()) or (explore.exploreManager:getExploreRed())
end

--盟约任务暂时屏蔽
function getTaskRed(self)
    if self.serverTaskDic == nil then
        return false
    else
        for k, v in pairs(self.serverTaskDic) do
            if v.state == 0 then
                return true
            end
        end
    end
    return false
end

--盟约研发中心
function getInstituteRed(self)
    if (self.instituteLv and self:getPerstigeStage()) then
        if ((self.instituteLv < self:getCovenantPrestigeDataById(self:getPerstigeStage()).helperLimitLvl) and (self:getInstituteData(101):getHelperLvExp(self.instituteLv) and role.RoleManager:getRoleVo():getPlayerHelperGlobalExp() >= self:getInstituteData(101):getHelperLvExp(self.instituteLv))) then
            return true
        end
        return false
    end
    return false
end

-- 获取是否显示红点
function getLevelRedPoint(self)
    local level = self:getPerstigeStage()
    if level == nil then
        return false
    end
    local nextExp = self:getCovenantPrestigeData()[level].next_exp
    if (self:getPrestigeExp() >= nextExp and nextExp ~= 0) then
        return true
    end
    return false
end
---------------------------------------------------------------- end 盟约选择 ----------------------------------------------------------------

-- 获取所有的声望配置
function getCovenantPrestigeData(self)
    if not self.m_prestigeConfigDic then
        self:parseCovenantPrestigeData()
    end
    return self.m_prestigeConfigDic
end

-- 获取对应id的声望配置
function getCovenantPrestigeDataById(self, id)
    if not self.m_prestigeConfigDic then
        self:parseCovenantPrestigeData()
    end
    return self.m_prestigeConfigDic[id]
end

-- 获取盟约Id 0-未加入
function getForcesId(self)
    return self.forces_id
end

-- 获取声望等级
function getPerstigeStage(self)
    return self.prestige_stage
end

-- 获取声望经验
function getPrestigeExp(self)
    return self.prestige_exp
end

-- 获取声望上限经验
-- function getPrestigeMaxExp(self)
--     return self.max_prestige_exp
-- end

-- 获取可变更势力时间戳
function getChangeTime(self)
    return self.change_time
end

function parseInstituteData(self)
    self.mInstituteDic = {}
    local baseData = RefMgr:getData("forces_inst_data")
    for helperId, data in pairs(baseData) do
        local infoVo = covenant.CovenantInstituteVo.new()
        infoVo:parseConfigData(data)
        self.mInstituteDic[helperId] = infoVo
    end
end

function getInstituteData(self, id)
    if self.mInstituteDic == nil then
        self:parseInstituteData()
    end
    return self.mInstituteDic[id]
end

-- 解析商店配置
function parseConfigData(self, cusData)
    local _sortHelperId = function(vo1, vo2)
        if (vo1 < vo2) then
            return true
        end
        if (vo1 > vo2) then
            return false
        end
        return false
    end
    self.m_helperIdListConfigDic = {}
    self.m_helperInfoConfigDic = {}
    self.m_helperLvlUpConfigDic = {}
    local baseData = RefMgr:getData("forces_helper_data")
    for helperId, data in pairs(baseData) do
        local infoVo = covenant.CovenantHelperInfoVo.new()
        infoVo:parseConfigData(helperId, data)
        self.m_helperInfoConfigDic[helperId] = infoVo
        if (not self.m_helperIdListConfigDic[infoVo.covenantId]) then
            self.m_helperIdListConfigDic[infoVo.covenantId] = {}
        end
        table.insert(self.m_helperIdListConfigDic[infoVo.covenantId], helperId)
        table.sort(self.m_helperIdListConfigDic[infoVo.covenantId], _sortHelperId)

        for key, voData in pairs(data.helper_levelup) do
            local lvlUpVo = covenant.CovenantHelperLvlUpVo.new()
            lvlUpVo:parseConfigData(helperId, voData)
            if (not self.m_helperLvlUpConfigDic[helperId]) then
                self.m_helperLvlUpConfigDic[helperId] = {}
            end
            self.m_helperLvlUpConfigDic[helperId][lvlUpVo.lvl] = lvlUpVo
        end
    end
end

-- 取助手基本信息
function getHelperConfigInfo(self, helperId)
    if (not self.m_helperInfoConfigDic) then
        self:parseConfigData()
    end
    return self.m_helperInfoConfigDic[helperId] or {}
end

-- 取助手升级字典
function getHelperLvlUpDic(self, helperId)
    if (not self.m_helperLvlUpConfigDic) then
        self:parseConfigData()
    end
    return self.m_helperLvlUpConfigDic[helperId] or {}
end

-- 取助手升级配置数据
function getHelperLvlUpConfigVo(self, helperId, cusLvl)
    return self:getHelperLvlUpDic(helperId)[cusLvl] or {}
end

-- 根据声望等级获取助手的限制等级
function getHelperLimitLvl(self, helperId)
    local stage = self:getPerstigeStage()
    local vo = self:getCovenantPrestigeDataById(stage)
    if (vo) then
        return vo.helperLimitLvl
    else
        return 0
    end
end

-- 获取指定助手最大等级
function getHelperMaxLvl(self, helperId)
    local maxLvl = 0
    local lvlDic = self:getHelperLvlUpDic(helperId)
    for lvl, vo in pairs(lvlDic) do
        if (lvl >= maxLvl) then
            maxLvl = lvl
        end
    end
    return maxLvl
end

-- 获取指定助手当前等级的经验上限
function getHelperMaxExp(self, helperId, cusLvl)
    local lvlUpConfigVo = self:getHelperLvlUpConfigVo(helperId, cusLvl)
    return lvlUpConfigVo.exp or 0
end

-- 获取所有助手id列表（covenantId：盟约id/势力id）
function getHelperIdList(self, covenantId)
    if (not self.m_helperIdListConfigDic) then
        self:parseConfigData()
    end
    covenantId = covenantId or self:getForcesId()
    return self.m_helperIdListConfigDic[covenantId] or {}
end

-- 解析服务器所有助手信息
function parseAllHelperData(self, msgVoList)
    self.m_helperDataDic = nil
    for _, msgVo in pairs(msgVoList) do
        self:parseHelperData(msgVo)
    end
end

-- 解析服务器助手信息
function parseHelperData(self, msgVo)
    if (not self.m_helperDataDic) then
        self.m_helperDataDic = {}
    end
    local helperVo = covenant.CovenantHelperVo.new()
    helperVo:parseMsgData(msgVo)
    self.m_helperDataDic[helperVo.helperId] = helperVo
end

function getHelperVo(self, cusHelperId)
    if (self.m_helperDataDic) then
        return self.m_helperDataDic[cusHelperId]
    end
    return nil
end

-- 助手研究所是否有红点
function isHelperBubble(self)
    local isBubble = false
    local helperIdList = self:getHelperIdList()
    for i = 1, #helperIdList do
        local helperVo = covenant.CovenantManager:getHelperVo(helperIdList[i])
        isBubble = self:isHelperCanLvlUp(helperVo)
        if (isBubble) then
            break
        end
    end
    return isBubble
end

-- 助手能否升级
function isHelperCanLvlUp(self, helperVo)
    if (not funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_COVENANT_GRADUATE_SCHOOL, false)) then
        return false
    end
    if (not helperVo) then
        return false
    end
    local limitLvl = covenant.CovenantManager:getHelperLimitLvl(helperVo.helperId)
    local maxLvl = covenant.CovenantManager:getHelperMaxLvl(helperVo.helperId)
    if (helperVo.lvl < maxLvl) then
        if (helperVo.lvl < limitLvl) then
            local propsConfigVo, needCount = self:getLvlUpNeedPropsCount(helperVo)
            local isEnough, tipStr = MoneyUtil.judgeNeedMoneyCountByTid(propsConfigVo.tid, needCount, false, false)
            if (isEnough) then
                return true
            else
                return false
            end
        end
    end
    return false
end

function getLvlUpNeedPropsCount(self, helperVo)
    local costTid = MoneyTid.PLAYER_HELPER_EXP_TID
    local propsConfigVo = props.PropsManager:getPropsConfigVo(costTid)
    if (propsConfigVo.effectType == UseEffectType.ADD_COVENANT_HELPER_EXP) then
        local convertExp = propsConfigVo.effectList[1]
        local needExp = helperVo.maxExp - helperVo.exp
        if (needExp < 0) then
            needExp = 0
        end
        local needCount = math.ceil(needExp / convertExp)
        return propsConfigVo, needCount
    end
    return nil, nil
end
---------------------------------------------------------------- end 盟约助手 ----------------------------------------------------------------

---------------------------------------------------------------- start 盟约天赋 ----------------------------------------------------------------

---------------------------------------------------------------- start 盟约天赋 server----------------------------------------------------------------
function setForcesTalentData(self, msg)
    self.mTalentLevelDic = {}
    for i = 1, #msg.forces_talent_info do
        self.mTalentLevelDic[msg.forces_talent_info[i].id] = { id = msg.forces_talent_info[i].id, level = msg.forces_talent_info[i].level, preShowValue = msg.forces_talent_info[i].pre_show_value, nextShowValue = msg.forces_talent_info[i].next_show_value }
    end
end

function updateForcesTalentData(self, msg)
    for i = 1, #msg.forces_talent_info do
        self.mTalentLevelDic[msg.forces_talent_info[i].id] = { id = msg.forces_talent_info[i].id, level = msg.forces_talent_info[i].level, preShowValue = msg.forces_talent_info[i].pre_show_value, nextShowValue = msg.forces_talent_info[i].next_show_value }
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_COVENANTSKILL_PANEL)
end

function talentUpdateResult(self, msg)
    -- 盟约技能升级成功返回结果
    if msg.result == 1 then
        GameDispatcher:dispatchEvent(EventName.UPDATE_COVENANTSKILL_PANEL)
    end
end

-- 获取盟约天赋等级
function getForcesTalentServerData(self, id)
    if self.mTalentLevelDic == nil then
        return 0
    end
    return self.mTalentLevelDic[id]
end

---------------------------------------------------------------- start 盟约天赋 local----------------------------------------------------------------
function parseForcesTalentData(self)
    self.mTalentDic = {}
    self.mTalentLineDic = {}
    local baseData = RefMgr:getData("forces_talent_data")
    for k, v in pairs(baseData) do
        local vo = covenant.CovenantTalentVo.new()
        vo:parseData(k, v)
        self.mTalentDic[k] = vo

        if self.mTalentLineDic[vo.line] == nil then
            self.mTalentLineDic[vo.line] = {}
            table.insert(self.mTalentLineDic[vo.line], vo)
        else
            table.insert(self.mTalentLineDic[vo.line], vo)
        end
        if (self.mLineData == nil) then
            self.mLineData = {}
        end
        self.mLineData[vo.needStage] = true
    end
end

function getRangeEmptyLine(self, startIndex, endIndex)
    local count = 1
    for i = startIndex, #self.mLineData do
        if (i >= endIndex + 1) then
            break
        end
        if (self.mLineData[i] == nil or not self.mLineData[i]) then
            count = count + 1
        end
    end
    return count
end

function getStageSkillDatas(self, stage)
    if (self.mTalentDic == nil) then
        self:parseForcesTalentData()
    end
    local resList = {}
    for k, v in pairs(self.mTalentDic) do
        if (v.needStage == stage) then
            table.insert(resList, v.skillId)
        end
    end
    return resList
end

function getForcesTalentAllData(self)
    if self.mTalentLineDic == nil then
        self:parseForcesTalentData()
    end
    return self.mTalentLineDic
end

function getForcesTalentData(self, id)
    if self.mTalentDic == nil then
        self:parseForcesTalentData()
    end
    return self.mTalentDic[id]
end

function getForcesTalentSkillMaxLv(self, id)
    if self.mTalentDic == nil then
        self:parseForcesTalentData()
    end
    return self.mTalentDic[id]:getSkillMaxLv()
end
---------------------------------------------------------------- end 盟约天赋 ----------------------------------------------------------------

---------------------------------------------------------------- start盟约任务 ----------------------------------------------------------------

function parseTaskServerData(self, msg)
    if self.serverTaskDic == nil then
        self.serverTaskDic = {}
    end
    for i = 1, #msg.task_info do
        local vo = covenant.CovenantTaskServerVo.new()
        vo:paserServerData(msg.task_info[i])
        self.serverTaskDic[vo.id] = vo
    end

    GameDispatcher:dispatchEvent(EventName.UPDATE_CONVENANT_RED_FLAG)
end

function updateSingleTask(self, msg)
    if self.serverTaskDic == nil then
        self.serverTaskDic = {}
    end
    --if self.serverTaskDic ~= nil then
    local vo = covenant.CovenantTaskServerVo.new()
    vo:paserServerData(msg.task_info)
    self.serverTaskDic[vo.id] = vo
    GameDispatcher:dispatchEvent(EventName.UPDATE_CONVENANT_TASK_PANEL)
    --end
end

function getTaskServerData(self, id)
    return self.serverTaskDic[id]
end

function updateTaskServerResult(self, msg)
    if msg.result == 1 then
        local rewardList = {}
        for i = 1, #msg.task_list do
            self.serverTaskDic[msg.task_list[i]].state = 2
        end
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_CONVENANT_RED_FLAG)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CONVENANT_TASK_PANEL)

end

-- 解析任务列表
function parseTaskData(self)
    self.mTaskList = {}
    local baseData = RefMgr:getData("forces_task_data")
    for k, v in pairs(baseData) do
        local vo = covenant.CovenantTaskVo.new()
        vo:parseData(k, v)
        table.insert(self.mTaskList, vo)
    end
end

-- 获取任务列表
function getTaskData(self)
    if self.mTaskList == nil then
        self:parseTaskData()
    end

    local showDataList = {}
    for i = 1, #self.mTaskList do
        local serverData = self:getTaskServerData(self.mTaskList[i].id)
        local localData = self.mTaskList[i]
        if serverData ~= nil then
            table.insert(showDataList, { localData = localData, serverData = serverData })
        end
    end

    return showDataList
end
---------------------------------------------------------------- end盟约任务 ----------------------------------------------------------------

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
