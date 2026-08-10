local var_0_0 = class("OathSceneCaptureView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_Oath/OathCaptureView/HeroOathSceneCaptureView"
end

local var_0_1 = {
	CAPTURE = 1,
	EXIT = 2
}
local var_0_2 = {
	BOOK = 2,
	SHARE = 1
}

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.lookStateController_ = arg_4_0.controller_:GetController("lookBtnState")
	arg_4_0.isClickCaptureBtn_ = false

	arg_4_0:AddBtnListener(arg_4_0.captureBtn_, nil, function()
		arg_4_0:OnClickCaptureBtn()
	end)
	arg_4_0:AddBtnListener(arg_4_0.settingBtn_, nil, function()
		JumpTools.OpenPageByJump("oathCaptureSettingView")
	end)

	arg_4_0.photoDisplayView_ = OathPhotoDisplayView.New(arg_4_0.photoDispalyPanel_)

	arg_4_0.photoDisplayView_:SetExitViewCallBack(function()
		arg_4_0.isClickCaptureBtn_ = false

		OathToLuaBridge.OathEnterCaptureHideUIMode(false)
	end)
	arg_4_0.photoDisplayView_:SetReCallBack(function()
		arg_4_0.isClickCaptureBtn_ = false

		OathToLuaBridge.OathEnterCaptureHideUIMode(false)
		SetActive(arg_4_0.gameObject_, true)
		arg_4_0.photoDisplayView_:IsShowPanel(false)
	end)
	arg_4_0.photoDisplayView_:SetShareCallBack(function(arg_9_0, arg_9_1)
		arg_4_0:OnClickDisplayShareBtn(arg_9_0, arg_9_1)
	end)

	arg_4_0.sharePanel_ = OathShareView.New(arg_4_0.goSharePanel_)

	arg_4_0.sharePanel_:ExitViewCallBack(function()
		arg_4_0.isClickCaptureBtn_ = false

		OathToLuaBridge.OathEnterCaptureHideUIMode(false)

		if arg_4_0.sceneMode == OathConst.OATH_SCENE_MODE.BOOK_RE then
			arg_4_0.photoDisplayView_:IsShowPanel(false)
		elseif arg_4_0.sceneMode == OathConst.OATH_SCENE_MODE.CAPTURE then
			arg_4_0.photoDisplayView_:IsShowPanel(true)
			arg_4_0.photoDisplayView_:SetAniPlayEnd()
		end
	end)
end

function var_0_0.OnClickDisplayShareBtn(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.photoDisplayView_:IsShowPanel(false)
	SetActive(arg_11_0.gameObject_, false)
	WaitRenderFrameUtil.inst.StartScreenShot(function()
		SetActive(arg_11_0.gameObject_, true)
		arg_11_0.sharePanel_:OnSnape(true)
	end)
end

function var_0_0.OnClickCaptureBtn(arg_13_0)
	if arg_13_0.isClickCaptureBtn_ then
		return
	end

	arg_13_0.isClickCaptureBtn_ = true

	OathToLuaBridge.OathEnterCaptureHideUIMode(true)
	manager.ui:ShowScreenTap(false)
	SetActive(arg_13_0.gameObject_, false)
	WaitRenderFrameUtil.inst.StartScreenShot(function()
		SetActive(arg_13_0.gameObject_, true)

		if arg_13_0.sceneMode == OathConst.OATH_SCENE_MODE.CAPTURE then
			manager.ui:SetUISeparateRender(true)
			arg_13_0.photoDisplayView_:OnSnape()
			arg_13_0:OathCaptureSDK(var_0_2.BOOK)
		elseif arg_13_0.sceneMode == OathConst.OATH_SCENE_MODE.SHARE then
			arg_13_0.sharePanel_:OnSnape(true)
			arg_13_0:OathCaptureSDK(var_0_2.SHARE)
		elseif arg_13_0.sceneMode == OathConst.OATH_SCENE_MODE.BOOK_RE then
			arg_13_0.photoDisplayView_:OnSnape()
			arg_13_0:OathCaptureSDK(var_0_2.BOOK)
		end

		manager.ui:ShowScreenTap(true)
	end)
end

function var_0_0.GetFilterSDKData(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = arg_15_0.lookStateController_:GetSelectedState() == "on"

	return (string.format("[{pose:%s},{emoji:%s},{filter:%s},{camera_look:%s},{camera_position:%s},{camera_distance:%s}]", OathToLuaBridge:GetCaptureSwitch(OathConst.OATH_CAPTURE_FILTER_TYPE.Action) or -1, OathToLuaBridge:GetCaptureSwitch(OathConst.OATH_CAPTURE_FILTER_TYPE.Face) or -1, OathToLuaBridge:GetCaptureSwitch(OathConst.OATH_CAPTURE_FILTER_TYPE.Filter) or -1, var_15_1 or false, arg_15_0.sliderSlr_.value, manager.ui.mainCameraCom_.fieldOfView))
end

function var_0_0.OathCaptureSDK(arg_16_0, arg_16_1)
	SDKTools.SendMessageToSDK("activity_combat_over", {
		sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM,
		hero_id = OathToLuaBridge:GetOathHeroID(),
		skin_id = OathToLuaBridge:GetUseOathCharacterID(),
		stage_id = arg_16_1,
		result = var_0_1.CAPTURE,
		other_data = arg_16_0:GetFilterSDKData() or {}
	})
end

function var_0_0.OathExitSDK(arg_17_0)
	local var_17_0 = var_0_2.BOOK

	if arg_17_0.sceneMode == OathConst.OATH_SCENE_MODE.SHARE then
		var_17_0 = var_0_2.SHARE
	end

	SDKTools.SendMessageToSDK("activity_combat_over", {
		sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM,
		hero_id = OathToLuaBridge:GetOathHeroID(),
		skin_id = OathToLuaBridge:GetUseOathCharacterID(),
		stage_id = var_17_0,
		result = var_0_1.EXIT,
		other_data = {}
	})
end

function var_0_0.OnEnter(arg_18_0)
	arg_18_0.sceneMode = arg_18_0.params_.sceneMode

	if arg_18_0.sceneMode == OathConst.OATH_SCENE_MODE.CAPTURE or arg_18_0.sceneMode == OathConst.OATH_SCENE_MODE.BOOK_RE then
		arg_18_0.photoDisplayView_:OnEnter()
		arg_18_0.photoDisplayView_:SetData(arg_18_0.sceneMode)

		if arg_18_0.sceneMode == OathConst.OATH_SCENE_MODE.BOOK_RE then
			arg_18_0.sharePanel_:OnEnter()
		end

		arg_18_0.sharePanel_:SetData(OathConst.OATH_SHARE_TYPE.BOOL_RE, OathToLuaBridge:GetOathHeroID())
	elseif arg_18_0.sceneMode == OathConst.OATH_SCENE_MODE.SHARE then
		arg_18_0.sharePanel_:OnEnter()
		arg_18_0.sharePanel_:SetData(OathConst.OATH_SHARE_TYPE.SHARE, OathToLuaBridge:GetOathHeroID())
	end

	arg_18_0:AddEventListeners()
end

function var_0_0.AddEventListeners(arg_19_0)
	arg_19_0:RegistEventListener(OATH_SCENE_LOAD_MODEL, handler(arg_19_0, arg_19_0.OnLoadModel))
end

function var_0_0.OnLoadModel(arg_20_0)
	local var_20_0 = OathToLuaBridge:GetCaptureSwitch(OathConst.OATH_CAPTURE_FILTER_TYPE.Action)

	OathToLuaBridge:SetCaptureSwitch(var_20_0)

	local var_20_1 = OathToLuaBridge:GetCaptureSwitch(OathConst.OATH_CAPTURE_FILTER_TYPE.Filter)

	OathToLuaBridge:SetCaptureSwitch(var_20_1)

	local var_20_2 = OathToLuaBridge:GetCaptureSwitch(OathConst.OATH_CAPTURE_FILTER_TYPE.Face)

	OathToLuaBridge:SetCaptureSwitch(var_20_2)
end

function var_0_0.OnTop(arg_21_0)
	arg_21_0:RefreshBar()
end

function var_0_0.RefreshBar(arg_22_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			content = GetTips("SNAKEGAME_GIVE_UP"),
			OkCallback = function()
				arg_22_0:OathExitSDK()
				OathToLuaBridge.OathExitScene()
			end
		})
	end)
end

function var_0_0.OnExit(arg_25_0)
	arg_25_0:RemoveAllEventListener()
	arg_25_0.photoDisplayView_:OnExit()
	arg_25_0.sharePanel_:OnExit()
end

function var_0_0.Dispose(arg_26_0)
	arg_26_0.photoDisplayView_:Dispose()

	arg_26_0.photoDisplayView_ = nil

	arg_26_0.sharePanel_:Dispose()

	arg_26_0.sharePanel_ = nil

	arg_26_0.super.Dispose(arg_26_0)
end

return var_0_0
