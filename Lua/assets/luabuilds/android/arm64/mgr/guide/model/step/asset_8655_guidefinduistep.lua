local GuideFindUIStep = class("GuideFindUIStep", import(".GuideStep"))

GuideFindUIStep.TRIGGER_TYPE_BUTTON = 1
GuideFindUIStep.TRIGGER_TYPE_TOGGLE = 2
GuideFindUIStep.EVENT_TYPE_CLICK = 3
GuideFindUIStep.EVENT_TYPE_STICK = 4
GuideFindUIStep.SHOW_UI = 5
GuideFindUIStep.TRIGGER_TYPE_BUTTONEX = 6
GuideFindUIStep.SNAP_PAGE = 7
GuideFindUIStep.EVENT_TYPE_EVT_CLICK = 8

function GuideFindUIStep:Ctor(arg_1_1)
	GuideFindUIStep.super.Ctor(self, arg_1_1)

	self.eventUI = self:GenEventSearchData(arg_1_1.ui)

	return
end

function GuideFindUIStep:GenEventSearchData(arg_2_1)
	if not arg_2_1 then
		return nil
	end

	local var_2_0 = self:GenSearchData(arg_2_1)
	local var_2_1 = arg_2_1.scale ~= nil
	local var_2_2 = arg_2_1.scale or 1

	if arg_2_1.dynamicPath then
		local var_2_3, var_2_4 = arg_2_1.dynamicPath()

		if var_2_3 then
			var_2_0.path = var_2_3
		end

		if var_2_4 then
			var_2_1 = true
			var_2_2 = var_2_4
		end
	end

	local var_2_5 = {
		pos = arg_2_1.pos,
		scale = var_2_2,
		eulerAngles = arg_2_1.eulerAngles,
		isLevelPoint = arg_2_1.isLevelPoint,
		image = arg_2_1.image
	}
	local var_2_6 = arg_2_1.pos

	if not arg_2_1.pos and not var_2_1 then
		::label_2_0::

		var_2_6 = arg_2_1.eulerAngles or arg_2_1.isLevelPoint
	end

	var_2_5.customPosition = var_2_6
	var_2_5.clearChildEvent = arg_2_1.eventPath ~= nil
	var_2_5.keepScrollTxt = arg_2_1.keepScrollTxt
	var_2_0.settings = var_2_5

	local var_2_7
	local var_2_8

	if arg_2_1.onClick then
		var_2_7 = GuideFindUIStep.TRIGGER_TYPE_BUTTONEX
		var_2_8 = arg_2_1.onClick
	else
		var_2_7 = arg_2_1.triggerType and arg_2_1.triggerType[1] or GuideFindUIStep.TRIGGER_TYPE_BUTTON
		var_2_8 = arg_2_1.triggerType and arg_2_1.triggerType[2]
	end

	local var_2_9 = arg_2_1.eventPath

	if arg_2_1.dynamicEventPath then
		var_2_9 = arg_2_1.dynamicEventPath()
	end

	var_2_0.triggerData = {
		type = var_2_7,
		arg = var_2_8
	}
	var_2_0.childIndex = arg_2_1.eventIndex
	var_2_0.eventPath = var_2_9
	var_2_0.fingerPos = arg_2_1.fingerPos
	var_2_0.slipAnim = var_2_7 == GuideFindUIStep.SNAP_PAGE

	return var_2_0
end

function GuideFindUIStep:GetType()
	return GuideStep.TYPE_FINDUI
end

function GuideFindUIStep:GetEventUI()
	return self.eventUI
end

return GuideFindUIStep
