local EchoLabCollectLevelCardComp = class("EchoLabCollectLevelCardComp", require("app.fairyGUI.echoLab.UI_EchoLabCollectLevelCardComp"))

function EchoLabCollectLevelCardComp:ctor()
	self._lastBuildStruct = nil
	self._buildStruct = nil

	self.m_levelPro:setMax(100)
	self.m_detailBtn:addClickListener(handler(self, self._onDetailBtnClick))
	self.m_goodsBtn:addClickListener(handler(self, self._onGoodsBtnClick))
end

function EchoLabCollectLevelCardComp:updateView(arg_2_1)
	self._lastBuildStruct = self._buildStruct
	self._buildStruct = arg_2_1

	local var_2_0 = self._buildStruct:getHangupOutInfo()

	if self:_checkNeedPlayProAmin() then
		self.m_isPlayAminController:setSelectedIndex(1)
	else
		self:_updateSelf()
	end

	self.m_goodsBtn:setIcon((g.core.common.Path:getIconByTypeValue(var_2_0.type, var_2_0.value)))

	local var_2_1 = {}

	for iter_2_0, iter_2_1 in pairs((self._buildStruct:getHangUpInfoDict())) do
		local var_2_2 = iter_2_0:split("_")

		var_2_1[#var_2_1 + 1] = {
			type = tonumber(var_2_2[1]),
			value = tonumber(var_2_2[2]),
			size = iter_2_1
		}
	end

	self.m_haloEffectNode:removeAllEffect()

	local var_2_4 = {
		isLoop = true,
		name = "eff_ui_echoLabCollect_crystal"
	}

	if var_2_1[1] then
		self.m_numText:setText(g.core.lang:get(408519, {
			num = var_2_1[1].size
		}))
		self.m_waitCollectController:setSelectedIndex(0)
	else
		var_2_4.anim = "idle"

		self.m_numText:setText(g.core.lang:get(408549))
		self.m_waitCollectController:setSelectedIndex(1)
	end

	self.m_haloEffectNode:addEffectSpine(var_2_4)
end

function EchoLabCollectLevelCardComp:_updateSelf()
	local var_3_0 = self._buildStruct:getLevel()
	local var_3_1 = self._buildStruct:getHangupOutInfo(var_3_0)

	self.m_levelText:setText(var_3_0)

	local var_3_2 = self._buildStruct:getExpInfo()

	self.m_levelPro:setValue((var_3_2.cur - var_3_2.startExp) / var_3_2.needExp * 100)
	self.m_expText:setText(g.core.lang:get(200523, {
		curNum = var_3_2.cur - var_3_2.startExp,
		totalNum = var_3_2.needExp
	}))
	self.m_hangUpIconLoader:setURL((g.core.common.Path:getIconByTypeValue(var_3_1.type, var_3_1.value, true)))
	self.m_hangUpText:setText(g.core.lang:get(408518, {
		num = var_3_1.size
	}))
	self.m_isPlayAminController:setSelectedIndex(0)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ECHO_LAB_COLLECT_PRO_AMIN_END, false)
end

function EchoLabCollectLevelCardComp:updateTimesTip(arg_4_1)
	local var_4_0 = self._buildStruct:getDailyActiveInfo(arg_4_1)

	self.m_timesTipText:setText(g.core.lang:get(408551, {
		num = math.max(var_4_0.activeMaxCount - var_4_0.activeCount, 0)
	}))
end

function EchoLabCollectLevelCardComp:_checkNeedPlayProAmin()
	local var_5_0 = false

	if self._lastBuildStruct and self._lastBuildStruct == self._buildStruct then
		local var_5_1 = self._buildStruct:getExpInfo()

		var_5_0 = tonumber(self.m_levelText:getText()) ~= self._buildStruct:getLevel() or tonumber(string.split(self.m_expText:getText(), "/")[1]) ~= var_5_1.cur - var_5_1.startExp
	end

	return var_5_0
end

function EchoLabCollectLevelCardComp:playProAmin()
	if self.m_isPlayAminController:getSelectedIndex() ~= 1 then
		self:_updateSelf()

		return
	end

	local var_6_0 = tonumber(self.m_levelText:getText())
	local var_6_1 = var_6_0 == self._buildStruct:getLevel()
	local var_6_2 = {
		remove = true,
		name = "eff_ui_echoLabCollect_level",
		isLoop = false,
		anim = "play1",
		eventHandler = handler(self, self._onSpineEventHandle)
	}

	self._anim = "play1"

	local var_6_3 = cc.size(260, 10)

	if var_6_1 then
		local var_6_4 = self._buildStruct:getExpInfo()

		self.m_levelPro:setValue((var_6_4.cur - var_6_4.startExp) / var_6_4.needExp * 100)

		var_6_3.width = var_6_3.width * ((var_6_4.cur - var_6_4.startExp) / var_6_4.needExp)

		self.m_expText:setText(g.core.lang:get(200523, {
			curNum = var_6_4.cur - var_6_4.startExp,
			totalNum = var_6_4.needExp
		}))
	else
		self.m_levelPro:setValue(100)

		local var_6_5 = self._buildStruct:getCfgByLevel(var_6_0 + 1)
		local var_6_6 = var_6_5.build_exp - self._buildStruct:getCfgByLevel(var_6_0).build_exp

		self.m_expText:setText(g.core.lang:get(200523, {
			curNum = var_6_6,
			totalNum = var_6_6
		}))
		self.m_hangUpText:setText(g.core.lang:get(408518, {
			num = var_6_5.output_size
		}))
	end

	self.m_effectComp:getChild("effectNode"):addEffectSpine(var_6_2)
	self.m_effectComp:setSize(var_6_3)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_FACILITY)
end

function EchoLabCollectLevelCardComp:_onSpineEventHandle(arg_7_1, arg_7_2)
	if require("app.view.battle.const.BattleConst").SPINE_EVENT.COMPLETE == arg_7_1.type then
		if self._anim == "play2" or tonumber(self.m_levelText:getText()) == self._buildStruct:getLevel() then
			self:_playProAminEnd()
		else
			self:_playLevelUpAmin()
		end
	end
end

function EchoLabCollectLevelCardComp:_playLevelUpAmin()
	self._anim = "play2"

	self.m_topEffectNode:addEffectSpine({
		remove = true,
		name = "eff_ui_echoLabCollect_level",
		isLoop = false,
		anim = "play2",
		eventHandler = handler(self, self._onSpineEventHandle)
	})
end

function EchoLabCollectLevelCardComp:_playProAminEnd()
	self.m_levelText:setText(math.min(tonumber(self.m_levelText:getText()) + 1, (self._buildStruct:getLevel())))

	if self:_checkNeedPlayProAmin() then
		self:playProAmin()
	else
		self:_updateSelf()
	end
end

function EchoLabCollectLevelCardComp:_onDetailBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.echoLab.view.collect.pop.EchoLabCollectBuildDetailPop").new(self._buildStruct), {
		touchDisappear = false
	})
end

function EchoLabCollectLevelCardComp:_onGoodsBtnClick()
	if not self._buildStruct:canGetHangupAwards() then
		g.core.module.ModuleManager:tip(g.core.lang:get(408534))

		return
	end

	g.core.network.GameNetProxy:send_C2S_Palace_GetHangupAward({
		build_type = self._buildStruct:getBuildType()
	})
end

return EchoLabCollectLevelCardComp
