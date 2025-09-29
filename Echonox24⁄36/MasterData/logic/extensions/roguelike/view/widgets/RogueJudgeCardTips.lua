-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueJudgeCardTips.lua

module("logic.extensions.roguelike.view.widgets.RogueJudgeCardTips", package.seeall)

local CardEffectTipItem = class("CardEffectTipItem")

function CardEffectTipItem:ctor(go)
	self._go = go
	self._imgDi = goutil.findChildImageComponent(go, "item/imgDi")
	self._imgIcon = goutil.findChildImageComponent(go, "item/icon")
	self._imgIconNum = goutil.findChildImageComponent(go, "item/icon/imgNum")
	self._txtName = goutil.findChildTextComponent(go, "item/txtName")
	self._txtContent = goutil.findChildTextComponent(go, "item/txtContent")
end

function CardEffectTipItem:updateData(data)
	self._txtName.text = data.name
	self._txtContent.text = data.content

	local isType1 = data.color == 1 and not data.isRight

	if data.icon and data.icon ~= "" then
		IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_Dice, data.icon)

		local numSpriteName = isType1 and string.format("pt_num_zheng_%s", data.level) or string.format("pt_num_fu_%s", data.level)

		IconLoader.setSprite(self._imgIconNum, IconType.DynSpriteAtlas_Dice, numSpriteName)
	end

	if data.color then
		local color = isType1 and "#000000" or "#c1ae84"

		IconLoader.setSprite(self._imgDi, IconType.DynSpriteAtlas_Dice, isType1 and "pt_bf_0034_02" or "pt_bf_0034_01")
		TextUtils.SetColor(self._imgIcon, color)
	end

	self:setActive(true)
end

function CardEffectTipItem:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

local M = class("RogueJudgeCardTips")

function M:ctor(container)
	local go = container.gameObject

	self._go = go
	self._traContentLeft = goutil.findChild(go, "contentLeft").transform
	self._traContentRight = goutil.findChild(go, "contentRight").transform
	self._goItem = goutil.findChild(go, "dice_effect_tips")
	self._leftItems = {}
	self._rightItems = {}
end

function M:updateData(data)
	for k, v in pairs(self._leftItems) do
		v:setActive(false)
	end

	for k, v in pairs(self._rightItems) do
		v:setActive(false)
	end

	for k, v in pairs(data.leftData) do
		local item = self._leftItems[k]

		if not item then
			local go = goutil.cloneAndSetParent(self._goItem, self._traContentLeft)

			item = CardEffectTipItem.New(go)
			self._leftItems[k] = item
		end

		local data1 = {}
		local entryCo = RoguelikeConfig.instance:getCardEntryById(v)

		data1.name = entryCo.name
		data1.content = entryCo.desc

		if entryCo then
			data1.icon = entryCo.icon
			data1.level = entryCo.level
			data1.color = entryCo.color
		end

		item:updateData(data1)
	end

	for k, v in pairs(data.rightData) do
		if k < 4 then
			local item = self._rightItems[k]

			if not item then
				local go = goutil.cloneAndSetParent(self._goItem, self._traContentRight)

				item = CardEffectTipItem.New(go)
				self._rightItems[k] = item
			end

			local entryId = data.rightData[#data.rightData - k + 1]
			local data1 = {}
			local entryCo = RoguelikeConfig.instance:getCardEntryById(entryId)

			data1.name = entryCo.name
			data1.content = entryCo.desc
			data1.isRight = true

			if entryCo then
				data1.icon = entryCo.icon
				data1.level = entryCo.level
				data1.color = entryCo.color
			end

			item:updateData(data1)
		end
	end

	self:setActive(true)
end

function M:setParent(parent, isWorld)
	self._go.transform:SetParent(parent, isWorld)
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:OnDestroy()
	return
end

return M
