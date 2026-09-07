ys = ys or {}

local var_0_0 = ys
local BattleSpecialWeapon = class("BattleSpecialWeapon", ys.Battle.BattleWeaponUnit)

ys.Battle.BattleSpecialWeapon = BattleSpecialWeapon
BattleSpecialWeapon.__name = "BattleSpecialWeapon"

function BattleSpecialWeapon:Ctor()
	BattleSpecialWeapon.super.Ctor(self)

	return
end

function BattleSpecialWeapon:CheckPreCast()
	if not self._tmpData.bullet_ID[1] then
		self._castInfo = {
			weapon = self
		}

		return true
	end

	local var_2_0 = self._dataProxy:GetSeqCenter():NewSeq("precast")
	local var_2_1 = var_0_0.Battle.NodeData.New(self._host, {
		weapon = self
	}, var_2_0)

	pg.NodeMgr.GetInstance():GenNode(var_2_1, pg.BattleNodesCfg[self._tmpData.bullet_ID[1]], var_2_0)

	local var_2_2 = var_2_1:GetData()

	if var_2_2.targets[1] == nil then
		return false
	end

	self._castInfo = var_2_2

	return true
end

function BattleSpecialWeapon:Fire()
	assert(self._castInfo ~= nil, "需要指定施法信息，有特殊需求可默认指定为{ weapon = self }")

	local var_3_1 = self._dataProxy:GetSeqCenter():NewSeq("cast")
	local var_3_2 = var_0_0.Battle.NodeData.New(self._host, self._castInfo, var_3_1)

	pg.NodeMgr.GetInstance():GenNode(var_3_2, pg.BattleNodesCfg[self._tmpData.barrage_ID[1]], var_3_1)
	self._host:SetCurNodeList(var_3_2:GetAllSeq())

	self._currentState = self.STATE_ATTACK
	self._castInfo = nil

	self:CheckAndShake()
	var_3_1:Add(var_0_0.Battle.CallbackNode.New(function()
		self:EnterCoolDown()

		return
	end))

	return true
end

return
