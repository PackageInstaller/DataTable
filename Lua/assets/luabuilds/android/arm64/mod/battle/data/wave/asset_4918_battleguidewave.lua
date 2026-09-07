ys = ys or {}
ys.Battle.BattleGuideWave = class("BattleGuideWave", ys.Battle.BattleWaveInfo)
ys.Battle.BattleGuideWave.__name = "BattleGuideWave"

local var_0_0 = ys.Battle.BattleGuideWave

function ys.Battle.BattleGuideWave.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleGuideWave:SetWaveData(arg_2_1)
	var_0_0.super.SetWaveData(self, arg_2_1)

	self._guideType = self._param.type or 0
	self._guideStep = self._param.id
	self._event = self._param.event

	return
end

function ys.Battle.BattleGuideWave:DoWave()
	var_0_0.super.DoWave(self)

	if not pg.NewGuideMgr.ENABLE_GUIDE then
		self:doPass()
	else
		if self._guideType == 1 then
			if pg.SeriesGuideMgr.GetInstance():isEnd() then
				self:doFail()

				goto label_3_0
			end
		end

		pg.NewGuideMgr.GetInstance():Play(self._guideStep, {
			self._event
		}, function()
			self:doPass()

			return
		end)
	end

	::label_3_0::

	return
end

return
