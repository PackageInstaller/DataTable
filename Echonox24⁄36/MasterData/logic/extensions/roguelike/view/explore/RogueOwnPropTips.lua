-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueOwnPropTips.lua

module("logic.extensions.roguelike.view.explore.RogueOwnPropTips", package.seeall)

local M = class("RogueOwnPropTips")

function M:ctor(go)
	self._go = go.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	self:init()
end

function M:init()
	local registry = self._viewElementsRegistry

	self._imgCoinIcon = registry:findUIElement("props_owner_tips_-1746667504", UIComponentType.Image)
	self._txtCoinNum = registry:findUIElement("props_owner_tips_-2011382412", UIComponentType.Text)
	self._btnClose = UIComponentType.ButtonAdapter(registry:findUIElement("props_owner_tips_-1101752061"))
	self._btnExplain = UIComponentType.ButtonAdapter(registry:findUIElement("6&btn_explain_-1936547904"))
	self._goPropsContent = registry:findUIElement("props_owner_tips_-1115489800")
	self._goEmpty = registry:findUIElement("props_owner_tips_1031070202")

	self._btnClose:AddClickListener(self._clickClose, self)
	self._btnExplain:AddClickListener(self._clickExplain, self)
	self:initPropItems()
end

function M:initPropItems()
	self._propItems = {}
	self._propItemCells = {}
end

function M:_clickClose()
	self:setActive(false)
end

function M:_clickExplain()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		CommEnum.ManualKey.RogueProp
	})
end

function M:_clickThrow()
	print("丢弃")
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
	local coinNum = gold or RoguelikeModel.instance:getGold()

	self._txtCoinNum.text = coinNum

	for k, v in ipairs(self._propItemCells) do
		goutil.setActive(v, false)
	end

	local allProp = RoguelikeModel.instance:getAllPropNOs()

	goutil.setActive(self._goEmpty, #allProp == 0)

	local go = goutil.findChild(self._goPropsContent, "cell")

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
			local goItem = goutil.findChild(goNew, "backpack_item")

			item = Astral.LuaComponentContainer.Add(goItem, RoguePropItem)

			table.insert(self._propItemCells, goNew)
			table.insert(self._propItems, item)

			local goContinue = goutil.findChild(goNew, "continue")
			local goSpecial = goutil.findChild(goNew, "special")
			local goUsed = goutil.findChild(goNew, "used")

			item:setExtraParam(goContinue, goSpecial, goUsed)

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
	self._imgIcon = nil
	self._txtName = nil
	self._txtHp = nil
	self._qua6Ploygon = nil
	self._txtQua6List = nil

	if self._btnClose then
		self._btnClose:RemoveClickListener()
	end

	self._btnClose = nil

	if self._btnExplain then
		self._btnExplain:RemoveClickListener()
	end

	self._btnExplain = nil

	for k, v in pairs(self._propItems or {}) do
		v:OnDestroy()
	end

	self._propItems = nil
end

return M
