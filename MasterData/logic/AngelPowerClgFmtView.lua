-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelpowerclg/view/AngelPowerClgFmtView.lua

module("logic.extensions.angelpowerclg.view.AngelPowerClgFmtView", package.seeall)

local AngelPowerClgFmtView = class("AngelPowerClgFmtView", ViewComponent)

function AngelPowerClgFmtView:ctor()
	AngelPowerClgFmtView.super.ctor(self)
end

function AngelPowerClgFmtView:unbindEvents()
	AngelPowerClgFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTransfer, self)
end

function AngelPowerClgFmtView:bindEvents()
	AngelPowerClgFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTransfer, self._onClickTransfer, self)
end

function AngelPowerClgFmtView:buildUI()
	AngelPowerClgFmtView.super.buildUI(self)

	self._btnTransfer = self:getGo("maskInfo/btnTransfer")
	self._txtTips = self:getTxt("maskInfo/txtTips")
end

function AngelPowerClgFmtView:onExit()
	AngelPowerClgFmtView.super.onExit(self)
end

function AngelPowerClgFmtView:onEnter()
	AngelPowerClgFmtView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()
	self._activityId = self._fmtMo:getActivityId()
	self._stageId = self._fmtMo:getStageId()
	self._actCfg = AngelPowerClgConfig.instance:getActivityCfg(self._activityId)

	local challengeCfg = AngelPowerClgConfig.instance:getStageCfg(self._activityId, self._stageId)
	local cfgEnemy = AngelPowerClgConfig.instance:getTeamCfg(challengeCfg.creepsMasterId)

	self._txtTips.text = langPara("第%s个回合结束时，敌阵精灵统一变身为面具精灵", GameUtil.getChineseNumber(self._actCfg.transferRoundCount))
end

function AngelPowerClgFmtView:_onClickTransfer()
	UIStateManager.instance:push(ViewName.AngelPowerClgPetView, self._activityId, self._stageId)
end

return AngelPowerClgFmtView
