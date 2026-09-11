LoopScrollViewBaseItem = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")

local AdminChipBaseItem = class("AdminChipBaseItem", LoopScrollViewBaseItem)

function AdminChipBaseItem:Show(arg_1_1)
	if not arg_1_1 and self.playingAni_ then
		self.animInfo_.aniNormTime_ = self:GetAnimTime()
	end

	AdminChipBaseItem.super.Show(self, arg_1_1)
end

function AdminChipBaseItem:GetAnimTime()
	local var_2_0 = self.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime

	if var_2_0 > 0.999 then
		return 1
	end

	return var_2_0
end

function AdminChipBaseItem:UpdateAnim(arg_3_1, arg_3_2)
	if not self.animInfo_.inited then
		self.animInfo_.inited = true
		self.animInfo_.aniNormTime_ = 1
		self.animInfo_.selected = arg_3_1
		self.playingAni_ = arg_3_2
	end

	if self.animInfo_.selected ~= arg_3_1 then
		self.animInfo_.selected = arg_3_1
		self.animInfo_.aniNormTime_ = 0
	elseif self.animator_:GetCurrentAnimatorStateInfo(0):IsName(self.playingAni_) then
		self.animInfo_.aniNormTime_ = self:GetAnimTime()
	end

	self.playingAni_ = arg_3_2

	self.animator_:Play(self.playingAni_, -1, self.animInfo_.aniNormTime_)
	self.animator_:Update(0)
end

return AdminChipBaseItem
