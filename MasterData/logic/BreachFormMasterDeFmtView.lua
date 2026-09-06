-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/view/BreachFormMasterDeFmtView.lua

module("logic.extensions.breachformmaster.view.BreachFormMasterDeFmtView", package.seeall)

local BreachFormMasterDeFmtView = class("BreachFormMasterDeFmtView", ViewComponent)

function BreachFormMasterDeFmtView:ctor()
	BreachFormMasterDeFmtView.super.ctor(self)
end

function BreachFormMasterDeFmtView:unbindEvents()
	BreachFormMasterDeFmtView.super.unbindEvents(self)
end

function BreachFormMasterDeFmtView:bindEvents()
	BreachFormMasterDeFmtView.super.bindEvents(self)
end

function BreachFormMasterDeFmtView:buildUI()
	BreachFormMasterDeFmtView.super.buildUI(self)

	self._txtZdl = self:getTxt("txtZdl")
	self._txtTime = self:getTxt("txtTime")
end

function BreachFormMasterDeFmtView:onExit()
	BreachFormMasterDeFmtView.super.onExit(self)
end

function BreachFormMasterDeFmtView:onEnter()
	BreachFormMasterDeFmtView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()

	local saveTime = BreachFormMasterModel.instance:getTodaySetDefenseFormTimes(self._fmtMo.activityId)
	local activityCfg = BreachFormMasterConfig.instance:getActivityCfg(self._fmtMo.activityId)
	local haveTime = activityCfg.dailySetDefenseFormTimes - saveTime
	local minZdl = activityCfg.defenseFormZdlWanPercent[1]

	self._txtTime.text = langPara("今日可保存次数：%s/%s", haveTime, activityCfg.dailySetDefenseFormTimes)
	self._txtZdl.text = langPara("修改后精灵总战力必须大于等于%s", minZdl)
end

return BreachFormMasterDeFmtView
