class = var_0_10000

local var_0_0 = "CarWashPhase2Page"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Game.Dorm3dGameBaseSubView"))

function var_0_1.Init(arg_1_0)
	arg_1_0:InitConfig()
	arg_1_0:InitUI()
	arg_1_0:BindEvent()
	arg_1_0:Hide()

	return
end

function var_0_1.InitConfig(arg_2_0)
	pg = var_1_10001
	arg_2_0.posConfig = var_1_10001.dorm3d_carwash_pos[arg_2_0.contextData.gameConfig.pos_phase2]
	assert = var_1

	local var_2_0 = arg_2_0.posConfig
	local var_2_1 = "CarWash phase2 pos config not found: "

	tostring = var_1_10005

	var_1(var_2_0, var_2_1 .. var_1_10005(arg_2_0.contextData.gameConfig.pos_phase2))

	arg_2_0.tipInfos = {}
	arg_2_0.clickedTips = {}

	return
end

function var_0_1.InitUI(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.tipContainer = var_1.Find(var_3_0, "tips")
	UIItemList = var_1

	local var_3_1 = var_1.New
	local var_3_2 = arg_3_0.tipContainer
	local var_3_3 = arg_3_0._tf

	arg_3_0.tipList = var_3_1(var_3_2, var_4.Find(var_3_3, "tips/tpl"))

	local var_3_4 = arg_3_0.tipList

	var_1.make(var_3_4, function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventInit then
			onButton = var_3

			var_3(arg_3_0, arg_4_2, function()
				if not arg_3_0.tipInfos[arg_4_1] then
					return
				end

				if arg_3_0.clickedTips[var_0.animId] then
					return
				end

				local var_5_0 = arg_3_0
				local var_5_1 = var_1.emit

				CarWashGameFlowSystem = var_3_10004

				var_5_1(var_5_0, var_3_10004.PLAY_PHASE2_REACTION, {
					animId = var_0.animId
				})

				return
			end)
		else
			UIItemList = var_3

			if arg_4_0 == var_3.EventUpdate then
				local var_4_0 = arg_3_0

				var_3.UpdateTipItem(var_4_0, arg_4_1, arg_4_2)
			end
		end

		return
	end)

	return
end

function var_0_1.BindEvent(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.bind

	CarWashGameFlowSystem = var_1_10004

	var_6_1(var_6_0, var_1_10004.UPDATE_GAME_STATE, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_1.newValue

		CarWashConst = var_2_10003

		if var_7_0 == var_2_10003.GAME_STATE.PHASE_2 then
			local var_7_1 = arg_6_0

			var_2.Show(var_7_1)

			local var_7_2 = arg_6_0

			var_2.ResetTips(var_7_2)

			local var_7_3 = arg_6_0

			var_2.Flush(var_7_3)

			goto label_7_0
		end

		local var_7_4 = arg_7_1.newValue

		CarWashConst = var_3

		if var_7_4 ~= var_3.GAME_STATE.PHASE_1 then
			do
				local var_7_5 = arg_7_1.newValue

				CarWashConst = var_3

				if var_7_5 == var_3.GAME_STATE.END then
					local var_7_6 = arg_6_0

					var_2.Hide(var_7_6)
				end
			end

			::label_7_0::

			return
		end
	end)

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.bind

	CarWashLadySystem = var_4

	var_6_3(var_6_2, var_4.UPDATE_PHASE2_TIPS, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_6_0.contextData.gameStatus.currentState

		CarWashConst = var_2_10003

		if var_8_0 ~= var_2_10003.GAME_STATE.PHASE_2 then
			return
		end

		arg_6_0.tipInfos = arg_8_1 or {}

		local var_8_1 = arg_6_0

		var_2.Flush(var_8_1)

		return
	end)

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.bind

	CarWashGameFlowSystem = var_4

	var_6_5(var_6_4, var_4.UPDATE_PHASE2_REACTION_PROGRESS, function(arg_9_0, arg_9_1)
		arg_6_0.clickedTips[arg_9_1.animId] = true

		local var_9_0 = arg_6_0

		var_2.Flush(var_9_0)

		return
	end)

	return
end

function var_0_1.Flush(arg_10_0)
	local var_10_0 = arg_10_0.tipList

	var_1.align(var_10_0, #arg_10_0.tipInfos)

	return
end

function var_0_1.UpdateTipItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.tipInfos[arg_11_1]

	assert = var_1_10004

	local var_11_1 = var_11_0
	local var_11_2 = "CarWash phase2 tip info not found: "

	tostring = var_1_10008

	var_1_10004(var_11_1, var_11_2 .. var_1_10008(arg_11_1))

	setActive = var_1_10004

	var_1_10004(arg_11_2, var_11_0.visible)

	if var_11_0.visible then
		setLocalPosition = var_4

		local var_11_3 = arg_11_2

		LuaHelper = var_7

		local var_11_4 = var_7.ScreenToLocal
		local var_11_5 = arg_11_0.tipContainer
		local var_11_6 = var_11_0.screenPosition

		pg = var_1_10011

		var_4(var_11_3, var_11_4(var_11_5, var_11_6, var_1_10011.UIMgr.GetInstance().uiCameraComp))
	end

	return
end

function var_0_1.ResetTips(arg_12_0)
	arg_12_0.tipInfos = {}
	arg_12_0.clickedTips = {}

	return
end

return var_0_1
