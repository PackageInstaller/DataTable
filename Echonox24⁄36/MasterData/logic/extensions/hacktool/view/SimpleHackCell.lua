-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/SimpleHackCell.lua

module("logic.extensions.hacktool.view.SimpleHackCell", package.seeall)

local M = class("SimpleHackCell", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)
end

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("name", BackpackNameComponent)
end

function M:updateData(data)
	self._data = data

	local normal = self:getComponent("normal")
	local name = self:getComponent("name")

	IconLoader.setSprite(normal._qualityFrame, IconType.Skinlib, CommEnum.Quality2ItemBg[data.quality])
	IconLoader.setSprite(normal._iconImg, data.iconTyp, data.icon)

	name._nameText.text = data.name
end

return M
