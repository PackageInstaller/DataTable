local CommonKnight = require("app.view.common.CommonKnight")
local var_0_1 = g.core.const.ConstMgr.SpineConst
local StormClearFinishPop = class("StormClearFinishPop", require("app.fairyGUI.storm.UI_StormClearFinishPop"), function()
	return fgui.GComponent:create({
		pkgName = "storm",
		resName = "StormClearFinishPop",
		pkgPath = "ui/storm/storm"
	}, ...)
end)

function StormClearFinishPop:ctor(arg_2_1)
	self:showAtCenter()

	arg_2_1 = arg_2_1 or {}
	self._stormId = arg_2_1.stormId

	if self._stormId then
		self._camp = g.core.config.storm_info.get(self._stormId).country
	end

	self.m_rewardList:setItemIniter(function(arg_3_0, arg_3_1)
		arg_3_1:bindLua("app.view.module.storm.view.comp.StormClearCell")
	end)
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardListRenderer))
	self.m_finishBtn:addClickListener(handler(self, self._close))
	self:_initOpenBoxUI()
	self:_playMoveAndOpen()
end

function StormClearFinishPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_CLEAR, self._onRcvStormClear, self)
	g.core.network.GameNetProxy:send_C2S_Storm_Clear({
		storm_id = self._stormId
	})
end

function StormClearFinishPop:_onRcvStormClear(arg_5_1, arg_5_2, arg_5_3)
	self._data = arg_5_3

	self:_updatePopView()
end

function StormClearFinishPop:_updatePopView()
	self.m_popPanel:setCloseBtnShow(false)
	self.m_finishBtn:setVisible(false)

	self._challengeAwards = self._data.challenge_awards or {}
	self._scores = self._data.scores or {}

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(self._data.awards or {}) do
		var_6_0[iter_6_1.type .. "_" .. iter_6_1.value] = not var_6_0[iter_6_1.type .. "_" .. iter_6_1.value] and iter_6_1.size or var_6_0[iter_6_1.type .. "_" .. iter_6_1.value] + iter_6_1.size
	end

	local var_6_1 = {}

	for iter_6_2, iter_6_3 in pairs(var_6_0) do
		local var_6_2 = string.split(iter_6_2, "_")

		table.insert(var_6_1, {
			type = tonumber(var_6_2[1]),
			value = tonumber(var_6_2[2]),
			size = iter_6_3
		})
	end

	self._eventAwards = var_6_1
	self._renderIndex = 0

	self:newSchedule(function()
		self:_onUpdateList()
	end, 0.4)
end

function StormClearFinishPop:_onUpdateList()
	self.m_rewardList:animationAddCell("ui://storm/StormClearCell")

	self._renderIndex = self._renderIndex + 1

	if self._renderIndex > #self._challengeAwards then
		self:cancelAllSchedule()
	end
end

function StormClearFinishPop:animPlayFinish()
	self.m_popPanel:setCloseBtnShow(true)
	self.m_finishBtn:setVisible(true)
end

function StormClearFinishPop:_close()
	g.core.module.ModuleManager:checkAndPlayPopExitAnim()
end

function StormClearFinishPop:_onRewardListRenderer(arg_11_1, arg_11_2)
	if arg_11_1 + 1 <= #self._challengeAwards then
		arg_11_2:updateCellView({
			index = arg_11_1 + 1,
			award = self._challengeAwards[arg_11_1 + 1].detail,
			score = self._scores[arg_11_1 + 1]
		})
	elseif arg_11_1 == #self._challengeAwards then
		arg_11_2:updateCellView(self._eventAwards or {}, true)
		self:animPlayFinish()
	end
end

function StormClearFinishPop:_initOpenBoxUI()
	local var_12_0 = CommonKnight.new({
		resId = g.core.config.knight_info.get(g.core.model.User:getBaseId()).advance_id
	})

	var_12_0:setScale(1)
	self.m_attackerNode:addChild(var_12_0)

	self._attackerKnight = var_12_0
	self._attackPos = self.m_attackerNode:getPosition()

	if self._camp then
		self.m_bgLoader:setURL(self:getGroupBgURL(self._camp))
	end

	self._boxSpine = self.m_boxNode:addEffectSpine({
		name = "eff_ui_bio_wuzixiang2",
		anim = "in",
		isLoop = true,
		listener = handler(self, self._onSpineEvent)
	})
end

function StormClearFinishPop:getGroupBgURL(arg_13_1)
	local var_13_0 = g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE

	return arg_13_1 == g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.JIAO_GUO and "pic/base_new/bg_sd_jiaoguo.png" or arg_13_1 == var_13_0.LIN_DONG and "pic/base_new/bg_sd_lindong.png" or arg_13_1 == var_13_0.DONG_XI and "pic/base_new/bg_sd_dongxi.png" or "pic/base_new/bg_sd_lijin.png"
end

function StormClearFinishPop:_onSpineEvent(arg_14_1)
	if arg_14_1.type == var_0_1.SPINE_EVENT.COMPLETE and self._boxSpine and self._inOpenBox then
		self._boxSpine:setAnimation(0, "idle", true)

		self._inOpenBox = false
	end
end

function StormClearFinishPop:_playMoveAndOpen()
	self._attackerKnight:playAction("run")
	self.m_goAndOpenBoxTransition:play(handler(self, self._doOpenBox))
end

function StormClearFinishPop:_doOpenBox()
	self._attackerKnight:playAction("attack", handler(self, self._onOpenBack))
end

function StormClearFinishPop:_onBoxOpen()
	self._boxSpine:setAnimation(0, "hit", false)
end

function StormClearFinishPop:_onOpenBack()
	self._inOpenBox = true

	self._attackerKnight:playAction("show", handler(self, self._onFinishOpen))
	self:_onBoxOpen()
end

function StormClearFinishPop:_onFinishOpen()
	self._attackerKnight:playAction("idle")
end

function StormClearFinishPop:onUnload()
	self:cancelAllSchedule()
end

return StormClearFinishPop
