local var_0_0 = class("OathPhotoDisplayView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.modeController_ = arg_1_0.controller_:GetController("mode")
end

function var_0_0.SetAniPlayEnd(arg_2_0)
	arg_2_0.ani_:Play("UI_phototakenUI_cx", 0, 1)
end

function var_0_0.OnSnape(arg_3_0)
	local var_3_0 = Screen.width
	local var_3_1 = Screen.height

	arg_3_0.screenSnap_ = ScreenSnap.New(var_3_0, var_3_1)

	arg_3_0.screenSnap_:Take()

	local var_3_2 = arg_3_0.screenSnap_:GetSprite()

	arg_3_0.imageBg_.sprite = var_3_2

	local var_3_3 = arg_3_0.maskNodeRect_.rect.width
	local var_3_4 = arg_3_0.maskNodeRect_.rect.height
	local var_3_5 = 1

	if var_3_0 / var_3_1 > 1.7777777777777777 then
		var_3_5 = var_3_4 / var_3_1
	else
		var_3_5 = var_3_3 / var_3_0
	end

	arg_3_0.imageBg_.transform.localScale = Vector3.one * var_3_5

	arg_3_0.imageBg_:SetNativeSize()

	arg_3_0.screenSnapPath_ = arg_3_0:GetSaveCachePath()

	arg_3_0.screenSnap_:SaveSnap(arg_3_0.screenSnapPath_)
	arg_3_0:IsShowPanel(true)
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.sceneMode = arg_4_1

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	if arg_5_0.sceneMode == OathConst.OATH_SCENE_MODE.CAPTURE then
		arg_5_0.modeController_:SetSelectedState("oathEnter")
	elseif arg_5_0.sceneMode == OathConst.OATH_SCENE_MODE.BOOK_RE then
		arg_5_0.modeController_:SetSelectedState("bookEnter")
	end
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:RegistEventListener(SDK_UPLOAD_IMG, OathCollectionContentAction.OnSDKUploadWeddingPhoto(handler(arg_6_0, arg_6_0.UploadImageSuccess), handler(arg_6_0, arg_6_0.UnloadImageFailed)))
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0:RemoveAllEventListener()

	arg_7_0.screenSnap_ = nil
end

function var_0_0.IsShowPanel(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.ExitPanel(arg_9_0)
	if arg_9_0.exitViewFunc then
		arg_9_0.exitViewFunc()
	end

	arg_9_0:IsShowPanel(false)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

local var_0_1 = {
	go = 1,
	share = 3,
	re = 2
}

function var_0_0.AddListeners(arg_11_0)
	arg_11_0:AddBtnListener(arg_11_0.goBtn_, nil, function()
		arg_11_0:OnClickSureBtn()
		arg_11_0:SendSelectSDK(var_0_1.go)
	end)
	arg_11_0:AddBtnListener(arg_11_0.reBtn_, nil, function()
		if arg_11_0.reFunc then
			arg_11_0.reFunc()
		end

		arg_11_0:SendSelectSDK(var_0_1.re)
	end)
	arg_11_0:AddBtnListener(arg_11_0.shareBtn_, nil, function()
		if arg_11_0.shareFunc then
			arg_11_0.shareFunc(arg_11_0.screenSnap_:GetSprite(), arg_11_0.screenSnapPath_)
		end

		arg_11_0:SendSelectSDK(var_0_1.share)
	end)
end

function var_0_0.SendSelectSDK(arg_15_0, arg_15_1)
	SDKTools.SendMessageToSDK("activity_sys_act", {
		params_list = "[1,2,3]",
		mould_id = 1,
		sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM,
		hero_id = OathToLuaBridge:GetOathHeroID(),
		type = OathConst.OATH_SCENE_ID.CAPTURE_SELECT,
		param_tree = arg_15_1
	})
end

function var_0_0.SetExitViewCallBack(arg_16_0, arg_16_1)
	if arg_16_1 then
		arg_16_0.exitViewFunc = arg_16_1
	end
end

function var_0_0.SetReCallBack(arg_17_0, arg_17_1)
	if arg_17_1 then
		arg_17_0.reFunc = arg_17_1
	end
end

function var_0_0.SetShareCallBack(arg_18_0, arg_18_1)
	if arg_18_1 then
		arg_18_0.shareFunc = arg_18_1
	end
end

function var_0_0.OnClickSureBtn(arg_19_0)
	local var_19_0 = arg_19_0.screenSnapPath_

	if var_19_0 == nil then
		var_19_0 = arg_19_0:GetSaveCachePath()

		arg_19_0.screenSnap_:SaveSnap(var_19_0)
	end

	if GameToSDK.IsEditorPlatform() then
		local var_19_1 = string.match(var_19_0, "picture_(%d+)%.jpg")

		arg_19_0:UploadImageSuccess(var_19_1)
	else
		SDKUploadImage("oath", var_19_0)
	end
end

function var_0_0.GetSaveCachePath(arg_20_0)
	local var_20_0 = OathToLuaBridge:GetOathHeroID()

	return manager.share:GetSavePathByModule("oath") .. string.format("picture_%s_%s.jpg", USER_ID, var_20_0)
end

function var_0_0.UploadImageSuccess(arg_21_0, arg_21_1)
	local var_21_0 = OathToLuaBridge:GetOathHeroID()

	OathCollectionContentAction.UpdateWeddingPhoto(var_21_0, arg_21_1)

	local var_21_1 = manager.share:GetSavePathByModule("imgCache/oath") .. string.format("picture_%s_%s.jpg", USER_ID, var_21_0)

	arg_21_0.screenSnap_:SaveSnap(var_21_1)
	arg_21_0:JumpToOathBook()
end

function var_0_0.UnloadImageFailed(arg_22_0)
	ShowTips("IMAGE_UPLOAD_FAIL")
end

function var_0_0.JumpToOathBook(arg_23_0)
	OathToLuaBridge.OathEnterCaptureHideUIMode(false)

	local var_23_0 = OathToLuaBridge:GetOathHeroID()
	local var_23_1 = arg_23_0.screenSnap_:GetSprite()

	if arg_23_0.sceneMode == OathConst.OATH_SCENE_MODE.CAPTURE then
		JumpTools.OpenPageByJump("oathBookLoadingView", {
			heroID = var_23_0,
			sprite = var_23_1
		})
	elseif arg_23_0.sceneMode == OathConst.OATH_SCENE_MODE.BOOK_RE then
		OathToLuaBridge.OathExitBookReModeScene(var_23_0, var_23_1)
	end
end

return var_0_0
