local ChapterPreCombatMediator = class("ChapterPreCombatMediator", import("..base.ContextMediator"))

ChapterPreCombatMediator.ON_START = "ChapterPreCombatMediator:ON_START"
ChapterPreCombatMediator.ON_SWITCH_SHIP = "ChapterPreCombatMediator:ON_SWITCH_SHIP"
ChapterPreCombatMediator.ON_SWITCH_FLEET = "ChapterPreCombatMediator:ON_SWITCH_FLEET"
ChapterPreCombatMediator.ON_OP = "ChapterPreCombatMediator:ON_OP"
ChapterPreCombatMediator.ON_AUTO = "ChapterPreCombatMediator:ON_AUTO"
ChapterPreCombatMediator.ON_SUB_AUTO = "ChapterPreCombatMediator:ON_SUB_AUTO"
ChapterPreCombatMediator.GET_CHAPTER_DROP_SHIP_LIST = "ChapterPreCombatMediator:GET_CHAPTER_DROP_SHIP_LIST"

function ChapterPreCombatMediator:register()
	self:bind(ChapterPreCombatMediator.GET_CHAPTER_DROP_SHIP_LIST, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.GET_CHAPTER_DROP_SHIP_LIST, {
			chapterId = arg_2_1,
			callback = arg_2_2
		})

		return
	end)
	self:bind(ChapterPreCombatMediator.ON_SWITCH_SHIP, function(arg_3_0, arg_3_1)
		local var_3_0 = getProxy(ChapterProxy)
		local var_3_1 = var_3_0:getActiveChapter()

		var_3_1.fleet:synchronousShipIndex(arg_3_1)
		var_3_0:updateChapter(var_3_1, ChapterConst.DirtyFleet)

		return
	end)
	self:bind(ChapterPreCombatMediator.ON_AUTO, function(arg_4_0, arg_4_1)
		self:onAutoBtn(arg_4_1)

		return
	end)
	self:bind(ChapterPreCombatMediator.ON_SUB_AUTO, function(arg_5_0, arg_5_1)
		self:onAutoSubBtn(arg_5_1)

		return
	end)
	self:bind(ChapterPreCombatMediator.ON_START, function(arg_6_0)
		local var_6_0 = getProxy(ChapterProxy):getActiveChapter()
		local var_6_1 = var_6_0.fleet
		local var_6_2 = var_6_0:getStageId(var_6_0.fleet.line.row, var_6_0.fleet.line.column)

		seriesAsync({
			function(arg_7_0)
				local var_7_0 = {}

				for iter_7_0, iter_7_1 in pairs(var_6_1.ships) do
					table.insert(var_7_0, iter_7_1)
				end

				Fleet.EnergyCheck(var_7_0, var_6_1.name, function(arg_8_0)
					if arg_8_0 then
						arg_7_0()
					end

					return
				end)

				return
			end,
			function(arg_9_0)
				if getProxy(PlayerProxy):getRawData():GoldMax(1) then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("gold_max_tip_title") .. i18n("resource_max_tip_battle"),
						onYes = arg_9_0
					})
				else
					arg_9_0()
				end

				return
			end
		}, function()
			self:sendNotification(GAME.BEGIN_STAGE, {
				system = SYSTEM_SCENARIO,
				stageId = var_6_2
			})

			return
		end)

		return
	end)
	self:bind(ChapterPreCombatMediator.ON_OP, function(arg_11_0, arg_11_1)
		self:sendNotification(GAME.CHAPTER_OP, arg_11_1)

		return
	end)

	local var_1_0 = getProxy(ChapterProxy)
	local var_1_1 = var_1_0:getActiveChapter()

	self.viewComponent:setSubFlag(var_1_0.getSubAidFlag(var_1_1, (var_1_1:getStageId(var_1_1.fleet.line.row, var_1_1.fleet.line.column))))
	self.viewComponent:setPlayerInfo(getProxy(PlayerProxy):getRawData())
	self:display()

	return
end

function ChapterPreCombatMediator:onAutoBtn(arg_12_1)
	self:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = arg_12_1.isOn,
		toggle = arg_12_1.toggle
	})

	return
end

function ChapterPreCombatMediator:onAutoSubBtn(arg_13_1)
	self:sendNotification(GAME.AUTO_SUB, {
		isActiveSub = arg_13_1.isOn,
		toggle = arg_13_1.toggle
	})

	return
end

function ChapterPreCombatMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		GAME.BEGIN_STAGE_ERRO,
		GAME.CHAPTER_OP_DONE
	}
end

function ChapterPreCombatMediator:handleNotification(arg_15_1)
	local var_15_0 = arg_15_1:getName()
	local var_15_1 = arg_15_1:getBody()

	if var_15_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayerInfo(getProxy(PlayerProxy):getRawData())
	elseif var_15_0 == GAME.BEGIN_STAGE_ERRO then
		setActive(self.viewComponent._startBtn, true)

		if var_15_1 == 3 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("battle_preCombatMediator_timeout"),
				onYes = function()
					self.viewComponent:emit(BaseUI.ON_CLOSE)

					return
				end
			})
		end
	elseif var_15_0 == GAME.CHAPTER_OP_DONE and (var_15_1.type == ChapterConst.OpStrategy or var_15_1.type == ChapterConst.OpRepair or var_15_1.type == ChapterConst.OpRequest) then
		self:display()
	end

	return
end

function ChapterPreCombatMediator:display()
	self.viewComponent:updateChapter((getProxy(ChapterProxy):getActiveChapter()))

	return
end

return ChapterPreCombatMediator
