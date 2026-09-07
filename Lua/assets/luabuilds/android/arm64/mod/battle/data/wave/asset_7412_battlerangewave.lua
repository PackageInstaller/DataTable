ys = ys or {}
ys.Battle.BattleRangeWave = class("BattleRangeWave", ys.Battle.BattleWaveInfo)
ys.Battle.BattleRangeWave.__name = "BattleRangeWave"

local var_0_0 = ys.Battle.BattleRangeWave

function ys.Battle.BattleRangeWave.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleRangeWave:SetWaveData(arg_2_1)
	var_0_0.super.SetWaveData(self, arg_2_1)

	self._pos = Vector3(self._param.rect[1], 0, self._param.rect[2])
	self._width = self._param.rect[3]
	self._height = self._param.rect[4]
	self._lifeTime = 31

	return
end

function ys.Battle.BattleRangeWave:DoWave()
	var_0_0.super.DoWave(self)
	self._spawnFunc(self._pos, self._width, self._height, self._lifeTime, function(arg_4_0, arg_4_1)
		for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
			if iter_4_1.IFF ~= arg_4_1:GetCldData().IFF then
				arg_4_1:SetActiveFlag(false)
				self:doPass()

				break
			end
		end

		return
	end)

	return
end

return
