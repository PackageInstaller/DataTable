local GuildStatueBuildComp = class("GuildStatueBuildComp", require("app.fairyGUI.guildStatue.UI_GuildStatueBuildComp"))

GuildStatueBuildComp.ROTATION_KEY = {
	-60,
	-26,
	-6,
	6,
	26,
	70
}
GuildStatueBuildComp.ROTATION_SCORE_MAP = {
	1,
	3,
	5,
	3,
	1
}
GuildStatueBuildComp.COST_ITEM_MAP = {
	1,
	3,
	5
}
GuildStatueBuildComp.SHOW_DESC = {
	"GOOD",
	nil,
	"COOL",
	nil,
	"PERFECT"
}

function GuildStatueBuildComp:ctor()
	self._selectCostIndex = 0
	self._inFocus = false
	self._partData = nil

	self.m_rechargeBtn:addClickListener(handler(self, self._onRechargeBtnClick))
	self.m_selectController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeSelectCtrl))
	self.m_rechargeBtn:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onRechargeBtnTouchBegin))
	self.m_rechargeBtn:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onRechargeBtnTouchEnd))
	self:_updateCost()
	self:playBtnEffect()
end

function GuildStatueBuildComp:onLoad()
	self:startRotate()
end

function GuildStatueBuildComp:setFocus(arg_3_1, arg_3_2)
	if arg_3_1 then
		self.m_selectController:setSelectedIndex(0)
	end

	self._inFocus = arg_3_1
	self._partData = arg_3_2
end

function GuildStatueBuildComp:startRotate()
	self.m_pointer:setRotation(GuildStatueBuildComp.ROTATION_KEY[1])

	self._radio = 0
	self._pointerState = 1

	self:cancelAllSchedule()

	self._moveScheduler = self:newSchedule(function(arg_5_0, arg_5_1, arg_5_2)
		self:_onMoveRepeat(arg_5_1)
	end)
end

function GuildStatueBuildComp:_onMoveRepeat(arg_6_1)
	local var_6_0 = self.m_pointer:getRotation()

	self.m_pointer:setRotation(var_6_0 + self._radio)

	local var_6_1 = 0.3

	if g.core.common.Setting:getValue(g.core.common.Setting.FUNC_FPS) == 1 then
		var_6_1 = 0.1
	end

	self._radio = var_6_0 + self._radio >= 0 and self._radio - var_6_1 or self._radio + var_6_1
end

function GuildStatueBuildComp:_onCloseBtnClick()
	if not self._inFocus then
		return
	end

	self.m_backTransition:play()
	self:dispatchCompEvent("GUILD_STATUE_BACK_NORMAL_STATE")
end

function GuildStatueBuildComp:backNormalState()
	self:_onCloseBtnClick()
end

function GuildStatueBuildComp:_onRechargeBtnClick()
	self:playBtnEffect()

	if not self._inFocus or not self._partData then
		g.core.module.ModuleManager:tip(g.core.lang:get(109710))

		return
	end

	if g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_ITEM, g.core.common.Goods.ITEM.TYPE_STATUE_STONE) < GuildStatueBuildComp.COST_ITEM_MAP[self._selectCostIndex + 1] then
		g.core.module.ModuleManager:tip(g.core.lang:get(109711))

		return
	end

	local var_9_0, var_9_1, var_9_2 = g.core.model.User.guildStatueData:isStoneMax(GuildStatueBuildComp.COST_ITEM_MAP[self._selectCostIndex + 1])

	if not var_9_0 then
		if var_9_2 <= 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(109704))
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(109705, {
				num = var_9_2
			}))
		end

		return
	end

	self:cancelAllSchedule()

	local var_9_3 = self.m_pointer:getRotation()
	local var_9_4 = 0

	for iter_9_0, iter_9_1 in ipairs(GuildStatueBuildComp.ROTATION_SCORE_MAP) do
		if var_9_3 >= GuildStatueBuildComp.ROTATION_KEY[iter_9_0] and var_9_3 < GuildStatueBuildComp.ROTATION_KEY[iter_9_0 + 1] then
			var_9_4 = iter_9_1

			break
		end
	end

	self.m_scoreStateTxt:setText(GuildStatueBuildComp.SHOW_DESC[var_9_4])
	self:playSuccessEffect(var_9_4)
	g.core.network.GameNetProxy:send_C2S_GuildStatue_DoCast({
		cast_type = 1,
		type = self._partData.type,
		value = var_9_4,
		stone = GuildStatueBuildComp.COST_ITEM_MAP[self._selectCostIndex + 1]
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.ENERGY_FULL)
	self.m_rechargeBtn:setTouchable(false)
	self:newScheduleOnce(function(arg_10_0, arg_10_1, arg_10_2)
		self:startRotate()
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.ENERGY_POINTER)
		self.m_rechargeBtn:setTouchable(true)
	end, 1.5)
end

function GuildStatueBuildComp:_onChangeSelectCtrl()
	self._selectCostIndex = self.m_selectController:getSelectedIndex()

	self:_updateCost()
end

function GuildStatueBuildComp:updateCost()
	self:_updateCost()
end

function GuildStatueBuildComp:_updateCost()
	self.m_costIcon:setURL((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_ITEM, g.core.common.Goods.ITEM.TYPE_STATUE_STONE, true)))

	local var_13_0 = g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_ITEM, g.core.common.Goods.ITEM.TYPE_STATUE_STONE)

	if GuildStatueBuildComp.COST_ITEM_MAP[self._selectCostIndex + 1] <= var_13_0 then
		self.m_haveNumTxt:setText(g.core.lang:get(109716, {
			num = var_13_0,
			haveNum = GuildStatueBuildComp.COST_ITEM_MAP[self._selectCostIndex + 1]
		}))
	else
		self.m_haveNumTxt:setText(g.core.lang:get(109715, {
			num = var_13_0,
			haveNum = GuildStatueBuildComp.COST_ITEM_MAP[self._selectCostIndex + 1]
		}))
	end
end

function GuildStatueBuildComp:playSuccessEffect(arg_14_1)
	local var_14_0 = {
		anim = "play",
		remove = true,
		isLoop = false,
		listener = handler(self, self._onSuccessEffectEvent)
	}

	var_14_0.name = arg_14_1 == 1 and "eff_ui_guildstatue_recharge_good" or arg_14_1 == 3 and "eff_ui_guildstatue_recharge_cool" or "eff_ui_guildstatue_recharge_perfect"

	self.m_effectComp:addEffectSpine(var_14_0)
	self.m_rechargeTransition:play()
end

function GuildStatueBuildComp:_onSuccessEffectEvent(arg_15_1)
	if arg_15_1.type == "play" then
		self.m_rechargeTransition:play()
	end
end

function GuildStatueBuildComp:playBtnEffect()
	local var_16_0 = self.m_rechargeBtn:getSize()

	self.m_rechargeBtn:addEffectSpine({
		name = "eff_ui_guildstatue_rechargeBtn",
		remove = true,
		isLoop = false,
		anim = "play_click",
		x = var_16_0.width / 2,
		y = var_16_0.height / 2
	})
end

function GuildStatueBuildComp:_onRechargeBtnTouchBegin()
	if self._rechargeBtnEff then
		self._rechargeBtnEff:removeSelf()

		self._rechargeBtnEff = nil
	end

	local var_17_0 = self.m_rechargeBtn:getSize()

	self._rechargeBtnEff = self.m_rechargeBtn:addEffectSpine({
		name = "eff_ui_guildstatue_rechargeBtn",
		remove = true,
		isLoop = true,
		anim = "play_idle",
		x = var_17_0.width / 2,
		y = var_17_0.height / 2
	})
end

function GuildStatueBuildComp:_onRechargeBtnTouchEnd()
	if self._rechargeBtnEff then
		self._rechargeBtnEff:removeSelf()

		self._rechargeBtnEff = nil
	end
end

function GuildStatueBuildComp:onUnload()
	if self._moveScheduler then
		self:cancelSchedule(self._moveScheduler)

		self._moveScheduler = nil
	end
end

return GuildStatueBuildComp
