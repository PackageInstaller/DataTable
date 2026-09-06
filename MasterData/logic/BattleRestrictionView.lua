-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/BattleRestrictionView.lua

module("logic.extensions.guide.view.BattleRestrictionView", package.seeall)

local BattleRestrictionView = class("BattleRestrictionView", BattleViewSelectUnit)

function BattleRestrictionView:buildUI()
	self._camera = self:getGo("Camera"):GetComponent("Camera")

	CameraRectSetter.CalcRect(self._camera)

	self._leftToRight = self:getGo("LeftToRight")
	self._rightToLeft = self:getGo("RightToLeft")
	self.btnClose = self:getGo("btnClose")
end

function BattleRestrictionView:onEnter()
	BattleRestrictionView.super.onEnter(self)
	GameUtil.addClickHandler(self.btnClose, self.onClickClose, self)

	local screenPos = self._itemTargets[1]:getUnitScreenPos(UnitConst.spineCenterPointPath)
	local localPos = UGUIToolHelper.ScreenToUGUILocalPosition(self.mainGO:GetComponent("RectTransform"), GlobalModel.instance.uiCamera, screenPos)

	if self._itemTargets[1].teamId == BattleModel.instance.myTeamId then
		self._leftToRight:SetActive(true)
		self._rightToLeft:SetActive(false)
		Framework.TransformUtil.SetLocalPos(self._leftToRight.transform, localPos.x, localPos.y, 0)
	else
		self._leftToRight:SetActive(false)
		self._rightToLeft:SetActive(true)
		Framework.TransformUtil.SetLocalPos(self._rightToLeft.transform, localPos.x, localPos.y, 0)
	end

	settimer(2, self._tickBattleRestriction, self, false)
end

function BattleRestrictionView:onExit()
	self._closable = nil

	removetimer(self._tickBattleRestriction, self)
	BattleRestrictionView.super.onExit(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function BattleRestrictionView:_tickBattleRestriction()
	self._closable = true
end

function BattleRestrictionView:onClickClose()
	if self._closable then
		GuideController.instance:finishGuide()
	end
end

return BattleRestrictionView
