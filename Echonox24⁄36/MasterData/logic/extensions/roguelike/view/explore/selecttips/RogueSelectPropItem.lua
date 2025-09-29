-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/selecttips/RogueSelectPropItem.lua

module("logic.extensions.roguelike.view.explore.selecttips.RogueSelectPropItem", package.seeall)

local PropItem = class("RogueSelectPropItem")

function PropItem:ctor(go)
	self._go = go.gameObject
end

function PropItem:Awake()
	self:init()
end

function PropItem:init()
	local go = self._go

	self._goSelect = goutil.findChild(go, "select")
	self._goSign = goutil.findChild(go, "sign")
	self._txtName = goutil.findChildComponent(go, "txtName", UIComponentType.Text)
	self._txtContent = goutil.findChildComponent(go, "txtContent", UIComponentType.Text)
	self._imgQuality = goutil.findChildImageComponent(go, "propItem/backpack_item/imgQuality")
	self._imgQuality2 = goutil.findChildImageComponent(go, "propQuality")
	self._imgIcon = goutil.findChildImageComponent(go, "propItem/backpack_item/imgIcon")
	self._btnClick = UIComponentType.ButtonAdapter(go)

	self._btnClick:AddClickListener(self.onClick, self)
end

function PropItem:onClick()
	if self._callback then
		self._callback(self._propId)
	end
end

function PropItem:updateData(data)
	local propId = data.propId

	if propId == nil then
		goutil.setActive(self._go, false)

		return
	end

	self._propId = propId

	local propCo = RoguelikeConfig.instance:getPropById(propId)

	if not propCo then
		return
	end

	self._callback = data.callback
	self._txtName.text = propCo.name

	local linkText = propCo.link ~= "" and "\n\n" .. propCo.link or ""

	self._txtContent.text = StringUtil.replaceAllGraphicText2(propCo.descirption .. linkText)

	if data.content then
		self._txtContent.text = data.content
	end

	IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, propCo.art)
	IconLoader.setSprite(self._imgQuality, IconType.Skinlib, GameUrl.getItemQualityUrl(propCo.rarity + 1))
	IconLoader.setSprite(self._imgQuality2, IconType.DynSpriteAtlas_Dice, GameUrl.getRoguePropItemQualityUrl(propCo.rarity + 1))

	local isSign = false
	local effectIds = propCo.effectIds

	for k, v in pairs(effectIds or {}) do
		if v == 10000000 then
			isSign = true
		end
	end

	goutil.setActive(self._goSign, isSign)
	self:setSelect(false)
	self:setActive(true)
end

function PropItem:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function PropItem:setSelect(isSelect)
	goutil.setActive(self._goSelect, isSelect)
end

function PropItem:OnDestroy()
	self._txtName = nil
	self._txtContent = nil
	self._callback = nil

	self._btnClick:RemoveClickListener()

	self._btnClick = nil
end

return PropItem
