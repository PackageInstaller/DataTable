-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/view/BreachFormMasterRankView.lua

module("logic.extensions.breachformmaster.view.BreachFormMasterRankView", package.seeall)

local BreachFormMasterRankView = class("BreachFormMasterRankView", ViewComponent)

function BreachFormMasterRankView:ctor()
	BreachFormMasterRankView.super.ctor(self)
end

function BreachFormMasterRankView:unbindEvents()
	BreachFormMasterRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function BreachFormMasterRankView:bindEvents()
	BreachFormMasterRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function BreachFormMasterRankView:buildUI()
	BreachFormMasterRankView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tablist = self:getGo("tablist")
	self._contentCol = self:getGo("contentCol")
	self._tabFrameWorkShow = TabFrameWorkShow.create(self, self._contentCol, self._tablist, self:_getFrameId())

	self._tabFrameWorkShow:getCommonTab():setDefaultLeafCallBack(GameUtil.handler(self._defaultLeaf, self))
end

function BreachFormMasterRankView:onExit()
	BreachFormMasterRankView.super.onExit(self)
end

function BreachFormMasterRankView:onEnter()
	BreachFormMasterRankView.super.onEnter(self)

	local param = self:getOpenParam()
	local activityId = param[1]

	BreachFormMasterModel.instance:setCurActivityId(activityId)

	local rootId = 1

	if param and param[2] then
		rootId = checknumber(param[2])
	end

	self._tabFrameWorkShow:jumpTab(rootId, (param and param[3] or nil) and checknumber(param[3]))
end

function BreachFormMasterRankView:_getFrameId()
	return 593001
end

function BreachFormMasterRankView:_defaultLeaf(tabData)
	local leafIndex = 0
	local activityId = BreachFormMasterModel.instance:getCurActivityId()
	local curStepId = BreachFormMasterModel.instance:getCurStepId(activityId)

	if tabData.root == 2 then
		if curStepId ~= 1 then
			leafIndex = curStepId - 1
		end
	else
		leafIndex = curStepId
	end

	if leafIndex == 0 then
		for i, v in ipairs(tabData.leafList) do
			leafIndex = v.leaf
		end
	end

	return leafIndex
end

return BreachFormMasterRankView
