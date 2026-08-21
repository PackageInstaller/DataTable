local var_0_0 = class("CusteomCenterSceneItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.useController_ = arg_1_0.controllerEx_:GetController("use")
	arg_1_0.selectController_ = arg_1_0.controllerEx_:GetController("select")
	arg_1_0.lockController_ = arg_1_0.controllerEx_:GetController("lock")
	arg_1_0.dlcController_ = arg_1_0.controllerEx_:GetController("dlc")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.sceneID_ == arg_3_0.selectID_ then
			return
		end

		if HomeSceneSettingData:CanUseScene(arg_3_0.sceneID_) == false then
			ShowTips("CUSTOM_CENTER_SCENE_LOCK")

			return
		end

		manager.notify:Invoke(CUSTOM_CENTER_SELECT_SCENE, arg_3_0.sceneID_)
	end)
end

function var_0_0.SetSceneData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.sceneID_ = arg_5_1
	arg_5_0.selectID_ = arg_5_2

	local var_5_0 = arg_5_1

	if HomeSceneSettingCfg[arg_5_1].limit_display ~= 1 then
		local var_5_1 = SkinSceneActionCfg.get_id_list_by_special_scene_id[arg_5_1]

		var_5_0 = var_5_1 and nullable(SkinSceneActionCfg, var_5_1[1], "skin_id") or var_5_0
	end

	arg_5_0.icon_.spriteSync = "TextureConfig/SceneChangeUI/item/" .. var_5_0

	arg_5_0.selectController_:SetSelectedState(arg_5_2 == arg_5_1 and "true" or "false")
	arg_5_0:RefreshState()
	arg_5_0:RefreshLock()
	arg_5_0:RefreshDLC()
end

function var_0_0.RefreshState(arg_6_0)
	if CustomCenterTools.IsDLCScene(arg_6_0.sceneID_) then
		arg_6_0.useController_:SetSelectedState("false")

		return
	end

	if CustomCenterTools.IsRandomScene() then
		if table.keyof(HomeSceneSettingData:GetCacheRandomSceneList(), arg_6_0.sceneID_) then
			arg_6_0.useController_:SetSelectedState("true")

			return
		end
	elseif manager.loadScene:GetTimeSceneID(HomeSceneSettingData:GetRealScene()) == arg_6_0.sceneID_ then
		arg_6_0.useController_:SetSelectedState("true")

		return
	end

	arg_6_0.useController_:SetSelectedState("false")
end

function var_0_0.RefreshLock(arg_7_0)
	local var_7_0 = not HomeSceneSettingData:CanUseScene(arg_7_0.sceneID_)

	arg_7_0.lockController_:SetSelectedState(tostring(var_7_0))
end

function var_0_0.RefreshDLC(arg_8_0)
	if CustomCenterTools.IsDLCScene(arg_8_0.sceneID_) then
		arg_8_0.dlcController_:SetSelectedState("state1")
	else
		arg_8_0.dlcController_:SetSelectedState("state0")
	end
end

return var_0_0
