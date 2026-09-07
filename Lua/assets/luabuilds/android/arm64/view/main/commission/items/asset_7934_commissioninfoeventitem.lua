local CommissionInfoEventItem = class("CommissionInfoEventItem", import(".CommissionInfoItem"))

function CommissionInfoEventItem:Ctor(arg_1_1, arg_1_2)
	CommissionInfoEventItem.super.Ctor(self, arg_1_1, arg_1_2)

	self.lockTF = self._tf:Find("lock")

	setActive(self.lockTF, false)
	setText(self.lockTF:Find("Text"), i18n("commission_label_unlock_event_tip"))

	return
end

function CommissionInfoEventItem:CanOpen()
	return getProxy(PlayerProxy):getData().level >= 12
end

function CommissionInfoEventItem:Init()
	local var_3_0 = self:CanOpen()

	setActive(self.lockTF, not var_3_0)
	setGray(self.toggle, not var_3_0, true)
	setActive(self.foldFlag, var_3_0)
	setActive(self.goBtn, var_3_0)

	self.ptBonus = EventPtBonus.New(self.toggle:Find("bonusPt"))

	CommissionInfoEventItem.super.Init(self)

	return
end

function CommissionInfoEventItem:GetList()
	assert(self.list, "why ???")
	table.sort(self.list, CompareFuncs({
		function(arg_5_0)
			return -arg_5_0:GetState()
		end
	}))

	return self.list, 4
end

function CommissionInfoEventItem:OnFlush()
	local var_6_0, var_6_1, var_6_2, var_6_3 = getProxy(EventProxy):GetEventListForCommossionInfo()

	self.finishedCounter.text = var_6_1
	self.ongoingCounter.text = var_6_2
	self.leisureCounter.text = var_6_3

	setActive(self.finishedCounterContainer, var_6_1 > 0)
	setActive(self.ongoingCounterContainer, var_6_2 > 0)
	setActive(self.leisureCounterContainer, var_6_3 > 0)
	setActive(self.goBtn, var_6_1 == 0)
	setActive(self.finishedBtn, var_6_1 > 0)

	self.list = var_6_0

	return
end

function CommissionInfoEventItem:UpdateList()
	CommissionInfoEventItem.super.UpdateList(self)
	self:UpdateActList()

	return
end

function CommissionInfoEventItem:UpdateActList()
	local var_8_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_COLLECTION_EVENT)

	if var_8_0 and not var_8_0:isEnd() then
		local var_8_1 = getProxy(EventProxy):GetEventByActivityId(var_8_0.id)

		if var_8_1 then
			local var_8_2 = cloneTplTo(self.uilist.item, self.uilist.container)

			var_8_2:SetAsFirstSibling()
			self:UpdateEventInfo(var_8_2, var_8_1)
			setActive(var_8_2:Find("unlock"), true)
			setActive(var_8_2:Find("lock"), false)
			self:UpdateStyle(var_8_2, true)
		end
	end

	return
end

function CommissionInfoEventItem:GetChapterByCount(arg_9_1)
	for iter_9_0, iter_9_1 in pairs(pg.chapter_template.all) do
		if pg.chapter_template[iter_9_1].collection_team == arg_9_1 then
			return pg.chapter_template[iter_9_1]
		end
	end

	return
end

function CommissionInfoEventItem:UpdateListItem(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_1 > getProxy(EventProxy).maxFleetNums

	if var_10_0 then
		local var_10_1 = self:GetChapterByCount(arg_10_1)

		assert(var_10_1, arg_10_1)

		if getProxy(SettingsProxy):IsMellowStyle() then
			setText(arg_10_3:Find("lock/Text"), i18n("commission_open_tip", var_10_1.chapter_name))
		else
			setText(arg_10_3:Find("lock/Text"), i18n("commission_no_open") .. "\n" .. i18n("commission_open_tip", var_10_1.chapter_name))
		end
	else
		self:UpdateEventInfo(arg_10_3, arg_10_2)
	end

	setActive(arg_10_3:Find("unlock"), not var_10_0)
	setActive(arg_10_3:Find("lock"), var_10_0)
	self:UpdateStyle(arg_10_3, false, arg_10_2)

	return
end

function CommissionInfoEventItem:UpdateEventInfo(arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2 and arg_11_2:GetState() or EventInfo.StateNone

	if var_11_0 == EventInfo.StateNone then
		setText(arg_11_1:Find("unlock/name_bg/Text"), i18n("commission_idle"))
		onButton(self, arg_11_1:Find("unlock/leisure/go_btn"), function()
			self:OnSkip()

			return
		end, SFX_PANEL)
		onButton(self, arg_11_1, function()
			triggerButton(arg_11_1:Find("unlock/leisure/go_btn"))

			return
		end, SFX_PANEL)
	elseif var_11_0 == EventInfo.StateFinish then
		setText(arg_11_1:Find("unlock/name_bg/Text"), arg_11_2.template.title)
		onButton(self, arg_11_1:Find("unlock/finished/finish_btn"), function()
			self:emit(CommissionInfoMediator.FINISH_EVENT, arg_11_2)

			return
		end, SFX_PANEL)
		onButton(self, arg_11_1, function()
			triggerButton(arg_11_1:Find("unlock/finished/finish_btn"))

			return
		end, SFX_PANEL)
	elseif var_11_0 == EventInfo.StateActive then
		setText(arg_11_1:Find("unlock/name_bg/Text"), arg_11_2.template.title)
		self:AddTimer(arg_11_2, (arg_11_1:Find("unlock/ongoging/time"):GetComponent(typeof(Text))))
	end

	setActive(arg_11_1:Find("unlock/leisure"), var_11_0 == EventInfo.StateNone)
	setActive(arg_11_1:Find("unlock/ongoging"), var_11_0 == EventInfo.StateActive)
	setActive(arg_11_1:Find("unlock/finished"), var_11_0 == EventInfo.StateFinish)

	return
end

function CommissionInfoEventItem:AddTimer(arg_16_1, arg_16_2)
	self:RemoveTimer(arg_16_1)

	local var_16_0 = arg_16_1.finishTime + 2

	self.timers[arg_16_1.id] = Timer.New(function()
		local var_17_0 = var_16_0 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_17_0 <= 0 then
			self.timers[arg_16_1.id]:Stop()

			self.timers[arg_16_1.id] = nil

			self:OnFlush()
			self:UpdateList()
		else
			arg_16_2.text = pg.TimeMgr.GetInstance():DescCDTime(var_17_0)
		end

		return
	end, 1, -1)

	self.timers[arg_16_1.id]:Start()
	self.timers[arg_16_1.id].func()

	return
end

function CommissionInfoEventItem:RemoveTimer(arg_18_1)
	if self.timers[arg_18_1.id] then
		self.timers[arg_18_1.id]:Stop()

		self.timers[arg_18_1.id] = nil
	end

	return
end

function CommissionInfoEventItem:UpdateStyle(arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_3 and arg_19_3:GetState() or EventInfo.StateNone
	local var_19_1 = "icon_1"
	local var_19_2 = "icon_4"
	local var_19_3 = "icon_3"

	if arg_19_2 then
		var_19_3 = "icon_6"
		var_19_2 = "icon_6"
		var_19_1 = "icon_5"
	end

	local function var_19_4(arg_20_0, arg_20_1)
		local var_20_0 = arg_19_1:Find(string.format("unlock/%s/icon", arg_20_0))
		local var_20_1 = GetSpriteFromAtlas("ui/commissioninfoui_atlas", arg_20_1)

		if arg_19_2 then
			var_20_0.localScale = Vector3.one or Vector3(1.2, 1.2, 1.2)
		end

		var_20_0:GetComponent(typeof(Image)).sprite = var_20_1

		var_20_0:GetComponent(typeof(Image)):SetNativeSize()

		return
	end

	var_19_4("leisure", var_19_1)
	var_19_4("ongoging", var_19_2)
	var_19_4("finished", var_19_3)

	local var_19_5 = "event_ongoing"

	if arg_19_2 then
		var_19_5 = "event_bg_act"
	end

	if getProxy(SettingsProxy):IsMellowStyle() then
		var_19_5 = "frame_unlock"
		arg_19_1:Find("unlock/ongoging"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/CommissionInfoUI4Mellow_atlas", "frame_unlock")
		arg_19_1:Find("unlock/finished"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/CommissionInfoUI4Mellow_atlas", var_19_5)
	else
		arg_19_1:Find("unlock/ongoging"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/commissioninfoui_atlas", var_19_5)
		arg_19_1:Find("unlock/finished"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/commissioninfoui_atlas", var_19_5)
	end

	local var_19_6 = arg_19_2 and Color.New(0.996078431372549, 0.7568627450980392, 0.9725490196078431, 1) or Color.New(0.6039215686274509, 0.7843137254901961, 0.9607843137254902, 1)

	arg_19_1:Find("unlock/ongoging/print"):GetComponent(typeof(Image)).color = var_19_6
	arg_19_1:Find("unlock/finished/print"):GetComponent(typeof(Image)).color = var_19_6

	setActive(arg_19_1:Find("unlock/act"), var_19_0 == EventInfo.StateNone and arg_19_2)

	return
end

function CommissionInfoEventItem:OnSkip()
	self:emit(CommissionInfoMediator.ON_ACTIVE_EVENT)

	return
end

function CommissionInfoEventItem:OnFinishAll()
	local var_22_0 = {}
	local var_22_1 = 0

	_.each(self.list, function(arg_23_0)
		if arg_23_0:GetState() == EventInfo.StateFinish then
			table.insert(var_22_0, function(arg_24_0)
				self:emit(CommissionInfoMediator.FINISH_EVENT, arg_23_0, var_22_1, arg_24_0)

				return
			end)
		end

		return
	end)

	local var_22_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_COLLECTION_EVENT)

	if var_22_2 and not var_22_2:isEnd() then
		local var_22_3 = getProxy(EventProxy):GetEventByActivityId(var_22_2.id)

		if var_22_3 and var_22_3:GetState() == EventInfo.StateFinish then
			table.insert(var_22_0, function(arg_25_0)
				self:emit(CommissionInfoMediator.FINISH_EVENT, var_22_3, var_22_1, arg_25_0)

				return
			end)
		end
	end

	var_22_1 = #var_22_0

	seriesAsync(var_22_0)

	return
end

return CommissionInfoEventItem
