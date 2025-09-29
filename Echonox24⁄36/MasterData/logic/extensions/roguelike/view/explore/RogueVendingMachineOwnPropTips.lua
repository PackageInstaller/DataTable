-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueVendingMachineOwnPropTips.lua

module("logic.extensions.roguelike.view.explore.RogueVendingMachineOwnPropTips", package.seeall)

local M = class("RogueVendingMachineOwnPropTips")

function M:ctor(go)
	self._go = go.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	self:init()
end

function M:init()
	local go = self._go

	self._btnClose = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnClose"))
	self._goPropsContent = goutil.findChild(go, "viewPort/content")

	self._btnClose:AddClickListener(self._clickClose, self)
	self:initPropItems()
end

function M:initPropItems()
	self._propItems = {}
	self._propItemCells = {}
end

function M:_clickClose()
	self:setActive(false)
end

function M:setActive(isActive)
	if isActive then
		self:updateData()
	end

	goutil.setActive(self._go, isActive)
end

function M:setItemClickCallback(callback)
	self._itemClickCallback = callback
end

function M:updateData()
	for k, v in ipairs(self._propItemCells) do
		goutil.setActive(v, false)
	end

	local allProp = RoguelikeModel.instance:getAllPropNOs()
	local go = goutil.findChild(self._goPropsContent, "backpack_item")

	table.sort(allProp, function(a, b)
		local aAsh = a.ash and 1 or 0
		local bAsh = b.ash and 1 or 0

		if aAsh == bAsh then
			local aRarity = RoguelikeConfig.instance:getPropById(a.code).rarity
			local bRarity = RoguelikeConfig.instance:getPropById(b.code).rarity

			if aRarity == bRarity then
				return a.code > b.code
			else
				return bRarity < aRarity
			end
		else
			return bAsh < aAsh
		end
	end)

	for idx, v in ipairs(allProp) do
		local item = self._propItems[idx]

		if not item then
			local goNew = Astral.GameObjectUtil.CloneAndSetParent(go, self._goPropsContent.transform, nil)

			item = Astral.LuaComponentContainer.Add(goNew, RoguePropItem)

			table.insert(self._propItemCells, goNew)
			table.insert(self._propItems, item)

			self._propItems[idx] = item
		end

		local data = {}
		local id = v.id
		local code = v.code

		data.propId = code
		data.inUsing = v.ing
		data.ash = v.ash
		data.heroId = v.heroId

		function data.callback()
			if self._itemClickCallback then
				self._itemClickCallback(v)

				return
			end

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_SELECT_PROP, v)
		end

		item:updateData(data)
		goutil.setActive(self._propItemCells[idx], true)
	end
end

function M:setEvent(isAdd)
	if isAdd then
		-- block empty
	end
end

function M:OnDestroy()
	if self._btnClose then
		self._btnClose:RemoveClickListener()
	end

	self._btnClose = nil

	for k, v in pairs(self._propItems or {}) do
		v:OnDestroy()
	end

	self._propItems = nil
end

return M
