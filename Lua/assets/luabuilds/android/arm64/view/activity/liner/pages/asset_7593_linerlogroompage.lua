local LinerLogRoomPage = class("LinerLogRoomPage", import("view.base.BaseSubView"))

function LinerLogRoomPage:getUIName()
	return "LinerLogRoomPage"
end

function LinerLogRoomPage:OnLoaded()
	self.leftTF = self._tf:Find("left")
	self.rightTF = self._tf:Find("right")
	self.togglesTF = self._tf:Find("toggles")
	self.anim = self._tf:Find("view"):GetComponent(typeof(Animation))

	local var_2_0 = self._tf:Find("view/content")

	self.itemTFs = {
		var_2_0:Find("1"),
		var_2_0:Find("2"),
		var_2_0:Find("3"),
		(var_2_0:Find("4"))
	}

	for iter_2_0, iter_2_1 in pairs(self.itemTFs) do
		iter_2_1:Find("empty"):GetComponent(typeof(Image)):SetNativeSize()
	end

	self.awardTF = self._tf:Find("award/mask/IconTpl")
	self.awardDesc = self._tf:Find("award/Text")

	setText(self.awardDesc, i18n("liner_room_award_tip"))

	self.goBtn = self._tf:Find("award/go")
	self.getBtn = self._tf:Find("award/get")
	self.gotTF = self._tf:Find("award/got")

	return
end

function LinerLogRoomPage:OnInit()
	self:UpdateActivity()
	onButton(self, self.getBtn, function()
		self:emit(LinerLogBookMediator.GET_ROOM_AWARD, self.activity.id, self.curIdx, self.groups[self.curIdx]:GetDrop())

		return
	end, SFX_CONFIRM)
	onButton(self, self.goBtn, function()
		self:emit(LinerLogBookMediator.ON_CLOSE)

		return
	end, SFX_CONFIRM)

	self.groupIds = self.activity:getConfig("config_data")[2]
	self.groups = {}

	for iter_3_0, iter_3_1 in ipairs(self.groupIds) do
		self.groups[iter_3_0] = LinerRoomGroup.New(iter_3_1)
	end

	self.toggleUIList = UIItemList.New(self.togglesTF, self.togglesTF:Find("tpl"))

	self.toggleUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventInit then
			local var_6_0 = arg_6_1 + 1

			arg_6_2.name = arg_6_1 + 1

			local var_6_1 = "PAGE " .. string.format("%02d", arg_6_1 + 1)

			setText(arg_6_2:Find("Text"), var_6_1)
			setText(arg_6_2:Find("selected/Text"), var_6_1)
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
			setActive(arg_6_2:Find("tip"), LinerLogRoomPage.IsTipWithGroupId(self.activity, self.groups[arg_6_1 + 1].id))
		end

		return
	end)
	self.toggleUIList:align(#self.groupIds)
	triggerToggle(self.toggleUIList.container:Find("1"), true)

	return
end

function LinerLogRoomPage:UpdateActivity(arg_8_1)
	self.activity = arg_8_1 or getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LINER)

	assert(self.activity and not self.activity:isEnd(), "not exist liner act, type: " .. ActivityConst.ACTIVITY_TYPE_LINER)

	self.finishRoomIds = self.activity:GetExploredRoomIds()

	return
end

function LinerLogRoomPage:FlushPage()
	self.anim:Play()
	self.toggleUIList:align(#self.groupIds)

	local var_9_0 = false
	local var_9_1 = self.groups[self.curIdx]:GetIds()

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_2 = self.itemTFs[iter_9_0]

		if self.itemTFs[iter_9_0] then
			setActive(var_9_2, true)

			local var_9_3 = var_9_2:Find("desc")
			local var_9_4 = self.groups[self.curIdx]:GetRoom(iter_9_1)

			setText(var_9_2:Find("name/Text"), var_9_4:GetName())
			setImageSprite(var_9_2:Find("icon"), GetSpriteFromAtlas("ui/linermainui_atlas", "area" .. iter_9_1, true))

			local var_9_5 = table.contains(self.finishRoomIds, iter_9_1)
			local var_9_6

			if not var_9_5 then
				var_9_0 = true
				var_9_6 = var_9_5 and var_9_4:GetDesc() or ""
			end

			setText(var_9_3, var_9_6)
			setActive(var_9_2:Find("empty"), not var_9_5)
		end
	end

	for iter_9_2 = #var_9_1 + 1, #self.itemTFs do
		setActive(self.itemTFs[iter_9_2], false)
	end

	local var_9_7 = self.groups[self.curIdx]:GetDrop()

	updateDrop(self.awardTF, var_9_7)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_9_7)

		return
	end, SFX_PANEL)

	local var_9_8 = self.activity:IsGotRoomAward(self.curIdx)
	local var_9_9 = not var_9_8 and not var_9_0

	setActive(self.goBtn, not var_9_8 and not var_9_9)
	setActive(self.gotTF, var_9_8)
	setActive(self.awardTF:Find("mask"), var_9_8)
	setActive(self.getBtn, var_9_9)
	self:Show()

	return
end

function LinerLogRoomPage:OnDestroy()
	return
end

function LinerLogRoomPage:IsTipWithGroupId(arg_12_1)
	if self:IsGotRoomAward((table.indexof(self:GetRoomGroupIds(), arg_12_1))) then
		return false
	end

	local var_12_0 = self:GetExploredRoomIds()

	return underscore.all(pg.activity_liner_room_group[arg_12_1].ids, function(arg_13_0)
		return table.contains(var_12_0, arg_13_0)
	end)
end

function LinerLogRoomPage.IsTip()
	local var_14_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LINER)

	assert(var_14_0 and not var_14_0:isEnd(), "not exist liner act, type: " .. ActivityConst.ACTIVITY_TYPE_LINER)

	return underscore.any(var_14_0:GetRoomGroupIds(), function(arg_15_0)
		return LinerLogRoomPage.IsTipWithGroupId(var_14_0, arg_15_0)
	end)
end

return LinerLogRoomPage
