-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petshandbook/view/AttributeBtn.lua

module("logic.extensions.petshandbook.view.AttributeBtn", package.seeall)

local AttributeBtn = class("AttributeBtn")

function AttributeBtn:ctor(container)
	self._container = container.gameObject
	self._selectFunc = nil
	self._unSelectFunc = nil

	self:_onBuild()
	self:_onEvent()
end

function AttributeBtn:setAtrribute(type)
	self._raceType = type
end

function AttributeBtn:setCallBackFunc(selectFunc, unSelectFunc)
	self._selectFunc = selectFunc
	self._unSelectFunc = unSelectFunc
end

function AttributeBtn:_onBuild()
	self._Btn_Unselect = Framework.ButtonAdapter.GetFrom(self._container, "Btn_Unselect")
	self._Btn_Select = Framework.ButtonAdapter.GetFrom(self._container, "Btn_Select")
end

function AttributeBtn:_onEvent()
	self._Btn_Unselect:AddClickListener(self._onClickUnSelect, self)
	self._Btn_Select:AddClickListener(self._onClickSelect, self)
end

function AttributeBtn:unEvent()
	self._Btn_Unselect:RemoveClickListener()
	self._Btn_Select:RemoveClickListener()
end

function AttributeBtn:setBtnNormal()
	self._Btn_Unselect.gameObject:SetActive(true)
	self._Btn_Select.gameObject:SetActive(false)
end

function AttributeBtn:_onClickUnSelect()
	if self._selectFunc then
		self._selectFunc(self._raceType)
	end

	self._Btn_Select.gameObject:SetActive(true)
	self._Btn_Unselect.gameObject:SetActive(false)
end

function AttributeBtn:_onClickSelect()
	if self._unSelectFunc then
		self._unSelectFunc(self._raceType)
	end

	self._Btn_Unselect.gameObject:SetActive(true)
	self._Btn_Select.gameObject:SetActive(false)
end

return AttributeBtn
