local BaseAgoraView = class("BaseAgoraView", import("Mod.Island.Core.View.IslandView"))

function BaseAgoraView:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	BaseAgoraView.super.Ctor(self, arg_1_1, arg_1_3, arg_1_4)

	self.agora = arg_1_2
	self.agora_callbacks = {}

	return
end

function BaseAgoraView:SetUp()
	BaseAgoraView.super.SetUp(self)
	self:AddAgoraListeners()

	return
end

function BaseAgoraView:AddAgoraListeners()
	return
end

function BaseAgoraView:RemoveAgoraListeners()
	return
end

function BaseAgoraView:AddAgoraListener(arg_5_1, arg_5_2)
	local function var_5_0(arg_6_0, ...)
		arg_5_2(self, ...)

		return
	end

	assert(self.agora_callbacks[arg_5_2] == nil, "This method has been monitored. Please use another one" .. arg_5_1)

	self.agora_callbacks[arg_5_2] = var_5_0

	self.agora:AddListener(arg_5_1, var_5_0)

	return
end

function BaseAgoraView:RemoveAgoraListener(arg_7_1, arg_7_2)
	if self.agora_callbacks[arg_7_2] then
		self.agora:RemoveListener(arg_7_1, self.agora_callbacks[arg_7_2])

		self.agora_callbacks[self.agora_callbacks[arg_7_2]] = nil
	end

	return
end

function BaseAgoraView:OnDispose()
	BaseAgoraView.super.OnDispose(self)
	self:RemoveAgoraListeners()

	return
end

return BaseAgoraView
