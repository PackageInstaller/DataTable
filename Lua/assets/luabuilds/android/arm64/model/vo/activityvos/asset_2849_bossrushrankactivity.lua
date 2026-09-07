local BossRushRankActivity = class("BossRushRankActivity", import("model.vo.Activity"))

function BossRushRankActivity:GetScore()
	return self.data1
end

function BossRushRankActivity:Record(arg_2_1)
	local var_2_0 = getProxy(ActivityProxy):GetBossRushRuntime(self.id).record + arg_2_1

	getProxy(ActivityProxy):GetBossRushRuntime(self.id).record = var_2_0
	self.data1 = math.max(self.data1, var_2_0)

	return
end

function BossRushRankActivity:ResetLast()
	getProxy(ActivityProxy):GetBossRushRuntime(self.id).record = 0

	return
end

return BossRushRankActivity
