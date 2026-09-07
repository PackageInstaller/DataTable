local NewEducateSiteHandler = class("NewEducateSiteHandler")

NewEducateSiteHandler.TPL_TYPE = {
	TEXT = 2,
	DROP = 4,
	CONDITION = 1,
	ARROWS = 5,
	OPTION = 3
}

function NewEducateSiteHandler:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.windowTF = self._tf:Find("window")
	self.titleTF = self.windowTF:Find("title/Text")
	self.closeBtn = self.windowTF:Find("close_btn")

	setActive(self.closeBtn, false)

	self.endOptionsTF = self.windowTF:Find("end_options")
	self.endBtn = self.endOptionsTF:Find("end_btn")

	setScrollText(self.endBtn:Find("mask/Text"), i18n("child2_site_exit"))
	setActive(self.endOptionsTF, false)

	self.againBtn = self.endOptionsTF:Find("again_btn")

	setScrollText(self.againBtn:Find("mask/Text"), i18n("child2_site_again"))

	self.closeBtn2 = self._tf:Find("close")

	setActive(self.closeBtn2, false)

	self.scrollrect = self.windowTF:Find("content/view")
	self.contentTF = self.scrollrect:Find("mask/content")
	self.optionsTF = self.windowTF:Find("content/options")
	self.optionUIList = UIItemList.New(self.optionsTF, self.optionsTF:Find("tpl"))

	self.optionUIList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			self:UpdateOption(arg_2_1, arg_2_2)
		end

		return
	end)

	self.tpls = {
		[NewEducateSiteHandler.TPL_TYPE.CONDITION] = self._tf:Find("window/tpls/tpl_condition"),
		[NewEducateSiteHandler.TPL_TYPE.TEXT] = self._tf:Find("window/tpls/tpl_text"),
		[NewEducateSiteHandler.TPL_TYPE.OPTION] = self._tf:Find("window/tpls/tpl_option"),
		[NewEducateSiteHandler.TPL_TYPE.DROP] = self._tf:Find("window/tpls/tpl_drop"),
		[NewEducateSiteHandler.TPL_TYPE.ARROWS] = self._tf:Find("window/tpls/tpl_arrows")
	}
	self.imageColorTFs = {
		self.windowTF:Find("title"),
		self.windowTF:Find("line"),
		self.tpls[NewEducateSiteHandler.TPL_TYPE.TEXT]:Find("name_container/left/Image"),
		self.tpls[NewEducateSiteHandler.TPL_TYPE.TEXT]:Find("name_container/right/Image")
	}
	self.textColorTFs = {
		self.tpls[NewEducateSiteHandler.TPL_TYPE.TEXT]:Find("name_container/left"),
		self.tpls[NewEducateSiteHandler.TPL_TYPE.TEXT]:Find("name_container/right"),
		self.tpls[NewEducateSiteHandler.TPL_TYPE.OPTION]:Find("text"),
		self.tpls[NewEducateSiteHandler.TPL_TYPE.DROP]:Find("tpl/content/value")
	}
	self.charName = getProxy(NewEducateProxy):GetCurChar():getConfig("name")
	self.playerName = getProxy(PlayerProxy):getRawData():GetName()
	self.passNodeIds = {}
	self.optionIds = {}
	self.dropRecords = {}
	self.speed = NewEducateConst.TYPEWRITE_SPEED

	return
end

function NewEducateSiteHandler:SetSite(arg_3_1)
	setActive(self._go, true)

	self.siteId = arg_3_1

	local var_3_0 = pg.child2_site_display[arg_3_1]

	self.siteType = pg.child2_site_display[arg_3_1].type

	local var_3_1, var_3_2 = NewEducateHelper.GetSiteColors(self.siteId)

	underscore.each(self.imageColorTFs, function(arg_4_0)
		setImageColor(arg_4_0, var_3_1)

		return
	end)
	underscore.each(self.textColorTFs, function(arg_5_0)
		setTextColor(arg_5_0, var_3_2)

		return
	end)
	setText(self.titleTF, pg.child2_site_display[arg_3_1].title)

	local var_3_3 = getProxy(NewEducateProxy):GetCurChar()

	switch(self.siteType, {
		[NewEducateConst.SITE_TYPE.WORK] = function()
			existCall(self.onNormal)
			setActive(self._tf, false)

			local var_6_0 = pg.child2_site_normal[var_3_3:GetNormalIdByType(NewEducateConst.SITE_NORMAL_TYPE.WORK)]

			self:AddConditions(var_3_3, var_6_0)
			self:AddEnterOption(var_6_0.title)

			return
		end,
		[NewEducateConst.SITE_TYPE.TRAVEL] = function()
			existCall(self.onNormal)
			setActive(self._tf, false)

			local var_7_0 = pg.child2_site_normal[var_3_3:GetNormalIdByType(NewEducateConst.SITE_NORMAL_TYPE.TRAVEL)]

			self:AddConditions(var_3_3, var_7_0)
			self:AddEnterOption(var_7_0.title)

			return
		end,
		[NewEducateConst.SITE_TYPE.SHIP] = function()
			return
		end,
		[NewEducateConst.SITE_TYPE.EVENT] = function()
			setText(self.titleTF, pg.child2_site_event_group[var_3_0.param].event_title)

			return
		end
	})

	return
end

function NewEducateSiteHandler:AddConditions(arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1:GetConditionIdsFromComplex(arg_10_2.special_args)

	if not var_10_0 or #var_10_0 == 0 then
		return
	end

	local var_10_1 = cloneTplTo(self.tpls[NewEducateSiteHandler.TPL_TYPE.CONDITION], self.contentTF, self.siteId .. "Conditions")
	local var_10_2 = underscore.detect(var_10_0, function(arg_11_0)
		return pg.child2_condition[arg_11_0].type == NewEducateConst.CONDITION_TYPE.NORMAL_SITE_CNT
	end)

	if var_10_2 and not arg_10_1:IsMatchCondition(var_10_2) then
		local var_10_3 = pg.child2_condition[var_10_2].param[3] - arg_10_1:GetNormalCnt(arg_10_2.id)

		if pg.child2_condition[var_10_2].param[1] == ">" then
			var_10_3 = var_10_3 + 1
		end

		setText(var_10_1:Find("count"), i18n("child2_unlock_site_cnt", var_10_3))
	end

	setActive(var_10_1:Find("count"), var_10_2)

	local var_10_4 = underscore.detect(var_10_0, function(arg_12_0)
		return pg.child2_condition[arg_12_0].type == NewEducateConst.CONDITION_TYPE.ROUND
	end)

	if var_10_4 and not arg_10_1:IsMatchCondition(var_10_4) then
		local var_10_5 = pg.child2_condition[var_10_4].param[2] - arg_10_1:GetRoundData().round

		if pg.child2_condition[var_10_4].param[1] == ">" then
			var_10_5 = var_10_5 + 1
		end

		setText(var_10_1:Find("round"), i18n("child2_unlock_site_round", var_10_5))
	end

	setActive(var_10_1:Find("round"), var_10_4)

	local var_10_6 = underscore.select(var_10_0, function(arg_13_0)
		return pg.child2_condition[arg_13_0].type == NewEducateConst.CONDITION_TYPE.DROP and pg.child2_condition[arg_13_0].param[1] == NewEducateConst.DROP_TYPE.ATTR and not arg_10_1:IsMatchCondition(arg_13_0)
	end) or {}

	if #var_10_6 > 0 then
		setText(var_10_1:Find("attrs/text"), i18n("child2_unlock_site_attr"))

		local var_10_7 = var_10_1:Find("attrs/content")
		local var_10_8 = UIItemList.New(var_10_7, var_10_7:Find("tpl"))

		var_10_8:make(function(arg_14_0, arg_14_1, arg_14_2)
			if arg_14_0 == UIItemList.EventUpdate then
				local var_14_0 = pg.child2_condition[var_10_6[arg_14_1 + 1]].param[4]

				LoadImageSpriteAsync("neweducateicon/" .. pg.child2_attr[pg.child2_condition[var_10_6[arg_14_1 + 1]].param[2]].icon, arg_14_2:Find("icon_bg/icon"))
				setText(arg_14_2:Find("name"), pg.child2_attr[pg.child2_condition[var_10_6[arg_14_1 + 1]].param[2]].name)

				local var_14_1 = arg_10_1:GetAttr(pg.child2_condition[var_10_6[arg_14_1 + 1]].param[2])

				setText(arg_14_2:Find("value"), (var_14_1 < var_14_0 and setColorStr(var_14_1, "#a9a9b0") or var_14_1) .. "/" .. var_14_0)
			end

			return
		end)
		var_10_8:align(#var_10_6)
	end

	setActive(var_10_1:Find("attrs"), #var_10_6 > 0)

	return
end

function NewEducateSiteHandler:AddEnterOption(arg_15_1)
	local var_15_0 = cloneTplTo(self.tpls[NewEducateSiteHandler.TPL_TYPE.OPTION], self.contentTF, self.siteId .. "_EnterOption")

	setText(var_15_0:Find("name_container/name"), self.charName)
	setText(var_15_0:Find("text"), ">>" .. arg_15_1)

	return
end

function NewEducateSiteHandler:AddEnterText(arg_16_1, arg_16_2)
	local var_16_0 = cloneTplTo(self.tpls[NewEducateSiteHandler.TPL_TYPE.TEXT], self.contentTF, self.siteId .. "_EnterText")

	setActive(var_16_0:Find("name_container"), true)
	setActive(var_16_0:Find("name_container/left"), true)
	setActive(var_16_0:Find("name_container/right"), false)
	setText(var_16_0:Find("name_container/left"), arg_16_1)
	setText(var_16_0:Find("text"), arg_16_2)

	return
end

function NewEducateSiteHandler:Play(arg_17_1, arg_17_2, arg_17_3)
	self.callName = self.callName or getProxy(NewEducateProxy):GetCurChar():GetCallName()

	local function var_17_0(...)
		existCall(arg_17_2(...))
		scrollTo(self.scrollrect, 0, 0)

		return
	end

	table.insert(self.passNodeIds, arg_17_1)

	local var_17_1 = pg.child2_node[arg_17_1]

	switch(pg.child2_node[arg_17_1].type, {
		[NewEducateNodePanel.NODE_TYPE.EVENT_TEXT] = function()
			self:AddText(var_17_1, var_17_0)

			return
		end,
		[NewEducateNodePanel.NODE_TYPE.EVENT_OPTION] = function()
			self:AddOption(var_17_1, var_17_0)

			return
		end,
		[NewEducateNodePanel.NODE_TYPE.DROP] = function()
			self:AddDrops(arg_17_1, arg_17_3, var_17_0)

			return
		end
	})

	return
end

function NewEducateSiteHandler:_GetText(arg_22_1)
	return string.gsub(pg.child2_word[arg_22_1].word, "$1", self.callName)
end

function NewEducateSiteHandler:UpdateOption(arg_23_1, arg_23_2)
	local var_23_0 = self.optionIds[arg_23_1 + 1]

	arg_23_2.name = self.optionIds[arg_23_1 + 1]

	local var_23_1 = pg.child2_node[self.optionIds[arg_23_1 + 1]]

	setScrollText(arg_23_2:Find("mask/name"), self:_GetText(pg.child2_node[self.optionIds[arg_23_1 + 1]].text))

	local var_23_2 = getProxy(NewEducateProxy):GetCurChar()
	local var_23_3 = var_23_1.performance_param

	setActive(arg_23_2:Find("bg"), var_23_1.performance_param ~= "")

	if var_23_3 ~= "" then
		if var_23_3 == 3 then
			LoadImageSpriteAtlasAsync("ui/neweducatenodeui_atlas", "option_bg" .. var_23_3, arg_23_2:Find("bg"))
		else
			LoadImageSpriteAsync("neweducateicon/" .. var_23_2:GetPersonalityTagOptionBg(var_23_3), arg_23_2:Find("bg"))
		end
	end

	local var_23_4 = false

	if #var_23_1.option_condition > 0 then
		var_23_4 = not var_23_2:IsMatchComplex(var_23_1.option_condition)
	end

	setActive(arg_23_2:Find("cost"), #var_23_1.option_cost > 0)

	local var_23_5 = NewEducateHelper.Config2Drops(var_23_1.option_cost)

	if #var_23_5 > 0 then
		local var_23_6 = UIItemList.New(arg_23_2:Find("cost"), arg_23_2:Find("cost/tpl"))

		var_23_6:make(function(arg_24_0, arg_24_1, arg_24_2)
			if arg_24_0 == UIItemList.EventUpdate then
				LoadImageSpriteAsync("neweducateicon/" .. NewEducateHelper.GetDropConfig(var_23_5[arg_24_1 + 1]).icon, arg_24_2:Find("Image"))
				setText(arg_24_2:Find("Text"), "-" .. var_23_5[arg_24_1 + 1].number)
			end

			return
		end)
		var_23_6:align(#var_23_5)

		var_23_4 = var_23_4 or not var_23_2:IsMatchs((underscore.map(var_23_5, function(arg_25_0)
			arg_25_0.operator = ">="

			return arg_25_0
		end)))
	end

	setImageColor(arg_23_2, Color.NewHex(var_23_4 and "C8CAD5" or "FFFFFF"))
	setTextColor(arg_23_2:Find("mask/name"), Color.NewHex(var_23_4 and "717171" or "393A3C"))

	if not var_23_4 then
		onButton(self, arg_23_2, function()
			existCall(self.callback(var_23_0, var_23_5))

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_23_2)
	end

	return
end

function NewEducateSiteHandler:AddText(arg_27_1, arg_27_2)
	self.speed = NewEducateConst.TYPEWRITE_SPEED

	local var_27_0 = cloneTplTo(self.tpls[NewEducateSiteHandler.TPL_TYPE.TEXT], self.contentTF, arg_27_1.id)
	local var_27_1 = arg_27_1.name ~= 0

	setActive(var_27_0:Find("name_container"), arg_27_1.name ~= 0)

	local var_27_2 = false

	if var_27_1 then
		local var_27_3 = self:_GetText(pg.child2_word[arg_27_1.name].id)

		if pg.child2_word[arg_27_1.name].char_type == NewEducateConst.WORD_TYPE.SITE_LEFT then
			setActive(var_27_0:Find("name_container/left"), true)
			setActive(var_27_0:Find("name_container/right"), false)
			setText(var_27_0:Find("name_container/left"), var_27_3)
		elseif pg.child2_word[arg_27_1.name].char_type == NewEducateConst.WORD_TYPE.SITE_RIGHT then
			var_27_2 = true

			setActive(var_27_0:Find("name_container/left"), false)
			setActive(var_27_0:Find("name_container/right"), true)
			setText(var_27_0:Find("name_container/right"), var_27_3)
		end
	end

	local var_27_4 = self:_GetText(arg_27_1.text)

	if var_27_2 and GetPerceptualSize(var_27_4) < 22 then
		var_27_0:Find("text"):GetComponent(typeof(Text)).alignment = TextAnchor.UpperRight
	end

	setText(var_27_0:Find("text"), var_27_4)

	local var_27_5 = GetComponent(var_27_0:Find("text"), typeof(Typewriter))

	function var_27_5.endFunc()
		if arg_27_1.next_type == NewEducateNodePanel.NEXT_TYPE.OPTION then
			self.optionIds = self:FilterOptions(arg_27_1.next)
			self.callback = arg_27_2

			self.optionUIList:align(#self.optionIds)
		else
			self.optionUIList:align(#self.optionIds)
			existCall(arg_27_2)
		end

		self:StopAutoScroll()
		scrollTo(self.scrollrect, 0, 0)

		return
	end

	var_27_5:setSpeed(self.speed)
	var_27_5:Play()

	if self.speed ~= NewEducateConst.TYPEWRITE_SPEED_UP then
		onButton(self, self.windowTF, function()
			removeOnButton(self.windowTF)

			self.speed = NewEducateConst.TYPEWRITE_SPEED_UP

			var_27_5:setSpeed(self.speed)

			return
		end)
	end

	self:StartAutoScroll()

	return
end

function NewEducateSiteHandler:FilterOptions(arg_30_1)
	local var_30_0 = getProxy(NewEducateProxy):GetCurChar()

	return underscore.select(arg_30_1, function(arg_31_0)
		if pg.child2_node[arg_31_0].option_condition_show == 0 then
			return true
		end

		return not ((#pg.child2_node[arg_31_0].option_condition > 0 or nil) and not var_30_0:IsMatchComplex(pg.child2_node[arg_31_0].option_condition))
	end)
end

function NewEducateSiteHandler:AddOption(arg_32_1, arg_32_2)
	local var_32_0 = cloneTplTo(self.tpls[NewEducateSiteHandler.TPL_TYPE.OPTION], self.contentTF, arg_32_1.id)

	if pg.child2_word[arg_32_1.text].char_type == NewEducateConst.WORD_TYPE.CHILD then
		setActive(var_32_0:Find("name_container"), true)
		setText(var_32_0:Find("name_container/name"), self.charName)
	elseif pg.child2_word[arg_32_1.text].char_type == NewEducateConst.WORD_TYPE.PLAYER then
		setActive(var_32_0:Find("name_container"), true)
		setText(var_32_0:Find("name_container/name"), self.playerName)
	else
		setActive(var_32_0:Find("name_container"), false)
	end

	setText(var_32_0:Find("text"), ">>" .. self:_GetText(arg_32_1.text))

	if arg_32_1.next_type == NewEducateNodePanel.NEXT_TYPE.OPTION then
		self.optionIds = arg_32_1.next
		self.callback = arg_32_2

		self.optionUIList:align(#self.optionIds)
	else
		self.optionIds = {}

		self.optionUIList:align(#self.optionIds)
		existCall(arg_32_2)
	end

	return
end

function NewEducateSiteHandler:AddDrops(arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = cloneTplTo(self.tpls[NewEducateSiteHandler.TPL_TYPE.DROP], self.contentTF, arg_33_1)

	setActive(var_33_0:Find("tpl"), false)

	local var_33_1 = {}
	local var_33_2 = NewEducateHelper.MergeDrops(arg_33_2)

	for iter_33_0, iter_33_1 in ipairs(var_33_2) do
		table.insert(var_33_1, function(arg_34_0)
			self:UpdateDropText(iter_33_1, cloneTplTo(var_33_0:Find("tpl"), var_33_0, iter_33_1.type .. "_" .. iter_33_1.id), arg_34_0)

			return
		end)
	end

	seriesAsync(var_33_1, function()
		local var_35_0 = underscore.reduce(var_33_2, 0, function(arg_36_0, arg_36_1)
			return arg_36_0 + ((NewEducateHelper.IsPersonalDrop(arg_36_1) or nil) and (arg_36_1.number or 0))
		end)

		if var_35_0 ~= 0 then
			self:CheckPersonalChange(var_35_0)
		end

		existCall(arg_33_3)

		return
	end)

	return
end

function NewEducateSiteHandler:UpdateDropText(arg_37_1, arg_37_2, arg_37_3)
	self.speed = NewEducateConst.TYPEWRITE_SPEED

	local var_37_0 = NewEducateHelper.GetDropConfig(arg_37_1)
	local var_37_1 = getProxy(NewEducateProxy):GetCurChar()

	if NewEducateHelper.IsPersonalDrop(arg_37_1) then
		setText(arg_37_2:Find("content/value"), (arg_37_1.number > 0 and var_37_1:GetPersonalityTagTip(2) or var_37_1:GetPersonalityTagTip(1)) .. "+" .. math.abs(arg_37_1.number))
	elseif arg_37_1.type == NewEducateConst.DROP_TYPE.ATTR or arg_37_1.type == NewEducateConst.DROP_TYPE.RES then
		local var_37_2 = arg_37_1.number > 0 and "child2_site_drop_add" or "child2_site_drop_reduce"
		local var_37_3 = var_37_1:GetOwnCnt(arg_37_1)

		setText(arg_37_2:Find("content/value"), i18n(var_37_2, var_37_0.name, var_37_3 - arg_37_1.number + (arg_37_1.overflow or 0), var_37_3, (math.abs(arg_37_1.number - (arg_37_1.overflow or 0)))))
	else
		setText(arg_37_2:Find("content/value"), i18n("child2_site_drop_item", var_37_0.name))
	end

	setActive(arg_37_2:Find("content/benefit"), false)

	local var_37_4 = GetComponent(arg_37_2:Find("content/value"), typeof(Typewriter))

	function var_37_4.endFunc()
		onDelayTick(function()
			existCall(arg_37_3)

			return
		end, 0.5)

		return
	end

	var_37_4:setSpeed(self.speed)

	if not isActive(self._tf) then
		existCall(arg_37_3)
	else
		var_37_4:Play()

		if self.speed ~= NewEducateConst.TYPEWRITE_SPEED_UP then
			onButton(self, self.windowTF, function()
				removeOnButton(self.windowTF)

				self.speed = NewEducateConst.TYPEWRITE_SPEED_UP

				var_37_4:setSpeed(self.speed)

				return
			end)
		end

		scrollTo(self.scrollrect, 0, 0)
	end

	return
end

function NewEducateSiteHandler:CheckPersonalChange(arg_41_1)
	self.speed = NewEducateConst.TYPEWRITE_SPEED

	local var_41_0 = getProxy(NewEducateProxy):GetCurChar()

	if var_41_0:GetPersonalityTag(var_41_0:GetPersonality() - arg_41_1) ~= var_41_0:GetPersonalityTag() then
		local var_41_1 = cloneTplTo(self.tpls[NewEducateSiteHandler.TPL_TYPE.DROP], self.contentTF, "personal_change"):Find("tpl")

		setText(var_41_1:Find("content/value"), i18n("child2_personal_change") .. ">>" .. (arg_41_1 > 0 and var_41_0:GetPersonalityTagTip(2) or var_41_0:GetPersonalityTagTip(1)))
		setActive(var_41_1:Find("content/benefit"), false)

		local var_41_2 = GetComponent(var_41_1:Find("content/value"), typeof(Typewriter))

		function var_41_2.endFunc()
			return
		end

		var_41_2:setSpeed(self.speed)
		var_41_2:Play()

		if self.speed ~= NewEducateConst.TYPEWRITE_SPEED_UP then
			onButton(self, self.windowTF, function()
				removeOnButton(self.windowTF)

				self.speed = NewEducateConst.TYPEWRITE_SPEED_UP

				var_41_2:setSpeed(self.speed)

				return
			end)
		end

		scrollTo(self.scrollrect, 0, 0)
	end

	return
end

function NewEducateSiteHandler:AddFavorUpgrade()
	self.speed = NewEducateConst.TYPEWRITE_SPEED

	local var_44_0 = cloneTplTo(self.tpls[NewEducateSiteHandler.TPL_TYPE.DROP], self.contentTF, "favor_drop"):Find("tpl")

	setText(var_44_0:Find("content/value"), i18n("child2_ship_upgrade_favor", pg.child2_site_display[self.siteId].name, pg.child2_site_character[pg.child2_site_display[self.siteId].param].level + 1))
	setActive(var_44_0:Find("content/benefit"), false)

	local var_44_1 = GetComponent(var_44_0:Find("content/value"), typeof(Typewriter))

	function var_44_1.endFunc()
		return
	end

	var_44_1:setSpeed(self.speed)
	var_44_1:Play()

	if self.speed ~= NewEducateConst.TYPEWRITE_SPEED_UP then
		onButton(self, self.windowTF, function()
			removeOnButton(self.windowTF)

			self.speed = NewEducateConst.TYPEWRITE_SPEED_UP

			var_44_1:setSpeed(self.speed)

			return
		end)
	end

	scrollTo(self.scrollrect, 0, 0)
	pg.m02:sendNotification(NewEducateMapMediator.ON_SHIP_UPGRADE_LEVEL)

	return
end

function NewEducateSiteHandler:Reset()
	setActive(self._go, false)
	setActive(self.endOptionsTF, false)
	setActive(self.closeBtn, false)
	setActive(self.closeBtn2, false)
	removeAllChildren(self.contentTF)
	self:StopAutoScroll()

	self.dropRecords = {}
	self.passNodeIds = {}
	self.optionIds = {}
	self.callback = nil
	self.siteId = 0
	self.speed = NewEducateConst.TYPEWRITE_SPEED

	removeOnButton(self.windowTF)

	return
end

function NewEducateSiteHandler:BindEndBtn(arg_48_1, arg_48_2, arg_48_3)
	onButton(self, self.endBtn, function()
		existCall(arg_48_1)

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		existCall(arg_48_1)

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn2, function()
		existCall(arg_48_1)

		return
	end, SFX_PANEL)

	self.onSiteEnd = arg_48_2
	self.onNormal = arg_48_3

	return
end

function NewEducateSiteHandler:AddDropRecords(arg_52_1)
	self.dropRecords = table.mergeArray(self.dropRecords, arg_52_1)

	return
end

function NewEducateSiteHandler:OnEventEnd()
	setActive(self._tf, true)
	existCall(self.onSiteEnd)
	self:UpdateAgainBtn()
	setActive(self.endOptionsTF, true)
	setActive(self.closeBtn, true)
	setActive(self.closeBtn2, true)

	if pg.child2_site_display[self.siteId].type == NewEducateConst.SITE_TYPE.SHIP then
		self:AddFavorUpgrade()
	end

	return
end

function NewEducateSiteHandler:UpdateAgainBtn()
	local var_54_0 = pg.child2_site_display[self.siteId].type
	local var_54_1 = pg.child2_site_display[self.siteId].type == NewEducateConst.SITE_TYPE.WORK or var_54_0 == NewEducateConst.SITE_TYPE.TRAVEL

	setActive(self.againBtn, pg.child2_site_display[self.siteId].type == NewEducateConst.SITE_TYPE.WORK or var_54_0 == NewEducateConst.SITE_TYPE.TRAVEL)

	if var_54_1 then
		local var_54_2 = getProxy(NewEducateProxy):GetCurChar()
		local var_54_3 = var_54_2:GetNormalIdByType((var_54_0 == NewEducateConst.SITE_TYPE.WORK or nil) and (NewEducateConst.SITE_NORMAL_TYPE.WORK or NewEducateConst.SITE_NORMAL_TYPE.TRAVEL))
		local var_54_4 = NewEducateHelper.Config2Drop(pg.child2_site_normal[var_54_3].cost)

		LoadImageSpriteAsync("neweducateicon/" .. NewEducateHelper.GetDropConfig(var_54_4).icon, self.againBtn:Find("cost/Image"))
		setText(self.againBtn:Find("cost/Text"), "-" .. var_54_4.number)

		var_54_4.operator = ">="

		local var_54_5 = not var_54_2:IsMatch(var_54_4)

		setImageColor(self.againBtn, Color.NewHex(var_54_5 and "C8CAD5" or "FFFFFF"))
		setTextColor(self.againBtn:Find("mask/Text"), Color.NewHex(var_54_5 and "717171" or "393A3C"))

		if not var_54_5 then
			onButton(self, self.againBtn, function()
				pg.m02:sendNotification(GAME.NEW_EDUCATE_MAP_NORMAL, {
					id = var_54_2.id,
					normalId = var_54_3
				})
				existCall(self.onNormal)

				return
			end, SFX_PANEL)
		else
			removeOnButton(self.againBtn)
		end
	end

	return
end

function NewEducateSiteHandler:StartAutoScroll()
	self.timer = Timer.New(function()
		scrollTo(self.scrollrect, 0, 0)

		return
	end, 0.4, -1)

	self.timer:Start()

	return
end

function NewEducateSiteHandler:StopAutoScroll()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function NewEducateSiteHandler:UpdateCallName()
	self.callName = getProxy(NewEducateProxy):GetCurChar():GetCallName()

	return
end

function NewEducateSiteHandler:Destroy()
	pg.DelegateInfo.Dispose(self)

	return
end

return NewEducateSiteHandler
