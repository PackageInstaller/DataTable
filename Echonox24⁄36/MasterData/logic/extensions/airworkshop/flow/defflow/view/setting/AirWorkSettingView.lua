-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/setting/AirWorkSettingView.lua

module("logic.extensions.airworkshop.flow.defflow.view.setting.AirWorkSettingView", package.seeall)

local M = class("AirWorkSettingView", ViewComponent)

function M:buildUI()
	self._panels = {
		self:getGo("air_workshop_setting_tips_314528035"),
		self:getGo("air_workshop_setting_tips_-1851665468"),
		self:getGo("air_workshop_setting_tips_-1178150670")
	}

	local conditionView = Astral.LuaComponentContainer.Add(self._panels[1], AirWorkSettingCondition)
	local guanQiaView = Astral.LuaComponentContainer.Add(self._panels[2], AirWorkSettingGuanQia)
	local bornsView = Astral.LuaComponentContainer.Add(self._panels[3], AirWorkSettingBorns)

	self._panelsView = {
		conditionView,
		guanQiaView,
		bornsView
	}
	self._tabContentGo = self:getGo("2&left_tab_list_-1655680316")
	self._tabGo = self:getGo("2&0&left_tab_list_item_-51389005")
	self._btnClose = self:getBtn("0&middle_tips_common_bg_-1205189576")
	self._btnBg = self:getBtn("0&middle_tips_common_bg_-1572128605")

	goutil.setActive(self._tabGo, false)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnBg:AddClickListener(self._onClickClose, self)
	goutil.clearChildren(self._tabContentGo)

	for i, v in ipairs({
		{
			name = lang("tip_air_workshop_setting_win")
		},
		{
			name = lang("tip_air_workshop_setting_flag")
		},
		{
			name = lang("进攻区")
		}
	}) do
		local tabGo = goutil.cloneAndSetParent(self._tabGo, self._tabContentGo.transform, "tab" .. i)
		local txtTabName = goutil.findChildTextComponent(tabGo, "normal/layout/txtTitle")
		local txtTabName2 = goutil.findChildTextComponent(tabGo, "select/layout/txtTitle")

		txtTabName.text = v.name
		txtTabName2.text = v.name

		goutil.setActive(tabGo, true)
	end

	self._toggles = {}

	local toggleGoList = Astral.GameObjectUtil.GetChildren(self._tabContentGo)

	for index = 0, toggleGoList.Length - 1 do
		local toggleComp = toggleGoList[index]:GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._toggles, toggleComp)
		toggleComp:AddListener(function(_, isOn)
			if isOn then
				self:_toggleClick(index + 1, isOn)
			end
		end, nil)
	end
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnBg:RemoveClickListener()

	for _, toggleComp in pairs(self._toggles or {}) do
		toggleComp:RemoveListener()
	end
end

function M:onEnter()
	local currModel = AirWorkShopDefMgr.instance:getModel()

	self._mapData = currModel:getModiedMapMO()

	local params = self:getOpenParam()
	local idx = params[1] or 1

	self._conditionData = #params > 1 and params[2] or {}

	local bakeMap = not params[3]

	if bakeMap then
		AirWorkShopDefSceneModel.instance:bakeMapForLeave(self._mapData)
	end

	self._toggles[idx].IsOn = true

	self:_showView(idx)
end

function M:onExitFinished()
	for i, v in ipairs(self._panelsView) do
		v:onExit()
	end

	self._conditionData = {}
end

function M:_toggleClick(index, isOn)
	printWarn("====index==>", index, isOn)
	self:_showView(index)
end

function M:_showView(index)
	for i = 1, #self._panels do
		goutil.setActive(self._panels[i], i == index)
	end

	for i, v in ipairs(self._panelsView) do
		if i == index then
			v:onEnter(self._mapData, self._conditionData)
		else
			v:onExit()
		end
	end
end

function M:_onClickClose()
	self:close()
end

return M
