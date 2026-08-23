local ExplorationConst = require("app.view.module.exploration.const.ExplorationConst")
local ExplorationMapTiledComp = class("ExplorationMapTiledComp", require("app.fairyGUI.exploration.UI_ExplorationMapTiledComp"))

function ExplorationMapTiledComp:ctor()
	self._info = nil
	self._floatInfo = {
		isDirty = false
	}
end

function ExplorationMapTiledComp:getType()
	if not self._info then
		return "none"
	end

	return self._info.type
end

function ExplorationMapTiledComp:updateCompView(arg_3_1)
	local var_3_0 = {}

	if arg_3_1.type == "barrier" then
		self.m_barrierBgIcon:setURL("ui://exploration/pic_bg_slmj_gezi1")
		self:_setIconURL("ui://exploration/" .. arg_3_1.value)

		if arg_3_1.valueEx then
			self.m_icon:setColor(cc.c3b(255, 255, 255))
			self.m_barrierBgIcon:setVisible(false)
		else
			self.m_icon:setColor(cc.c3b(100, 100, 100))
			self.m_barrierBgIcon:setVisible(true)
		end
	else
		self.m_barrierBgIcon:setVisible(false)
		self.m_icon:setColor(cc.c3b(255, 255, 255))

		local var_3_1 = arg_3_1.value

		if arg_3_1.value:getState() == ExplorationConst.MAP.TILED_STATE_UNLOCK then
			local var_3_2 = var_3_1:getEventType()

			if var_3_2 == ExplorationConst.EVENT_TYPE.GUARD or var_3_2 == ExplorationConst.EVENT_TYPE.ROBBER then
				var_3_0.info, var_3_0.type = var_3_1:getTiledMonster(), "ExplorationMapKnightComp"

				self:_setIconURL("")
			elseif var_3_2 == ExplorationConst.EVENT_TYPE.ULTIMATUM then
				if not var_3_1:getEventInfo().unique_id then
					var_3_0.info, var_3_0.type = var_3_1:getTiledMonster(), "ExplorationMapKnightComp"

					self:_setIconURL("")
				else
					self:_setIconURL(var_3_1:getPicId())
				end

				self:newScheduleOnce(handler(self, function(arg_4_0)
					arg_4_0:dispatchCompEvent("updateMirrorEffect")
				end))
			else
				local var_3_3 = var_3_1:getTiledMonsterAndReset()

				if var_3_3 ~= nil then
					var_3_3.needPlayDied = true
					var_3_0.type = "ExplorationMapKnightComp"
					var_3_0.info = var_3_3
				end

				self:_setIconURL(var_3_1:getPicId())
			end

			if var_3_2 >= ExplorationConst.EVENT_TYPE.KNIGHT_SHOP and var_3_2 <= ExplorationConst.EVENT_TYPE.ARTIFACT_SHOP then
				var_3_0.type = "ExplorationTiledNameComp"
				var_3_0.info = {
					text = var_3_1:getEventName()
				}
			end
		else
			self:_setIconURL("ui://exploration/pic_bg_slmj_gezi" .. var_3_1:getState() + 1)
		end
	end

	self._info = arg_3_1

	self:_updateFloatComp(var_3_0)
end

function ExplorationMapTiledComp:getFloatInfo()
	return self._floatInfo
end

function ExplorationMapTiledComp:_updateFloatComp(arg_6_1)
	if self._floatInfo.node then
		if arg_6_1.type ~= self._floatInfo.node:getName() then
			self:dispatchCompEvent("pushFloatComp", self._floatInfo)

			self._floatInfo.node = nil
			self._floatInfo.isDirty = next(arg_6_1)
			self._floatInfo.param = arg_6_1
		elseif arg_6_1.type == "ExplorationMapKnightComp" and arg_6_1.info.resId ~= self._floatInfo.node:getResId() then
			self:dispatchCompEvent("pushFloatComp", self._floatInfo)

			self._floatInfo.node = nil
			self._floatInfo.isDirty = next(arg_6_1)
			self._floatInfo.param = arg_6_1
		else
			self:setAndUpdateFloatComp(self._floatInfo.node, arg_6_1)
		end
	elseif next(arg_6_1) then
		self._floatInfo.node = nil
		self._floatInfo.isDirty = next(arg_6_1)
		self._floatInfo.param = arg_6_1
	end
end

function ExplorationMapTiledComp:setAndUpdateFloatComp(arg_7_1, arg_7_2)
	local var_7_0 = self:getPosition()
	local var_7_1 = self:displayObject():getLocalZOrder()

	if arg_7_2.type == "ExplorationMapKnightComp" then
		arg_7_1:updateKnight(arg_7_2.info)
		arg_7_1:displayObject():setLocalZOrder(var_7_1)
		arg_7_1:setVisible(true)
	elseif arg_7_2.type == "ExplorationTiledNameComp" then
		arg_7_1:setTitle(arg_7_2.info.text)

		var_7_0.y = var_7_0.y + 26

		arg_7_1:displayObject():setLocalZOrder(var_7_1 + 2)
	end

	arg_7_1:setPosition(var_7_0)

	self._floatInfo.param = arg_7_2
	self._floatInfo.node = arg_7_1
	self._floatInfo.isDirty = false
end

function ExplorationMapTiledComp:_setIconURL(arg_8_1)
	if arg_8_1 and #arg_8_1 > 1 then
		self.m_icon:setURL(arg_8_1)
		self.m_icon:setVisible(true)
	else
		self.m_icon:setVisible(false)
	end
end

function ExplorationMapTiledComp:onSingleClick(arg_9_1)
	local var_9_0 = self._info.value:getEventType()
	local var_9_2 = ""
	local var_9_3
	local var_9_4 = not arg_9_1 and g.core.lang:get(420656) or nil

	if var_9_0 == ExplorationConst.EVENT_TYPE.GUARD or var_9_0 == ExplorationConst.EVENT_TYPE.ROBBER then
		local var_9_5, var_9_6 = g.core.model.User.explorationData:getMapData():isShopFull(ExplorationConst.EVENT_TYPE.KNIGHT_SHOP)

		if var_9_5 then
			g.core.module.ModuleManager:tip(g.core.lang:get(var_9_6))

			return
		end

		var_9_2 = "clickMonster"
		var_9_3 = {
			value = self._info.value,
			routePath = arg_9_1
		}
	elseif var_9_0 == ExplorationConst.EVENT_TYPE.ULTIMATUM then
		var_9_2 = "clickMirror"
		var_9_3 = {
			value = self._info.value,
			routePath = arg_9_1
		}
		var_9_4 = nil
	elseif var_9_0 == ExplorationConst.EVENT_TYPE.NONE or var_9_0 == ExplorationConst.EVENT_TYPE.RANDOM then
		var_9_2 = "clickMoveTiled"
		var_9_3 = {
			value = self._info.value,
			routePath = arg_9_1
		}
	elseif var_9_0 == ExplorationConst.EVENT_TYPE.TYPE_BUFF then
		var_9_2 = "clickBuff"
		var_9_3 = {
			value = self._info.value,
			routePath = arg_9_1
		}
	elseif var_9_0 == ExplorationConst.EVENT_TYPE.GAME_FLOP or var_9_0 == ExplorationConst.EVENT_TYPE.GAME_TURNTABLE or var_9_0 == ExplorationConst.EVENT_TYPE.GAME_WALLET then
		if arg_9_1 and #arg_9_1 == 0 then
			var_9_2 = "clickGame"
			var_9_3 = {
				value = self._info.value,
				routePath = arg_9_1
			}
		else
			var_9_2 = "clickMoveTiled"
			var_9_3 = {
				value = self._info.value,
				routePath = arg_9_1
			}
		end
	elseif var_9_0 == ExplorationConst.EVENT_TYPE.TIP_TASK then
		if arg_9_1 and #arg_9_1 == 0 then
			var_9_2 = "triggerTask"
			var_9_3 = {
				value = self._info.value,
				routePath = arg_9_1
			}
		else
			var_9_2 = "clickMoveTiled"
			var_9_3 = {
				value = self._info.value,
				routePath = arg_9_1
			}
		end
	else
		local var_9_12, var_9_13 = g.core.model.User.explorationData:getMapData():isShopFull(var_9_0)

		if var_9_12 then
			var_9_4 = g.core.lang:get(var_9_13)
		end

		var_9_2 = "clickMoveShop"
		var_9_3 = {
			value = self._info.value,
			routePath = arg_9_1
		}
	end

	if var_9_4 then
		g.core.module.ModuleManager:tip(var_9_4)

		return
	else
		self:dispatchCompEvent(var_9_2, var_9_3)
	end
end

return ExplorationMapTiledComp
