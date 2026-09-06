-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivityMagicSchoolsummaryView.lua

module("logic.extensions.operationsummary.view.ActivityMagicSchoolsummaryView", package.seeall)

local ActivityMagicSchoolsummaryView = class("ActivityMagicSchoolsummaryView", ActivityGrandSummaryView)

function ActivityMagicSchoolsummaryView:onEnter()
	ActivityMagicSchoolsummaryView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OperationInvitation, self._operationInvitation, self)
	self.addGEvent(self, GlobalNotify.PM_MagicSchoolGetInfoRes, self._checkAndPopInvitationCardView, self)

	self._magicSchoolActId = MagicSchoolController.instance:getMagicSchoolActIdInTime()

	local magicSchoolKey = string.format(MagicSchoolController.FIRST_ENTER_HUD_KEY, self._magicSchoolActId)
	local magicSchoolActCfg = MagicSchoolConfig.instance:getActCfg(self._magicSchoolActId)

	if magicSchoolActCfg then
		self._activitySummaryId = magicSchoolActCfg.activitySummaryId or 0
	end

	if GameUtil.getUserData(magicSchoolKey) == nil then
		local info = MagicSchoolModel.instance:getInfo(self._magicSchoolActId)

		if info == nil and self._magicSchoolActId > 0 then
			MagicSchoolController.instance:sendPM_MagicSchoolGetInfoReq(self._magicSchoolActId)
		else
			self:_checkAndPopInvitationCardView()
		end
	end
end

function ActivityMagicSchoolsummaryView:_operationInvitation(activityId)
	if self._activitySummaryId == activityId then
		local magicSchoolKey = string.format(MagicSchoolController.FIRST_ENTER_HUD_KEY, self._magicSchoolActId)

		GameUtil.saveUserData(magicSchoolKey, true)
	end
end

function ActivityMagicSchoolsummaryView:_checkAndPopInvitationCardView()
	local info = MagicSchoolModel.instance:getInfo(self._magicSchoolActId)

	if info then
		if not info.acceptInvite then
			local acceptInvite = false

			if info and not acceptInvite then
				local function callBackFunc()
					local magicSchoolKey = string.format(MagicSchoolController.FIRST_ENTER_HUD_KEY, self._magicSchoolActId)

					GameUtil.saveUserData(magicSchoolKey, true)
				end

				UIStateManager.instance:push(ViewName.InvitationCardView, self._activitySummaryId, nil, callBackFunc)
			end
		end
	end
end

function ActivityMagicSchoolsummaryView:_getSumActivityId()
	local key = self._viewPresentor.viewName
	local data = OperationSummaryConfig.instance:getSummaryStartUpData(key)

	if data == nil then
		printError(string.format("key错误,无法读到正确配置.( key = %s )", key))

		return
	end

	return data.activityId
end

return ActivityMagicSchoolsummaryView
