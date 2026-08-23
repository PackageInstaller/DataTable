local SummerThemeData = class("SummerThemeData")

function SummerThemeData:ctor(arg_1_1, arg_1_2)
	self._activeThemeType = arg_1_1
	self._activeThemeValue = arg_1_2
	self._curThemeActiveData = nil

	self:_initThemeData()
end

function SummerThemeData:_initThemeData()
	self._curThemeActiveData = nil
	self._bossData = nil
	self._dungeonData = nil
	self._dungeonData = require("app.view.module.summerTheme.model.SummerThemeDungeonData").new()
	self._taskData = nil
	self._taskData = require("app.view.module.summerTheme.model.SummerThemeTaskData").new()
	self._exploreData = nil
	self._exploreData = require("app.view.module.summerTheme.model.ThemeExploreData").new()
	self._turnCardData = nil
	self._turnCardData = require("app.view.module.summerTheme.model.ThemeTurnCardData").new()
	self._turnTableData = nil
	self._turnTableData = require("app.view.module.summerTheme.model.ThemeTurnTableData").new()
	self._gemEliminateData = nil
	self._gemEliminateData = require("app.view.module.summerTheme.model.GemEliminateData").new()
	self._themePuzzleData = nil
	self._themePuzzleData = require("app.view.module.summerTheme.model.ThemePuzzleData").new()
	self._themeBioData = nil
	self._themeBioData = require("app.view.module.themeBio.model.ThemeBioData").new()
	self._guessData = nil
	self._guessData = require("app.view.module.summerTheme.model.SummerGuessData").new()

	if g.core.config.activity_theme_info.get(self._activeThemeValue).activity_passcard > 0 then
		self._passCardData = require("app.view.module.summerTheme.model.ThemePassCardData").new()

		self._passCardData:initData(self._activeThemeValue)
	end
end

function SummerThemeData:configThemeType()
	return self._activeThemeType
end

function SummerThemeData:configThemeVal()
	return self._activeThemeValue
end

function SummerThemeData:isThemeStart()
	return self._curThemeActiveData ~= nil
end

function SummerThemeData:getBossData()
	self._bossData = self._bossData or g.core.config.activity_theme_info.get(self._activeThemeValue).version == g.core.const.ConstMgr.ThemeConst.THEME_ACTIVITY_BOSS_VERSION.THIRD and require("app.view.module.summerThemeThirdBoss.model.ThemeThirdBossData").new() or require("app.view.module.summerThemeBoss.model.SummerThemeBossData").new()

	return self._bossData
end

function SummerThemeData:getDungeonData()
	return self._dungeonData
end

function SummerThemeData:getTaskData()
	return self._taskData
end

function SummerThemeData:getExploreData()
	return self._exploreData
end

function SummerThemeData:getTurnCardData()
	return self._turnCardData
end

function SummerThemeData:getTurnTableData()
	return self._turnTableData
end

function SummerThemeData:getGemEliminateData()
	return self._gemEliminateData
end

function SummerThemeData:getThemePuzzleData()
	return self._themePuzzleData
end

function SummerThemeData:getThemeBioData()
	return self._themeBioData
end

function SummerThemeData:getThemeGuessData()
	return self._guessData
end

function SummerThemeData:getThemeShopSkinData()
	for iter_16_0, iter_16_1 in ipairs((g.core.model.User.shopData:getThemeInfo(self._activeThemeType, self._activeThemeValue, true))) do
		if iter_16_1.type == g.core.common.Goods.TYPE_SKIN then
			local var_16_0 = g.core.model.User.shopData:getBuyLimitLeft(iter_16_1)

			if var_16_0 and var_16_0 > 0 then
				return {
					name = iter_16_1.name,
					type = iter_16_1.type,
					value = iter_16_1.value
				}
			end
		end
	end

	return nil
end

function SummerThemeData:getPassCardData()
	return self._passCardData
end

function SummerThemeData:isThemeActiveOpen()
	local var_18_0 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(self._activeThemeType, self._activeThemeValue)

	if var_18_0 and var_18_0:isOpen() then
		return true
	end

	return false
end

function SummerThemeData:startThemeData(arg_19_1)
	self._curThemeActiveData = arg_19_1

	if not self._curThemeActiveData then
		return
	end

	self:getBossData():startByActivityData(arg_19_1)
	self._dungeonData:startByActivityData(arg_19_1)
	self._taskData:startByActivityData(arg_19_1)
	self._exploreData:startByActivityData(arg_19_1)
	self._turnCardData:startByActivityData(arg_19_1)
	self._turnTableData:startByActivityData(arg_19_1)
	self._gemEliminateData:startByActivityData(arg_19_1)
	self._themePuzzleData:startByActivityData(arg_19_1)
	self._themeBioData:startByActivityData(arg_19_1)
	self._guessData:startByActivityData(arg_19_1)
end

function SummerThemeData:refreshRedPointData(arg_20_1)
	if arg_20_1.boss_hint then
		self:getBossData():refreshRedPointData(arg_20_1.boss_hint)
	end

	if arg_20_1.dungeon_hint then
		self._dungeonData:refreshRedPointData(arg_20_1.dungeon_hint)
	end

	if arg_20_1.task_hint then
		self._taskData:refreshRedPointData(arg_20_1.task_hint)
	end

	if arg_20_1.turn_card then
		self._turnCardData:refreshRedPointData(arg_20_1.turn_card)
	end

	if arg_20_1.turntable then
		self._turnTableData:refreshRedPointData(arg_20_1.turntable)
	end

	if arg_20_1.gem_eliminate then
		self._gemEliminateData:refreshRedPointData(arg_20_1.gem_eliminate)
	end

	if arg_20_1.turn_puzzle then
		self._themePuzzleData:refreshRedPointData(arg_20_1.turn_puzzle)
	end

	if arg_20_1.biography_hint then
		self._themeBioData:refreshRedPointData(arg_20_1.biography_hint)
	end

	if arg_20_1.guess_info then
		self._guessData:refreshRedPointData(arg_20_1.guess_info)
	end

	if arg_20_1.passcard_award and self._passCardData then
		self._passCardData:refreshRedPointData(arg_20_1.passcard_award)
	end
end

return SummerThemeData
