-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/view/RoomBackpackFilterPanelView.lua

module("logic.extensions.housebackpack.view.RoomBackpackFilterPanelView", package.seeall)

local M = class("RoomBackpackFilterPanelView")
local cfg = {
	[CommEnum.RoomBackpackShowType.FurnitureShowType] = {
		index2type = {
			CommEnum.RoomFurnitureFilterType.All,
			CommEnum.RoomFurnitureFilterType.Using,
			CommEnum.RoomFurnitureFilterType.NotUsing
		},
		nameList = CommEnum.FurnitureFilterType2Name
	},
	[CommEnum.RoomBackpackShowType.DrawingShowType] = {
		index2type = {
			CommEnum.RoomDrawingFilterType.All,
			CommEnum.RoomDrawingFilterType.NotOwned,
			CommEnum.RoomDrawingFilterType.Owned
		},
		nameList = CommEnum.DrawingFilterType2Name
	},
	[CommEnum.RoomBackpackShowType.TradeMaterialShowType] = {
		index2type = {
			CommEnum.RoomTradeMaterialFilterType.All,
			CommEnum.RoomTradeMaterialFilterType.Quality,
			CommEnum.RoomTradeMaterialFilterType.Category
		},
		nameList = CommEnum.TradeMaterialFilterType2Name
	}
}

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self._mainGo:SetActive(false)
	self:_buildUI()
end

function M:_buildUI()
	self._toggleCompList = {}
	self._lineList = {}
	self._toggleGroup = self._mainGo:GetComponent(UIComponentType.SpaceXToggleGroup)

	local toggleGoList = Astral.GameObjectUtil.GetChildren(self._mainGo)

	for index = 0, toggleGoList.Length - 1 do
		local toggleComp = toggleGoList[index]:GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._toggleCompList, toggleComp)
		toggleComp:AddListener(function(_, isOn)
			if isOn then
				self:_dealToggleSwitch(index + 1, isOn)
			end
		end, nil)
		table.insert(self._lineList, goutil.findChild(toggleGoList[index], "normal/line"))
	end
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	return
end

function M:setVisible(visible)
	self._mainGo:SetActive(visible)
end

function M:getVisible()
	return self._mainGo.activeSelf
end

function M:_dealToggleSwitch(index)
	for _index, lineGo in ipairs(self._lineList) do
		lineGo:SetActive(_index ~= index - 1)
	end

	local showType = self._showType
	local filterCfg = RoomBackpackModel.instance:getFilterCfg(showType)
	local _index2type = cfg[showType].index2type

	filterCfg:setFilterType(_index2type[index])
	GlobalDispatcher:dispatchEvent(EventType.ROOM_BACKPACK_FILTER_EVENT, showType)
	self:setVisible(false)
end

function M:setShowType(showType)
	self._showType = showType

	local _index2type = cfg[showType].index2type
	local _nameList = cfg[showType].nameList
	local toggleGoList = Astral.GameObjectUtil.GetChildren(self._mainGo)

	for index = 0, toggleGoList.Length - 1 do
		local textTextComp = goutil.findChildTextComponent(toggleGoList[index], "Text")

		textTextComp.text = _nameList[_index2type[index + 1]]
	end

	local filterCfg = RoomBackpackModel.instance:getFilterCfg(showType)
	local index = table.indexof(_index2type, filterCfg:getFilterType())

	self._toggleCompList[index].IsOn = true
end

return M
