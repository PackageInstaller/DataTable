-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaHeroCell.lua

module("logic.extensions.arena.view.ArenaHeroCell", package.seeall)

local ArenaHeroCell = class("ArenaHeroCell")
local LuaComponentContainer = Framework.LuaComponentContainer

function ArenaHeroCell.AddOnce(go)
	local component = ArenaHeroCell.Get(go)

	component = component or LuaComponentContainer.Add(go, ArenaHeroCell)

	return component
end

function ArenaHeroCell.Remove(go)
	LuaComponentContainer.Remove(go, ArenaHeroCell)
end

function ArenaHeroCell.Get(go)
	return (LuaComponentContainer.Get(go, ArenaHeroCell))
end

function ArenaHeroCell:ctor(container)
	self._container = container
	self._zoneId = 0
end

function ArenaHeroCell:initCell(data)
	self._zoneId = data.zoneId

	local _Txt_Title = goutil.findChildTextComponent(self._container, "Txt_Title")

	_Txt_Title.text = ArenaModel.instance:getZoneName(data.zoneId)

	for i, v in ipairs(data.topInfos) do
		local cell = goutil.findChild(self._container, "Cell_" .. i)

		if cell then
			cell.gameObject:SetActive(true)
			self:_initCellWithData(cell, data.topInfos[i])
		end
	end

	self._Txt_Detail = goutil.findChildComponent(self._container, "Txt_Detail", "UIGraphicText")

	self._Txt_Detail:AddClickListener(self._herfPointer, self)

	self._Txt_Detail.text = "<a href=\"内容\">详细排名</a>"
end

function ArenaHeroCell:_initCellWithData(cell, cellData)
	if cellData.position ~= 1 then
		local _Txt_Rank = goutil.findChildTextComponent(cell, "Txt_Rank")

		_Txt_Rank.text = cellData.position
	end

	local _Txt_Name = goutil.findChildTextComponent(cell, "Txt_Name")

	_Txt_Name.text = cellData.userName

	local _Txt_Power = goutil.findChildTextComponent(cell, "Txt_Power")

	_Txt_Power.text = cellData.everMaxZdl

	local _Txt_Union = goutil.findChildTextComponent(cell, "Txt_Union")

	_Txt_Union.text = cellData.familyName
end

function ArenaHeroCell:_herfPointer()
	printInfo("self._zoneId:" .. self._zoneId)
	ArenaAgent.instance:sendGetTopDetailReq(self._zoneId, 1, 100)
end

function ArenaHeroCell:onDelete()
	self._Txt_Detail:RemoveClickListener()
end

return ArenaHeroCell
