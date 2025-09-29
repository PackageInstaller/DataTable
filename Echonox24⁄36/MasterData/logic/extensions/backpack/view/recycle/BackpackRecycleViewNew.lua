-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/recycle/BackpackRecycleViewNew.lua

module("logic.extensions.backpack.view.recycle.BackpackRecycleViewNew", package.seeall)

local M = class("BackpackRecycleViewNew", ViewComponent)
local BackpackChangedType = CommEnum.MainBackpackRefreshType

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._txtCapacity = self:getText("equip_decompose_tips_1287396436")
	self._btnClear = self:getBtn("1&com_btn_2_-31477526")
	self._btnRecycle = self:getBtn("2&btn_right_1251431307")
	self._goRewardParent = self:getGo("equip_decompose_tips_2045178698")
	self._goItem = goutil.findChild(self._goRewardParent, "backpack_item")

	goutil.setActive(self._goItem, false)

	self._rewardItemList = {}
	self._goQuickParent = self:getGo("equip_decompose_tips_1911542806")
	self._quickSelectItemViews = {}

	for key, name in pairs(EquipEnum.QualityEnum) do
		local quickItem = goutil.findChild(self._goQuickParent, "item" .. key)
		local itemView = Astral.LuaComponentContainer.Add(quickItem, BackpackRecycleViewQuickSelectItem)

		self._quickSelectItemViews[key] = itemView
	end
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClear:AddClickListener(self._onClickClearBtn, self)
	self._btnRecycle:AddClickListener(self._onClickRecycleBtn, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_RECYCLE_QUICK_CLICK_EVENT, self._handleQuickSelect, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_PAGE_DATA_CHANGED, self._onBackpackPageDataChanged, self)
end

function M:unbindEvents()
	self._btnClear:RemoveClickListener()
	self._btnRecycle:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_RECYCLE_QUICK_CLICK_EVENT, self._handleQuickSelect, self)
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_PAGE_DATA_CHANGED, self._onBackpackPageDataChanged, self)
end

function M:onEnter()
	self:_initData()
	self:_refreshView()
end

function M:_initData()
	self._quickSelectItems = {}
	self._showType = MainBackpackModel.instance:getCurShowType()
	self._limitCount = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.RecycleLimit)
	self._recycleAwards = {}
	self._recycleEquips = {}

	MainBackpackModel.instance:getRecycleItems(self._recycleEquips)
end

function M:_refreshView()
	self:_refreshReward()
	self:_refreshWQuickSelect()

	self._txtCapacity.text = #self._recycleEquips .. "/" .. self._limitCount
end

function M:_refreshWQuickSelect()
	if not self._quickSelectItems then
		self._quickSelectItems = {}
	end

	for quality, qualityName in pairs(EquipEnum.QualityEnum) do
		local item = self._quickSelectItemViews[quality]

		item:setData(quality, lang(qualityName))
		item:setStatus(self._quickSelectItems[quality])
	end
end

function M:_onBackpackPageDataChanged(e, changeType)
	if changeType == BackpackChangedType.RecycleChanged then
		MainBackpackModel.instance:getRecycleItems(self._recycleEquips)
		MainBackpackModel.instance:calRecycleGetItems(self._recycleEquips, self._recycleAwards)
		self:_refreshView()
	elseif changeType == BackpackChangedType.RecycleReplied then
		local allItems = MainBackpackModel.instance:getCurShowTypeAllItems()

		if #allItems <= 0 then
			self:close()

			return
		end

		table.clear(self._recycleEquips)
		table.clear(self._recycleAwards)
		table.clear(self._quickSelectItems)
		self:_refreshView()
	end
end

function M:_handleQuickSelect(e, quality, isSelect)
	self._quickSelectItems[quality] = isSelect

	local info = {}

	if isSelect then
		info = self._quickSelectItems
	else
		info[quality] = true
	end

	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_RECYCLE_QUICK_SELECT_CLICK, info, isSelect)
end

function M:_refreshReward()
	local index = 1

	for i = index, #self._recycleAwards do
		if not self._rewardItemList[i] then
			local go = goutil.clone(self._goItem)

			goutil.addChildToParent(go, self._goRewardParent)

			local item = Astral.LuaComponentContainer.Add(go, ItemCell)

			self._rewardItemList[i] = item
		end

		index = index + 1

		self._rewardItemList[i]:updateData(self._recycleAwards[i])
		goutil.setActive(self._rewardItemList[i]:getGo(), true)
	end

	for i = index, #self._rewardItemList do
		goutil.setActive(self._rewardItemList[i]:getGo(), false)
	end
end

function M:onExit()
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_EXIT_RECYCLE)
end

function M:_onClickCloseBtn()
	self:close()
end

function M:_onClickClearBtn()
	self:close()
end

function M:_onClickRecycleBtn()
	if not self._recycleEquips or #self._recycleEquips < 1 then
		FloatWordMgr.instance:show(lang("tip_backpack_recycle_empty"))

		return
	end

	local isOpen = self:isOpenPrinstallNoticView(self._recycleEquips)

	if isOpen then
		ViewMgr.instance:open(ViewName.CharacterPreinstallNoticeView, 1, self._recycleEquips, self)
	else
		self:_confirmCallbackPreinstall()
	end
end

function M:isOpenPrinstallNoticView(list)
	for k, v in pairs(list) do
		local temp = CharacterPreinstallController.instance:getItemList(v:getUuid())

		if temp then
			return true
		end
	end

	return false
end

function M:_confirmCallbackPreinstall()
	local param = {
		useItems = self._recycleEquips,
		showType = self._showType
	}

	ViewMgr.instance:open(ViewName.ResolveItemTips, param)
end

return M
