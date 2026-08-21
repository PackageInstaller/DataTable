local var_0_0 = require("cjson")
local var_0_1 = class("HeroDisplayShareView", ReduxView)

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.shareCallbackHandler_ = handler(arg_1_0, arg_1_0.ShareCallback)
end

function var_0_1.SetData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.heroId_ = arg_2_1
	arg_2_0.showWeapon_ = arg_2_2
	arg_2_0.posIndex_ = arg_2_3
end

function var_0_1.OnSnape(arg_3_0, arg_3_1)
	local var_3_0

	if GameToSDK.PLATFORM_ID == 3 then
		-- block empty
	else
		var_3_0 = tonumber(SettingData:GetSettingData().pic.resolution)
	end

	local var_3_1, var_3_2 = SettingTools.GetSettingScreenSize(var_3_0)

	if not SDKTools.IsSDK() then
		var_3_1, var_3_2 = _G.SCREEN_WIDTH, _G.SCREEN_HEIGHT
	end

	if arg_3_1 then
		arg_3_0.screenSnap_ = ScreenSnap.New(var_3_1, var_3_2)
	else
		arg_3_0.screenSnap_ = ScreenSnap.New(var_3_2, var_3_1)
	end

	arg_3_0.screenSnap_:Take()

	local var_3_3 = arg_3_0.screenSnap_:GetSprite()

	if GameToSDK.IsPCPlatform() then
		SetActive(arg_3_0.imageShotGo_, false)
		SetActive(arg_3_0.imageShotGoPc_, true)

		arg_3_0.imageShotPc_.sprite = var_3_3
	else
		SetActive(arg_3_0.imageShotGo_, true)
		SetActive(arg_3_0.imageShotGoPc_, false)

		arg_3_0.imageShot_.sprite = var_3_3
	end

	arg_3_0.imageBg_.sprite = var_3_3
	arg_3_0.screenSnapPath_ = manager.share:SaveTexture()

	arg_3_0.screenSnap_:SaveSnap(arg_3_0.screenSnapPath_)
	SetActive(arg_3_0.gameObject_, true)
end

function var_0_1.OnEnter(arg_4_0)
	print("分享功能差异化")

	if not SDKTools.GetIsOverSea() then
		SetActive(arg_4_0.buttonTwiiter_.transform.gameObject, false)

		if GameToSDK.PLATFORM_ID == 4 then
			SetActive(arg_4_0.buttonWechat_.transform.gameObject, false)
			SetActive(arg_4_0.buttonWeibo_.transform.gameObject, false)
			SetActive(arg_4_0.buttonQQ_.transform.gameObject, false)
			SetActive(arg_4_0.buttonQQZone_.transform.gameObject, false)
			SetActive(arg_4_0.buttonWechatMoments_.transform.gameObject, false)
		end
	else
		SetActive(arg_4_0.buttonQQ_.transform.gameObject, false)
		SetActive(arg_4_0.buttonQQZone_.transform.gameObject, false)
		SetActive(arg_4_0.buttonWechat_.transform.gameObject, false)
		SetActive(arg_4_0.buttonWeibo_.transform.gameObject, false)
		SetActive(arg_4_0.buttonWechatMoments_.transform.gameObject, false)
		SetActive(arg_4_0.buttonTwiiter_.transform.gameObject, true)
	end

	SetActive(arg_4_0.buttonPath_.transform.gameObject, GameToSDK.IsEditorOrPcPlatform())
	manager.notify:RegistListener(SHARE_CALLBACK, arg_4_0.shareCallbackHandler_)
end

function var_0_1.OnExit(arg_5_0)
	manager.notify:RemoveListener(SHARE_CALLBACK, arg_5_0.shareCallbackHandler_)

	arg_5_0.screenSnap_ = nil
end

function var_0_1.ExitPanel(arg_6_0)
	if arg_6_0.exitViewFunc then
		arg_6_0.exitViewFunc()
	end

	SetActive(arg_6_0.gameObject_, false)
end

function var_0_1.Dispose(arg_7_0)
	var_0_1.super.Dispose(arg_7_0)

	arg_7_0.shareCallbackHandler_ = nil
end

function var_0_1.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.buttonCancel_, nil, function()
		arg_8_0:ExitPanel()
	end)
	arg_8_0:AddBtnListener(arg_8_0.buttonQQ_, nil, function()
		arg_8_0:Share("QQ")
	end)
	arg_8_0:AddBtnListener(arg_8_0.buttonQQZone_, nil, function()
		arg_8_0:Share("QZone")
	end)
	arg_8_0:AddBtnListener(arg_8_0.buttonWechat_, nil, function()
		arg_8_0:Share("Wechat")
	end)
	arg_8_0:AddBtnListener(arg_8_0.buttonWechatMoments_, nil, function()
		arg_8_0:Share("WechatMoments")
	end)
	arg_8_0:AddBtnListener(arg_8_0.buttonWeibo_, nil, function()
		arg_8_0:Share("SinaWeibo")
	end)
	arg_8_0:AddBtnListener(arg_8_0.buttonTwiiter_, nil, function()
		arg_8_0:Share(nil)
	end)
	arg_8_0:AddBtnListener(arg_8_0.buttonSave_, nil, function()
		if GameToSDK.IsEditorOrPcPlatform() then
			LuaForUtil.SaveScreenShot(arg_8_0.screenSnapPath_)
		else
			local var_16_0 = manager.share:SaveTexture()

			arg_8_0.screenSnap_:SaveSnap(var_16_0)
			LuaForUtil.SavePhotoToAlbum(var_16_0)
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.buttonPath_, nil, function()
		if GameToSDK.IsEditorOrPcPlatform() then
			LuaForUtil.OpenScreenShotFolder()
		end
	end)
end

function var_0_1.Share(arg_18_0, arg_18_1)
	if GameToSDK.IsEditorOrPcPlatform() then
		ShowTips("SHARE_PLATFORM")

		return
	end

	local var_18_0 = GetTips("SHARE_TITLE")
	local var_18_1 = GetTips("SHARE_CONTENT")
	local var_18_2 = GetTips("SHARE_URL")
	local var_18_3
	local var_18_4 = arg_18_1 == nil and "Share" or "ShareWithPlatform"
	local var_18_5 = {
		imageUrl = "",
		messageType = var_18_4,
		url = var_18_2,
		title = var_18_0,
		content = var_18_1,
		imagePath = arg_18_0.screenSnapPath_,
		platform = arg_18_1
	}

	arg_18_0.paltform_ = arg_18_1

	local var_18_6 = var_0_0.encode(var_18_5)

	SendMessageToSDK(var_18_6)
end

function var_0_1.ShareCallback(arg_19_0, arg_19_1)
	if arg_19_1 == 0 then
		arg_19_0:SendToSDK(arg_19_0.paltform_)
	elseif arg_19_1 == 2 then
		-- block empty
	end
end

function var_0_1.SendToSDK(arg_20_0, arg_20_1)
	if arg_20_0.heroId_ then
		local var_20_0 = HeroDisplayData:GetHeroPoseList(arg_20_0.heroId_)[arg_20_0.posIndex_]
		local var_20_1 = 0

		if arg_20_0.showWeapon_ and var_20_0.weaponState ~= HeroDisplayConst.WEAPON_STATE.HIDE_WEAPON then
			var_20_1 = 1
		end

		SDKTools.SendMessageToSDK("screenshot", {
			screenshot_oper = 2,
			hero_id = arg_20_0.heroId_,
			weapon_on = var_20_1,
			posture_id = arg_20_0.posIndex_,
			logo_location = HeroDisplayData.settingProfile_.logoPos == 0 and 2 or HeroDisplayData.settingProfile_.logoPos,
			card_show = HeroDisplayData.settingProfile_.cardShow and 1 or 0,
			card_location = HeroDisplayData.settingProfile_.cardPos == 0 and 1 or HeroDisplayData.settingProfile_.cardPos,
			lv_show = HeroDisplayData.settingProfile_.cardShowLv and 1 or 0,
			uid_show = HeroDisplayData.settingProfile_.cardShowUID and 1 or 0,
			share_channel = SDKTools.PlatformStrToId(arg_20_1)
		})
	end
end

function var_0_1.ExitViewCallBack(arg_21_0, arg_21_1)
	if arg_21_1 then
		arg_21_0.exitViewFunc = arg_21_1
	end
end

return var_0_1
