local var_0_0 = g.core.const.ConstMgr.ThemeConst
local var_0_1 = g.core.model.User.themeData
local SummerThemeDungeonChapterComp = class("SummerThemeDungeonChapterComp", require("app.fairyGUI.summerTheme.UI_SummerThemeDungeonChapterComp"))

function SummerThemeDungeonChapterComp:ctor()
	self._stageId = nil
	self._stageType = 0
	self._dungeonData = nil
	self._stageData = nil
	self._activeThemeValue = 1

	self:addClickListener(handler(self, self._onClick))
end

function SummerThemeDungeonChapterComp:updateMonsterInfo(arg_2_1, arg_2_2)
	self._activeThemeValue = arg_2_2
	self._dungeonData = var_0_1:getThemeData(self._activeThemeValue):getDungeonData()
	self._stageId = arg_2_1.id
	self._stageType = arg_2_1.stage_type

	self.m_stageIdTxt:setText(arg_2_1.stage_id)
	self.m_stageNameTxt:setText(arg_2_1.name)
	self.m_typeController:setSelectedIndex(self._stageType == var_0_0.DUNGEON_STAGE_TYPE.BATTLE and 0 or 1)
	self:refreshMonsterState()
	self:refreshStar()
end

function SummerThemeDungeonChapterComp:refreshStar()
	if self._stageData then
		self.m_starController:setSelectedIndex((self._stageData:getStageStar()))
	else
		self.m_starController:setSelectedIndex(0)
	end
end

function SummerThemeDungeonChapterComp:refreshMonsterState()
	self._stageData = self._dungeonData:getStage(self._stageId)

	if self._stageData then
		self.m_isPassController:setSelectedIndex(self._stageData:getStagePassed() and 1 or 0)
	end

	self:refreshStar()
end

function SummerThemeDungeonChapterComp:playPassAni()
	self.m_passTransition:play()
end

function SummerThemeDungeonChapterComp:_onClick()
	if self._stageType == var_0_0.DUNGEON_STAGE_TYPE.BATTLE then
		self:addPopup(require("app.view.module.summerTheme.view.dungeon.SummerDungeonBattlePop").new({
			id = self._stageId,
			themeValue = self._activeThemeValue
		}))
	else
		self:addPopup(require("app.view.module.summerTheme.view.dungeon.SummerDungeonStoryStagePop").new({
			id = self._stageId,
			themeValue = self._activeThemeValue
		}))
	end
end

return SummerThemeDungeonChapterComp
