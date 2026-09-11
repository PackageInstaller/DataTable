local SpringFestivalRiddleMainItem = class("SpringFestivalRiddleMainItem", ReduxView)

function SpringFestivalRiddleMainItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.activityID_ = arg_1_2
	self.questionID_ = arg_1_3

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "riddlesBtn")
end

function SpringFestivalRiddleMainItem:Dispose()
	SpringFestivalRiddleMainItem.super.Dispose(self)
end

function SpringFestivalRiddleMainItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("springFestivalRiddleQuestion", {
			activityID = self.activityID_,
			questionID = self.questionID_
		})
	end)
end

function SpringFestivalRiddleMainItem:RefreshState(arg_5_1)
	if table.keyof(SpringFestivalRiddleData:GetQuestionAnswerList(self.activityID_, self.questionID_), ActivitySpringFestivalRiddleCfg[self.questionID_].correct_answer) then
		self.controller_:SetSelectedState("finish")
	elseif arg_5_1 == false then
		self.controller_:SetSelectedState("normal")
	else
		self.controller_:SetSelectedState("receive")
	end
end

return SpringFestivalRiddleMainItem
