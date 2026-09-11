HeroDisplayShareView = import("game.views.heroDisplay.HeroDisplayShareView")

local OathShareView = class("OathShareView", HeroDisplayShareView)

function OathShareView:SendToSDK(arg_1_1)
	SDKTools.SendMessageToSDK("screenshot", {
		screenshot_oper = 1,
		sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM,
		hero_id = self.hero_id,
		type = self.oath_type,
		share_channel = arg_1_1
	})
end

function OathShareView:SendSaveSDK()
	SDKTools.SendMessageToSDK("screenshot", {
		screenshot_oper = 2,
		sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM,
		hero_id = self.hero_id,
		type = self.oath_type
	})
end

function OathShareView:SetData(arg_3_1, arg_3_2)
	self.oath_type = arg_3_1
	self.hero_id = arg_3_2
end

function OathShareView:OnSnape(arg_4_1)
	OathShareView.super.OnSnape(self, arg_4_1)
	self.animator_:Play("T0_108502_Capture_Result", 0, 0)
end

function OathShareView:OnBookShareSnape(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.screenSnap_ = ScreenSnap.New(Screen.width, Screen.height)

	self.screenSnap_:Take()

	local var_5_0 = self.screenSnap_:GetSprite()
	local var_5_1 = UnityEngine.Texture2D.New(arg_5_3, arg_5_4)

	UnityEngine.Texture2D.SetPixels(var_5_1, (UnityEngine.Texture2D.GetPixels(var_5_0.texture, arg_5_1, arg_5_2, arg_5_3, arg_5_4)))
	UnityEngine.Texture2D.Apply(var_5_1)

	local var_5_2 = UnityEngine.Sprite.Create(var_5_0.texture, UnityEngine.Rect.New(arg_5_1, arg_5_2, arg_5_3, arg_5_4), Vector2.one / 2, 100, 1, UnityEngine.SpriteMeshType.FullRect)

	if GameToSDK.IsPCPlatform() then
		SetActive(self.imageShotGo_, false)
		SetActive(self.imageShotGoPc_, true)

		self.imageShotPc_.sprite = var_5_2
	else
		SetActive(self.imageShotGo_, true)
		SetActive(self.imageShotGoPc_, false)

		self.imageShot_.sprite = var_5_2
	end

	self.imageBg_.sprite = var_5_2
	self.screenSnapPath_ = manager.share:SaveTexture(var_5_2.texture)

	SetActive(self.gameObject_, true)
	self.animator_:Play("T0_108502_Capture_Result", 0, 0)
end

function OathShareView:AddListeners()
	self:AddBtnListener(self.buttonCancel_, nil, function()
		self:ExitPanel()
	end)
	self:AddBtnListener(self.buttonQQ_, nil, function()
		self:Share("QQ")
	end)
	self:AddBtnListener(self.buttonQQZone_, nil, function()
		self:Share("QZone")
	end)
	self:AddBtnListener(self.buttonWechat_, nil, function()
		self:Share("Wechat")
	end)
	self:AddBtnListener(self.buttonWechatMoments_, nil, function()
		self:Share("WechatMoments")
	end)
	self:AddBtnListener(self.buttonWeibo_, nil, function()
		self:Share("SinaWeibo")
	end)
	self:AddBtnListener(self.buttonTwiiter_, nil, function()
		self:Share(nil)
	end)
	self:AddBtnListener(self.buttonSave_, nil, function()
		if GameToSDK.IsEditorOrPcPlatform() then
			LuaForUtil.SaveScreenShot(self.screenSnapPath_)
		else
			local var_14_0 = manager.share:SaveTexture()

			self.screenSnap_:SaveSnap(var_14_0)
			LuaForUtil.SavePhotoToAlbum(var_14_0)
		end

		self:SendSaveSDK()
	end)
	self:AddBtnListener(self.buttonPath_, nil, function()
		if GameToSDK.IsEditorOrPcPlatform() then
			LuaForUtil.OpenScreenShotFolder()
		end
	end)
end

return OathShareView
