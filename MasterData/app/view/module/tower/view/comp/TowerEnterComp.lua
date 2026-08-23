local TowerEnterComp = class("TowerEnterComp", require("app.fairyGUI.tower.UI_TowerEnterComp"))
local TowerCommon = require("app.view.module.tower.const.TowerCommon")
local var_0_2 = g.core.common.ServerTime
local var_0_3 = g.core.const.ConstMgr.TowerConst
local var_0_4 = g.core.config.tower_type_info
local var_0_5 = g.core.common.Drops

function TowerEnterComp:ctor()
	self._towerData = nil

	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onItemRenderer))
end

function TowerEnterComp:init(arg_2_1)
	self:update(arg_2_1)
end

function TowerEnterComp:update(arg_3_1)
	arg_3_1 = arg_3_1 or 1
	self._towerData = TowerCommon:getModelDataByType(arg_3_1)

	if arg_3_1 == var_0_3.TOWER_DIFFICULTY.NORMAL then
		self.m_difficultyController:setSelectedIndex(0)
		self.m_redPointComp:setId(402)
	elseif arg_3_1 == var_0_3.TOWER_DIFFICULTY.HARD then
		self.m_difficultyController:setSelectedIndex(1)
		self.m_redPointComp:setId(403)
	end

	local var_3_0 = var_0_4.get(arg_3_1)

	self.m_descTxt:setText(var_3_0.description)

	self._awards = var_0_5:getGoodsArray(var_3_0.award_drop)

	self.m_awardList:setNumItems(#self._awards)
	self:_updateTime()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

function TowerEnterComp:_updateTime()
	if self._towerData then
		self.m_timeTxt:setText(var_0_2:secondToHMSString((self._towerData:getCurRealHangupTimeAndProgress())))
	end
end

function TowerEnterComp:onLoad()
	self:newSchedule(handler(self, self._updateTime), 1)
	self:_updateTime()
end

function TowerEnterComp:onUnload()
	return
end

function TowerEnterComp:_onItemRenderer(arg_7_1, arg_7_2)
	if self._awards[arg_7_1 + 1] then
		arg_7_2:updateIcon(self._awards[arg_7_1 + 1])
	end
end

return TowerEnterComp
