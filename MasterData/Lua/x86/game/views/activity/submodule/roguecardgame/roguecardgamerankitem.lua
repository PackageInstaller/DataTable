local RogueCardGameRankItem = class("RogueCardGameRankItem", BaseView)

function RogueCardGameRankItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function RogueCardGameRankItem:InitUI()
	self:BindCfgUI()

	self.commonPortrait = CommonHeadPortrait.New(self.headItem_)

	self:AddUIListeners()

	self.rankController = self.conExCollection_:GetController("rank")
	self.viewController = self.conExCollection_:GetController("viewBtn")
end

function RogueCardGameRankItem:AddUIListeners()
	self:AddBtnListener(self.viewBtn_, nil, function()
		JumpTools.OpenPageByJump("rogueCardGameRankPopView", {
			dataList = self.data
		})
	end)
end

function RogueCardGameRankItem:Dispose()
	self.commonPortrait:Dispose()
	RogueCardGameRankItem.super.Dispose(self)
end

function RogueCardGameRankItem:GetRankActivityID()
	return ActivityConst.ACTIVITY_ROGUECARD_5_0
end

function RogueCardGameRankItem:SetData(arg_7_1)
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

	if #arg_7_1.extraInfo > 0 then
		self.viewController:SetSelectedState("normal")
	else
		self.viewController:SetSelectedState("lock")
	end
end

return RogueCardGameRankItem
