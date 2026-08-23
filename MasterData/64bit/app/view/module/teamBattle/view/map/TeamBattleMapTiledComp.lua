local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleMapTiledComp = class("TeamBattleMapTiledComp", require("app.fairyGUI.teamBattle.UI_TeamBattleMapTiledComp"))

function TeamBattleMapTiledComp:ctor()
	self._info = nil
	self._floatInfo = {
		isDirty = false
	}

	self:_onInitTimeScale()

	self._iconEff = nil
end

function TeamBattleMapTiledComp:_onInitTimeScale()
	self.m_showTransition:setTimeScale(2)
	self.m_hideTransition:setTimeScale(2)
end

function TeamBattleMapTiledComp:getType()
	if not self._info then
		return "none"
	end

	return self._info.type
end

function TeamBattleMapTiledComp:updateCompView(arg_4_1)
	local var_4_0 = false

	self:setVisible(false)

	local var_4_1 = {}
	local var_4_2 = false
	local var_4_3 = arg_4_1.changeInfo

	self:_removeIconEff()

	if arg_4_1.type == "barrier" then
		self:_setIconURL("ui://teamBattle/" .. arg_4_1.value)

		if arg_4_1.valueEx == 1 then
			var_4_2 = true

			self:setVisible(true)
		elseif arg_4_1.valueEx == 2 then
			self:setVisible(true)
		end
	else
		local var_4_4 = arg_4_1.value
		local var_4_5 = arg_4_1.value:getEventInfo()
		local var_4_6 = arg_4_1.value:getEventType()

		if arg_4_1.value:getState() >= TeamBattleConst.MAP.TILED_STATE_UNLOCK then
			local var_4_7 = var_4_4:getUIInfo()

			if var_4_4:getState() == TeamBattleConst.MAP.TILED_STATE_UNLOCK then
				var_4_2 = true
			elseif var_4_7.url and #var_4_7.url > 1 then
				if var_4_6 == TeamBattleConst.EVENT_TYPE.BUFF then
					self:playIconEff(2)
				elseif var_4_6 >= TeamBattleConst.EVENT_TYPE.GAME_METEOR_SHOWER then
					self:playIconEff(1)
				end
			end

			local var_4_8 = var_4_7.knightInfo

			if var_4_7.knightInfo and var_4_8.resId then
				if var_4_5:getState() == TeamBattleConst.EVENT_STATE.FINISH then
					local var_4_9 = 0

					if var_4_8.needPlayDied then
						var_4_1.type = "TeamBattleMapKnightComp"
						var_4_1.info = var_4_8
						var_4_1.info.isHide = var_4_2
						var_4_1.info.changeInfo = var_4_3
						var_4_9 = 1.5
					end

					if var_4_5:getEventType() == TeamBattleConst.EVENT_TYPE.GUARD then
						if not g.core.model.User.teamBattleData:getMapData():isLastGuardTiled(var_4_4) then
							var_4_0 = true
							var_4_1.type = "TeamBattleTiledShopNameComp"
							var_4_1.info = {
								hideBg = true,
								text = g.core.lang:get(427162)
							}
							var_4_1.info.isHide = var_4_2
							var_4_1.info.changeInfo = var_4_3

							self:newScheduleOnce(handler(self, self.playTelportEff), var_4_9)
						end
					end
				else
					var_4_1.type = "TeamBattleMapKnightComp"
					var_4_1.info = var_4_8
					var_4_1.info.isHide = var_4_2
					var_4_1.info.changeInfo = var_4_3
				end
			end

			self:_setIconURL(var_4_7.url)

			if var_4_6 == TeamBattleConst.EVENT_TYPE.KNIGHT_SHOP or var_4_6 == TeamBattleConst.EVENT_TYPE.BUFF_SHOP then
				var_4_1.type = "TeamBattleTiledShopNameComp"
				var_4_1.info = {
					text = var_4_4:getEventName()
				}
				var_4_1.info.isHide = var_4_2
				var_4_1.info.changeInfo = var_4_3
			end

			self:setVisible(true)
		end
	end

	if not var_4_0 then
		self:_removeTelportEff()
	end

	self._info = arg_4_1

	self:_updateFloatComp(var_4_1)

	if not self.inUpAction and not var_4_3 then
		if var_4_2 then
			self.m_hideEndTransition:play()
		else
			self.m_showEndTransition:play()
		end
	end

	self._playChangeAction(self, var_4_3, self)
end

function TeamBattleMapTiledComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_TEAM_BATTLE_EVENT_FINISH, self._onUpdateSelf, self)
end

function TeamBattleMapTiledComp:_onUpdateSelf()
	if self._info then
		self:updateCompView(self._info)
	end
end

function TeamBattleMapTiledComp:getFloatInfo()
	return self._floatInfo
end

function TeamBattleMapTiledComp:_updateFloatComp(arg_8_1)
	if self._floatInfo.node then
		if arg_8_1.type ~= self._floatInfo.node:getName() then
			self:dispatchCompEvent("pushFloatComp", self._floatInfo)

			self._floatInfo.node = nil
			self._floatInfo.isDirty = next(arg_8_1)
			self._floatInfo.param = arg_8_1
		elseif arg_8_1.type == "TeamBattleMapKnightComp" and arg_8_1.info.resId ~= self._floatInfo.node:getResId() then
			self:dispatchCompEvent("pushFloatComp", self._floatInfo)

			self._floatInfo.node = nil
			self._floatInfo.isDirty = next(arg_8_1)
			self._floatInfo.param = arg_8_1
		else
			self:setAndUpdateFloatComp(self._floatInfo.node, arg_8_1)
		end
	elseif next(arg_8_1) then
		self._floatInfo.node = nil
		self._floatInfo.isDirty = next(arg_8_1)
		self._floatInfo.param = arg_8_1
	end
end

function TeamBattleMapTiledComp:clearFloatInfo()
	if self._floatInfo.node then
		self:dispatchCompEvent("pushFloatComp", self._floatInfo)
	end

	self._floatInfo = {
		isDirty = false
	}
end

function TeamBattleMapTiledComp:setAndUpdateFloatComp(arg_10_1, arg_10_2)
	local var_10_0 = self:getPosition()
	local var_10_1 = self:displayObject():getLocalZOrder()
	local var_10_2 = false

	if arg_10_2.type == "TeamBattleMapKnightComp" then
		arg_10_1:updateKnight(arg_10_2.info)
		arg_10_1:displayObject():setLocalZOrder(var_10_1)
		arg_10_1:setVisible(true)

		var_10_2 = true
	elseif arg_10_2.type == "TeamBattleTiledShopNameComp" then
		arg_10_1:setTitle(arg_10_2.info.text)
		arg_10_1:getChild("bgPic"):setVisible(not arg_10_2.info.hideBg)

		var_10_0.y = var_10_0.y + 26

		arg_10_1:displayObject():setLocalZOrder(var_10_1 + 2)
	end

	if not arg_10_1.inUpAction then
		if arg_10_2.info.isHide then
			arg_10_1:getTransition("hideEnd"):play()
		else
			arg_10_1:getTransition("showEnd"):play()
		end

		if var_10_2 then
			arg_10_1:setOpacity(255)
			arg_10_1:setKnightBlack(arg_10_2.info.isHide)
		end
	end

	self:_playChangeAction(arg_10_2.info.changeInfo, arg_10_1, var_10_2)
	arg_10_1:setPosition(var_10_0)

	self._floatInfo.param = arg_10_2
	self._floatInfo.node = arg_10_1
	self._floatInfo.isDirty = false
end

function TeamBattleMapTiledComp:_setIconURL(arg_11_1)
	if arg_11_1 and #arg_11_1 > 1 then
		self.m_icon:setURL(arg_11_1)
		self.m_icon:setVisible(true)
	else
		self.m_icon:setVisible(false)
	end
end

function TeamBattleMapTiledComp:getIconTiledSize()
	local var_12_0 = self.m_icon:getSize()

	return (cc.size(math.ceil(var_12_0.width / 210), math.ceil(var_12_0.height / 210)))
end

function TeamBattleMapTiledComp:onSingleClick(arg_13_1)
	if type(self._info.value) ~= "table" then
		self:_onClickEmptyTiled(arg_13_1)
	else
		self:_onClickTiled(arg_13_1)
	end
end

function TeamBattleMapTiledComp:_onClickEmptyTiled(arg_14_1)
	if not arg_14_1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(420656))

		return
	end

	self:dispatchCompEvent("clickEmptyTiled", {
		info = self._info,
		routePath = arg_14_1
	})
end

function TeamBattleMapTiledComp:_onClickTiled(arg_15_1)
	if not arg_15_1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(420656))

		return
	end

	local var_15_0 = self._info.value
	local var_15_1 = self._info.value:getEventType(true)
	local var_15_2 = self._info.value:getEventInfo()

	if var_15_2 and not var_15_2:canTriggerEvent() then
		g.core.module.ModuleManager:tip(g.core.lang:get(427114))

		return
	end

	local var_15_4 = ""
	local var_15_5
	local var_15_6 = not arg_15_1 and g.core.lang:get(420656) or nil

	if var_15_1 == TeamBattleConst.EVENT_TYPE.ROBBER or var_15_1 == TeamBattleConst.EVENT_TYPE.GUARD then
		if var_15_1 == TeamBattleConst.EVENT_TYPE.GUARD then
			local var_15_7 = 0
			local var_15_8 = 0
			local var_15_9 = g.core.model.User.teamBattleData:getMapData():getRoomStructByRoomId(var_15_2:getEventInfo().room):getTiledStructList(function(arg_16_0)
				local var_16_0 = arg_16_0:getEventInfo()

				if var_16_0 and var_16_0:getEventType() == TeamBattleConst.EVENT_TYPE.ROBBER then
					var_15_7 = var_15_7 + 1

					if var_16_0:getState() == TeamBattleConst.EVENT_STATE.FINISH then
						var_15_8 = var_15_8 + 1
					end
				end
			end)

			if 0 < 0 then
				var_15_6 = g.core.lang:get(427132)
			end
		end

		var_15_4 = "clickMonster"
		var_15_5 = {
			value = self._info.value,
			routePath = arg_15_1
		}
	elseif var_15_1 == TeamBattleConst.EVENT_TYPE.LIMIT_BOSS1 or var_15_1 == TeamBattleConst.EVENT_TYPE.LIMIT_BOSS2 then
		if var_15_2:getState() ~= TeamBattleConst.EVENT_STATE.FINISH then
			local var_15_11 = var_15_2:getBindUid()

			if not var_15_2:isInTime() then
				var_15_6 = g.core.lang:get(427130)
			elseif var_15_2:isKillOtherBoss() then
				var_15_6 = g.core.lang:get(427134)
			elseif var_15_11 ~= 0 and not var_15_2:checkBindUidIsSelf() then
				local var_15_13 = g.core.model.User.teamBattleData:getMapData():getPlayerStruct(var_15_11):getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER)

				var_15_6 = g.core.lang:get(427160, {
					name = (var_15_13 or nil) and var_15_13.name
				})
			end

			var_15_4 = "clickBoss"
			var_15_5 = {
				value = self._info.value,
				routePath = arg_15_1
			}
		else
			var_15_4 = "clickMoveTiled"
			var_15_5 = {
				value = self._info.value,
				routePath = arg_15_1
			}
		end
	elseif var_15_1 == TeamBattleConst.EVENT_TYPE.MINING then
		var_15_4 = "clickMine"
		var_15_5 = {
			value = self._info.value,
			routePath = arg_15_1
		}
	elseif var_15_1 == TeamBattleConst.EVENT_TYPE.NONE then
		if var_15_0:getEventType() == TeamBattleConst.EVENT_TYPE.GUARD then
			if not g.core.model.User.teamBattleData:getMapData():isLastGuardTiled(var_15_0) then
				var_15_4 = "clickMoveTelPort"
				var_15_5 = {
					value = self._info.value,
					routePath = arg_15_1
				}

				goto label_15_0
			end
		end

		var_15_4 = "clickMoveTiled"
		var_15_5 = {
			value = self._info.value,
			routePath = arg_15_1
		}
	elseif var_15_1 == TeamBattleConst.EVENT_TYPE.BUFF then
		var_15_4 = "clickBuff"
		var_15_5 = {
			value = self._info.value,
			routePath = arg_15_1
		}
	elseif var_15_1 == TeamBattleConst.EVENT_TYPE.GAME_METEOR_SHOWER or var_15_1 == TeamBattleConst.EVENT_TYPE.GAME_TURN_CARD or var_15_1 == TeamBattleConst.EVENT_TYPE.GAME_DART then
		if var_15_2:getState() == TeamBattleConst.EVENT_STATE.WAIT_TRIGGER then
			var_15_4 = "clickMoveTiled"
			var_15_5 = {
				value = self._info.value,
				routePath = arg_15_1
			}
		else
			var_15_4 = "clickGame"
			var_15_5 = {
				value = self._info.value,
				routePath = arg_15_1
			}
		end
	elseif var_15_1 == TeamBattleConst.EVENT_TYPE.TEL_PORT then
		self:dispatchCompEvent("clickEmptyTiled", {
			info = self._info,
			routePath = arg_15_1
		})
	elseif var_15_1 == TeamBattleConst.EVENT_TYPE.RECOVER then
		local var_15_18 = {}

		for iter_15_0, iter_15_1 in ipairs((g.core.model.User.teamBattleData:getFormationData():getAllKnightList())) do
			local var_15_19 = iter_15_1:getHpRatio()

			if var_15_19 > 0 and var_15_19 < 1000 then
				var_15_18[#var_15_18 + 1] = iter_15_1
			end
		end

		if #var_15_18 < 1 then
			var_15_6 = g.core.lang:get(427122)
		end

		var_15_4 = "clickRecover"
		var_15_5 = {
			value = self._info.value,
			routePath = arg_15_1
		}
	elseif var_15_1 == TeamBattleConst.EVENT_TYPE.REVIVAL then
		local var_15_20 = {}

		for iter_15_2, iter_15_3 in ipairs((g.core.model.User.teamBattleData:getFormationData():getAllKnightList())) do
			if iter_15_3:getHpRatio() <= 0 then
				var_15_20[#var_15_20 + 1] = iter_15_3
			end
		end

		if #var_15_20 < 1 then
			var_15_6 = g.core.lang:get(427133)
		end

		var_15_4 = "clickRevival"
		var_15_5 = {
			value = self._info.value,
			routePath = arg_15_1
		}
	elseif var_15_1 == TeamBattleConst.EVENT_TYPE.TRAPPED then
		var_15_4 = "clickMoveTiled"
		var_15_5 = {
			value = self._info.value,
			routePath = arg_15_1
		}
	else
		local var_15_21, var_15_22 = g.core.model.User.teamBattleData:getMapData():isShopFull(var_15_1)

		if var_15_21 then
			var_15_6 = g.core.lang:get(var_15_22)
		end

		var_15_4 = "clickMoveShop"
		var_15_5 = {
			value = self._info.value,
			routePath = arg_15_1
		}
	end

	::label_15_0::

	if var_15_6 then
		g.core.module.ModuleManager:tip(var_15_6)

		return
	else
		self:dispatchCompEvent(var_15_4, var_15_5)
	end
end

function TeamBattleMapTiledComp:_removeAllEffectNode()
	self.m_effectNode:removeAllEffect()
	self.m_effectNode2:removeAllEffect()

	self._telEff = nil
	self._iconEff = nil
end

function TeamBattleMapTiledComp:_removeIconEff()
	self.m_effectNode2:removeAllEffect()
end

function TeamBattleMapTiledComp:_removeTelportEff()
	if self._telEff then
		self._telEff:removeFromParent()
	end

	self._telEff = nil
end

function TeamBattleMapTiledComp:playTelportEff()
	if self._telEff then
		return
	end

	self:_removeAllEffectNode()

	self._telEff = self.m_effectNode:addEffectSpine({
		name = "eff_ui_teamBattle_transmit",
		isLoop = true,
		anim = "play"
	})
end

function TeamBattleMapTiledComp:playIconEff(arg_21_1)
	self:_removeAllEffectNode()

	self._iconEff = self.m_effectNode2:addEffectSpine({
		isLoop = true,
		anim = "play",
		name = table.concat({
			"eff_ui_teamBattle_iconLoop",
			arg_21_1
		})
	})
end

function TeamBattleMapTiledComp:playMineEff(arg_22_1)
	self:_removeAllEffectNode()
	self.m_effectNode:addEffectSpine({
		name = "eff_ui_teamBattle_mining",
		remove = true,
		isLoop = false,
		anim = "play",
		eventHandler = function(self, arg_23_1)
			if require("app.view.battle.const.BattleConst").SPINE_EVENT.COMPLETE == self.type and self._animName and arg_22_1 then
				arg_22_1()
			end
		end
	})
end

function TeamBattleMapTiledComp:_playChangeAction(arg_24_1, arg_24_2, arg_24_3)
	if arg_24_1 then
		if arg_24_1.showStr == "show" then
			arg_24_2:getTransition("show"):play()

			if arg_24_3 then
				arg_24_2:setKnightBlackAnim(false)
			end
		elseif arg_24_1.showStr == "hide" then
			arg_24_2:getTransition("hide"):play()

			if arg_24_3 then
				arg_24_2:setKnightBlackAnim(true)
			end
		elseif arg_24_1.showStr == "up" then
			arg_24_2.inUpAction = true

			arg_24_2:setVisible(true)
			arg_24_2:setOpacity(0)
			g.core.common.Scheduler:newScheduleOnce(handler(arg_24_2, function(arg_25_0)
				if tolua.isnull(arg_24_2) then
					return
				end

				arg_24_2:getTransition("up"):play(function()
					arg_24_2.inUpAction = false
				end)
			end), 0.6 + arg_24_1.timeLevel * TeamBattleConst.MAP.TILED_SHOW_EFFECT_DELTA)
		end
	end
end

return TeamBattleMapTiledComp
