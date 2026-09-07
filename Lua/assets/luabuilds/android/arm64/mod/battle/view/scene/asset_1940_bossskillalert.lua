ys = ys or {}
ys.Battle.BossSkillAlert = class("BossSkillAlert")
ys.Battle.BossSkillAlert.__name = "BossSkillAlert"

function ys.Battle.BossSkillAlert:Ctor(arg_1_1)
	self._alertGO = arg_1_1
	self._alertTF = arg_1_1.transform
	self._alertTF.localPosition = Vector3.zero

	LeanTween.alpha(arg_1_1, 0.3, 0.1):setDelay(0.1):setLoopPingPong()

	return
end

function ys.Battle.BossSkillAlert:SetActive(arg_2_1)
	self._alertGO:SetActive(arg_2_1)

	return
end

function ys.Battle.BossSkillAlert:GetActive()
	return self._alertGO.activeSelf
end

function ys.Battle.BossSkillAlert:SetScale(arg_4_1)
	self._alertTF.localScale = arg_4_1

	return
end

function ys.Battle.BossSkillAlert.SetExistTime(arg_5_0, arg_5_1)
	arg_5_0._timer = pg.TimeMgr.GetInstance():AddBattleTimer("BossSkillAlert", 0, arg_5_1, function()
		if arg_5_0._alertGO then
			arg_5_0:Dispose()
		end

		return
	end)

	return
end

function ys.Battle.BossSkillAlert:Dispose()
	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._timer)
	LeanTween.cancel(self._alertGO)
	Object.Destroy(self._alertGO)

	self._alertGO = nil

	return
end

return
