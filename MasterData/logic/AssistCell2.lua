-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/cell/AssistCell2.lua

module("logic.extensions.xiaonuoassistant.view.cell.AssistCell2", package.seeall)

local AssistCell2 = class("AssistCell2", BaseAssistCell)

function AssistCell2:ctor(luaComponentContainer)
	AssistCell2.super.ctor(self, luaComponentContainer)

	self._btn1 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn1", self._name))
	self._markbtn1 = goutil.findChild(self._parentGo, string.format("%s/btn1/Background/Checkmark", self._name))
	self._txt1 = goutil.findChildTextComponent(self._parentGo, string.format("%s/txt1", self._name))
	self._txt2 = goutil.findChildTextComponent(self._parentGo, string.format("%s/txt2", self._name))
	self._txtLabel = goutil.findChildTextComponent(self._parentGo, string.format("%s/btn1/Label", self._name))
end

function AssistCell2:init(data)
	AssistCell2.super.init(self, data)
	self._btn1:AddClickListener(self._onClickBtn1, self)
	self:_setBtnIsOn1(self._data:getCellSelect(self._data.selectIndex1))

	local cfg = self._data:getCfg()

	if cfg.previewDescList then
		self._txt1.text = cfg.previewDescList[1] or self:getDefaultStr() or self:getDefaultStr()
	end

	self._txt2.text = cfg.desc
	self._txtLabel.text = cfg.tag[1]
end

function AssistCell2:reset()
	self._btn1:RemoveClickListener()
end

function AssistCell2:_selectAll()
	self._data:setCellSelect(self._data.selectIndex1, true)
	self:_setBtnIsOn1(true)
end

function AssistCell2:_cancelAll()
	return
end

function AssistCell2:_onClickBtn1()
	local isOn = self._data:getCellSelect(self._data.selectIndex1)

	self._data:setCellSelect(self._data.selectIndex1, not isOn)
	self:_setBtnIsOn1(not isOn)
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell2:_setBtnIsOn1(isOn)
	goutil.setActive(self._markbtn1, isOn)
end

return AssistCell2
