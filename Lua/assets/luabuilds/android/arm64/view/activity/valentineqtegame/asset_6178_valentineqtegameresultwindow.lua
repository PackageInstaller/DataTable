local ValentineQteGameResultWindow = class("ValentineQteGameResultWindow")

function ValentineQteGameResultWindow:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self._tf = arg_1_1
	self._parentTf = arg_1_1.parent
	self.backBtn = arg_1_1:Find("back")
	self.shareBtn = arg_1_1:Find("share")
	self.scoreTxt = arg_1_1:Find("frame/score/Text"):GetComponent(typeof(Text))
	self.perfectTxt = arg_1_1:Find("frame/content/Perfect/value/Text"):GetComponent(typeof(Text))
	self.greatTxt = arg_1_1:Find("frame/content/Great/value/Text"):GetComponent(typeof(Text))
	self.goodTxt = arg_1_1:Find("frame/content/Good/value/Text"):GetComponent(typeof(Text))
	self.missTxt = arg_1_1:Find("frame/content/Miss/value/Text"):GetComponent(typeof(Text))
	self.comboTxt = arg_1_1:Find("frame/content/Combo/value/Text"):GetComponent(typeof(Text))
	self.chatTxt = arg_1_1:Find("chat/Text"):GetComponent(typeof(Text))
	self.nameTxt = arg_1_1:Find("frame/Text"):GetComponent(typeof(Text))

	self:Init()
	setText(arg_1_1:Find("frame/score/label"), i18n("Valentine_minigame_label1"))

	self.nameTxt.text = getProxy(PlayerProxy):getRawData():GetName()

	setActive(self.nameTxt.gameObject, false)

	return
end

function ValentineQteGameResultWindow:Init()
	onButton(self, self.backBtn, function()
		if self.callback then
			self.callback()
		end

		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.shareBtn, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeValentineQte)

		return
	end, SFX_PANEL)

	return
end

function ValentineQteGameResultWindow:Show(arg_5_1, arg_5_2)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.statistics = arg_5_1
	self.callback = arg_5_2

	setActive(self._tf, true)
	self:Flush()

	return
end

function ValentineQteGameResultWindow:Flush()
	self.scoreTxt.text = self.statistics.Score
	self.perfectTxt.text = self.statistics.Perfect
	self.greatTxt.text = self.statistics.Great
	self.goodTxt.text = self.statistics.Good
	self.missTxt.text = self.statistics.Miss
	self.comboTxt.text = self.statistics.Combo
	self.chatTxt.text = self:GetChatTxt(self.statistics.Score)

	return
end

function ValentineQteGameResultWindow:GetChatTxt(arg_7_1)
	local var_7_0

	for iter_7_0, iter_7_1 in ipairs(ValentineQteGameConst.CHAT_CONTENT) do
		if iter_7_1[1] <= arg_7_1 and arg_7_1 <= iter_7_1[2] then
			var_7_0 = iter_7_1[3]

			break
		end
	end

	if var_7_0 then
		return i18n("2025Valentine_minigame_" .. var_7_0)
	else
		return ""
	end

	return
end

function ValentineQteGameResultWindow:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	self.callback = nil

	setActive(self._tf, false)

	return
end

function ValentineQteGameResultWindow:Destroy()
	self:Hide()
	pg.DelegateInfo.Dispose(self)

	return
end

return ValentineQteGameResultWindow
