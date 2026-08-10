local var_0_0 = {
	OnEnterBlisterGameScene = function()
		return
	end,
	OnBlisterGameSceneReady = function()
		return
	end
}

function var_0_0.SetBlisterCamParam()
	manager.uiInit()

	whereami = "battle"

	manager.ui:SetMainCameraPos(Vector3(5, 5, -30))
	manager.ui:SetMainCameraRot(Vector3.zero)
	manager.ui:SetMainCameraFieldOfView(30)
	BlisterGameTool.GoToBlisterBattleInfoView()
	var_0_0:UpSetCameraFOV()

	local var_3_0 = manager.ui.mainCameraCom_
	local var_3_1 = GameObject.Find("Alone_BubblesGame/fontBg")
	local var_3_2 = var_3_1.transform
	local var_3_3 = var_3_1.transform:GetComponent("SpriteRenderer").sprite.bounds.size
	local var_3_4 = var_3_3.x
	local var_3_5 = var_3_3.y
	local var_3_6 = 2 * Mathf.Abs(var_3_0.transform.position.z - var_3_2.position.z) * Mathf.Tan(var_3_0.fieldOfView * 0.5 * Mathf.Deg2Rad)
	local var_3_7 = var_3_6 * var_3_0.aspect

	if var_3_5 < var_3_6 then
		local var_3_8 = var_3_7 / var_3_4
		local var_3_9 = var_3_6 / var_3_5
		local var_3_10 = var_3_9 < var_3_8 and var_3_8 or var_3_9

		var_3_1.transform.localScale = Vector3.New(var_3_10, var_3_10, 1)
	end
end

function var_0_0.UpSetCameraFOV(arg_4_0)
	local var_4_0 = 1.7777777777777777 / (Screen.width / Screen.height)
	local var_4_1 = 30
	local var_4_2 = math.max(var_4_0 * 30, var_4_1)

	manager.ui.mainCameraCom_.fieldOfView = var_4_2
end

function var_0_0.OnBlisterGameSceneLoaded()
	return
end

function var_0_0.OnUpdateComboNum(arg_6_0)
	manager.notify:Invoke(BLISTERGAME_UpdateCombo, arg_6_0)
end

function var_0_0.OnBlisterGameSceneExit()
	if var_0_0.raycaster then
		Object.Destroy(var_0_0.raycaster)

		var_0_0.raycaster = nil
	end
end

function var_0_0.OnGameEnd(arg_8_0)
	manager.notify:Invoke(BLISTERGAME_GAMEEND, arg_8_0)
end

function var_0_0.OnUpdateNum(arg_9_0)
	manager.notify:Invoke(BLISTERGAME_UpdateteNum, arg_9_0)
end

function var_0_0.OnUpdateScore(arg_10_0, arg_10_1)
	manager.notify:Invoke(BLISTERGAME_UpdateteScore, arg_10_0, arg_10_1)
end

function var_0_0.OnBlisterWaterring(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	manager.notify:Invoke(BLISTERGAME_ONWATERRING, arg_11_0, arg_11_1, arg_11_2, arg_11_3)
end

function var_0_0.BigNode()
	manager.notify:Invoke(BLISTERGAME_BIGNODE)
end

function var_0_0.ShowAddAnim()
	manager.notify:Invoke(BLISTERGAME_ADD_ANIM)
end

function var_0_0.ShowReduceAnim()
	manager.notify:Invoke(BLISTERGAME_REDUCE_ANIM)
end

return var_0_0
