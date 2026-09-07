ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst

ys.Battle.BattleWallData = class("BattleWallData")
ys.Battle.BattleWallData.__name = "BattleWallData"

local var_0_2 = ys.Battle.BattleWallData

ys.Battle.BattleWallData.CLD_OBJ_TYPE_BULLET = 1
ys.Battle.BattleWallData.CLD_OBJ_TYPE_SHIP = 2

function ys.Battle.BattleWallData:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self._id = arg_1_1
	self._host = arg_1_2
	self._cldFun = arg_1_3
	self._cldBox = arg_1_4
	self._cldOffset = arg_1_5

	self:InitCldComponent()

	return
end

function ys.Battle.BattleWallData:InitCldComponent()
	self._cldComponent = self._cldBox.range and var_0_0.Battle.BattleColumnCldComponent.New(self._cldBox.range, 5, self._cldOffset[1], self._cldOffset[3]) or var_0_0.Battle.BattleCubeCldComponent.New(self._cldBox[1], self._cldBox[2], self._cldBox[3], self._cldOffset[1], self._cldOffset[3])

	self._cldComponent:SetCldData({
		type = var_0_1.CldType.WALL,
		UID = self:GetUniqueID(),
		func = self:GetCldFunc()
	})
	self._cldComponent:SetActive(true)
	self:SetCldObjType()

	return
end

function ys.Battle.BattleWallData:IsActive()
	return self._host:IsWallActive()
end

function ys.Battle.BattleWallData:DeactiveCldBox()
	self._cldComponent:SetActive(false)

	return
end

function ys.Battle.BattleWallData:GetCldBox()
	return self._cldComponent:GetCldBox(self:GetPosition())
end

function ys.Battle.BattleWallData:GetCldData()
	return self._cldComponent:GetCldData()
end

function ys.Battle.BattleWallData:GetBoxSize()
	return self._cldComponent:GetCldBoxSize()
end

function ys.Battle.BattleWallData:GetHost()
	return self._host
end

function ys.Battle.BattleWallData:GetIFF()
	return self:GetHost():GetIFF()
end

function ys.Battle.BattleWallData:GetPosition()
	return self:GetHost():GetPosition()
end

function ys.Battle.BattleWallData:GetUniqueID()
	return self._id
end

function ys.Battle.BattleWallData:GetCldFunc()
	return self._cldFun
end

function ys.Battle.BattleWallData.SetCldObjType(arg_13_0, arg_13_1)
	arg_13_0._cldObjType = arg_13_1 or var_0_2.CLD_OBJ_TYPE_BULLET

	return
end

function ys.Battle.BattleWallData:GetCldObjType()
	return self._cldObjType
end

return
