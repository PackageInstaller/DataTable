local var_0_0 = class("ActivityReforgeSkillView", ReduxView)
local var_0_1 = "D46068"
local var_0_2 = {
	USE = 2,
	ILLUSTRATED = 1
}
local var_0_3 = {
	PASSIVE = 2,
	INITIATIVE = 1
}

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeSkillUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.initiativeSkillList_ = {
		{},
		{},
		{},
		{}
	}
	arg_4_0.passiveSkillList_ = {}

	for iter_4_0, iter_4_1 in pairs(ActivityReforgeSkillCfg.all) do
		local var_4_0 = ActivityReforgeSkillCfg[iter_4_1]

		if var_4_0.type == 1 then
			table.insert(arg_4_0.initiativeSkillList_[var_4_0.slot], iter_4_1)
		else
			table.insert(arg_4_0.passiveSkillList_, iter_4_1)
		end
	end

	arg_4_0.viewStatusController_ = arg_4_0.controllerEx_:GetController("viewStatus")
	arg_4_0.curSkillStatusController_ = arg_4_0.controllerEx_:GetController("curSkillStatus")
	arg_4_0.skillStatusController_ = arg_4_0.controllerEx_:GetController("skillStatus")
	arg_4_0.initiativeList_ = {}

	for iter_4_2 = 1, 4 do
		arg_4_0.initiativeList_[iter_4_2] = ActivityReforgeInitiativeSkillItem.New(arg_4_0["initiativeSkillListGo" .. iter_4_2 .. "_"])
	end

	arg_4_0.passiveList_ = {}

	for iter_4_3 = 1, 1 do
		arg_4_0.passiveList_[iter_4_3] = ActivityReforgePassiveSkillItem.New(arg_4_0["passiveSkillListGo" .. iter_4_3 .. "_"])
	end

	arg_4_0.itemSelectHandler_ = handler(arg_4_0, arg_4_0.OnItemSelect)
end

function var_0_0.OnItemSelect(arg_5_0, arg_5_1)
	arg_5_0.skillID_ = arg_5_1

	if ActivityReforgeSkillCfg[arg_5_0.skillID_].type == 1 then
		arg_5_0.curViewStatus_ = var_0_3.INITIATIVE
	else
		arg_5_0.curViewStatus_ = var_0_3.PASSIVE
	end

	arg_5_0:RefreshUI()
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.toggleBtn_, nil, function()
		if arg_6_0.curViewStatus_ == var_0_3.INITIATIVE then
			arg_6_0.curViewStatus_ = var_0_3.PASSIVE
			arg_6_0.skillID_ = arg_6_0.passiveSkillList_[1]
		elseif arg_6_0.curViewStatus_ == var_0_3.PASSIVE then
			arg_6_0.curViewStatus_ = var_0_3.INITIATIVE
			arg_6_0.skillID_ = arg_6_0.initiativeSkillList_[1][1]
		end

		arg_6_0:RefreshUI()
	end)
	arg_6_0:AddBtnListener(arg_6_0.buyBtn_, nil, function()
		ActivityReforgeAction.BuySkill(arg_6_0.chapterActivityID_, arg_6_0.levelID_, arg_6_0.skillID_, function()
			ActivityReforgeAction.SelectSkill(arg_6_0.chapterActivityID_, arg_6_0.levelID_, arg_6_0.skillID_, function()
				ShowTips("ACTIVITY_REFORGE_BUY_SKILL")
			end)
		end)
	end)
	arg_6_0:AddBtnListener(arg_6_0.useBtn_, nil, function()
		ActivityReforgeAction.SelectSkill(arg_6_0.chapterActivityID_, arg_6_0.levelID_, arg_6_0.skillID_, function()
			ShowTips("ACTIVITY_REFORGE_USE_SKILL")
		end)
	end)
	arg_6_0:AddBtnListener(arg_6_0.unUsebtn_, nil, function()
		ActivityReforgeAction.UnSelectSkill(arg_6_0.chapterActivityID_, arg_6_0.levelID_, arg_6_0.skillID_)
	end)
	arg_6_0:AddBtnListener(arg_6_0.panelUseBtn_, nil, function()
		ActivityReforgeAction.SelectSkill(arg_6_0.chapterActivityID_, arg_6_0.levelID_, arg_6_0.skillID_)
	end)
	arg_6_0:AddBtnListener(arg_6_0.panelUnUseBtn_, nil, function()
		ActivityReforgeAction.UnSelectSkill(arg_6_0.chapterActivityID_, arg_6_0.levelID_, arg_6_0.skillID_)
	end)
	arg_6_0:AddBtnListener(arg_6_0.panelSellBtn_, nil, function()
		ActivityReforgeAction.SellSkill(arg_6_0.chapterActivityID_, arg_6_0.levelID_, arg_6_0.skillID_)
	end)
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0.activityID_ = arg_17_0.params_.activityID
	arg_17_0.chapterActivityID_ = arg_17_0.params_.chapterActivityID
	arg_17_0.levelID_ = arg_17_0.params_.levelID
	arg_17_0.viewType_ = arg_17_0.params_.viewType

	if arg_17_0.viewType_ == var_0_2.ILLUSTRATED then
		arg_17_0.curViewStatus_ = var_0_3.INITIATIVE
		arg_17_0.skillID_ = arg_17_0.initiativeSkillList_[1][1]
	else
		arg_17_0:InitEnterSelectSkill()
	end

	arg_17_0:RefreshUI()
end

function var_0_0.OnTop(arg_18_0)
	if arg_18_0.viewType_ == var_0_2.USE then
		local var_18_0 = CurrencyConst.CURRENCY_TYPE_ACTIVITY_REFORGE

		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			var_18_0
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function var_0_0.OnExit(arg_19_0)
	for iter_19_0 = 1, 4 do
		arg_19_0.initiativeList_[iter_19_0]:OnExit()
	end

	for iter_19_1 = 1, 1 do
		arg_19_0.passiveList_[iter_19_1]:OnExit()
	end

	manager.windowBar:HideBar()
end

function var_0_0.InitEnterSelectSkill(arg_20_0)
	if arg_20_0.params_.skillID ~= nil and arg_20_0.params_.skillID ~= 0 then
		arg_20_0.skillID_ = arg_20_0.params_.skillID

		if ActivityReforgeSkillCfg[arg_20_0.skillID_].type == 1 then
			arg_20_0.curViewStatus_ = var_0_3.INITIATIVE
		else
			arg_20_0.curViewStatus_ = var_0_3.PASSIVE
		end
	elseif arg_20_0.params_.slot_ and arg_20_0.params_.viewStatus then
		if arg_20_0.params_.viewStatus == var_0_3.INITIATIVE then
			if arg_20_0.params_.slot_ < 1 or arg_20_0.params_.slot_ > 4 then
				arg_20_0.params_.slot_ = 1
			end

			arg_20_0.skillID_ = arg_20_0.initiativeSkillList_[arg_20_0.params_.slot_][1]
		else
			arg_20_0.skillID_ = arg_20_0.passiveSkillList_[1]
		end
	elseif arg_20_0.params_.viewStatus then
		arg_20_0.curViewStatus_ = arg_20_0.params_.viewStatus

		if arg_20_0.params_.viewStatus == var_0_3.INITIATIVE then
			arg_20_0.skillID_ = arg_20_0.initiativeSkillList_[1][1]
		else
			arg_20_0.skillID_ = arg_20_0.passiveSkillList_[1]
		end
	end
end

function var_0_0.RefreshUI(arg_21_0)
	if arg_21_0.curViewStatus_ == var_0_3.INITIATIVE then
		arg_21_0.viewStatusController_:SetSelectedState("initiative")

		for iter_21_0 = 1, 4 do
			arg_21_0.initiativeList_[iter_21_0]:SetData(arg_21_0.viewType_, arg_21_0.initiativeSkillList_[iter_21_0], arg_21_0.itemSelectHandler_, arg_21_0.activityID_, arg_21_0.levelID_, iter_21_0, arg_21_0.skillID_)
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_0.initiativeSkillContentTrans_)
	else
		arg_21_0.viewStatusController_:SetSelectedState("passive")

		for iter_21_1 = 1, 1 do
			arg_21_0.passiveList_[iter_21_1]:SetData(arg_21_0.viewType_, arg_21_0.passiveSkillList_, arg_21_0.itemSelectHandler_, arg_21_0.activityID_, arg_21_0.levelID_, arg_21_0.skillID_)
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_0.passiveSkillContentTrans_)
	end

	local var_21_0 = ActivityReforgeSkillCfg[arg_21_0.skillID_]

	if arg_21_0.viewType_ == var_0_2.ILLUSTRATED then
		if ActivityReforgeData:GetSkillIsLock(arg_21_0.activityID_, arg_21_0.skillID_) then
			arg_21_0.curSkillStatusController_:SetSelectedState("lock")

			arg_21_0.lockDesText_.text = var_21_0.lock_des
		else
			arg_21_0.skillImage_.sprite = getSprite("Atlas/ValhallaSkillAtlas", var_21_0.icon)
			arg_21_0.skillBgImage_.sprite = getSprite("Atlas/ValhallaSkillAtlas", var_21_0.bg_name)
			arg_21_0.skillName_.text = var_21_0.name
			arg_21_0.buffText_.text = var_21_0.desc_effect
			arg_21_0.debuffText_.text = var_21_0.desc_negative
			arg_21_0.skillDesText_.text = var_21_0.desc_background
			arg_21_0.costText_.text = var_21_0.cost

			if var_21_0.count == -1 then
				arg_21_0.curSkillStatusController_:SetSelectedState("illustratedFreeNormal")
			else
				arg_21_0.curSkillStatusController_:SetSelectedState("illustratedNormal")

				local var_21_1 = "useNum" .. var_21_0.count

				arg_21_0.skillStatusController_:SetSelectedState(var_21_1)

				for iter_21_2 = 1, 3 do
					SetActive(arg_21_0["useNumGo" .. iter_21_2 .. "_"], true)
				end
			end
		end
	else
		arg_21_0.skillStatus_, arg_21_0.skillCanUseNum_ = ActivityReforgeData:GetSkillStatus(arg_21_0.activityID_, arg_21_0.levelID_, arg_21_0.skillID_)

		arg_21_0.curSkillStatusController_:SetSelectedState(arg_21_0.skillStatus_)

		if arg_21_0.skillStatus_ == "lock" then
			arg_21_0.lockDesText_.text = var_21_0.lock_des
		end

		if arg_21_0.skillStatus_ == "freeUsing" or arg_21_0.skillStatus_ == "freeNormal" or arg_21_0.skillStatus_ == "haveNot" or arg_21_0.skillStatus_ == "using" or arg_21_0.skillStatus_ == "haveNotFree" or arg_21_0.skillStatus_ == "infiniteUsing" or arg_21_0.skillStatus_ == "infiniteNormal" or arg_21_0.skillStatus_ == "normal" then
			arg_21_0.skillImage_.sprite = getSprite("Atlas/ValhallaSkillAtlas", var_21_0.icon)
			arg_21_0.skillBgImage_.sprite = getSprite("Atlas/ValhallaSkillAtlas", var_21_0.bg_name)
			arg_21_0.skillName_.text = var_21_0.name
			arg_21_0.buffText_.text = var_21_0.desc_effect
			arg_21_0.debuffText_.text = var_21_0.desc_negative
			arg_21_0.skillDesText_.text = var_21_0.desc_background

			if ActivityReforgeAction.CheckGold(var_21_0.cost, false) then
				arg_21_0.costText_.text = var_21_0.cost
			else
				arg_21_0.costText_.text = "<color=#" .. var_0_1 .. ">" .. var_21_0.cost .. "</color>"
			end
		end

		if arg_21_0.skillStatus_ == "haveNot" or arg_21_0.skillStatus_ == "using" or arg_21_0.skillStatus_ == "normal" then
			local var_21_2 = "useNum" .. var_21_0.count

			arg_21_0.skillStatusController_:SetSelectedState(var_21_2)

			for iter_21_3 = 1, 3 do
				if iter_21_3 <= arg_21_0.skillCanUseNum_ then
					SetActive(arg_21_0["useNumGo" .. iter_21_3 .. "_"], true)
				else
					SetActive(arg_21_0["useNumGo" .. iter_21_3 .. "_"], false)
				end
			end
		end
	end
end

function var_0_0.OnActivityReforgeCurLevelUpdate(arg_22_0)
	arg_22_0:RefreshUI()

	if arg_22_0.viewType_ == var_0_2.USE then
		local var_22_0 = CurrencyConst.CURRENCY_TYPE_ACTIVITY_REFORGE

		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			var_22_0
		})
	end
end

function var_0_0.Dispose(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.initiativeList_) do
		arg_23_0.initiativeList_[iter_23_0]:Dispose()

		arg_23_0.initiativeList_[iter_23_0] = nil
	end

	arg_23_0.initiativeList_ = nil

	for iter_23_2, iter_23_3 in pairs(arg_23_0.passiveList_) do
		arg_23_0.passiveList_[iter_23_2]:Dispose()

		arg_23_0.passiveList_[iter_23_2] = nil
	end

	arg_23_0.passiveList_ = nil
	arg_23_0.itemSelectHandler_ = nil

	arg_23_0.super.Dispose(arg_23_0)
end

return var_0_0
