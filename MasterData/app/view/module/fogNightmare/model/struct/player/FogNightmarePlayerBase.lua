local var_0_0 = g.core.const.ConstMgr.FogNightmareConst
local FogNightmareCmdBase = require("app.view.module.fogNightmare.model.struct.execute.FogNightmareCmdBase")
local FogNightmareCmdUI = require("app.view.module.fogNightmare.model.struct.execute.FogNightmareCmdUI")
local FogNightmareCmdNet = require("app.view.module.fogNightmare.model.struct.execute.FogNightmareCmdNet")
local FogNightmareCmdSub = require("app.view.module.fogNightmare.model.struct.execute.FogNightmareCmdSub")
local FogNightmarePlayerBase = class("FogNightmarePlayerBase")

function FogNightmarePlayerBase:ctor()
	self._isUsedUI = true
	self._needFormation = false
	self._needAddPoolKnight = false
	self._needSelectTalent = false
	self._canExplore = false
	self._formationIdx = -1
	self._addPoolKnightNum = -1
end

function FogNightmarePlayerBase:checkKeepsakeNet()
	if not g.core.model.User.fogNightmareData:getAutoPlay():checkCurCmdId("checkKeepsakeNet", true) then
		self:_doEnterNextFloor()
	end
end

function FogNightmarePlayerBase:setUIEnable(arg_3_1)
	self._isUsedUI = arg_3_1
end

function FogNightmarePlayerBase:startThinking()
	self._originLevel = g.core.model.User.fogNightmareData:getFogLevel()
	self._curMax = g.core.model.User.fogNightmareData:getTowerData():getCurrentMaxFloorNum()
	self._curFloorId = g.core.model.User.fogNightmareData:getTowerData():getCurrentFloorNum()

	local var_4_0 = g.core.model.User.fogNightmareData:getTowerData():checkCurFloorState(true)
	local var_4_1 = g.core.module.ModuleManager:getCurModule()
	local var_4_2 = var_0_0.FLOOR_STATE.PASS == var_4_0 and handler(self, self._doEnterNextFloor) or var_0_0.FLOOR_STATE.WAIT_SELECT_KEEPSAKE == var_4_0 and handler(self, self._doCheckNeedSelectKeepsake) or var_0_0.FLOOR_STATE.WAIT_SELECT == var_4_0 and handler(self, self._doSelectStage) or var_4_1 and var_4_1.display:getName() == "FogNightmareExploreFormationPop" and handler(self, self._doBattleStart) or handler(self, self._doWaveSelectAndPass)

	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdBase.new({
		execute = var_4_2
	})))
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CHECK_KEEPSAKE_NET, handler(self, self.checkKeepsakeNet), self)
end

function FogNightmarePlayerBase:stopThinking()
	g.core.event.EventManager:removeListenerWithTarget(self)
end

local var_0_6 = g.core.const.ConstMgr.KNIGHT_CONST

function FogNightmarePlayerBase:_checkNeedFormation()
	local var_6_0 = g.core.model.User.fogNightmareData:getTowerData():getCurFloorStruct()

	if not var_6_0 or #var_6_0:getSelectedStage() < 1 then
		self._needFormation = false
	else
		local var_6_1 = var_6_0:getSelectedStage()[1]
		local var_6_2 = var_6_1:getTempSelectWave()

		if var_0_0.WAVE_EFFECT_TYPE.MONSTER_BOSS >= var_6_1:getAllWave()[var_6_2]:getType() then
			local var_6_3 = g.core.model.User.fogNightmareData:getFormationData():getLineUpFormation(var_6_2)

			if not var_6_3 then
				self._needFormation = false

				return
			end

			self._needFormation = var_6_3:getKnightsNum() == 0

			if self._needFormation then
				self._formationIdx = var_6_2
			end
		else
			self._needFormation = false
		end
	end

	return self._needFormation
end

function FogNightmarePlayerBase:_doFormation()
	local var_7_0 = g.core.model.User.fogNightmareData:getFormationData():getLineUpFormation(self._formationIdx)
	local var_7_1 = {}

	for iter_7_0 = 1, var_0_6.LINEUP_MAX do
		if not var_7_0:getKnight(iter_7_0) then
			local var_7_2 = self:_getBestKnight(var_7_0, var_7_1)

			if not var_7_2 then
				return
			end

			var_7_1[var_7_2] = var_7_2

			if self._isUsedUI then
				self:_addKnightByUI(var_7_0, iter_7_0)
			else
				var_7_0:setKnight(var_7_2, iter_7_0)
			end
		end
	end
end

function FogNightmarePlayerBase:_getBestKnight(arg_8_1, arg_8_2)
	return
end

function FogNightmarePlayerBase:_getBestArtifact(arg_9_1)
	return
end

function FogNightmarePlayerBase:_getBestUnitToken(arg_10_1)
	return
end

function FogNightmarePlayerBase:_getBestPet(arg_11_1)
	return
end

function FogNightmarePlayerBase:_doBattleStart()
	if self:_checkNeedFormation() then
		g.core.model.User.fogNightmareData:getAutoPlay():stopAutoPlay(g.core.lang:get(500249))

		return
	end

	if self._isUsedUI then
		local var_12_0 = g.core.model.User.fogNightmareData:getFormationData():getStageSkipFormation()

		if not var_12_0 then
			g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdUI.new({
				UIPath = "FogNightmareExploreFormationPop:challengeBtn",
				UIParam = {
					type = "comp"
				}
			})))
		elseif var_12_0 and not g.core.model.User.fogNightmareData:getAutoPlay():isAutoSkipEnable() then
			self:_doSkipFormationBattleStart()
		end

		local var_12_1 = FogNightmareCmdBase.new({
			trigger = function()
				local var_13_0 = g.core.battle.BattleProxy:getBattleLayer()
				local var_13_1 = false

				if var_13_0 then
					local var_13_2 = var_13_0:getUILayerSubComp("autoNode")

					if var_13_2 and var_13_2:isVisible() then
						var_13_1 = true
					end
				end

				return var_13_1
			end,
			execute = function()
				local var_14_0 = g.core.battle.BattleProxy:getBattleLayer():getUILayerSubComp("controlComp/skipBtn")

				if var_14_0:getController("lock"):getSelectedIndex() == 0 then
					var_14_0:dispatchEvent(fgui.UIEventType.Click)
				end
			end
		})

		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_12_1)
		var_12_1:setQuickTrigger(true)
	else
		local var_12_2 = {
			netFunc = handler(g.core.network.GameNetProxy, g.core.network.GameNetProxy.send_C2S_Formation_Save)
		}

		var_12_2.netParams = g.core.model.User.fogNightmareData:getFormationData():getAndSaveFormationRequestParam()
		var_12_2.netEventKey = g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE

		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdNet.new(var_12_2)))

		local var_12_3 = g.core.model.User.fogNightmareData:getTowerData():getCurrentFloorNum()
		local var_12_4 = g.core.model.User.fogNightmareData:getTowerData():getFloorStruct(var_12_3):getSelectedStage()[1]

		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdNet.new({
			netFunc = handler(g.core.network.GameNetProxy, g.core.network.GameNetProxy.send_C2S_Fog_ChallengeBegin),
			netParams = {
				floor = var_12_3,
				stage = var_12_4:getStageId(),
				wave = var_12_4:getTempSelectWave()
			},
			netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_CHALLENGEBEGIN
		})))
	end

	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdNet.new({
		execute = handler(self, self._doBattleEnd),
		netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_CHALLENGEFINISH,
		receive = function(self)
			local var_15_0 = false

			if not self.is_win then
				var_15_0 = true
			else
				local var_15_1 = 0

				for iter_15_0, iter_15_1 in pairs((g.core.model.User.fogNightmareData:getFormationData():getBattleFormation():getKnightPosList())) do
					if iter_15_1:getHpPercent() < 1 then
						var_15_1 = var_15_1 + 1
					end
				end

				if var_15_1 >= g.core.model.User.fogNightmareData:getAutoPlay():getLowHpNum() then
					var_15_0 = true
				end
			end

			if var_15_0 and self._isUsedUI then
				local var_15_2 = g.core.lang:get(500249)

				if self.is_win then
					var_15_2 = g.core.lang:get(500248)
				end

				g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(FogNightmareCmdUI.new({
					UIPath = "BattleResultLayer:autoNode",
					execute = function()
						g.core.model.User.fogNightmareData:getAutoPlay():stopAutoPlay(var_15_2)
					end,
					UIParam = {
						type = "comp"
					}
				}), 1)
			elseif var_15_0 then
				g.core.model.User.fogNightmareData:getAutoPlay():stopAutoPlay(g.core.lang:get(500249))
			end
		end
	})))
end

function FogNightmarePlayerBase:_doSkipFormationBattleStart()
	local FogNightmareCmdWaiting = require("app.view.module.fogNightmare.model.struct.execute.FogNightmareCmdWaiting")
	local var_17_1 = {}

	if g.core.model.User.fogNightmareData:getFormationData():checkCanSkipFormation() then
		table.insert(var_17_1, (FogNightmareCmdUI.new({
			UIPath = "FogNightmareExploreFormationPop:challengeBtn",
			UIParam = {
				type = "comp"
			}
		})))
		table.insert(var_17_1, (FogNightmareCmdBase.new({})))
	else
		table.insert(var_17_1, (FogNightmareCmdUI.new({
			UIPath = "BaseConfirmPop:midNode",
			UIParam = {
				type = "comp"
			},
			execute = function()
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_FOG_NIGHTMARE_AUTO_KEEPSAKE_SHOW, false)
			end
		})))
		table.insert(var_17_1, (FogNightmareCmdUI.new({
			UIPath = "FogNightmareExploreFormationPop:challengeBtn",
			UIParam = {
				type = "comp"
			}
		})))
	end

	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdWaiting.new({
		cnt = 0,
		cmdList = var_17_1,
		waiterParam = {}
	})))
end

function FogNightmarePlayerBase:_doBattleEnd()
	if self._isUsedUI then
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdUI.new({
			UIPath = "BattleResultLayer",
			showUIPath = "BattleResultLayer:autoNode",
			UIParam = {
				type = "comp"
			}
		})))
	end

	local var_19_0 = FogNightmareCmdBase.new({
		execute = handler(self, self._doWaveSelectAndPass)
	})

	var_19_0:setQuickTrigger(true)
	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_19_0)
end

function FogNightmarePlayerBase:_addKnightByUI(arg_20_1, arg_20_2)
	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdUI.new({
		UIPath = "FogNightmareExploreFormationPop:tabList",
		UIParam = {
			type = "list",
			selectIdx = arg_20_1:getFormationIdx() - 1
		}
	})))
	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdUI.new({
		UIPath = "FogNightmareExploreFormationPop:knightsComp/knight" .. arg_20_2 .. "/knightComp/knightClickNode",
		UIParam = {
			type = "comp"
		}
	})))
	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdUI.new({
		UIPath = "FogNightmareExploreLineUpPop:lineList",
		UIParam = {
			selectIdx = 0,
			type = "list"
		}
	})))
end

function FogNightmarePlayerBase:_checkNeedAddPoolKnight()
	self._addPoolKnightNum = 0

	local var_21_0 = g.core.model.User:getId()
	local var_21_1 = 0

	for iter_21_0, iter_21_1 in pairs(g.core.model.User.fogNightmareData:getFormationData():getPoolMember().knights) do
		if iter_21_1:getOwner().id == var_21_0 then
			var_21_1 = var_21_1 + 1
		end
	end

	local var_21_2 = self:getMaxKnightNum() - var_0_0.MAX_HELPER_LINE_UP_COUNT

	if var_21_1 < var_21_2 then
		local var_21_3 = 0

		for iter_21_2, iter_21_3 in ipairs((g.core.model.User.knightsData:getOwnerAllList())) do
			if self:_checkCanAddPool(iter_21_3) then
				var_21_3 = var_21_3 + 1
			end
		end

		self._addPoolKnightNum = math.min(var_21_3, var_21_2 - var_21_1)
	end

	self._needAddPoolKnight = self._addPoolKnightNum > 0

	return self._needAddPoolKnight
end

function FogNightmarePlayerBase:_checkCanAddPool(arg_22_1)
	return not g.core.model.User.fogNightmareData:getFormationData():isInPoolKnightByAdvanceId(arg_22_1:getAdvanceId())
end

function FogNightmarePlayerBase:_addPoolKnight()
	return
end

function FogNightmarePlayerBase:_getBestPoolKnights()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs((g.core.model.User.knightsData:getOwnerAllList())) do
		if self:_checkCanAddPool(iter_24_1) then
			var_24_0[#var_24_0 + 1] = iter_24_1
		end
	end

	table.sort(var_24_0, function(arg_25_0, arg_25_1)
		local var_25_0 = arg_25_0:getQuality()
		local var_25_1 = arg_25_1:getQuality()

		if var_25_0 ~= var_25_1 then
			return var_25_1 < var_25_0
		end

		local var_25_2 = arg_25_0:getStarLv()
		local var_25_3 = arg_25_1:getStarLv()

		if var_25_2 ~= var_25_3 then
			return var_25_3 < var_25_2
		end

		local var_25_4 = arg_25_0:getAdvanceLevel()
		local var_25_5 = arg_25_1:getAdvanceLevel()

		if var_25_4 ~= var_25_5 then
			return var_25_5 < var_25_4
		end

		return arg_25_0:getAdvanceId() < arg_25_1:getAdvanceId()
	end)

	return var_24_0
end

function FogNightmarePlayerBase:_doSelectStage()
	local var_26_0 = g.core.model.User.fogNightmareData:getTowerData():getCurFloorStruct()

	if var_26_0 and next(var_26_0:getLockInfo()) then
		g.core.model.User.fogNightmareData:getAutoPlay():stopAutoPlay(g.core.lang:get(500250))

		return
	end

	local var_26_1 = var_26_0:getStages()
	local var_26_2 = var_26_1[1]
	local var_26_3 = 1

	for iter_26_0 = 2, #var_26_1 do
		if var_26_1[iter_26_0]:getPower() < var_26_2:getPower() then
			var_26_2 = var_26_1[iter_26_0]
			var_26_3 = iter_26_0
		end
	end

	if self._isUsedUI then
		local var_26_4 = FogNightmareCmdBase.new({
			execute = function()
				local var_27_0 = g.core.module.ModuleManager:getCurModule()

				if var_27_0 and var_27_0.display and var_27_0.display:getName() == "StoryDialogLayer" then
					self:_jumpStory(1)
				end
			end
		})

		var_26_4:setQuickTrigger(true)
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_26_4)
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdUI.new({
			showUIPath = "FogNightmareExploreLayer:autoNode",
			UIPath = "FogNightmareExploreLayer:floopBgComp/" .. ((#var_26_1 > 1 or nil) and (var_26_3 == 1 and "leftButton" or "rightButton")),
			UIParam = {
				type = "comp"
			}
		})))

		local var_26_6 = FogNightmareCmdUI.new({
			UIPath = "FogNightmareExploreLayer:tipComp/btnConfirm",
			showUIPath = "FogNightmareExploreLayer:tipComp/autoNode",
			UIParam = {
				type = "comp"
			}
		})

		var_26_6:setQuickTrigger(true)
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_26_6)

		local var_26_7 = FogNightmareCmdNet.new({
			netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_CHOOSESTAGE
		})

		var_26_7:setQuickTrigger(true)
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_26_7)

		local var_26_8 = FogNightmareCmdBase.new({
			execute = function()
				if g.core.model.User.fogNightmareData:checkSkipBattle(self._curFloorId, var_26_1[var_26_3]) then
					g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():clearAllCmd()

					local var_28_0 = FogNightmareCmdNet.new({
						netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_RANDSEALS
					})

					var_28_0:setQuickTrigger(true)
					g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_28_0)
					g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdBase.new({
						execute = handler(self, self._doCheckNeedSelectKeepsake)
					})))
				end
			end
		})

		var_26_8:setQuickTrigger(true)
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_26_8)

		if var_26_2:getStoryId() ~= 0 and not var_26_2:isStoryIsRead() then
			self:_jumpStory()
		end

		if not var_26_2:isReadAllFrontTexts() and #var_26_2:getFrontTexts() > 0 then
			g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdUI.new({
				UIPath = "FogNightmareExploreLayer:stageComp/frontClickNode",
				executeTimes = 999,
				finish = handler(var_26_2, var_26_2.isReadAllFrontTexts),
				UIParam = {
					type = "comp"
				}
			})))
		end
	else
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdNet.new({
			netFunc = handler(g.core.network.GameNetProxy, g.core.network.GameNetProxy.send_C2S_Fog_ChooseStage),
			netParams = {
				floor = var_26_0:getFloorId(),
				stage = var_26_2:getStageId()
			},
			netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_CHOOSESTAGE
		})))
	end

	local var_26_9 = FogNightmareCmdBase.new({
		execute = handler(self, self._doWaveSelectAndPass)
	})

	var_26_9:setQuickTrigger(true)
	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_26_9)

	self._originLevel = g.core.model.User.fogNightmareData:getFogLevel()
	self._curMax = g.core.model.User.fogNightmareData:getTowerData():getCurrentMaxFloorNum()
	self._curFloorId = g.core.model.User.fogNightmareData:getTowerData():getCurrentFloorNum()
end

function FogNightmarePlayerBase:_jumpStory(arg_29_1)
	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(FogNightmareCmdUI.new({
		UIPath = "StoryDialogLayer:skipComp/skipBtn",
		UIParam = {
			type = "comp"
		}
	}), arg_29_1)

	arg_29_1 = arg_29_1 and arg_29_1 + 1

	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(FogNightmareCmdUI.new({
		UIPath = "StorySkipPop:okBtn",
		UIParam = {
			type = "comp"
		}
	}), arg_29_1)
end

function FogNightmarePlayerBase:_doWaveSelectAndPass()
	local var_30_0 = g.core.model.User.fogNightmareData:getTowerData():getCurFloorStruct():getSelectedStage()[1]
	local var_30_1
	local var_30_2 = 1

	for iter_30_0, iter_30_1 in ipairs((var_30_0:getAllWave())) do
		if not iter_30_1:isFinish() then
			var_30_1 = iter_30_1
			var_30_2 = iter_30_0

			break
		end
	end

	if var_30_1 then
		if self._isUsedUI then
			g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdUI.new({
				UIPath = "FogNightmareExploreLayer:stageComp/waveList",
				showUIPath = "FogNightmareExploreLayer:stageComp/autoNode",
				UIParam = {
					type = "comp"
				}
			})))
		end

		local var_30_3 = handler(self, self._monsterWavePass)

		var_30_0:setTempSelectWave(var_30_2)

		local var_30_4 = FogNightmareCmdBase.new({
			execute = ({
				var_30_3,
				var_30_3,
				var_30_3,
				handler(self, self._cureWavePass),
				handler(self, self._revivalWavePass),
				handler(self, self._choiceWavePass),
				handler(self, self._sacrificeWavePass)
			})[var_30_1:getType()],
			executeParams = {
				wave = var_30_1
			}
		})

		var_30_4:setQuickTrigger(true)
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_30_4)
	else
		local var_30_5 = FogNightmareCmdBase.new({
			execute = handler(self, self._doCheckNeedSelectKeepsake)
		})

		var_30_5:setQuickTrigger(true)
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_30_5)
	end
end

function FogNightmarePlayerBase:_monsterWavePass(arg_31_1)
	if self._isUsedUI then
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdUI.new({
			UIPath = "FogNightmareExploreLayer:stageComp/btnStage",
			UIParam = {
				type = "comp"
			}
		})))
	end

	local var_31_0 = FogNightmareCmdBase.new({
		execute = handler(self, self._doBattleStart)
	})

	var_31_0:setQuickTrigger(true)
	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_31_0)
end

function FogNightmarePlayerBase:_cureWavePass(arg_32_1)
	local var_32_0 = arg_32_1.wave

	if self._isUsedUI then
		local var_32_1 = {}

		table.insert(var_32_1, (FogNightmareCmdUI.new({
			UIPath = "FogNightmareExploreLayer:stageComp/btnStage",
			UIParam = {
				type = "comp"
			}
		})))
		table.insert(var_32_1, (FogNightmareCmdNet.new({
			netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_RECOVER
		})))
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdSub.new({
			cmdList = var_32_1
		})))

		local var_32_2 = FogNightmareCmdBase.new({
			execute = function()
				if var_32_0:getCurEffects()[1]:getRecoverKnights() then
					g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(FogNightmareCmdUI.new({
						UIPath = "FogNightmareKnightStatePop",
						showUIPath = "FogNightmareKnightStatePop:autoNode",
						execute = function()
							g.core.module.ModuleManager:popComponent()
						end,
						UIParam = {
							type = "comp"
						}
					}), 1)
				end
			end
		})

		var_32_2:setQuickTrigger(true)
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_32_2)
	else
		local var_32_3 = g.core.model.User.fogNightmareData:getTowerData():getCurFloorStruct()

		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdNet.new({
			netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_RECOVER,
			netFunc = handler(g.core.network.GameNetProxy, g.core.network.GameNetProxy.send_C2S_Fog_Recover),
			netParams = {
				floor = var_32_3:getFloorId(),
				stage = var_32_3:getSelectedStage()[1]:getStageId(),
				wave = arg_32_1.wave:getWaveId()
			}
		})))
	end

	local var_32_4 = FogNightmareCmdBase.new({
		execute = handler(self, self._doEnterNextFloor)
	})

	var_32_4:setQuickTrigger(true)
	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_32_4)
end

function FogNightmarePlayerBase:_revivalWavePass(arg_35_1)
	local var_35_0 = arg_35_1.wave

	if self._isUsedUI then
		local var_35_1 = {}

		table.insert(var_35_1, (FogNightmareCmdUI.new({
			UIPath = "FogNightmareExploreLayer:stageComp/btnStage",
			UIParam = {
				type = "comp"
			}
		})))
		table.insert(var_35_1, (FogNightmareCmdNet.new({
			netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_RECOVER
		})))
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdSub.new({
			cmdList = var_35_1
		})))

		local var_35_2 = FogNightmareCmdBase.new({
			execute = function()
				if var_35_0:getCurEffects()[1]:getRevivalKnights() then
					g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(FogNightmareCmdUI.new({
						UIPath = "FogNightmareKnightStatePop",
						showUIPath = "FogNightmareKnightStatePop:autoNode",
						execute = function()
							g.core.module.ModuleManager:popComponent()
						end,
						UIParam = {
							type = "comp"
						}
					}), 1)
				end
			end
		})

		var_35_2:setQuickTrigger(true)
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_35_2)
	else
		local var_35_3 = g.core.model.User.fogNightmareData:getTowerData():getCurFloorStruct()

		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdNet.new({
			netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_RECOVER,
			netFunc = handler(g.core.network.GameNetProxy, g.core.network.GameNetProxy.send_C2S_Fog_Recover),
			netParams = {
				floor = var_35_3:getFloorId(),
				stage = var_35_3:getSelectedStage()[1]:getStageId(),
				wave = arg_35_1.wave:getWaveId()
			}
		})))
	end

	local var_35_4 = FogNightmareCmdBase.new({
		execute = handler(self, self._doEnterNextFloor)
	})

	var_35_4:setQuickTrigger(true)
	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_35_4)
end

function FogNightmarePlayerBase:_sacrificeWavePass(arg_38_1)
	local var_38_0 = handler(self, self._doWaveSelectAndPass)

	if self._isUsedUI then
		local var_38_1 = {}

		table.insert(var_38_1, (FogNightmareCmdUI.new({
			UIPath = "FogNightmareExploreLayer:stageComp/btnCancel",
			UIParam = {
				type = "comp"
			}
		})))
		table.insert(var_38_1, (FogNightmareCmdNet.new({
			netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_DEMONCONVERT
		})))
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdSub.new({
			cmdList = var_38_1
		})))

		var_38_0 = handler(self, self._doEnterNextFloor)
	else
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdNet.new({
			netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_DEMONCONVERT,
			netFunc = handler(g.core.network.GameNetProxy, g.core.network.GameNetProxy.send_C2S_Fog_DemonConvert),
			netParams = {
				tp = true
			}
		})))
	end

	local var_38_2 = FogNightmareCmdBase.new({
		execute = var_38_0
	})

	var_38_2:setQuickTrigger(true)
	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_38_2)
end

function FogNightmarePlayerBase:_choiceWavePass(arg_39_1)
	local var_39_0 = arg_39_1.wave:getCurEffects()[1]:getSubEffects()
	local var_39_1

	for iter_39_0, iter_39_1 in ipairs(var_39_0) do
		if iter_39_1:getRealEffect():canChoice() then
			var_39_1 = iter_39_0

			break
		end
	end

	local var_39_2 = var_39_0[var_39_1]
	local var_39_3 = var_39_0[var_39_1]:getCfg().id

	if self._isUsedUI then
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdUI.new({
			UIPath = "FogNightmareExploreLayer:stageComp/childCompRoot/FogNightmareChoiceWaveTextItem/list",
			UIParam = {
				type = "list",
				selectIdx = var_39_1 - 1
			}
		})))

		local var_39_4 = FogNightmareCmdUI.new({
			UIPath = "FogNightmareExploreLayer:stageComp/btnStage",
			UIParam = {
				type = "comp"
			}
		})

		if var_39_3 ~= 3 and var_39_3 ~= 5 then
			local var_39_5 = {}

			table.insert(var_39_5, var_39_4)
			table.insert(var_39_5, (FogNightmareCmdNet.new({
				netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_MAKECHOICE
			})))
			g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdSub.new({
				cmdList = var_39_5
			})))
		else
			g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_39_4)
		end
	end

	;({
		handler(self, self._choiceSubRecoverPass),
		handler(self, self._choiceSubRevivalPass),
		handler(self, self._choiceSubKeepsakeUpPass),
		handler(self, self._choiceSubPassivePass),
		handler(self, self._choiceSubKeepsakeSelPass)
	})[var_39_3](var_39_2)
end

function FogNightmarePlayerBase:_choiceSubKeepsakeSelPass(arg_40_1)
	local var_40_0 = {
		netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_MAKECHOICE
	}

	if not self._isUsedUI then
		var_40_0.netFunc = handler(g.core.network.GameNetProxy, g.core.network.GameNetProxy.send_C2S_Fog_MakeChoice)
		var_40_0.netParams = {
			choice_id = arg_40_1:getCfg().id
		}
	end

	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdNet.new(var_40_0)))

	local var_40_1 = FogNightmareCmdBase.new({
		execute = handler(self, self._doWaveSelectAndPass)
	})

	var_40_1:setQuickTrigger(true)
	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_40_1)
end

function FogNightmarePlayerBase:_choiceSubKeepsakeUpPass(arg_41_1)
	if self._isUsedUI then
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdUI.new({
			UIPath = "FogNightmareExploreLayer:stageComp/childCompRoot/FogNightmareChoiceWaveTextItem/childNode/" .. "FogNightmareKnightChoseWaveComp/knightList",
			UIParam = {
				selectIdx = 0,
				type = "list"
			}
		})))

		local var_41_0 = {}

		table.insert(var_41_0, (FogNightmareCmdUI.new({
			UIPath = "FogNightmareExploreLayer:stageComp/btnStage",
			UIParam = {
				type = "comp"
			}
		})))
		table.insert(var_41_0, (FogNightmareCmdNet.new({
			netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_MAKECHOICE
		})))
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdSub.new({
			cmdList = var_41_0
		})))
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdUI.new({
			UIPath = "FogNightmareKeepsakeLevelUpPop",
			showUIPath = "FogNightmareKeepsakeLevelUpPop:autoNode",
			execute = function()
				g.core.module.ModuleManager:popComponent()
			end,
			UIParam = {
				type = "comp"
			}
		})))
	else
		local var_41_1 = arg_41_1:getRealEffect()
		local var_41_2 = {
			netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_MAKECHOICE,
			netFunc = handler(g.core.network.GameNetProxy, g.core.network.GameNetProxy.send_C2S_Fog_MakeChoice)
		}
		local var_41_3 = {
			choice_id = arg_41_1:getCfg().id
		}

		var_41_3.knight_id = var_41_1:getCanUpKnights()[1]:getServerId()
		var_41_2.netParams = var_41_3

		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdNet.new(var_41_2)))
	end

	local var_41_4 = FogNightmareCmdBase.new({
		execute = handler(self, self._doEnterNextFloor)
	})

	var_41_4:setQuickTrigger(true)
	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_41_4)
end

function FogNightmarePlayerBase:_choiceSubPassivePass(arg_43_1)
	if not self._isUsedUI then
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdNet.new({
			netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_MAKECHOICE,
			netFunc = handler(g.core.network.GameNetProxy, g.core.network.GameNetProxy.send_C2S_Fog_MakeChoice),
			netParams = {
				choice_id = arg_43_1:getCfg().id
			}
		})))
	end

	local var_43_0 = FogNightmareCmdBase.new({
		execute = handler(self, self._doEnterNextFloor)
	})

	var_43_0:setQuickTrigger(true)
	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_43_0)
end

function FogNightmarePlayerBase:_choiceSubRecoverPass(arg_44_1)
	if self._isUsedUI then
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdUI.new({
			UIPath = "FogNightmareExploreBlessPop",
			showUIPath = "FogNightmareExploreBlessPop:autoNode",
			execute = function()
				g.core.module.ModuleManager:popComponent()
			end,
			UIParam = {
				type = "comp"
			}
		})))
	else
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdNet.new({
			netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_MAKECHOICE,
			netFunc = handler(g.core.network.GameNetProxy, g.core.network.GameNetProxy.send_C2S_Fog_MakeChoice),
			netParams = {
				choice_id = arg_44_1:getCfg().id
			}
		})))
	end

	local var_44_0 = FogNightmareCmdBase.new({
		execute = handler(self, self._doEnterNextFloor)
	})

	var_44_0:setQuickTrigger(true)
	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_44_0)
end

function FogNightmarePlayerBase:_choiceSubRevivalPass(arg_46_1)
	if self._isUsedUI then
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdUI.new({
			UIPath = "FogNightmareKnightStatePop",
			showUIPath = "FogNightmareKnightStatePop:autoNode",
			execute = function()
				g.core.module.ModuleManager:popComponent()
			end,
			UIParam = {
				type = "comp"
			}
		})))
	else
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdNet.new({
			netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_MAKECHOICE,
			netFunc = handler(g.core.network.GameNetProxy, g.core.network.GameNetProxy.send_C2S_Fog_MakeChoice),
			netParams = {
				choice_id = arg_46_1:getCfg().id
			}
		})))
	end

	local var_46_0 = FogNightmareCmdBase.new({
		execute = handler(self, self._doEnterNextFloor)
	})

	var_46_0:setQuickTrigger(true)
	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_46_0)
end

function FogNightmarePlayerBase:_doCheckNeedSelectKeepsake()
	local var_48_0 = g.core.model.User.fogNightmareData:getTowerData()

	if not var_48_0:getCurFloorStruct():getSelectedStage()[1].checkCanSelectRandomKeepsake(var_48_0) then
		if g.core.model.User.fogNightmareData:getTalentData():getRandSealData() then
			local var_48_1 = FogNightmareCmdBase.new({
				trigger = function()
					local var_49_0 = g.core.model.User.fogNightmareData:getTalentData():getRandSealData()

					return var_49_0 and #var_49_0 > 0
				end,
				execute = handler(self, self._doSelectStageKeepsake)
			})

			var_48_1:setQuickTrigger(true)
			g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_48_1)

			goto label_48_0
		end
	end

	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdBase.new({
		execute = handler(self, self._doEnterNextFloor)
	})))

	::label_48_0::
end

function FogNightmarePlayerBase:_doSelectStageKeepsake()
	local var_50_0 = g.core.model.User.fogNightmareData:getTalentData():getRandSealData()
	local var_50_1 = math.max(1, self:_selectBestKeepsake(var_50_0))

	if self._isUsedUI then
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdUI.new({
			UIPath = "FogNightmareKeepsakeSelectPop:keepsakeList",
			trigger = function(self)
				return self:getNumItems() > 0
			end,
			UIParam = {
				type = "list",
				selectIdx = var_50_1 - 1
			}
		})))
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdUI.new({
			UIPath = "FogNightmareKeepsakeSelectPop:switchComp/confirmBtn",
			UIParam = {
				type = "comp"
			}
		})))
	else
		local var_50_2 = {
			netFunc = handler(g.core.network.GameNetProxy, g.core.network.GameNetProxy.send_C2S_Fog_ChooseSeal)
		}
		local var_50_3 = {
			knight_id = var_50_0[var_50_1].knight_id
		}

		var_50_3.seal_level_id = var_50_0[var_50_1].seal_level_id
		var_50_2.netParams = var_50_3
		var_50_2.netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_CHOOSESEAL

		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdNet.new(var_50_2)))
	end

	local var_50_4 = FogNightmareCmdBase.new({
		execute = handler(self, self._doEnterNextFloor)
	})

	var_50_4:setQuickTrigger(true)
	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_50_4)
end

function FogNightmarePlayerBase:_selectBestKeepsake(arg_52_1)
	local var_52_0 = -1

	for iter_52_0, iter_52_1 in ipairs(arg_52_1) do
		local var_52_1 = g.core.model.User.fogNightmareData:getKeepsakeData():getKeepsakeStructById(iter_52_1.seal_level_id):getCfg().power
		local var_52_2 = g.core.model.User.fogNightmareData:getFormationData()
		local var_52_3 = 0

		if var_52_2 then
			var_52_3 = var_52_2:getKnightByServerId(iter_52_1.knight_id):getDevelopStruct("keepsake"):getCfg().power
		end

		local var_52_4

		if -1 < var_52_1 - var_52_3 then
			var_52_0 = iter_52_0
			var_52_4 = var_52_1 - var_52_3
		end
	end

	return var_52_0
end

function FogNightmarePlayerBase:_doEnterNextFloor()
	if g.core.model.User.fogNightmareData:getTowerData():isMaxFloor() then
		g.core.model.User.fogNightmareData:getAutoPlay():stopAutoPlay(g.core.lang:get(500250))

		return
	end

	if not self._isUsedUI then
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdNet.new({
			netFunc = handler(g.core.network.GameNetProxy, g.core.network.GameNetProxy.send_C2S_Fog_NextFloor),
			netParams = {},
			netEventKey = g.core.event.enum.EVENT_NET_S2C_FOG_NEXTFLOOR
		})))
	else
		local var_53_0 = FogNightmareCmdBase.new({
			execute = function()
				local var_54_0 = g.core.module.ModuleManager:getCurModule()

				if var_54_0 and var_54_0.display and var_54_0.display:getName() == "FogNightmareExploreResultPop" then
					g.core.model.User.fogNightmareData:getAutoPlay():stopAutoPlay(g.core.lang:get(500250))
				end
			end
		})

		var_53_0:setQuickTrigger(true)
		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_53_0)

		if self._curFloorId > self._curMax and g.core.model.User.fogNightmareData:getTowerData():getHistoryMaxFloorNum() < self._curFloorId then
			local var_53_1 = FogNightmareCmdBase.new({
				trigger = function()
					return g.core.model.User.fogNightmareData:getFogTempLevel() ~= nil
				end,
				execute = function()
					local var_56_0 = g.core.model.User.fogNightmareData:getFogTempLevel()

					if var_56_0 > self._originLevel then
						g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(FogNightmareCmdUI.new({
							UIPath = "FogNightmareLevelUpPop:effComTitle",
							showUIPath = "FogNightmareLevelUpPop:autoNode",
							execute = function()
								g.core.module.ModuleManager:popComponent()
							end,
							UIParam = {
								type = "comp"
							}
						}), 1)

						if next((g.core.model.User.fogNightmareData:getSealListByLevel(var_56_0))) then
							g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(FogNightmareCmdUI.new({
								UIPath = "FogNightmareKeepsakeUnlockPop:effComTitle",
								showUIPath = "FogNightmareKeepsakeUnlockPop:autoNode",
								execute = function()
									g.core.module.ModuleManager:popComponent()
								end,
								UIParam = {
									type = "comp"
								}
							}), 2)
						end
					end
				end
			})

			var_53_1:setQuickTrigger(true)
			g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd(var_53_1)
		end

		g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdUI.new({
			UIPath = "FogNightmareExploreLayer:autoNode",
			UIParam = {
				type = "comp"
			}
		})))
	end

	g.core.model.User.fogNightmareData:getAutoPlay():getCmdManager():pushCmd((FogNightmareCmdBase.new({
		execute = handler(self, self._doSelectStage)
	})))
end

return FogNightmarePlayerBase
