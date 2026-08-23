local var_0_0 = g.core.model.User.monopolyDataMgr
local var_0_1 = g.core.common.Goods
local RichmanSelNumPop = class("RichmanSelNumPop", require("app.fairyGUI.monopoly.UI_MonopolySelNumPop"), function()
	return fgui.GComponent:create({
		resName = "MonopolySelNumPop",
		pkgPath = "ui/monopoly/monopoly",
		pkgName = "monopoly"
	})
end)

function RichmanSelNumPop:ctor()
	self:showAtCenter()
	self.m_numberController:setSelectedIndex(-1)
	self.m_numberController:addEventListener(fgui.UIEventType.Changed, handler(self, self.onClickSel))
end

function RichmanSelNumPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MONOPOLY_USEFIXEDDICE, handler(self, self._onItemUseRecv), self)
	self.m_enterTransition:play()
end

function RichmanSelNumPop:onClickSel()
	local var_4_0 = var_0_0:getMonopolyData()

	if var_4_0:getNextDice() > 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(426004))

		return
	end

	local var_4_1 = self.m_numberController:getSelectedIndex() + 1

	if g.core.model.User.bagData:getOwnNum(var_0_1.TYPE_ITEM, var_0_1.ITEM.MONOPOLY_DICE) > 0 then
		g.core.network.GameNetProxy:send_C2S_Monopoly_UseFixedDice({
			activityId = var_4_0:getActivityId(),
			dice = self.m_numberController:getSelectedIndex() + 1
		})
	end

	self["m_num" .. var_4_1]:getChild("effIcon"):addEffectSpine({
		remove = true,
		name = "eff_ui_richman_select",
		isLoop = false,
		eventHandler = handler(self, self._onAnimationEnd)
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_TouziSuccess)
end

function RichmanSelNumPop:_onItemUseRecv(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self._useSuccess = true

	if self._animEnd then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function RichmanSelNumPop:_onAnimationEnd(arg_6_1)
	if arg_6_1.type == "complete" then
		self._animEnd = true

		if self._useSuccess then
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		end
	end
end

return RichmanSelNumPop
