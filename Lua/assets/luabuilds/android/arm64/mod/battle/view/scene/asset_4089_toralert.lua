ys = ys or {}

local var_0_0 = ys

ys.Battle.TorAlert = class("TorAlert")
ys.Battle.TorAlert.__name = "TorAlert"

function ys.Battle.TorAlert:Ctor(arg_1_1)
	self._alertGO = arg_1_1
	self._alertTF = arg_1_1.transform
	self._alertTF.localScale = Vector3(20, 5, 1)

	LeanTween.scaleY(arg_1_1, 0, 0.5):setDelay(0.1)

	return
end

function ys.Battle.TorAlert:SetPosition(arg_2_1, arg_2_2)
	pg.EffectMgr.GetInstance():PlayBattleEffect(self._alertGO, arg_2_1)

	self._alertTF.eulerAngles = Vector3(0, 180 - arg_2_2, 0)

	return
end

function ys.Battle.TorAlert:Dispose()
	LeanTween.cancel(self._alertGO)
	var_0_0.Battle.BattleResourceManager.GetInstance():DestroyOb(self._alertGO)

	return
end

return
