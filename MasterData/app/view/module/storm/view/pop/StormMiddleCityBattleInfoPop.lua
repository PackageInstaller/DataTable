local StormMiddleCityBattleInfoPop = class("StormMiddleCityBattleInfoPop", require("app.fairyGUI.storm.UI_StormMiddleCityBattleInfoPop"), function()
	return fgui.GComponent:create({
		resName = "StormMiddleCityBattleInfoPop",
		pkgPath = "ui/storm/storm",
		pkgName = "storm"
	})
end)

function StormMiddleCityBattleInfoPop:ctor(arg_2_1)
	self._stormId = arg_2_1.stormId
	self._cellEventId = arg_2_1.cellEventId

	self.m_rightBattleInfo:setData(arg_2_1)

	self._isEnterBattle = false

	self.m_rightBattleInfo:setSize(display.width, display.height)
	self.m_rightBattleInfo:onBattleUserInfoBack(arg_2_1.content)
	self:addClickListener(handler(self, self._onClose))
	self.m_playTimesComp:initView({
		isResetRecover = true,
		playNum = g.core.model.User.stormData:getMiddleCityPlayNumId(self._stormId),
		getTimesFunc = function()
			return g.core.model.User.shopData:getLeftCount(g.core.model.User.stormData:getMiddleCityPlayNumId(self._stormId))
		end,
		refreshEvent = {
			g.core.event.enum.EVENT_NET_S2C_STORM_RESET,
			g.core.event.enum.EVENT_NET_S2C_STORM_CLEAR
		}
	})
end

function StormMiddleCityBattleInfoPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM, self._onRcvFlushPlayNum, self)
	self:showAction()
	self.m_playTimesComp:updateView()
end

function StormMiddleCityBattleInfoPop:_onRcvFlushPlayNum()
	return
end

function StormMiddleCityBattleInfoPop:showAction()
	return
end

function StormMiddleCityBattleInfoPop:_onClose()
	self.m_rightBattleInfo:hideAction()
end

return StormMiddleCityBattleInfoPop
