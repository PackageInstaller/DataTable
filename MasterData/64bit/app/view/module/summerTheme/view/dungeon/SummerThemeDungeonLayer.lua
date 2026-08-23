local var_0_0 = g.core.config.activity_theme_dungeon_chapter_info
local var_0_1 = g.core.model.User.themeData
local var_0_2 = g.core.const.ConstMgr.ThemeConst
local var_0_3 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_SOURCE_TYPE
local var_0_4 = g.core.config.activity_theme_dungeon_stage_info
local var_0_5 = g.core.config.activity_theme_display_info
local SummerThemeDungeonLayer = class("SummerThemeDungeonLayer", require("app.fairyGUI.summerTheme.UI_SummerThemeDungeonLayer"), function()
	local var_1_1 = {
		pkgPath = "ui/summerTheme/summerTheme",
		isFullScreen = true,
		pkgName = "summerTheme"
	}

	var_1_1.resName = var_0_2.THEME_ACTIVITY_DUNGEON_LAYER[({
		...
	})[1].themeValue or var_0_2.THEME_VALUE.GRYPH] or var_0_2.THEME_ACTIVITY_DUNGEON_LAYER[1]

	return fgui.GComponent:create(var_1_1, ...)
end)

function SummerThemeDungeonLayer:ctor(arg_2_1)
	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.themeValue or var_0_2.THEME_VALUE.GRYPH
	end

	self._activeThemeType = var_0_2.THEME_TYPE
	self._activeThemeValue = var_2_0
	self._chapters = nil
	self._chapterId = 0
	self._selectIndex = 1

	if arg_2_1 then
		self._initChapterId = arg_2_1.chapterId or nil
	end

	self:_initRegisterUI()
	self:_initMainViewUI()
end

function SummerThemeDungeonLayer:_initRegisterUI()
	self.m_changePhaseList = self:getChild("changePhaseList")
	self.m_changePhaseLine = self:getChild("changePhaseLine")

	self.m_chapterList:setVirtual()
	self.m_chapterList:doFairyBatching(false)
	self.m_chapterList:setScrollLimit(true)
	self.m_chapterList:setItemRenderer(handler(self, self._onChapterItemRender))
	self:addListen(self.m_chapterList)
	self.m_chestRewardBtn:addClickListener(handler(self, self._onChestRewardClick))
end

function SummerThemeDungeonLayer:_initMainViewUI()
	self._dungeonData = var_0_1:getThemeData(self._activeThemeValue):getDungeonData()

	self._dungeonData:requestThemeDungeonInfo()

	self._displayInfo = var_0_5.get(self._activeThemeValue)

	self.m_topBarComp:setResInfoById(self._displayInfo.dungeon_top_bar)
	self.m_topBarComp:setTitle(self._displayInfo.dungeon_name)

	self._chapters = self._dungeonData:getThemeDungeonChapters()

	if self._initChapterId then
		for iter_4_0, iter_4_1 in ipairs(self._chapters) do
			if iter_4_1.chapterId == self._initChapterId then
				self._selectIndex = iter_4_0

				break
			end
		end
	else
		self._selectIndex = self._dungeonData:getDefaultChapterIdx()
	end

	self._chapterId = self._chapters[self._selectIndex].chapterId

	self:_chooseDungeonChapter(self._chapterId)

	if #self._chapters == 1 then
		self.m_chapterList:setNumItems(0)
		self.m_chapterList:setTouchable(false)
	else
		self.m_chapterList:setNumItems(#self._chapters)
		self.m_chapterList:setTouchable(true)
	end

	self.m_chapterList:setSelectedIndex(self._selectIndex - 1)
	self.m_enterTransition:play()
	self:_initChangePhaseList()
end

function SummerThemeDungeonLayer:_initChangePhaseList()
	if not self.m_changePhaseList then
		return
	end

	self._mergedValues = var_0_1:getThemeMergeConfigValueList(self._activeThemeValue)

	if #self._mergedValues <= 1 then
		self.m_changePhaseList:setVisible(false)

		if self.m_changePhaseLine then
			self.m_changePhaseLine:setVisible(false)
		end

		return
	end

	self.m_changePhaseList:setVisible(true)

	if self.m_changePhaseLine then
		self.m_changePhaseLine:setVisible(true)
	end

	self.m_changePhaseList:setVirtual()
	self.m_changePhaseList:setItemRenderer(handler(self, self._onChangePhaseItemRender))
	self.m_changePhaseList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onChangePhaseListClick))
	self.m_changePhaseList:setNumItems(#self._mergedValues)
end

function SummerThemeDungeonLayer:_onChangePhaseItemRender(arg_6_1, arg_6_2)
	local var_6_0 = self._mergedValues[arg_6_1 + 1]

	arg_6_2:setTitle(var_0_5.get(self._mergedValues[arg_6_1 + 1]).main_tab)
	arg_6_2:updateTabCell(var_6_0)
	arg_6_2:setSelected(self._activeThemeValue == var_6_0)
end

function SummerThemeDungeonLayer:_onChangePhaseListClick(arg_7_1)
	local var_7_0 = arg_7_1:getDataValue()

	if var_7_0 >= 0 and self._mergedValues[var_7_0 + 1] then
		local var_7_1 = self._mergedValues[var_7_0 + 1]
		local var_7_2 = var_0_1:getActivityData(self._mergedValues[var_7_0 + 1])
		local var_7_3 = g.core.const.ConstMgr.ActivityConst

		if not var_7_2 or var_7_2:getActivityState() ~= g.core.const.ConstMgr.ActivityConst.ACTIVITY_STATE.START then
			local var_7_4 = var_7_2 and var_7_2:getActivityState()

			if var_7_4 == g.core.const.ConstMgr.ActivityConst.ACTIVITY_STATE.END or var_7_4 == g.core.const.ConstMgr.ActivityConst.ACTIVITY_STATE.EXPIRE then
				g.core.module.ModuleManager:tip(g.core.lang:get(1005))
			else
				local var_7_5 = g.core.model.User.activityDataManager:getActivityDataListByFilter(function(arg_8_0)
					if arg_8_0:getActivityType() == var_7_3.ACTIVITY_TYPE.SUMMER_ACTIVITY then
						return arg_8_0:getConfigActivityValue() == var_7_1
					end
				end)
				local var_7_6 = var_7_5 and var_7_5[1]

				if not (var_7_5 and var_7_5[1]) then
					g.core.module.ModuleManager:tip(g.core.lang:get(1005))
				else
					local var_7_7 = var_7_6:getStartTime() or 0

					if var_7_7 > g.core.common.ServerTime:getTime() then
						local var_7_8, var_7_9, var_7_10, var_7_11 = g.core.common.ServerTime:getLeftTimeParts(var_7_7)

						if var_7_10 > 0 or var_7_11 > 0 then
							var_7_9 = var_7_9 + 1
						end

						g.core.module.ModuleManager:tip(g.core.lang:get(500125, {
							day = var_7_8,
							hour = var_7_9
						}))
					else
						g.core.module.ModuleManager:tip(g.core.lang:get(1008))
					end
				end
			end

			return
		end

		self:_onChangePhaseItemClick(self._mergedValues[var_7_0 + 1])
	end
end

function SummerThemeDungeonLayer:_onChangePhaseItemClick(arg_9_1)
	if arg_9_1 == self._activeThemeValue then
		return
	end

	self._activeThemeValue = arg_9_1
	self._displayInfo = var_0_5.get(arg_9_1)

	self.m_topBarComp:setResInfoById(self._displayInfo.dungeon_top_bar)
	self.m_topBarComp:setTitle(self._displayInfo.dungeon_name)

	self._dungeonData = var_0_1:getThemeData(arg_9_1):getDungeonData()

	self._dungeonData:requestThemeDungeonInfo()

	self._chapters = self._dungeonData:getThemeDungeonChapters()
	self._selectIndex = self._dungeonData:getDefaultChapterIdx()
	self._chapterId = self._chapters[self._selectIndex].chapterId

	self:_chooseDungeonChapter(self._chapterId)

	if #self._chapters == 1 then
		self.m_chapterList:setNumItems(0)
		self.m_chapterList:setTouchable(false)
	else
		self.m_chapterList:setNumItems(#self._chapters)
		self.m_chapterList:setTouchable(true)
	end

	self.m_chapterList:setSelectedIndex(0)
	self.m_changePhaseList:setNumItems(#self._mergedValues)
	self:_updateStarInfo()
end

function SummerThemeDungeonLayer:_onChapterItemRender(arg_10_1, arg_10_2)
	arg_10_2:updateTabInfo(self._chapters[arg_10_1 + 1], arg_10_1 + 1, self._activeThemeValue)

	if self._selectIndex == arg_10_1 + 1 then
		arg_10_2:setCtrlState("isSelect", {
			index = 1
		})
	end

	arg_10_2:refreshRedPoint()
end

function SummerThemeDungeonLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_DUNGEON_GETINFO, self._refreshStageInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_DUNGEON_GETPLOT, self._onGetStagePlotRec, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayFlush, self)
	self:_checkBattleWinOrFirstPlotAni()
	self:_checkPlayFirstPassAni()
end

function SummerThemeDungeonLayer:_refreshRedPointComp()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_chestRewardBtn,
		customData = {
			themeValue = self._activeThemeValue,
			id = self._chapterId
		}
	})

	for iter_12_0, iter_12_1 in ipairs((self.m_chapterList:getChildren())) do
		iter_12_1:refreshRedPoint()
	end
end

function SummerThemeDungeonLayer:_refreshStageInfo()
	if #self._chapters == 1 then
		self.m_chapterList:setNumItems(0)
		self.m_chapterList:setTouchable(false)
	else
		self.m_chapterList:setNumItems(#self._chapters)
		self.m_chapterList:setTouchable(true)
	end

	local var_13_0 = self.m_mapPlaceComp:getChild("parallax")

	if var_13_0 then
		var_13_0:updateAllStageInfo()
	end

	self:_updateStarInfo()
end

function SummerThemeDungeonLayer:_updateStarInfo()
	local var_14_0 = var_0_0.get(self._chapterId)
	local var_14_1 = self._dungeonData:getChapterStar(self._chapterId)

	self.m_curTxt:setText(var_14_1)
	self.m_totalTxt:setText(g.core.lang:get(405711, {
		maxStar = var_14_0.stars
	}))
	self.m_progress:setPercent({
		init = 0,
		cur = var_14_1,
		max = var_14_0.stars
	})
	self:_refreshRedPointComp()
end

function SummerThemeDungeonLayer:_chooseDungeonChapter(arg_15_1)
	local var_15_0 = var_0_0.get(arg_15_1)

	if var_15_0 then
		local var_15_1 = self.m_mapPlaceComp:getChild("parallax")

		if var_15_1 then
			var_15_1:removeFromParent()
		end

		local var_15_2 = fgui.UIPackage:createObject("summerTheme", "SummerThemeParallaxComp")

		self.m_mapPlaceComp:addChild(var_15_2)

		self._dungeonParallax = var_15_2

		var_15_2:setName("parallax")
		var_15_2:createDungeonMapComp(arg_15_1, var_15_0.chapter_map, var_15_0.chapter_pos, self._activeThemeValue)
		g.core.model.User.themeData:getThemeData(self._activeThemeValue):getDungeonData():redDoNewChapterOpen(arg_15_1)
	end
end

function SummerThemeDungeonLayer:receiveCompEvent(arg_16_1, arg_16_2)
	if arg_16_1 == "ON_SELECT_CHAPTER_ID" then
		local var_16_0

		if arg_16_2 then
			var_16_0 = arg_16_2.id or 1

			if self._chapterId == var_16_0 then
				return
			end
		end

		self._chapterId = var_16_0

		if arg_16_2 then
			self._selectIndex = arg_16_2.selectIndex or 1
		end

		self:_chooseDungeonChapter(self._chapterId)
		self:_refreshStageInfo()
	elseif arg_16_1 == "SELECT_STORY_STAGE_POP" then
		if arg_16_2 then
			self._selectStoryId = arg_16_2.stageId or 1
		end
	elseif arg_16_1 == "EVENT_STORY_END" then
		self:_updateByStoryEnd(arg_16_2)
	end
end

function SummerThemeDungeonLayer:_onChestRewardClick()
	local SummerThemeStarAwardPop = require("app.view.module.summerTheme.view.dungeon.SummerThemeStarAwardPop")

	if SummerThemeStarAwardPop then
		g.core.module.ModuleManager:pushPopup(SummerThemeStarAwardPop.new({
			chapterId = self._chapterId,
			themeValue = self._activeThemeValue
		}))
	end
end

function SummerThemeDungeonLayer:_onGetStagePlotRec(arg_18_1, arg_18_2, arg_18_3)
	if arg_18_3.awards then
		g.core.module.ModuleManager:awardSummary(arg_18_3.awards, true)
		self:newScheduleOnce(function()
			self:_checkPlayFirstPassAni()
		end, 1.5)
	end

	self:_refreshStageInfo()
end

function SummerThemeDungeonLayer:_updateByStoryEnd(arg_20_1)
	if arg_20_1.trigger_type == "EVENT_STORY_FORCE_START" and self._selectStoryId then
		if not self._dungeonData:getStage(self._selectStoryId) then
			local var_20_0 = self._dungeonData:getDungeonActivitySourceType()
			local var_20_1 = var_20_0 == var_0_3.CONFIG_TABLE and 1 or 0
			local var_20_2 = var_0_4.get(self._selectStoryId).chapter_id

			if not var_20_0 or not self._activeThemeValue then
				return
			end

			g.core.network.GameNetProxy:send_C2S_ThemeDungeon_GetPlot({
				recruit_type = var_20_1,
				act_id = self._activeThemeValue,
				chapter_id = var_20_2,
				stage_id = self._selectStoryId
			})
		end
	end
end

function SummerThemeDungeonLayer:_onCrossDayFlush()
	if #self._chapters == 1 then
		self.m_chapterList:setNumItems(0)
		self.m_chapterList:setTouchable(false)
	else
		self.m_chapterList:setNumItems(#self._chapters)
		self.m_chapterList:setTouchable(true)
	end
end

function SummerThemeDungeonLayer:_checkPlayFirstPassAni()
	if self._dungeonData:getFirstPassChapter(self._chapterId) then
		local var_22_0 = var_0_0.get(self._chapterId)

		if var_22_0 then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.summerTheme.view.dungeon.SummerThemeDungeonFinishPop").new({
				id = var_22_0.number,
				themeValue = self._activeThemeValue
			}), {
				blackOpacity = 0.2
			})
			self._dungeonData:setFirstPassChapter(self._chapterId, false)
		end

		if #self._chapters == 1 then
			self.m_chapterList:setNumItems(0)
			self.m_chapterList:setTouchable(false)
		else
			self.m_chapterList:setNumItems(#self._chapters)
			self.m_chapterList:setTouchable(true)
		end
	end
end

function SummerThemeDungeonLayer:_checkBattleWinOrFirstPlotAni()
	local var_23_0 = self._dungeonData:getNewStageId()

	if var_23_0 > 0 then
		local var_23_1 = self.m_mapPlaceComp:getChild("parallax")

		if var_23_1 then
			local var_23_2 = var_23_1:getStageComp(var_23_0 - 1)

			if var_23_2 then
				var_23_2:refreshMonsterState()
				var_23_2:playPassAni()
			end

			local var_23_3 = var_23_1:getStageComp(var_23_0)
			local var_23_4 = var_23_1:getPreLineCompByStageId(var_23_0)

			if var_23_3 and var_23_4 then
				var_23_4:setVisible(true)
				var_23_4:getTransition("switch"):changeParams({
					xy = {
						var_23_4:getWidth(),
						-1
					}
				}):play(handler(self, function()
					var_23_3:setVisible(true)
					var_23_3:getTransition("enter"):play()
				end))
			end

			var_23_1:moveToMonsterPos()
		end

		self._dungeonData:resetNewStageId()
		self:_updateStarInfo()
	elseif self._dungeonParallax then
		self._dungeonParallax:updateAllStageInfo()
		self:_updateStarInfo()
	end
end

return SummerThemeDungeonLayer
