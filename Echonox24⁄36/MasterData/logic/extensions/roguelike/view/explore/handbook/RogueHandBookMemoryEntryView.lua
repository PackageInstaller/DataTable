-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/handbook/RogueHandBookMemoryEntryView.lua

module("logic.extensions.roguelike.view.explore.handbook.RogueHandBookMemoryEntryView", package.seeall)

local RogueMemoryItem = class("RogueMemoryItem")

function RogueMemoryItem:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform

	self:init()
end

function RogueMemoryItem:init()
	local go = self._go

	self._goNew = goutil.findChild(go, "newSign")
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click"))
	self._txtFill = goutil.findChildTextComponent(go, "txtFill")
	self._txtName = goutil.findChildTextComponent(go, "txtName")
	self._imgFill = goutil.findChildImageComponent(go, "fillDi/fill")
	self._imgBg = goutil.findChildImageComponent(go, "imgCard")

	self._btnClick:AddClickListener(self._onClick, self)
end

function RogueMemoryItem:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function RogueMemoryItem:updateData(data)
	self._callback = data.callback
	self._txtName.text = data.name
	self._txtFill.text = data.progressText
	self._imgFill.fillAmount = data.progress

	IconLoader.setSprite(self._imgBg, IconType.RunGroup, data.icon)
	self:setActive(true)
end

function RogueMemoryItem:OnDestroy()
	self._btnClick:RemoveClickListener()

	self._goNew = nil
	self._btnClick = nil
	self._txtFill = nil
	self._txtName = nil
	self._imgFill = nil
end

function RogueMemoryItem:_onClick()
	if self._callback then
		self._callback()
	end
end

local M = class("RogueHandBookMemoryEntryView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._allItems = {}
end

function M:buildUI()
	self._traMemoryContent = self:getGo("run_group_handbook_memory_entry_view_-105171671").transform
	self._goMemoryItem = self:getGo("handbook_record_entry_view_210071424")

	goutil.setActive(self._goMemoryItem, false)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_THREAD_INFO_REFRESH, self._onThreadRefresh, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_THREAD_INFO_REFRESH, self._onThreadRefresh, self)
	end
end

function M:onEnter()
	self:setEvent(true)
	RoguelikeAgent.instance:sendLoadLogsRequest()
end

function M:onExit()
	self:setEvent(false)
end

function M:_onThreadRefresh()
	self:updateData()
end

function M:updateData()
	local allScripts = RoguelikeConfig.instance:getAllGallery()

	for k, v in pairs(self._allItems) do
		v:setActive(false)
	end

	table.sort(allScripts, function(a, b)
		local aIsCommunal = a.isCommunal
		local bIsCommunal = b.isCommunal

		if aIsCommunal ~= bIsCommunal then
			return bIsCommunal < aIsCommunal
		else
			return a.id > b.id
		end
	end)

	for k, v in ipairs(allScripts) do
		local item = self._allItems[k]

		if not item then
			local go = goutil.cloneAndSetParent(self._goMemoryItem, self._traMemoryContent)

			item = Astral.LuaComponentContainer.Add(go, RogueMemoryItem)
			self._allItems[k] = item
		end

		local data = {}
		local temp = v
		local curCount, allCount = RoguelikeUtil.instance:getScriptMemoryProgress(v.id)

		function data.callback()
			ViewMgr.instance:open(ViewName.RogueMemoryMain, temp, curCount, allCount)
		end

		data.name = v.name
		data.progress = curCount / allCount
		data.progressText = math.floor(curCount / allCount * 100) .. "\n<size=22>%</size>"
		data.icon = k == 1 and "rungroup_memory_entry_card/rungroup_memory_entry_card1" or "rungroup_memory_entry_card/rungroup_memory_entry_card2"

		item:updateData(data)
	end
end

return M
