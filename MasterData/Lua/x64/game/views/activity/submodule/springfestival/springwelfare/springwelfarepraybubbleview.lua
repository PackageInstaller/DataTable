SpringPreheatPrayBubbleView = import("game.views.activity.Submodule.springFestival.springPreheat.SpringPreheatPrayBubbleView")

local SpringWelfarePrayBubbleView = class("SpringWelfarePrayBubbleView", SpringPreheatPrayBubbleView)

function SpringWelfarePrayBubbleView:Init()
	SpringWelfarePrayBubbleView.super.Init(self)

	self.signController_ = ControllerUtil.GetController(self.transform_, "sign")
	self.acquireController_ = ControllerUtil.GetController(self.transform_, "acquire")
end

function SpringWelfarePrayBubbleView:SwitchController(arg_2_1)
	if not self.selectController_ or not self.lockController_ or not self.signController_ or not self.acquireController_ then
		return
	end

	self.lockController_:SetSelectedState("false")
	self.selectController_:SetSelectedState("selected")

	if arg_2_1 == SPRING_WELFARE_DAY_STATE_TYPE.ACQUIRED then
		self.acquireController_:SetSelectedState("acquired")
		self.signController_:SetSelectedState("false")
	elseif arg_2_1 == SPRING_WELFARE_DAY_STATE_TYPE.NOT_ACQUIRE then
		self.acquireController_:SetSelectedState("notready")
		self.signController_:SetSelectedState("false")
	elseif arg_2_1 == SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN then
		self.acquireController_:SetSelectedState("ready")
		self.signController_:SetSelectedState("true")
	elseif arg_2_1 == SPRING_WELFARE_DAY_STATE_TYPE.CAN_PRAY then
		self.acquireController_:SetSelectedState("ready")
		self.signController_:SetSelectedState("false")
	end
end

function SpringWelfarePrayBubbleView:GetDayState()
	return (SpringWelfareData:GetDayState(self.day_))
end

function SpringWelfarePrayBubbleView:GetPraySelectionList()
	return SpringWelfareData:GetPraySelectionList(self.day_)
end

return SpringWelfarePrayBubbleView
