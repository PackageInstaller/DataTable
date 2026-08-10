local var_0_0 = singletonClass("StoryPlayNodeFactory")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.storyPlayNodeMap_ = {}
	arg_1_0.storyPlayer_ = nil
end

function var_0_0.SetStoryPlayer(arg_2_0, arg_2_1)
	arg_2_0.storyPlayer_ = arg_2_1
end

function var_0_0.GetNode(arg_3_0, arg_3_1)
	return (arg_3_0:GetFreeeNode(arg_3_1))
end

function var_0_0.GetFreeeNode(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.className

	arg_4_0.storyPlayNodeMap_[var_4_0] = arg_4_0.storyPlayNodeMap_[var_4_0] or {}

	local var_4_1 = arg_4_0.storyPlayNodeMap_[var_4_0]

	for iter_4_0 = 1, #var_4_1 do
		local var_4_2 = var_4_1[iter_4_0]

		if var_4_2.isFree then
			var_4_2.isFree = false

			var_4_2:ResetStatus()
			var_4_2:SetConfig(arg_4_1)

			return var_4_2
		end
	end

	local var_4_3 = arg_4_0:CreateNode(arg_4_1)

	table.insert(var_4_1, var_4_3)

	return var_4_3
end

function var_0_0.CreateNode(arg_5_0, arg_5_1)
	local var_5_0 = _G[arg_5_1.className].New(arg_5_0.storyPlayer_)

	var_5_0:SetConfig(arg_5_1)

	return var_5_0
end

function var_0_0.RetureNode(arg_6_0, arg_6_1)
	arg_6_1.isFree = true
end

function var_0_0.Dispose(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.storyPlayNodeMap_) do
		for iter_7_2, iter_7_3 in ipairs(iter_7_1) do
			iter_7_3:Dispose()
		end
	end

	arg_7_0.storyPlayNodeMap_ = {}
	arg_7_0.storyPlayer_ = nil
end

return var_0_0
