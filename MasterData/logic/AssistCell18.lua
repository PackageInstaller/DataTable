-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/cell/AssistCell18.lua

module("logic.extensions.xiaonuoassistant.view.cell.AssistCell18", package.seeall)

local AssistCell18 = class("AssistCell18", BaseAssistCell)

function AssistCell18:ctor(luaComponentContainer)
	AssistCell18.super.ctor(self, luaComponentContainer)

	self._btn1 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn1", self._name))
	self._markbtn1 = goutil.findChild(self._parentGo, string.format("%s/btn1/Background/Checkmark", self._name))
	self._txtLabel1 = goutil.findChildTextComponent(self._parentGo, string.format("%s/btn1/Label", self._name))
	self._btn2 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn2", self._name))
	self._markbtn2 = goutil.findChild(self._parentGo, string.format("%s/btn2/Background/Checkmark", self._name))
	self._txtLabel2 = goutil.findChildTextComponent(self._parentGo, string.format("%s/btn2/Label", self._name))
	self._txt1 = goutil.findChildTextComponent(self._parentGo, string.format("%s/txt1", self._name))
end

function AssistCell18:init(data)
	AssistCell18.super.init(self, data)
	self._btn1:AddClickListener(self._onClickBtn1, self)
	self._btn2:AddClickListener(self._onClickBtn2, self)
	self:_setBtnIsOn1(self._data:getCellSelect(self._data.selectIndex1))
	self:_setBtnIsOn2(self._data:getCellSelect(self._data.selectIndex2))

	local cfg = self._data:getCfg()

	if cfg.previewDescList then
		self._txt1.text = cfg.previewDescList[1] or self:getDefaultStr() or self:getDefaultStr()
	end

	self._txtLabel1.text = cfg.tag[1] or self:getDefaultStr()
	self._txtLabel2.text = cfg.tag[2] or self:getDefaultStr()
end

function AssistCell18:reset()
	self._btn1:RemoveClickListener()
	self._btn2:RemoveClickListener()
end

function AssistCell18:_selectAll()
	self._data:setCellSelect(self._data.selectIndex1, true)
	self._data:setCellSelect(self._data.selectIndex2, true)
	self:_setBtnIsOn1(true)
	self:_setBtnIsOn2(true)
end

function AssistCell18:_onClickBtn1()
	local isOn = self._data:getCellSelect(self._data.selectIndex1)

	self._data:setCellSelect(self._data.selectIndex1, not isOn)
	self:_setBtnIsOn1(not isOn)
end

function AssistCell18:_setBtnIsOn1(isOn)
	goutil.setActive(self._markbtn1, isOn)
end

function AssistCell18:_onClickBtn2()
	local isOn = self._data:getCellSelect(self._data.selectIndex2)

	self._data:setCellSelect(self._data.selectIndex2, not isOn)
	self:_setBtnIsOn2(not isOn)
end

function AssistCell18:_setBtnIsOn2(isOn)
	goutil.setActive(self._markbtn2, isOn)
end

return AssistCell18
