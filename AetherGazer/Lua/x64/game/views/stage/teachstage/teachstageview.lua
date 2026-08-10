local var_0_0 = class("TeachStageView", ReduxView)
local var_0_1 = {
	{
		battleConst = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING,
		redConst = RedPointConst.TEACH_BASE
	},
	{
		battleConst = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
		redConst = RedPointConst.TEACH_CHARACTER
	}
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Teachinglevel/TeachinglevelUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.switchBtn_ = {}
	arg_3_0.contentView_ = {}

	arg_3_0:InitUI()
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("TEACH_STAGE_DESC")

	for iter_4_0 = 1, 2 do
		arg_4_0:AddBtnListener(arg_4_0[string.format("btnTab%s_", iter_4_0)], nil, function()
			arg_4_0:SelectTab(iter_4_0)
		end)
	end

	local var_4_0 = arg_4_0.params_.switchType or BattleTeachData:GetSwitchType()

	BattleTeachData:SetSwitchType(var_4_0)

	arg_4_0.lastSwitchType_ = var_4_0

	local var_4_1 = 1

	for iter_4_1, iter_4_2 in ipairs(var_0_1) do
		if iter_4_2.battleConst == var_4_0 then
			var_4_1 = iter_4_1
		end

		manager.redPoint:bindUIandKey(arg_4_0[string.format("buttle0%sTrs_", iter_4_1)].transform, iter_4_2.redConst)
	end

	arg_4_0:SelectTab(var_4_1)
	manager.redPoint:bindUIandKey(arg_4_0.buttle01Trs_, RedPointConst.TEACH_BASE_TEACHING)
end

function var_0_0.SelectTab(arg_6_0, arg_6_1)
	arg_6_0:OnGroupSelect(arg_6_1)
	arg_6_0.tabControl:SetSelectedState(string.format("state%s", arg_6_1))
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function var_0_0.OnUpdate(arg_8_0)
	if arg_8_0.lastSwitchType_ ~= BattleTeachData:GetSwitchType() then
		arg_8_0.lastSwitchType_ = BattleTeachData:GetSwitchType()

		arg_8_0:SwitchPage(arg_8_0.lastSwitchType_, false)
	end

	arg_8_0.contentView_[arg_8_0.lastSwitchType_]:OnUpdate()
end

function var_0_0.OnClickTeachViewBtn(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.contentView_) do
		iter_9_1:OnClickTeachViewBtn()
	end
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0.switchType_ = nil

	manager.windowBar:HideBar()

	for iter_10_0, iter_10_1 in pairs(arg_10_0.contentView_) do
		iter_10_1:OnExit()
	end

	for iter_10_2, iter_10_3 in ipairs(var_0_1) do
		manager.redPoint:unbindUIandKey(arg_10_0[string.format("buttle0%sTrs_", iter_10_2)].transform)
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveListeners()

	for iter_11_0, iter_11_1 in pairs(arg_11_0.contentView_) do
		iter_11_1:Dispose()
	end

	arg_11_0.contentView_ = nil
	arg_11_0.basePanel_ = nil
	arg_11_0.heroPanel_ = nil

	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.InitUI(arg_12_0)
	arg_12_0:BindCfgUI()

	arg_12_0.tabControl = arg_12_0.tabControllerexcollection_:GetController("select")
	arg_12_0.contentView_[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING] = TeachStageBaseView.New(arg_12_0.basePanel_, BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING)
	arg_12_0.contentView_[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING] = TeachStageHeroView.New(arg_12_0.heroPanel_, BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING)
end

function var_0_0.RemoveListeners(arg_13_0)
	return
end

function var_0_0.OnGroupSelect(arg_14_0, arg_14_1)
	local var_14_0 = var_0_1[arg_14_1].battleConst

	if var_14_0 == arg_14_0.switchType_ and not arg_14_0.params_.heroID then
		return
	end

	arg_14_0:SwitchPage(var_14_0, arg_14_0.params_.isBack)
	BattleTeachData:SetSwitchType(arg_14_0.switchType_)
	arg_14_0:Go("teachStage", {
		switchType = arg_14_0.switchType_
	})
	manager.notify:CallUpdateFunc(CLICK_TEACH_BTN)

	for iter_14_0, iter_14_1 in pairs(arg_14_0.contentView_) do
		iter_14_1:OnEnter()
	end
end

function var_0_0.GetCurView(arg_15_0)
	if arg_15_0.contentView_[arg_15_0.switchType_] then
		return arg_15_0.contentView_[arg_15_0.switchType_]
	end
end

function var_0_0.SwitchPage(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.switchType_ = arg_16_1

	if arg_16_1 == 12 then
		OperationRecorder.Record("teachStage", "base")
	elseif arg_16_1 == 13 then
		OperationRecorder.Record("teachStage", "role")
	end

	for iter_16_0, iter_16_1 in pairs(arg_16_0.contentView_) do
		iter_16_1:SwitchPageUI(arg_16_1, arg_16_0.params_.heroID, arg_16_2 ~= true)
	end

	arg_16_0.params_.heroID = nil
end

return var_0_0
