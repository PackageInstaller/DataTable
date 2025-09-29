-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/defset/AirWorkShopTriggerConditionSelectView.lua

module("logic.extensions.airworkshop.flow.defflow.view.defset.AirWorkShopTriggerConditionSelectView", package.seeall)

local M = class("AirWorkShopTriggerConditionSelectView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtnByPath("universal_second_tips_common_bg/content/btnClose")
	self._btnCancel = Astral.SimpleLuaComponentContainer.Add(self:getGoByPath("allContent/btnCancel"), CommButton)
	self._btnEnsure = Astral.SimpleLuaComponentContainer.Add(self:getGoByPath("allContent/btnSure"), CommButton)
	self._leftScrollRectGo = goutil.findChild(self.mainGO, "allContent/scrollView1")
	self._leftLoopGridView = LoopGridViewHelper.New(self._leftScrollRectGo)

	self._leftLoopGridView:InitGridView(0, self._updateLeftCell, self)

	self._rightTxtScrollRectGo = goutil.findChild(self.mainGO, "allContent/scrollView2")
	self._rightTxtLoopGridView = LoopGridViewHelper.New(self._rightTxtScrollRectGo)

	self._rightTxtLoopGridView:InitGridView(0, self._updateRightTxtCell, self)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnEnsure:AddClickListener(self._onClickEnsure, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnCancel:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnEnsure:RemoveClickListener()
end

function M:onDestroy()
	self._leftLoopGridView:Dispose()
	self._rightTxtLoopGridView:Dispose()
end

function M:_onClickClose()
	self:close()
end

function M:_onClickEnsure()
	local condition = self._conditionCOList[self._leftIndex]
	local params = false

	if self._rightIndex > 0 then
		params = self._rightContentList[self._rightIndex]
	end

	AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.ON_MESSAGE_TRIGGER_UPDATE, condition.id, params)
	self:close()
end

function M:onEnter()
	local params = self:getOpenParam()

	self:_setSelectCondition(params[1], params[2], params[3])
end

function M:_setSelectCondition(type, condition, params)
	self._conditionType = type
	self._leftContentList = {}
	self._rightContentList = {}
	self._conditionCOList = {}

	self:_initLeftScroll()

	self._leftIndex = self:_getLeftIndexByParams(condition)

	self:_initRightScroll()

	self._rightIndex = self:_getRightIndexByParams(params)

	self:_refreshLeftScroll()
	self:_refreshRightScroll()
end

function M:_getLeftIndexByParams(condition)
	for i, co in ipairs(self._conditionCOList) do
		if condition == co.id then
			return i
		end
	end

	return 1
end

function M:_getRightIndexByParams(params)
	for i, v in ipairs(self._rightContentList) do
		if v == params then
			return i
		end
	end

	if #self._rightContentList > 0 then
		return 1
	end

	return -1
end

function M:_initLeftScroll()
	local conditionCOList = AirWorkShopConfig.instance:getAllMessageConditionCO()

	for k, co in pairs(conditionCOList) do
		local isFitForType = false

		if not co.useType and enableErrorLog then
			printError("留言时机表使用对象未配置")
		end

		for i, type in ipairs(co.useType) do
			if type == self._conditionType then
				isFitForType = true
			end
		end

		if isFitForType then
			table.insert(self._conditionCOList, co)

			if co.limit then
				table.insert(self._leftContentList, string.format(co.descStr, "<sprite name=\"fhdt01\"><sprite name=\"fhdt02\">"))
			else
				table.insert(self._leftContentList, co.descStr)
			end
		end
	end
end

function M:_initRightScroll()
	local co = self._conditionCOList[self._leftIndex]

	table.clear(self._rightContentList)

	if co.limit then
		for i, v in ipairs(co.limit) do
			table.insert(self._rightContentList, v)
		end
	end
end

function M:_refreshLeftScroll()
	self._leftLoopGridView:SetListItemCount(#self._leftContentList)
	self._leftLoopGridView:RefreshAllShownItem()
end

function M:_refreshRightScroll()
	self._rightTxtLoopGridView:SetListItemCount(#self._rightContentList)
	self._rightTxtLoopGridView:RefreshAllShownItem()
end

function M:_onSelectType(idx)
	if self._leftIndex == idx then
		return
	end

	self._leftIndex = idx
	self._rightIndex = -1

	self._leftLoopGridView:RefreshAllShownItem()
	self:_initRightScroll()

	if #self._rightContentList > 0 then
		self._rightIndex = 1
	end

	self:_refreshRightScroll()
end

function M:_onSelectRightContent(idx)
	self._rightIndex = idx

	self._rightTxtLoopGridView:RefreshAllShownItem()
end

function M:_updateLeftCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._leftLoopGridView:NewListViewItem("item1")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, AirWorkTextItem)
	local content = self._leftContentList[curIndex]

	itemView:setContentAndIndex(content, curIndex)
	itemView:setSeleted(curIndex == self._leftIndex)
	itemView:setClickCallBack(self._onSelectType, self)

	return item
end

function M:_updateRightTxtCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._rightTxtLoopGridView:NewListViewItem("item1")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, AirWorkTextItem)
	local content = self._rightContentList[curIndex]

	itemView:setContentAndIndex(content, curIndex)
	itemView:setSeleted(curIndex == self._rightIndex)
	itemView:setClickCallBack(self._onSelectRightContent, self)

	return item
end

return M
