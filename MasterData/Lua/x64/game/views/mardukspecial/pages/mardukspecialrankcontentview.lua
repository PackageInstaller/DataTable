local MardukSpecialRankContentView = class("MardukSpecialRankContentView", ReduxView)

function MardukSpecialRankContentView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MardukSpecialRankContentView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MardukSpecialRankContentView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.listGo_, MardukSpecialRankItemView)
end

function MardukSpecialRankContentView:indexItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, self.data_.rankList[arg_4_1])
end

function MardukSpecialRankContentView:AddUIListener()
	return
end

function MardukSpecialRankContentView:AddEventListeners()
	return
end

function MardukSpecialRankContentView:SetData(arg_7_1, arg_7_2)
	self.activityId_ = activityId
	self.battleId_ = arg_7_1
	self.battleCfg_ = BattleQuickTrainingCfg[arg_7_1]
	self.data_ = RankData:GetActivityRank(arg_7_2)

	self:UpdateView()
end

function MardukSpecialRankContentView:SetMySelfData(arg_8_1)
	local var_8_0 = PlayerData:GetPlayerInfo()

	self.frame_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. var_8_0.icon_frame)
	self.name_.text = GetI18NText(var_8_0.nick)
	self.icon_.sprite = ItemTools.getItemSprite(var_8_0 and var_8_0.portrait)
	self.battleId_ = arg_8_1
	self.battleCfg_ = BattleQuickTrainingCfg[arg_8_1]
	self.rankNameLabel_.text = self.battleCfg_.name
end

function MardukSpecialRankContentView:UpdateView()
	if not self.data_ then
		return
	end

	self.uiList_:StartScroll(#self.data_.rankList)

	if self.data_.myRank and self.data_.myRank.score > 0 then
		if self.data_.myRank.rank >= 1 and self.data_.myRank.rank <= 100 then
			self.rank_.text = self.data_.myRank.rank
			self.score_.text = self.data_.myRank.score
		else
			self.rank_.text = string.format("%.2f", self.data_.myRank.rank / (self.data_.total or 1) * 100) .. "%"
			self.score_.text = self.data_.myRank.score
		end
	else
		self.rank_.text = GetTips("MATRIX_RANK_NO_RANK")
		self.score_.text = GetTips("MATRIX_RANK_NO_INFO")
	end
end

function MardukSpecialRankContentView:OnEnter()
	self:AddEventListeners()
end

function MardukSpecialRankContentView:OnExit()
	self:RemoveAllEventListener()
end

function MardukSpecialRankContentView:OnMainHomeViewTop()
	return
end

function MardukSpecialRankContentView:Dispose()
	self.data_ = nil

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	MardukSpecialRankContentView.super.Dispose(self)
end

return MardukSpecialRankContentView
