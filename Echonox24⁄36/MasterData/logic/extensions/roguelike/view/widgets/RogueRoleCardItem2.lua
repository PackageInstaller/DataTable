-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueRoleCardItem2.lua

module("logic.extensions.roguelike.view.widgets.RogueRoleCardItem2", package.seeall)

local M = class("RogueRoleCardItem2")

function M:ctor(go)
	self._go = go
	self._imgIcon = goutil.findChildComponent(go, "cardInfo/cardBg/charaterIcon", UIComponentType.Image)
	self._txtHp = goutil.findChildComponent(go, "cardInfo/txtHp", UIComponentType.Text)
	self._txtSan = goutil.findChildComponent(go, "cardInfo/txtSan", UIComponentType.Text)
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click"))

	self:bindEvents()
end

function M:bindEvents()
	self._btnClick:AddClickListener(self.onClick, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:setHp(hp)
	self._txtHp.text = hp
end

function M:setSan(san)
	self._txtSan.text = san
end

function M:setHeadIcon(roleId)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(roleId)

	IconLoader.setSprite(self._imgIcon, IconType.Head, characterCO.modelId)
end

function M:updateData(data)
	local roleId = data.roleId

	self._index = data.index
	self._clickCallback = data.callback

	local prop = RogueMgr.instance:getModel():getRoleMoByRoleId(roleId).roleProp

	self:setHp(prop:getHp())
	self:setSan(prop:getSan())
	self:setHeadIcon(roleId)
	goutil.setActive(self._go, true)
end

function M:onClick()
	if self._clickCallback then
		self._clickCallback(self._index)
	end
end

return M
