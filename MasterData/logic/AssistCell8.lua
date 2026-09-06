-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/cell/AssistCell8.lua

module("logic.extensions.xiaonuoassistant.view.cell.AssistCell8", package.seeall)

local AssistCell8 = class("AssistCell8", BaseAssistCell)

function AssistCell8:ctor(luaComponentContainer)
	AssistCell8.super.ctor(self, luaComponentContainer)

	self._btn1 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn1", self._name))
	self._markbtn1 = goutil.findChild(self._parentGo, string.format("%s/btn1/Background/Checkmark", self._name))
	self._txt1 = goutil.findChildTextComponent(self._parentGo, string.format("%s/txt1", self._name))
end

function AssistCell8:init(data)
	AssistCell8.super.init(self, data)
	self._btn1:AddClickListener(self._onClickBtn1, self)
	self:_setBtnIsOn1(self._data:getCellSelect(self._data.selectIndex1))

	local cfg = self._data:getCfg()

	if cfg.previewDescList then
		self._txt1.text = cfg.previewDescList[1] or self:getDefaultStr() or self:getDefaultStr()
	end
end

function AssistCell8:reset()
	self._btn1:RemoveClickListener()
end

function AssistCell8:_selectAll()
	self._data:setCellSelect(self._data.selectIndex1, true)
	self:_setBtnIsOn1(true)
end

function AssistCell8:_cancelAll()
	return
end

function AssistCell8:_onClickBtn1()
	local isOn = self._data:getCellSelect(self._data.selectIndex1)

	self._data:setCellSelect(self._data.selectIndex1, not isOn)
	self:_setBtnIsOn1(not isOn)
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell8:_setBtnIsOn1(isOn)
	goutil.setActive(self._markbtn1, isOn)
end

return AssistCell8
