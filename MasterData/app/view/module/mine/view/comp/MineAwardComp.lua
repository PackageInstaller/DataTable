local var_0_0 = g.core.const.ConstMgr
local MineAwardComp = class("MineAwardComp", require("app.fairyGUI.mine.UI_MineAwardComp"))

function MineAwardComp:ctor()
	self._numGold = 0
	self._maxGold = g.core.config.mine_parameter_info.indexOf(1).max_gold

	self.m_processComp:setMax(100)
	self:addClickListener(handler(self, self._onClickAward))
	self.m_itemIcon:setURL(g.core.common.Goods:convert(g.core.const.ConstMgr.MineConst.PRODUCT_ITEM).icon)
	self:setVisible(false)
end

function MineAwardComp:updateGoldNum(arg_2_1)
	self._numGold = arg_2_1

	self.m_numTxt:setText(arg_2_1)
	self:checkSpeWeakGuide()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MINE_GOLD_TICK_END, false)
	self:updateRedPoint()
end

function MineAwardComp:checkSpeWeakGuide()
	if g.core.model.User.guideData:getServerDataById(var_0_0.GuideConst.SAVE_SERVER_DATA_IDS.MINE_SCORE_CLICKED) then
		return
	end

	if self._numGold > 0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_MINE_SCORE",
			targetBtn = self
		})
	end
end

function MineAwardComp:setProgVisible(arg_4_1)
	self:setVisible(checkbool(arg_4_1))
end

function MineAwardComp:updateGoldProg(arg_5_1)
	self.m_processComp:setValue(arg_5_1)
end

function MineAwardComp:_onClickAward()
	if self._numGold > 0 then
		g.core.model.User.guideData:setSaveServerData(var_0_0.GuideConst.SAVE_SERVER_DATA_IDS.MINE_SCORE_CLICKED)
		g.core.network.GameNetProxy:send_C2S_Mine_GetGold({})
	end
end

function MineAwardComp:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function MineAwardComp:updateRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			curGold = self._numGold
		}
	})
end

return MineAwardComp
