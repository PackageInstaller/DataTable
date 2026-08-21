local var_0_0 = class("OsirisPlayGameChallegeStageView", ReduxView)
local var_0_1 = 7

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Osiris/Activity_Osiris_CheckpointUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.items_ = {}

	for iter_4_0 = 1, 6 do
		local var_4_0 = OsirisPlayGameChallegeStageItem.New(arg_4_0["itemGo_" .. iter_4_0], iter_4_0)

		arg_4_0.items_[iter_4_0] = var_4_0

		arg_4_0.items_[iter_4_0]:RegisterClickFunc(function(arg_5_0)
			arg_4_0:OnBtnClick(arg_5_0)
		end)
	end

	arg_4_0.positionCon_ = arg_4_0.transform_:GetComponent("ControllerExCollection"):GetController("position")
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.activityID_ = arg_6_0.params_.activityID_
	arg_6_0.stage_list = ActivityGeneralityStageCfg.get_id_list_by_chapter_id[var_0_1]

	arg_6_0:RefreshItems()

	local var_6_0 = OsirisPlayGameData:GetPassStageClearTimes()

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if iter_6_1 == 0 then
			OsirisPlayGameData:SetPassStageClearTimes(iter_6_0)
		end
	end
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.maskBtn_, nil, function()
		if arg_7_0:IsOpenSectionView() then
			JumpTools.Back()
			arg_7_0:ResetSelect()
		end
	end)
end

function var_0_0.IsOpenSectionView(arg_9_0)
	return arg_9_0:IsOpenRoute("osirisPlayGameSectionInfoView")
end

function var_0_0.RefreshItems(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.items_ do
		arg_10_0.items_[iter_10_0]:RefreshView(arg_10_0.stage_list[iter_10_0])
	end
end

function var_0_0.OnBtnClick(arg_11_0, arg_11_1)
	for iter_11_0 = 1, #arg_11_0.items_ do
		arg_11_0.items_[iter_11_0]:RefreshState(arg_11_1 == iter_11_0 and 1 or 0)
	end

	arg_11_0.positionCon_:SetSelectedIndex(arg_11_1)
	arg_11_0:EnterLevel(arg_11_1)
end

function var_0_0.EnterLevel(arg_12_0, arg_12_1)
	arg_12_0.selectLevel_ = arg_12_1

	arg_12_0.positionCon_:SetSelectedIndex(arg_12_1)

	local var_12_0 = arg_12_0.stage_list[arg_12_1]
	local var_12_1 = ActivityGeneralityStageCfg[var_12_0].stage_id

	JumpTools.OpenPageByJump("osirisPlayGameSectionInfoView", {
		section = var_12_0,
		sectionType = BattleConst.STAGE_TYPE_NEW.OSIRIS_PLAY_GAME,
		mainActivityID = arg_12_0.activityID_,
		activityId = arg_12_0.activityID_,
		backCall = handler(arg_12_0, arg_12_0.ResetSelect)
	})
end

function var_0_0.ResetSelect(arg_13_0)
	arg_13_0.positionCon_:SetSelectedState(0)

	arg_13_0.selectLevel_ = 0

	for iter_13_0 = 1, #arg_13_0.items_ do
		arg_13_0.items_[iter_13_0]:RefreshState(0)
	end
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_GENERALITY_DESC")
	manager.windowBar:RegistBackCallBack(function()
		if arg_14_0:IsOpenSectionView() then
			arg_14_0:ResetSelect()
		end

		JumpTools.Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		if arg_14_0:IsOpenSectionView() then
			arg_14_0:ResetSelect()
		end

		gameContext:Go("/home", nil, nil, true)
	end)
end

function var_0_0.OnExit(arg_17_0)
	var_0_0.super.OnExit(arg_17_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_18_0)
	for iter_18_0 = 1, #arg_18_0.items_ do
		arg_18_0.items_[iter_18_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
