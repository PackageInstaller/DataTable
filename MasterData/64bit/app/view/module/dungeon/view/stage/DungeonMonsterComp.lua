local DungeonMonsterComp = class("DungeonMonsterComp", require("app.fairyGUI.dungeon.UI_DungeonMonsterComp"))
local var_0_1 = g.core.config.dungeon_stage_info
local var_0_2 = g.core.const.ConstMgr.DungeonConst
local var_0_3 = g.core.config.dungeon_chapter_info
local var_0_4 = g.core.const.ConstMgr.SpineConst
local var_0_5 = g.core.model.User.dungeonData
local CommonKnight = require("app.view.common.CommonKnight")
local var_0_7 = g.core.event.EventManager
local var_0_8 = g.core.event.enum
local var_0_9 = g.core.module.ModuleManager

function DungeonMonsterComp:ctor()
	self._knight = nil
	self._fightTipsComp = nil
	self._originalPos = {}
	self._preStar = 0
	self._curStar = 0
	self._isFirstEnter = true
	self._isStarAni = false
	self._isBoss = false
	self._distVert = 0
	self._distHoriz = 0
	self._deltaX = 0
	self._isUnlock = false
	self.compMovePos = self.m_moveComp:getPosition()
end

function DungeonMonsterComp:_addWeakGuideComp()
	fgui.UIPackage:addPackage("ui/guide/guide")

	local var_2_0 = fgui.UIPackage:createObject("guide", "GuideTouchComp")

	var_2_0:setTouchable(false)
	var_2_0:updateView()
	var_2_0:setPosition(50, 0)
	self.m_guideHolderComp:addChild(var_2_0)
end

function DungeonMonsterComp:onLoad()
	self.m_bubComp:setVisible(false)

	self._isFirstEnter = false
end

function DungeonMonsterComp:checkStarAnimation()
	if not self._isFirstEnter then
		self._curStar = var_0_5:getStageStar(self._monsterId)

		if self._preStar < self._curStar then
			self._isStarAni = true

			self:playStarAnimation()
		else
			self._isStarAni = false
		end
	end
end

function DungeonMonsterComp:update(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self._isBoss = arg_5_4
	self._monsterId = arg_5_1.id

	local var_5_0 = var_0_1.get(self._monsterId)
	local var_5_1 = var_0_5:getStage(self._monsterId)

	self._distHoriz = var_5_0.range_x
	self._distVert = var_5_0.range_y

	local var_5_2 = var_5_0.quality

	self._isUnlock = arg_5_2

	local var_5_3 = self.m_moveComp:getChild("nameComp")
	local var_5_4 = self.m_moveComp:getChild("nameBgImg")
	local var_5_5 = var_0_5:getDisplayVersion()
	local var_5_6, var_5_7

	if var_5_5 == 1 then
		var_5_6 = arg_5_1.name or arg_5_1["name_" .. var_5_5]

		if var_5_5 == 1 then
			var_5_7 = arg_5_1.res or arg_5_1["res_" .. var_5_5]
		end
	end

	var_5_3:setText(var_5_6)

	if var_5_2 > 0 then
		var_5_4:setURL(var_0_2.MONSTER_ICON_PATH .. var_5_2)

		if var_5_1 and var_5_1:isPassed() then
			var_5_4:setURL(var_0_2.MONSTER_ICON_PATH .. var_5_2 .. "_gray")
		end
	end

	var_5_3:setVisible(arg_5_2)
	var_5_4:setVisible(arg_5_2)
	self.m_bubComp:setTitle(arg_5_1.talk)

	if not self._knight then
		self._knight = CommonKnight.new({
			resId = var_5_7,
			callback = handler(self, self._onClick)
		})

		self._knight:setScaleX(-1)
		self.m_moveComp:getChild("knightComp"):addChildWithListen(self._knight)
	else
		self._knight:_updateRes({
			resId = arg_5_1.res,
			callback = handler(self, self._onClick)
		})
	end

	local var_5_8 = {
		offPosX = var_5_0.model_X_location,
		offPosY = var_5_0.model_Y_location
	}

	if var_5_0.model_zoom > 0 then
		var_5_8.scale = var_5_0.model_zoom / 1000

		if var_5_0.model_width > 0 then
			var_5_8.touchWidth = var_5_0.model_width or 95
		end

		self._deltaX = math.max(0, (var_5_8.touchWidth - 100) / 2)
	end

	self._knight:updatePosData(var_5_8)

	self._originalPos = self.m_moveComp:getPosition()
	self._curStar = var_0_5:getStageStar(self._monsterId)

	self.m_starGroup:setVisible(false)

	if not arg_5_2 and arg_5_3 then
		if not self._isBoss then
			self:_beginMove()
		end
	else
		self:_setDefaultPosAndToward()

		if arg_5_2 and self._curStar == 0 and not self._fightTipsComp then
			self.m_moveComp:stopAllFGActions()
			self.m_moveComp:setPosition({
				x = self.compMovePos.x,
				y = self.compMovePos.y
			})
			self:_playBossAction()

			self._fightTipsComp = fgui.UIPackage:createObject("base", "BaseFightTipsComp")

			self:addChild(self._fightTipsComp)
			self._fightTipsComp:setPosition(self:getWidth() / 2 - 35, self:getHeight() - 245)
		elseif self._curStar > 0 and self._fightTipsComp then
			self.m_bubComp:stopAllFGActions()
			self.m_bubComp:setVisible(false)
			self.m_moveComp:stopAllFGActions()
			self.m_starGroup:setVisible(true)
			self.m_guideHolderComp:removeChildren()
			self._fightTipsComp:removeSelf()

			self._fightTipsComp = nil

			self:updateStar()
			self._knight:playAction(var_0_4.LOOP_ACTION.FAILURE)
		elseif self._curStar > 0 and not self._fightTipsComp then
			self.m_moveComp:stopAllFGActions()
			self.m_starGroup:setVisible(true)
			self:updateStar()
			self._knight:playAction(var_0_4.LOOP_ACTION.FAILURE)
		end
	end
end

function DungeonMonsterComp:doAutoAction()
	if self._isUnlock and self._curStar == 0 then
		self:_onClick()

		return true
	end
end

function DungeonMonsterComp:updateStar()
	local var_7_0

	if self._isStarAni then
		var_7_0 = self._preStar or self._curStar
	end

	for iter_7_0 = 1, var_0_2.STAR_MAX do
		local var_7_1 = self["m_starImg" .. iter_7_0]
		local var_7_2

		if iter_7_0 <= var_7_0 then
			var_7_2 = var_0_2.STAR_PATH_LIGHT or var_0_2.STAR_PATH_GRAY
		end

		var_7_1:setAlpha(iter_7_0 <= var_7_0 and 1 or 0.5)
		var_7_1:setURL(var_7_2)
	end

	self._isStarAni = false
end

function DungeonMonsterComp:playStarAnimation()
	local var_8_0 = self._preStar
	local var_8_1 = var_0_5:getStageStar(self._monsterId)
	local var_8_2 = self._isBoss
	local var_8_3 = self.m_moveComp
	local var_8_4 = 0.1
	local var_8_5 = var_0_3.get(var_0_1.get(self._monsterId).chapter_id)

	self:showPreStar(self._preStar)

	for iter_8_0 = self._preStar + 1, var_8_1 do
		local var_8_6 = self["m_starImg" .. iter_8_0]
		local var_8_7 = self["m_starEffect" .. iter_8_0]
		local var_8_8 = self["m_star" .. iter_8_0 .. "Transition"]

		if var_8_4 > 0 then
			var_0_7:dispatchEvent(var_0_8.EVENT_GUIDE_WAIT)
			g.core.common.Scheduler:newScheduleOnce(function()
				var_0_7:dispatchEvent(var_0_8.EVENT_GUIDE_READY)
			end, var_8_4 + 0.5)
			self["m_starImg" .. iter_8_0]:runFGAction((fgui.FSequence:create({
				fgui.FDelayTime:create(var_8_4),
				fgui.FCallFunc:create(function()
					var_8_8:play(handler(self, function(arg_11_0)
						var_8_6:setURL(var_0_2.STAR_PATH_LIGHT)
						var_8_6:setVisible(true)
						var_8_7:addEffectSpine({
							isLoop = false,
							scale = 0.5,
							name = "eff_ui_common_qiaoxing"
						})

						if iter_8_0 == var_8_1 then
							arg_11_0._preStar = arg_11_0._curStar
							arg_11_0._isStarAni = false

							if var_8_2 and var_8_0 == 0 then
								if var_8_5.scroll_num > 0 then
									arg_11_0.m_starGroup:setVisible(false)
									var_8_3:getChild("nameComp"):setVisible(false)

									if var_0_3.indexOf(1).id == var_8_5.id then
										arg_11_0:stopAllFGActions()
										arg_11_0:runFGAction(fgui.FSequence:create({
											fgui.FDelayTime:create(3),
											fgui.FCallFunc:create(handler(arg_11_0, function()
												arg_11_0.m_starGroup:setVisible(true)
												var_8_3:getChild("nameComp"):setVisible(true)
											end))
										}))
									end
								end

								arg_11_0:dispatchCompEvent("chapter_finish", {
									pos = arg_11_0:getPosition()
								})
							end
						end
					end))
				end)
			})))
		else
			self["m_star" .. iter_8_0 .. "Transition"]:play()
		end

		var_8_4 = var_8_4 + 0.3
	end
end

function DungeonMonsterComp:showPreStar()
	for iter_13_0 = 1, 3 do
		if iter_13_0 <= self._preStar then
			self["m_starImg" .. iter_13_0]:setURL(var_0_2.STAR_PATH_LIGHT)
			self["m_starImg" .. iter_13_0]:setAlpha(1)
		else
			self["m_starImg" .. iter_13_0]:setURL(var_0_2.STAR_PATH_GRAY)
			self["m_starImg" .. iter_13_0]:setAlpha(0.5)
		end
	end
end

function DungeonMonsterComp:showMonsterAction(arg_14_1, arg_14_2)
	local var_14_0 = arg_14_2

	if self._isBoss and arg_14_1 == var_0_4.ACTION.SHOW then
		self._knight:playSound()

		var_14_0 = handler(self, function()
			self._knight:playAction(var_0_4.LOOP_ACTION.IDLE)
		end)
	end

	self._knight:playAction(arg_14_1, var_14_0)
end

function DungeonMonsterComp:_setDefaultPosAndToward()
	self._knight:setScaleX(-1)
	self.m_moveComp:setPosition(self._originalPos.x, self._originalPos.y)
	self:showMonsterAction(var_0_4.LOOP_ACTION.IDLE)
end

function DungeonMonsterComp:_beginMove()
	self.m_moveComp:stopAllFGActions()

	local var_17_0 = self.m_moveComp:getX()
	local var_17_1 = self.m_moveComp:getY()
	local var_17_2, var_17_3 = self:_generateRandomX()

	self._knight:setScaleX(var_17_0 < var_17_2 and 1 or -1)
	self._knight:playAction(var_0_4.LOOP_ACTION.RUN)

	local var_17_4 = {}

	table.insert(var_17_4, (fgui.FMoveTo:create(math.max(math.abs(var_17_2 - var_17_0) / var_0_2.MOVE_SPEED, math.abs(var_17_3 - var_17_1) / var_0_2.MOVE_SPEED), {
		x = var_17_2,
		y = var_17_3
	})))
	table.insert(var_17_4, (fgui.FCallFunc:create(handler(self, function()
		self:showMonsterAction(var_0_4.LOOP_ACTION.IDLE)
	end))))
	table.insert(var_17_4, (fgui.FDelayTime:create(math.random(var_0_2.STAY_TIME_MIN, var_0_2.STAY_TIME_MAX) / 1000)))
	table.insert(var_17_4, (fgui.FCallFunc:create(handler(self, self._beginMove))))
	self.m_moveComp:runFGAction((fgui.FSequence:create(var_17_4)))
end

function DungeonMonsterComp:_playBossAction()
	self.m_moveComp:stopAllFGActions()
	self.m_moveComp:runFGAction((fgui.FRepeatForever:create((fgui.FSequence:create({
		fgui.FCallFunc:create(handler(self, function()
			self._knight:playAction(var_0_4.ACTION.SHOW, handler(self, function()
				self._knight:playAction(var_0_4.LOOP_ACTION.IDLE)
			end))
		end)),
		fgui.FDelayTime:create(4)
	})))))
end

function DungeonMonsterComp:_generateRandomX()
	local var_22_0 = self._originalPos.x - self._distHoriz
	local var_22_1 = self._originalPos.y - self._distVert
	local var_22_2, var_22_3

	if self._originalPos.x - self._distHoriz < 0 then
		var_22_2 = -var_22_0 or 0

		if var_22_1 < 0 then
			var_22_3 = -var_22_1 or 0
		end
	end

	return math.random(var_22_0 + var_22_2, self._originalPos.x + self._distHoriz + var_22_2) - var_22_2, math.random(var_22_1 + var_22_3, self._originalPos.y + self._distVert + var_22_3) - var_22_3
end

function DungeonMonsterComp:showBubble()
	self.m_effectComp:setVisible(false)
	self.m_bubComp:stopAllFGActions()
	self.m_bubComp:setScale(0, 0)
	self.m_bubComp:runFGAction((fgui.FSequence:create({
		fgui.FShow:create(),
		fgui.FEaseBounceOut:create(fgui.FScaleTo:create(0.5, 1)),
		fgui.FDelayTime:create(3),
		fgui.FScaleTo:create(0.25, 0)
	})))
end

function DungeonMonsterComp:_playTalkBubCycle()
	self.m_bubComp:stopAllFGActions()
	self.m_bubComp:setVisible(true)
	self.m_bubComp:runFGAction(fgui.FRepeatForever:create((fgui.FSequence:create({
		fgui.FEaseBounceOut:create(fgui.FScaleTo:create(0.5, 1)),
		fgui.FDelayTime:create(3),
		fgui.FScaleTo:create(0.25, 0),
		fgui.FDelayTime:create(2)
	}))))
end

function DungeonMonsterComp:updatePreStar()
	self._preStar = var_0_5:getStageStar(self._monsterId)
end

function DungeonMonsterComp:_onClick()
	if not self._isUnlock then
		var_0_9:tip(g.core.lang:get(300016))

		return
	end

	self:dispatchCompEvent("DungeonMonsterComp_SHOW_BATTLE_COMP", {
		pos = self:getPosition(),
		monsterId = self._monsterId,
		deltaX = self._deltaX
	})
	self._knight:playSound()
end

function DungeonMonsterComp:setMonsterEffectVisble(arg_27_1)
	self:setVisible(arg_27_1)
end

function DungeonMonsterComp:getMonsterDeltaX()
	return self._deltaX
end

return DungeonMonsterComp
