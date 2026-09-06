-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelpowerclg/view/AngelPowerClgResultView.lua

module("logic.extensions.angelpowerclg.view.AngelPowerClgResultView", package.seeall)

local AngelPowerClgResultView = class("AngelPowerClgResultView", BattleSettlementSuccessView)

function AngelPowerClgResultView:customSettlementInfo()
	self:_onEnumTypeIsAngelPowerClg()
end

function AngelPowerClgResultView:_onEnumTypeIsAngelPowerClg()
	local params = BattleSettlementModel.instance:getParams()

	self:enqueueQueue(self._settlementTeam, {
		self
	})
	self:enqueueQueue(self._settlementReward, nil)
	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

return AngelPowerClgResultView
