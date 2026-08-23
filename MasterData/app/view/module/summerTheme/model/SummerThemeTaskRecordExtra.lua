local var_0_0 = g.core.const.ConstMgr.ThemeConst
local SummerThemeTaskRecordExtra = class("SummerThemeTaskRecordExtra", import(".SummerThemeTaskRecord"))

function SummerThemeTaskRecordExtra:ctor(arg_1_1)
	SummerThemeTaskRecordExtra.super.ctor(self, arg_1_1)
end

function SummerThemeTaskRecordExtra:initWithCfgInfo(arg_2_1)
	self._baseInfo = arg_2_1
end

function SummerThemeTaskRecordExtra:getThemeTaskType()
	return var_0_0.THEME_TASK_TYPE.COMMON
end

function SummerThemeTaskRecordExtra:getTaskStatus()
	if self:getCurDoingNum() >= self._baseInfo.reward_number_max then
		return 3
	end

	return 1
end

function SummerThemeTaskRecordExtra:getCurDoingNum()
	return self._refParentTaskData:getTaskDropNum(self._baseInfo.id)
end

return SummerThemeTaskRecordExtra
