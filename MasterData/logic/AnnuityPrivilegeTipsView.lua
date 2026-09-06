-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annuityprivilege/view/AnnuityPrivilegeTipsView.lua

module("logic.extensions.annuityprivilege.view.AnnuityPrivilegeTipsView", package.seeall)

local AnnuityPrivilegeTipsView = class("AnnuityPrivilegeTipsView", ViewComponent)

function AnnuityPrivilegeTipsView:buildUI()
	AnnuityPrivilegeTipsView.super.buildUI(self)

	self._content = self:getGo("content")
	self._txtYear = self:getTxt("content/txtYear")
	self._strTxtYear = self._txtYear.text
	self._txtPassTips = self:getTxt("content/txtPassTips")
end

function AnnuityPrivilegeTipsView:onEnter()
	AnnuityPrivilegeTipsView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = ActivityDefineController.instance:getActTypeByActId(self._activityId)

	self.addGEvent(self, GlobalNotify.AnnuityInfoChange, self._onUpdate, self)
	self:_onUpdate()
end

function AnnuityPrivilegeTipsView:onExit()
	AnnuityPrivilegeTipsView.super.onExit(self)
end

function AnnuityPrivilegeTipsView:_onUpdate()
	self._annuityActivityId = 0

	local annuityActivityIds = AnnuityPrivilegeController.instance:getCanSweepAnnuityActivityIds(self._activityId)

	for _, annuityActivityId in ipairs(annuityActivityIds) do
		if YearCardModel.instance:isActiveAnnuity(annuityActivityId) then
			self._annuityActivityId = annuityActivityId

			break
		end
	end

	local fitAnnuityActivityId = self._annuityActivityId

	if fitAnnuityActivityId <= 0 then
		for i, v in ipairs(annuityActivityIds) do
			fitAnnuityActivityId = Mathf.Max(fitAnnuityActivityId, v)
		end
	end

	if fitAnnuityActivityId > 0 then
		local data = PayShopConfig.instance:getAnnuityCfgById(fitAnnuityActivityId)

		self._txtYear.text = string.format(self._strTxtYear, data.year)

		local sweepData = AnnuityPrivilegeConfig.instance:getSweepData(fitAnnuityActivityId, self._activityType)

		self._txtPassTips.text = sweepData.passTips
	end

	GameUtil.SetActive(self._content, fitAnnuityActivityId > 0)
end

return AnnuityPrivilegeTipsView
