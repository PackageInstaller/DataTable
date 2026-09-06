-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/mission/AceteamFormationView.lua

module("logic.extensions.formation.view.AceteamFormationView", package.seeall)

local AceteamFormationView = class("AceteamFormationView", FormationView)

function AceteamFormationView:unbindEvents()
	AceteamFormationView.super.unbindEvents(self)
	self._backButton:RemoveClickListener()
	self._saveButton:RemoveClickListener()
end

function AceteamFormationView:bindEvents()
	AceteamFormationView.super.bindEvents(self)
	self._backButton:AddClickListener(self._onClickClose, self)
	self._saveButton:AddClickListener(self._onClickSave, self)
end

function AceteamFormationView:buildUI()
	AceteamFormationView.super.buildUI(self)

	self._saveRoot = self:getGo("saveRoot")

	goutil.setActive(self._saveRoot, true)
	goutil.setActive(self._btnRecFormation.gameObject, false)
	goutil.setActive(self._btnShare.gameObject, false)
	self._btnSingleLine:Layout()
end

function AceteamFormationView:onExit()
	AceteamFormationView.super.onExit(self)
	AceTeamModel.instance:resetFormationMo()
end

function AceteamFormationView:onEnter()
	AceteamFormationView.super.onEnter(self)
	self._tipObj.gameObject:SetActive(true)

	self._tipObj.text = lang("aceteamformationview__1")
end

function AceteamFormationView:_reqSaveCurForm(handler, handlerTarget)
	AceTeamController.instance:sendSaveForm()
end

function AceteamFormationView:_onClickSave()
	self:_reqSaveCurForm()
end

function AceteamFormationView:_onClickClose()
	self:_reqSaveCurForm()
	self:close()
end

return AceteamFormationView
