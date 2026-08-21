local var_0_0 = class("GameHelpMultiView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Pop/InstructionspopUI03"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Dispose(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.infoItems_) do
		iter_3_1:Dispose()
	end

	arg_3_0.infoItems_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddListeners()

	arg_4_0.infoItems_ = {}
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.closeBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	local var_7_0 = arg_7_0.params_.titleList or {}
	local var_7_1 = arg_7_0.params_.contentList or {}

	for iter_7_0 = 1, #var_7_0 do
		if not arg_7_0.infoItems_[iter_7_0] then
			local var_7_2 = Object.Instantiate(arg_7_0.infoItemGo_, arg_7_0.infoItemRootTrs_)

			arg_7_0.infoItems_[iter_7_0] = GameHelpMultiItem.New(var_7_2)
		end

		arg_7_0.infoItems_[iter_7_0]:SetData(var_7_0[iter_7_0], var_7_1[iter_7_0])
		arg_7_0.infoItems_[iter_7_0]:Show(true)
	end

	for iter_7_1 = #var_7_0 + 1, #arg_7_0.infoItems_ do
		arg_7_0.infoItems_[iter_7_1]:Show(false)
	end

	arg_7_0.scrollView_.normalizedPosition = Vector2(0, 1)
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0:RecordStay(arg_8_0.params_.key)
end

function var_0_0.RecordStay(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:GetStayTime()
	local var_9_1 = 0

	if arg_9_1 == "EQUIP_STAGE_DESCRIPE" then
		var_9_1 = 50101
	elseif arg_9_1 == "ENCHANTMENT_DESCRIPE" then
		var_9_1 = 50102
	elseif arg_9_1 == "MATRIX_DESCRIPE" then
		var_9_1 = 50103
	elseif arg_9_1 == "BOSS_CHALLENGE_DESC" then
		var_9_1 = 50104
	elseif arg_9_1 == "MYTHIC_DESCRIPE" then
		var_9_1 = 50105
	elseif arg_9_1 == "SPAWN_DESCRIPE" then
		var_9_1 = 50106
	elseif arg_9_1 == "TEACH_STAGE_DESC" then
		var_9_1 = 50107
	end

	OperationRecorder.RecordStayView("STAY_VIEW_GAME_HELP", var_9_0, var_9_1)
end

return var_0_0
