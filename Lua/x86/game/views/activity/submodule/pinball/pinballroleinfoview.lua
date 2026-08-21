local var_0_0 = class("PinballRoleInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_PinballUI/BaichaoUI_3_9_PinballHeroLvlUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

local var_0_1 = class("PinballRoleInfoView.RoleItem", BaseView)

function var_0_1.Ctor(arg_3_0, arg_3_1)
	arg_3_0.gameObject_ = arg_3_1
	arg_3_0.transform_ = arg_3_1.transform

	arg_3_0:BindCfgUI()

	arg_3_0.selectController = arg_3_0.controllers_:GetController("select")
	arg_3_0.lockController = arg_3_0.controllers_:GetController("lock")

	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.onClick then
			arg_3_0.onClick(arg_3_0.id)
		end

		if not arg_3_0.muteRedPoint then
			local var_4_0 = PinballTools.UpgradeRedPoint(arg_3_0.id)

			manager.redPoint:setTip(var_4_0, 0)
			manager.redPoint:SetRedPointIndependent(arg_3_0.transform_, false)
		end
	end)
end

function var_0_1.SetData(arg_5_0, arg_5_1)
	arg_5_0.id = arg_5_1
	arg_5_0.icon_.spriteSync = PinballTools.GetRoleIconPath(arg_5_1)

	if arg_5_0.muteRedPoint then
		manager.redPoint:SetRedPointIndependent(arg_5_0.transform_, false)
	else
		local var_5_0 = PinballTools.UpgradeRedPoint(arg_5_1)

		manager.redPoint:SetRedPointIndependent(arg_5_0.transform_, manager.redPoint:getTipBoolean(var_5_0))
	end

	if arg_5_0.lockController then
		arg_5_0.lockController:SetSelectedState(not PinballTools.CheckRoleUnlocked(arg_5_1) and "true" or "false")
	end
end

function var_0_1.SetSelected(arg_6_0, arg_6_1)
	if arg_6_0.selectController then
		arg_6_0.selectController:SetSelectedState(arg_6_1 and "true" or "false")
	end
end

function var_0_1.SetMuteRedPoint(arg_7_0, arg_7_1)
	arg_7_0.muteRedPoint = arg_7_1
end

function var_0_1.Dispose(arg_8_0)
	var_0_1.super.Dispose(arg_8_0)
	arg_8_0:RemoveAllListeners()
end

var_0_0.RoleItem = var_0_1

local var_0_2 = 3

function var_0_0.Init(arg_9_0)
	arg_9_0:BindCfgUI()

	arg_9_0.props = {}

	for iter_9_0 = 1, var_0_2 do
		local var_9_0 = PinballCharaPropItem.New(arg_9_0[string.format("prop%d_", iter_9_0)])

		table.insert(arg_9_0.props, var_9_0)
	end

	arg_9_0.skills = {}
	arg_9_0.lockController = arg_9_0.controllers_:GetController("lock")
	arg_9_0.showCostController = arg_9_0.controllers_:GetController("showCost")
	arg_9_0.coinEnoughController = arg_9_0.controllers_:GetController("coinEnough")

	arg_9_0:AddBtnListenerScale(arg_9_0.upgradeBtn_, nil, function()
		arg_9_0:OnClickUpgrade()
	end)
end

function var_0_0.Dispose(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.props) do
		iter_11_1:Dispose()
	end

	arg_11_0.props = nil

	for iter_11_2, iter_11_3 in pairs(arg_11_0.skills) do
		iter_11_3:Dispose()
	end

	arg_11_0.skills = nil

	var_0_0.super.Dispose(arg_11_0)
end

local var_0_3 = {
	2500
}

function var_0_0.RegisterEvents(arg_12_0)
	arg_12_0:RegistEventListener("PINBALL_ROLE_LEVEL_CHANGE", function()
		arg_12_0:Refresh()
	end)
	arg_12_0:RegistEventListener(ACTIVITY_UPDATE, function(arg_14_0)
		for iter_14_0, iter_14_1 in ipairs(PinballData:GetStageCategoryActivityList()) do
			if iter_14_1 == arg_14_0 then
				arg_12_0:Refresh()

				return
			end
		end
	end)
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0:Refresh()
	arg_15_0:RegisterEvents()
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:RemoveAllEventListener()
end

function var_0_0.OnTop(arg_17_0)
	local var_17_0 = PinballTools.ActivityCoin()

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_17_0
	})
	manager.windowBar:SetBarCanClick(var_17_0, true)
end

function var_0_0.OnBehind(arg_18_0)
	manager.windowBar:HideBar()
end

function var_0_0.Refresh(arg_19_0)
	arg_19_0:SetData(arg_19_0.params_.heroID)
end

function var_0_0.SetData(arg_20_0, arg_20_1)
	local var_20_0 = PinballPlayerCfg[arg_20_1]

	if PinballTools.CheckRoleUnlocked(arg_20_1) then
		arg_20_0.lockController:SetSelectedState("false")
	else
		arg_20_0.lockController:SetSelectedState("true")
	end

	local var_20_1 = var_20_0.hero_id

	arg_20_0.raceIcon_.sprite = HeroTools.GetHeroRaceIcon(var_20_1)
	arg_20_0.headIcon_.spriteSync = PinballTools.GetRoleIconPath(arg_20_1)
	arg_20_0.img_.spriteSync = PinballTools.GetRoleFullImgPath(arg_20_1)
	arg_20_0.shadow_.spriteSync = PinballTools.GetRoleFullImgPath(arg_20_1)
	arg_20_0.name_.text = var_20_0.desc

	local var_20_2 = PinballData:GetRoleLevel(arg_20_1)
	local var_20_3

	if var_20_2 then
		local var_20_4 = nullable(var_20_0, "upgrade_cost_list", var_20_2)

		if var_20_4 then
			arg_20_0.costIcon_.sprite = ItemTools.getItemLittleSprite(var_20_4[1])

			local var_20_5 = ItemTools.getItemNum(var_20_4[1]) >= var_20_4[2] and "true" or "false"

			arg_20_0.coinEnoughController:SetSelectedState(var_20_5)

			arg_20_0.cost_.text = var_20_4[2]

			arg_20_0.showCostController:SetSelectedState("true")
		else
			arg_20_0.showCostController:SetSelectedState("false")
		end

		arg_20_0.level_.text = GetTipsF("PINBALL_HERO_LEVEL", var_20_2)
	else
		arg_20_0.showCostController:SetSelectedState("false")

		arg_20_0.level_.text = ""
	end

	for iter_20_0 = 1, var_0_2 do
		local var_20_6

		arg_20_0.props[iter_20_0]:SetData(var_20_6, PinballTools.CalcRoleProp(arg_20_1, iter_20_0), var_0_3[iter_20_0], PinballTools.GetRoleNextLevelGrowthProp(arg_20_1, iter_20_0))
	end

	arg_20_0:SetSkillList(var_20_0.skill_list)
end

local function var_0_4(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_2.childCount
	local var_21_1 = #arg_21_0

	for iter_21_0 = 1, math.max(arg_21_1, var_21_1, var_21_0) do
		local var_21_2
		local var_21_3

		if var_21_0 < iter_21_0 then
			var_21_2 = GameObject.Instantiate(arg_21_3, arg_21_2)
		end

		if var_21_1 < iter_21_0 then
			if isNil(var_21_2) then
				var_21_2 = arg_21_2:GetChild(iter_21_0 - 1).gameObject
			end

			var_21_3 = PinballCharaSkillItem.New(var_21_2)

			table.insert(arg_21_0, var_21_3)
		end

		var_21_3 = var_21_3 or arg_21_0[iter_21_0]

		var_21_3:SetVisible(iter_21_0 <= arg_21_1)
	end
end

function var_0_0.SetSkillList(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1 and #arg_22_1 or 0

	var_0_4(arg_22_0.skills, var_22_0, arg_22_0.skillsRoot_, arg_22_0.skillPrefab_)

	for iter_22_0 = 1, var_22_0 do
		arg_22_0.skills[iter_22_0]:SetData(arg_22_1[iter_22_0])
	end
end

local function var_0_5(arg_23_0, arg_23_1)
	ShowTips(arg_23_1)
end

function var_0_0.OnClickRoleItem(arg_24_0, arg_24_1)
	local var_24_0, var_24_1 = PinballTools.CheckRoleUnlocked(arg_24_1)

	if var_24_0 then
		arg_24_0:SetData(arg_24_1)
	else
		var_0_5(arg_24_1, var_24_1)
	end
end

function var_0_0.OnClickUpgrade(arg_25_0)
	local var_25_0 = arg_25_0.params_.heroID
	local var_25_1, var_25_2 = PinballTools.CheckRoleUnlocked(var_25_0)

	if var_25_1 then
		local var_25_3 = PinballData:GetRoleLevel(var_25_0)
		local var_25_4 = nullable(PinballPlayerCfg, var_25_0, "max_grade") or 0

		if var_25_3 and var_25_3 < var_25_4 then
			if PinballTools.CheckRoleCanUpgrade(var_25_0) then
				PinballAction.UpgradeRoleLevel(PinballData.activityID, var_25_0, 1)
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
			end
		else
			ShowTips("PINBALL_ROLE_REACH_MAX_LEVEL")
		end
	else
		var_0_5(var_25_0, var_25_2)
	end
end

return var_0_0
