ys = ys or {}

local var_0_0 = ys
local var_0_3 = ys.Battle.BattlePopNumManager

ys.Battle.BattlePopNumBundle = class("BattlePopNumBundle")
ys.Battle.BattlePopNumBundle.__name = "BattlePopNumBundle"

local var_0_4 = ys.Battle.BattlePopNumBundle

ys.Battle.BattlePopNumBundle.PRO = 0
ys.Battle.BattlePopNumBundle.SLIM = 1

function ys.Battle.BattlePopNumBundle:Ctor(arg_1_1, arg_1_2)
	self.pool = arg_1_1
	self._container = cloneTplTo(arg_1_2.containerTpl, arg_1_2.containerTpl.parent)
	self._bundleType = arg_1_2.type
	self._score = arg_1_2.score

	self:init()

	return
end

function ys.Battle.BattlePopNumBundle:InitPopScore(arg_2_1)
	self._allPool[var_0_3.POP_SCORE] = self:generateTempPool(var_0_3.POP_SCORE, self._container, arg_2_1, 1)

	return
end

function ys.Battle.BattlePopNumBundle:GetContainer()
	return self._container
end

function ys.Battle.BattlePopNumBundle:init()
	self._allPool = {}

	local var_4_0 = var_0_3.GetInstance():GetPopSkin()

	if self._score then
		self._allPool[var_0_3.POP_SCORE] = self:generateTempPool(var_0_3.POP_SCORE, self._container, var_4_0, 1)
	else
		self._allPool[var_0_3.POP_COMMON] = self:generateTempPool(var_0_3.POP_COMMON, self._container, var_4_0, 1)
		self._allPool[var_0_3.POP_CT_EXPLO] = self:generateTempPool(var_0_3.POP_CT_EXPLO, self._container, var_4_0, 0)
		self._allPool[var_0_3.POP_MISS] = self:generateTempPool(var_0_3.POP_MISS, self._container, var_4_0, 0)
		self._allPool[var_0_3.POP_NORMAL] = self:generateTempPool(var_0_3.POP_NORMAL, self._container, var_4_0, 0)
		self._allPool[var_0_3.POP_CT_NORMAL] = self:generateTempPool(var_0_3.POP_CT_NORMAL, self._container, var_4_0, 0)

		if self._bundleType == var_0_4.PRO then
			self._allPool[var_0_3.POP_UNBREAK] = self:generateTempPool(var_0_3.POP_UNBREAK, self._container, var_4_0, 1)
			self._allPool[var_0_3.POP_HEAL] = self:generateTempPool(var_0_3.POP_HEAL, self._container, var_4_0, 1)
			self._allPool[var_0_3.POP_EXPLO] = self:generateTempPool(var_0_3.POP_EXPLO, self._container, var_4_0, 0)
			self._allPool[var_0_3.POP_PIERCE] = self:generateTempPool(var_0_3.POP_PIERCE, self._container, var_4_0, 0)
			self._allPool[var_0_3.POP_CT_PIERCE] = self:generateTempPool(var_0_3.POP_CT_PIERCE, self._container, var_4_0, 0)
		end
	end

	return
end

function ys.Battle.BattlePopNumBundle:Clear()
	self.pool:Recycle(self)

	return
end

function ys.Battle.BattlePopNumBundle:GetPop(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	local var_6_0, var_6_1 = var_0_3.getType(arg_6_1, arg_6_2, arg_6_3, arg_6_5)
	local var_6_2 = self._allPool[var_6_0]:GetObject()

	if var_6_0 ~= var_0_3.POP_MISS then
		var_6_2:SetText(arg_6_4)
	end

	var_6_2:SetScale(var_6_1)

	return var_6_2
end

function ys.Battle.BattlePopNumBundle:GetScorePop(arg_7_1)
	local var_7_0 = self._allPool[var_0_3.POP_SCORE]:GetObject()

	var_7_0:SetText(arg_7_1)

	return var_7_0
end

function ys.Battle.BattlePopNumBundle.generateTempPool(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	return pg.LuaObPool.New(var_0_0.Battle.BattlePopNum, {
		template = arg_8_3.transform:Find(arg_8_1).gameObject,
		parentTF = arg_8_2,
		mgr = arg_8_0
	}, arg_8_4)
end

function ys.Battle.BattlePopNumBundle.Init(arg_9_0)
	return
end

function ys.Battle.BattlePopNumBundle.Recycle(arg_10_0)
	return
end

function ys.Battle.BattlePopNumBundle:IsScorePop()
	return self._score
end

function ys.Battle.BattlePopNumBundle:Dispose()
	for iter_12_0, iter_12_1 in pairs(self._allPool) do
		iter_12_1:Dispose()
	end

	self._allPool = nil

	Object.Destroy(self._container.gameObject)

	self._container = nil

	return
end

return
