local DungeonStageScrollComp = class("DungeonStageScrollComp")
local DungeonMapHelper = require("app.view.module.dungeon.utils.DungeonMapHelper")
local BGFactory = require("app.view.common.BGFactory")
local Route = require("app.core.common.Route")
local var_0_4 = g.core.const.ConstMgr.DungeonConst
local var_0_5 = g.core.const.ConstMgr.EasterEggConst
local var_0_6 = g.core.config.dungeon_chapter_info
local var_0_7 = g.core.config.dungeon_stinger_info
local var_0_8 = g.core.event.enum
local var_0_9 = g.core.event.EventManager
local var_0_10 = g.core.common.Path
local var_0_11 = g.core.model.User.dungeonData

DungeonStageScrollComp.ENTER_OFFSET = 0
DungeonStageScrollComp.INER_SENSITITY = 2
DungeonStageScrollComp.INER_ACCE = 5
DungeonStageScrollComp.HEAD_OFFESTY = 300
DungeonStageScrollComp.BORDER_OFFSETX = 80
DungeonStageScrollComp.BORDER_BACK = 100

function DungeonStageScrollComp:ctor()
	self._curTouchX = 0
	self._offsetX = 0
	self._curStage = 1
	self._chapterId = 0
	self._chapterInfo = nil
	self._path = {}
	self._cameraRoute = {}
	self._canTouchMove = true
	self._isFirstEnter = false
	self._isUpdate = false
	self._isChapterPass = false
	self._inerSchedule = nil
	self._inerSpeed = 0
	self._mapComp = nil
	self._borderScheduler = nil
	self._isBorderLeft = false
	self._isBorderRight = false
	self._eggCompList = {}
	self._stageComp = fgui.UIPackage:createObject("dungeon", "DungeonStageComp")

	self._stageComp:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	var_0_11:resetNewStageId()
end

function DungeonStageScrollComp:recheckWeakGuide()
	self._stageComp:recheckWeakGuide()
end

function DungeonStageScrollComp:initChapterId(arg_3_1)
	self._chapterId = arg_3_1
	self._chapterInfo = var_0_6.get(arg_3_1)
	self._mapId = self._chapterInfo.stage_map
	self._routeId = self._chapterInfo.ctrl_id

	if g.core.utils.Quality.needUseStaticMap() then
		self._mapId = self._mapId .. "0001"
		self._routeId = self._routeId .. "0001"
	end

	self._cameraRoute = DungeonMapHelper:getCameraRouteByMapId(self._mapId)

	self._stageComp:initChapterId(arg_3_1)

	self._mapSize = BGFactory.getMapSize({
		bgPath = "parallax/dungeon_stage/" .. self._mapId .. "/dungeon_stage.pcfg"
	})

	self:_checkCurOpenStageMoveRange()
end

function DungeonStageScrollComp:onLoad()
	var_0_9:addEventListener(var_0_8.EVENT_MODULE_EXIT, handler(self, self._onModuleExit), self)
	var_0_9:addEventListener(var_0_8.EVENT_CLOUD_END, handler(self, self._cloundEndEvent), self)
end

function DungeonStageScrollComp:_cloundEndEvent()
	if self._isFirstEnter then
		self:newScheduleOnce(handler(self, function()
			self:handleFirstEnter()

			self._isFirstEnter = false
		end), 0)
	end
end

function DungeonStageScrollComp:_checkCurOpenStageMoveRange()
	local var_7_0 = var_0_11:getOpenUnlockStageId()

	if self._chapterId == var_0_11:getLastUnlockChapter() and var_7_0 > 0 then
		local var_7_1 = json.decodeFile((var_0_10:getDungeonMonsterPos(self._mapId, self._routeId)))

		for iter_7_0 = 1, #var_7_1 do
			if var_7_1[iter_7_0].isMonster then
				if self._chapterInfo["stage_" .. var_7_1[iter_7_0].index] > 0 and self._chapterInfo["stage_" .. var_7_1[iter_7_0].index] == var_7_0 and var_7_1[iter_7_0].pos.x > 0 then
					self._mapSize.width = var_7_1[iter_7_0].pos.x + var_0_4.OPEN_STAGE_OFFESTX
				end
			end
		end
	else
		self._mapSize = BGFactory.getMapSize({
			bgPath = "parallax/dungeon_stage/" .. self._mapId .. "/dungeon_stage.pcfg"
		})
	end
end

function DungeonStageScrollComp:_onModuleExit(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_3 and arg_8_3.params

	if not (arg_8_3 and arg_8_3.params) then
		return
	end

	if var_8_0 and var_8_0.tag and (var_8_0 and var_8_0.tag) == "openEffect" then
		self._stageComp:updateRoleToStartPoint()
		self:dispatchCompEvent("first_finish")
	end
end

function DungeonStageScrollComp:onUnload()
	if self._waitState then
		self._waitState = false

		var_0_9:dispatchEvent(var_0_8.EVENT_GUIDE_READY)
	end

	if self._mapComp then
		self._mapComp:stopActions()
	end

	self:stopAllFGActions()

	if self._inerSchedule then
		self:cancelSchedule(self._inerSchedule)
	end

	if self._borderScheduler then
		self:cancelSchedule(self._borderScheduler)
	end
end

function DungeonStageScrollComp:update()
	self._isChapterPass = var_0_11:isChapterPassed(self._chapterId)

	self:_checkCurOpenStageMoveRange()
end

function DungeonStageScrollComp:handlePostBattleAni()
	self._stageComp:handlePostBattleAni()
end

function DungeonStageScrollComp:updateScrollState(arg_12_1, arg_12_2)
	self._isFirstEnter = arg_12_2

	if self._isFirstEnter then
		self:_jumpToDefaultPos(self._chapterInfo)
	else
		local var_12_0 = var_0_11:getNewStageId()

		if arg_12_1 > 0 then
			self:_jumpToStage(arg_12_1)
		elseif var_12_0 <= 0 and not self._isUpdate then
			self:_jumpToDefaultPos(self._chapterInfo)
		else
			self:_createMapComp(0)
		end

		self._isUpdate = true
	end

	self:addTouchListener()
	self._stageComp:update(self._chapterInfo, self._isFirstEnter, self._mapComp, self._isChapterPass)
	var_0_11:resetNewStageId()
end

function DungeonStageScrollComp:_createMapComp(arg_13_1)
	if not self._mapComp then
		self._mapComp = BGFactory.create({
			bgPath = "parallax/dungeon_stage/" .. self._mapId .. "/dungeon_stage.pcfg",
			parent = self,
			stage = self._stageComp,
			initPosX = arg_13_1
		})
		self._yOffset = self._mapComp:getYOffset()

		self:_initMapEasterEgg()
	end

	self._mapComp:stopActions()
end

function DungeonStageScrollComp:handleFirstEnter()
	local var_14_0 = require("app.view.module.dungeon.view.DungeonEffectPop").new()

	self:addPopup(var_14_0, {
		tag = "openEffect",
		hideContinue = true,
		touchDisappear = true
	})
	var_14_0:update({
		name = "open",
		chapterId = self._chapterInfo.id
	})
	self:dispatchCompEvent("HIDE_TOP_DOWN_COMP")
end

function DungeonStageScrollComp:addTouchListener()
	if not self._stageComp:hasEventListener(fgui.UIEventType.TouchMove) then
		self._stageComp:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	end

	if not self._stageComp:hasEventListener(fgui.UIEventType.TouchEnd) then
		self._stageComp:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	end
end

function DungeonStageScrollComp:removeTouchListener()
	if self._stageComp:hasEventListener(fgui.UIEventType.TouchMove) then
		self._stageComp:removeEventListener(fgui.UIEventType.TouchMove)
	end

	if self._stageComp:hasEventListener(fgui.UIEventType.TouchEnd) then
		self._stageComp:removeEventListener(fgui.UIEventType.TouchEnd)
	end
end

function DungeonStageScrollComp:_jumpToDefaultPos(arg_17_1)
	local var_17_0 = math.min(display.width / 2 - self:_getStageMonsterPosX((var_0_11:getLastUnlockedStage(arg_17_1.id))), 0)

	self:_moveToStagePos(var_17_0, (DungeonMapHelper:getRouthY(display.width / 2 - var_17_0, self._mapSize, arg_17_1.stage_map)))
end

function DungeonStageScrollComp:_jumpToStage(arg_18_1)
	if arg_18_1 < 0 then
		return
	end

	local var_18_0 = math.min(display.width / 2 - self:_getStageMonsterPosX(arg_18_1), 0)

	self:_moveToStagePos(var_18_0, DungeonMapHelper:getRouthY(display.width / 2 - var_18_0, self._mapSize, self._mapId), false)
end

function DungeonStageScrollComp:_getStageMonsterPosX(arg_19_1)
	local var_19_0 = json.decodeFile((var_0_10:getDungeonMonsterPos(self._mapId, self._routeId)))
	local var_19_1 = 0

	for iter_19_0 = 1, #var_19_0 do
		if var_19_0[iter_19_0].isMonster then
			if self._chapterInfo["stage_" .. var_19_0[iter_19_0].index] > 0 and self._chapterInfo["stage_" .. var_19_0[iter_19_0].index] == arg_19_1 and var_19_0[iter_19_0].pos.x > 0 then
				var_19_1 = var_19_0[iter_19_0].pos.x
			end
		end
	end

	return var_19_1
end

function DungeonStageScrollComp:_moveToStagePos(arg_20_1, arg_20_2, arg_20_3)
	if arg_20_3 then
		arg_20_1 = arg_20_1 - 200
		arg_20_1 = math.max(arg_20_1, display.width - self._mapSize.width)
	end

	if arg_20_1 + DungeonStageScrollComp.ENTER_OFFSET < 0 then
		self:setTouchable(false)
		var_0_9:dispatchEvent(var_0_8.EVENT_GUIDE_WAIT)

		self._waitState = true

		self:_createMapComp(arg_20_1 + DungeonStageScrollComp.ENTER_OFFSET)
		self._mapComp:setPosition(arg_20_1 + DungeonStageScrollComp.ENTER_OFFSET, arg_20_2)
		self._mapComp:runAction({
			action = fgui.FSequence:create({
				fgui.FMoveBy:create(0.5, cc.p(-DungeonStageScrollComp.ENTER_OFFSET, 0)),
				fgui.FCallFunc:create(handler(self, self._onMoveByEnterOffset))
			}),
			fAction = fgui.FParallaxMoveBy:create(0.5, cc.p(-DungeonStageScrollComp.ENTER_OFFSET, 0))
		})
	else
		self:_createMapComp(arg_20_1)
		self._mapComp:setPosition(arg_20_1, arg_20_2)
	end
end

function DungeonStageScrollComp:moveToMonsterPos(arg_21_1, arg_21_2, arg_21_3)
	arg_21_2 = arg_21_2 or 2

	self:setStageTouchable(false)

	local var_21_0 = {
		x = math.max(math.min(0, math.max(display.width / 2 - arg_21_1.x, display.width / 2 - self._mapSize.width)), display.width - self._mapSize.width),
		y = DungeonMapHelper:getRouthY(arg_21_1.x, self._mapSize, self._mapId)
	}

	self._cameraRoute = DungeonMapHelper:getCameraRouteByMapId(self._mapId)

	local var_21_1 = DungeonMapHelper:getRouteToMainRole({
		x = self._stageComp:getX(),
		y = self._stageComp:getY()
	}, var_21_0, self._cameraRoute)

	Route.new(self._stageComp, var_21_1):moveTo({
		point = var_21_0,
		speed = arg_21_2,
		finishFunc = handler(self, function()
			self:setStageTouchable(true)

			if arg_21_3 then
				arg_21_3()
			end
		end)
	})
	Route.new(self._mapComp:getBackground(), var_21_1):moveParallaxNode({
		point = var_21_0,
		speed = arg_21_2,
		yOffset = self._yOffset
	})
	Route.new(self._mapComp:getForeground(), var_21_1):moveParallaxNode({
		point = var_21_0,
		speed = arg_21_2,
		yOffset = self._yOffset
	})
end

function DungeonStageScrollComp:_onMoveByEnterOffset()
	self:setTouchable(true)

	self._waitState = false

	g.core.common.Scheduler:newScheduleOnce(function()
		var_0_9:dispatchEvent(var_0_8.EVENT_GUIDE_READY)
	end, 0.1)
end

function DungeonStageScrollComp:_onTouchBegin(arg_25_1)
	if self._canTouchMove then
		arg_25_1:captureTouch()
	end

	local var_25_0 = arg_25_1:getInput():getPosition()

	self._offsetX = 0
	self._curTouchX = var_25_0.x
	self._startX = var_25_0.x
	self._isBorderLeft = false
	self._isBorderRight = false
end

function DungeonStageScrollComp:_onTouchMove(arg_26_1)
	local var_26_0 = arg_26_1:getInput():getPosition()
	local var_26_1 = var_26_0.x - self._curTouchX or 0

	self:_moveMap(var_26_1)

	self._curTouchX = var_26_0.x
	self._offsetX = var_26_1
end

function DungeonStageScrollComp:_moveMap(arg_27_1)
	local var_27_0 = arg_27_1 > 0
	local var_27_1 = self._stageComp:getX()

	if arg_27_1 > 0 and var_27_1 >= 0 or not var_27_0 and var_27_1 + self._mapSize.width - var_0_4.SCAN_FULL_SCENE_OFFSET_X <= display.width then
		return false
	end

	local var_27_2 = var_27_1 + arg_27_1

	self._mapComp:setDragRangeX(display.width - self._mapSize.width, 0)
	self._mapComp:setPosition(var_27_2, (DungeonMapHelper:getRouthY(display.width / 2 - var_27_1, self._mapSize, self._mapId)))

	return true
end

function DungeonStageScrollComp:_moveDisParkMap(arg_28_1)
	local var_28_0 = arg_28_1 > 0
	local var_28_1 = self._stageComp:getX()

	if arg_28_1 > 0 and var_28_1 + DungeonStageScrollComp.BORDER_OFFSETX >= 0 or not var_28_0 and var_28_1 + self._mapSize.width - var_0_4.SCAN_FULL_SCENE_OFFSET_X - DungeonStageScrollComp.BORDER_OFFSETX <= display.width then
		return false
	end

	local var_28_2 = var_28_1 + arg_28_1

	self._mapComp:setDragRangeX(display.width - self._mapSize.width + DungeonStageScrollComp.BORDER_OFFSETX, -DungeonStageScrollComp.BORDER_OFFSETX)
	self._mapComp:setPosition(var_28_2, (DungeonMapHelper:getRouthY(display.width / 2 - var_28_1, self._mapSize, self._mapId)))

	return true
end

function DungeonStageScrollComp:_onTouchEnd(arg_29_1)
	self:cancelAllSchedule()

	local var_29_0 = self._offsetX / math.abs(self._offsetX)

	self._borderScheduler = self:newSchedule(function()
		self:_onBorderAction()
	end, 0)
	self._inerSpeed = math.abs(self._offsetX * DungeonStageScrollComp.INER_SENSITITY)

	if self._inerSpeed < 20 then
		return
	end

	self._inerSchedule = self:newSchedule(function(arg_31_0, arg_31_1, arg_31_2)
		self._inerSpeed = math.max(0, self._inerSpeed - DungeonStageScrollComp.INER_ACCE)

		if not self:_moveDisParkMap(self._inerSpeed * var_29_0) or self._inerSpeed == 0 then
			self:cancelAllSchedule()
		end
	end, 0)
end

function DungeonStageScrollComp:_onBorderAction()
	local var_32_0 = self._stageComp:getX()
	local var_32_1 = var_32_0 + self._mapSize.width

	self._isBorderLeft = checkbool(var_32_0 + DungeonStageScrollComp.BORDER_OFFSETX >= 0)
	self._isBorderRight = checkbool(var_32_1 - DungeonStageScrollComp.BORDER_OFFSETX <= display.width)

	if self._isBorderLeft then
		self._mapComp:runAction({
			action = fgui.FMoveBy:create(0.3, cc.p(DungeonStageScrollComp.BORDER_BACK * -1, 0)),
			fAction = fgui.FParallaxMoveBy:create(0.3, cc.p(DungeonStageScrollComp.BORDER_BACK * -1, 0))
		})
	elseif self._isBorderRight then
		self._mapComp:runAction({
			action = fgui.FMoveBy:create(0.3, cc.p(DungeonStageScrollComp.BORDER_BACK, 0)),
			fAction = fgui.FParallaxMoveBy:create(0.3, cc.p(DungeonStageScrollComp.BORDER_BACK, 0))
		})
	end

	self:cancelSchedule(self._borderScheduler)

	self._isBorderLeft = false
	self._isBorderRight = false
end

function DungeonStageScrollComp:getStageComp()
	return self._stageComp
end

function DungeonStageScrollComp:setStageTouchable(arg_34_1)
	self._stageComp:setTouchable(arg_34_1)
end

function DungeonStageScrollComp:setMainRoleVisible(arg_35_1)
	if self._stageComp and self._stageComp.setMainRoleVisible then
		self._stageComp:setMainRoleVisible(arg_35_1)
	end
end

function DungeonStageScrollComp:getMainRolePos()
	return self._stageComp:getMainRolePos()
end

function DungeonStageScrollComp:onMoveTargetPos(arg_37_1, arg_37_2)
	self._stageComp:onMoveTargetPos(arg_37_1, arg_37_2)
end

function DungeonStageScrollComp:updateMonsterState(arg_38_1)
	self._stageComp:updateStage(not arg_38_1)
end

function DungeonStageScrollComp:battleEndUpdate(arg_39_1)
	self._stageComp:battleEndUpdate(not arg_39_1)
end

function DungeonStageScrollComp:getMonsterByStageID(arg_40_1)
	return (self._stageComp:getMonsterByStageID(arg_40_1))
end

function DungeonStageScrollComp:_initMapEasterEgg()
	if self._mapComp then
		local var_41_0 = self._mapComp:getBackground()
		local var_41_1 = self._mapComp:getForeground()
		local var_41_2 = {}

		for iter_41_0, iter_41_1 in ipairs((var_0_7.match(function(arg_42_0)
			return arg_42_0.interaction_id == self._chapterInfo.interaction_id
		end))) do
			local var_41_3 = var_41_0:getChild("DungeonEasterEggComp" .. iter_41_1.id)

			if var_41_3 == nil then
				var_41_3 = var_41_1:getChild("DungeonEasterEggComp" .. iter_41_1.id)
			end

			if var_41_3 then
				var_41_3:bindLua("app.view.module.dungeon.view.stage.DungeonEasterEggComp")
				var_41_3:setData(iter_41_1.id, iter_41_1 and iter_41_1.toObject())

				self._eggCompList[iter_41_1.id] = var_41_3

				if iter_41_1 and iter_41_1.type == var_0_5.EGG_TYPE.MOVE_POS_TYPE then
					var_41_2[iter_41_1.id] = {
						x1 = iter_41_1.x1,
						y1 = iter_41_1.y1 - (display.cy - 375),
						x2 = iter_41_1.x2,
						y2 = iter_41_1.y2 - (display.cy - 375)
					}
				end
			end
		end

		self._stageComp:setMoveCall(var_41_2, handler(self, self.updateEasterEgg))
		self._stageComp:setClickCall(handler(self, self.checkIsClickEggComp))
	end
end

function DungeonStageScrollComp:updateEasterEgg(arg_43_1, arg_43_2)
	if self._eggCompList[arg_43_1] then
		if arg_43_2 then
			return (self._eggCompList[arg_43_1]:setHightLight())
		else
			self._eggCompList[arg_43_1]:resetNormal()
		end
	end
end

function DungeonStageScrollComp:checkIsClickEggComp(arg_44_1, arg_44_2)
	local var_44_0 = false

	for iter_44_0, iter_44_1 in pairs(self._eggCompList) do
		if iter_44_1:checkIsClick(arg_44_1, arg_44_2) then
			var_44_0 = true
		end
	end

	return var_44_0
end

function DungeonStageScrollComp:doAutoAction()
	return self._stageComp:doAutoAction()
end

function DungeonStageScrollComp:getSpineStateName()
	return self._stageComp:getSpineStateName()
end

return DungeonStageScrollComp
