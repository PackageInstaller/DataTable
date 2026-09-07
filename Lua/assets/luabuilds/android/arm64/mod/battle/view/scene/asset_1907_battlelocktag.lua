ys = ys or {}
ys.Battle.BattleLockTag = class("BattleLockTag")
ys.Battle.BattleLockTag.__name = "BattleLockTag"

function ys.Battle.BattleLockTag:Ctor(arg_1_1, arg_1_2)
	self._markGO = arg_1_1
	self._markTF = arg_1_1.transform
	self._controller = self._markTF:GetComponent("LockTag")
	self._flag = true

	return
end

function ys.Battle.BattleLockTag:Mark(arg_2_1)
	self._markTime = pg.TimeMgr.GetInstance():GetCombatTime()
	self._requiredTime = arg_2_1

	SetActive(self._markGO, true)

	self._controller.enabled = true

	return
end

function ys.Battle.BattleLockTag:Update(arg_3_1)
	if (arg_3_1 - self._markTime) / self._requiredTime >= 1 and self._flag then
		self._controller:SetRate(1)

		self._controller.enabled = false
		self._markTF:GetComponent(typeof(Animator)).enabled = true
		self._flag = false
	elseif self._flag then
		self._controller:SetRate((arg_3_1 - self._markTime) / self._requiredTime)
	end

	return
end

function ys.Battle.BattleLockTag:SetPosition(arg_4_1)
	self._markTF.position = arg_4_1

	return
end

function ys.Battle.BattleLockTag:SetTagCount(arg_5_1)
	self._controller.count = arg_5_1

	return
end

function ys.Battle.BattleLockTag:Dispose()
	Object.Destroy(self._markGO)

	return
end

return
