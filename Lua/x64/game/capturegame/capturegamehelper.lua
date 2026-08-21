return {
	GetTaskBySectionId = function(arg_1_0, arg_1_1)
		return ActivitySwimSkinSubSectionCfg[arg_1_1].task_list or {}
	end,
	GetConditionByTask = function(arg_2_0, arg_2_1)
		return ActivitySwimSkinSubActivityTaskCfg[arg_2_1]
	end,
	GetConditionExecutorById = function(arg_3_0, arg_3_1)
		if arg_3_1 == nil or not CaptureConditionMap[arg_3_1] then
			Debug.LogError("不存在的条件类型: " .. (arg_3_1 or "nil"))

			return CaptureConditionMap[CaptureGameConst.ConditionType.Unknow]
		end

		return CaptureConditionMap[arg_3_1]
	end,
	GetAnimHashId = function(arg_4_0, arg_4_1)
		if not arg_4_0.animHashMap then
			local var_4_0 = {}

			arg_4_0.animHashMap = var_4_0

			for iter_4_0, iter_4_1 in ipairs(ActivitySwimSkinAnimationCfg.all) do
				local var_4_1 = ActivitySwimSkinAnimationCfg[iter_4_1]

				var_4_0[var_4_1.Id] = Animator.StringToHash(var_4_1.animName)
			end

			var_4_0[-1] = Animator.StringToHash("Idle")
		end

		return arg_4_0.animHashMap[arg_4_1]
	end
}
