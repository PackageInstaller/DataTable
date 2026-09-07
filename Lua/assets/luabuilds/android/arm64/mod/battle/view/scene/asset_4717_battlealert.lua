ys = ys or {}
ys.Battle.BattleAlert = class("BattleAlert")
ys.Battle.BattleAlert.__name = "BattleAlert"

function ys.Battle.BattleAlert:Ctor(arg_1_1)
	self._alertGO = arg_1_1
	self._alertTf = arg_1_1.transform
	self._diskTf = self._alertGO.transform:Find("Disk")

	self:UpdateRate(0)
	self._alertGO:SetActive(true)

	return
end

function ys.Battle.BattleAlert:SetPosition(arg_2_1)
	self._alertTf.localPosition = Vector3(arg_2_1.x, 0, arg_2_1.z)

	return
end

function ys.Battle.BattleAlert:Zoom(arg_3_1)
	self._alertTf.localScale = Vector3(arg_3_1 * 2, arg_3_1 * 2, 1)

	return
end

function ys.Battle.BattleAlert:UpdateRate(arg_4_1)
	self._diskTf.localScale = Vector3(arg_4_1, arg_4_1, 1)

	return
end

function ys.Battle.BattleAlert:Dispose()
	Object.Destroy(self._alertGO)

	return
end

return
