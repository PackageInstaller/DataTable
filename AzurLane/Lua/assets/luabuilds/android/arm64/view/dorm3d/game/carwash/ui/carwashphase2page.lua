local var_0_0 = class("CarWashPhase2Page", import("view.dorm3d.Game.Dorm3dGameBaseSubView"))

function var_0_0.Init(arg_1_0)
	arg_1_0:InitConfig()
	arg_1_0:InitUI()
	arg_1_0:BindEvent()
	arg_1_0:Hide()

	return
end

function var_0_0.InitConfig(arg_2_0)
	arg_2_0.posConfig = pg.dorm3d_carwash_pos[arg_2_0.contextData.gameConfig.pos_phase2]

	assert(arg_2_0.posConfig, "CarWash phase2 pos config not found: " .. tostring(arg_2_0.contextData.gameConfig.pos_phase2))

	arg_2_0.tipInfos = {}
	arg_2_0.clickedTips = {}

	return
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.tipContainer = arg_3_0._tf:Find("tips")
	arg_3_0.tipList = UIItemList.New(arg_3_0.tipContainer, arg_3_0._tf:Find("tips/tpl"))

	arg_3_0.tipList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		if arg_4_0 == UIItemList.EventInit then
			onButton(arg_3_0, arg_4_2, function()
				if not arg_3_0.tipInfos[arg_4_1] then
					return
				end

				if arg_3_0.clickedTips[arg_3_0.tipInfos[arg_4_1].animId] then
					return
				end

				arg_3_0:emit(CarWashGameFlowSystem.PLAY_PHASE2_REACTION, {
					animId = arg_3_0.tipInfos[arg_4_1].animId
				})

				return
			end)
		elseif arg_4_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateTipItem(arg_4_1, arg_4_2)
		end

		return
	end)

	return
end

function var_0_0.BindEvent(arg_6_0)
	arg_6_0:bind(CarWashGameFlowSystem.UPDATE_GAME_STATE, function(arg_7_0, arg_7_1)
		if arg_7_1.newValue == CarWashConst.GAME_STATE.PHASE_2 then
			arg_6_0:Show()
			arg_6_0:ResetTips()
			arg_6_0:Flush()
		elseif arg_7_1.newValue == CarWashConst.GAME_STATE.PHASE_1 or arg_7_1.newValue == CarWashConst.GAME_STATE.END then
			arg_6_0:Hide()
		end

		return
	end)
	arg_6_0:bind(CarWashLadySystem.UPDATE_PHASE2_TIPS, function(arg_8_0, arg_8_1)
		if arg_6_0.contextData.gameStatus.currentState ~= CarWashConst.GAME_STATE.PHASE_2 then
			return
		end

		arg_6_0.tipInfos = arg_8_1 or {}

		arg_6_0:Flush()

		return
	end)
	arg_6_0:bind(CarWashGameFlowSystem.UPDATE_PHASE2_REACTION_PROGRESS, function(arg_9_0, arg_9_1)
		arg_6_0.clickedTips[arg_9_1.animId] = true

		arg_6_0:Flush()

		return
	end)

	return
end

function var_0_0.Flush(arg_10_0)
	arg_10_0.tipList:align(#arg_10_0.tipInfos)

	return
end

function var_0_0.UpdateTipItem(arg_11_0, arg_11_1, arg_11_2)
	assert(arg_11_0.tipInfos[arg_11_1], "CarWash phase2 tip info not found: " .. tostring(arg_11_1))
	setActive(arg_11_2, arg_11_0.tipInfos[arg_11_1].visible)

	if arg_11_0.tipInfos[arg_11_1].visible then
		setLocalPosition(arg_11_2, LuaHelper.ScreenToLocal(arg_11_0.tipContainer, arg_11_0.tipInfos[arg_11_1].screenPosition, pg.UIMgr.GetInstance().uiCameraComp))
	end

	return
end

function var_0_0.ResetTips(arg_12_0)
	arg_12_0.tipInfos = {}
	arg_12_0.clickedTips = {}

	return
end

return var_0_0
