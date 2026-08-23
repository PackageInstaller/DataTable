local CommonKnight = require("app.view.common.CommonKnight")
local var_0_1 = g.core.const.ConstMgr.SpineConst
local StormOneKeyClearFinishPop = class("StormOneKeyClearFinishPop", require("app.fairyGUI.storm.UI_StormOneKeyClearFinishPop"), function()
	return fgui.GComponent:create({
		resName = "StormOneKeyClearFinishPop",
		pkgPath = "ui/storm/storm",
		pkgName = "storm"
	}, ...)
end)

function StormOneKeyClearFinishPop:ctor()
	self:showAtCenter()

	self._camp = 4

	self.m_rewardList:setItemIniter(function(arg_3_0, arg_3_1)
		arg_3_1:bindLua("app.view.module.storm.view.comp.StormClearCell")
	end)
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardListRenderer))
	self.m_finishBtn:addClickListener(handler(self, self._close))
	self.m_jumpBtn:addClickListener(handler(self, self._onJumpBtnClicked))
	self:_initOpenBoxUI()
end

function StormOneKeyClearFinishPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_ONEKEY_CLEAR, self._onRcvStormClear, self)
	g.core.network.GameNetProxy:send_C2S_Storm_OneKey_Clear({
		is_helper = false
	})
end

function StormOneKeyClearFinishPop:_onRcvStormClear(arg_5_1, arg_5_2, arg_5_3)
	self._data = arg_5_3.storm_awards or {}

	self:_updatePopView()
	self:_playMoveAndOpen()
end

function StormOneKeyClearFinishPop:_updateData()
	local var_6_0 = {}
	local var_6_1 = {}
	local var_6_2 = {}

	for iter_6_0, iter_6_1 in ipairs(self._data) do
		for iter_6_2, iter_6_3 in ipairs(iter_6_1.challenge_awards or {}) do
			var_6_0[#var_6_0 + 1] = iter_6_3
		end

		for iter_6_4, iter_6_5 in ipairs(iter_6_1.scores or {}) do
			var_6_1[#var_6_1 + 1] = iter_6_5
		end

		for iter_6_6, iter_6_7 in ipairs(iter_6_1.awards or {}) do
			var_6_2[#var_6_2 + 1] = iter_6_7
		end
	end

	self._challengeAwards = var_6_0
	self._scores = var_6_1

	local var_6_4 = {}
	local var_6_5 = {}

	for iter_6_8, iter_6_9 in ipairs(var_6_2) do
		var_6_5[iter_6_9.type .. "_" .. iter_6_9.value] = not var_6_5[iter_6_9.type .. "_" .. iter_6_9.value] and iter_6_9.size or var_6_5[iter_6_9.type .. "_" .. iter_6_9.value] + iter_6_9.size
	end

	for iter_6_10, iter_6_11 in pairs(var_6_5) do
		local var_6_6 = string.split(iter_6_10, "_")

		table.insert(var_6_4, {
			type = tonumber(var_6_6[1]),
			value = tonumber(var_6_6[2]),
			size = iter_6_11
		})
	end

	self._eventAwards = var_6_4
end

function StormOneKeyClearFinishPop:_updatePopView()
	self.m_popPanel:setCloseBtnShow(false)
	self.m_finishBtn:setVisible(false)
	self:_updateData()

	self._renderIndex = 0

	self:newSchedule(function()
		self:_onUpdateList()
	end, 0.4)
end

function StormOneKeyClearFinishPop:_onUpdateList(arg_9_1)
	if not arg_9_1 then
		self.m_rewardList:animationAddCell("ui://storm/StormClearCell")
	else
		self.m_rewardList:animationAddCell("ui://storm/StormClearCell"):stopAllFGActions()
		self.m_rewardList:animationAddCellFinish()
	end

	self._renderIndex = self._renderIndex + 1

	if self._renderIndex > #self._challengeAwards then
		self:cancelAllSchedule()
	end
end

function StormOneKeyClearFinishPop:animPlayFinish()
	self.m_popPanel:setCloseBtnShow(true)
	self.m_finishBtn:setVisible(true)
	self.m_jumpBtn:setVisible(false)
end

function StormOneKeyClearFinishPop:_close()
	g.core.module.ModuleManager:checkAndPlayPopExitAnim()
end

function StormOneKeyClearFinishPop:_onJumpBtnClicked()
	if not self._data then
		return
	end

	self:cancelAllSchedule()

	for iter_12_0 = 1, #self._challengeAwards - self._renderIndex do
		self:_onUpdateList(true)
	end

	self:_onUpdateList()
end

function StormOneKeyClearFinishPop:_onRewardListRenderer(arg_13_1, arg_13_2)
	if arg_13_1 + 1 <= #self._challengeAwards then
		arg_13_2:updateCellView({
			index = arg_13_1 + 1,
			award = self._challengeAwards[arg_13_1 + 1].detail,
			score = self._scores[arg_13_1 + 1]
		})
	elseif arg_13_1 == #self._challengeAwards then
		arg_13_2:updateCellView(self._eventAwards or {}, true)
		self:animPlayFinish()
	end
end

function StormOneKeyClearFinishPop:_initOpenBoxUI()
	local var_14_0 = CommonKnight.new({
		resId = g.core.config.knight_info.get(g.core.model.User:getBaseId()).advance_id
	})

	var_14_0:setScale(1)
	self.m_attackerNode:addChild(var_14_0)

	self._attackerKnight = var_14_0
	self._attackPos = self.m_attackerNode:getPosition()

	if self._camp then
		self.m_bgLoader:setURL(self:getGroupBgURL(self._camp))
	end

	self._boxSpine = self.m_boxNode:addEffectSpine({
		anim = "in",
		name = "eff_ui_bio_wuzixiang2",
		isLoop = true,
		listener = handler(self, self._onSpineEvent)
	})
end

function StormOneKeyClearFinishPop:getGroupBgURL(arg_15_1)
	local var_15_0 = g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE

	return arg_15_1 == g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.JIAO_GUO and "pic/base_new/bg_sd_jiaoguo.png" or arg_15_1 == var_15_0.LIN_DONG and "pic/base_new/bg_sd_lindong.png" or arg_15_1 == var_15_0.DONG_XI and "pic/base_new/bg_sd_dongxi.png" or "pic/base_new/bg_sd_lijin.png"
end

function StormOneKeyClearFinishPop:_onSpineEvent(arg_16_1)
	if arg_16_1.type == var_0_1.SPINE_EVENT.COMPLETE and self._boxSpine and self._inOpenBox then
		self._boxSpine:setAnimation(0, "idle", true)

		self._inOpenBox = false
	end
end

function StormOneKeyClearFinishPop:_playMoveAndOpen()
	self._attackerKnight:playAction("run")
	self.m_goAndOpenBoxTransition:play(handler(self, self._doOpenBox))
end

function StormOneKeyClearFinishPop:_doOpenBox()
	self._attackerKnight:playAction("attack", handler(self, self._onOpenBack))
end

function StormOneKeyClearFinishPop:_onBoxOpen()
	self._boxSpine:setAnimation(0, "hit", false)
end

function StormOneKeyClearFinishPop:_onOpenBack()
	self._inOpenBox = true

	self._attackerKnight:playAction("show", handler(self, self._onFinishOpen))
	self:_onBoxOpen()
end

function StormOneKeyClearFinishPop:_onFinishOpen()
	self._attackerKnight:playAction("idle")
end

function StormOneKeyClearFinishPop:onUnload()
	self:cancelAllSchedule()
end

return StormOneKeyClearFinishPop
