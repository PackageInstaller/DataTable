-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/monument/MonumentFilterPanelView.lua

module("logic.extensions.playerinfo.view.monument.MonumentFilterPanelView", package.seeall)

local M = class("MonumentFilterPanelView")
local _index2type = {
	CommEnum.MonumentFilterType.All,
	CommEnum.MonumentFilterType.Type1,
	CommEnum.MonumentFilterType.Type2
}

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self._mainGo:SetActive(false)
	self:_buildUI()
end

function M:_buildUI()
	self._toggleCompList = {}
	self._toggleGroup = self._mainGo:GetComponent(UIComponentType.SpaceXToggleGroup)

	local toggleGoList = Astral.GameObjectUtil.GetChildren(self._mainGo)

	for index = 0, toggleGoList.Length - 1 do
		local toggleComp = toggleGoList[index]:GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._toggleCompList, toggleComp)
		toggleComp:AddListener(function(_, isOn)
			if isOn then
				self:_dealToggleClick(index + 1, isOn)
			end
		end, nil)

		if not _index2type[index + 1] then
			toggleGoList[index]:SetActive(false)
			goutil.findChild(toggleGoList[index], "normal"):SetActive(false)
		else
			local labelName = MonumentModel.instance:getLabelName(index)
			local textComp = goutil.findChildTextComponent(toggleGoList[index], "normal/Text")

			textComp.text = labelName
			textComp = goutil.findChildTextComponent(toggleGoList[index], "select/Text")
			textComp.text = labelName
		end
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

	if visible then
		local filterType = MonumentController.instance:getMonumentFilterType()
		local index = table.indexof(_index2type, filterType)

		self._toggleCompList[index].IsOn = true
	end
end

function M:getVisible()
	return self._mainGo.activeSelf
end

function M:_dealToggleClick(index)
	MonumentController.instance:setMonumentFilterType(_index2type[index])
	self:setVisible(false)
end

return M
