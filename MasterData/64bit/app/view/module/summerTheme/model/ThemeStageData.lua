local var_0_0 = g.core.const.ConstMgr.ThemeConst
local var_0_1 = g.core.config.activity_theme_dungeon_stage_info
local ThemeStageData = class("ThemeStageData")

function ThemeStageData:ctor(arg_1_1)
	self._id = 0
	self._star = 0
	self._isAward = false

	self:initData(arg_1_1)
end

function ThemeStageData:initData(arg_2_1)
	self._id = arg_2_1.key
	self._star = arg_2_1.value
	self._isAward = arg_2_1.isAward
end

function ThemeStageData:getStageId()
	return self._id
end

function ThemeStageData:getStageStar()
	return self._star
end

function ThemeStageData:getStagePassed()
	local var_5_0 = self:getStageType()

	if var_5_0 == var_0_0.DUNGEON_STAGE_TYPE.BATTLE then
		return checkbool(self._star > 0)
	elseif var_5_0 == var_0_0.DUNGEON_STAGE_TYPE.STORY then
		return self._isAward
	end

	return false
end

function ThemeStageData:getStageFinish()
	return checkbool(self._star == var_0_0.DUNGEON_FINISH_STAR)
end

function ThemeStageData:getStageType()
	return var_0_1.get(self._id).stage_type
end

function ThemeStageData:getChapterId()
	return var_0_1.get(self._id).chapter_id
end

return ThemeStageData
