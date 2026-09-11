local HodurRankItem = class("HodurRankItem", BaseView)

function HodurRankItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function HodurRankItem:InitUI()
	self:BindCfgUI()

	self.commonPortrait = CommonHeadPortrait.New(self.headItem_)

	self:AddUIListeners()

	self.rankController = self.conExCollection_:GetController("rank")
	self.viewController = self.conExCollection_:GetController("viewBtn")
end

function HodurRankItem:AddUIListeners()
	self:AddBtnListener(self.viewBtn_, nil, function()
		JumpTools.OpenPageByJump("hodurRankSquadsView", {
			list = self.heroList,
			affix_list = self.data.extraInfo
		})
	end)
end

function HodurRankItem:Dispose()
	self.commonPortrait:Dispose()
	HodurRankItem.super.Dispose(self)
end

function HodurRankItem:GetRankActivityID()
	return ActivityConst.ACTIVITY_HODUR_RANK
end

function HodurRankItem:SetData(arg_7_1)
	self.data = arg_7_1
	self.rankText_.text = GetI18NText(arg_7_1.rank)
	self.scoreText_.text = GetI18NText(arg_7_1.score)
	self.heroList = arg_7_1:GetSingleSelectHeroList()

	if arg_7_1.rank <= 3 then
		self.rankController:SetSelectedIndex(arg_7_1.rank)
	else
		self.rankController:SetSelectedIndex(0)
	end

	self.nickText_.text = GetI18NText(arg_7_1.nick)

	self.commonPortrait:RenderHead(arg_7_1.portrait)
	self.commonPortrait:RenderFrame(arg_7_1.frame)
end

return HodurRankItem
