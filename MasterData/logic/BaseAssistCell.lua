-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/cell/BaseAssistCell.lua

module("logic.extensions.xiaonuoassistant.view.cell.BaseAssistCell", package.seeall)

local BaseAssistCell = class("BaseAssistCell")

function BaseAssistCell:ctor(luaComponentContainer)
	self._parentGo = luaComponentContainer.gameObject
	self._name = string.format("detailcellparent/%s", XiaoNuoAssistantModel.cellName)
	self._txtName = goutil.findChildTextComponent(self._parentGo, "txtName")
	self._btnAll = Framework.ButtonAdapter.GetFrom(self._parentGo, "btnAll")
	self._markbtnAll = goutil.findChild(self._parentGo, "btnAll/Background/Checkmark")
	self._btnAllIsOn = false

	goutil.setActive(self._btnAll.gameObject, true)

	self._method = SystemReflexHelp.getMethod("UnityEngine.UI.Dropdown,UnityEngine.UI", "Hide")
end

function BaseAssistCell:getCellPath(path)
	return string.format(self._name .. "/" .. path)
end

function BaseAssistCell:init(data)
	self:reset()
	self._btnAll:AddClickListener(self._onClickAll, self)

	self._data = data
	self._txtName.text = self._data:getName()

	self:_setBtnAllIsOn(self._data:getOpenData())

	local funcId = self._data:getFuncIndex()
	local x, y = XiaoNuoAssistantController.instance:getCellHeight(funcId)

	GameUtil.setHeight(self._parentGo, y)

	self._assistCellData = self._data:getAssistCellData()
end

function BaseAssistCell:reset()
	self._btnAll:RemoveClickListener()
end

function BaseAssistCell:_updateSelectData()
	return
end

function BaseAssistCell:_updateBtnAll()
	return
end

function BaseAssistCell:_selectAll()
	return
end

function BaseAssistCell:_cancelAll()
	return
end

function BaseAssistCell:_onClickAll()
	local isOn = self._data:getOpenData()

	self._data:setOpenData(not isOn)
	self:_setBtnAllIsOn(not isOn)

	if self._data:getOpenData() then
		printInfo("test 选择全部")
	else
		printInfo("test 取消全部")
	end

	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function BaseAssistCell:_setBtnAllIsOn(isOn)
	goutil.setActive(self._markbtnAll, isOn)

	self._btnAllIsOn = checkbool(isOn)
end

function BaseAssistCell:getDefaultStr()
	return "--"
end

function BaseAssistCell:_fixTxtShow(text)
	text.text = text.text .. " "
end

function BaseAssistCell:_dispatchRefreshCostShow()
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantRefreshCoin, self._data:getTabIndex())
end

function BaseAssistCell:_hideDropdown(dropdown)
	self._method:Call(dropdown)
end

return BaseAssistCell
