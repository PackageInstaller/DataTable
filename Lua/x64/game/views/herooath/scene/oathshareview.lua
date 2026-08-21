HeroDisplayShareView = import("game.views.heroDisplay.HeroDisplayShareView")

local var_0_0 = class("OathShareView", HeroDisplayShareView)

function var_0_0.SendToSDK(arg_1_0, arg_1_1)
	SDKTools.SendMessageToSDK("screenshot", {
		screenshot_oper = 1,
		sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM,
		hero_id = arg_1_0.hero_id,
		type = arg_1_0.oath_type,
		share_channel = arg_1_1
	})
end

function var_0_0.SendSaveSDK(arg_2_0)
	SDKTools.SendMessageToSDK("screenshot", {
		screenshot_oper = 2,
		sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM,
		hero_id = arg_2_0.hero_id,
		type = arg_2_0.oath_type
	})
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.oath_type = arg_3_1
	arg_3_0.hero_id = arg_3_2
end

function var_0_0.OnSnape(arg_4_0, arg_4_1)
	var_0_0.super.OnSnape(arg_4_0, arg_4_1)
	arg_4_0.animator_:Play("T0_108502_Capture_Result", 0, 0)
end

function var_0_0.OnBookShareSnape(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = Screen.width
	local var_5_1 = Screen.height

	arg_5_0.screenSnap_ = ScreenSnap.New(var_5_0, var_5_1)

	arg_5_0.screenSnap_:Take()

	local var_5_2 = arg_5_0.screenSnap_:GetSprite()
	local var_5_3 = UnityEngine.Texture2D.New(arg_5_3, arg_5_4)
	local var_5_4 = UnityEngine.Texture2D.GetPixels(var_5_2.texture, arg_5_1, arg_5_2, arg_5_3, arg_5_4)

	UnityEngine.Texture2D.SetPixels(var_5_3, var_5_4)
	UnityEngine.Texture2D.Apply(var_5_3)

	local var_5_5 = UnityEngine.Sprite.Create(var_5_2.texture, UnityEngine.Rect.New(arg_5_1, arg_5_2, arg_5_3, arg_5_4), Vector2.one / 2, 100, 1, UnityEngine.SpriteMeshType.FullRect)

	if GameToSDK.IsPCPlatform() then
		SetActive(arg_5_0.imageShotGo_, false)
		SetActive(arg_5_0.imageShotGoPc_, true)

		arg_5_0.imageShotPc_.sprite = var_5_5
	else
		SetActive(arg_5_0.imageShotGo_, true)
		SetActive(arg_5_0.imageShotGoPc_, false)

		arg_5_0.imageShot_.sprite = var_5_5
	end

	arg_5_0.imageBg_.sprite = var_5_5

	local var_5_6 = var_5_5.texture

	arg_5_0.screenSnapPath_ = manager.share:SaveTexture(var_5_6)

	SetActive(arg_5_0.gameObject_, true)
	arg_5_0.animator_:Play("T0_108502_Capture_Result", 0, 0)
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.buttonCancel_, nil, function()
		arg_6_0:ExitPanel()
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

		arg_6_0:SendSaveSDK()
	end)
	arg_6_0:AddBtnListener(arg_6_0.buttonPath_, nil, function()
		if GameToSDK.IsEditorOrPcPlatform() then
			LuaForUtil.OpenScreenShotFolder()
		end
	end)
end

return var_0_0
