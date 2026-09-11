local var_0_0 = singletonClass("StoryPlayNodeFactory")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.storyPlayNodeMap_ = {}
	arg_1_0.storyPlayer_ = nil
end

function var_0_0.SetStoryPlayer(arg_2_0, arg_2_1)
	arg_2_0.storyPlayer_ = arg_2_1
end

function var_0_0:GetNode(arg_3_1)
	return (self:GetFreeeNode(arg_3_1))
end

function var_0_0:GetFreeeNode(arg_4_1)
	self.storyPlayNodeMap_[arg_4_1.className] = self.storyPlayNodeMap_[arg_4_1.className] or {}

	for iter_4_0 = 1, #self.storyPlayNodeMap_[arg_4_1.className] do
		if self.storyPlayNodeMap_[arg_4_1.className][iter_4_0].isFree then
			self.storyPlayNodeMap_[arg_4_1.className][iter_4_0].isFree = false

			self.storyPlayNodeMap_[arg_4_1.className][iter_4_0]:ResetStatus()
			self.storyPlayNodeMap_[arg_4_1.className][iter_4_0]:SetConfig(arg_4_1)

			return self.storyPlayNodeMap_[arg_4_1.className][iter_4_0]
		end
	end

	local var_4_0 = self:CreateNode(arg_4_1)

	table.insert(self.storyPlayNodeMap_[arg_4_1.className], var_4_0)

	return var_4_0
end

function var_0_0:CreateNode(arg_5_1)
	local var_5_0 = _G[arg_5_1.className].New(self.storyPlayer_)

	var_5_0:SetConfig(arg_5_1)

	return var_5_0
end

function var_0_0.RetureNode(arg_6_0, arg_6_1)
	arg_6_1.isFree = true
end

function var_0_0:Dispose()
	for iter_7_0, iter_7_1 in pairs(self.storyPlayNodeMap_) do
		for iter_7_2, iter_7_3 in ipairs(iter_7_1) do
			iter_7_3:Dispose()
		end
	end

	self.storyPlayNodeMap_ = {}
	self.storyPlayer_ = nil
end

return var_0_0
