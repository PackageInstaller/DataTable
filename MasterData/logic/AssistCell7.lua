-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/cell/AssistCell7.lua

module("logic.extensions.xiaonuoassistant.view.cell.AssistCell7", package.seeall)

local AssistCell7 = class("AssistCell7", BaseAssistCell)

function AssistCell7:ctor(luaComponentContainer)
	AssistCell7.super.ctor(self, luaComponentContainer)

	self._btn1 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn1", self._name))
	self._btn2 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn2", self._name))
	self._btn3 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn3", self._name))
	self._btn4 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn4", self._name))
	self._markbtn1 = goutil.findChild(self._parentGo, string.format("%s/btn1/Background/Checkmark", self._name))
	self._markbtn2 = goutil.findChild(self._parentGo, string.format("%s/btn2/Background/Checkmark", self._name))
	self._markbtn3 = goutil.findChild(self._parentGo, string.format("%s/btn3/Background/Checkmark", self._name))
	self._markbtn4 = goutil.findChild(self._parentGo, string.format("%s/btn4/Background/Checkmark", self._name))
	self._txtLabel1 = goutil.findChildTextComponent(self._parentGo, string.format("%s/btn1/Label", self._name))
	self._txtLabel2 = goutil.findChildTextComponent(self._parentGo, string.format("%s/btn2/Label", self._name))
	self._txtLabel3 = goutil.findChildTextComponent(self._parentGo, string.format("%s/btn3/Label", self._name))
	self._txtLabel4 = goutil.findChildTextComponent(self._parentGo, string.format("%s/btn4/Label", self._name))
	self._txt1 = MaterialMgr.findGraphicText(self._parentGo, string.format("%s/txt1", self._name))
end

function AssistCell7:init(data)
	AssistCell7.super.init(self, data)
	self._btn1:AddClickListener(self._onClickBtn1, self)
	self._btn2:AddClickListener(self._onClickBtn2, self)
	self._btn3:AddClickListener(self._onClickBtn3, self)
	self._btn4:AddClickListener(self._onClickBtn4, self)
	self:_setBtnIsOn1(self._data:getCellSelect(self._data.selectIndex1))
	self:_setBtnIsOn2(self._data:getCellSelect(self._data.selectIndex2))
	self:_setBtnIsOn3(self._data:getCellSelect(self._data.selectIndex3))
	self:_setBtnIsOn4(self._data:getCellSelect(self._data.selectIndex4))

	local cfg = self._data:getCfg()

	if cfg.previewDescList then
		self._txt1.text = cfg.previewDescList[1] or self:getDefaultStr() or self:getDefaultStr()
	end

	self._txtLabel1.text = cfg.tag[1] or self:getDefaultStr()
	self._txtLabel2.text = cfg.tag[2] or self:getDefaultStr()
	self._txtLabel3.text = cfg.tag[3] or self:getDefaultStr()
	self._txtLabel4.text = cfg.tag[4] or self:getDefaultStr()
end

function AssistCell7:reset()
	self._btn1:RemoveClickListener()
	self._btn2:RemoveClickListener()
	self._btn3:RemoveClickListener()
	self._btn4:RemoveClickListener()
end

function AssistCell7:_selectAll()
	self._data:setCellSelect(self._data.selectIndex1, true)
	self._data:setCellSelect(self._data.selectIndex2, true)
	self._data:setCellSelect(self._data.selectIndex3, true)
	self._data:setCellSelect(self._data.selectIndex4, true)
	self:_setBtnIsOn1(true)
	self:_setBtnIsOn2(true)
	self:_setBtnIsOn3(true)
	self:_setBtnIsOn4(true)
	self:_updateSelectData()
end

function AssistCell7:_cancelAll()
	return
end

function AssistCell7:_onClickBtn1()
	local isOn = self._data:getCellSelect(self._data.selectIndex1)

	self._data:setCellSelect(self._data.selectIndex1, not isOn)
	self:_setBtnIsOn1(not isOn)
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell7:_onClickBtn2()
	local isOn = self._data:getCellSelect(self._data.selectIndex2)

	self._data:setCellSelect(self._data.selectIndex2, not isOn)
	self:_setBtnIsOn2(not isOn)
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell7:_onClickBtn3()
	local isOn = self._data:getCellSelect(self._data.selectIndex3)

	self._data:setCellSelect(self._data.selectIndex3, not isOn)
	self:_setBtnIsOn3(not isOn)
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell7:_onClickBtn4()
	local isOn = self._data:getCellSelect(self._data.selectIndex4)

	self._data:setCellSelect(self._data.selectIndex4, not isOn)
	self:_setBtnIsOn4(not isOn)
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell7:_setBtnIsOn1(isOn)
	goutil.setActive(self._markbtn1, isOn)
end

function AssistCell7:_setBtnIsOn2(isOn)
	goutil.setActive(self._markbtn2, isOn)
end

function AssistCell7:_setBtnIsOn3(isOn)
	goutil.setActive(self._markbtn3, isOn)
end

function AssistCell7:_setBtnIsOn4(isOn)
	goutil.setActive(self._markbtn4, isOn)
end

return AssistCell7
