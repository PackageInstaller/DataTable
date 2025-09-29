-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueEquipDescBox.lua

module("logic.extensions.roguelike.view.widgets.RogueEquipDescBox", package.seeall)

local M = class("RogueEquipDescBox")

function M:ctor(root)
	self._root = root
	self._itemClone = goutil.findChild(root, "lay_item")
end

function M:upadateData(desc)
	local root = self._root.transform
	local childrenNum = root.childCount
	local descs = string.split(desc, "○")
	local descs1 = {}
	local needShowNum = 0

	for k, v in pairs(descs) do
		if v ~= "" then
			needShowNum = needShowNum + 1

			table.insert(descs1, needShowNum, v)
		end
	end

	local toAddNum = needShowNum - childrenNum + 1

	if toAddNum > 0 then
		self:_addNewItem(toAddNum)
	else
		self:_hideItem(toAddNum)
	end

	for i = 1, needShowNum do
		local item = root:GetChild(i)
		local txtChild = item:GetChild(1)
		local txt = txtChild:GetComponent(goutil.Type_UIText)

		txt.text = StringUtil.replaceAllGraphicText2(descs1[i])

		goutil.setActive(item.gameObject, true)
	end
end

function M:_addNewItem(num)
	for i = 1, num do
		goutil.cloneAndSetParent(self._itemClone, self._root.transform)
	end
end

function M:_hideItem(num)
	local root = self._root.transform
	local childrenNum = root.childCount

	for i = num, -1 do
		local child = root:GetChild(childrenNum + i)

		goutil.setActive(child.gameObject, false)
	end
end

return M
