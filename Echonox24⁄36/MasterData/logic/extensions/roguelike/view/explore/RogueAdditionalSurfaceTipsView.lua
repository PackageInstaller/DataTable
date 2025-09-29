-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueAdditionalSurfaceTipsView.lua

module("logic.extensions.roguelike.view.explore.RogueAdditionalSurfaceTipsView", package.seeall)

local AdditionalDiceItem = class("AdditionalDiceItem")

function AdditionalDiceItem:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
end

function AdditionalDiceItem:Awake()
	local go = self._go

	self._txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	self._imgIcon = goutil.findChildImageComponent(go, "icon")
end

function AdditionalDiceItem:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function AdditionalDiceItem:updateData(data, index)
	self._txtDesc.text = data.desc

	if not data.isNormal then
		IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_Dice, string.format("dice_%s", data.pattern))
	end

	local pattern = tonumber(data.pattern) or 1
	local isRed = pattern >= RoguelikeConst.DICE_PATTERN.BLEEDING and pattern <= RoguelikeConst.DICE_PATTERN.CURSE

	self._imgIcon.color = isRed and Astral.ColorUtil.ParseColor("#c64949") or Astral.ColorUtil.ParseColor("#7cabbc")

	self:setActive(true)
end

function AdditionalDiceItem:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

local M = class("RogueAdditionalSurfaceTipsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._additionalItems = {}
end

function M:buildUI()
	self._btnClose = self:getBtn("1&middle_tips_common_bg_-1205189576")
	self._traDiceDescParent = self:getGo("additional_surface_tips_1592101907").transform
	self._goDiceDescItem1 = self:getGo("additional_surface_tips_1473890035")
	self._goDiceDescItem2 = self:getGo("additional_surface_tips_1914581772")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self:updateData()
end

function M:onExit()
	return
end

function M:updateData()
	for k, v in pairs(self._additionalItems) do
		v:setActive(false)
	end

	local allAdditionalDiceCo = RoguelikeConfig.instance:getAllFaceEffect()

	for k, v in pairs(allAdditionalDiceCo) do
		local item = self._additionalItems[k]

		if not item then
			local go

			if k == 1 then
				go = goutil.cloneAndSetParent(self._goDiceDescItem1, self._traDiceDescParent)
			else
				go = goutil.cloneAndSetParent(self._goDiceDescItem2, self._traDiceDescParent)
			end

			item = Astral.LuaComponentContainer.Add(go, AdditionalDiceItem)
			self._additionalItems[k] = item
		end

		local data = {}

		data.pattern = v.icon
		data.isNormal = k == 1
		data.desc = v.name .. ":" .. v.desc

		item:updateData(data)
	end
end

function M:_onClickClose()
	self:close()
end

return M
