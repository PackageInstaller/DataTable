local M = BaseClass("BridgeCmdSkillCtrl", BaseUICtrl)

function M:Init()
    local skillUpBinder = Bind(self, self.OnSkillUpgrade)
    local eventName = UIMessageNames.BRIDGE_SKILL_UPGRADE
    local itemView = require("UI.View.Common.ItemPfbView")
    local itemCtrl = require("UI.Ctrl.Common.CommonItemCtrl")
    local skillCtrl = require("UI.Ctrl.Bridge.BridgeCmdSkillItemCtrl")
    local skillView = require("UI.View.Bridge.BridgeCmdSkillItemView")

    self.m_data = nil
    self.m_tipsId = 0
    self.m_callCount = 0 -- 调用次数
    self.m_skillDatas = {}
    self.m_itemLoop = self._view.itemList -- 消耗列表
    self.m_skillLoop = self._view.skillList -- 技能列表
    self.m_itemLoop:Init(itemCtrl, itemView)
    self.m_skillLoop:Init(skillCtrl, skillView)
    self.m_maxLevel = GameHelper.GetParamter(182)
    self._view.heroBtn:onClick(Bind(self, self.OnClickAddHero))
    self._view.upLevelBtn:onClick(Bind(self, self.OnClickUpgrade))
    self.m_skillUpgrade = EventMgr:AddListener(eventName, skillUpBinder)
    self._view.currency:SetChangeState(true, Bind(self, self.OnItemChanged))
    self.m_itemLoop:SetCreateItemCallback(Bind(self, self.OnCreateCostItem))
    self.m_skillLoop:SetCreateItemCallback(Bind(self, self.OnCreateSkillItem))
end

function M:OnEnter()
    self._view.txt_upTips:SetColorByColor(Color.red)

    local lvCfg = ConfigHelper.GetCfg("homepageLevel", IPlayerData.level) or {}
    self._view.txt_storages:SetText(tostring(lvCfg.playerAttrValue[0]))

    self._view.skillNode:SetActive(false)
    self.m_skillDatas = CmderSkillMgr:GetAllCmderSkills()
    for _, data in ipairs(self.m_skillDatas) do data.IsSelect = false end
    self.m_skillLoop:SetDataList(self.m_skillDatas)
end

--点击设置退出键【关闭带顶栏的Normal窗口】
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

function M:OnClose()
    EventMgr:RemoveListener(UIMessageNames.BRIDGE_SKILL_UPGRADE, self.m_skillUpgrade)
    self.m_skillUpgrade = nil
    self.m_skillDatas = nil
    self.m_skillLoop = nil
    self.m_itemLoop = nil
    self.m_data = nil
end

-- 点击技能Item回调
function M:OnCreateSkillItem(ctrl)
    ctrl:ClickToggleCallback(Bind(self, self._SetSkillInfo))
end

-- 点击消耗Item回调
function M:OnCreateCostItem(ctrl)
    ctrl:OnNumChanged(Bind(self, self.OnItemChanged))
end

function M:_SetSkillInfo(data)
    self.m_data = data
    local cfg = self.m_data.Config
    local heroId = self.m_data.HeroId
    local cmdID, oriLv = cfg.cmdID, cfg.level -- 原始等级
    local addLv = CmderSkillMgr:GetAddValue(cmdID, heroId)
    local curSkill = CmderSkillMgr:GetSkillConfig(cmdID, oriLv + addLv)
    self._view.skillNode:SetActive(true)
    self._view.skillIcon:SetPic(curSkill.icon)
    self._view.leftName:SetText(curSkill.name)
    self._view.skillName:SetText(curSkill.name)
    self._view.leftDesc:SetText(curSkill.cmddesc)
    self._view.leftLevel:SetText("Lv." .. curSkill.level)

    if heroId > 0 then -- 有绑定战员
        if addLv > 0 then
            local str = "%d<color=#5183FF>+%d</color>"
            self._view.skillLevel:SetText(string.format(str, oriLv, addLv))
        else
            self._view.skillLevel:SetText(tostring(curSkill.level))
        end

        self._view.heroMask:SetActive(true)
        self._view.heroName:SetAvatarName(heroId, RoleType.ERT_Hero)
        self._view.heroIcon:SetAvatarIcon(heroId, RoleType.ERT_Hero)
    else -- 未绑定战员
        local str = ConfigHelper.GetLocalString(5170)
        local text = string.format("<color=#A4A4A4>%s</color>", str)
        self._view.heroName:SetText(text)
        self._view.heroMask:SetActive(false)
        self._view.skillLevel:SetText(tostring(oriLv))
    end

    local nextCfg = CmderSkillMgr:GetSkillConfig(cmdID, oriLv + addLv + 1)
    if nextCfg then
        self._view.rightName:SetText(nextCfg.name)
        self._view.rightDesc:SetText(nextCfg.cmddesc)
        self._view.rightLevel:SetText("Lv." .. nextCfg.level)
    end

    local items, nums = cfg.costItem, cfg.costNum
    self:_ShowItemList(items, nums)

    local isEnough = GameHelper.CheckItemsByLua(items, nums)
    if self.m_callCount ~= 0 and isEnough and self.m_data.IsUnlock then
        GameHelper.SetPlayerPrefsInt("CmdSkill" .. cmdID, oriLv)
    end
    self.m_callCount = 1
    self:_UpdateState(isEnough)
end

-- 显示消耗列表
function M:_ShowItemList(items, nums)
    items = items or {}
    nums = nums or {}
    local list, nType = {}, ItemNumberType.BALANCE
    local idx = self._view.currency:SetItemById(items[1], nums[1], 1)
    for i = idx, #items, 1 do
        local id, num = items[i], nums[i]
        if (id > 0) and (num > 0) then
            table.insert(list, { itemId = id, numType = nType, itemNum = num })
        end
    end

    self.m_itemLoop:SetDataList(list)
end

-- 添加队员按钮
function M:OnClickAddHero(go)
    if not self.m_data then return end

    UIContextMgr:GetInstance():Show("BridgeChooseHero", self.m_data)
end

-- 升级按钮
function M:OnClickUpgrade(go)
    if self.m_tipsId > 0 then
        GameHelper.TipsById(self.m_tipsId)
    else
        CmderSkillMgr:RqCmderSkillUpgrade({
            SkillId = self.m_data.Config.cmdID
        })
    end
end

-- 更新技能面板
function M:OnSkillUpgrade(data)
    if not data then return end

    local cmdID = data.Config.cmdID
    for _, skill in ipairs(self.m_skillDatas) do
        if skill.Config.cmdID == cmdID then
            skill.IsUnlock = data.IsUnlock
            skill.HeroId = data.HeroId
            skill.Config = data.Config
            break
        end
    end

    self.m_callCount = 0
    self.m_skillLoop:UpdateList()
    if self.m_data and (cmdID == self.m_data.Config.cmdID) then
        self:_SetSkillInfo(data)
    end
end

function M:OnItemChanged()
    local items = self.m_data.Config.costItem
    local nums = self.m_data.Config.costNum
    self:_UpdateState(GameHelper.CheckItemsByLua(items, nums))
end

-- 道具数量变化刷新
function M:_UpdateState(isEnough)
    local cfg = self.m_data.Config
    local unlockId = cfg.unlock
    local condition = ConfigHelper.GetCfgByLua("openCondition", unlockId) or {}
    if cfg.level >= self.m_maxLevel then
        self.m_tipsId = 4117
        self._view.node_right:SetActive(false)
        self._view.itemPanel:SetActive(false)
        self._view.currency:SetActive(false)
        self._view.upLevelText:SetText(5222)
        self._view.upLevelBtn:SetState(2)
    else
        self._view.node_right:SetActive(true)
        self._view.itemPanel:SetActive(true)
        self._view.currency:SetActive(true)
        self._view.upLevelText:SetText(4116)

        if GameHelper.CheckLockByOpenConditionId(unlockId) then
            -- DuSir:按原始等级显示消耗
            self.m_tipsId = isEnough and 0 or 4118
            self._view.upLevelBtn:SetState(isEnough and 1 or 2)
        else
            self.m_tipsId = condition.tips
            self._view.upLevelBtn:SetState(2)
        end
    end

    self._view.txt_upTips:SetText(condition.tips)
    self._view.txt_upTips:SetActive(self.m_tipsId == condition.tips)
end

return M
