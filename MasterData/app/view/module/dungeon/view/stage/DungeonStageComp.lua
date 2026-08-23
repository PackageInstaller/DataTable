local DungeonStageComp = class("DungeonStageComp", require("app.fairyGUI.dungeon.UI_DungeonStageComp"))
local DungeonMapHelper = require("app.view.module.dungeon.utils.DungeonMapHelper")
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.const.ConstMgr.DungeonConst
local var_0_5 = g.core.model.User.dungeonData
local var_0_6 = g.core.common.Path
local var_0_7 = g.core.const.ConstMgr.SpineConst

function DungeonStageComp:ctor()
	self._chapterInfo = nil
	self._isPlayRoleAnim = false
	self._stageNum = 0
	self._compBoss = nil
	self._stageRoute = {}
	self._chapterEnd = false
	self._mapComp = nil
	self._mapSize = {}
	self._isMonsterInit = false
	self._isFirstEnter = true
	self._idleMonster = {}
	self._monsterCfg = {}
	self._preStageIndex = 0
	self._interactCfg = nil
	self._interactCompCache = nil
	self._movingSchedule = nil
	self._checkMovePos = {}
	self._scrollCompCall = nil
	self._scrollCompClickCall = nil
	self._effectState = {}
	self._isEditor = var_0_5:getDebugEditor()
	self._posIndexDebug = 0
	self._posListDebug = {}

	self:setEnablePosYAsZOrder(true)
	var_0_5:resetBattleInfo()
	self.m_roleComp:updateMainRole()
	self.m_roleComp:setTouchable(false)
	self.m_roleComp:playShowAction()
	self:addClickListener(handler(self, self._onClick))
	self:addChildWithListen(self.m_roleComp)
end

function DungeonStageComp:_onClick(arg_2_1)
	local var_2_0 = arg_2_1:getInput():getTouch()

	if not var_2_0 then
		return
	end

	local var_2_1 = self:displayObject():convertTouchToNodeSpace(var_2_0)

	var_2_1.y = self:getSize().height - var_2_1.y

	if self._isEditor then
		local var_2_2 = fgui.UIPackage:createObject("dungeon", "DungeonAreaLinePoint", self)

		var_2_2:setPosition(var_2_1.x, var_2_1.y)
		self:addChild(var_2_2)

		self._posIndexDebug = self._posIndexDebug + 1
		self._posListDebug[self._posIndexDebug % 2 == 0 and 2 or 1] = clone(var_2_1)

		if #self._posListDebug >= 2 then
			if self._showSizeComp == nil then
				self._resetBtn = fgui.UIPackage:createObject("base_new", "BaseBtn", self)

				self._resetBtn:setPosition(1000, 500)
				self._resetBtn.m_title:setText("reset")
				self:addChild(self._resetBtn)
				self._resetBtn:addClickListener(handler(self, self.resetPoint))

				self._showSizeComp = fgui.UIPackage:createObject("dungeon", "DungeonAreaLinePoint1", self)

				self:addChild(self._showSizeComp, 1)
			end

			self._showSizeComp:setSize(math.abs(self._posListDebug[1].x - self._posListDebug[2].x), (math.abs(self._posListDebug[1].y - self._posListDebug[2].y)))
			self._showSizeComp:setVisible(true)
			self.m_roleComp:setVisible(false)
			self._showSizeComp:setPosition(math.min(self._posListDebug[1].x, self._posListDebug[2].x), math.min(self._posListDebug[1].y, self._posListDebug[2].y))
			self._showSizeComp:getChild("point1"):setText(math.floor((math.min(self._posListDebug[1].x, self._posListDebug[2].x))) .. "," .. math.floor((math.min(self._posListDebug[1].y, self._posListDebug[2].y))))
			self._showSizeComp:getChild("point2"):setText(math.floor((math.max(self._posListDebug[1].x, self._posListDebug[2].x))) .. "," .. math.floor((math.max(self._posListDebug[1].y, self._posListDebug[2].y))))
		end
	end

	if self._chapterInfo.id == var_0_5:getLastUnlockChapter() then
		for iter_2_0 = 1, #self._monsterCfg do
			if self._monsterCfg[iter_2_0].isMonster then
				if self._chapterInfo["stage_" .. self._monsterCfg[iter_2_0].index] > 0 and self._chapterInfo["stage_" .. self._monsterCfg[iter_2_0].index] == var_0_5:getOpenUnlockStageId() and not var_0_5:isStagePassed(self._chapterInfo["stage_" .. self._monsterCfg[iter_2_0].index]) and var_2_1.x > self._monsterCfg[iter_2_0].pos.x + var_0_4.OPEN_STAGE_OFFESTX then
					g.core.module.ModuleManager:tip(g.core.lang:get(300027))

					return
				end
			end
		end
	end

	if self._scrollCompClickCall ~= nil and self._scrollCompClickCall(var_2_0:getLocation(), var_2_1) then
		return
	end

	self:onMoveTargetPos(var_2_1)
end

function DungeonStageComp:resetPoint()
	self._posListDebug = {}
	self._posIndexDebug = 0

	if self._showSizeComp then
		self._showSizeComp:setVisible(false)
	end

	self.m_roleComp:setVisible(true)
end

function DungeonStageComp:onMoveTargetPos(arg_4_1, arg_4_2)
	local var_4_0, var_4_1 = self._pathInPolygon:getRoutesFromAreaData(self.m_roleComp:getPosition(), arg_4_1)

	if var_4_0 == 0 then
		if self:isPortalTargetPos() then
			self:portalToTargetPos(arg_4_1, function()
				if arg_4_2 then
					arg_4_2()
				end
			end)
		else
			self.m_roleComp:onMove(var_4_1, function()
				if arg_4_2 then
					arg_4_2()
				end
			end)
		end
	end
end

function DungeonStageComp:isPortalTargetPos()
	local var_7_0 = self:getMainRolePos()

	var_7_0.y = var_7_0.y - 50

	local var_7_1 = var_7_0.x + self:getX()
	local var_7_2 = var_7_0.y + self:getY()

	return var_7_1 < -100 or var_7_1 > display.width + 100 or var_7_2 < -100 or var_7_2 > display.height + 100
end

function DungeonStageComp:portalToTargetPos(arg_8_1, arg_8_2)
	if arg_8_1 then
		if not self._pathInPolygon:checkPointInArea(arg_8_1.x, arg_8_1.y) then
			g.core.module.ModuleManager:tip(g.core.lang:get(300029))

			return
		end

		self.m_roleComp:stopCurActions()
		self.m_roleComp:stopAllFGActions()
		self:setTouchable(false)

		local var_8_0 = self.m_roleComp:getSize()

		self.m_roleComp:setPosition(arg_8_1.x, arg_8_1.y)
		self.m_focusComp:setPosition(arg_8_1.x, arg_8_1.y)
		self.m_roleComp:addEffectSpine({
			isLoop = false,
			name = "battle_shunyi",
			x = var_8_0.width / 2,
			y = var_8_0.height / 2 - 80,
			eventHandler = handler(self, function()
				if arg_8_2 then
					arg_8_2()
				end

				self:setTouchable(true)
			end)
		})
		self:checkMoving()
	end
end

function DungeonStageComp:initChapterId(arg_10_1)
	self._chapterId = arg_10_1
	self._chapterInfo = g.core.config.dungeon_chapter_info.get(arg_10_1)
	self._mapId = self._chapterInfo.stage_map
	self._routeId = self._chapterInfo.ctrl_id

	if g.core.utils.Quality.needUseStaticMap() then
		self._mapId = self._mapId .. "0001"
		self._routeId = self._routeId .. "0001"
	end

	self:_initInteractInfo()

	self._monsterCfg = json.decodeFile((var_0_6:getDungeonMonsterPos(self._mapId, self._routeId)))
	self._pathInPolygon = require("app.core.utils.PathInPolygon").new({
		mapId = self._mapId,
		monsterCfg = self._monsterCfg
	})

	if self._isEditor then
		local var_10_0 = json.decodeFile((var_0_6:getDungeonArea(self._mapId))).area or {}
		local var_10_1 = #var_10_0

		for iter_10_0 = 1, #var_10_0 do
			local var_10_2 = self._pathInPolygon:fitPosY(var_10_0[iter_10_0].y)
			local var_10_3 = self._pathInPolygon:fitPosY(var_10_0[iter_10_0 % var_10_1 + 1].y) - var_10_2
			local var_10_4 = math.sqrt(var_10_3 * var_10_3 + (var_10_0[iter_10_0 % var_10_1 + 1].x - var_10_0[iter_10_0].x) * (var_10_0[iter_10_0 % var_10_1 + 1].x - var_10_0[iter_10_0].x))
			local var_10_5 = math.atan2(var_10_3, var_10_0[iter_10_0 % var_10_1 + 1].x - var_10_0[iter_10_0].x) * 180 / math.pi
			local var_10_6 = fgui.UIPackage:createObject("dungeon", "DungeonAreaLine", self)

			var_10_6:setPosition(var_10_0[iter_10_0].x, var_10_2)
			var_10_6:getChild("pointTxt"):setText(var_10_0[iter_10_0].x .. "_" .. var_10_2)

			local var_10_7 = var_10_6:getChild("area")

			var_10_7:setSize(var_10_4, 2)
			var_10_7:setRotation(var_10_5)
			self:addChild(var_10_6)
		end
	end
end

function DungeonStageComp:onLoad()
	if self._isFirstEnter then
		var_0_5:resetNewStageId()
	end

	local var_11_0 = var_0_5:getNewStageId()

	self._isPlayRoleAnim = var_11_0 > 0

	if var_0_5:getNewChapterId() > 0 then
		self._chapterEnd = true

		self:setTouchable(false)
	end

	var_0_3:addEventListener(var_0_2.EVENT_GUIDE_FINISH, handler(self, self._onForceGuideEnd), self)

	if g.core.model.User.storyData:isInStory() then
		self:setTouchable(false)

		if var_11_0 > 0 then
			local var_11_1 = var_0_5:getStageIndex(g.core.config.dungeon_stage_info.get(var_11_0).preset_stage)
			local var_11_2

			var_11_2, self._preStageIndex = var_0_5:getStageIndex(var_11_0), var_11_1

			self:updateRoleAndMapPos((self._chapterEnd or nil) and var_11_1, true, self._chapterEnd)
		end
	else
		self._preStageIndex = 0

		self:handlePostBattleAni()
	end

	self._isFirstEnter = false

	var_0_3:addEventListener(var_0_2.EVENT_NET_S2C_INTERACTION_INFO, handler(self, self.resetRoleHightLight), self)
	var_0_3:addEventListener(var_0_2.EVENT_NET_S2C_DUNGEON_CHALLENGESTAGEBEGIN, self._onRcvBattleBegin, self)
	var_0_3:addEventListener(var_0_2.EVENT_NET_S2C_DUNGEON_CHALLENGESTAGEFINISH, self._onRcvBattleFinish, self)
	var_0_3:addEventListener(var_0_2.EVENT_KEY_PAD, handler(self, self._onKeypadClicked), self)
end

function DungeonStageComp:onUnload()
	if self._movingSchedule ~= nil then
		g.core.common.Scheduler:cancelSchedule(self._movingSchedule)

		self._movingSchedule = nil
	end

	self._isClose = true
	self._guidePause = false

	var_0_3:dispatchEvent(var_0_2.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function DungeonStageComp:postBattle()
	local var_13_0 = var_0_5:getBattleInfo()
	local var_13_1, var_13_2

	if var_13_0 then
		var_13_1 = var_13_0.isWin or false

		if var_13_0 then
			var_13_2 = var_13_0.isFirst or false
		end
	end

	local var_13_3 = var_13_0.stageId

	if var_13_1 and var_13_2 then
		var_0_3:dispatchEvent(var_0_2.EVENT_DUNGEON_STAGE_END, false, {
			story = {
				var_13_3
			}
		})

		if var_0_5:isBossStage(var_13_3) then
			self:setAllMonsterAndChestTouch(false)
		end
	end
end

function DungeonStageComp:handlePostBattleAni()
	local var_14_0 = var_0_5:getNewStageId()
	local var_14_1 = var_0_5:getBattleInfo()

	if var_14_1 then
		if var_14_1 then
			local var_14_3 = var_14_1.isWin or false

			if next(var_14_1) then
				local var_14_4 = self:getChild("Comp_monster" .. var_0_5:getStageIndex(var_14_1.stageId))

				if not var_14_4 then
					return
				end

				var_14_4:checkStarAnimation()

				if self._chapterId == var_0_4.GUIDE_LOCK_STAGE.CHAPTER_ID and var_14_1.stageId == self._chapterInfo["stage_" .. var_0_4.GUIDE_LOCK_STAGE.STAGE_ID] and var_14_3 and (var_14_1.isFirst or false) then
					var_0_3:dispatchEvent(var_0_2.EVENT_GUIDE_DUNGEON_SPECIAL_LOCK)
				end
			end

			if var_14_0 == 0 then
				local var_14_5 = var_0_5:getLastUnlockStageId()
				local var_14_6 = var_0_5:getStageIndex(var_14_5)

				assert(var_14_5 > 0, "not found unlock stage, " .. "current chapter is " .. tostring(self._chapterId) .. ", unlock chapter is " .. var_0_5:getLastUnlockChapter())

				if var_0_5:isBossStage(var_14_5) then
					self:updateRoleAndMapPos(var_14_6, false, true)
				end
			end

			if self._isPlayRoleAnim and var_14_3 then
				self:setTouchable(false)

				if not self._chapterEnd then
					self:updateRouteAnimation(var_14_0, true)
				end
			end
		end
	end
end

function DungeonStageComp:update(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	self._mapComp = arg_15_3
	self._mapSize = self._mapComp:getMapSize()
	self._stageNum = var_0_5:getStageNum(arg_15_1.id)
	self._stageRoute = json.decodeFile((var_0_6:getDungeonMainRoute(self._mapId, self._routeId)))
	self._stageRoute = DungeonMapHelper:getFitMainRoleRoute(self._stageRoute)

	self:updateStage(arg_15_2)

	self._compBoss = self:getChild("Comp_monster" .. #var_0_5:getStageIds(arg_15_1.id))

	self:updateMainRolePos(arg_15_1)
end

function DungeonStageComp:battleEndUpdate(arg_16_1)
	self:_checkTickWeakGuide()
	self:updateMonsterState(false)
end

function DungeonStageComp:getMainRolePos()
	return {
		x = self.m_roleComp:getX(),
		y = self.m_roleComp:getY()
	}
end

function DungeonStageComp:updateStage(arg_18_1)
	local var_18_0 = -self:getX() - 150

	if self._isMonsterInit then
		self:updateMonsterState(not arg_18_1)
		self:updateStageChest()

		return
	end

	local var_18_1 = self._monsterCfg
	local var_18_2 = 1

	for iter_18_0 = 1, #self._monsterCfg do
		if var_18_1[iter_18_0].isMonster then
			if var_18_0 <= var_18_1[iter_18_0].pos.x and var_18_0 + display.width + 150 >= var_18_1[iter_18_0].pos.x then
				local var_18_3 = fgui.UIPackage:createObject("dungeon", "DungeonMonsterComp", self)

				var_18_3:setPosition(var_18_1[iter_18_0].pos.x, var_18_1[iter_18_0].pos.y - (display.height - CC_DESIGN_RESOLUTION.height) / 2)
				var_18_3:setName("Comp_monster" .. var_18_1[iter_18_0].index)
				self:addChild(var_18_3)

				if self._chapterInfo["stage_" .. var_18_1[iter_18_0].index] > 0 then
					var_18_3:update(g.core.config.dungeon_stage_info.get(self._chapterInfo["stage_" .. var_18_1[iter_18_0].index]), var_0_5:isStageUnlocked(self._chapterInfo["stage_" .. var_18_1[iter_18_0].index]), not arg_18_1, (var_0_5:isBossStage(self._chapterInfo["stage_" .. var_18_1[iter_18_0].index], self._chapterInfo.id)))
					var_18_3:updatePreStar()
					var_18_3:setVisible(true)
				else
					var_18_3:setVisible(false)
				end
			else
				self._idleMonster[var_18_1[iter_18_0].index] = var_18_1[iter_18_0]
			end
		else
			local var_18_4 = fgui.UIPackage:createObject("dungeon", "DungeonStageChestComp", self)

			var_18_4:setPosition(var_18_1[iter_18_0].pos.x, var_18_1[iter_18_0].pos.y - (display.height - CC_DESIGN_RESOLUTION.height) / 2)

			local var_18_5 = self._chapterInfo["stage_chest_" .. var_18_2]

			if self._chapterInfo["stage_chest_" .. var_18_2] > 0 then
				var_18_4:setVisible(var_18_5 > 0 and var_0_5:isStageChestSeen(var_18_5))
				var_18_4:update(self._chapterInfo.id, g.core.config.dungeon_chest_info.get(var_18_5), var_18_2)
				var_18_4:setName("chestComp" .. var_18_2)

				var_18_2 = var_18_2 + 1
			end

			self:addChild(var_18_4)
		end
	end

	self:_createInteractComp()

	self._isMonsterInit = true

	self:addIdleMonsterComp(not arg_18_1)
	self:_checkTickWeakGuide()
end

function DungeonStageComp:doAutoAction()
	for iter_19_0 = 1, var_0_4.MAX_STAGE_COUNT do
		local var_19_0 = self:getChild("Comp_monster" .. iter_19_0)

		if var_19_0 and var_19_0:doAutoAction() then
			return var_19_0
		end
	end
end

function DungeonStageComp:addIdleMonsterComp(arg_20_1)
	for iter_20_0, iter_20_1 in pairs(self._idleMonster) do
		local var_20_0 = fgui.UIPackage:createObject("dungeon", "DungeonMonsterComp", self)

		var_20_0:setPosition(iter_20_1.pos.x, iter_20_1.pos.y - (display.height - CC_DESIGN_RESOLUTION.height) / 2)
		var_20_0:setName("Comp_monster" .. iter_20_0)
		self:addChild(var_20_0)

		local var_20_1 = self._chapterInfo["stage_" .. iter_20_0]
		local var_20_2 = var_0_5:isStageUnlocked(self._chapterInfo["stage_" .. iter_20_0])
		local var_20_3 = var_0_5:isBossStage(self._chapterInfo["stage_" .. iter_20_0], self._chapterInfo.id)

		var_20_0:setVisible(self._chapterInfo["stage_" .. iter_20_0] > 0)

		if var_20_1 > 0 then
			local var_20_4 = g.core.config.dungeon_stage_info.get(var_20_1)
			local var_20_5 = g.core.config.knight_base_info.get(var_20_4.res)

			if g.core.model.User.splitDownloadData:isShowDownloadListPop() then
				if var_20_0.update then
					var_20_0:update(var_20_4, var_20_2, arg_20_1, var_20_3)
					var_20_0:updatePreStar()
				end
			else
				g.core.resource.ResourceManager:loadKnightSpineAsync({
					var_20_5.fight_id
				}, function()
					if var_20_0.update then
						var_20_0:update(var_20_4, var_20_2, arg_20_1, var_20_3)
						var_20_0:updatePreStar()
					end
				end)
			end
		end
	end
end

function DungeonStageComp:updateMonsterState(arg_22_1)
	for iter_22_0 = 1, var_0_4.MAX_STAGE_COUNT do
		local var_22_0 = self:getChild("Comp_monster" .. iter_22_0)

		if self._chapterInfo["stage_" .. iter_22_0] > 0 and var_22_0 then
			var_22_0:update(g.core.config.dungeon_stage_info.get(self._chapterInfo["stage_" .. iter_22_0]), var_0_5:isStageUnlocked(self._chapterInfo["stage_" .. iter_22_0]), arg_22_1, (var_0_5:isBossStage(self._chapterInfo["stage_" .. iter_22_0], self._chapterInfo.id)))

			if iter_22_0 == self._preStageIndex then
				var_22_0:showPreStar()
			end
		end
	end
end

function DungeonStageComp:getMonsterByStageID(arg_23_1)
	return (self:getChild("Comp_monster" .. var_0_5:getStageIndex(arg_23_1)))
end

function DungeonStageComp:setAllMonsterVisible(arg_24_1)
	for iter_24_0 = 1, var_0_4.MAX_STAGE_COUNT do
		local var_24_0 = self:getChild("Comp_monster" .. iter_24_0)

		if var_24_0 then
			var_24_0:setMonsterEffectVisble(arg_24_1)
		end
	end
end

function DungeonStageComp:setAllMonsterAndChestTouch(arg_25_1)
	for iter_25_0 = 1, var_0_4.MAX_STAGE_COUNT do
		local var_25_0 = self:getChild("Comp_monster" .. iter_25_0)

		if var_25_0 then
			var_25_0:setTouchable(arg_25_1)
		end

		local var_25_1 = self:getChild("chestComp" .. iter_25_0)

		if var_25_1 then
			var_25_1:setTouchable(arg_25_1)
		end
	end
end

function DungeonStageComp:updateStageChest()
	for iter_26_0 = 1, var_0_4.MAX_STAGE_CHEST_COUNT do
		local var_26_0 = self:getChild("chestComp" .. iter_26_0)

		if not var_26_0 then
			return
		end

		local var_26_1 = self._chapterInfo["stage_chest_" .. iter_26_0]

		var_26_0:setVisible(self._chapterInfo["stage_chest_" .. iter_26_0] > 0 and var_0_5:isStageChestSeen(self._chapterInfo["stage_chest_" .. iter_26_0]))

		if var_26_1 > 0 then
			var_26_0:update(self._chapterInfo.id, g.core.config.dungeon_chest_info.get(var_26_1), iter_26_0)
		end
	end
end

function DungeonStageComp:setAllStageChestVisible(arg_27_1)
	for iter_27_0 = 1, var_0_4.MAX_STAGE_CHEST_COUNT do
		local var_27_0 = self:getChild("chestComp" .. iter_27_0)

		if var_27_0 then
			var_27_0:setVisible(arg_27_1)
		end
	end
end

function DungeonStageComp:updateRoleAndMapPos(arg_28_1, arg_28_2, arg_28_3)
	if not self._stageRoute[arg_28_1] then
		return
	end

	local var_28_0 = DungeonMapHelper:getRealRoleRoute(self._stageRoute[arg_28_1], self._mapSize, self._mapId)

	self.m_roleComp:stopAllFGActions()
	self.m_focusComp:stopAllFGActions()

	local var_28_1 = self._stageRoute[arg_28_1][1]
	local var_28_2 = var_28_0[1]

	if arg_28_3 then
		var_28_1 = self._stageRoute[arg_28_1][#self._stageRoute[arg_28_1]]
		var_28_2 = var_28_0[#var_28_0]
	end

	self.m_roleComp:setPosition(var_28_1.x, var_28_1.y)
	self:checkMoving()
	self.m_roleComp:playAction("ready")
	self.m_focusComp:setPosition(var_28_2.x, var_28_2.y)

	if arg_28_2 then
		self._mapComp:setPosition(math.max(display.width - self._mapSize.width, math.min(display.width / 2 - var_28_2.x, 0)), (math.max(display.height - self._mapSize.height + (display.height - CC_DESIGN_RESOLUTION.height) / 2, math.min(display.height / 2 - var_28_2.y - 0, 0))))
	end
end

function DungeonStageComp:updateRouteAnimation(arg_29_1, arg_29_2)
	self:updateRoleAndMapPos(var_0_5:getStageIndex(arg_29_1), arg_29_2)

	if arg_29_2 then
		self._nextStage = arg_29_1

		self:showMainRole(function()
			self:runFGAction((fgui.FSequence:create({
				fgui.FDelayTime:create(0.1),
				fgui.FCallFunc:create(handler(self, self.doUpdateRouteAnimation))
			})))
		end)
	end
end

function DungeonStageComp:doUpdateRouteAnimation()
	if not self._guidePause then
		self:dispatchCompEvent("DungeonStageComp_show_end", {
			stageId = self._nextStage
		})
	end

	self._nextStage = nil
end

function DungeonStageComp:updateMainRolePos(arg_32_1)
	local var_32_0 = self:getMonsterByStageID((var_0_5:getLastUnlockedStage(arg_32_1.id)))

	if var_32_0 then
		local var_32_1 = var_32_0:getPosition()

		self.m_roleComp:setPosition(var_32_1.x - 130 - var_32_0:getMonsterDeltaX(), var_32_1.y)
		self:checkMoving()
	end
end

function DungeonStageComp:updateRoleToStartPoint()
	if not self._stageRoute[1] then
		return
	end

	self.m_roleComp:setPosition(self._stageRoute[1][1].x, self._stageRoute[1][1].y)
end

function DungeonStageComp:setMainRoleVisible(arg_34_1)
	self.m_roleComp:setVisible(arg_34_1)
end

function DungeonStageComp:showMainRole(arg_35_1)
	self.m_roleComp:playAction("show", function()
		if arg_35_1 then
			arg_35_1()
		end
	end)
end

function DungeonStageComp:_onForceGuideEnd()
	self:_checkTickWeakGuide()
end

function DungeonStageComp:recheckWeakGuide()
	self:_checkTickWeakGuide()
end

function DungeonStageComp:_checkTickWeakGuide()
	if self._chapterId <= 4 then
		local var_39_0 = var_0_5:getLastUnlockedStage(self._chapterInfo.id)

		if not var_0_5:isStagePassed(var_39_0) then
			local var_39_1 = self:getMonsterByStageID(var_39_0)

			if var_39_1 then
				var_0_3:dispatchEvent(var_0_2.EVENT_TICK_WEAK_GUIDE_TICK, false, {
					key = "DUNGEON_STAGE_STAY",
					targetBtn = var_39_1
				})
			end
		end
	end
end

function DungeonStageComp:getMainRole()
	return self.m_roleComp
end

function DungeonStageComp:_initInteractInfo()
	self._interactFileId = self._chapterInfo.interaction_id

	local var_41_0 = g.core.model.User.dungeonData:getChapter(self._chapterInfo.id)

	if var_41_0 then
		self._interactCfg = var_41_0:getInteractCfgInfo(self._interactFileId)
	end
end

function DungeonStageComp:_createInteractComp()
	if not self._interactCfg then
		return
	end

	self._interactCompCache = {}

	for iter_42_0, iter_42_1 in ipairs(self._interactCfg) do
		local var_42_0 = fgui.UIPackage:createObject("dungeon", "DungeonCommonInteractComp", self)

		var_42_0:setPosition(iter_42_1.posInfo.pos.x, iter_42_1.posInfo.pos.y - (display.height - CC_DESIGN_RESOLUTION.height) / 2)
		var_42_0:updateComp(iter_42_1)
		self:addChild(var_42_0)
		table.insert(self._interactCompCache, var_42_0)
	end
end

function DungeonStageComp:hideStageCompToShowFullScene()
	self:setAllMonsterVisible(false)
	self:setAllStageChestVisible(false)
	self:setAllStageInteractVisible(false)
	self.m_roleComp:setVisible(false)
end

function DungeonStageComp:resumeStageCompFromFullScene()
	self:setAllMonsterVisible(true)
	self:setAllStageChestVisible(true)
	self:setAllStageInteractVisible(true)
	self.m_roleComp:setVisible(true)
end

function DungeonStageComp:getSpineStateName()
	return self.m_roleComp:getSpineAnimName()
end

function DungeonStageComp:setAllStageInteractVisible(arg_46_1)
	if self._interactCompCache and #self._interactCompCache > 0 then
		for iter_46_0, iter_46_1 in ipairs(self._interactCompCache) do
			iter_46_1:setVisible(arg_46_1)
		end
	end
end

function DungeonStageComp:receiveCompEvent(arg_47_1, arg_47_2)
	if arg_47_1 == "MainRoleMoving" then
		if self._movingSchedule == nil then
			self._movingSchedule = g.core.common.Scheduler:newSchedule(handler(self, self.checkMoving), 0.2)
		end
	elseif arg_47_1 == "MainRoleMove_stop" then
		if self._isClose then
			return
		end

		self:checkMoving()

		if self._movingSchedule ~= nil then
			g.core.common.Scheduler:cancelSchedule(self._movingSchedule)

			self._movingSchedule = nil
		end
	else
		self:dispatchCompEvent(arg_47_1, arg_47_2)
	end
end

function DungeonStageComp:setMoveCall(arg_48_1, arg_48_2)
	self._checkMovePos = arg_48_1
	self._scrollCompCall = arg_48_2

	if self._isEditor then
		for iter_48_0, iter_48_1 in pairs(arg_48_1) do
			local var_48_0 = fgui.UIPackage:createObject("dungeon", "DungeonAreaLinePoint1", self)

			self:addChild(var_48_0, 1)
			var_48_0:setSize(math.abs(iter_48_1.x1 - iter_48_1.x2), (math.abs(iter_48_1.y1 - iter_48_1.y2)))
			var_48_0:setVisible(true)
			var_48_0:setPosition(iter_48_1.x1, iter_48_1.y1)
		end
	end
end

function DungeonStageComp:setClickCall(arg_49_1)
	self._scrollCompClickCall = arg_49_1
end

function DungeonStageComp:setRoleHightLight(arg_50_1)
	self.m_roleComp:setHightLight(arg_50_1)
end

function DungeonStageComp:resetRoleHightLight()
	self.m_roleComp:setHightLight(false)

	local var_51_0 = self:getMainRolePos()

	for iter_51_0, iter_51_1 in pairs(self._checkMovePos) do
		if self._scrollCompCall ~= nil then
			if var_51_0.x > iter_51_1.x1 and var_51_0.x < iter_51_1.x2 and var_51_0.y > iter_51_1.y1 and var_51_0.y < iter_51_1.y2 then
				self:setRoleHightLight((self._scrollCompCall(iter_51_0, true)))

				self._effectState[iter_51_0] = true
			else
				self._scrollCompCall(iter_51_0, false)

				self._effectState[iter_51_0] = false
			end
		end
	end
end

function DungeonStageComp:checkMoving()
	local var_52_0 = self:getMainRolePos()

	for iter_52_0, iter_52_1 in pairs(self._checkMovePos) do
		if self._scrollCompCall ~= nil then
			if var_52_0.x > iter_52_1.x1 and var_52_0.x < iter_52_1.x2 and var_52_0.y > iter_52_1.y1 and var_52_0.y < iter_52_1.y2 then
				if self._effectState[iter_52_0] ~= true then
					self:setRoleHightLight((self._scrollCompCall(iter_52_0, true)))

					self._effectState[iter_52_0] = true
				end
			elseif self._effectState[iter_52_0] ~= false then
				self._scrollCompCall(iter_52_0, false)
				self:setRoleHightLight(false)

				self._effectState[iter_52_0] = false
			end
		end
	end
end

function DungeonStageComp:_onRcvBattleBegin(arg_53_1, arg_53_2, arg_53_3)
	if var_0_5:isCanAutoFightByStageId() then
		self.m_roleComp:playAction("attack")
		g.core.battle.BattleShowResult:disableAll()
		g.core.battle.BattleProxy:fastBattle(arg_53_3.battle_id)
	end
end

function DungeonStageComp:_onRcvBattleFinish(arg_54_1, arg_54_2, arg_54_3)
	if var_0_5:isCanAutoFightByStageId() then
		local var_54_0 = g.core.model.User.battleResultData:getDungeonResultData(arg_54_3)
		local var_54_1 = self:getChild("Comp_monster" .. var_0_5:getStageIndex(arg_54_3.id))

		if arg_54_3.is_win then
			var_54_1:showMonsterAction(var_0_7.ACTION.HIT)
			self:handlePostBattleAni()
			self:updateMonsterState(false)
			var_54_1:updatePreStar()
			self:dispatchCompEvent("end_auto_fight")
			var_54_1:showMonsterAction(var_0_7.LOOP_ACTION.FAILURE)
			self:newScheduleOnce(handler(self, function()
				g.core.module.ModuleManager:awardSummary(var_54_0.dropList or {})
			end), 1)
		else
			var_54_1:showMonsterAction(var_0_7.ACTION.HIT)
			var_54_1:showMonsterAction(var_0_7.LOOP_ACTION.IDLE)
			g.core.module.ModuleManager:tip(g.core.lang:get(112116))
			self:dispatchCompEvent("end_auto_fight")
		end
	end

	var_0_3:dispatchEvent(var_0_2.EVENT_GUIDE_CHECK, false, {
		tickType = 4,
		stageId = arg_54_3.id
	})
end

function DungeonStageComp:autoGoToNextMonster()
	local var_56_0 = var_0_5:getLastUnlockStageId()

	self:dispatchCompEvent("DungeonMonsterComp_SHOW_BATTLE_COMP", {
		pos = self:getChild("Comp_monster" .. var_0_5:getStageIndex(var_56_0)):getPosition(),
		monsterId = var_56_0
	})
end

function DungeonStageComp:_onKeypadClicked(arg_57_1, arg_57_2, arg_57_3, arg_57_4)
	if arg_57_4 == cc.KeyCode.KEY_SPACE then
		var_0_5:setDebugEditor(not self._isEditor)
	end
end

return DungeonStageComp
