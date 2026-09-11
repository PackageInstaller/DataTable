local ActivityRaceRankItem = class("ActivityRaceRankItem", ReduxView)

function ActivityRaceRankItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityRaceRankItem:Init()
	self:InitUI()
end

function ActivityRaceRankItem:InitUI()
	self:BindCfgUI()

	self.rankController_ = ControllerUtil.GetController(self.transform_, "rank")
end

function ActivityRaceRankItem:RefreshUI(arg_4_1)
	self.userID_ = arg_4_1.user_id
	self.name_.text = arg_4_1.nick
	self.icon_.sprite = ItemTools.getItemSprite(arg_4_1.portrait)
	self.frame_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. arg_4_1.frame)
	self.rank_.text = arg_4_1.rank
	self.score_.text = arg_4_1.score

	if arg_4_1.rank <= 3 then
		self.rankController_:SetSelectedState(arg_4_1.rank)
	else
		self.rankController_:SetSelectedState(0)
	end
end

return ActivityRaceRankItem
