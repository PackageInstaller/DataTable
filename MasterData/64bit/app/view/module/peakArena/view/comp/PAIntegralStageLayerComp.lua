local var_0_0 = g.core.model.User
local var_0_1 = g.core.model.User.peakArenaData
local var_0_2 = g.core.common.ServerTime
local DrawKnight = require("app.view.common.DrawKnight")
local PAIntegralStageLayerComp = class("PAIntegralStageLayerComp", require("app.fairyGUI.peakArena.UI_PAIntegralStageLayerComp"))

function PAIntegralStageLayerComp:ctor()
	self._lineupKnightIdArr = {}

	self.m_lineupList:setIniter()
	self.m_lineupList:doFairyBatching(true)
	self.m_lineupList:setItemRenderer(handler(self, self._onLineupListRenderer))
end

function PAIntegralStageLayerComp:onLoad()
	self.m_deployWordLoader:setURL("ui://text_new/txt_jjc_zhenrong")
	self:_updateMyInfo()
	self:_updateLineupList()
end

function PAIntegralStageLayerComp:onCD()
	local var_3_0, var_3_1, var_3_2 = var_0_2:getLeftTimeParts((var_0_1:getIntegralStageEndTime()))
	local var_3_3 = var_3_0 > 0 and g.core.lang:get(1051, {
		day = var_3_0,
		hour = var_3_1
	}) or g.core.lang:get(1096, {
		hour = var_3_1,
		minute = var_3_2
	})

	self.m_cdTxt:setText(g.core.lang:get(307001, {
		time = var_3_3
	}))
end

function PAIntegralStageLayerComp:onRcvUserInfo()
	self.m_integralStageInfoComp:updateComp()
end

function PAIntegralStageLayerComp:_onLineupListRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateComp(arg_5_1 + 1, (self._lineupKnightIdArr[arg_5_1 + 1] and self._lineupKnightIdArr[arg_5_1 + 1] ~= 0 or nil) and {
		sid = self._lineupKnightIdArr[arg_5_1 + 1]
	})
end

function PAIntegralStageLayerComp:_updateMyInfo()
	self.m_knightSpineDad:removeChildren()
	self.m_knightSpineDad:addChild((DrawKnight.new({
		scale = 0.9,
		isShowBg = true,
		resId = var_0_0:getAssistantResInfo().painted_id
	})))
	self.m_powerNumText:setText(var_0_0:getFightValue())
end

function PAIntegralStageLayerComp:_updateLineupList()
	self._lineupKnightIdArr = var_0_0.knightsData:getFormation()

	self.m_lineupList:setNumItems(#self._lineupKnightIdArr)
end

function PAIntegralStageLayerComp:playEnterAni()
	self.m_enterTransition:play()
end

return PAIntegralStageLayerComp
