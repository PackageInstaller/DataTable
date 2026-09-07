local ActivityPermanentLayer = class("ActivityPermanentLayer", import("..base.BaseUI"))

function ActivityPermanentLayer:getUIName()
	return "ActivitySelectUI"
end

function ActivityPermanentLayer:onBackPressed()
	self:closeView()

	return
end

function ActivityPermanentLayer:onBackPressed()
	if isActive(self.rtMsgbox) then
		self:hideMsgbox()
	else
		ActivityPermanentLayer.super.onBackPressed(self)
	end

	return
end

function ActivityPermanentLayer:init()
	self.bg = self._tf:Find("bg_back")

	onButton(self, self.bg, function()
		self:closeView()

		return
	end, SFX_CANCEL)

	self.btnBack = self._tf:Find("window/inner/top/back")

	onButton(self, self.btnBack, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	setText(self._tf:Find("window/inner/top/back/Text"), i18n("activity_permanent_total"))

	self.btnHelp = self._tf:Find("window/inner/top/help")

	onButton(self, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("activity_permanent_help")
		})

		return
	end, SFX_PANEL)

	self.content = self._tf:Find("window/inner/content/scroll_rect")
	self.itemList = UIItemList.New(self.content, self.content:Find("item"))

	local var_4_0 = getProxy(ActivityPermanentProxy)

	self.itemList:make(function(arg_8_0, arg_8_1, arg_8_2)
		arg_8_1 = arg_8_1 + 1

		if arg_8_0 == UIItemList.EventUpdate then
			local var_8_0 = self.ids[arg_8_1]

			setText(arg_8_2:Find("main/word/Text"), pg.activity_task_permanent[self.ids[arg_8_1]].gametip)
			setText(arg_8_2:Find("main/Image/tip/Text"), pg.activity_task_permanent[self.ids[arg_8_1]].gametip_extra)
			GetImageSpriteFromAtlasAsync("activitybanner/" .. pg.activity_task_permanent[self.ids[arg_8_1]].banner_route, "", arg_8_2:Find("main/Image"))
			onButton(self, arg_8_2:Find("main"), function()
				self:showMsgbox(var_8_0)

				return
			end, SFX_PANEL)

			local var_8_1 = arg_8_2:Find("finish")
			local var_8_2 = GetOrAddComponent(var_8_1, typeof(CanvasGroup))

			if var_8_0 == self.contextData.finishId then
				self.childFinish = arg_8_2
				var_8_2.alpha = 0
			else
				var_8_2.alpha = 1
			end

			setText(var_8_1:Find("Image/Text"), i18n("activity_permanent_finished"))
			setActive(var_8_1, var_4_0:isActivityFinish(var_8_0))
		end

		return
	end)

	self.rtMsgbox = self._tf:Find("Msgbox")

	onButton(self, self.rtMsgbox:Find("bg"), function()
		self:hideMsgbox()

		return
	end, SFX_CANCEL)
	onButton(self, self.rtMsgbox:Find("window/top/btnBack"), function()
		self:hideMsgbox()

		return
	end, SFX_CANCEL)
	onButton(self, self.rtMsgbox:Find("window/button_container/custom_button_2"), function()
		self:hideMsgbox()

		return
	end, SFX_CANCEL)

	return
end

function ActivityPermanentLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self.itemList:align(#self.ids)

	if self.childFinish then
		scrollTo(self.content, nil, math.clamp(self.childFinish.anchoredPosition.y / (self.content.rect.height - self.content:GetComponent(typeof(ScrollRect)).viewport.rect.height), 0, 1))
		self:doFinishAnim(self.childFinish)

		self.childFinish = nil
	end

	if PlayerPrefs.GetInt("permanent_select", 0) ~= 1 then
		PlayerPrefs.SetInt("permanent_select", 1)
		triggerButton(self.btnHelp)
	end

	return
end

function ActivityPermanentLayer:willExit()
	if isActive(self.rtMsgbox) then
		self:hideMsgbox()
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	if self.ltId then
		LeanTween.cancel(self.ltId)

		self.ltId = nil
	end

	return
end

function ActivityPermanentLayer:setActivitys(arg_15_1)
	self.ids = arg_15_1

	local var_15_0 = getProxy(ActivityPermanentProxy)

	table.sort(self.ids, function(arg_16_0, arg_16_1)
		local var_16_0 = var_15_0:isActivityFinish(arg_16_1)

		if var_15_0:isActivityFinish(arg_16_0) == var_16_0 then
			return arg_16_0 < arg_16_1
		else
			return var_16_0
		end

		return
	end)

	return
end

function ActivityPermanentLayer:doFinishAnim(arg_17_1)
	self.ltId = LeanTween.alphaCanvas(GetOrAddComponent(arg_17_1:Find("finish"), typeof(CanvasGroup)), 1, 1).uniqueId

	return
end

function ActivityPermanentLayer:showMsgbox(arg_18_1)
	setText(self.rtMsgbox:Find("window/button_container/custom_button_1/pic"), i18n("msgbox_text_confirm"))
	setText(self.rtMsgbox:Find("window/button_container/custom_button_2/pic"), i18n("msgbox_text_cancel"))
	setText(self.rtMsgbox:Find("window/top/bg/infomation/title"), i18n("words_information"))
	setText(self.rtMsgbox:Find("window/msg_panel/content"), i18n("activity_permanent_tips1", pg.activity_task_permanent[arg_18_1].activity_name))
	setText(self.rtMsgbox:Find("window/msg_panel/Text"), i18n("activity_permanent_tips4"))
	onButton(self, self.rtMsgbox:Find("window/button_container/custom_button_1"), function()
		self:hideMsgbox()
		self:emit(ActivityPermanentMediator.START_SELECT, arg_18_1)

		return
	end, SFX_CONFIRM)
	setActive(self.rtMsgbox, true)
	pg.UIMgr.GetInstance():BlurPanel(self.rtMsgbox)

	return
end

function ActivityPermanentLayer:hideMsgbox()
	setActive(self.rtMsgbox, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.rtMsgbox)

	return
end

return ActivityPermanentLayer
