local CourtYardFeastPoolMgr = class("CourtYardFeastPoolMgr", import(".CourtYardPoolMgr"))

function CourtYardFeastPoolMgr:GenPool(arg_1_1)
	local var_1_0 = CourtYardFeastPoolMgr.super.GenPool(self, arg_1_1)

	for iter_1_0, iter_1_1 in ipairs({
		"chengbao_aixin",
		"chengbao_xinxin",
		"chengbao_yinfu",
		"chengbao_ZZZ"
	}) do
		table.insert(var_1_0, function(arg_2_0)
			ResourceMgr.Inst:getAssetAsync("Effect/" .. iter_1_1, "", typeof(Object), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_3_0)
				if self.exited then
					return
				end

				if arg_3_0 then
					self.pools[iter_1_1] = CourtYardEffectPool.New(arg_1_1, arg_3_0, 0, 3, CourtYardConst.FEAST_EFFECT_TIME)
				end

				arg_2_0()

				return
			end), true, true)

			return
		end)
	end

	return var_1_0
end

return CourtYardFeastPoolMgr
