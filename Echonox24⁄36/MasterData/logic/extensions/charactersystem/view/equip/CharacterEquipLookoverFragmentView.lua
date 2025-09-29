-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/CharacterEquipLookoverFragmentView.lua

module("logic.extensions.charactersystem.view.equip.CharacterEquipLookoverFragmentView", package.seeall)

local M = class("CharacterEquipLookoverFragmentView", CharacterEquipFragmentView)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	M.super.buildUI(self)
	self:setIsOtherPlayer(true)
end

function M:onClickEquipItem()
	return
end

function M:_setRedPoint()
	return
end

return M
