local IslandCharUnitBuilder = class("IslandCharUnitBuilder", import(".IslandBaseBuilder"))

function IslandCharUnitBuilder:Load(arg_1_1, arg_1_2)
	self:GetPoolMgr():GetSceneCharacter(arg_1_1:GetAssetPath(), arg_1_1:GetAnimator(), arg_1_1:GetBehaviourTree(), arg_1_2)

	return
end

function IslandCharUnitBuilder:Recycle(arg_2_1, arg_2_2)
	self:GetPoolMgr():ReturnSceneCharacter(arg_2_1:GetAssetPath(), arg_2_1:GetAnimator(), arg_2_1:GetBehaviourTree(), arg_2_2)

	return
end

function IslandCharUnitBuilder:AddComponents(arg_3_1, arg_3_2)
	return
end

return IslandCharUnitBuilder
