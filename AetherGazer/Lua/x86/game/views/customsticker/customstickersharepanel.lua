local var_0_0 = require("cjson")
local var_0_1 = class("CustomStickerSharePanel", ReduxView)

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.onClose_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_1.OnSnape(arg_2_0, arg_2_1)
	local var_2_0 = tonumber(SettingData:GetSettingData().pic.resolution)
	local var_2_1, var_2_2 = SettingTools.GetSettingScreenSize(var_2_0)

	if not SDKTools.IsSDK() then
		var_2_1, var_2_2 = _G.SCREEN_WIDTH, _G.SCREEN_HEIGHT
	end

	arg_2_0.screenSnapPath_ = manager.share:SaveTexture()
	arg_2_0.screenSnap_ = ScreenSnap.New(var_2_1, var_2_2)

	arg_2_0.screenSnap_:Take()

	local var_2_3 = arg_2_0.screenSnap_:GetSprite()

	arg_2_0.imageShot_.sprite = var_2_3

	arg_2_0.screenSnap_:SaveSnap(arg_2_0.screenSnapPath_)
	SetActive(arg_2_0.gameObject_, true)
end

function var_0_1.OnEnter(arg_3_0)
	if not SDKTools.GetIsOverSea() then
		SetActive(arg_3_0.buttonTwiiter_.transform.gameObject, false)

		if GameToSDK.PLATFORM_ID == 4 then
			SetActive(arg_3_0.buttonWechat_.transform.gameObject, false)
			SetActive(arg_3_0.buttonWeibo_.transform.gameObject, false)
			SetActive(arg_3_0.buttonQQ_.transform.gameObject, false)
			SetActive(arg_3_0.buttonQQZone_.transform.gameObject, false)
			SetActive(arg_3_0.buttonWechatMoments_.transform.gameObject, false)
		end
	else
		SetActive(arg_3_0.buttonQQ_.transform.gameObject, false)
		SetActive(arg_3_0.buttonQQZone_.transform.gameObject, false)
		SetActive(arg_3_0.buttonWechat_.transform.gameObject, false)
		SetActive(arg_3_0.buttonWeibo_.transform.gameObject, false)
		SetActive(arg_3_0.buttonWechatMoments_.transform.gameObject, false)
		SetActive(arg_3_0.buttonTwiiter_.transform.gameObject, true)
	end
end

function var_0_1.OnExit(arg_4_0)
	arg_4_0.screenSnap_ = nil
end

function var_0_1.Dispose(arg_5_0)
	var_0_1.super.Dispose(arg_5_0)
end

function var_0_1.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.buttonCancel_, nil, function()
		if arg_6_0.onClose_ then
			arg_6_0.onClose_()
		end

		SetActive(arg_6_0.gameObject_, false)
	end)
	arg_6_0:AddBtnListener(arg_6_0.buttonQQ_, nil, function()
		arg_6_0:Share("QQ")
	end)
	arg_6_0:AddBtnListener(arg_6_0.buttonQQZone_, nil, function()
		arg_6_0:Share("QZone")
	end)
	arg_6_0:AddBtnListener(arg_6_0.buttonWechat_, nil, function()
		arg_6_0:Share("Wechat")
	end)
	arg_6_0:AddBtnListener(arg_6_0.buttonWechatMoments_, nil, function()
		arg_6_0:Share("WechatMoments")
	end)
	arg_6_0:AddBtnListener(arg_6_0.buttonWeibo_, nil, function()
		arg_6_0:Share("SinaWeibo")
	end)
	arg_6_0:AddBtnListener(arg_6_0.buttonTwiiter_, nil, function()
		arg_6_0:Share(nil)
	end)
	arg_6_0:AddBtnListener(arg_6_0.buttonSave_, nil, function()
		if GameToSDK.IsEditorOrPcPlatform() then
			LuaForUtil.SaveScreenShot(arg_6_0.screenSnapPath_)
		else
			local var_14_0 = manager.share:SaveTexture()

			arg_6_0.screenSnap_:SaveSnap(var_14_0)
			LuaForUtil.SavePhotoToAlbum(var_14_0)
		end
	end)
end

function var_0_1.Share(arg_15_0, arg_15_1)
	if not SDKTools.IsSDK() then
		ShowTips("SHARE_PLATFORM")

		return
	end

	local var_15_0 = GetTips("SHARE_TITLE")
	local var_15_1 = GetTips("SHARE_CONTENT")
	local var_15_2 = GetTips("SHARE_URL")
	local var_15_3
	local var_15_4 = arg_15_1 == nil and "Share" or "ShareWithPlatform"
	local var_15_5 = {
		imageUrl = "",
		messageType = var_15_4,
		url = var_15_2,
		title = var_15_0,
		content = var_15_1,
		imagePath = arg_15_0.screenSnapPath_,
		platform = arg_15_1
	}

	arg_15_0.paltform_ = arg_15_1

	local var_15_6 = var_0_0.encode(var_15_5)

	SendMessageToSDK(var_15_6)
end

return var_0_1
