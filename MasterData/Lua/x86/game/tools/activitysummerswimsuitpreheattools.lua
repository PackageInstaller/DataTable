return {
	GetCfgStageImage = function(self)
		return getSpriteWithoutAtlas((ActivityCfg[self.activity_id].activity_theme == ActivityConst.THEME.ACTIVITY_4_2 and "TextureConfig/VersionUI/Alone_SummerUI_PreheatUI/" or "TextureConfig/VersionUI/Alone_SummerUI_PreheatUI/") .. self.pic_name)
	end,
	GetCfgMainActivityId = function(self)
		return ActivityTools.GetMainActivityId(self.activity_id)
	end,
	GetCfgIdList = function(arg_3_0)
		local var_3_0 = {}

		if ActivitySummerSwimsuitPreheatCfg then
			for iter_3_0, iter_3_1 in ipairs(ActivitySummerSwimsuitPreheatCfg.get_id_list_by_activity_id[arg_3_0] or {}) do
				table.insert(var_3_0, iter_3_1)
			end

			for iter_3_2, iter_3_3 in ipairs(ActivityCfg[arg_3_0].sub_activity_list) do
				table.insert(var_3_0, ActivitySummerSwimsuitPreheatCfg.get_id_list_by_activity_id[iter_3_3][1])
			end
		end

		return var_3_0
	end
}
