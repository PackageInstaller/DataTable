local IslandDelegationFishBuilder = class("IslandDelegationFishBuilder", import(".IslandGenericBuilder"))

function IslandDelegationFishBuilder:GetModule(arg_1_1, arg_1_2)
	return IslandDelegationFishUnit.New(arg_1_1, arg_1_2)
end

function IslandDelegationFishBuilder:LoadAsset(arg_2_1, arg_2_2)
	self:GetPoolMgr():GetSceneDelegateItem(arg_2_1:GetAssetPath(), arg_2_1:GetAnimator(), arg_2_1:GetBehaviourTree(), arg_2_2)

	return
end

function IslandDelegationFishBuilder:Recycle(arg_3_1, arg_3_2)
	self:GetPoolMgr():ReturnSceneDelegateItem(arg_3_1:GetAssetPath(), arg_3_1:GetAnimator(), arg_3_1:GetBehaviourTree(), arg_3_2)

	return
end

function IslandDelegationFishBuilder:SetTag(arg_4_1)
	arg_4_1.tag = IslandConst.TAG_NPC

	return
end

return IslandDelegationFishBuilder
