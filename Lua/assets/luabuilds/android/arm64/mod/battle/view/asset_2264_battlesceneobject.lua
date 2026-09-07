ys = ys or {}

local var_0_0 = ys
local BattleSceneObject = class("BattleSceneObject")

ys.Battle.BattleSceneObject = BattleSceneObject
BattleSceneObject.__name = "BattleSceneObject"

function BattleSceneObject:Ctor()
	return
end

function BattleSceneObject:GetGO()
	return self._go
end

function BattleSceneObject:GetTf()
	return self._tf
end

function BattleSceneObject:SetGO(arg_4_1)
	self._go = arg_4_1
	self._tf = arg_4_1.transform

	return
end

function BattleSceneObject:GetCldBoxSize()
	assert(false, self.__name .. ".GetCldBoxSize: this function should be override!!!")

	return
end

function BattleSceneObject:GetCldBox()
	assert(false, self.__name .. ".GetCldBox: this function should be override!!!")

	return
end

function BattleSceneObject:GetCldData()
	assert(false, self.__name .. ".GetCldData: this function should be override!!!")

	return
end

function BattleSceneObject:GetGOPosition()
	return self._tf.localPosition
end

function BattleSceneObject:CameraOrthogonal(arg_9_1)
	self._tf.localRotation = arg_9_1.transform.localRotation

	return
end

function BattleSceneObject:Dispose()
	self._tf = nil

	var_0_0.Battle.BattleResourceManager.GetInstance():DestroyOb(self._go)

	self._go = nil

	return
end

return
