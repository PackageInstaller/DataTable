-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewhacker/BattleDropDownBtnHandler.lua

module("logic.extensions.battle.viewhacker.BattleDropDownBtnHandler", package.seeall)

local M = class("BattleDropDownBtnHandler")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._toggleCompList = {}
	self._lineList = {}
	self._dropDownPanelGo = goutil.findChild(self._mainGo, "Template")
	self._toggleGroup = self._dropDownPanelGo:GetComponent(UIComponentType.SpaceXToggleGroup)

	local toggleGoList = Astral.GameObjectUtil.GetChildren(self._dropDownPanelGo)

	for index = 0, toggleGoList.Length - 1 do
		local toggleComp = toggleGoList[index]:GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._toggleCompList, toggleComp)
		toggleComp:AddListener(function(_, isOn)
			if isOn then
				self:_dealToggleClick(index + 1, isOn)
			end
		end, nil)
		table.insert(self._lineList, goutil.findChild(toggleGoList[index], "normal/line"))
	end

	self._clickBtn = Astral.ButtonAdapter.Get(goutil.findChild(self._mainGo, "btnFilter"))

	self._clickBtn:AddClickListener(self._onClickBtn, self)

	self._name1Txt = goutil.findChildTextComponent(self._mainGo, "btnFilter/normal/Label")
	self._name2Txt = goutil.findChildTextComponent(self._mainGo, "btnFilter/select/Label")
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
	self._clickBtn:RemoveClickListener()
end

function M:setVisible(visible)
	self._dropDownPanelGo:SetActive(visible)

	if visible then
		self._clickListener = Astral.UIGlobalTouchTrigger.Get(self._mainGo)

		self._clickListener:AddGlobalListener(self._onDoClick, self)
		self._toggleGroup:TryActiveChildOn(self._toggleCompList[self._selectIndex], true)
	else
		self._clickListener:RemoveGlobalListener()
	end
end

function M:_onDoClick()
	self:setVisible(false)
end

function M:getVisible()
	return self._dropDownPanelGo.activeSelf
end

function M:_dealToggleClick(index)
	if self._selectIndex == index then
		return
	end

	for _index, lineGo in ipairs(self._lineList) do
		lineGo:SetActive(_index ~= index - 1)
	end

	self._selectIndex = index
	self._name1Txt.text = self._index2NameCfg[index]
	self._name2Txt.text = self._index2NameCfg[index]

	if self._selectChangeFunc then
		self._selectChangeFunc(self._selectChangeHandler, self._selectIndex, self._backParam)
	end
end

function M:setIndex2Name(cfg)
	self._index2NameCfg = cfg

	local toggleGoList = Astral.GameObjectUtil.GetChildren(self._dropDownPanelGo)

	for index = 0, toggleGoList.Length - 1 do
		local textTextComp = goutil.findChildTextComponent(toggleGoList[index], "Text")

		textTextComp.text = self._index2NameCfg[index + 1]
	end
end

function M:setSelectIndex(index)
	self._selectIndex = index

	if self._index2NameCfg[index] then
		self._name1Txt.text = self._index2NameCfg[index]
		self._name2Txt.text = self._index2NameCfg[index]
	end
end

function M:getSelectIndex()
	return self._selectIndex or 1
end

function M:setDropChangeCallBack(func, handler, backParam)
	self._selectChangeFunc = func
	self._selectChangeHandler = handler
	self._backParam = backParam
end

function M:_onClickBtn()
	if self:getVisible() then
		self:setVisible(false)
	else
		self:setVisible(true)
	end
end

return M
