local NewEducateScheduleResultLayer = class("NewEducateScheduleResultLayer", import("view.newEducate.base.NewEducateBaseUI"))

function NewEducateScheduleResultLayer:getUIName()
	return "NewEducateScheduleResultUI"
end

function NewEducateScheduleResultLayer:SetData()
	self.attrIds = self.contextData.char:GetAttrIds()
	self.moneyResId = self.contextData.char:GetResIdByType(NewEducateChar.RES_TYPE.MONEY)
	self.moodResId = self.contextData.char:GetResIdByType(NewEducateChar.RES_TYPE.MOOD)
	self.resIds = {
		self.moneyResId,
		self.moodResId
	}
	self.unlockPlanNum = self.contextData.char:GetRoundData():getConfig("plan_num")
	self.planIds = self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.PLAN):GetPlans()

	return
end

function NewEducateScheduleResultLayer:init()
	self.rootTF = self._tf:Find("root")
	self.anim = self.rootTF:GetComponent(typeof(Animation))
	self.animEvent = self.rootTF:GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		self:emit(NewEducateScheduleResultLayer.ON_CLOSE)

		return
	end)

	self.plansTF = self.rootTF:Find("window/plans/content")
	self.planUIList = UIItemList.New(self.plansTF, self.plansTF:Find("tpl"))
	self.attrsTF = self.rootTF:Find("window/attr")
	self.attrUIList = UIItemList.New(self.attrsTF, self.attrsTF:Find("tpl"))
	self.resTF = self.rootTF:Find("window/res/content")
	self.resUIList = UIItemList.New(self.resTF, self.resTF:Find("tpl"))

	setText(self.rootTF:Find("window/tip"), i18n("child_close_tip"))

	self.moodTF = self.rootTF:Find("window/benefit/mood")
	self.moodStageTF = self.moodTF:Find("left/Text")
	self.moodEffectTF = self.moodTF:Find("right/value")

	setText(self.moodTF:Find("right/Text"), i18n("child2_mood_benefit"))
	self:BlurPanel(self._tf, {
		groupDelta = 1
	})

	return
end

function NewEducateScheduleResultLayer:didEnter()
	self:SetData()
	onButton(self, self._tf, function()
		self:_close()

		return
	end, SFX_CANCEL)

	self.result = {}
	self.benefit = {}

	underscore.each(self.contextData.drops, function(arg_7_0)
		self.result[arg_7_0.id] = self.result[arg_7_0.id] or 0
		self.result[arg_7_0.id] = self.result[arg_7_0.id] + arg_7_0.number

		if arg_7_0.isBenefit then
			self.benefit[arg_7_0.type] = self.benefit[arg_7_0.type] or {}
			self.benefit[arg_7_0.type][arg_7_0.id] = self.benefit[arg_7_0.type][arg_7_0.id] or 0
			self.benefit[arg_7_0.type][arg_7_0.id] = self.benefit[arg_7_0.type][arg_7_0.id] + arg_7_0.number
		end

		return
	end)

	local var_5_0 = self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.PLAN)

	self.oldRes = var_5_0:GetResources() or {}
	self.oldAttrs = var_5_0:GetAttrs() or {}

	self:UpdataMood()
	self.attrUIList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			self:UpdateAttr(arg_8_1, arg_8_2)
		end

		return
	end)
	self.attrUIList:align(#self.attrIds)
	self.resUIList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			self:UpdateRes(arg_9_1, arg_9_2)
		end

		return
	end)
	self.resUIList:align(#self.resIds)
	self.planUIList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			self:UpdatePlan(arg_10_1, arg_10_2)
		end

		return
	end)
	self.planUIList:align(self.unlockPlanNum)

	return
end

function NewEducateScheduleResultLayer:UpdataMood()
	local var_11_0, var_11_1 = self.contextData.char:GetMoodStage()

	setText(self.moodStageTF, i18n("child2_mood_stage" .. var_11_0))
	setText(self.moodEffectTF, var_11_1 / 100 .. "%")
	setActive(self.moodTF:Find("buff"), var_11_1 >= 0)
	setActive(self.moodTF:Find("debuff"), var_11_1 < 0)

	return
end

function NewEducateScheduleResultLayer:GetExtraStr(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = ""

	if arg_12_3 ~= 0 then
		var_12_0 = setColorStr((arg_12_3 > 0 and "+" or "") .. arg_12_3, arg_12_3 > 0 and "#22AFFF" or "#FF6767")
	end

	local var_12_2 = arg_12_2 - arg_12_3 - arg_12_1

	return ((arg_12_2 - arg_12_3 - arg_12_1 ~= 0 or nil) and setColorStr((var_12_2 > 0 and "+" or "") .. var_12_2, var_12_2 > 0 and "#393A3C" or "#FF6767")) .. var_12_0
end

function NewEducateScheduleResultLayer:UpdateAttr(arg_13_1, arg_13_2)
	LoadImageSpriteAsync("neweducateicon/" .. pg.child2_attr[self.attrIds[arg_13_1 + 1]].icon, arg_13_2:Find("icon_bg/icon"))
	setScrollText(arg_13_2:Find("name_mask/name"), pg.child2_attr[self.attrIds[arg_13_1 + 1]].name)

	local var_13_0 = self.attrIds[arg_13_1 + 1]
	local var_13_1 = self.contextData.char:GetAttr(self.attrIds[arg_13_1 + 1])
	local var_13_2, var_13_3 = NewEducateInfoPanel.GetArrtInfo(pg.child2_attr[self.attrIds[arg_13_1 + 1]].rank, var_13_1)

	setText(arg_13_2:Find("rank/Text"), var_13_2)
	setText(arg_13_2:Find("value_new"), var_13_1)
	setImageColor(arg_13_2:Find("gradient"), Color.NewHex(EducateConst.GRADE_2_COLOR[var_13_2][1]))
	setImageColor(arg_13_2:Find("rank"), Color.NewHex(EducateConst.GRADE_2_COLOR[var_13_2][2]))

	local var_13_4 = self.oldAttrs[var_13_0]
	local var_13_5

	if not self.oldAttrs[var_13_0] then
		var_13_4 = var_13_1
		var_13_5 = var_13_1 - var_13_4 > 0 and "16CF99" or "FF6767"
	end

	if var_13_1 - var_13_4 == 0 then
		var_13_5 = "393A3C"
	end

	setImageColor(arg_13_2:Find("arrow"), Color.NewHex(var_13_5))
	setTextColor(arg_13_2:Find("value_new"), Color.NewHex(var_13_5))
	setText(arg_13_2:Find("value_old"), math.max(var_13_4, 0) .. self:GetExtraStr(var_13_4, var_13_1, (self.benefit[NewEducateConst.DROP_TYPE.ATTR] or nil) and (self.benefit[NewEducateConst.DROP_TYPE.ATTR][var_13_0] or 0)))
	setActive(arg_13_2:Find("VX"), var_13_4 ~= var_13_1)

	return
end

function NewEducateScheduleResultLayer:UpdateRes(arg_14_1, arg_14_2)
	local var_14_0 = self.resIds[arg_14_1 + 1]

	LoadImageSpriteAsync("neweducateicon/" .. pg.child2_resource[self.resIds[arg_14_1 + 1]].icon, arg_14_2:Find("icon"))
	setText(arg_14_2:Find("name"), pg.child2_resource[var_14_0].name)

	local var_14_1 = self.contextData.char:GetRes(var_14_0)
	local var_14_2 = self.oldRes[var_14_0]
	local var_14_3

	if not self.oldRes[var_14_0] then
		var_14_2 = var_14_1
		var_14_3 = var_14_1 - var_14_2 > 0 and "16CF99" or "FF6767"
	end

	if var_14_1 - var_14_2 == 0 then
		var_14_3 = "393A3C"
	end

	setText(arg_14_2:Find("value_new"), var_14_1)
	setImageColor(arg_14_2:Find("arrow"), Color.NewHex(var_14_3))
	setTextColor(arg_14_2:Find("value_new"), Color.NewHex(var_14_3))
	setText(arg_14_2:Find("value_old"), math.max(var_14_2, 0) .. self:GetExtraStr(var_14_2, var_14_1, (self.benefit[NewEducateConst.DROP_TYPE.RES] or nil) and (self.benefit[NewEducateConst.DROP_TYPE.RES][var_14_0] or 0)))

	return
end

function NewEducateScheduleResultLayer:UpdatePlan(arg_15_1, arg_15_2)
	setActive(arg_15_2:Find("bg/icon"), self.planIds[arg_15_1 + 1])
	setActive(arg_15_2:Find("bg/empty"), not self.planIds[arg_15_1 + 1])

	if self.planIds[arg_15_1 + 1] then
		LoadImageSpriteAtlasAsync("ui/neweducatecommonui_atlas", "plan_type" .. pg.child2_plan[self.planIds[arg_15_1 + 1]].replace_type_show, arg_15_2:Find("bg/icon"))
	end

	setActive(arg_15_2:Find("dot"), arg_15_1 + 1 ~= self.unlockPlanNum)

	return
end

function NewEducateScheduleResultLayer:_close()
	self.anim:Play("anim_educate_result_out")

	return
end

function NewEducateScheduleResultLayer:onBackPressed()
	self:_close()

	return
end

function NewEducateScheduleResultLayer:willExit()
	self:UnOverlayPanel(self._tf)
	existCall(self.contextData.onExit)
	self.animEvent:SetEndEvent(nil)

	return
end

return NewEducateScheduleResultLayer
