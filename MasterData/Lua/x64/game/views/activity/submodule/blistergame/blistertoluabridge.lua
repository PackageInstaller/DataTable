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

	local var_3_0 = GameObject.Find("Alone_BubblesGame/fontBg")
	local var_3_1 = var_3_0.transform:GetComponent("SpriteRenderer").sprite.bounds.size
	local var_3_2 = var_3_1.x
	local var_3_3 = var_3_1.y
	local var_3_4 = 2 * Mathf.Abs(manager.ui.mainCameraCom_.transform.position.z - var_3_0.transform.position.z) * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

	if var_3_1.y < var_3_4 then
		var_3_0.transform.localScale = Vector3.New(var_3_4 / var_3_3 < var_3_4 * manager.ui.mainCameraCom_.aspect / var_3_2 and var_3_4 * manager.ui.mainCameraCom_.aspect / var_3_2 or var_3_4 / var_3_3, var_3_4 / var_3_3 < var_3_4 * manager.ui.mainCameraCom_.aspect / var_3_2 and var_3_4 * manager.ui.mainCameraCom_.aspect / var_3_2 or var_3_4 / var_3_3, 1)
	end
end

function var_0_0.UpSetCameraFOV(arg_4_0)
	manager.ui.mainCameraCom_.fieldOfView = math.max(1.7777777777777777 / (Screen.width / Screen.height) * 30, 30)
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
