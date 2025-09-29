-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueCampAffectItem.lua

module("logic.extensions.roguelike.view.widgets.RogueCampAffectItem", package.seeall)

local M = class("RogueCampAffectItem")

function M:ctor(go)
	self._go = go.gameObject
end

function M:Awake()
	self:onInit()
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:onInit()
	local go = self._go

	self._goSelect = goutil.findChild(go, "select")
	self._imgIcon1 = goutil.findChildImageComponent(go, "Type/type1/campIcon")
	self._imgIcon2 = goutil.findChildImageComponent(go, "Type/type2/campIcon")
	self._txtNum1 = goutil.findChildTextComponent(go, "Type/num/txtNum")
	self._goType1 = goutil.findChild(go, "Type/type1")
	self._goType2 = goutil.findChild(go, "Type/type2")
	self._txtDesc = goutil.findChildTextComponent(go, "desc/desc_item")
end

function M:updateData(data)
	IconLoader.setSprite(self._imgIcon1, IconType.CharaterCampCornerIcon, CommEnum.CampType2SmallIcon[data.camp])
	IconLoader.setSprite(self._imgIcon2, IconType.CharaterCampCornerIcon, CommEnum.CampType2SmallIcon[data.camp])

	self._txtNum1.text = data.numText
	self._txtDesc.text = data.desc

	local campNum = data.campNum
	local affectNum = 3

	self._txtDesc.color = campNum < affectNum and Astral.ColorUtil.ParseColor("#838383") or Astral.ColorUtil.ParseColor("#FFFFFF")

	goutil.setActive(self._goType1, campNum < affectNum)
	goutil.setActive(self._goType2, affectNum <= campNum)
	self:setActive(true)
end

function M:setSelect(isSelect)
	goutil.setActive(self._goSelect, isSelect)
end

function M:OnDestroy()
	return
end

return M
