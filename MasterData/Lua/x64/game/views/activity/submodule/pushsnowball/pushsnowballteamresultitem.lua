local PushSnowBallTeamResultItem = class("PushSnowBallTeamResultItem", ReduxView)

function PushSnowBallTeamResultItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
end

function PushSnowBallTeamResultItem:initUI()
	self:BindCfgUI()

	self.rankController_ = ControllerUtil.GetController(self.transform_, "rank")
end

function PushSnowBallTeamResultItem:SetData(arg_3_1, arg_3_2)
	self.data_ = arg_3_2
	self.index_ = arg_3_1

	self:Refresh()
end

function PushSnowBallTeamResultItem:Refresh()
	if self.rankText_ then
		self.rankText_.text = self.data_.rank
	end

	if self.scoreText_ then
		self.scoreText_.text = self.data_.score
	end

	if self.rankController_ then
		if self.data_.rank <= 3 then
			self.rankController_:SetSelectedIndex(self.data_.rank - 1)
		else
			self.rankController_:SetSelectedIndex(0)
		end
	end

	self.nameText_.text = self.data_.nick
	self.iconImg_.sprite = ItemTools.getItemSprite(self.data_.icon)
	self.frameImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. self.data_.frame)
end

return PushSnowBallTeamResultItem
