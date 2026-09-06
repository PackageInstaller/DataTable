-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/cell/AssistCell1.lua

module("logic.extensions.xiaonuoassistant.view.cell.AssistCell1", package.seeall)

local AssistCell1 = class("AssistCell1", BaseAssistCell)

function AssistCell1:ctor(luaComponentContainer)
	AssistCell1.super.ctor(self, luaComponentContainer)

	self._btn1 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn1", self._name))
	self._btn2 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn2", self._name))
	self._markbtn1 = goutil.findChild(self._parentGo, string.format("%s/btn1/Background/Checkmark", self._name))
	self._markbtn2 = goutil.findChild(self._parentGo, string.format("%s/btn2/Background/Checkmark", self._name))
	self._txtLabel1 = goutil.findChildTextComponent(self._parentGo, string.format("%s/btn1/Label", self._name))
	self._txtLabel2 = goutil.findChildTextComponent(self._parentGo, string.format("%s/btn2/Label", self._name))
	self._txt1 = goutil.findChildTextComponent(self._parentGo, string.format("%s/txt1", self._name))
	self._txt2 = goutil.findChildTextComponent(self._parentGo, string.format("%s/txt2", self._name))
	self._btnIsOn1 = false
	self._btnIsOn2 = false

	self._btn1:AddClickListener(self._onClickBtn1, self)
	self._btn2:AddClickListener(self._onClickBtn2, self)

	self._bossId1 = AssistData1.bossId1
	self._bossId2 = AssistData1.bossId2
end

function AssistCell1:init(data)
	AssistCell1.super.init(self, data)

	local selectList = self._data:getSelectData()

	self:_setBtnIsOn1(selectList[1])
	self:_setBtnIsOn2(selectList[2])
	self:_updateSelectData()
	self:_updateBtnAll()

	local isJoinFamily = FamilyModel.instance:isInFamily()
	local leftTime1 = FamilyModel.instance:getBossChallegenLeftTime(self._bossId1)
	local leftTime2 = FamilyModel.instance:getBossChallegenLeftTime(self._bossId2)
	local cfg = self._data:getCfg()

	self._txtLabel1.text = string.format("%s剩余%d次", cfg.tag[1], isJoinFamily and leftTime1 or 0)
	self._txtLabel2.text = string.format("%s剩余%d次", cfg.tag[2], isJoinFamily and leftTime2 or 0)

	if cfg.previewDescList then
		self._txt1.text = cfg.previewDescList[1] or self:getDefaultStr() or self:getDefaultStr()
	end

	if cfg.previewDescList then
		self._txt2.text = cfg.previewDescList[2] or self:getDefaultStr() or self:getDefaultStr()
	end
end

function AssistCell1:reset()
	self._btn1:RemoveClickListener()
	self._btn2:RemoveClickListener()
end

function AssistCell1:_updateSelectData()
	local list = {}

	table.insert(list, self._btnIsOn1)
	table.insert(list, self._btnIsOn2)
	self._data:setSelectData(list)
end

function AssistCell1:_updateBtnAll()
	if not self._btnIsOn1 or not self._btnIsOn2 then
		self:_setBtnAllIsOn(false)
	else
		self:_setBtnAllIsOn(true)
	end
end

function AssistCell1:_selectAll()
	self:_setBtnIsOn1(true)
	self:_setBtnIsOn2(true)
	self:_updateSelectData()
end

function AssistCell1:_cancelAll()
	self:_setBtnIsOn1(false)
	self:_setBtnIsOn2(false)
	self:_updateSelectData()
end

function AssistCell1:_onClickBtn1()
	self:_setBtnIsOn1(not self._btnIsOn1)
	self:_updateSelectData()
	self:_updateBtnAll()
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell1:_onClickBtn2()
	self:_setBtnIsOn2(not self._btnIsOn2)
	self:_updateSelectData()
	self:_updateBtnAll()
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell1:_setBtnIsOn1(isOn)
	goutil.setActive(self._markbtn1, isOn)

	self._btnIsOn1 = checkbool(isOn)
end

function AssistCell1:_setBtnIsOn2(isOn)
	goutil.setActive(self._markbtn2, isOn)

	self._btnIsOn2 = checkbool(isOn)
end

return AssistCell1
