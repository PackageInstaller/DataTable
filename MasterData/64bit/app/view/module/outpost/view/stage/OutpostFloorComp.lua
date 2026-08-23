local var_0_0 = math.random
local OutpostCommon = require("app.view.module.outpost.const.OutpostCommon")
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local var_0_3 = g.core.model.User.outpostData
local OutpostFightEffectEnum = require("app.view.module.outpost.simulationWorld.fight.OutpostFightEffectEnum")
local var_0_5 = g.core.const.ConstMgr.outpostConst
local OutpostFloorComp = class("OutpostFloorComp", require("app.fairyGUI.outpost.UI_OutpostFloorComp"))

function OutpostFloorComp:ctor()
	self._allShowData = {}
	self._typePool = {}
	self._KnightTypeMap = {}
	self._knightTopCompMap = {}
	self._bindKnightTalkComp = {}
	self._stage = nil
	self._centerPosX = -display.width
	self._centerPosY = -display.height
	self._lastUpdatePos = cc.p(self._centerPosX, self._centerPosY)
	self._asyncApplyEntityDict1 = {}
	self._asyncApplyEntityDict2 = {}
	self._bossComp = nil

	self:initTypePools()

	self._eventManager = var_0_3:getEventManager()
	self._dirtyUpdate = {
		hasPosChange = false,
		needUpdateViewEntity = false,
		roleFightEffect = {}
	}
end

function OutpostFloorComp:setStage(arg_2_1)
	self._stage = arg_2_1

	self.m_mapEffectHolder:addEffectSpine({
		anim = "loop",
		remove = false,
		isLoop = true,
		name = "outpost_big_map"
	})
end

function OutpostFloorComp:onLoad()
	self:newScheduleOnce(handler(self, self.updateViewEntity), 0)
	self:newSchedule(handler(self, self._updateTickView))
	self:_addOutpostWorldEventManager()
end

function OutpostFloorComp:_addOutpostWorldEventManager()
	self._eventManager:addEventListener(OutpostEvent.RoleMove, handler(self, self._onEntityMoveStart), self)
	self._eventManager:addEventListener(OutpostEvent.RoleAtk, handler(self, self._onEntityAttackStart), self)
	self._eventManager:addEventListener(OutpostEvent.RoleIdle, handler(self, self._onEntityIdleStart), self)
	self._eventManager:addEventListener(OutpostEvent.RoleInBuild, handler(self, self._onEntityInBuild), self)
	self._eventManager:addEventListener(OutpostEvent.RoleOutBuild, handler(self, self._onEntityOutBuild), self)
	self._eventManager:addEventListener(OutpostEvent.RoleMoveToBossEnd, handler(self, self._onMoveToBossEnd), self)
	self._eventManager:addEventListener(OutpostEvent.BossIsActive, handler(self, self._onBossActive), self)
	self._eventManager:addEventListener(OutpostEvent.EntityAdd, handler(self, self._onEntityAdd), self)
	self._eventManager:addEventListener(OutpostEvent.EntityUpdatePos, handler(self, self._onEntityUpdatePos), self)
	self._eventManager:addEventListener(OutpostEvent.EntityDestroy, handler(self, self._onEntityDestroy), self)
	self._eventManager:addEventListener(OutpostEvent.EntityActive, handler(self, self._onEntityActive), self)
	self._eventManager:addEventListener(OutpostEvent.RoleUpdateFightEffect, handler(self, self._onEntityFightEffect), self)
	self._eventManager:addEventListener(OutpostEvent.KnightTalk, handler(self, self._onKnightTalk), self)
	self._eventManager:addEventListener(OutpostEvent.KnightToBuild, handler(self, self._onEntityMoveToBuild), self)
	self._eventManager:addEventListener(OutpostEvent.KnightInAttacking, handler(self, self._onEntityInAttacking), self)
	self._eventManager:addEventListener(OutpostEvent.BossBoxTimeTick, handler(self, self._onBossBoxTick), self)
end

function OutpostFloorComp:_onEntityFightEffect(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_3:getEffectList()

	if self._allShowData[arg_5_3.victim.oid] then
		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			if iter_5_1.effectType == OutpostFightEffectEnum.Damage then
				self._allShowData[arg_5_3.victim.oid].comp:playHit(arg_5_3)
			end
		end
	end

	if self:_checkInShow(arg_5_3.victim.x, arg_5_3.victim.y - var_0_5.ROLE_HEIGHT) then
		self.m_effectComp:playEffectList(var_5_0)
	end

	table.insert(self._dirtyUpdate.roleFightEffect, arg_5_3.victim.oid)
end

function OutpostFloorComp:_onMoveToBossEnd(arg_6_1, arg_6_2, arg_6_3)
	if self._allShowData[arg_6_3.boss.oid] then
		self._allShowData[arg_6_3.boss.oid].comp:updateBossView()
	end

	self:updateBossView(arg_6_3.boss)
end

function OutpostFloorComp:showDropFinger(arg_7_1)
	if not arg_7_1 then
		return
	end

	if self._allShowData[arg_7_1.oid] then
		self:fingerShowTo(self._allShowData[arg_7_1.oid].comp, 40, 40)
	end
end

function OutpostFloorComp:fingerShowTo(arg_8_1, arg_8_2, arg_8_3)
	if arg_8_1 and arg_8_1.fingerComp and not tolua.isnull(arg_8_1) then
		arg_8_1.fingerComp:removeSelf()

		arg_8_1.fingerComp = nil
	end

	fgui.UIPackage:addPackage("ui/guide/guide")

	local var_8_0 = fgui.UIPackage:createObject("guide", "GuideTouchComp")

	var_8_0:setTouchable(false)
	var_8_0:setPosition(arg_8_2 or 0, arg_8_3 or 0)
	arg_8_1:addChild(var_8_0)

	arg_8_1.fingerComp = var_8_0

	var_8_0:playTimes(3, handler(arg_8_1, function(arg_9_0)
		if arg_9_0 and arg_9_0.fingerComp and not tolua.isnull(arg_9_0) then
			arg_9_0.fingerComp:removeSelf()

			arg_9_0.fingerComp = nil
		end
	end))
end

function OutpostFloorComp:_onBossActive(arg_10_1, arg_10_2, arg_10_3)
	if self._allShowData[arg_10_3.boss.oid] then
		self._allShowData[arg_10_3.boss.oid].comp:updateBossView()
	end

	self:updateBossView(arg_10_3.boss)
end

function OutpostFloorComp:updateBossView(arg_11_1)
	if not arg_11_1:isInSleep() then
		if self._bossComp then
			self._bossComp:onActiveBoss()

			self._bossComp = nil
		end
	else
		if not self._bossComp then
			self._bossComp = fgui.UIPackage:createObject("outpost", "OutpostBossSleepComp")

			self._bossComp:setPosition(arg_11_1.x, arg_11_1.y)
			self.m_bossSleepHolder:addChild(self._bossComp)
		end

		self._bossComp:updateComp(arg_11_1)
	end
end

function OutpostFloorComp:_onEntityMoveStart(arg_12_1, arg_12_2, arg_12_3)
	if self._allShowData[arg_12_3.entity.oid] then
		local var_12_0 = self._allShowData[arg_12_3.entity.oid].comp

		if arg_12_3.nextPos then
			var_12_0:setKnightScale(arg_12_3.entity.x < arg_12_3.nextPos.x and 1 or -1)
			var_12_0:playMove()
		else
			var_12_0:playIdle()
		end
	end
end

function OutpostFloorComp:_onEntityMoveToBuild(arg_13_1, arg_13_2, arg_13_3)
	if self._allShowData[arg_13_3.entity.oid] then
		self._allShowData[arg_13_3.entity.oid].comp:showToBuild(arg_13_3.targetBuild)
	end
end

function OutpostFloorComp:_onEntityInAttacking(arg_14_1, arg_14_2, arg_14_3)
	if self._allShowData[arg_14_3.entity.oid] then
		self._allShowData[arg_14_3.entity.oid].comp:changeInAttacking(arg_14_3.isInAttacking)
	end
end

function OutpostFloorComp:_onBossBoxTick(arg_15_1, arg_15_2, arg_15_3)
	if self._allShowData[arg_15_3.oid] then
		self._allShowData[arg_15_3.oid].comp:updateBoxTime()
	end
end

function OutpostFloorComp:getEntityObject(arg_16_1)
	return self._allShowData[arg_16_1] and self._allShowData[arg_16_1].comp and self._allShowData[arg_16_1].comp.m_clickKnight
end

function OutpostFloorComp:_onEntityAttackStart(arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = self._allShowData[arg_17_3.attacker.oid]

	if self._allShowData[arg_17_3.attacker.oid] then
		local var_17_1 = var_17_0.comp

		var_17_0.comp:setKnightScale(arg_17_3.attacker.x < arg_17_3.victim.x and 1 or -1)
		var_17_1:playAttack(arg_17_3.fightResult)
		var_17_1:changeInAttacking(true)

		if not self._isPlayAtkSound then
			self._isPlayAtkSound = true

			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Hit)
			self:newScheduleOnce(function()
				self._isPlayAtkSound = false
			end, var_0_5.WorldParam.AttackChangeMinCd)
		end
	end
end

function OutpostFloorComp:_onEntityIdleStart(arg_19_1, arg_19_2, arg_19_3)
	if self._allShowData[arg_19_3.oid] then
		self._allShowData[arg_19_3.oid].comp:playIdle()
	end
end

function OutpostFloorComp:_onEntityInBuild(arg_20_1, arg_20_2, arg_20_3)
	if self._allShowData[arg_20_3.entity.oid] then
		self._allShowData[arg_20_3.entity.oid].comp:inBuild(arg_20_3.entity)
	end

	if self._bindKnightTalkComp[arg_20_3.entity.oid] then
		self:returnObjectToPool(self._bindKnightTalkComp[arg_20_3.entity.oid], var_0_5.ShowType.KnightTalk)

		self._bindKnightTalkComp[arg_20_3.entity.oid] = nil
	end
end

function OutpostFloorComp:_onEntityOutBuild(arg_21_1, arg_21_2, arg_21_3)
	if self._allShowData[arg_21_3.entity.oid] then
		self._allShowData[arg_21_3.entity.oid].comp:outBuild()
	end
end

function OutpostFloorComp:_onEntityAdd(arg_22_1, arg_22_2, arg_22_3)
	self:addEntityInView(arg_22_3)
end

function OutpostFloorComp:_onEntityActive(arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = self:addEntityInView(arg_23_3.entity)

	if var_23_0 and arg_23_3.entity:isMonster() then
		var_23_0.comp:monsterActive(arg_23_3.entity)
	end
end

function OutpostFloorComp:addEntityInView(arg_24_1)
	if arg_24_1:isHide() then
		return
	end

	if self:_checkInShow(arg_24_1.x, arg_24_1.y) then
		local var_24_0 = self._allShowData[arg_24_1.oid]

		if not self._allShowData[arg_24_1.oid] then
			local var_24_1 = self:getObjectFromPool(arg_24_1.entityType, nil, arg_24_1)

			var_24_1:updateEntityShowParam(arg_24_1)
			var_24_1:setPosition(arg_24_1.x, arg_24_1.y)

			var_24_0 = {
				comp = var_24_1,
				entity = arg_24_1
			}
			self._allShowData[arg_24_1.oid] = var_24_0
		end

		if arg_24_1.entityType == var_0_5.EntityType.Drop then
			var_24_0.comp:playDropTran()
		elseif arg_24_1.entityType == var_0_5.EntityType.BossBox then
			var_24_0.comp:playBossBoxDropTran()
		end

		return var_24_0
	end
end

function OutpostFloorComp:_onEntityUpdatePos(arg_25_1, arg_25_2, arg_25_3)
	if arg_25_3:isHide() then
		return
	end

	local var_25_0 = arg_25_3.oid

	if self._allShowData[arg_25_3.oid] then
		local var_25_1 = self._allShowData[arg_25_3.oid].comp
		local var_25_2 = self._allShowData[arg_25_3.oid].comp:getX()

		self._allShowData[arg_25_3.oid].comp:setPosition(arg_25_3.x, arg_25_3.y)

		if arg_25_3:isKnight() or arg_25_3:isMonster() then
			var_25_1:playMove()
			var_25_1:setKnightScale(var_25_2 < arg_25_3.x and 1 or -1)
		end
	elseif self:_checkInShow(arg_25_3.x, arg_25_3.y) then
		local var_25_3 = self:getObjectFromPool(arg_25_3.entityType, nil, arg_25_3)

		var_25_3:updateEntityShowParam(arg_25_3)
		var_25_3:setPosition(arg_25_3.x, arg_25_3.y)

		if arg_25_3:isKnight() or arg_25_3:isMonster() then
			var_25_3:playMove()
		end

		self._allShowData[var_25_0] = {
			comp = var_25_3,
			entity = arg_25_3
		}
	end

	if self._bindKnightTalkComp[var_25_0] then
		self._bindKnightTalkComp[var_25_0]:setPosition(arg_25_3.x, arg_25_3.y)
	end

	self._dirtyUpdate.hasPosChange = true
end

function OutpostFloorComp:_onEntityDestroy(arg_26_1, arg_26_2, arg_26_3)
	if self._allShowData[arg_26_3.oid] then
		self:returnObjectToPool(self._allShowData[arg_26_3.oid].comp, arg_26_3.entityType, arg_26_3)

		self._allShowData[arg_26_3.oid] = nil

		if arg_26_3.entityType == var_0_5.EntityType.Drop then
			local var_26_0 = self:getObjectFromPool(var_0_5.ShowType.DropRes)

			var_26_0:setPosition(arg_26_3.x, arg_26_3.y)
			var_26_0:showResComp(arg_26_3.itemInfo, 1)
			var_26_0:playResTopAnim(handler(self, function(arg_27_0)
				arg_27_0:returnObjectToPool(var_26_0, var_0_5.ShowType.DropRes)
			end))
		elseif arg_26_3.entityType == var_0_5.EntityType.Boss then
			self:updateBossView(arg_26_3)
		end

		if self._bindKnightTalkComp[arg_26_3.oid] then
			self:returnObjectToPool(self._bindKnightTalkComp[arg_26_3.oid], var_0_5.ShowType.KnightTalk)

			self._bindKnightTalkComp[arg_26_3.oid] = nil
		end
	end
end

function OutpostFloorComp:_onKnightTalk(arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = arg_28_3.entity.oid

	if self._allShowData[arg_28_3.entity.oid] then
		local var_28_1 = self._bindKnightTalkComp[arg_28_3.entity.oid]

		if not self._bindKnightTalkComp[arg_28_3.entity.oid] then
			var_28_1 = self:getObjectFromPool(var_0_5.ShowType.KnightTalk)
			self._bindKnightTalkComp[arg_28_3.entity.oid] = var_28_1

			var_28_1:setPosition(arg_28_3.entity.x, arg_28_3.entity.y)
			var_28_1:showTalkParam(arg_28_3)
		else
			var_28_1:setPosition(arg_28_3.entity.x, arg_28_3.entity.y)
			var_28_1:showTalkParam(arg_28_3)
		end

		if arg_28_3.talkType ~= var_0_5.TalkType.Talk1001 then
			var_28_1:newScheduleOnce(handler(self, function(arg_29_0)
				arg_29_0:returnObjectToPool(var_28_1, var_0_5.ShowType.KnightTalk)

				arg_29_0._bindKnightTalkComp[var_28_0] = nil
			end), 3)
		end
	end
end

function OutpostFloorComp:_checkInShow(arg_30_1, arg_30_2)
	if arg_30_1 < self._centerPosX - display.cx or arg_30_1 > self._centerPosX + display.cx or arg_30_2 < self._centerPosY - display.cy or arg_30_2 > self._centerPosY + display.cy then
		return false
	end

	return true
end

function OutpostFloorComp:initTypePools()
	self._typePool[var_0_5.EntityType.Barrier] = self._typePool[var_0_5.EntityType.Barrier] or {}

	for iter_31_0 = 1, var_0_5.INIT_OBS_POOL_SIZE do
		local var_31_0 = fgui.UIPackage:createObject("outpost", "OutpostBarrierComp")

		self.m_entityHolder:addChild(var_31_0)
		var_31_0:setVisible(false)
		table.insert(self._typePool[var_0_5.EntityType.Barrier], var_31_0)
	end
end

function OutpostFloorComp:getObjectFromPool(arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = self:getEntityRealType(arg_32_1, arg_32_3)

	self._typePool[var_32_0] = self._typePool[var_32_0] or {}

	if self._typePool[var_32_0] and next(self._typePool[var_32_0]) then
		local var_32_1 = table.remove(self._typePool[var_32_0])

		var_32_1:setVisible(arg_32_2 ~= false)

		return var_32_1
	else
		return self:getObjItemByType(arg_32_1, arg_32_3)
	end
end

function OutpostFloorComp:getEntityRealType(arg_33_1, arg_33_2)
	return (arg_33_2 and arg_33_1 == var_0_5.EntityType.Build or nil) and arg_33_1 * 10000 + arg_33_2:getBuildType()
end

function OutpostFloorComp:getObjItemByType(arg_34_1, arg_34_2)
	if arg_34_1 == var_0_5.EntityType.Build then
		local var_34_0 = fgui.UIPackage:createObject("outpost", "OutpostBuildComp")

		self.m_entityHolder:addChild(var_34_0)

		return var_34_0
	elseif arg_34_1 == var_0_5.EntityType.Knight then
		local var_34_1 = fgui.UIPackage:createObject("outpost", "OutpostKnightComp")

		self.m_entityHolder:addChild(var_34_1)

		return var_34_1
	elseif arg_34_1 == var_0_5.EntityType.Monster then
		local var_34_2 = fgui.UIPackage:createObject("outpost", "OutpostKnightComp")

		self.m_entityHolder:addChild(var_34_2)

		return var_34_2
	elseif arg_34_1 == var_0_5.EntityType.Boss then
		local var_34_3 = fgui.UIPackage:createObject("outpost", "OutpostKnightComp")

		self.m_entityHolder:addChild(var_34_3)

		return var_34_3
	elseif arg_34_1 == var_0_5.EntityType.Bullet then
		local var_34_4 = fgui.UIPackage:createObject("outpost", "OutpostBulletComp")

		self.m_entityHolder:addChild(var_34_4)

		return var_34_4
	elseif arg_34_1 == var_0_5.EntityType.Drop then
		local var_34_5 = fgui.UIPackage:createObject("outpost", "OutpostItemComp")

		self.m_entityHolder:addChild(var_34_5)

		return var_34_5
	elseif arg_34_1 == var_0_5.EntityType.Barrier then
		local var_34_6 = fgui.UIPackage:createObject("outpost", "OutpostBarrierComp")

		self.m_entityHolder:addChild(var_34_6)

		return var_34_6
	elseif arg_34_1 == var_0_5.EntityType.Door then
		local var_34_7 = fgui.UIPackage:createObject("outpost", "OutpostDoorComp")

		self.m_entityHolder:addChild(var_34_7)

		return var_34_7
	elseif arg_34_1 == var_0_5.EntityType.BossBox then
		local var_34_8 = fgui.UIPackage:createObject("outpost", "OutpostBossBoxComp")

		self.m_entityHolder:addChild(var_34_8)

		return var_34_8
	elseif arg_34_1 == var_0_5.EntityType.Mask then
		local var_34_9 = require("app.view.module.outpost.view.stage.mapComp.OutpostMaskComp").new()

		self.m_maskHolder:addNode(var_34_9)

		return var_34_9
	elseif arg_34_1 == var_0_5.ShowType.ItemToKnight then
		local var_34_10 = fgui.UIPackage:createObject("outpost", "OutpostItemToKnightComp")

		self.m_dropHolder:addChild(var_34_10)

		return var_34_10
	elseif arg_34_1 == var_0_5.ShowType.KnightTalk then
		local var_34_11 = fgui.UIPackage:createObject("outpost", "OutpostKnightTalkComp")

		self.m_talkHolder:addChild(var_34_11)

		return var_34_11
	elseif arg_34_1 == var_0_5.ShowType.DropRes then
		local var_34_12 = fgui.UIPackage:createObject("outpost", "OutpostResComp")

		self.m_dropHolder:addChild(var_34_12)

		return var_34_12
	elseif arg_34_1 == var_0_5.THROW then
		self.m_dropHolder:addChild((fgui.UIPackage:createObject("outpost", "OutpostThrowComp")))
	else
		assert(false, "can not create objType:%s", arg_34_1)
	end
end

function OutpostFloorComp:returnObjectToPool(arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = self:getEntityRealType(arg_35_2, arg_35_3)

	self._typePool[var_35_0] = self._typePool[var_35_0] or {}

	if arg_35_1.resetComp then
		arg_35_1:resetComp()
	end

	arg_35_1:setVisible(false)
	table.insert(self._typePool[var_35_0], arg_35_1)
end

function OutpostFloorComp:updateViewEntity()
	local var_36_0 = self._stage:getMapComp():getScreenCenterPoint()
	local var_36_1, var_36_2 = OutpostCommon.coordToPixel(var_36_0.x, var_36_0.y)

	self._centerPosX = var_36_1
	self._centerPosY = var_36_2

	if cc.pDistanceSQ(self._lastUpdatePos, cc.p(var_36_1, var_36_2)) < var_0_5.UPDATE_RENDER_PIX then
		return
	else
		self._lastUpdatePos = cc.p(var_36_1, var_36_2)
	end

	self._dirtyUpdate.needUpdateViewEntity = true
end

function OutpostFloorComp:showKnightExp(arg_37_1)
	if self._allShowData[arg_37_1.oid] then
		self._allShowData[arg_37_1.oid].comp:checkExpChange(arg_37_1)
	end
end

function OutpostFloorComp:showKnightDrop(arg_38_1, arg_38_2, arg_38_3, arg_38_4)
	if self._allShowData[arg_38_1.oid] then
		local var_38_0, var_38_1 = OutpostCommon.coordToPixel(arg_38_3, arg_38_4)

		for iter_38_0, iter_38_1 in ipairs(arg_38_2) do
			local var_38_2 = self:getObjectFromPool(var_0_5.ShowType.ItemToKnight)
			local var_38_3 = cc.p(var_38_0 + var_0_0(-100, 100), var_38_1 + var_0_0(-100, 100))

			var_38_2:setPosition(var_38_3)
			var_38_2:showItem(iter_38_1)
			var_38_2:setScale(1)
			var_38_2:playDropInFloor()
			var_38_2:runFGAction((fgui.FSequence:create({
				fgui.FDelayTime:create(0.2),
				fgui.FDelayTime:create(0.1 * iter_38_0),
				(fgui.FCallFunc:create(handler(self, function(arg_39_0)
					arg_39_0:moveToTarget(var_38_2, arg_38_1, var_38_3, var_0_5.ShowType.ItemToKnight)
				end)))
			})))
		end
	end
end

function OutpostFloorComp:moveToTarget(arg_40_1, arg_40_2, arg_40_3, arg_40_4)
	local var_40_0 = cc.p(arg_40_2.x, arg_40_2.y - var_0_5.ROLE_HEIGHT)
	local var_40_1 = cc.pGetDistance(arg_40_3, var_40_0) / var_0_5.WorldParam.ItemToKnightSpeed

	arg_40_1:runFGAction((fgui.FSequence:create({
		fgui.FSpawn:create({
			fgui.FEaseQuarticActionIn:create(fgui.FMoveTo:create(var_40_1, var_40_0)),
			(fgui.FEaseQuarticActionIn:create(fgui.FScaleTo:create(var_40_1, 0.5)))
		}),
		(fgui.FCallFunc:create(handler(self, function(arg_41_0)
			arg_41_0:returnObjectToPool(arg_40_1, arg_40_4, arg_40_2)
		end)))
	})))
end

function OutpostFloorComp:_updateTickView()
	self:checkDirtyUpdateView()
	self:checkDirtyPosChange()
	self:checkAsyncLoad()
	self:checkDirtyHUDView()
end

function OutpostFloorComp:checkDirtyUpdateView()
	if self._dirtyUpdate.needUpdateViewEntity then
		self._dirtyUpdate.needUpdateViewEntity = false

		local var_43_0, var_43_1 = self._stage:getVirtualWorld():getVirtualMap():queryRectEntities(self._lastUpdatePos.x, self._lastUpdatePos.y, display.width * 1.5, display.height * 1.5)

		for iter_43_0, iter_43_1 in pairs(self._allShowData) do
			if not var_43_1[iter_43_0] then
				self:returnObjectToPool(iter_43_1.comp, iter_43_1.entity.entityType, iter_43_1.entity)

				self._allShowData[iter_43_0] = nil
				self._asyncApplyEntityDict1[iter_43_0] = nil
				self._asyncApplyEntityDict2[iter_43_0] = nil

				if self._bindKnightTalkComp[iter_43_0] then
					self._bindKnightTalkComp[iter_43_0]:setVisible(false)
				end
			end
		end

		if var_0_3:isAsyncUpdate() then
			for iter_43_2, iter_43_3 in ipairs(var_43_0) do
				local var_43_2 = iter_43_3.oid

				if not iter_43_3:isHide() then
					if self._allShowData[iter_43_3.oid] then
						if self._bindKnightTalkComp[var_43_2] then
							self._bindKnightTalkComp[var_43_2]:setVisible(true)
						end
					else
						local var_43_3 = self:getObjectFromPool(iter_43_3.entityType, false, iter_43_3)

						if self:_checkInShow(iter_43_3.x, iter_43_3.y) then
							self._asyncApplyEntityDict1[var_43_2] = iter_43_3
						else
							self._asyncApplyEntityDict2[var_43_2] = iter_43_3
						end

						if iter_43_3.entityType == var_0_5.EntityType.Mask then
							var_43_3:setPosition(iter_43_3.x, -iter_43_3.y)
						else
							var_43_3:setPosition(iter_43_3.x, iter_43_3.y)
						end

						self._allShowData[var_43_2] = {
							comp = var_43_3,
							entity = iter_43_3
						}
					end
				elseif self._allShowData[iter_43_3.oid] then
					self:returnObjectToPool(self._allShowData[iter_43_3.oid].comp, self._allShowData[iter_43_3.oid].entity.entityType, self._allShowData[iter_43_3.oid].entity)

					self._allShowData[var_43_2] = nil
					self._asyncApplyEntityDict1[var_43_2] = nil
					self._asyncApplyEntityDict2[var_43_2] = nil

					if self._bindKnightTalkComp[var_43_2] then
						self._bindKnightTalkComp[var_43_2]:setVisible(false)
					end
				end
			end
		else
			for iter_43_4, iter_43_5 in ipairs(var_43_0) do
				local var_43_4 = iter_43_5.oid

				if not iter_43_5:isHide() then
					if self._allShowData[iter_43_5.oid] then
						-- block empty
					else
						local var_43_5 = self:getObjectFromPool(iter_43_5.entityType, nil, iter_43_5)

						if iter_43_5.entityType == var_0_5.EntityType.Mask then
							var_43_5:setPosition(iter_43_5.x, -iter_43_5.y)
						else
							var_43_5:setPosition(iter_43_5.x, iter_43_5.y)
						end

						self._allShowData[var_43_4] = {
							comp = var_43_5,
							entity = iter_43_5
						}

						var_43_5:updateEntityShowParam(iter_43_5)
					end
				elseif self._allShowData[iter_43_5.oid] then
					self:returnObjectToPool(self._allShowData[iter_43_5.oid].comp, self._allShowData[iter_43_5.oid].entity.entityType, self._allShowData[iter_43_5.oid].entity)

					self._allShowData[var_43_4] = nil
					self._asyncApplyEntityDict1[var_43_4] = nil
					self._asyncApplyEntityDict2[var_43_4] = nil

					if self._bindKnightTalkComp[var_43_4] then
						self._bindKnightTalkComp[var_43_4]:setVisible(false)
					end
				end
			end
		end
	end
end

function OutpostFloorComp:checkDirtyPosChange()
	if self._dirtyUpdate.hasPosChange then
		self._dirtyUpdate.hasPosChange = false

		local var_44_0 = {}

		for iter_44_0, iter_44_1 in pairs(self._allShowData) do
			local var_44_1 = iter_44_1.entity

			if iter_44_1.entity.entityType ~= var_0_5.EntityType.Mask then
				local var_44_2 = var_44_1.x
				local var_44_3 = var_44_1.y
				local var_44_4, var_44_5 = OutpostCommon.pixelToCoord(var_44_1.x, var_44_1.y)

				if var_44_1.entityType == var_0_5.EntityType.Barrier then
					local var_44_6 = var_44_1:getBarrierInfo()
					local var_44_7 = OutpostCommon.DIR_X[var_44_6.x_w * 100 + var_44_6.y_w] or cc.p(0, 0)

					var_44_2 = var_44_2 + var_44_7.x
					var_44_3 = var_44_3 + var_44_7.y
				elseif var_44_1.entityType == var_0_5.EntityType.Build then
					var_44_2 = var_44_2 - 140
					var_44_3 = var_44_3 - 70
				end

				table.insert(var_44_0, {
					oid = var_44_1.oid,
					obj = iter_44_1.comp,
					pixelX = var_44_2,
					pixelY = var_44_3,
					px = var_44_4,
					py = var_44_5,
					aSum = var_44_4 + var_44_5,
					bSum = var_44_4 + var_44_5,
					isDoor = var_44_1.entityType == var_0_5.EntityType.Door
				})
			end
		end

		table.sort(var_44_0, function(arg_45_0, arg_45_1)
			if arg_45_0.isDoor ~= arg_45_1.isDoor then
				return arg_45_0.isDoor
			end

			if arg_45_0.aSum ~= arg_45_1.bSum then
				return arg_45_0.aSum < arg_45_1.bSum
			end

			if arg_45_0.pixelX ~= arg_45_1.pixelX then
				return arg_45_0.pixelX < arg_45_1.pixelX
			end

			if arg_45_0.pixelY ~= arg_45_1.pixelY then
				return arg_45_0.pixelY < arg_45_1.pixelY
			end

			return arg_45_0.oid < arg_45_1.oid
		end)

		for iter_44_2 = 1, #var_44_0 do
			self.m_entityHolder:setChildIndex(var_44_0[iter_44_2].obj, iter_44_2 - 1)
		end
	end
end

function OutpostFloorComp:checkAsyncLoad()
	if var_0_3:isAsyncUpdate() then
		local var_46_0 = 0

		for iter_46_0, iter_46_1 in pairs(self._asyncApplyEntityDict1) do
			if self._allShowData[iter_46_1.oid] then
				self._allShowData[iter_46_1.oid].comp:setVisible(true)
				self._allShowData[iter_46_1.oid].comp:updateEntityShowParam(iter_46_1)

				if self._bindKnightTalkComp[iter_46_0] then
					self._bindKnightTalkComp[iter_46_0]:setVisible(true)
				end

				var_46_0 = var_46_0 + 1
			end

			self._asyncApplyEntityDict1[iter_46_0] = nil

			if var_46_0 > var_0_5.AsyncUpdateCount then
				break
			end
		end

		if var_46_0 < var_0_5.AsyncUpdateCount then
			for iter_46_2, iter_46_3 in pairs(self._asyncApplyEntityDict2) do
				if self._allShowData[iter_46_3.oid] then
					self._allShowData[iter_46_3.oid].comp:setVisible(true)
					self._allShowData[iter_46_3.oid].comp:updateEntityShowParam(iter_46_3)

					if self._bindKnightTalkComp[iter_46_2] then
						self._bindKnightTalkComp[iter_46_2]:setVisible(true)
					end

					var_46_0 = var_46_0 + 1
				end

				self._asyncApplyEntityDict2[iter_46_2] = nil

				if var_46_0 > var_0_5.AsyncUpdateCount then
					break
				end
			end
		end
	end
end

function OutpostFloorComp:checkDirtyHUDView()
	for iter_47_0, iter_47_1 in pairs(self._dirtyUpdate.roleFightEffect) do
		if self._allShowData[iter_47_1] then
			self._allShowData[iter_47_1].comp:updateHp()
		end
	end
end

function OutpostFloorComp:playItemFlyEff(arg_48_1)
	local var_48_0 = self:getObjectFromPool(var_0_5.ShowType.DropRes)

	var_48_0:setPosition(arg_48_1.buildPos.x, arg_48_1.buildPos.y)
	var_48_0:showResCompById(arg_48_1.itemInfo.value, arg_48_1.itemInfo.size)
	var_48_0:playResTopAnim(handler(self, function(arg_49_0)
		arg_49_0:returnObjectToPool(var_48_0, var_0_5.ShowType.DropRes)
	end))
end

function OutpostFloorComp:onUnload()
	self._eventManager:removeListenerWithTarget(self)
end

return OutpostFloorComp
