local var_0_0 = g.core.model.User.fogNightmareData
local FogNightMareStageRewardPop = class("FogNightMareStageRewardPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareStageRewardPop"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareStageRewardPop",
		pkgPath = "ui/fogNightmare/fogNightmare",
		pkgName = "fogNightmare"
	}, ...)
end)

function FogNightMareStageRewardPop:ctor()
	self:showAtCenter()
	self.m_rewardItemList:setItemRenderer(handler(self, self._onRewardItemRenderer))
	self.m_rewardItemList:setVirtual()
	self.m_rewardItemList:doFairyBatching(false)

	local var_2_0 = var_0_0:getTowerData()

	self.m_floorTxt:setText((math.max(var_2_0:getCurrentFloorNum() - 1, (math.max(var_2_0:getCurrentMaxFloorNum(), var_2_0:getHistoryMaxFloorNum())))))
end

function FogNightMareStageRewardPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_PHASEAWARD, self.onPhaseAward, self)
	self:updateData()
end

function FogNightMareStageRewardPop:updateData()
	self._rewardData = var_0_0:getTowerData():getPhaseRewardData()

	table.sort(self._rewardData, function(arg_5_0, arg_5_1)
		if arg_5_0.received ~= arg_5_1.received then
			return not arg_5_0.received
		end

		return arg_5_0.index < arg_5_1.index
	end)
	self.m_rewardItemList:setNumItems(#self._rewardData)
end

function FogNightMareStageRewardPop:onPhaseAward(arg_6_1, arg_6_2, arg_6_3)
	g.core.module.ModuleManager:awardSummary(arg_6_3.awards or {})
	self:updateData()
end

function FogNightMareStageRewardPop:_onRewardItemRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateFogNightCell(self._rewardData[arg_7_1 + 1])
end

return FogNightMareStageRewardPop
