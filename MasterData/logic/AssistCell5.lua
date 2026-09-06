-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/cell/AssistCell5.lua

module("logic.extensions.xiaonuoassistant.view.cell.AssistCell5", package.seeall)

local AssistCell5 = class("AssistCell5", BaseAssistCell)

function AssistCell5:ctor(luaComponentContainer)
	AssistCell5.super.ctor(self, luaComponentContainer)

	self._btn1 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn1", self._name))
	self._markbtn1 = goutil.findChild(self._parentGo, string.format("%s/btn1/Background/Checkmark", self._name))
	self._btn2 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn2", self._name))
	self._markbtn2 = goutil.findChild(self._parentGo, string.format("%s/btn2/Background/Checkmark", self._name))
	self._btn3 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn3", self._name))
	self._markbtn3 = goutil.findChild(self._parentGo, string.format("%s/btn3/Background/Checkmark", self._name))
	self._btn4 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn4", self._name))
	self._markbtn4 = goutil.findChild(self._parentGo, string.format("%s/btn4/Background/Checkmark", self._name))
	self._txt1 = MaterialMgr.findGraphicText(self._parentGo, string.format("%s/txt1", self._name))
	self._txt2 = goutil.findChildTextComponent(self._parentGo, string.format("%s/txt2", self._name))
	self._txtLabel = goutil.findChildTextComponent(self._parentGo, string.format("%s/btn1/Label", self._name))
end

function AssistCell5:init(data)
	AssistCell5.super.init(self, data)
	self._btn1:AddClickListener(self._onClickBtn1, self)
	self:_setBtnIsOn1(self._data:getCellSelect(self._data.selectIndex1))

	local cfg = self._data:getCfg()

	if cfg.previewDescList then
		self._txt1.text = cfg.previewDescList[1] or self:getDefaultStr() or self:getDefaultStr()
	end

	self._txt2.text = cfg.desc or self:getDefaultStr()
	self._txtLabel.text = cfg.tag[1] or self:getDefaultStr()
end

function AssistCell5:reset()
	self._btn1:RemoveClickListener()
end

function AssistCell5:_selectAll()
	self._data:setCellSelect(self._data.selectIndex1, true)
	self:_setBtnIsOn1(true)
end

function AssistCell5:_onClickBtn1()
	local isOn = self._data:getCellSelect(self._data.selectIndex1)

	self._data:setCellSelect(self._data.selectIndex1, not isOn)
	self:_setBtnIsOn1(not isOn)
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell5:_setBtnIsOn1(isOn)
	goutil.setActive(self._markbtn1, isOn)
end

function AssistCell5:_onClickBtn2()
	local isOn = self._data:getCellSelect(self._data.selectIndex2)

	self._data:setCellSelect(self._data.selectIndex2, not isOn)
	self:_setBtnIsOn2(not isOn)
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell5:_setBtnIsOn2(isOn)
	goutil.setActive(self._markbtn2, isOn)
end

function AssistCell5:_onClickBtn3()
	local isOn = self._data:getCellSelect(self._data.selectIndex3)

	self._data:setCellSelect(self._data.selectIndex3, not isOn)
	self:_setBtnIsOn3(not isOn)
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell5:_setBtnIsOn3(isOn)
	goutil.setActive(self._markbtn3, isOn)
end

function AssistCell5:_onClickBtn4()
	local isOn = self._data:getCellSelect(self._data.selectIndex4)

	self._data:setCellSelect(self._data.selectIndex4, not isOn)
	self:_setBtnIsOn4(not isOn)
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell5:_setBtnIsOn4(isOn)
	goutil.setActive(self._markbtn4, isOn)
end

return AssistCell5
