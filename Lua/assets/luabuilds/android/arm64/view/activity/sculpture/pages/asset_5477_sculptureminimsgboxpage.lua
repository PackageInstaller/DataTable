local SculptureMiniMsgBoxPage = class("SculptureMiniMsgBoxPage", import("view.base.BaseSubView"))

function SculptureMiniMsgBoxPage:getUIName()
	return "SculptureMiniMsgBoxUI"
end

function SculptureMiniMsgBoxPage:OnLoaded()
	self.contentTxt = self._tf:Find("frame/Text"):GetComponent(typeof(Text))
	self.confirmBtn = self._tf:Find("frame/btns/btn_confrim")
	self.btnImg = self.confirmBtn:GetComponent(typeof(Image))
	self.cancelBtn = self._tf:Find("frame/btns/btn_cancel")

	return
end

function SculptureMiniMsgBoxPage:OnInit()
	onButton(self, self.confirmBtn, function()
		self:Hide()

		if self.settings.onYes then
			self.settings.onYes()
		end

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		if self.settings.model then
			return
		end

		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		if self.settings.model then
			return
		end

		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function SculptureMiniMsgBoxPage:Show(arg_7_1)
	SculptureMiniMsgBoxPage.super.Show(self)

	self.settings = arg_7_1
	self.contentTxt.text = HXSet.hxLan(arg_7_1.content)

	SetParent(self._tf, pg.UIMgr.GetInstance().OverlayMain)

	self.btnImg.sprite = GetSpriteFromAtlas("ui/SculptureUI_atlas", arg_7_1.yes_text or "btn_confrim")

	if arg_7_1.effect then
		self:LoadEffect()
	end

	setActive(self.cancelBtn, arg_7_1.showNo)

	return
end

function SculptureMiniMsgBoxPage:Hide()
	SculptureMiniMsgBoxPage.super.Hide(self)

	if self.effectGo then
		Object.Destroy(self.effectGo)

		self.effectGo = nil
	end

	return
end

function SculptureMiniMsgBoxPage:LoadEffect()
	local var_9_0 = "liwucaijian_caidai"

	if not self.effectGo then
		ResourceMgr.Inst:getAssetAsync("ui/" .. "liwucaijian_caidai", "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_10_0)
			if self.exited then
				return
			end

			self.effectGo = Object.Instantiate(arg_10_0, self._tf)
			self.effectGo.name = var_9_0

			return
		end), true, true)
	else
		setActive(self.effectGo, false)
		setActive(self.effectGo, true)
	end

	return
end

function SculptureMiniMsgBoxPage:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return SculptureMiniMsgBoxPage
