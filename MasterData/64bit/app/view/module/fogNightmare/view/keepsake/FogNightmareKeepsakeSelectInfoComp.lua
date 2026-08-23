local FogNightmareKeepsakeSelectInfoComp = class("FogNightmareKeepsakeSelectInfoComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareKeepsakeSelectInfoComp"))
local var_0_1 = g.core.model.User.fogNightmareData

function FogNightmareKeepsakeSelectInfoComp:ctor()
	self.m_confirmBtn:addEventListener(fgui.UIEventType.Click, handler(self, self._onConfirm))
end

function FogNightmareKeepsakeSelectInfoComp:updateView(arg_2_1)
	self._knightId = arg_2_1.knightId
	self._nextSealId = arg_2_1.sealId
	self._worldPos = arg_2_1.worldPos
	self._struct = arg_2_1.struct
	self._curKnightStruct = var_0_1:getFormationData():getKnightByServerId(self._knightId)

	local var_2_0 = self._curKnightStruct:getDevelopStruct("keepsake")

	self.m_changeController:setSelectedIndex(0)
	self.m_powerChangeController:setSelectedIndex(0)

	self.nextStruct = var_0_1:getKeepsakeData():getKeepsakeStructById(self._nextSealId)

	local var_2_1 = self.nextStruct:getCfg().power
	local var_2_2 = self.nextStruct:getBaseInfo().suit_id
	local var_2_3 = var_0_1:getKeepsakeData():getSuitInfo(var_2_2)

	if var_2_3 then
		local var_2_4 = var_2_3:getActiveKeepsakeNum()
		local var_2_5 = 1

		if var_2_0 then
			if var_0_1:getKeepsakeData():getKeepsakeStructById(var_2_0.id):getBaseInfo().suit_id == var_2_2 then
				var_2_5 = 0
			end
		end

		local var_2_6 = var_2_3:getActiveInfo(var_2_4 + var_2_5)

		if var_2_6 then
			var_2_1 = var_2_1 + var_2_6.totalPower
		end

		self.m_nextSuitIcon:setURL(g.core.common.Path:getFogNightmareKeepsakeSuitPicRes(var_2_3:getCfg().icon))
		self.m_nextSuitNameText:setText(g.core.lang:get(500235, {
			name = var_2_3:getCfg().name,
			activeNum = var_2_4 + var_2_5,
			max = var_2_3:getEffectInfoByIndex(var_2_3:getActiveNum() + 1).targetNum
		}))

		local var_2_7 = self.m_nextSuitNameText:getSize()

		var_2_7.width = var_2_7.width + self.m_nextSuitIcon:getSize().width * (self.m_nextSuitIcon:getScale().x / 2 + 0.5)

		local var_2_8 = self.m_nextIcon:getPosition()

		var_2_8.x = var_2_8.x - var_2_7.width / 2
		var_2_8.y = self.m_nextSuitGroup:getPosition().y

		self.m_nextSuitGroup:setPosition(var_2_8)
		self.m_nextSuitGroup:setVisible(true)
	else
		self.m_nextSuitGroup:setVisible(false)
	end

	self.m_txtPower:setText(g.core.lang:get(500226, {
		power = var_2_1
	}))
	self.m_curSuitGroup:setVisible(false)

	if var_2_0 then
		self.m_changeController:setSelectedIndex(1)

		self._curSealId = var_2_0.id

		self.m_curIcon:updateIconById(self._curSealId)

		self.curStruct = var_0_1:getKeepsakeData():getKeepsakeStructById(self._curSealId)

		local var_2_10 = var_0_1:getKeepsakeData():getSuitInfo(self.curStruct:getBaseInfo().suit_id)

		self.m_curIcon:updateIconLv(self.curStruct:getCfg().level)

		local var_2_11 = self.curStruct:getCfg().power

		if var_2_10 then
			var_2_11 = var_2_11 + var_2_10:getPower()

			self.m_curSuitIcon:setURL(g.core.common.Path:getFogNightmareKeepsakeSuitPicRes(var_2_10:getCfg().icon))
			self.m_curSuitNameText:setText(g.core.lang:get(500235, {
				name = var_2_10:getCfg().name,
				activeNum = var_2_10:getActiveKeepsakeNum(),
				max = var_2_10:getEffectInfoByIndex(math.max(1, (var_2_10:getActiveNum()))).targetNum
			}))

			local var_2_12 = self.m_curSuitNameText:getSize()

			var_2_12.width = var_2_12.width + self.m_curSuitIcon:getSize().width * (self.m_curSuitIcon:getScale().x / 2 + 0.5)

			local var_2_13 = self.m_curIcon:getPosition()

			var_2_13.x = var_2_13.x - var_2_12.width / 2
			var_2_13.y = self.m_curSuitGroup:getPosition().y

			self.m_curSuitGroup:setPosition(var_2_13)
			self.m_curSuitGroup:setVisible(true)
		end

		self.m_nextIcon:updateIconById(self._nextSealId)

		self.nextStruct = var_0_1:getKeepsakeData():getKeepsakeStructById(self._nextSealId)

		self.m_nextIcon:updateIconLv(self.nextStruct:getCfg().level)

		local var_2_14 = 500136
		local var_2_15 = var_2_1 - var_2_11

		self.m_powerChangeController:setSelectedIndex(0)

		if var_2_1 == var_2_11 then
			var_2_14 = 500152

			self.m_powerChangeController:setSelectedIndex(2)
		elseif var_2_1 < var_2_11 then
			var_2_14 = 500153

			self.m_powerChangeController:setSelectedIndex(1)

			var_2_15 = var_2_11 - var_2_1
		end

		if var_2_15 > 0 then
			self.m_txtPower:setText(g.core.lang:get(var_2_14, {
				power = var_2_15
			}))
		elseif var_2_15 == 0 then
			self.m_txtPower:setText(g.core.lang:get(500202))
		end

		self:_updateSuitChangeTipText(var_2_10, var_2_3)
	end
end

function FogNightmareKeepsakeSelectInfoComp:_updateSuitChangeTipText(arg_3_1, arg_3_2)
	local var_3_0 = ""
	local var_3_1 = g.core.common.Color.A3

	if not arg_3_1 and not arg_3_2 then
		-- block empty
	elseif arg_3_1 and not arg_3_2 then
		local var_3_2, var_3_3 = arg_3_1:getActiveInfo(arg_3_1:getActiveKeepsakeNum() - 1)

		if var_3_3 < arg_3_1:getActiveNum() then
			var_3_0 = g.core.lang:get(500244)
			var_3_1 = g.core.common.Color.A7
		end
	elseif arg_3_2 and not arg_3_1 then
		local var_3_4, var_3_5 = arg_3_2:getActiveInfo(arg_3_2:getActiveKeepsakeNum() + 1)

		if var_3_5 > arg_3_2:getActiveNum() then
			var_3_0 = g.core.lang:get(500245)
			var_3_1 = g.core.common.Color.A5
		end
	elseif arg_3_1:getCfg().id ~= arg_3_2:getCfg().id then
		local var_3_6, var_3_7 = arg_3_1:getActiveInfo(arg_3_1:getActiveKeepsakeNum() - 1)
		local var_3_8 = arg_3_1:getActiveNum() ~= var_3_7
		local var_3_9, var_3_10 = arg_3_2:getActiveInfo(arg_3_2:getActiveKeepsakeNum() + 1)
		local var_3_11 = var_3_10 ~= arg_3_2:getActiveNum()

		if var_3_8 and var_3_11 then
			var_3_0 = g.core.lang:get(500243)
		elseif var_3_8 and not var_3_11 then
			var_3_0 = g.core.lang:get(500244)
			var_3_1 = g.core.common.Color.A7
		elseif not var_3_8 and var_3_11 then
			var_3_0 = g.core.lang:get(500245)
			var_3_1 = g.core.common.Color.A8
		end
	end

	self.m_suitChangeTipText:setText(var_3_0)
	self.m_suitChangeTipText:getChild("title"):setColor(var_3_1)

	if #var_3_0 > 0 then
		local var_3_12 = self.m_suitChangeTipText:getSize()
		local var_3_13 = self.m_suitChangeTipText:getChild("title")
		local var_3_14 = var_3_13:getPosition()
		local var_3_15 = var_3_13:getSize()
		local var_3_16 = self.m_suitChangeTipText:getTransition("runAction")

		var_3_16:stop()

		if var_3_15.width - var_3_12.width > 0 then
			var_3_16:setValue("left", {
				var_3_12.width / 2 - (var_3_15.width - var_3_12.width),
				var_3_14.y
			})
			var_3_16:setValue("right", {
				var_3_12.width / 2 + (var_3_15.width - var_3_12.width),
				var_3_14.y
			})
			var_3_16:play()
			var_3_16:changePlayTimes(999)
		else
			var_3_14.x = var_3_12.width / 2

			var_3_13:setPosition(var_3_14)
		end

		self.m_suitChangeTipText:setVisible(true)
	else
		self.m_suitChangeTipText:setVisible(false)
	end
end

function FogNightmareKeepsakeSelectInfoComp:_onConfirm()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_KEEPSAKE_SELECT_CONFIRM)
	self:dispatchCompEvent("selectKeepsake", {
		cfg = self._struct,
		worldPos = self._worldPos
	})
end

return FogNightmareKeepsakeSelectInfoComp
