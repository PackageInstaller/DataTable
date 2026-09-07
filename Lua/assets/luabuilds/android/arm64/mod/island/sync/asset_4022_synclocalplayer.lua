local SyncLocalPlayer = class("SyncLocalPlayer")

SyncLocalPlayer.ANIMATOR_LAYER = {
	0,
	1,
	2
}

function SyncLocalPlayer:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1
	self.sceneObject = arg_1_2
	self.animator = arg_1_2:GetAnimator()
	self.inTimeline = false

	return
end

function SyncLocalPlayer:GetStatus()
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(self.ANIMATOR_LAYER) do
		var_2_0[iter_2_0] = self.animator:GetCurrentAnimatorStateInfo(iter_2_1).shortNameHash
	end

	return var_2_0
end

function SyncLocalPlayer:IsLoaded()
	return self.sceneObject and self.sceneObject:IsLoaded()
end

function SyncLocalPlayer:SetInTimeline(arg_4_1)
	self.inTimeline = arg_4_1

	return
end

function SyncLocalPlayer:InTimeline()
	return self.inTimeline
end

function SyncLocalPlayer:CreateSyncData()
	return (SyncUnitData.New({
		id = self.id,
		pos = self:GetLocalPosition(),
		dir = self:GetRotation(),
		status = self:GetStatus()
	}))
end

function SyncLocalPlayer:GetLocalPosition()
	return self.sceneObject._go.transform.localPosition
end

function SyncLocalPlayer:GetRotation()
	return self.sceneObject._go.transform.rotation
end

return SyncLocalPlayer
