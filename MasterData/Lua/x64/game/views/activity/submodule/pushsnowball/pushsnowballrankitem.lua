local AdvanceTestRankItem = class("AdvanceTestRankItem", ReduxView)

function AdvanceTestRankItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
end

function AdvanceTestRankItem:initUI()
	self:BindCfgUI()

	self.rankController_ = ControllerUtil.GetController(self.transform_, "rank")
	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
end

function AdvanceTestRankItem:Refresh(arg_3_1, arg_3_2)
	self.rankText_.text = arg_3_1.rank

	if arg_3_2 == 1 then
		self.scoreText_.text = arg_3_1.score
		self.campText_.text = arg_3_1.extraInfo[1] == 1 and "Boss" or GetTips("ACTIVITY_SNOWBALL_PUSH_RANK_TEAM")

		self.stateController_:SetSelectedState("boss")
	else
		self.campText_.text = ""
		self.killNumText_.text = arg_3_1.score

		self.stateController_:SetSelectedState("neck")
	end

	if arg_3_1.rank <= 3 then
		self.rankController_:SetSelectedIndex(arg_3_1.rank - 1)
	else
		self.rankController_:SetSelectedIndex(3)
	end

	self.nameText_.text = arg_3_1.nick
	self.iconImg_.sprite = ItemTools.getItemSprite(arg_3_1.portrait)
	self.frameImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. arg_3_1.frame)
end

return AdvanceTestRankItem
