local LinerRoomInfoPage = class("LinerRoomInfoPage", import("view.base.BaseSubView"))

LinerRoomInfoPage.TYPEWRITE_SPEED = 0.03
LinerRoomInfoPage.TYPE_EXPLORE = 1
LinerRoomInfoPage.TYPE_EVENT = 2
LinerRoomInfoPage.MODE_EVENT_DESC = 1
LinerRoomInfoPage.MODE_OPTION_DESC = 2
LinerRoomInfoPage.MODE_ROOM_DESC = 3
LinerRoomInfoPage.TIME_DIFF_LIST = {
	1,
	2,
	3,
	4,
	5,
	6,
	12,
	13,
	14
}
LinerRoomInfoPage.ICON_LIST = {
	2,
	5,
	6,
	12,
	13,
	14
}

function LinerRoomInfoPage:getUIName()
	return "LinerRoomInfoPage"
end

function LinerRoomInfoPage:OnLoaded()
	self.dotTF = self._tf:Find("frame/bottom/name/Image")
	self.nameTF = self._tf:Find("frame/bottom/name/Text")
	self.iconTF = self._tf:Find("frame/bottom/icon/mask/Image")
	self.descTF = self._tf:Find("frame/bottom/Text")
	self.nextTF = self._tf:Find("frame/bottom/next")
	self.typewrite = GetComponent(self.descTF, typeof(Typewriter))

	self.typewrite:setSpeed(LinerRoomInfoPage.TYPEWRITE_SPEED)

	self.optionsTF = self._tf:Find("frame/options")

	return
end

function LinerRoomInfoPage:OnInit()
	onButton(self, self._tf:Find("mask"), function()
		self:OnClick()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("frame/bottom"), function()
		self:OnClick()

		return
	end, SFX_PANEL)

	function self.typewrite.endFunc()
		if self.curIndex == #self.descList then
			switch(self.mode, {
				[LinerRoomInfoPage.MODE_EVENT_DESC] = function()
					setActive(self.optionsTF, true)
					self:ShowOptionsAnim()

					return
				end,
				[LinerRoomInfoPage.MODE_OPTION_DESC] = function()
					pg.TipsMgr.GetInstance():ShowTips(i18n("liner_event_get_tip", self.eventName))

					return
				end,
				[LinerRoomInfoPage.MODE_ROOM_DESC] = function()
					pg.TipsMgr.GetInstance():ShowTips(i18n("liner_room_get_tip", self.room:GetName()))

					return
				end
			})
		end

		self.isWriting = false
		self.curIndex = self.curIndex + 1

		return
	end

	self.optionsUIList = UIItemList.New(self.optionsTF, self.optionsTF:Find("tpl"))

	self.optionsUIList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = arg_10_1 + 1
			local var_10_1 = self.events[arg_10_1 + 1]

			setText(arg_10_2:Find("Text"), self.events[arg_10_1 + 1]:GetOptionName())
			onButton(self, arg_10_2, function()
				if table.contains(self.finishEventIds, var_10_1.id) then
					return
				end

				self.isClickEvent = true

				self:emit(LinerMediator.CLICK_EVENT, {
					actId = self.activity.id,
					roomId = self.room.id,
					eventId = var_10_1.id,
					callback = function()
						self.eventName = var_10_1:GetTitle()

						self:SetContent(var_10_1:GetOptionDisplay(), LinerRoomInfoPage.MODE_OPTION_DESC)
						table.insert(self.finishEventIds, var_10_1.id)
						table.remove(self.events, var_10_0)
						self.optionsUIList:align(#self.events)

						return
					end
				})

				return
			end, SFX_CONFIRM)
		end

		return
	end)

	return
end

function LinerRoomInfoPage:ShowInfo(arg_13_1, arg_13_2, arg_13_3)
	self.activity = arg_13_1
	self.curTime = self.activity:GetCurTime()
	self.room = LinerRoom.New(arg_13_2)
	self.callback = arg_13_3

	setText(self.nameTF, self.room:GetName())

	local var_13_0 = tostring(arg_13_2)

	setLocalScale(self.iconTF, {
		x = 0.7,
		y = 0.7
	})

	if table.contains(LinerRoomInfoPage.TIME_DIFF_LIST, arg_13_2) then
		var_13_0 = var_13_0 .. "_" .. self.curTime:GetBgType()
	end

	if table.contains(LinerRoomInfoPage.ICON_LIST, arg_13_2) then
		var_13_0 = "icon_" .. var_13_0

		setLocalScale(self.iconTF, {
			x = 1,
			y = 1
		})
	end

	setImageSprite(self.iconTF, GetSpriteFromAtlas("ui/linermainui_atlas", var_13_0), true)
	switch(self.curTime:GetType(), {
		[LinerTime.TYPE.EXPLORE] = function()
			self:ShowRoomInfos()

			return
		end,
		[LinerTime.TYPE.EVENT] = function()
			self:ShowEventInfos()

			return
		end
	})
	self:Show()

	return
end

function LinerRoomInfoPage:ShowRoomInfos()
	setImageColor(self.dotTF, Color.NewHex("FE9400"))
	setActive(self.optionsTF, false)
	self:emit(LinerMediator.CLICK_ROOM, self.activity.id, self.room.id)
	self:SetContent(self.room:GetDescList(), LinerRoomInfoPage.MODE_ROOM_DESC)

	return
end

function LinerRoomInfoPage:ShowEventInfos()
	setImageColor(self.dotTF, Color.NewHex("4E5BFF"))

	local var_17_0 = ""

	self.events = {}
	self.finishEventIds = self.activity:GetCurEventInfo()[self.room.id] or {}

	for iter_17_0, iter_17_1 in ipairs(self.curTime:GetParamInfo()) do
		if iter_17_1[1] == self.room.id then
			var_17_0 = HXSet.hxLan(iter_17_1[3])

			for iter_17_2, iter_17_3 in ipairs(iter_17_1[4]) do
				if not table.contains(self.finishEventIds, iter_17_3) then
					table.insert(self.events, LinerEvent.New(iter_17_3))
				end
			end
		end
	end

	self:SetContent({
		var_17_0
	}, LinerRoomInfoPage.MODE_EVENT_DESC)
	setActive(self.optionsTF, false)

	return
end

function LinerRoomInfoPage:ShowOptionsAnim()
	local var_18_0 = {}

	for iter_18_0 = 1, #self.events do
		table.insert(var_18_0, function(arg_19_0)
			self:managedTween(LeanTween.delayedCall, function()
				self.optionsUIList:align(#self.events)
				arg_19_0()

				return
			end, 0.066, nil)

			return
		end)
	end

	seriesAsync(var_18_0, function()
		return
	end)

	return
end

function LinerRoomInfoPage:SetContent(arg_22_1, arg_22_2)
	self.mode = arg_22_2
	self.curIndex = 1
	self.descList = arg_22_1

	self:SetOnePage()

	return
end

function LinerRoomInfoPage:SetOnePage()
	self.isWriting = true

	setActive(self.nextTF, self.curIndex < #self.descList)
	setText(self.descTF, self.descList[self.curIndex])
	self.typewrite:Play()

	return
end

function LinerRoomInfoPage:OnClick()
	if self.isWriting then
		return
	end

	if #self.descList >= self.curIndex then
		self:SetOnePage()

		return
	end

	if self.events and #self.events > 0 then
		return
	end

	self:Hide()

	if self.callback and (self.isClickEvent or self.curTime:GetType() == LinerTime.TYPE.EXPLORE) then
		self.callback()

		self.callback = nil
		self.isClickEvent = nil
	end

	return
end

return LinerRoomInfoPage
