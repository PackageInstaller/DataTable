local BackyardMsgBoxMgr = class("BackyardMsgBoxMgr")

function BackyardMsgBoxMgr:Init(arg_1_1, arg_1_2)
	self.view = arg_1_1
	self.loaded = false

	PoolMgr.GetInstance():GetUI("BackYardMsgBox", true, function(arg_2_0)
		if self.exited then
			return
		end

		setParent(arg_2_0, pg.UIMgr.GetInstance().UIMain)

		self._go = arg_2_0
		self._tf = arg_2_0.transform
		self.frame = findTF(self._tf, "msg")
		self.closeBtn = findTF(self._tf, "frame/close")
		self.context = findTF(self._tf, "msg/Text"):GetComponent(typeof(Text))
		self.cancelBtn = findTF(self._tf, "msg/btns/btn2")
		self.confirmBtn = findTF(self._tf, "msg/btns/btn1")
		self.helpPanel = findTF(self._tf, "help_panel")
		self._helpList = self.helpPanel:Find("list")

		setText(self._tf:Find("frame/title"), i18n("words_information"))
		setText(self.cancelBtn:Find("Text"), i18n("word_cancel"))
		setText(self.confirmBtn:Find("Text"), i18n("battle_result_confirm"))

		self.loaded = true

		setActive(self._tf, false)
		arg_1_2()

		return
	end)
	pg.DelegateInfo.New(self.view)

	return
end

function BackyardMsgBoxMgr:Show(arg_3_1)
	setActive(self.frame, true)
	setActive(self.helpPanel, false)

	if not self.loaded then
		return
	end

	self.isShowMsg = true
	self.context.text = arg_3_1.content
	self.onYes = arg_3_1.onYes
	self.onNo = arg_3_1.onNo

	self:Common(arg_3_1)

	return
end

function BackyardMsgBoxMgr:Common(arg_4_1)
	onButton(self.view, self.confirmBtn, function()
		if self.onYes then
			self.onYes()
		end

		self:Hide()

		return
	end, arg_4_1.yesSound or SFX_PANEL)
	onButton(self.view, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self.view, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self.view, self.cancelBtn, function()
		if self.onNo then
			self.onNo()
		end

		self:Hide()

		return
	end, SFX_PANEL)
	setActive(self.cancelBtn, not arg_4_1.hideNo)
	setActive(self._tf, true)
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	return
end

function BackyardMsgBoxMgr:ShowHelp(arg_9_1)
	setActive(self.frame, false)
	setActive(self.helpPanel, true)

	for iter_9_0 = #arg_9_1.helps, self._helpList.childCount - 1 do
		Destroy(self._helpList:GetChild(iter_9_0))
	end

	for iter_9_1 = self._helpList.childCount, #arg_9_1.helps - 1 do
		cloneTplTo(self._helpTpl, self._helpList)
	end

	for iter_9_2, iter_9_3 in ipairs(arg_9_1.helps) do
		local var_9_0 = self._helpList:GetChild(iter_9_2 - 1)

		setActive(var_9_0, true)
		setActive(var_9_0:Find("icon"), iter_9_3.icon)
		setActive(findTF(var_9_0, "line"), iter_9_3.line)

		local var_9_1 = var_9_0:Find("richText"):GetComponent("RichText")

		setText(var_9_0, HXSet.hxLan(iter_9_3.info and SwitchSpecialChar(iter_9_3.info, true) or ""))
	end

	self:Common(arg_9_1)

	return
end

function BackyardMsgBoxMgr:Hide()
	self.onYes = nil
	self.onNo = nil
	self.isShowMsg = false

	setActive(self._tf, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, pg.UIMgr.GetInstance().UIMain)

	return
end

function BackyardMsgBoxMgr:Destroy()
	self.exited = true

	if self.isShowMsg then
		self:Hide()
	end

	PoolMgr.GetInstance():ReturnUI("BackYardMsgBox", self._go)

	return
end

return BackyardMsgBoxMgr
