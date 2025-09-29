-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uibubble/impl/BubbleBuffAddHint.lua

module("logic.battle.uibubble.impl.BubbleBuffAddHint", package.seeall)

local BubbleBuffAddHint = class("BubbleBuffAddHint")

function BubbleBuffAddHint:ctor(mainGO)
	self.mainGO = mainGO

	self:buildUI()
end

function BubbleBuffAddHint:buildUI()
	self._txtBuff = goutil.findChildTextComponent(self.mainGO, "txtBuff")
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "buff_icon/pos/imgIcon")
end

function BubbleBuffAddHint:destroyUI()
	self._animation = nil
	self._goAdd = nil
	self._txtBuff = nil
	self._txtMinus = nil
	self._imgIcon = nil
end

function BubbleBuffAddHint:getHeight()
	return 35
end

function BubbleBuffAddHint:resetUI()
	return
end

function BubbleBuffAddHint:setVisible(status)
	goutil.setActive(self.mainGO, status)
end

function BubbleBuffAddHint:setBubbleContent(buffCode)
	local buffCO = BuffConfig.instance:getBuffCO(buffCode)

	self._txtBuff.text = buffCO.name

	IconLoader.setSprite(self._imgIcon, IconType.BuffIcon, buffCO.buffIcon)
end

return BubbleBuffAddHint
