local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.themeData
local var_0_2 = g.core.const.ConstMgr.ThemeConst
local KsMath = require("app.core.utils.KsMath")
local BGFactory = require("app.view.common.BGFactory")
local SummerThemeParallaxComp = class("SummerThemeParallaxComp", require("app.fairyGUI.summerTheme.UI_SummerThemeParallaxComp"))

function SummerThemeParallaxComp:ctor()
	self._mapId = 0
	self._chapterId = 0
	self._monsterPos = 0
	self._mapComp = nil
	self._dungeonData = nil
	self._curTouchX = 0
	self._linesArray = {}
	self._lineComps = {}
	self._monsterComps = {}
	self._activeThemeValue = 0

	self:_initUIListener()
end

function SummerThemeParallaxComp:_initUIListener()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
end

function SummerThemeParallaxComp:createDungeonMapComp(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self._chapterId = arg_3_1
	self._mapId = arg_3_2
	self._monsterPos = arg_3_3
	self._activeThemeValue = arg_3_4
	self._dungeonData = var_0_1:getThemeData(self._activeThemeValue):getDungeonData()
	self._stageInfos = self._dungeonData:getStagesCfgByChapterId(arg_3_1)
	self._mapComp = BGFactory.create({
		initPosX = 0,
		bgPath = "parallax/themeDungeon/" .. arg_3_2 .. "/themeDungeon.pcfg",
		parent = self,
		stage = self.m_monsterPlaceComp
	})
	self._mapSize = BGFactory.getMapSize({
		bgPath = "parallax/themeDungeon/" .. arg_3_2 .. "/themeDungeon.pcfg"
	})

	self:_createMonsterComp()
	self:_createChapterRouteLine()
	self:moveToMonsterPos()
end

function SummerThemeParallaxComp:_createMonsterComp()
	self._monstersArray = {}
	self._monsterCfg = json.decodeFile((var_0_0:getThemeDungeonMonsterPos(self._mapId, self._monsterPos)))

	self.m_monsterPlaceComp:setY(self.m_monsterPlaceComp:getY() - self._mapComp:getYOffset())

	for iter_4_0 = 1, #self._monsterCfg do
		if self._monsterCfg[iter_4_0].isMonster and self._stageInfos then
			if self._stageInfos[self._monsterCfg[iter_4_0].index] then
				local var_4_1 = fgui.UIPackage:createObject("summerTheme", var_0_2.THEME_ACTIVITY_DUNGEON_CHAPTER_COMP[self._activeThemeValue] or "SummerThemeDungeonChapterComp", self)

				var_4_1:setPosition(self._monsterCfg[iter_4_0].pos.x, (math.min(self._monsterCfg[iter_4_0].pos.y - (display.height - CC_DESIGN_RESOLUTION.height) / 2, self._monsterCfg[iter_4_0].pos.y - math.max((display.height - CC_DESIGN_RESOLUTION.height) / 2, 61))))
				var_4_1:setName("monsterComp_" .. self._stageInfos[self._monsterCfg[iter_4_0].index].id)
				var_4_1:setVisible(false)
				var_4_1:setSortingOrder(1000 - iter_4_0 * 10)
				self.m_monsterPlaceComp:addChild(var_4_1)
			end
		end
	end
end

function SummerThemeParallaxComp:_createChapterRouteLine()
	self._lineArray = {}

	for iter_5_0 = 1, #self._stageInfos do
		if self._stageInfos[iter_5_0] and self._stageInfos[iter_5_0 + 1] then
			local var_5_0 = self.m_monsterPlaceComp:getChild("monsterComp_" .. self._stageInfos[iter_5_0].id)
			local var_5_1 = self.m_monsterPlaceComp:getChild("monsterComp_" .. self._stageInfos[iter_5_0 + 1].id)

			if var_5_0 and var_5_1 then
				local var_5_2 = var_5_0:getPosition()
				local var_5_3 = var_5_1:getPosition()

				table.insert(self._lineArray, {
					pos = var_5_2,
					angle = -KsMath.calculateRotation(var_5_2, var_5_3),
					length = math.sqrt(math.pow(math.abs(var_5_2.x - var_5_3.x), 2) + math.pow(math.abs(var_5_2.y - var_5_3.y), 2))
				})
			end
		end
	end

	if next(self._lineArray) then
		for iter_5_1 = 1, #self._lineArray do
			local var_5_4 = fgui.UIPackage:createObject("base_new", "BaseGuideLIneComp")

			var_5_4:setPosition(self._lineArray[iter_5_1].pos)
			var_5_4:setRotation(self._lineArray[iter_5_1].angle)
			var_5_4:setWidth(self._lineArray[iter_5_1].length)
			var_5_4:setName("line_" .. iter_5_1)
			var_5_4:setVisible(false)
			self.m_monsterPlaceComp:addChild(var_5_4)
		end
	end
end

function SummerThemeParallaxComp:updateAllStageInfo()
	local var_6_0 = self._dungeonData:getStageIndexByChapterId(self._chapterId, (self._dungeonData:getUnlockLastStageId(self._chapterId)))

	for iter_6_0 = 1, #self._stageInfos do
		local var_6_1 = self._stageInfos[iter_6_0]
		local var_6_2 = self.m_monsterPlaceComp:getChild("monsterComp_" .. self._stageInfos[iter_6_0].id)

		if var_6_2 then
			var_6_2:setVisible(iter_6_0 <= var_6_0)
			var_6_2:updateMonsterInfo(var_6_1, self._activeThemeValue)
		end

		local var_6_3 = self.m_monsterPlaceComp:getChild("line_" .. iter_6_0)

		if var_6_3 then
			var_6_3:setVisible(iter_6_0 <= var_6_0 - 1)
		end
	end
end

function SummerThemeParallaxComp:getStageComp(arg_7_1)
	local var_7_0 = self.m_monsterPlaceComp:getChild("monsterComp_" .. arg_7_1)

	if var_7_0 then
		return var_7_0
	end

	return nil
end

function SummerThemeParallaxComp:getPreLineCompByStageId(arg_8_1)
	local var_8_0 = self.m_monsterPlaceComp:getChild("line_" .. self._dungeonData:getStageIndexByChapterId(self._chapterId, arg_8_1) - 1)

	if var_8_0 then
		return var_8_0
	end

	return nil
end

function SummerThemeParallaxComp:_onTouchBegin(arg_9_1)
	arg_9_1:captureTouch()

	self._curTouchX = arg_9_1:getInput():getPosition().x
end

function SummerThemeParallaxComp:_onTouchMove(arg_10_1)
	local var_10_0 = arg_10_1:getInput():getPosition()

	self:_moveMap(var_10_0.x - self._curTouchX)

	self._curTouchX = var_10_0.x
end

function SummerThemeParallaxComp:_moveMap(arg_11_1)
	local var_11_0 = arg_11_1 > 0
	local var_11_1 = self.m_monsterPlaceComp:getX()

	if arg_11_1 > 0 and var_11_1 >= 0 or not var_11_0 and var_11_1 + self._mapSize.width <= display.width then
		return
	end

	local var_11_2 = var_11_1 + arg_11_1

	self._mapComp:setDragRangeX(display.width - self._mapSize.width, 0)
	self._mapComp:setPosition(var_11_2, -(self._mapComp:getYOffset() + (display.height - CC_DESIGN_RESOLUTION.height) / 2))
end

function SummerThemeParallaxComp:moveToMonsterPos()
	self._mapComp:setPosition(math.max(math.min(0, math.max(display.width / 2 - self:getStageComp((self._dungeonData:getUnlockLastStageId(self._chapterId))):getPosition().x, display.width / 2 - self._mapSize.width)), display.width - self._mapSize.width), -(self._mapComp:getYOffset() + (display.height - CC_DESIGN_RESOLUTION.height) / 2))
end

return SummerThemeParallaxComp
