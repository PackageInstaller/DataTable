-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/enter/AirWorkTemplateSelectView.lua

module("logic.extensions.airworkshop.flow.defflow.view.enter.AirWorkTemplateSelectView", package.seeall)

local M = class("AirWorkTemplateSelectView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtnByPath("middle_tips_common_bg/btnClose")
	self._btnBg = self:getBtnByPath("middle_tips_common_bg/clickExit")
	self._scrollRectGo = self:getGoByPath("content/themeScroll")
	self._sceneloopGridView = LoopGridViewHelper.New(self._scrollRectGo)

	self._sceneloopGridView:InitGridView(0, self._updateScrollCell, self)

	self._templateCOList = {}
	self._btnUse = self:getBtnByPath("content/btnUse")
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnBg:AddClickListener(self._onClickClose, self)
	self._btnUse:AddClickListener(self._onClickUse, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnBg:RemoveClickListener()
	self._btnUse:RemoveClickListener()
end

function M:onDestroy()
	self._sceneloopGridView:Dispose()
end

function M:_setEvents(isAdd)
	if isAdd then
		AirWorkDispatcher:addEventListener(AirWorkShopEventType.ON_TEMPLATE_UPDATE, self._onTemplateUpdate, self)
	else
		AirWorkDispatcher:removeEventListener(AirWorkShopEventType.ON_TEMPLATE_UPDATE, self._onTemplateUpdate, self)
	end
end

function M:_onTemplateUpdate()
	self._sceneloopGridView:RefreshAllShownItem()
end

function M:onEnter()
	self._selectIdx = -1

	self:_setEvents(true)
	self:_init()
	self:_updateView()
end

function M:_init()
	local params = self:getOpenParam()

	self._sceneId = params[1]
	self._levelId = params[2]

	table.clear(self._templateCOList)
	table.insert(self._templateCOList, false)
	AirWorkShopConfig.instance:getAllAirTemplateCOBySceneId(self._sceneId, self._templateCOList)
	self:_checkForSendRequest()
end

function M:_checkForSendRequest()
	local requestIds = {}

	for i, v in ipairs(self._templateCOList) do
		if v and not AirWorkMapModel.instance:getTemplateScene(v.id) then
			table.insert(requestIds, v.id)
		end
	end

	if #requestIds > 0 then
		AirWorkShopDefAgent.instance:sendGetAirMapTemplatesRequest(requestIds)
	end
end

function M:_updateView()
	self._sceneloopGridView:SetListItemCount(#self._templateCOList)
	self._sceneloopGridView:RefreshAllShownItem()
end

function M:onExit()
	self:_setEvents(false)
	table.clear(self._themeCOList)
	table.clear(self._scenesInThemeList)
end

function M:_updateScrollCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._sceneloopGridView:NewListViewItem("theme_item")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, AirWorkTemplateItem)
	local co = self._templateCOList[curIndex]

	itemView.mainGO.name = string.format("theme_item_%d", curIndex)

	itemView:setData(co, curIndex, self._sceneId)
	itemView:setSeleted(self._selectIdx == curIndex)
	itemView:setClickCallBack(self._onSelectScene, self)

	return item
end

function M:_onSelectScene(idx)
	self._selectIdx = idx

	self._sceneloopGridView:RefreshAllShownItem()
end

function M:_onClickClose()
	self:close()
end

function M:_onClickUse()
	if not AirWorkShopModel.instance:hasAgreeProtocol() then
		FloatWordMgr.instance:show("请先阅读工坊协议")

		return
	end

	if self._selectIdx <= 0 then
		FloatWordMgr.instance:show(lang("tip_airwork_select_one_scene"))

		return
	end

	if AirWorkShopDefMgr.instance:isInDefFlow() then
		local info = {}

		info.clickRightCallBackFunc = self._ensureCreate
		info.clickRightCallBackHandler = self
		info.content = lang("tip_airwork_change_scene_ensure")
		info.leftTxt = lang("tip_airwork_cancel")
		info.rightTxt = lang("tip_airwork_ensure_2")

		ViewMgr.instance:open(ViewName.CommonConfirmTips, info)
	else
		self:_ensureCreate()
	end
end

function M:_ensureCreate()
	local mapMO

	if not self._templateCOList[self._selectIdx] then
		mapMO = AirWorkMapMO.New()

		mapMO:init(self._sceneId)
	else
		local templateCo = self._templateCOList[self._selectIdx]

		mapMO = AirWorkMapModel.instance:getTemplateScene(templateCo.id)

		if mapMO then
			mapMO = mapMO:deepCopy()

			mapMO:clearHeroAndAmubush()
		end
	end

	if mapMO then
		ViewMgr.instance:close(ViewName.AirWorkShopDefThemeSelectView)
		AirWorkShopDefMgr.instance:enter(self._levelId, mapMO)
		self:close()
	else
		FloatWordMgr.instance:show(lang("tip_airwork_template_not_get"))
	end
end

return M
