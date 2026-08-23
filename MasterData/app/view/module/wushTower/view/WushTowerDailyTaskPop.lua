local var_0_0 = g.core.model.User.wushTowerData
local WushTowerDailyTaskPop = class("WushTowerDailyTaskPop", require("app.fairyGUI.wushTower.UI_WushTowerDailyTaskPop"), function()
	return fgui.GComponent:create({
		resName = "WushTowerDailyTaskPop",
		pkgPath = "ui/wushTower/wushTower",
		pkgName = "wushTower"
	}, ...)
end)

function WushTowerDailyTaskPop:ctor(arg_2_1)
	self._taskStructArr = var_0_0:getTaskStructArr()

	self.m_fullBtn:addClickListener(handler(self, self._onClickFullBtn))
	self.m_rewardList:setVirtual()
	self.m_rewardList:doFairyBatching(false)
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderRewardList))
	self:showAtCenter()
end

function WushTowerDailyTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_TOWER_TASKAWARD, self._onS2CTaskAward, self)
	self:_updateView()
	self.m_rewardList:transitionShowCells("enter_down", 0.03)
end

function WushTowerDailyTaskPop:_onS2CTaskAward(arg_4_1, arg_4_2, arg_4_3)
	g.core.module.ModuleManager:awardSummary(arg_4_3.awards)
	self:_updateView()
end

function WushTowerDailyTaskPop:_onClickFullBtn()
	local var_5_0 = var_0_0:getTaskIdsRcvEnable()

	if #var_5_0 > 0 then
		g.core.network.GameNetProxy:send_C2S_DeadTower_TaskAward({
			ids = var_5_0
		})
	end
end

function WushTowerDailyTaskPop:_onRenderRewardList(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._taskStructArr[arg_6_1 + 1])
end

function WushTowerDailyTaskPop:_updateView()
	var_0_0:sortTaskStructArr(self._taskStructArr)
	self.m_rewardList:setNumItems(#self._taskStructArr)
	self.m_fullBtn:setVisible((self:_isShowFullBtn()))
end

function WushTowerDailyTaskPop:_isShowFullBtn()
	return #var_0_0:getTaskIdsRcvEnable() > 1
end

return WushTowerDailyTaskPop
