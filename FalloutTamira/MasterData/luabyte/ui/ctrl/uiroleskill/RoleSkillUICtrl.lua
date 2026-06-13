-- 预制体 RoleSkillUI_New
local RoleSkillUICtrl = BaseClass("RoleSkillUICtrl", BaseUICtrl)
local M = RoleSkillUICtrl
local SkillOpenId = EnumConst.SkillOpenId -- 技能开放条件
local EQuality = EnumConst.EQuality
local tIndexof = table.indexof
local sfmt = string.format
local JBattleLevel = CS.GameBase.JBattleLevel
local tArrayContains = table.arrayContains
local tArrayIndexof = table.arrayIndexof
local JSkillUpgrading = CS.GameBase.JSkillUpgrading

function M:Init()
    self._roomStorySelectCfg = ConfigHelper.GetCfgs("roomStorySelect")
    self._view.levelUpBtn:onClick(Bind(self, self._OnClickLevelUp))
    self._refreshDataHandler = EventMgr:AddListener(UIMessageNames.ROLE_DEVELOP_REFRESH_DATA, Bind(self, self._OnRefreshData))
    self._tempOnRefreshSkillLv = EventMgr:AddListener(UIMessageNames.ROLE_SKILLUP, Bind(self, self._OnRefreshSkillLv))
    self._refBaseSkillHandler = Bind(self, self._UpdateInfoPanel)
    self._refBattleLevelSkillHandler = Bind(self, self._RefreshBattleLevelSkill)
    self:InitSystem318()
end

function M:InitSystem318()
    if self.tabSystem318 then
        return
    end

    self.tabSystem318 = {}
    -- 推荐技能等级
    local system318 = ConfigHelper.GetSystemParams(318)

    for i = 0, system318.Length - 1, 3 do
        local data = {}

        data.level = system318[i]
        data.skillLevel = system318[i + 1]
        self.tabSystem318[#self.tabSystem318 + 1] = data
    end
end

function M:OnEnter(heroId)
    UIContextMgr:GetInstance():Close("RoleSkillDetailUI")
    self.heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
    self.heroId = heroId
    self._view.labName:SetAvatarName(self.heroId, RoleType.ERT_Hero)
    self._view.imgQuality:SetHeroRare(self.heroId)
    self:_SetSkillInfo()
end

function M:_OnRefreshData(heroId)
    self:OnEnter(heroId)
end

function M:_OnRefreshSkillLv(heroId)
    if self.heroId ~= heroId then
        return
    end
    self:_SetSkillInfo()
end

function M:_OnClickMask()
    if self.selectSkill then
        self.selectSkill:SetIsOn(false)
        self.selectSkill = nil
    end

    UIContextMgr:GetInstance():Close("RoleSkillDetailUI")
end

function M:_OnClickLevelUp()
    if self.lockBtn then
        return
    end
    self:_OnClickMask()
    UIContextMgr:GetInstance():Show(UIDefine.UIRoleSkillUp, self.heroData)
end

function M:_SetSkillInfo()
    self.rare = self.heroData:GetHeroCfg().rare
    local info = {}
    -- 普攻技能
    local skillId = ConfigHelper.GetCfgPropByLua("role", self.heroId, "attack")
    local atk = ConfigHelper.GetCfgByLua("skill", skillId)

    if atk then
        info.name = atk.skillname
        info.icon = atk.icon
        info.desc = atk.skilldescribe
        info.nextDesc = 0
        info.type = 91
        info.mold = 493
        info.cost = 0
        local data = {}
        data.battleLevel = info
        data.isOpen = true
        data.type = 1 -- 普攻技能
        self._view.atkSkill:SetAtkInfo(data, self._refBaseSkillHandler)
    end

    -- 觉醒技能
    local haveAwake = self.rare >= EQuality.SR
    self._view.awakeSkill:SetActive(haveAwake)

    if haveAwake then
        info = self:_GetAwakeSkill()
        local awakeSkillState = self:_GetAwakeSkillState(3)
        local data = {}
        data.battleLevel = info
        data.isOpen = awakeSkillState
        data.type = 2 -- 觉醒技能
        self._view.awakeSkill:SetAtkInfo(data, self._refBaseSkillHandler)
    end

    -- 战中技能
    self.curBattleLv = self.heroData:GetSkillLevel()
    self:GetBaseBattleLevel()
    self:SetBattleSkill()
    self:SetOtakuSkill()
    local heroLevel = self.heroData:GetLevel()
    local adviceSkillLevel = 0
    self._view.labSkillLv:SetText("LV." .. self.curBattleLv)
    for _, data in ipairs(self.tabSystem318) do
        if data.level >= heroLevel then
            adviceSkillLevel = data.skillLevel
            break
        end
    end

    self._view.tfTips:SetActive(self.curBattleLv < adviceSkillLevel)

    self:_InitBtnState()
    if self.curBattleLv >= adviceSkillLevel then
        return
    else
        self._view.labTipsLv:SetText(tostring(adviceSkillLevel))
    end

end

function M:_InitBtnState()
    self.lockBtn = nil
    local tips
    -- 开放限制
    do
        local showCondition = ConfigHelper.GetCfgPropByLua("functionOpen", SkillOpenId[self.rare], "showCondition")
        for _, conditionId in pairs(showCondition) do
            local isOpen = GameHelper.CheckLockByOpenConditionId(conditionId, self.heroId)
            if not isOpen then
                self.lockBtn = true
                local openCondition = ConfigHelper.GetCfg("openCondition", conditionId)
                tips = ConfigHelper.GetLocalString(openCondition.tips)
                local heroName = ConfigHelper.GetHeroName(self.heroId)
                tips = sfmt(tips, heroName, openCondition.unlockParam2)
                break
            end
        end
    end
    if not tips then
        -- 升级限制
        local skillUpgrading = nil
        local skillUpgrading = JSkillUpgrading.GetSkillUpgradings(self.heroId, self.curBattleLv + 1)
        if IsNull(skillUpgrading) then -- 满级
            self.lockBtn = true
            tips = 5222
        else
            local conditionId = skillUpgrading.openCondition
            local isOpen = GameHelper.CheckLockByOpenConditionId(conditionId, self.heroId)
            if not isOpen then
                self.lockBtn = true
                local openCondition = ConfigHelper.GetCfg("openCondition", conditionId)
                tips = ConfigHelper.GetLocalString(openCondition.tips)
                local heroName = ConfigHelper.GetHeroName(self.heroId)
                tips = sfmt(tips, heroName, openCondition.unlockParam2)
            end
        end
    end
    self._view.stateBtn:SetState(self.lockBtn and 2 or 1)
    if tips then
        self._view.labLocked:SetText(tips)
    end
end

-- 获取英雄战中技能底子信息
function M:GetBaseBattleLevel()
    local skinId = self.heroData:GetSkinId()
    -- 英雄战中技能底子信息
    self.baseBattleLevel = JBattleLevel.GetHeroBattleLevel(skinId, 1, self.curBattleLv)
end

-- 获取基础技能数量(不包括三路技能)
function M:GetBaseBattleNum()
    if tArrayContains(self.baseBattleLevel.battleSkillLimit, 6) then
        return self.baseBattleLevel.battleSkillLimit.Length - 1
    else
        return self.baseBattleLevel.battleSkillLimit.Length
    end
end

-- 三路技能是否配置
function M:GetThreeSkillGrade()
    local threeSkillIndex = tArrayIndexof(self.baseBattleLevel.battleSkillLimit, 6)

    if not threeSkillIndex then
        return
    end
    return self.baseBattleLevel.nextGrade[threeSkillIndex]
end

--[[   battleSkill 
    3       1
    4       2

    6       5
        7
]]
-- 设置战中技能信息
function M:SetBattleSkill()
    local skillNum = self:GetBaseBattleNum()

    if skillNum == 2 then
        local info = self:GetSkillByGrade(self.baseBattleLevel.nextGrade[0])

        local data = {}
        data.battleLevel = info
        data.isOpen = true
        data.type = 3 -- 战中技能
        self._view.battleSkill1:SetBattleSkillInfo(data, self._refBattleLevelSkillHandler)

        info = self:GetSkillByGrade(info.nextGrade[0])
        data = {}
        data.battleLevel = info
        data.isOpen = true
        data.type = 3 -- 战中技能
        self._view.battleSkill2:SetBattleSkillInfo(data, self._refBattleLevelSkillHandler)

        info = self:GetSkillByGrade(self.baseBattleLevel.nextGrade[1])
        data = {}
        data.battleLevel = info
        data.isOpen = true
        data.type = 3 -- 战中技能
        self._view.battleSkill3:SetBattleSkillInfo(data, self._refBattleLevelSkillHandler)

        info = self:GetSkillByGrade(info.nextGrade[0])
        data = {}
        data.battleLevel = info
        data.isOpen = true
        data.type = 3 -- 战中技能
        self._view.battleSkill4:SetBattleSkillInfo(data, self._refBattleLevelSkillHandler)

        self._view.battleSkill5:SetBattleSkillInfo()
        self._view.battleSkill6:SetBattleSkillInfo()
        self._view.battleSkill7:SetBattleSkillInfo()
    end

    if skillNum == 1 then
        local nextInfo = self:GetSkillByGrade(self.baseBattleLevel.nextGrade[0])
        local nextGrade = nextInfo.nextGrade
        local nextInfo1 = nextGrade.Length >= 1 and self:GetSkillByGrade(nextGrade[0]) or nil
        local nextInfo2 = nextGrade.Length >= 2 and self:GetSkillByGrade(nextGrade[1]) or nil
        if not nextInfo2 then
            local data = {}
            data.battleLevel = nextInfo
            data.isOpen = true
            data.type = 3 -- 战中技能
            self._view.battleSkill1:SetBattleSkillInfo(data, self._refBattleLevelSkillHandler)

            if nextInfo1 then
                data = {}
                data.battleLevel = nextInfo1
                data.isOpen = true
                data.type = 3 -- 战中技能
                self._view.battleSkill2:SetBattleSkillInfo(data, self._refBattleLevelSkillHandler)
            else
                self._view.battleSkill2:SetBattleSkillInfo()
            end

            self._view.battleSkill3:SetBattleSkillInfo()
            self._view.battleSkill4:SetBattleSkillInfo()
            self._view.battleSkill5:SetBattleSkillInfo()
            self._view.battleSkill6:SetBattleSkillInfo()
            self._view.battleSkill7:SetBattleSkillInfo()
        else
            self._view.battleSkill1:SetBattleSkillInfo()
            self._view.battleSkill2:SetBattleSkillInfo()
            self._view.battleSkill3:SetBattleSkillInfo()
            self._view.battleSkill4:SetBattleSkillInfo()

            local data = {}
            data.battleLevel = nextInfo
            data.isOpen = true
            data.type = 3 -- 战中技能
            self._view.battleSkill5:SetBattleSkillInfo(data, self._refBattleLevelSkillHandler)
            data = {}
            data.battleLevel = nextInfo1
            data.isOpen = true
            data.type = 3 -- 战中技能
            self._view.battleSkill6:SetBattleSkillInfo(data, self._refBattleLevelSkillHandler)
            data = {}
            data.battleLevel = nextInfo2
            data.isOpen = true
            data.type = 3 -- 战中技能
            self._view.battleSkill7:SetBattleSkillInfo(data, self._refBattleLevelSkillHandler)
        end
    end
    do
        -- 三路技能信息
        local threeGrade = self:GetThreeSkillGrade()

        if threeGrade then
            local info = self:GetSkillByGrade(threeGrade)
            local awakeSkillState = self:_GetAwakeSkillState(4)
            local data = {}
            data.battleLevel = info
            data.isOpen = awakeSkillState
            data.type = 4 -- 三路技能
            self._view.battleSkill8:SetBattleSkillInfo(data, self._refBattleLevelSkillHandler, awakeSkillState)

            info = self:GetSkillByGrade(info.nextGrade[0])
            data = {}
            data.battleLevel = info
            data.isOpen = awakeSkillState
            data.type = 4 -- 三路技能
            self._view.battleSkill9:SetBattleSkillInfo(data, self._refBattleLevelSkillHandler, awakeSkillState)
        else
            self._view.battleSkill8:SetActive(false)
            self._view.battleSkill9:SetActive(false)
        end
    end
end

---设置边舱技能
function M:SetOtakuSkill()
    local breakLevel = self.heroData:GetBreakLevel()
    local heroBreaks = ConfigHelper.GetCfgsByLua('heroBreak', {hero=self.heroId, breakLevel=breakLevel})
    if heroBreaks.Length <= 0 then
        Logger.LogError('策划配置错误')
        return
    end
    local heroBreak = heroBreaks[0]
    local powerId1, powerId2
    local ifOpen1 = 0
    local ifOpen2 = 0
    local lockTips1, lockTips2
    local lv1 = "1"
    local lv2 = "1"
    local nextDesc1, nextDesc2
    if heroBreak.powerId2.Length == 0 then
    elseif heroBreak.powerId2.Length == 1 then
        powerId1 = heroBreak.powerId2[0]
        lv1 = heroBreak.nextPower[0] == 0 and "Max" or "1"
        if heroBreak.nextPower[0] > 0 then
            nextDesc1 = ConfigHelper.GetCfgPropByLua('power', heroBreak.nextPower[0], "powerDes")
        end
    elseif heroBreak.powerId2.Length == 2 then
        powerId1 = heroBreak.powerId2[0]
        powerId2 = heroBreak.powerId2[1]
        lv1 = heroBreak.nextPower[0] == 0 and "Max" or "1"
        lv2 = heroBreak.nextPower[1] == 0 and "Max" or "1"
        if heroBreak.nextPower[0] > 0 then
            nextDesc1 = ConfigHelper.GetCfgPropByLua('power', heroBreak.nextPower[0], "powerDes")
        end
        if heroBreak.nextPower[0] > 0 then
            nextDesc2 = ConfigHelper.GetCfgPropByLua('power', heroBreak.nextPower[1], "powerDes")
        end
    end
    if heroBreak.ifOpen.Length == 0 then
    elseif heroBreak.ifOpen.Length == 1 then
        ifOpen1 = heroBreak.ifOpen[0]
    elseif heroBreak.ifOpen.Length == 2 then
        ifOpen1 = heroBreak.ifOpen[0]
        ifOpen2 = heroBreak.ifOpen[1]
    end
    if ifOpen1 <= 0 then
        lockTips1 = heroBreak.language[0]
        lv1 = "1"
    end
    if ifOpen2 <= 0 then
        lockTips2 = heroBreak.language[1]
        lv2 = "1"
    end
    self:_SetOtakuSkillInfo(self._view.atkOtaku1, powerId1, ifOpen1, lockTips1, lv1, nextDesc1)
    self:_SetOtakuSkillInfo(self._view.atkOtaku2, powerId2, ifOpen2, lockTips2, lv2, nextDesc2)
end

-- 边舱技能
function M:_SetOtakuSkillInfo(RoleSkillItemCtrl, powerId, ifOpen, lockTips, lv, nextDesc)
    if not powerId then
        RoleSkillItemCtrl:SetOtakuSkill()
        return
    end
    local power = ConfigHelper.GetCfgByLua('power', powerId)

    local info = {}
    info.name = power.powerName
    info.icon = power.powerIcon
    info.desc = power.powerDes
    info.nextDesc = nextDesc
    info.type = 91
    info.mold = 493
    info.cost = 0
    local data = {}
    data.isOpen = ifOpen >= 1
    data.battleLevel = info
    data.type = 5 -- 边舱技能
    if not data.isOpen then
        data.lockTips = lockTips
    end
    RoleSkillItemCtrl:SetOtakuSkill(data, self._refBaseSkillHandler)
end

-- 获取觉醒技能是否开启
function M:_GetAwakeSkillState(awakeEffectType)
    local awakeLevel = self.heroData:GetAwakeLevel()
    local heroAwakes = ConfigHelper.GetCfgsByLua('heroAwake', {heroId=self.heroId})

    for _, heroAwake in pairs(heroAwakes) do
        if tIndexof(heroAwake.effectType, awakeEffectType) then
            return heroAwake.level <= awakeLevel
        end
    end
    return false
end

-- 战中技能
function M:_RefreshBattleLevelSkill(data, toggle, skillItem)
    self.selectSkill = toggle
    self.skillItem = skillItem
    if not data then
        UIContextMgr:GetInstance():Close('RoleSkillDetailUI')
        return
    end

    UIContextMgr:GetInstance():Show('RoleSkillDetailUI', self.heroData, data, self.selectSkill)
end

function M:_GetSkillByGrade(data, grade)
    for i = 0, data.Count - 1 do
        if data[i].grade == grade then
            return data[i]
        end
    end
end

function M:GetSkillByGrade(grade)
    if not grade then
        return
    end
    local skinId = self.heroData:GetSkinId()
    local battleLevel = JBattleLevel.GetHeroBattleLevel(skinId, grade, self.curBattleLv)
    if IsNull(battleLevel) then
        Logger.LogError("策划配置错误,heroId:" .. self.heroId .. "  grade:" .. grade .. "     skillLevel:" .. self.curBattleLv)
        return
    end

    return battleLevel
end

-- 普攻觉醒技能
function M:_UpdateInfoPanel(data, toggle, skillItem)
    self.selectSkill = toggle
    self.skillItem = skillItem
    if not data then
        UIContextMgr:GetInstance():Close("RoleSkillDetailUI")
        return
    end

    UIContextMgr:GetInstance():Show("RoleSkillDetailUI", self.heroData, data, self.selectSkill)
end

-- 获取英雄觉醒技能表
function M:_GetAwakeCfg()
    local heroAwakes = ConfigHelper.GetCfgsByLua("heroAwake", {heroId=self.heroId})

    for _, heroAwake in pairs(heroAwakes) do
        if tIndexof(heroAwake.effectType, 3) then
            return heroAwake
        end
    end

    Logger.LogError("获取英雄觉醒技能表错误")
end

-- 获取觉醒技能信息
function M:_GetAwakeSkill()
    if self.rare < EQuality.SR then
        return nil
    end

    local heroAwake = self:_GetAwakeCfg()
    local info = {}
    info.name = heroAwake.skillName
    info.icon = heroAwake.icon
    info.type = 446
    info.cost = 0
    info.nextDesc = 0
    info.desc = heroAwake.desc
    info.mold = 1285
    return info
end

function M:OnClose()
    M.super.OnClose(self)
end

function M:OnDispose()
    self:_RemoveListener(UIMessageNames.ROLE_DEVELOP_REFRESH_DATA, self._refreshDataHandler)
    self:_RemoveListener(UIMessageNames.ROLE_SKILLUP, self._tempOnRefreshSkillLv)
    M.super.OnDispose(self)
end

return RoleSkillUICtrl
