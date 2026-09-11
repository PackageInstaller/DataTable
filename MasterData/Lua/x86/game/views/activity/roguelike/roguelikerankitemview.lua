local RoguelikeRankItemView = class("RoguelikeRankItemView", ReduxView)

function RoguelikeRankItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RoguelikeRankItemView:Init()
	self.gameObject_:InjectUI(self)

	self.commonPortrait_ = CommonHeadPortrait.New(self.GoHeadItem)

	self:AddUIListener()
end

function RoguelikeRankItemView:InitUI()
	return
end

function RoguelikeRankItemView:AddUIListener()
	return
end

function RoguelikeRankItemView:AddEventListeners()
	return
end

function RoguelikeRankItemView:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.index = arg_6_1
	self.data = arg_6_2
	self.isGuild = arg_6_3

	self:UpdateView()
end

function RoguelikeRankItemView:UpdateView()
	local var_7_0 = self.data:GetSingleSelectHeroList()
	local var_7_1 = var_7_0[1].skin_id

	if var_7_0[1].skin_id == 0 then
		var_7_1 = var_7_0[1].hero_id
	end

	self.commonPortrait_:RenderHead(self.data.portrait)
	self.commonPortrait_:RenderFrame(self.data.frame)

	self.ImgRole.sprite = ItemTools.getItemSprite(var_7_1)

	if self.data.rank < 4 then
		self.CtrlRank:SetSelectedIndex(self.data.rank)
	else
		self.CtrlRank:SetSelectedIndex(0)
	end

	self.TxtRank.text = self.data.rank
	self.TxtNick.text = self.data.nick
	self.TxtScore.text = self.data.score
	self.TxtDifficulty.text = self.data.difficulty
end

function RoguelikeRankItemView:OnEnter()
	self:AddEventListeners()
end

function RoguelikeRankItemView:OnExit()
	self:RemoveAllEventListener()
end

function RoguelikeRankItemView:OnMainHomeViewTop()
	return
end

function RoguelikeRankItemView:Dispose()
	self.commonPortrait_:Dispose()

	self.data = nil

	RoguelikeRankItemView.super.Dispose(self)
end

return RoguelikeRankItemView
