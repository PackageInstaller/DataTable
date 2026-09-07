local IslandFriendCodePage = class("IslandFriendCodePage", import("view.base.BaseSubView"))
local var_0_1 = 4

function IslandFriendCodePage:getUIName()
	return "IslandFirendCodeUI"
end

function IslandFriendCodePage:OnLoaded()
	self.enterBtn = self._tf:Find("frame/visit")
	self.saveBtn = self._tf:Find("frame/like")
	self.inputTr = self._tf:Find("frame/input")
	self.uiItemlist = UIItemList.New(self._tf:Find("frame/list"), self._tf:Find("frame/list/tpl"))
	self.tipTxt = self._tf:Find("frame/sub_title/Text"):GetComponent(typeof(Text))
	self.frequentlyUsedList = self:GetSaveCodeList()

	setText(self._tf:Find("frame/title/Text"), i18n("island_input_code_tip"))
	setText(self._tf:Find("frame/input/Text"), i18n("island_input_code_tip_1"))
	setText(self._tf:Find("frame/like/Text"), i18n("island_set_like"))
	setText(self._tf:Find("frame/visit/Text"), i18n("island_btn_label_visit"))

	return
end

function IslandFriendCodePage:OnInit()
	onButton(self, self.enterBtn, function()
		local var_4_0 = getInputText(self.inputTr)

		if not var_4_0 or var_4_0 == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_input_code_erro"))

			return
		end

		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandVisitByCode())
		self:emit(IslandMediator.ENTER_ISLAND_BY_CODE, var_4_0)

		return
	end, SFX_PANEL)
	onButton(self, self.saveBtn, function()
		self:AddCode()

		return
	end, SFX_PANEL)
	self:InitFrequentlyUsedList()

	return
end

function IslandFriendCodePage:GetSaveCodeList()
	local var_6_0 = PlayerPrefs.GetString("_ISLAND_CODE_" .. getProxy(PlayerProxy):getRawData().id, "")

	if var_6_0 == "" then
		return {}
	end

	return (string.split(var_6_0, "#"))
end

function IslandFriendCodePage:AddCode()
	if #self.frequentlyUsedList >= var_0_1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_visit_tip7"))

		return
	end

	local var_7_0 = getInputText(self.inputTr)

	if not var_7_0 or var_7_0 == "" then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_input_code_erro"))

		return
	end

	if table.contains(self.frequentlyUsedList, var_7_0) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_code_exist"))

		return
	end

	table.insert(self.frequentlyUsedList, var_7_0)
	self:InitFrequentlyUsedList()

	return
end

function IslandFriendCodePage:RemoveCode(arg_8_1)
	table.removebyvalue(self.frequentlyUsedList, arg_8_1)
	self:InitFrequentlyUsedList()

	return
end

function IslandFriendCodePage:SaveCodeList()
	local var_9_0 = PlayerPrefs.SetString("_ISLAND_CODE_" .. getProxy(PlayerProxy):getRawData().id, (table.concat(self.frequentlyUsedList, "#")))

	PlayerPrefs.Save()

	return
end

function IslandFriendCodePage:InitFrequentlyUsedList()
	self.uiItemlist:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			setActive(arg_11_2:Find("btns"), self.frequentlyUsedList[arg_11_1 + 1])
			setActive(arg_11_2:Find("empty"), not self.frequentlyUsedList[arg_11_1 + 1])

			if self.frequentlyUsedList[arg_11_1 + 1] then
				self:UpdateCodeTpl(arg_11_2:Find("btns"), self.frequentlyUsedList[arg_11_1 + 1])
			end
		end

		return
	end)
	self.uiItemlist:align(var_0_1)

	self.tipTxt.text = i18n("island_like_title") .. #self.frequentlyUsedList .. "/" .. var_0_1

	return
end

function IslandFriendCodePage:UpdateCodeTpl(arg_12_1, arg_12_2)
	setText(arg_12_1:Find("id/Text"), arg_12_2)
	onButton(self, arg_12_1:Find("copy"), function()
		UniPasteBoard.SetClipBoardString(arg_12_2)
		pg.TipsMgr.GetInstance():ShowTips(i18n("friend_id_copy_ok"))

		return
	end, SFX_PANEL)
	onButton(self, arg_12_1:Find("remove"), function()
		self:RemoveCode(arg_12_2)

		return
	end, SFX_PANEL)
	setText(arg_12_1:Find("remove/Text"), i18n("island_btn_label_remove"))
	setText(arg_12_1:Find("copy/Text"), i18n("island_btn_label_copy"))

	return
end

function IslandFriendCodePage:Hide()
	IslandFriendCodePage.super.Hide(self)
	self:SaveCodeList()

	return
end

function IslandFriendCodePage:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return IslandFriendCodePage
