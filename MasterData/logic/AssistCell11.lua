-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/cell/AssistCell11.lua

module("logic.extensions.xiaonuoassistant.view.cell.AssistCell11", package.seeall)

local AssistCell11 = class("AssistCell11", BaseAssistCell)

AssistCell11.Key_IsFirstSelected = "AssistCell11.Key_IsFirstSelected"

function AssistCell11:ctor(luaComponentContainer)
	AssistCell11.super.ctor(self, luaComponentContainer)

	self._btn1 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn1", self._name))
	self._btn2 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn2", self._name))
	self._markbtn1 = goutil.findChild(self._parentGo, string.format("%s/btn1/Background/Checkmark", self._name))
	self._markbtn2 = goutil.findChild(self._parentGo, string.format("%s/btn2/Background/Checkmark", self._name))
	self._inputComp = Framework.InputFieldAdapter.GetFrom(self._parentGo, string.format("%s/refrescount/InputField", self._name))
	self._tablecellGoRefresh = goutil.findChild(self._parentGo, string.format("%s/refrescount/panel/tablecell", self._name))
	self._tableviewGoRefresh = goutil.findChild(self._parentGo, string.format("%s/refrescount/panel/tableview", self._name))
	self._btnSelectTime = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/refrescount/btnSelectTime", self._name))
	self._panelRefreshGo = goutil.findChild(self._parentGo, string.format("%s/refrescount/panel", self._name))
	self._refresPanelGo = goutil.findChild(self._parentGo, string.format("%s/refrescount/panel", self._name))
	self._refreshCustomInput = UICustomInput.Get(self._refresPanelGo)
	self._refreshArrowGo = goutil.findChild(self._parentGo, string.format("%s/refrescount/arrow", self._name))
	self._tableviewGoType = goutil.findChild(self._parentGo, string.format("%s/type/panel/tableview", self._name))
	self._tablecellGoType = goutil.findChild(self._parentGo, string.format("%s/type/panel/tablecell", self._name))
	self._btnSelectMat = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/type/btnSelectMat", self._name))
	self._panelTypeGo = goutil.findChild(self._parentGo, string.format("%s/type/panel", self._name))
	self._typePanelGo = goutil.findChild(self._parentGo, string.format("%s/type/panel", self._name))
	self._customInput = UICustomInput.Get(self._typePanelGo)
	self._txtTypeDesc = goutil.findChildTextComponent(self._parentGo, string.format("%s/type/txtDesc", self._name))
	self._typeArrowGo = goutil.findChild(self._parentGo, string.format("%s/type/arrow", self._name))
	self._typescrollerList = ScrollerList.create(self._tableviewGoType, self._tablecellGoType, GameUtil.handler(self._updateTypeCell, self), GameUtil.handler(self._clearTypeCell, self))
	self._refreshscrollerList = ScrollerList.create(self._tableviewGoRefresh, self._tablecellGoRefresh, GameUtil.handler(self._updateRefershCell, self), GameUtil.handler(self._clearRefreshCell, self))
end

function AssistCell11:reset()
	self._btn1:RemoveClickListener()
	self._btn2:RemoveClickListener()
	self._inputComp:RemoveOnValueChanged()
	self._btnSelectMat:RemoveClickListener()
	self._btnSelectTime:RemoveClickListener()
	self._customInput:RemoveListener()
	self._refreshCustomInput:RemoveListener()
	self._typescrollerList:dispose()
	self._refreshscrollerList:dispose()
end

function AssistCell11:init(data)
	AssistCell11.super.init(self, data)
	self._btn1:AddClickListener(self._onClickBtn1, self)
	self._btn2:AddClickListener(self._onClickBtn2, self)
	self._inputComp:AddOnValueChanged(self._inputValueChanged, self)
	self._btnSelectMat:AddClickListener(self._onClickbtnSelectMat, self)
	self._btnSelectTime:AddClickListener(self._onClickbtnSelectTime, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	self._refreshCustomInput:AddListener(self._onCustomRefreshInputCallback, self)

	self._assistCellData = self._data:getAssistCellData()
	self._refreshCfgs = AssignmentConfig.instance:getPetDispatchRefreshConfig(1)
	self._maxRefreshCount = #self._refreshCfgs

	self:_setBtnIsOn1(self._assistCellData.selectState == AssistData11.RefreshAndDispatch)
	self:_setBtnIsOn2(self._assistCellData.selectState == AssistData11.Dispatch)
	self:_initRefreshTime()
	self:_initPanels()

	self._cacheTodayTaskRefreshTimes = self._assistCellData.cacheTodayTaskRefreshTimes
end

function AssistCell11:_selectAll()
	return
end

function AssistCell11:_cancelAll()
	return
end

function AssistCell11:_onClickBtn1()
	self._assistCellData.selectState = AssistData11.RefreshAndDispatch

	self._data:setCellData(self._data.keySelect, AssistData11.RefreshAndDispatch)
	self:_setBtnIsOn1(true)
	self:_setBtnIsOn2(false)
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell11:_onClickBtn2()
	self._assistCellData.selectState = AssistData11.Dispatch

	self._data:setCellData(self._data.keySelect, AssistData11.Dispatch)
	self:_setBtnIsOn1(false)
	self:_setBtnIsOn2(true)
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell11:_setBtnIsOn1(isOn)
	goutil.setActive(self._markbtn1, isOn)
end

function AssistCell11:_setBtnIsOn2(isOn)
	goutil.setActive(self._markbtn2, isOn)
end

function AssistCell11:_initRefreshTime()
	self._txtrefreTimeStr = self._assistCellData.txtrefreTimeStr

	self._inputComp:SetText(self._txtrefreTimeStr)
end

function AssistCell11:_updateRefreshTime(times)
	times = times or 1
	times = Mathf.Clamp(times, 1, self._maxRefreshCount)
	self._txtrefreTimeStr = tostring(times)

	self._inputComp:SetText(self._txtrefreTimeStr)

	self._assistCellData.txtrefreTimeStr = times

	self._data:setCellData(self._data.keySelectTimes, times)
end

function AssistCell11:_inputValueChanged(text)
	if text == self._txtrefreTimeStr then
		return
	end

	local times = checknumber(text)

	self:_updateRefreshTime(times)
end

function AssistCell11:_initPanels()
	self._openTypePanel = false
	self._openRefreshPanel = false

	goutil.setActive(self._panelTypeGo, self._openTypePanel)
	goutil.setActive(self._panelRefreshGo, self._openRefreshPanel)
	Framework.TransformUtil.SetLocalRotation(self._refreshArrowGo.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalRotation(self._typeArrowGo.transform, 0, 0, 0)

	local refeshTimes = {
		1,
		5,
		10,
		20,
		30,
		50
	}

	self._refreshscrollerList:reloadData(refeshTimes)

	local typeDatas = AssignmentController.instance:getTaskPrizeTypeDatas()

	self._selectTypeIds = self._selectTypeIds or {}

	for i, v in ipairs(typeDatas) do
		for _, prizeType in ipairs(self._assistCellData.selectTypeIds) do
			if v.prizeType == prizeType then
				self._selectTypeIds[v.prizeType] = v

				break
			end
		end
	end

	self._typescrollerList:reloadData(typeDatas)
	self:_setSelectTypeDesc()
end

function AssistCell11:_onClickbtnSelectMat()
	self._openTypePanel = not self._openTypePanel

	Framework.TransformUtil.SetLocalRotation(self._typeArrowGo.transform, 0, 0, self._openTypePanel and 180 or 0)
	goutil.setActive(self._panelTypeGo, self._openTypePanel)
end

function AssistCell11:_onClickbtnSelectTime()
	self._openRefreshPanel = not self._openRefreshPanel

	Framework.TransformUtil.SetLocalRotation(self._refreshArrowGo.transform, 0, 0, self._openRefreshPanel and 180 or 0)
	goutil.setActive(self._panelRefreshGo, self._openRefreshPanel)
end

function AssistCell11:_onCustomInputCallback(hover)
	if not hover and self._openTypePanel then
		self:_onClickbtnSelectMat()
	end
end

function AssistCell11:_onCustomRefreshInputCallback(hover)
	if not hover and self._openRefreshPanel then
		self:_onClickbtnSelectTime()
	end
end

function AssistCell11:_updateTypeCell(view, cell, data, tag)
	local goSelect = goutil.findChild(cell.gameObject, "checkbox/select")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnSelect")

	txtName.text = data.prizeTypeName

	goutil.setActive(goSelect, self._selectTypeIds[data.prizeType])
	btn:AddClickListener(function()
		local selectNum = table.nums(self._selectTypeIds)

		if selectNum <= 1 and self._selectTypeIds[data.prizeType] then
			FloatWordMgr.instance:show("至少选一种")

			return
		elseif selectNum >= 2 and not self._selectTypeIds[data.prizeType] then
			FloatWordMgr.instance:show("最多选两种")

			return
		end

		if self._selectTypeIds[data.prizeType] then
			self._selectTypeIds[data.prizeType] = nil
		else
			self._selectTypeIds[data.prizeType] = data
		end

		self:_saveSelectTypeIds()
		self:_setSelectTypeDesc()
		self._typescrollerList:refresh()
	end)
end

function AssistCell11:_saveSelectTypeIds()
	local newSelectTypeIds = {}

	for k, v in pairs(self._selectTypeIds) do
		table.insert(newSelectTypeIds, v.prizeType)
	end

	self._data:setCellData(self._data.keySelectTypeIds, GameUtil.jsonToString(newSelectTypeIds))

	self._assistCellData.selectTypeIds = newSelectTypeIds
end

function AssistCell11:_clearTypeCell(cell)
	return
end

function AssistCell11:_setSelectTypeDesc()
	local strList = {}

	for k, v in pairs(self._selectTypeIds) do
		table.insert(strList, v.prizeTypeName)
	end

	self._txtTypeDesc.text = table.concat(strList, "、")
end

function AssistCell11:_updateRefershCell(view, cell, time, tag)
	local txt = goutil.findChildTextComponent(cell.gameObject, "txt")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	txt.text = time

	btn:AddClickListener(function()
		self:_onSelectRefresTime(time)
	end)
end

function AssistCell11:_clearRefreshCell(cell)
	return
end

function AssistCell11:_onSelectRefresTime(times)
	self:_inputValueChanged(tostring(times))
	self:_onClickbtnSelectTime()
end

return AssistCell11
