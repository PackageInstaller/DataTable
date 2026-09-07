local LinerLogEventPage = class("LinerLogEventPage", import("view.base.BaseSubView"))

function LinerLogEventPage:getUIName()
	return "LinerLogEventPage"
end

function LinerLogEventPage:OnLoaded()
	self.leftTF = self._tf:Find("left")
	self.rightTF = self._tf:Find("right")
	self.togglesTF = self._tf:Find("toggles")
	self.anim = self._tf:Find("content"):GetComponent(typeof(Animation))

	local var_2_0 = self._tf:Find("content/view/content")

	self.itemTFs = {
		var_2_0:Find("1"),
		var_2_0:Find("2"),
		(var_2_0:Find("3"))
	}

	for iter_2_0, iter_2_1 in pairs(self.itemTFs) do
		iter_2_1:Find("empty"):GetComponent(typeof(Image)):SetNativeSize()
	end

	self.eventIconTF = self._tf:Find("content/title/Image")
	self.awardTF = self._tf:Find("award/mask/IconTpl")
	self.awardDesc = self._tf:Find("award/Text")
	self.goBtn = self._tf:Find("award/go")
	self.getBtn = self._tf:Find("award/get")
	self.gotTF = self._tf:Find("award/got")

	setText(self._tf:Find("award/got/title"), i18n("liner_event_award_tip3"))

	self.conclusionDesc = self._tf:Find("award/got/Text")

	return
end

function LinerLogEventPage:OnInit()
	self:UpdateActivity()
	onButton(self, self.getBtn, function()
		self:emit(LinerLogBookMediator.ON_START_REASONING, self.activity.id, self.curIdx)

		return
	end, SFX_CONFIRM)
	onButton(self, self.goBtn, function()
		self:emit(LinerLogBookMediator.ON_CLOSE)

		return
	end, SFX_CONFIRM)

	self.groupIds = self.activity:GetEventGroupIds()
	self.groups = {}

	for iter_3_0, iter_3_1 in ipairs(self.groupIds) do
		self.groups[iter_3_0] = LinerEventGroup.New(iter_3_1)
	end

	self.toggleUIList = UIItemList.New(self.togglesTF, self.togglesTF:Find("tpl"))

	self.toggleUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventInit then
			local var_6_0 = arg_6_1 + 1

			arg_6_2.name = arg_6_1 + 1

			local var_6_1 = i18n("liner_log_event_group_title" .. arg_6_1 + 1)

			setText(arg_6_2:Find("Text"), var_6_1)
			setText(arg_6_2:Find("selected/Text"), var_6_1)

			if arg_6_1 + 1 > 1 then
				local var_6_2 = self:IsFinishWithGroupIdx(arg_6_1 + 1 - 1)

				SetCompomentEnabled(arg_6_2, typeof(Toggle), var_6_2)
				setActive(arg_6_2:Find("lock"), not var_6_2)

				if not var_6_2 then
					setActive(arg_6_2:Find("selected"), false)
				end
			end

			onToggle(self, arg_6_2, function(arg_7_0)
				if arg_7_0 then
					if self.curIdx and self.curIdx == var_6_0 then
						return
					end

					self.curIdx = var_6_0

					self:FlushPage()
				end

				return
			end, SFX_CONFIRM)
		elseif arg_6_0 == UIItemList.EventUpdate then
			setActive(arg_6_2:Find("tip"), LinerLogEventPage.IsTipWithGroupId(self.activity, self.groups[arg_6_1 + 1].id))
		end

		return
	end)
	self.toggleUIList:align(#self.groupIds)
	triggerToggle(self.toggleUIList.container:Find("1"), true)

	return
end

function LinerLogEventPage:UpdateActivity(arg_8_1)
	self.activity = arg_8_1 or getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LINER)

	assert(self.activity and not self.activity:isEnd(), "not exist liner act, type: " .. ActivityConst.ACTIVITY_TYPE_LINER)

	self.finishEventIds = self.activity:GetFinishEventIds()

	return
end

function LinerLogEventPage:FlushPage()
	self.anim:Play()
	self.toggleUIList:align(#self.groupIds)
	setImageSprite(self.eventIconTF, GetSpriteFromAtlas("ui/linermainui_atlas", "event_title" .. self.groups[self.curIdx].id), true)

	local var_9_0 = false
	local var_9_1 = self.groups[self.curIdx]:GetIds()

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_2 = self.itemTFs[iter_9_0]

		setActive(self.itemTFs[iter_9_0], true)

		local var_9_3 = var_9_2:Find("desc")
		local var_9_4 = self.groups[self.curIdx]:GetEvent(iter_9_1)
		local var_9_5 = table.contains(self.finishEventIds, iter_9_1)

		setText(var_9_2:Find("name/Text"), var_9_5 and var_9_4:GetTitle() or i18n("liner_event_title" .. iter_9_0))

		if not var_9_5 then
			var_9_0 = true
		end

		setImageSprite(var_9_2:Find("icon"), GetSpriteFromAtlas("ui/linermainui_atlas", (var_9_5 or nil) and ("clue" .. iter_9_1 or "empty" .. iter_9_0)), true)
		setText(var_9_3, var_9_5 and var_9_4:GetLogDesc() or "")
		setActive(var_9_2:Find("empty"), not var_9_5)
	end

	for iter_9_2 = #var_9_1 + 1, #self.itemTFs do
		setActive(self.itemTFs[iter_9_2], false)
	end

	local var_9_6 = self.groups[self.curIdx]:GetDrop()

	updateDrop(self.awardTF, var_9_6)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_9_6)

		return
	end, SFX_PANEL)

	local var_9_7 = self.activity:IsGotEventAward(self.curIdx)
	local var_9_8 = not var_9_7 and not var_9_0

	setActive(self.goBtn, not var_9_7 and not var_9_8)
	setActive(self.getBtn, var_9_8)
	setActive(self.gotTF, var_9_7)
	setActive(self.awardTF:Find("mask"), var_9_7)
	setText(self.awardDesc, var_9_8 and i18n("liner_event_award_tip2") or i18n("liner_event_award_tip1"))
	setActive(self.awardDesc, not var_9_7)

	if var_9_7 then
		setText(self.conclusionDesc, self.groups[self.curIdx]:GetConclusions()[self.activity:GetEventAwardFlag(self.curIdx)])
	end

	self:Show()

	return
end

function LinerLogEventPage:OnDestroy()
	return
end

function LinerLogEventPage:IsFinishWithGroupIdx(arg_12_1)
	return underscore.all(self.groups[arg_12_1]:GetIds(), function(arg_13_0)
		return table.contains(self.finishEventIds, arg_13_0)
	end)
end

function LinerLogEventPage:IsTipWithGroupId(arg_14_1)
	if self:IsGotEventAward((table.indexof(self:GetEventGroupIds(), arg_14_1))) then
		return false
	end

	local var_14_0 = self:GetFinishEventIds()

	return underscore.all(pg.activity_liner_event_group[arg_14_1].ids, function(arg_15_0)
		return table.contains(var_14_0, arg_15_0)
	end)
end

function LinerLogEventPage.IsTip()
	local var_16_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LINER)

	assert(var_16_0 and not var_16_0:isEnd(), "not exist liner act, type: " .. ActivityConst.ACTIVITY_TYPE_LINER)

	return underscore.any(var_16_0:GetEventGroupIds(), function(arg_17_0)
		return LinerLogEventPage.IsTipWithGroupId(var_16_0, arg_17_0)
	end)
end

function LinerLogEventPage.IsUnlcok()
	local var_18_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LINER)

	assert(var_18_0 and not var_18_0:isEnd(), "not exist liner act, type: " .. ActivityConst.ACTIVITY_TYPE_LINER)

	return var_18_0:GetCurIdx() > 7
end

return LinerLogEventPage
