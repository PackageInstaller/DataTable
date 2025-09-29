-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewteammessage/BattleTeamMessageView.lua

module("logic.extensions.battle.viewteammessage.BattleTeamMessageView", package.seeall)

local M = class("BattleTeamMessageView", ViewComponent)

function M:createMessage(title, content, heroIdList)
	return {
		title = title,
		content = content,
		heroIdList = heroIdList
	}
end

function M:buildUI()
	self._txtTitle = self:getTextByPath("universal_second_tips_common_bg/content/txtTitle")
	self._txtDesc = self:getTextByPath("allContent/txtDesc")
	self._btnConfirm = self:getBtnByPath("allContent/btnConfirm")
	self._btnClose = self:getBtnByPath("universal_second_tips_common_bg/content/btnClose")
	self._goHeroHeadContent = self:getGoByPath("allContent/headScroll/viewPort/heroHeadList")
	self._heroItemCollection = ViewlibCollection.New(ViewlibResPath.HeroHeadItem, 5)
	self._currentIndex = 0
end

function M:destroyUI()
	self._txtTitle = nil
	self._txtDesc = nil
	self._btnConfirm = nil
	self._btnClose = nil
	self._goHeroHeadContent = nil
	self._heroItemCollection = nil
end

function M:bindEvents()
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._btnClose:AddClickListener(self._onClickConfirm, self)
end

function M:unbindEvents()
	self._btnConfirm:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self._currentIndex = 0

	self:_tryShowNextMessage()
end

function M:onExit()
	local instances = self._heroItemCollection:getAllInstances()

	for _, heroItem in pairs(instances) do
		heroItem:playCloseAnimation()
		heroItem:unbindEvents()
	end
end

function M:_onClickConfirm()
	self:_tryShowNextMessage()
end

function M:_tryShowNextMessage()
	local messageInfoList = self:getFirstParam()
	local totalMessageCount = messageInfoList and #messageInfoList

	if totalMessageCount <= self._currentIndex then
		self:close()

		return
	end

	self._currentIndex = self._currentIndex + 1

	local messageInfo = messageInfoList[self._currentIndex]

	self._txtTitle.text = messageInfo.title
	self._txtDesc.text = messageInfo.content

	self:_setHeroHeadList(messageInfo.heroIdList)
end

function M:_setHeroHeadList(heroIdList)
	self._heroItemCollection:clearAllInstance()

	for _, heroId in pairs(heroIdList) do
		local heroItem = self._heroItemCollection:createInstance(self._goHeroHeadContent)
		local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

		heroItem:playOpenAnimation()
		heroItem:setHeroMO(heroMO)
		heroItem:showCamp(true)
	end
end

return M
