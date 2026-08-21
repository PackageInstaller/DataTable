local var_0_0 = class("MonsterCosplayMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ExploreUI/ExploreHome"
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

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uiListGo_, MonsterCosplaySkillUpItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListenerScale(arg_5_0.sureBtn_, nil, function()
		return
	end)
end

function var_0_0.UpdateBar(arg_7_0)
	return
end

function var_0_0.UpdateView(arg_8_0)
	return
end

function var_0_0.UpdateData(arg_9_0)
	return
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.monsterID = arg_10_0.params_.monsterID
	arg_10_0.exitView_ = false

	manager.ui:SetMainCamera("soloHeartDemon")
	manager.windowBar:SetWhereTag("soloHeartDemon")
	arg_10_0:LoadModel()
	arg_10_0:UpdateData()
	arg_10_0:UpdateView()
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0.exitView_ = true

	manager.ui:ResetMainCamera()
	arg_11_0:UnloadModel()
end

function var_0_0.LoadModel(arg_12_0)
	if arg_12_0.currentBossTemplateID == arg_12_0.modelID then
		return
	end

	arg_12_0:UnloadModel()

	arg_12_0.currentBossTemplateID = arg_12_0.modelID

	local var_12_0 = SoloHeartDemonUICfg[arg_12_0.modelID]

	arg_12_0.loadIndex = manager.resourcePool:AsyncLoad("Char/" .. var_12_0.model, ASSET_TYPE.TPOSE, function(arg_13_0)
		if arg_12_0.exitView_ or arg_12_0.currentBossTemplateID ~= arg_12_0.modelID then
			manager.resourcePool:DestroyOrReturn(arg_13_0, ASSET_TYPE.TPOSE)

			return
		end

		local var_13_0 = var_12_0.model_pos
		local var_13_1 = var_12_0.model_rot
		local var_13_2 = var_12_0.model_scale

		arg_12_0.bossModel = arg_13_0
		arg_13_0.transform.localPosition = Vector3(var_13_0[1], var_13_0[2], var_13_0[3])
		arg_13_0.transform.localEulerAngles = Vector3(var_13_1[1], var_13_1[2], var_13_1[3])
		arg_13_0.transform.localScale = Vector3(var_13_2[1], var_13_2[2], var_13_2[3])
	end)
end

function var_0_0.InitBackScene(arg_14_0)
	local var_14_0 = "UI/Common/BackgroundQuad"

	arg_14_0.backGround_ = manager.resourcePool:Get(var_14_0, ASSET_TYPE.SCENE)
	arg_14_0.backGroundTrs_ = arg_14_0.backGround_.transform

	arg_14_0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	local var_14_1 = GameDisplayCfg.solo_heart_demon_bg_pos.value

	arg_14_0.backGroundTrs_.localPosition = Vector3(var_14_1[1], var_14_1[2], var_14_1[3])
	arg_14_0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)

	local var_14_2 = GameDisplayCfg.solo_heart_demon_bg_pos.scale

	arg_14_0.backGroundTrs_.localScale = Vector3(var_14_2[1], var_14_2[2], var_14_2[3])
end

function var_0_0.DestroyBackScene(arg_15_0)
	if arg_15_0.backGround_ then
		manager.resourcePool:DestroyOrReturn(arg_15_0.backGround_, ASSET_TYPE.SCENE)

		arg_15_0.backGround_ = nil
	end
end

function var_0_0.Dispose(arg_16_0)
	return
end

return var_0_0
