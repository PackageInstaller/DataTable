-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/item/impl/BuffDetailItem.lua

module("logic.common.viewlib.item.impl.BuffDetailItem", package.seeall)

local M = class("BuffDetailItem", UIReusableLuaBehavior)

function M:buildUI()
	self._imgBg = goutil.findChildImageComponent(self.mainGO, "Image1")
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "icon")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtBuffName")
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "content")
	self._goRound = goutil.findChild(self.mainGO, "countdown")
	self._txtRound = goutil.findChildTextComponent(self.mainGO, "countdown/text")
	self._goLayer = goutil.findChild(self.mainGO, "countLayer")
	self._txtLayer = goutil.findChildTextComponent(self.mainGO, "countLayer/text")
end

function M:destroyUI()
	self._imgBg = nil
	self._imgIcon = nil
	self._txtName = nil
	self._txtContent = nil
	self._goRound = nil
	self._txtRound = nil
	self._goLayer = nil
	self._txtLayer = nil
end

function M:onEnter()
	return
end

function M:onExit()
	IconLoader.clearSprite(self._imgBg)
	IconLoader.clearSprite(self._imgIcon)
end

function M:setBuffId(buffId)
	local buffCO = BuffConfig.instance:getBuffCO(buffId)

	self._txtName.text = buffCO.name
	self._txtContent.text = buffCO.desc

	IconLoader.setSprite(self._imgIcon, IconType.BuffIcon, buffCO.buffIcon)
	IconLoader.setSprite(self._imgBg, IconType.Skinlib, BuffCOUtil.getBuffBgOfTips(buffCO))
	goutil.setActive(self._goRound, false)
end

function M:setRound(round)
	if round >= 0 then
		goutil.setActive(self._goRound, true)

		self._txtRound.text = round
	end
end

function M:setLayerAndMaxLayer(layer, maxLayer)
	if layer > 0 then
		goutil.setActive(self._goLayer, true)

		self._txtLayer.text = string.format(lang("t_buff_detail_item_layer_format"), layer, maxLayer)
	end
end

return M
