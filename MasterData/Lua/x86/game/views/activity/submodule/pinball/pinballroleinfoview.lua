local PinballRoleInfoView = class("PinballRoleInfoView", ReduxView)

function PinballRoleInfoView:UIName()
	return "Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_PinballUI/BaichaoUI_3_9_PinballHeroLvlUI"
end

function PinballRoleInfoView:UIParent()
	return manager.ui.uiMain.transform
end

local var_0_1 = class("PinballRoleInfoView.RoleItem", BaseView)

function var_0_1:Ctor(arg_3_1)
	self.gameObject_ = arg_3_1
	self.transform_ = arg_3_1.transform

	self:BindCfgUI()

	self.selectController = self.controllers_:GetController("select")
	self.lockController = self.controllers_:GetController("lock")

	self:AddBtnListener(self.btn_, nil, function()
		if self.onClick then
			self.onClick(self.id)
		end

		if not self.muteRedPoint then
			manager.redPoint:setTip(PinballTools.UpgradeRedPoint(self.id), 0)
			manager.redPoint:SetRedPointIndependent(self.transform_, false)
		end
	end)
end

function var_0_1:SetData(arg_5_1)
	self.id = arg_5_1
	self.icon_.spriteSync = PinballTools.GetRoleIconPath(arg_5_1)

	if self.muteRedPoint then
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
	else
		manager.redPoint:SetRedPointIndependent(self.transform_, manager.redPoint:getTipBoolean((PinballTools.UpgradeRedPoint(arg_5_1))))
	end

	if self.lockController then
		self.lockController:SetSelectedState(not PinballTools.CheckRoleUnlocked(arg_5_1) and "true" or "false")
	end
end

function var_0_1:SetSelected(arg_6_1)
	if self.selectController then
		self.selectController:SetSelectedState(arg_6_1 and "true" or "false")
	end
end

function var_0_1:SetMuteRedPoint(arg_7_1)
	self.muteRedPoint = arg_7_1
end

function var_0_1:Dispose()
	var_0_1.super.Dispose(self)
	self:RemoveAllListeners()
end

PinballRoleInfoView.RoleItem = var_0_1

local var_0_2 = 3

function PinballRoleInfoView:Init()
	self:BindCfgUI()

	self.props = {}

	for iter_9_0 = 1, var_0_2 do
		table.insert(self.props, (PinballCharaPropItem.New(self[string.format("prop%d_", iter_9_0)])))
	end

	self.skills = {}
	self.lockController = self.controllers_:GetController("lock")
	self.showCostController = self.controllers_:GetController("showCost")
	self.coinEnoughController = self.controllers_:GetController("coinEnough")

	self:AddBtnListenerScale(self.upgradeBtn_, nil, function()
		self:OnClickUpgrade()
	end)
end

function PinballRoleInfoView:Dispose()
	for iter_11_0, iter_11_1 in pairs(self.props) do
		iter_11_1:Dispose()
	end

	self.props = nil

	for iter_11_2, iter_11_3 in pairs(self.skills) do
		iter_11_3:Dispose()
	end

	self.skills = nil

	PinballRoleInfoView.super.Dispose(self)
end

local var_0_3 = {
	2500
}

function PinballRoleInfoView:RegisterEvents()
	self:RegistEventListener("PINBALL_ROLE_LEVEL_CHANGE", function()
		self:Refresh()
	end)
	self:RegistEventListener(ACTIVITY_UPDATE, function(arg_14_0)
		for iter_14_0, iter_14_1 in ipairs(PinballData:GetStageCategoryActivityList()) do
			if iter_14_1 == arg_14_0 then
				self:Refresh()

				return
			end
		end
	end)
end

function PinballRoleInfoView:OnEnter()
	self:Refresh()
	self:RegisterEvents()
end

function PinballRoleInfoView:OnExit()
	self:RemoveAllEventListener()
end

function PinballRoleInfoView:OnTop()
	local var_17_0 = PinballTools.ActivityCoin()

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_17_0
	})
	manager.windowBar:SetBarCanClick(var_17_0, true)
end

function PinballRoleInfoView:OnBehind()
	manager.windowBar:HideBar()
end

function PinballRoleInfoView:Refresh()
	self:SetData(self.params_.heroID)
end

function PinballRoleInfoView:SetData(arg_20_1)
	local var_20_0 = PinballPlayerCfg[arg_20_1]

	if PinballTools.CheckRoleUnlocked(arg_20_1) then
		self.lockController:SetSelectedState("false")
	else
		self.lockController:SetSelectedState("true")
	end

	self.raceIcon_.sprite = HeroTools.GetHeroRaceIcon(var_20_0.hero_id)
	self.headIcon_.spriteSync = PinballTools.GetRoleIconPath(arg_20_1)
	self.img_.spriteSync = PinballTools.GetRoleFullImgPath(arg_20_1)
	self.shadow_.spriteSync = PinballTools.GetRoleFullImgPath(arg_20_1)
	self.name_.text = var_20_0.desc

	local var_20_1 = PinballData:GetRoleLevel(arg_20_1)

	if var_20_1 then
		local var_20_3 = nullable(var_20_0, "upgrade_cost_list", var_20_1)

		if var_20_3 then
			self.costIcon_.sprite = ItemTools.getItemLittleSprite(var_20_3[1])

			self.coinEnoughController:SetSelectedState(ItemTools.getItemNum(var_20_3[1]) >= var_20_3[2] and "true" or "false")

			self.cost_.text = var_20_3[2]

			self.showCostController:SetSelectedState("true")
		else
			self.showCostController:SetSelectedState("false")
		end

		self.level_.text = GetTipsF("PINBALL_HERO_LEVEL", var_20_1)
	else
		self.showCostController:SetSelectedState("false")

		self.level_.text = ""
	end

	for iter_20_0 = 1, var_0_2 do
		self.props[iter_20_0]:SetData(nil, PinballTools.CalcRoleProp(arg_20_1, iter_20_0), var_0_3[iter_20_0], PinballTools.GetRoleNextLevelGrowthProp(arg_20_1, iter_20_0))
	end

	self:SetSkillList(var_20_0.skill_list)
end

local function var_0_4(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	for iter_21_0 = 1, math.max(arg_21_1, #arg_21_0, arg_21_2.childCount) do
		local var_21_0
		local var_21_1

		if arg_21_2.childCount < iter_21_0 then
			var_21_0 = GameObject.Instantiate(arg_21_3, arg_21_2)
		end

		if #arg_21_0 < iter_21_0 then
			if isNil(var_21_0) then
				var_21_0 = arg_21_2:GetChild(iter_21_0 - 1).gameObject
			end

			var_21_1 = PinballCharaSkillItem.New(var_21_0)

			table.insert(arg_21_0, var_21_1)
		end

		var_21_1 = var_21_1 or arg_21_0[iter_21_0]

		var_21_1:SetVisible(iter_21_0 <= arg_21_1)
	end
end

function PinballRoleInfoView:SetSkillList(arg_22_1)
	local var_22_0

	if arg_22_1 then
		var_22_0 = #arg_22_1 or 0
	end

	var_0_4(self.skills, var_22_0, self.skillsRoot_, self.skillPrefab_)

	for iter_22_0 = 1, var_22_0 do
		self.skills[iter_22_0]:SetData(arg_22_1[iter_22_0])
	end
end

local function var_0_5(arg_23_0, arg_23_1)
	ShowTips(arg_23_1)
end

function PinballRoleInfoView:OnClickRoleItem(arg_24_1)
	local var_24_0, var_24_1 = PinballTools.CheckRoleUnlocked(arg_24_1)

	if var_24_0 then
		self:SetData(arg_24_1)
	else
		var_0_5(arg_24_1, var_24_1)
	end
end

function PinballRoleInfoView:OnClickUpgrade()
	local var_25_0, var_25_1 = PinballTools.CheckRoleUnlocked(self.params_.heroID)

	if var_25_0 then
		local var_25_2 = PinballData:GetRoleLevel(self.params_.heroID)

		if var_25_2 and var_25_2 < (nullable(PinballPlayerCfg, self.params_.heroID, "max_grade") or 0) then
			if PinballTools.CheckRoleCanUpgrade(self.params_.heroID) then
				PinballAction.UpgradeRoleLevel(PinballData.activityID, self.params_.heroID, 1)
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
			end
		else
			ShowTips("PINBALL_ROLE_REACH_MAX_LEVEL")
		end
	else
		var_0_5(self.params_.heroID, var_25_1)
	end
end

return PinballRoleInfoView
