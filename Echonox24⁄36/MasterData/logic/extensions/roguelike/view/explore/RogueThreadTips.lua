-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueThreadTips.lua

module("logic.extensions.roguelike.view.explore.RogueThreadTips", package.seeall)

local ThreadItem = class("ThreadItem")

function ThreadItem:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
end

function ThreadItem:Awake()
	local go = self._go

	self._goItem = goutil.findChild(go, "cell/backpack_item")
	self._goNew = goutil.findChild(go, "cell/newSign")
	self._itemGo = goutil.findChild(go, "cell/backpack_item")
	self._txtName = goutil.findChildTextComponent(go, "txtThreadName")
	self._txtDesc = goutil.findChildTextComponent(go, "txtThreadDesc")
end

function ThreadItem:updateData(data, index)
	self._txtName.text = data:getName()
	self._txtDesc.text = data:getItemDesc()

	local view = Astral.LuaComponentContainer.Add(self._itemGo, RogueThreadItem)
	local data1 = {}

	data1.itemId = data:getItemId()

	function data1.callback()
		local itemCO = BackpackConfig.instance:getItemInfoByItemId(data:getItemId())

		ViewMgr.instance:open(ViewName.RogueMemoryThread, itemCO)
	end

	view:updateData(data1)
	goutil.setActive(self._goNew, false)
end

function ThreadItem:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

local M = class("RogueThreadTips")

function M:ctor(go)
	self._go = go.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
	self._threadItems = {}
end

function M:Awake()
	self:init()
end

function M:init()
	local registry = self._viewElementsRegistry

	self._btnClose = UIComponentType.ButtonAdapter(registry:findUIElement("run_group_role_tips_582271652"))
	self._threadScrollGo = registry:findUIElement("run_group_thread_tips_-350012639")
	self._goThreadItem = registry:findUIElement("run_group_thread_tips_-597907886")
	self._scrollView = LoopListHelper.New(self._threadScrollGo)

	self._scrollView:InitListView(0, self._updateCell, self)
	self._btnClose:AddClickListener(self._clickClose, self)
end

function M:_clickClose()
	self:setActive(false)

	if self._closeCallback then
		self._closeCallback()
	end
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:setCloseCallback(callback)
	self._closeCallback = callback
end

function M:updateData()
	self._curShowList = ItemModel.instance:getItemsByTS(GameEnum.ItemTypeEnum.RoguelikeClueType, 0) or {}

	self._scrollView:SetListItemCount(#self._curShowList, true)
	self._scrollView:RefreshAllShownItem()
	self:setActive(true)
end

function M:_updateCell(curIndex)
	if curIndex < 0 then
		return nil
	end

	curIndex = curIndex + 1

	local item = self._scrollView:NewListViewItem("thread_item")

	if self._curShowList then
		local itemData = self._curShowList[curIndex]
		local shower = Astral.LuaComponentContainer.Add(item.gameObject, ThreadItem)

		shower.view = self

		shower:updateData(itemData, curIndex)
	end

	return item
end

function M:OnDestroy()
	self._btnClose:RemoveClickListener()

	self._btnClose = nil
end

return M
