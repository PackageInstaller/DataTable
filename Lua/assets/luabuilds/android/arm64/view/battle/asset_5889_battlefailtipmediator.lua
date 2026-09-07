local BattleFailTipMediator = class("BattleFailTipMediator", import("..base.ContextMediator"))

BattleFailTipMediator.CHAPTER_RETREAT = "BattleFailTipMediator:CHAPTER_RETREAT"
BattleFailTipMediator.GO_NAVALTACTICS = "BattleFailTipMediator:GO_NAVALTACTICS"
BattleFailTipMediator.GO_HIGEST_CHAPTER = "BattleFailTipMediator:GO_HIGEST_CHAPTER"
BattleFailTipMediator.GO_DOCKYARD_EQUIP = "BattleFailTipMediator:GO_DOCKYARD_EQUIP"
BattleFailTipMediator.GO_DOCKYARD_SHIP = "BattleFailTipMediator:GO_DOCKYARD_SHIP"

function BattleFailTipMediator:register()
	self:initData()
	self:bindEvent()

	return
end

function BattleFailTipMediator:initData()
	self.mainShips = self.contextData.mainShips
	self.battleSystem = self.contextData.battleSystem

	return
end

function BattleFailTipMediator:bindEvent()
	self:bind(BattleFailTipMediator.CHAPTER_RETREAT, function(arg_4_0, arg_4_1)
		local var_4_0 = getProxy(ChapterProxy):getActiveChapter()
		local var_4_2 = {}

		for iter_4_0, iter_4_1 in ipairs(var_4_0 and var_4_0:getShips() or self.mainShips) do
			var_4_2[#var_4_2 + 1] = iter_4_1.id
		end

		self.tempShipIDList = var_4_2

		self:sendNotification(GAME.CHAPTER_OP, {
			type = ChapterConst.OpRetreat
		})

		return
	end)
	self:bind(BattleFailTipMediator.GO_HIGEST_CHAPTER, function(arg_5_0)
		self:removeContextBeforeGO()

		local var_5_0, var_5_1 = getProxy(ChapterProxy):getHigestClearChapterAndMap()

		self:sendNotification(GAME.CHANGE_SCENE, SCENE.LEVEL, {
			targetChapter = var_5_0,
			targetMap = var_5_1
		})

		return
	end)
	self:bind(BattleFailTipMediator.GO_DOCKYARD_EQUIP, function(arg_6_0)
		self:removeContextBeforeGO()

		if not self.tempShipIDList then
			local var_6_0 = {}

			for iter_6_0, iter_6_1 in ipairs(self.mainShips) do
				var_6_0[#var_6_0 + 1] = iter_6_1.id
			end

			self.tempShipIDList = var_6_0
		end

		self:sendNotification(GAME.CHANGE_SCENE, SCENE.DOCKYARD, {
			priorEquipUpShipIDList = self.tempShipIDList,
			priorMode = DockyardScene.PRIOR_MODE_EQUIP_UP,
			mode = DockyardScene.MODE_OVERVIEW,
			onClick = function(self, arg_7_1)
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
					openEquipUpgrade = true,
					shipId = self.id,
					shipVOs = arg_7_1,
					page = ShipViewConst.PAGE.EQUIPMENT
				})

				return
			end
		})

		return
	end)
	self:bind(BattleFailTipMediator.GO_DOCKYARD_SHIP, function(arg_8_0)
		self:removeContextBeforeGO()

		if not self.tempShipIDList then
			local var_8_0 = {}

			for iter_8_0, iter_8_1 in ipairs(self.mainShips) do
				var_8_0[#var_8_0 + 1] = iter_8_1.id
			end

			self.tempShipIDList = var_8_0
		end

		self:sendNotification(GAME.CHANGE_SCENE, SCENE.DOCKYARD, {
			priorEquipUpShipIDList = self.tempShipIDList,
			priorMode = DockyardScene.PRIOR_MODE_SHIP_UP,
			mode = DockyardScene.MODE_OVERVIEW,
			onClick = function(self, arg_9_1)
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
					shipId = self.id,
					shipVOs = arg_9_1,
					page = ShipViewConst.PAGE.INTENSIFY
				})

				return
			end
		})

		return
	end)
	self:bind(BattleFailTipMediator.GO_NAVALTACTICS, function(arg_10_0)
		self:removeContextBeforeGO()
		self:sendNotification(GAME.CHANGE_SCENE, SCENE.NAVALTACTICS)

		return
	end)

	return
end

function BattleFailTipMediator:listNotificationInterests()
	return {
		GAME.CHAPTER_OP_DONE
	}
end

function BattleFailTipMediator:handleNotification(arg_12_1)
	local var_12_0 = arg_12_1:getBody()

	if arg_12_1:getName() == GAME.CHAPTER_OP_DONE then
		if self.viewComponent.lastClickBtn == BattleFailTipLayer.PowerUpBtn.ShipLevelUp then
			local var_12_1 = getProxy(ContextProxy):getContextByMediator(LevelMediator2)

			if var_12_1 then
				local var_12_2 = var_12_1:getContextByMediator(ChapterPreCombatMediator)

				if var_12_2 then
					var_12_1:removeChild(var_12_2)
				end

				local var_12_3 = var_12_1:getContextByMediator(BattleResultMediator)

				if var_12_3 then
					var_12_1:removeChild(var_12_3)
				end
			end

			local var_12_4, var_12_5 = getProxy(ChapterProxy):getHigestClearChapterAndMap()

			self:sendNotification(GAME.GO_BACK, {
				targetChapter = var_12_4,
				targetMap = var_12_5
			})
		elseif self.viewComponent.lastClickBtn == BattleFailTipLayer.PowerUpBtn.EquipLevelUp then
			local var_12_6 = getProxy(ContextProxy):getContextByMediator(LevelMediator2)

			if var_12_6 then
				local var_12_7 = var_12_6:getContextByMediator(ChapterPreCombatMediator)

				if var_12_7 then
					var_12_6:removeChild(var_12_7)
				end

				local var_12_8 = var_12_6:getContextByMediator(BattleResultMediator)

				if var_12_8 then
					var_12_6:removeChild(var_12_8)
				end
			end

			self:sendNotification(GAME.CHANGE_SCENE, SCENE.DOCKYARD, {
				priorEquipUpShipIDList = self.tempShipIDList,
				priorMode = DockyardScene.PRIOR_MODE_EQUIP_UP,
				mode = DockyardScene.MODE_OVERVIEW,
				onClick = function(self, arg_13_1)
					pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
						openEquipUpgrade = true,
						shipId = self.id,
						shipVOs = arg_13_1,
						page = ShipViewConst.PAGE.EQUIPMENT
					})

					return
				end
			})
		elseif self.viewComponent.lastClickBtn == BattleFailTipLayer.PowerUpBtn.SkillLevelUp then
			local var_12_9 = getProxy(ContextProxy):getContextByMediator(LevelMediator2)

			if var_12_9 then
				local var_12_10 = var_12_9:getContextByMediator(ChapterPreCombatMediator)

				if var_12_10 then
					var_12_9:removeChild(var_12_10)
				end

				local var_12_11 = var_12_9:getContextByMediator(BattleResultMediator)

				if var_12_11 then
					var_12_9:removeChild(var_12_11)
				end
			end

			self:sendNotification(GAME.CHANGE_SCENE, SCENE.NAVALTACTICS)
		elseif self.viewComponent.lastClickBtn == BattleFailTipLayer.PowerUpBtn.ShipBreakUp then
			local var_12_12 = getProxy(ContextProxy):getContextByMediator(LevelMediator2)

			if var_12_12 then
				local var_12_13 = var_12_12:getContextByMediator(ChapterPreCombatMediator)

				if var_12_13 then
					var_12_12:removeChild(var_12_13)
				end

				local var_12_14 = var_12_12:getContextByMediator(BattleResultMediator)

				if var_12_14 then
					var_12_12:removeChild(var_12_14)
				end
			end

			self:sendNotification(GAME.CHANGE_SCENE, SCENE.DOCKYARD, {
				priorEquipUpShipIDList = self.tempShipIDList,
				priorMode = DockyardScene.PRIOR_MODE_SHIP_UP,
				mode = DockyardScene.MODE_OVERVIEW,
				onClick = function(self, arg_14_1)
					pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
						shipId = self.id,
						shipVOs = arg_14_1,
						page = ShipViewConst.PAGE.INTENSIFY
					})

					return
				end
			})
		end

		self.tempShipIDList = nil
	end

	return
end

function BattleFailTipMediator:removeContextBeforeGO()
	local var_15_0 = getProxy(ContextProxy)

	if self.battleSystem == SYSTEM_SCENARIO then
		local var_15_1 = var_15_0:getContextByMediator(LevelMediator2)

		if var_15_1 then
			local var_15_2 = var_15_1:getContextByMediator(ChapterPreCombatMediator)

			if var_15_2 then
				var_15_1:removeChild(var_15_2)
			end

			local var_15_3 = var_15_1:getContextByMediator(BattleResultMediator)

			if var_15_3 then
				var_15_1:removeChild(var_15_3)
			end
		end
	elseif self.battleSystem == SYSTEM_ROUTINE or self.battleSystem == SYSTEM_SUB_ROUTINE then
		local var_15_4 = var_15_0:getContextByMediator(DailyLevelMediator)

		if var_15_4 then
			local var_15_5 = var_15_4:getContextByMediator(PreCombatMediator)

			if var_15_5 then
				var_15_4:removeChild(var_15_5)
			end

			local var_15_6 = var_15_4:getContextByMediator(BattleResultMediator)

			if var_15_6 then
				var_15_4:removeChild(var_15_6)
			end
		end
	elseif self.battleSystem == SYSTEM_DUEL then
		local var_15_7 = var_15_0:getContextByMediator(MilitaryExerciseMediator)

		if var_15_7 then
			local var_15_8 = var_15_7:getContextByMediator(ExercisePreCombatMediator)

			if var_15_8 then
				var_15_7:removeChild(var_15_8)
			end

			local var_15_9 = var_15_7:getContextByMediator(BattleResultMediator)

			if var_15_9 then
				var_15_7:removeChild(var_15_9)
			end
		end
	elseif self.battleSystem == SYSTEM_HP_SHARE_ACT_BOSS then
		local var_15_10, var_15_11 = var_15_0:getContextByMediator(ActivityBossPreCombatMediator)

		if var_15_10 then
			var_15_11:removeChild(var_15_10)
		end
	end

	return
end

return BattleFailTipMediator
