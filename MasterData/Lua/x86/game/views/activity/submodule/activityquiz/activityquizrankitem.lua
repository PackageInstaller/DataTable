local QuizFunction = import("game.quiz.QuizFunction")
local ActivityQuizRankItem = class("ActivityQuizRankItem", ReduxView)

function ActivityQuizRankItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityQuizRankItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityQuizRankItem:InitUI()
	self:BindCfgUI()

	self.mineCon_ = ControllerUtil.GetController(self.transform_, "mine")
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "rank")
end

function ActivityQuizRankItem:AddUIListeners()
	return
end

function ActivityQuizRankItem:RefreshData(arg_5_1, arg_5_2)
	self.id_ = arg_5_1
	self.index_ = arg_5_2
	self.data_ = QuizFunction:GetRankData(arg_5_1)
	self.scroe_.text = self.data_.score
	self.nick_.text = self.data_.nick
	self.rank_.text = self.index_

	if self.index_ > 3 then
		self.stateCon_:SetSelectedState("other")
	else
		self.stateCon_:SetSelectedState(self.index_)
	end
end

function ActivityQuizRankItem:SetMine(arg_6_1)
	if self.mineCon_ then
		self.mineCon_:SetSelectedState(arg_6_1 and "me" or "other")
	end
end

function ActivityQuizRankItem:OnExit()
	return
end

function ActivityQuizRankItem:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivityQuizRankItem
