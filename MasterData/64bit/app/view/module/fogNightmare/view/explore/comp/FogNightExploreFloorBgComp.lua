local FogNightExploreFloorBgComp = class("FogNightExploreFloorBgComp", require("app.fairyGUI.fogNightmare.UI_FogNightExploreFloorBgComp"))

function FogNightExploreFloorBgComp:ctor()
	self._floorStruct = nil
	self._stageItemPool = {}
	self._stages = {}
	self._spine = nil
	self._spineName = nil
	self._animName = nil
	self._selectIdx = 0
	self._isFirst = true

	self:_initView()
end

function FogNightExploreFloorBgComp:_initView()
	self.m_leftButton:addClickListener(handler(self, self._onLeftBtnClick))
	self.m_midButton:addClickListener(handler(self, self._onMidBtnClick))
	self.m_rightButton:addClickListener(handler(self, self._onRightBtnClick))
	self:_createStageItems()
end

function FogNightExploreFloorBgComp:_updateSpine(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 == self._spineName then
		return
	end

	self._animName = arg_3_2
	self._spineName = arg_3_1

	self:_popAllItem()
	self:_clearSpine()

	self._spine = self.m_effectBgNode:addEffectSpine({
		scale = 1.1,
		remove = false,
		name = arg_3_1,
		isLoop = arg_3_3 == true,
		anim = arg_3_2,
		eventHandler = handler(self, self._onSpineEventHandle)
	})
	self._slotNameMap = {}

	for iter_3_0, iter_3_1 in ipairs((self._spine:getSlotNames())) do
		self._slotNameMap[iter_3_1] = true
	end
end

function FogNightExploreFloorBgComp:_updateTempBgSpine(arg_4_1, arg_4_2, arg_4_3)
	self._tempSpine = self.m_effectTempBgNode:addEffectSpine({
		isLoop = false,
		remove = true,
		name = arg_4_1,
		anim = arg_4_2,
		eventHandler = handler(self, self._onTempSpineEventHandle)
	})
end

function FogNightExploreFloorBgComp:_onTempSpineEventHandle(arg_5_1, arg_5_2)
	if require("app.view.battle.const.BattleConst").SPINE_EVENT.COMPLETE == arg_5_1.type then
		self.m_effectTempBgNode:setVisible(false)
	end
end

function FogNightExploreFloorBgComp:_clearSpine()
	if self._spine then
		self._spine:dispose()
	end

	self._spine = nil
end

function FogNightExploreFloorBgComp:_onSpineEventHandle(arg_7_1, arg_7_2)
	if arg_7_1.type == "event" then
		local var_7_0 = arg_7_1.eventData or {}

		if var_7_0.name == "enter" and string.find(self._animName, "in") then
			self:_onMoveInEnd()
		elseif var_7_0.name == "uishow" then
			if self._animName == "next2" then
				self:_onPlayNextSpineEnter()
			elseif self._animName == "uishow" then
				self:_onFastEnterPlayEnd()
			elseif self._animName == "idle1" then
				self:_onStageUIShowEnd()
			end
		end
	end

	if require("app.view.battle.const.BattleConst").SPINE_EVENT.COMPLETE == arg_7_1.type and self._animName then
		if self._animName == "in1" then
			self:_setAnimation("in1idle")
		elseif self._animName == "in2" then
			self:_setAnimation("in2idle")
		elseif self._animName == "idle1" or self._animName == "idle0" then
			self:showButton()
			self:_setAnimation("idle2", true)
		elseif self._animName == "idle2" then
			-- block empty
		elseif self._animName == "uishow" then
			-- block empty
		elseif self._animName == "next2" then
			-- block empty
		elseif self._animName == "play" then
			self:_onEnterFloorActionEnd()
		end
	end
end

function FogNightExploreFloorBgComp:_createStageItems()
	for iter_8_0 = 1, 4 do
		local var_8_0 = fgui.UIPackage:createObject("fogNightmare", "FogNightmareExploreStageItem")

		self:addAutoRetain(var_8_0)

		self._stageItemPool[iter_8_0] = var_8_0
	end
end

function FogNightExploreFloorBgComp:_popAllItem()
	for iter_9_0, iter_9_1 in ipairs(self._stageItemPool) do
		local var_9_0 = iter_9_1:displayObject()

		if var_9_0:getParent() then
			var_9_0:removeFromParent()
		end
	end
end

function FogNightExploreFloorBgComp:onLoad()
	return
end

function FogNightExploreFloorBgComp:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function FogNightExploreFloorBgComp:hideButton()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
	self.m_leftButton:setVisible(false)
	self.m_rightButton:setVisible(false)
	self.m_midButton:setVisible(false)
end

function FogNightExploreFloorBgComp:showButton()
	if next((self._floorStruct:getLockInfo())) ~= nil then
		return
	end

	if #self._stages == 1 then
		self.m_leftButton:setVisible(false)
		self.m_rightButton:setVisible(false)
		self.m_midButton:setVisible(true)
	else
		self.m_leftButton:setVisible(true)
		self.m_rightButton:setVisible(true)
		self.m_midButton:setVisible(false)
	end
end

function FogNightExploreFloorBgComp:updateComp(arg_14_1, arg_14_2)
	self._floorStruct = arg_14_1

	local var_14_0 = self._floorStruct:getStages()

	self._stages = var_14_0

	self.m_midButton:setVisible(false)

	local var_14_1 = self._floorStruct:getFloorBgRes()

	if #var_14_0 == 1 then
		self.m_leftButton:setVisible(false)
		self.m_rightButton:setVisible(false)
		self.m_midButton:setVisible(true)
	else
		self.m_leftButton:setVisible(true)
		self.m_rightButton:setVisible(true)
		self.m_midButton:setVisible(false)
	end

	if not self._spineName then
		self:_updateSpine(var_14_1, "idle1", false)
	end

	self:updateFloorMidStage(arg_14_1, arg_14_2)
	self:checkSpeGuide()
end

function FogNightExploreFloorBgComp:setStageItemGrayed(arg_15_1, arg_15_2)
	for iter_15_0 = 1, 2 do
		local var_15_0 = arg_15_2

		if arg_15_1 ~= iter_15_0 then
			var_15_0 = not arg_15_2
		end

		self._stageItemPool[iter_15_0]:setGrayed(var_15_0)

		if var_15_0 then
			self._stageItemPool[iter_15_0]:playDownAction()
		else
			self._stageItemPool[iter_15_0]:playUpAction()
		end
	end
end

function FogNightExploreFloorBgComp:resetAllStageItemGrayed()
	for iter_16_0 = 1, 2 do
		self._stageItemPool[iter_16_0]:setGrayed(false)

		if self._stageItemPool[iter_16_0]:getScale().x > 1 then
			self._stageItemPool[iter_16_0]:playDownAction()
		end
	end
end

function FogNightExploreFloorBgComp:_onLeftBtnClick()
	local var_17_0 = self._floorStruct:getStages()[1]

	if var_17_0 then
		self:dispatchCompEvent("choseStage", {
			stageId = var_17_0:getStageId()
		})
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function FogNightExploreFloorBgComp:_onMidBtnClick()
	local var_18_0 = self._floorStruct:getStages()[1]

	if var_18_0 then
		self:dispatchCompEvent("choseStage", {
			stageId = var_18_0:getStageId()
		})
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function FogNightExploreFloorBgComp:checkSpeGuide()
	local var_19_0 = g.core.model.User.fogNightmareData:getTowerData()

	if var_19_0:getCurrentFloorNum() <= 2 and var_19_0:getCurrentMaxFloorNum() <= 2 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_CHECK_FOG_SELECT_STAGE",
			targetBtn = self.m_leftButton
		})
	end
end

function FogNightExploreFloorBgComp:_onRightBtnClick()
	local var_20_0 = self._floorStruct:getStages()[2]

	if var_20_0 then
		self:dispatchCompEvent("choseStage", {
			stageId = var_20_0:getStageId()
		})
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function FogNightExploreFloorBgComp:_fadeFloorMidStage(arg_21_1)
	for iter_21_0 = 1, 2 do
		self._stageItemPool[iter_21_0]:setOpacity(arg_21_1)
	end
end

function FogNightExploreFloorBgComp:updateFloorMidStage(arg_22_1, arg_22_2)
	local var_22_0 = arg_22_1:getStages()

	for iter_22_0 = 1, #var_22_0 do
		local var_22_1 = self._stageItemPool[iter_22_0]

		self._stageItemPool[iter_22_0]:updateItem(var_22_0[iter_22_0], iter_22_0 == 1, arg_22_2)

		local var_22_2 = var_22_1:displayObject()

		if not var_22_2:getParent() then
			self._spine:getNodeForSlot(string.format("chacao%02d", iter_22_0)):addChild(var_22_2)
		end

		if #var_22_0 == 1 then
			var_22_2:setPosition(cc.p(0, 0))
		elseif iter_22_0 == 1 then
			var_22_2:setPosition(cc.p(6, 0))
		else
			var_22_2:setPosition(cc.p(-6, 0))
		end
	end

	if arg_22_2 then
		self:hideButton()
	end
end

function FogNightExploreFloorBgComp:updateFloorNearlyStage(arg_23_1)
	local var_23_0 = arg_23_1:getStages()

	for iter_23_0 = 1, #var_23_0 do
		local var_23_1 = self._stageItemPool[iter_23_0 + 2]

		self._stageItemPool[iter_23_0 + 2]:updateItem(var_23_0[iter_23_0], iter_23_0 == 1, false)

		local var_23_2 = var_23_1:displayObject()

		if not var_23_2:getParent() then
			self._spine:getNodeForSlot(string.format("chacao%02d", iter_23_0 + 2)):addChild(var_23_2)
		end

		if #var_23_0 == 1 then
			var_23_2:setPosition(cc.p(0, 0))
		elseif iter_23_0 == 1 then
			var_23_2:setPosition(cc.p(6, 0))
		else
			var_23_2:setPosition(cc.p(-6, 0))
		end
	end
end

function FogNightExploreFloorBgComp:resetPlayIdle()
	self:hideButton()
	self:_setAnimation("idle2")
end

function FogNightExploreFloorBgComp:moveInStage(arg_25_1, arg_25_2)
	self:hideButton()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_STAGE_SELECT)

	self._selectIdx = arg_25_1

	self:_setAnimation("in" .. arg_25_1)
end

function FogNightExploreFloorBgComp:_onMoveInEnd()
	self:hideButton()
	self:dispatchCompEvent("onMoveInEnd")
end

function FogNightExploreFloorBgComp:playFastEnter(arg_27_1)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_START)
	self:hideButton()

	local var_27_0 = arg_27_1:getFloorBgRes()

	self:_updateTempBgSpine(var_27_0, "idle0")
	self._tempSpine:stop()

	self._floorStruct = arg_27_1
	self._targetSpineName = var_27_0
	self._targetAnim = "idle0"

	self:_updateSpine("wujing_xuanguan_04", "uishow", false)
end

function FogNightExploreFloorBgComp:_onFastEnterPlayEnd()
	self:_updateSpine(self._targetSpineName, "idle0", false)
	self:updateComp(self._floorStruct, next((self._floorStruct:getLockInfo())) ~= nil)
	self._tempSpine:restart()
	self.m_effectTempBgNode:setVisible(true)
	self:showButton()
	self:dispatchCompEvent("fastEnterPlayEnd")
end

function FogNightExploreFloorBgComp:_turnToNextSpine(arg_29_1)
	self._targetSpineName = arg_29_1

	self:_updateTempBgSpine(arg_29_1, "idle0")
	self._tempSpine:stop()
	self:dispatchCompEvent("onFastFocusFloor")
	self:_setAnimation("next2")
end

function FogNightExploreFloorBgComp:_onPlayNextSpineEnter()
	self:hideButton()
	self:_updateSpine(self._targetSpineName, "idle0", false)

	local var_30_0 = next((self._floorStruct:getLockInfo())) ~= nil

	self._tempSpine:restart()
	self:updateComp(self._floorStruct, var_30_0)
	self.m_effectTempBgNode:setVisible(true)
	self:dispatchCompEvent("playNextSpineEnter")
	self:showButton()
end

function FogNightExploreFloorBgComp:_onEnterFloorActionEnd()
	self:_fadeFloorMidStage(0)
	self:_setAnimation("idle1")
	self:dispatchCompEvent("onEnterFloorActionEnd")
	self:_fadeFloorMidStage(255)
end

function FogNightExploreFloorBgComp:_onStageUIShowEnd()
	self:showButton()

	if not self._isFirst then
		self:dispatchCompEvent("onStageUIShowEnd")
	end
end

function FogNightExploreFloorBgComp:playNextStage(arg_33_1)
	self:hideButton()

	local var_33_0 = arg_33_1:getFloorBgRes()

	if not self._spineName then
		-- block empty
	elseif self._spineName ~= var_33_0 then
		self:_turnToNextSpine(var_33_0)

		self._floorStruct = arg_33_1
	else
		self:_popAllItem()
		self:updateFloorNearlyStage(self._floorStruct)
		self:_setAnimation("play")
	end
end

function FogNightExploreFloorBgComp:_setAnimation(arg_34_1, arg_34_2, arg_34_3)
	self._spine:restart()

	self._animName = arg_34_1
	arg_34_3 = arg_34_3 or 0

	self._spine:setAnimation(arg_34_3, self._animName, arg_34_2)
end

function FogNightExploreFloorBgComp:stopAnimation()
	self._spine:stop()
end

return FogNightExploreFloorBgComp
