local AutoChessRankItem = class("AutoChessRankItem", BaseView)

function AutoChessRankItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function AutoChessRankItem:InitUI()
	self:BindCfgUI()

	self.commonPortrait = CommonHeadPortrait.New(self.headItem_)

	self:AddUIListeners()

	self.rankController = self.conExCollection_:GetController("rank")
	self.viewController = self.conExCollection_:GetController("viewBtn")
end

function AutoChessRankItem:AddUIListeners()
	self:AddBtnListener(self.viewBtn_, nil, function()
		AutoChessAction.OpenTeamnfoPopAfterFetch(self:GetRankActivityID(), self.data)
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_rank_team_touch",
			activity_id = AutoChessData:GetActivityID(),
			source = self.data.user_id
		})
	end)
end

function AutoChessRankItem:Dispose()
	self.commonPortrait:Dispose()
	AutoChessRankItem.super.Dispose(self)
end

function AutoChessRankItem:GetRankActivityID()
	return 3740701
end

function AutoChessRankItem:SetData(arg_7_1)
	self.data = arg_7_1
	self.rankText_.text = GetI18NText(arg_7_1.rank)
	self.scoreText_.text = GetI18NText(arg_7_1.score)

	if arg_7_1.rank <= 3 then
		self.rankController:SetSelectedIndex(arg_7_1.rank)
	else
		self.rankController:SetSelectedIndex(0)
	end

	self.nickText_.text = GetI18NText(arg_7_1.nick)

	self.commonPortrait:RenderHead(arg_7_1.portrait)
	self.commonPortrait:RenderFrame(arg_7_1.frame)
end

return AutoChessRankItem
