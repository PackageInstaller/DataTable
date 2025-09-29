-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/map/RoguePropListTips.lua

module("logic.extensions.roguelike.view.explore.map.RoguePropListTips", package.seeall)

local M = class("RoguePropListTips")

function M:ctor(container)
	local go = container.gameObject

	self._go = go
	self._goPropContent = goutil.findChild(go, "viewPort/content")
	self._goPropItem = self._goPropContent.transform:GetChild(0).gameObject
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnClose"))

	self._btnClick:AddClickListener(self._clickClose, self)
	self:initPropItems()
end

function M:initPropItems()
	self._propItems = {}
	self._propItemCells = {}
end

function M:updateData()
	for k, v in ipairs(self._propItemCells) do
		goutil.setActive(v, false)
	end

	local allProp = RoguelikeModel.instance:getAllPropNOs()
	local go = self._goPropItem

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
			local goNew = Astral.GameObjectUtil.CloneAndSetParent(go, self._goPropContent.transform, nil)

			item = Astral.LuaComponentContainer.Add(goNew, RoguePropItem)

			table.insert(self._propItems, item)
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

			ViewMgr.instance:open(ViewName.RoguePropTips, code)
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_SELECT_PROP, v)
		end

		item:updateData(data)
	end

	self:setActive(true)
end

function M:_clickClose()
	self:setActive(false)
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:setItemClickCallback(callback)
	self._itemClickCallback = callback
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_PROP, self._onPropRefresh, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_PROP, self._onPropRefresh, self)
	end
end

function M:_onPropRefresh()
	self:updateData()
end

function M:OnDestroy()
	if self._btnClick then
		self._btnClick:RemoveClickListener()

		self._btnClick = nil
	end

	self:setEvent(false)
end

return M
