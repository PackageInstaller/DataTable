-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/enter/AirWorkThemeSceneSelectView.lua

module("logic.extensions.airworkshop.flow.defflow.view.enter.AirWorkThemeSceneSelectView", package.seeall)

local M = class("AirWorkThemeSceneSelectView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtnByPath("title_view/layout/btnReturn_1")
	self._btnProtocol = self:getBtnByPath("allContent/btnActivityExplain")
	self._tabPanelGo = self:getGoByPath("allContent/tabList")
	self._scrollRectGo = self:getGoByPath("allContent/themeScroll")
	self._themeloopGridView = LoopGridViewHelper.New(self._tabPanelGo)

	self._themeloopGridView:InitGridView(0, self._updateScrollTab, self)

	self._sceneloopGridView = LoopGridViewHelper.New(self._scrollRectGo)

	self._sceneloopGridView:InitGridView(0, self._updateScrollCell, self)

	self._themeCOList = {}
	self._scenesInThemeList = {}
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnProtocol:AddClickListener(self._onClickProtocol, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnProtocol:RemoveClickListener()
end

function M:onDestroy()
	self._themeloopGridView:Dispose()
	self._sceneloopGridView:Dispose()
end

function M:onEnter()
	self._selectIdx = 1

	self:_init()
	self:_updateView()
	settimer(0.15, self._tryShowProtocol, self, false)
end

function M:_tryShowProtocol()
	if not AirWorkShopModel.instance:hasAgreeProtocol() then
		ViewMgr.instance:open(ViewName.AirWorkShopProtocolView, true)
	end
end

function M:_init()
	self._levelId = self:getFirstParam() or false

	local themeCOList = AirWorkShopConfig.instance:getAllTheme()

	for k, themeCO in pairs(themeCOList) do
		table.insert(self._themeCOList, themeCO)

		local sceneList = {}

		self._scenesInThemeList[themeCO.id] = sceneList

		for i, sceneId in ipairs(themeCO.sceneList) do
			local sceneCO = AirWorkShopConfig.instance:getSceneCO(sceneId)

			table.insert(sceneList, sceneCO)
		end
	end

	self._themeloopGridView:SetListItemCount(#self._themeCOList)

	if #self._themeCOList > 0 then
		self:_onSelectTab(self._themeCOList[1].id)
	end
end

function M:_onSelectTab(themeId)
	self._selectThemeId = themeId
	self._sceneCOList = self._scenesInThemeList[themeId]

	self._themeloopGridView:RefreshAllShownItem()
	self._sceneloopGridView:SetListItemCount(#self._sceneCOList)
end

function M:_updateView()
	self._sceneloopGridView:RefreshAllShownItem()
end

function M:onExit()
	removetimer(self._tryShowProtocol, self)
	table.clear(self._themeCOList)
	table.clear(self._scenesInThemeList)
end

function M:_updateScrollTab(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._themeloopGridView:NewListViewItem("tab_item")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, AirWorkThemeTabItem)
	local co = self._themeCOList[curIndex]

	itemView:setData(co)
	itemView:setSeleted(co.id == self._selectThemeId)
	itemView:setClickCallBack(self._onSelectTab, self)

	return item
end

function M:_updateScrollCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._sceneloopGridView:NewListViewItem("theme_item")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, AirWorkSceneItem)

	itemView.mainGO.name = string.format("theme_item_%d", curIndex)

	local co = self._sceneCOList[curIndex]

	itemView:setSceneCO(co, curIndex)
	itemView:setClickCallBack(self._onSelectScene, self)

	return item
end

function M:_onSelectScene(idx)
	if not AirWorkShopModel.instance:hasAgreeProtocol() then
		FloatWordMgr.instance:show("请先阅读工坊协议")

		return
	end

	local sceneCO = self._sceneCOList[idx]

	if not AirWorkShopModel.instance:getIsSceneOrBuildingUnlockById(GameEnum.UnlockTypeEnum.Scene, sceneCO.id) then
		FloatWordMgr.instance:show(lang("tip_airwork_still_locked"))

		return
	end

	self._selectIdx = idx

	self:_onClickConfirm()
end

function M:_onClickClose()
	self:close()
end

function M:_onClickConfirm()
	if self._selectIdx <= 0 then
		FloatWordMgr.instance:show(lang("tip_airwork_select_one_scene"))

		return
	end

	local sceneCO = self._sceneCOList[self._selectIdx]

	ViewMgr.instance:open(ViewName.AirWorkShopDefTemplateSelectView, sceneCO.id, self._levelId)
end

function M:_onClickProtocol()
	ViewMgr.instance:open(ViewName.AirWorkShopProtocolView, false)
end

return M
