local M = BaseClass("CmderSkillMgr", Singleton)
local MessageId = Proto.MessageId
local tInsert = table.insert
local EBattleStyle = EnumConst.EBattleStyle

-- 指挥官技能数据
function M:__init()
    -- 指挥官所有技能组，本地表
    self._skillGroupDic = {}
    -- 指挥官技能等级增加表
    self._addLevelDic = {}
    self.m_csCmdSkill = IPlayerData.CommanderSkill
    self.m_maxUpLv = GameHelper.GetParamters(182)[0]
    self:_InitSkillGroup()
end

function M:_InitSkillGroup()
    local configs = ConfigHelper.GetCfgsByLua("commanderSkill")
    for i = 1, #configs, 1 do
        local skill = configs[i]
        if not self._skillGroupDic[skill.cmdID] then
            self._skillGroupDic[skill.cmdID] = {}
        end

        -- 技能组ID为索引
        tInsert(self._skillGroupDic[skill.cmdID], skill)
    end

    for _, group in pairs(self._skillGroupDic) do
        table.sort(group, function(a, b) return a.level < b.level end)
    end

    local levelConfigs = ConfigHelper.GetCfgsByLua("commanderAddLevel")
    for i = 1, #levelConfigs, 1 do
        local addLevel = levelConfigs[i]
        self._addLevelDic[addLevel.cmdID] = addLevel
    end
end

function M:Cleanup()
    -- body
end

function M:Dispose()
    self._skillGroupDic = nil
    self._addLevelDic = nil
    self.m_csCmdSkill = nil
end

function M:RqCmderSkillSettingHero(request)
    if self._skillBindHero then return end
    local responseId = MessageId.ResponseCommanderSkillSettingHero
    local binder = Bind(self, self._OnRsCommanderSkillSettingHero)
    self._skillBindHero = NetPack:RegistResponse(responseId, binder)
    local requestId = MessageId.RequestCommanderSkillSettingHero
    NetPack:SendMessage(requestId, request)
end

function M:RqCmderSkillUpgrade(request)
    if self._skillUpgrade then return end
    local responseId = MessageId.ResponseCommanderSkillUpgrade
    local binder = Bind(self, self._OnRsCommanderSkillUpgrade)
    self._skillUpgrade = NetPack:RegistResponse(responseId, binder)
    NetPack:SendMessage(MessageId.RequestCommanderSkillUpgrade, request)
end

-- 指挥官技能升级
function M:_OnRsCommanderSkillUpgrade(_, result, msg)
    local responseId = MessageId.ResponseCommanderSkillUpgrade
    NetPack:UnRegistResponse(responseId, self._skillUpgrade)
    self._skillUpgrade = nil
    if result ~= 0 then return end
    self:_OnHandleCmderSkill(msg)
end

-- 指挥官技能装配英雄
function M:_OnRsCommanderSkillSettingHero(_, result, msg)
    local responseId = MessageId.ResponseCommanderSkillSettingHero
    NetPack:UnRegistResponse(responseId, self._skillBindHero)
    self._skillBindHero = nil
    if result ~= 0 then return end
    self:_OnHandleCmderSkill(msg)
end

function M:_OnHandleCmderSkill(msg)
    local cmdId = msg.Commander.CmdId
    local _, unlockInfo = self.m_csCmdSkill:TryGetValue(cmdId)
    local heroId, level = 0, 0

    if unlockInfo then
        heroId = unlockInfo.HeroId
        level = unlockInfo.Level
        unlockInfo.HeroId = msg.Commander.HeroId
        unlockInfo.Level = msg.Commander.Level
    else
        unlockInfo = CS.Protocol.CRoleCommander()
        self:_AddCommanderSkill(unlockInfo, msg.Commander)
    end

    GameKeyNodeMgr:GetInstance():Record(EGameKeyNode.CommanderSkillsUp)

    if heroId == 0 and unlockInfo.HeroId > heroId then
        GameHelper.TipsById(818)
    elseif heroId > 0 and unlockInfo.HeroId == 0 then
        GameHelper.TipsById(819)
    end

    if level > 0 and unlockInfo.Level > level then GameHelper.TipsById(820) end
    local group = self._skillGroupDic[cmdId]
    local config = group[1]
    local unlock = GameHelper.CheckLockByOpenConditionId(config.unlock)
    EventMgr:Broadcast(UIMessageNames.BRIDGE_SKILL_UPGRADE, {
        IsUnlock = config.unlock == 0 or unlock,
        HeroId = unlockInfo.HeroId,
        Config = group[unlockInfo.Level]
    })
end

-- 获得已解锁技能列表
function M:GetUnlockSkills()
    local skills = {}

    for cmdId, group in pairs(self._skillGroupDic) do
        local skillCfg = group[1] -- 初级技能配置
        local unlock = GameHelper.CheckLockByOpenConditionId(skillCfg.unlock)
        local _, unlockInfo = self.m_csCmdSkill:TryGetValue(cmdId)

        if skillCfg.unlock == 0 or unlock then
            if not unlockInfo then
                unlockInfo = CS.Protocol.CRoleCommander()
                self:_AddCommanderSkill(unlockInfo, {
                    CmdId = cmdId,
                    HeroId = 0,
                    Level = skillCfg.level
                })
            end

            tInsert(skills, {
                IsUnlock = true,
                HeroId = unlockInfo.HeroId,
                Config = group[unlockInfo.Level]
            })
        else
            -- 移除错误解锁
            if unlockInfo then
                self.m_csCmdSkill:Remove(cmdId)
            end
        end
    end

    table.sort(skills, function(a, b) return a.Config.id < b.Config.id end)
    return skills
end

-- 获得所有指挥官技能
function M:GetAllCmderSkills()
    -- 已解锁技能
    local unlockSkills = self:GetUnlockSkills()
    -- 未解锁技能
    local lockSkills = {}
    for cmdId, group in pairs(self._skillGroupDic) do
        if not self.m_csCmdSkill:ContainsKey(cmdId) then
            local newData = { IsUnlock = false, HeroId = 0, Config = group[1] }
            tInsert(lockSkills, newData)
        end
    end

    table.sort(lockSkills, function(a, b) return a.Config.id < b.Config.id end)

    for _, skillInfo in ipairs(lockSkills) do
        tInsert(unlockSkills, skillInfo)
    end
    return unlockSkills
end

-- 用技能组ID获取技能组
function M:GetSkillGroupConfig(cmdId)
    return self._skillGroupDic[cmdId]
end

-- 使用技能组ID和英雄ID获取等级增加值
function M:GetAddValue(cmdId, heroId)
    if heroId == 0 then return 0 end

    local config = self._addLevelDic[cmdId]
    if config then
        for i = 1, #config.hero, 1 do
            if config.hero[i] == heroId then
                return config.addValue[i]
            end
        end
    end
    return 0
end

-- 获取技能配置信息
function M:GetSkillConfig(cmdId, level)
    local group = self._skillGroupDic[cmdId]
    if group then
        return group[level]
    else
        return nil
    end
end

-- 指挥官技能表Id
function M:GetCommanderSkillId(cmdId)
    local _, roleCommander = self.m_csCmdSkill:TryGetValue(cmdId)
    if not IsNull(roleCommander) then
        local preCfg = self:GetSkillConfig(cmdId, roleCommander.Level) or {}
        local addLevel = self:GetAddValue(cmdId, roleCommander.HeroId) or {}
        local nextCfg = self:GetSkillConfig(cmdId, preCfg.level + addLevel) or {}
        return nextCfg.id
    else
        return 0
    end
end

function M:_AddCommanderSkill(unlockInfo, data)
    unlockInfo.CmdId = data.CmdId
    unlockInfo.HeroId = data.HeroId
    unlockInfo.Level = data.Level
    self.m_csCmdSkill:Add(unlockInfo.CmdId, unlockInfo)
end

-- 指挥官技能升级红点检测
function M:CheckSkillLvUpRedPoint(cmdID)
    if cmdID == 0 then
        for cmdId, group in pairs(self._skillGroupDic) do
            local skillCfg = group[1] -- 初级技能配置
            local unlock = GameHelper.CheckLockByOpenConditionId(skillCfg.unlock)
            local _, unlockInfo = self.m_csCmdSkill:TryGetValue(cmdId)
            if skillCfg.unlock == 0 or unlock then
                if not unlockInfo then
                    unlockInfo = CS.Protocol.CRoleCommander()
                    self:_AddCommanderSkill(unlockInfo, {
                        CmdId = cmdId,
                        HeroId = 0,
                        Level = skillCfg.level
                    })
                end

                if self:CheckSkillUpLv(unlockInfo) then return true end
            else
                -- 移除错误解锁
                if unlockInfo then
                    self.m_csCmdSkill:Remove(cmdId)
                end
            end
        end

        return false
    end

    local _, roleCommander = self.m_csCmdSkill:TryGetValue(cmdID)
    if IsNull(roleCommander) then return false end
    return self:CheckSkillUpLv(roleCommander)
end

-- 是否有升级红点
function M:CheckSkillUpLv(roleCommander)
    local cmdID = roleCommander.CmdId
    local cmdCfg = self:GetSkillConfig(cmdID, roleCommander.Level) or {}
    local level = GameHelper.GetPlayerPrefsInt("CmdSkill" .. cmdID, 0)
    if cmdCfg.level < self.m_maxUpLv and level < cmdCfg.level then
        -- DuSir : 需要检查道具数量
        local isEnough = GameHelper.CheckItemsByLua(cmdCfg.costItem, cmdCfg.costNum)
        return isEnough and ((cmdCfg.unlock == 0) or GameHelper.CheckLockByOpenConditionId(cmdCfg.unlock))
    end
    return false
end

-- 编队边仓技能红点
function M:CmderSkillRedPoint(param)

    if param == -1 then
        return
    end
    local battleStyle = UIContextMgr:GetInstance():GetContext(UIDefine.UITeamConfig):GetBattleStyle()
    -- 遭遇战
    if battleStyle == EBattleStyle.Encount then
        local equippedSkill = EncounterConfMgr:GetInstance():GetCommanderSkills()
        if #equippedSkill >= param then
            return
        end
        local skillNum = #self:GetUnlockSkills()
        return skillNum >= param
    else
        local battleMissionId = TeamConfMgr:GetInstance():GetBattleId()
        if not battleMissionId or battleMissionId == 0 then
            return
        end
        local teamType = ConfigHelper.GetCfgPropByLua("mission", battleMissionId, "teamType")
        if teamType == 1 then
            return
        end
        local equippedSkill = TeamConfMgr:GetInstance():GetCommanderSkills()
        if #equippedSkill >= param then
            return
        end
        local skillNum = #self:GetUnlockSkills()
        return skillNum >= param
    end
end

return M
