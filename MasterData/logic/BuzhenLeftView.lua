-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/BuzhenLeftView.lua

module("logic.extensions.formation.view.BuzhenLeftView", package.seeall)

local BuzhenLeftView = class("BuzhenLeftView", FormationLeftViewBase)

function BuzhenLeftView:buildUI()
	BuzhenLeftView.super.buildUI(self)
	printInfo("test 布阵界面己方阵型")

	self._oneKeyBtn = Framework.ButtonAdapter.GetFrom(self.mainGO, "Nego_Left/Btn_OneKey")
	self._cleanBtn = Framework.ButtonAdapter.GetFrom(self.mainGO, "Nego_Left/Btn_Clean")
end

function BuzhenLeftView:bindEvents()
	BuzhenLeftView.super.bindEvents(self)
	self._oneKeyBtn:AddClickListener(self._onClickOneKey, self)
	self._cleanBtn:AddClickListener(self._onClickClean, self)
end

function BuzhenLeftView:unbindEvents()
	BuzhenLeftView.super.unbindEvents(self)
	self._oneKeyBtn:RemoveClickListener()
	self._cleanBtn:RemoveClickListener()
end

function BuzhenLeftView:onEnter()
	BuzhenLeftView.super.onEnter(self)
	FastFormation.instance:setCurFormFunc(nil)
	FastFormation.instance:setGetCurPetList(nil)
end

function BuzhenLeftView:onExit()
	BuzhenLeftView.super.onExit(self)
	MissionModel.instance:setMaxPetNum(5)
	FastFormation.instance:setCurFormFunc(nil)
	FastFormation.instance:setGetCurPetList(nil)
end

function BuzhenLeftView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
	MissionModel.instance:setForceResetOneKey(false)
end

function BuzhenLeftView:_onClickClean()
	printInfo("_onClickClean")

	local fixedPosDic = MissionModel.instance:getFixedPos()

	FastFormation.instance:clean(fixedPosDic)
end

return BuzhenLeftView
