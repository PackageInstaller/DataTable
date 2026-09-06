-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashlesslongyan/view/AshlessLongYanBonfireTipsView.lua

module("logic.extensions.ashlesslongyan.view.AshlessLongYanBonfireTipsView", package.seeall)

local AshlessLongYanBonfireTipsView = class("AshlessLongYanBonfireTipsView", ViewComponent)

function AshlessLongYanBonfireTipsView:ctor()
	AshlessLongYanBonfireTipsView.super.ctor(self)
end

function AshlessLongYanBonfireTipsView:buildUI()
	AshlessLongYanBonfireTipsView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtFinish = self:getTxt("txtFinish")

	local descScrView = self:getGo("descCol/scrView")
	local descScrCell = self:getGo("descCol/scrCell")

	self._descScrollerList = ScrollerList.create(descScrView, descScrCell, GameUtil.handler(self._updateDescCell, self), GameUtil.handler(self._clearDescCell, self))
end

function AshlessLongYanBonfireTipsView:bindEvents()
	AshlessLongYanBonfireTipsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AshlessLongYanBonfireTipsView:unbindEvents()
	AshlessLongYanBonfireTipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AshlessLongYanBonfireTipsView:onEnter()
	AshlessLongYanBonfireTipsView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._phaseId = checknumber(params[2])
	self._longYanMo = AshlessLongYanController.instance:getLongYanMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_AshlessLongYanGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_AshlessLongYanUseWoodRes, self._onUpdate, self)

	local cfg = AshlessLongYanConfig.instance:getBuffCfg(self._activityId, self._phaseId) or {}

	self._descScrollerList:reloadData(cfg)
	self:_onUpdate()
end

function AshlessLongYanBonfireTipsView:onExit()
	AshlessLongYanBonfireTipsView.super.onExit(self)
	self._descScrollerList:dispose()
end

function AshlessLongYanBonfireTipsView:_onUpdate()
	self._txtFinish.text = self._longYanMo:getPassStageCount(self._phaseId, LongYanEnum.StageType_Bonfire)
end

function AshlessLongYanBonfireTipsView:_updateDescCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtCount.text = data.fireCount
	txtDesc.text = data.desc
end

function AshlessLongYanBonfireTipsView:_clearDescCell(cell)
	return
end

return AshlessLongYanBonfireTipsView
