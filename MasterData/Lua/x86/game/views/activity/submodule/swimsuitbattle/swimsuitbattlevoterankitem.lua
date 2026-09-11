local SwimsuitBattleVoteRankItem = class("SwimsuitBattleVoteRankItem", ReduxView)

function SwimsuitBattleVoteRankItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function SwimsuitBattleVoteRankItem:SetData(arg_2_1, arg_2_2)
	self.nameText_.text = HeroTools.GetHeroFullName(SwimsuitVoteHeroCfg[arg_2_1].hero_id)
	self.voteNum_.text = arg_2_2
end

function SwimsuitBattleVoteRankItem:Dispose()
	SwimsuitBattleVoteRankItem.super.Dispose(self)
end

return SwimsuitBattleVoteRankItem
