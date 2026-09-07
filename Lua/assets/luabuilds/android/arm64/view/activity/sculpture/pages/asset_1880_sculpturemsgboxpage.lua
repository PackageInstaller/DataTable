local SculptureMsgBoxPage = class("SculptureMsgBoxPage", import("view.base.BaseSubView"))

function SculptureMsgBoxPage:getUIName()
	return "SculptureMsgboxUI"
end

function SculptureMsgBoxPage:OnLoaded()
	self.contentTxt = self._tf:Find("frame/Text"):GetComponent(typeof(Text))
	self.nextBtn = self._tf:Find("frame/btn")
	self.confirmBtn = self._tf:Find("frame/btn_confrim")
	self.consumeTr = self._tf:Find("frame/consume")
	self.consumeTxt = self._tf:Find("frame/consume/Text"):GetComponent(typeof(Text))
	self.consumeIcon = self._tf:Find("frame/consume/icon"):GetComponent(typeof(Image))
	self.role = self._tf:Find("frame/role"):GetComponent(typeof(Image))
	self.title = self._tf:Find("frame/title/Text"):GetComponent(typeof(Image))

	setText(self._tf:Find("frame/tip"), i18n("sculpture_close_tip"))

	return
end

function SculptureMsgBoxPage:OnInit()
	onButton(self, self.confirmBtn, function()
		if self.settings.onYes then
			self.settings.onYes()
		end

		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.nextBtn, function()
		if self.settings.onYes then
			self.settings.onYes()
		end

		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function SculptureMsgBoxPage:Show(arg_7_1)
	SculptureMsgBoxPage.super.Show(self)

	self.settings = arg_7_1
	self.contentTxt.text = HXSet.hxLan(arg_7_1.content)

	setActive(self.consumeTr, arg_7_1.consume)

	if arg_7_1.consume then
		self.consumeTxt.text = arg_7_1.consume
		self.consumeIcon.sprite = LoadSprite("props/" .. pg.activity_workbench_item[arg_7_1.consumeId].icon)
		rtf(self.consumeIcon.gameObject).sizeDelta = Vector2(60, 60)
	else
		rtf(self.consumeIcon.gameObject).sizeDelta = Vector2(0, 0)
	end

	if arg_7_1.iconName then
		self:LoadChar(arg_7_1.iconName)
	else
		self:ClearChar()
	end

	self.title.sprite = arg_7_1.title and GetSpriteFromAtlas("ui/SculptureUI_atlas", arg_7_1.title) or GetSpriteFromAtlas("ui/SculptureUI_atlas", "item_title")

	self.title:SetNativeSize()
	setActive(self.nextBtn, arg_7_1.nextBtn)
	setActive(self.confirmBtn, not arg_7_1.nextBtn)

	return
end

function SculptureMsgBoxPage:LoadChar(arg_8_1)
	if self.charName == arg_8_1 then
		return
	end

	self:ClearChar()
	PoolMgr.GetInstance():GetSpineChar("takegift_" .. arg_8_1, true, function(arg_9_0)
		arg_9_0.transform:SetParent(self.role.gameObject.transform.parent)

		arg_9_0.transform.localScale = Vector3(0.8, 0.8, 0)
		arg_9_0.transform.localPosition = Vector3(550, -300, 0)

		arg_9_0:GetComponent(typeof(SpineAnimUI)):SetAction("gift_wait_" .. arg_8_1, 0)

		self.charGo = arg_9_0

		return
	end)

	self.charName = arg_8_1

	return
end

function SculptureMsgBoxPage:ClearChar()
	if self.charName and self.charGo then
		PoolMgr.GetInstance():ReturnSpineChar(self.charName, self.charGo)

		self.charName = nil
		self.charGo = nil
	end

	return
end

function SculptureMsgBoxPage:OnDestroy()
	self:ClearChar()

	return
end

return SculptureMsgBoxPage
