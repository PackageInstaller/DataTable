local EducateScheduleResultLayer = class("EducateScheduleResultLayer", import(".base.EducateBaseUI"))

function EducateScheduleResultLayer:getUIName()
	return "EducateScheduleResultUI"
end

function EducateScheduleResultLayer:init()
	self.anim = self._tf:Find("anim_root"):GetComponent(typeof(Animation))
	self.animEvent = self._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))
	self.inAnimPlaying = true

	self.animEvent:SetEndEvent(function()
		self.inAnimPlaying = false

		self.animEvent:SetEndEvent(function()
			self:emit(EducateScheduleResultLayer.ON_CLOSE)

			return
		end)

		return
	end)

	self.windowTF = self._tf:Find("anim_root/window")
	self.personalTF = self.windowTF:Find("personal")
	self.majorArrTF = self.windowTF:Find("major")
	self.minorArrTF = self.windowTF:Find("minor")
	self.resTF = self.windowTF:Find("res/content")

	setText(self.windowTF:Find("tip"), i18n("child_close_tip"))
	self:BlurPanel(self._tf, {
		groupDelta = 1
	})

	return
end

function EducateScheduleResultLayer:didEnter()
	onButton(self, self._tf, function()
		self:_close()

		return
	end, SFX_CANCEL)

	self.result = {}
	self.resResult = {}
	self.resultEvent = {}
	self.resResultEvent = {}
	self.drops = {}

	local function var_5_0(arg_7_0, arg_7_1)
		for iter_7_0, iter_7_1 in ipairs(arg_7_0) do
			table.insert(self.drops, iter_7_1)

			if iter_7_1.type == EducateConst.DROP_TYPE_ATTR then
				if arg_7_1 then
					self.resultEvent[iter_7_1.id] = self.resultEvent[iter_7_1.id] or 0
					self.resultEvent[iter_7_1.id] = self.resultEvent[iter_7_1.id] + iter_7_1.number
				else
					self.result[iter_7_1.id] = self.result[iter_7_1.id] or 0
					self.result[iter_7_1.id] = self.result[iter_7_1.id] + iter_7_1.number
				end
			end

			if iter_7_1.type == EducateConst.DROP_TYPE_RES then
				if arg_7_1 then
					self.resResultEvent[iter_7_1.id] = self.resResultEvent[iter_7_1.id] or 0
					self.resResultEvent[iter_7_1.id] = self.resResultEvent[iter_7_1.id] + iter_7_1.number
				else
					self.resResult[iter_7_1.id] = self.resResult[iter_7_1.id] or 0
					self.resResult[iter_7_1.id] = self.resResult[iter_7_1.id] + iter_7_1.number
				end
			end
		end

		return
	end

	for iter_5_0, iter_5_1 in ipairs(self.contextData.plan_results or {}) do
		var_5_0(iter_5_1.plan_drops)
		var_5_0(iter_5_1.event_drops, true)
		var_5_0(iter_5_1.spec_event_drops)
	end

	self.char = getProxy(EducateProxy):GetCharData()
	self.natureIds = self.char:GetAttrIdsByType(EducateChar.ATTR_TYPE_PERSONALITY)
	self.majorIds = self.char:GetAttrIdsByType(EducateChar.ATTR_TYPE_MAJOR)
	self.minorIds = self.char:GetAttrIdsByType(EducateChar.ATTR_TYPE_MINOR)
	self.resIds = {
		EducateChar.RES_MOOD_ID,
		EducateChar.RES_MONEY_ID
	}

	self:updatePersonalPanel()
	self:updateMajorPanel()
	self:updateMinorPanel()
	self:updateResPanel()

	return
end

function EducateScheduleResultLayer:updatePersonalPanel()
	local var_8_0 = EducateHelper.IsShowNature()

	setActive(self.personalTF, var_8_0)

	if var_8_0 then
		for iter_8_0, iter_8_1 in ipairs(self.natureIds) do
			local var_8_1 = self.personalTF:Find(tostring(iter_8_1))

			setText(var_8_1:Find("old"), pg.child_attr[iter_8_1].name .. " " .. self.char:GetAttrById(iter_8_1))

			local var_8_2 = self.result[iter_8_1] or 0

			setActive(var_8_1:Find("new"), var_8_2 ~= 0)

			if var_8_2 ~= 0 then
				local var_8_3 = var_8_2 > 0 and "39BFFF" or "FF6767"

				setText(var_8_1:Find("new"), (var_8_2 > 0 and "+" or "") .. " " .. var_8_2)
				setTextColor(var_8_1:Find("new"), Color.NewHex(var_8_3))
			end
		end
	end

	return
end

function EducateScheduleResultLayer:updateMajorPanel()
	for iter_9_0 = 1, self.majorArrTF.childCount do
		local var_9_0 = self.majorArrTF:GetChild(iter_9_0 - 1)

		GetImageSpriteFromAtlasAsync("ui/educatecommonui_atlas", "attr_" .. self.majorIds[iter_9_0], var_9_0:Find("icon_bg/icon"), true)
		setScrollText(var_9_0:Find("name_mask/name"), pg.child_attr[self.majorIds[iter_9_0]].name)

		local var_9_1 = self.char:GetAttrInfo(self.majorIds[iter_9_0])

		setText(var_9_0:Find("grade/Text"), var_9_1)

		local var_9_2 = self.char:GetAttrById(self.majorIds[iter_9_0])

		setText(var_9_0:Find("value_old"), var_9_2)
		setImageColor(var_9_0:Find("gradient"), Color.NewHex(EducateConst.GRADE_2_COLOR[var_9_1][1]))
		setImageColor(var_9_0:Find("grade"), Color.NewHex(EducateConst.GRADE_2_COLOR[var_9_1][2]))

		local var_9_3 = self.result[self.majorIds[iter_9_0]] or 0
		local var_9_4 = var_9_3 == 0 and "39393C" or "39BFFF"

		setActive(var_9_0:Find("VX"), var_9_3 ~= 0)
		setImageColor(var_9_0:Find("arrow"), Color.NewHex(var_9_4))
		setText(var_9_0:Find("value_new"), var_9_2 + var_9_3)
		setTextColor(var_9_0:Find("value_new"), Color.NewHex(var_9_4))
	end

	return
end

function EducateScheduleResultLayer:updateMinorPanel()
	for iter_10_0 = 1, self.minorArrTF.childCount do
		local var_10_0 = self.minorArrTF:GetChild(iter_10_0 - 1)

		GetImageSpriteFromAtlasAsync("ui/educatecommonui_atlas", "attr_" .. self.minorIds[iter_10_0], var_10_0:Find("icon"), true)
		setText(var_10_0:Find("name"), pg.child_attr[self.minorIds[iter_10_0]].name)
		setText(var_10_0:Find("value/value/old"), (self.char:GetAttrById(self.minorIds[iter_10_0])))

		local var_10_1 = self.result[self.minorIds[iter_10_0]] or 0

		setText(var_10_0:Find("value/value/add"), "")

		local var_10_2 = self.resultEvent[self.minorIds[iter_10_0]] or 0

		setText(var_10_0:Find("value/event_add"), "")

		local var_10_3 = var_10_1 ~= 0 or var_10_2 ~= 0

		setActive(var_10_0:Find("VX"), var_10_1 ~= 0 or var_10_2 ~= 0)

		if var_10_3 then
			onDelayTick(function()
				if var_10_1 > 0 then
					setText(var_10_0:Find("value/value/add"), "+" .. var_10_1)
				end

				if var_10_2 > 0 then
					setText(var_10_0:Find("value/event_add"), "+" .. var_10_2)
				end

				return
			end, 0.891)
		end
	end

	return
end

function EducateScheduleResultLayer:updateResPanel()
	for iter_12_0 = 1, #self.resIds do
		local var_12_0 = self.resTF:GetChild(iter_12_0 - 1)
		local var_12_1 = self.resIds[iter_12_0]

		GetImageSpriteFromAtlasAsync("ui/educatecommonui_atlas", "res_" .. self.resIds[iter_12_0], var_12_0:Find("icon"), true)
		setText(var_12_0:Find("name"), pg.child_resource[var_12_1].name)

		local var_12_2 = self.char:GetResById(var_12_1)

		if var_12_2 < 0 then
			var_12_2 = 0
		end

		setText(var_12_0:Find("value/value/old"), var_12_2)

		local var_12_3 = self.resResult[var_12_1]
		local var_12_5
		local var_12_4

		if not self.resResult[var_12_1] then
			var_12_3 = 0
			var_12_4 = setText
			var_12_5 = var_12_0:Find("value/value/add")
		end

		var_12_4(var_12_5, var_12_3 == 0 and "" or "+" .. var_12_3)

		local var_12_6 = self.resResultEvent[var_12_1]
		local var_12_8
		local var_12_7

		if not self.resResultEvent[var_12_1] then
			var_12_6 = 0
			var_12_7 = setText
			var_12_8 = var_12_0:Find("value/event_add")
		end

		var_12_7(var_12_8, var_12_6 == 0 and "" or "+" .. var_12_6)
	end

	return
end

function EducateScheduleResultLayer:_close()
	if self.inAnimPlaying then
		return
	end

	self.anim:Play("anim_educate_result_out")

	return
end

function EducateScheduleResultLayer:onBackPressed()
	self:_close()

	return
end

function EducateScheduleResultLayer:willExit()
	getProxy(EducateProxy):OnNextWeek()
	self.animEvent:SetEndEvent(nil)

	if self.drops then
		EducateHelper.UpdateDropsData(self.drops)
	end

	self:UnOverlayPanel(self._tf)

	if self.contextData.onExit then
		self.contextData.onExit()
	end

	return
end

return EducateScheduleResultLayer
