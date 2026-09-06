-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualbox/controller/AnnualBoxController.lua

module("logic.extensions.annualbox.controller.AnnualBoxController", package.seeall)

local AnnualBoxController = class("AnnualBoxController", BaseController)

function AnnualBoxController:ctor()
	self._annualBoxInfo = nil
end

function AnnualBoxController:onInit()
	AnnualBoxController.super.onInit(self)
	self:onReset()
end

function AnnualBoxController:onReset()
	AnnualBoxController.super.onReset(self)

	self._choPrizeId = nil
	self._annualBoxInfo = nil
end

function AnnualBoxController:csRequestAssembleOrderInfoReq()
	AssembleOrderAgent.instance:sendPM_AssembleOrderInfoReq()
end

function AnnualBoxController:scPushAssembleOrderInfo(msg)
	self:getAnnualBoxInfo(true)

	if msg then
		self._annualBoxInfo.userCode = msg.code
		self._annualBoxInfo.invitePro = checknumber(msg.inviteProgress)
		self._annualBoxInfo.helpPro = checknumber(msg.helpProgress)
		self._annualBoxInfo.regressionPrizeState = checknumber(msg.regressionPrizeState)

		for _, id in pairs(msg.inviteProgressPrize or {}) do
			if checknumber(id) > 0 then
				table.insert(self._annualBoxInfo.invitePrizes, id)
			end
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdataAnnualBoxInfo)
end

function AnnualBoxController:csRequestAssembleOrderGainInvitePrizeReq(prizeId)
	self._choPrizeId = prizeId

	AssembleOrderAgent.instance:sendPM_AssembleOrderGainInvitePrizeReq(prizeId)
end

function AnnualBoxController:scPushAssembleOrderGainInvitePrize()
	if self._annualBoxInfo.invitePrizes == nil or #self._annualBoxInfo.invitePrizes == 0 then
		self._annualBoxInfo.invitePrizes = {}
		self._annualBoxInfo.invitePrizes[1] = self._choPrizeId
	else
		local value = table.indexof(self._annualBoxInfo.invitePrizes, self._choPrizeId)

		if not value then
			table.insert(self._annualBoxInfo.invitePrizes, self._choPrizeId)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdataAnnualBoxInfo, self._choPrizeId, false)

	self._choPrizeId = nil
end

function AnnualBoxController:setRegressionPrizeStateGeted()
	if self._annualBoxInfo and self._annualBoxInfo.regressionPrizeState then
		self._annualBoxInfo.regressionPrizeState = 2
	end
end

function AnnualBoxController:isInviteFriend()
	if self._annualBoxInfo and self._annualBoxInfo.regressionPrizeState then
		return self._annualBoxInfo.regressionPrizeState > 0
	end
end

function AnnualBoxController:isGetedReturnReward()
	if self._annualBoxInfo and self._annualBoxInfo.regressionPrizeState then
		return self._annualBoxInfo.regressionPrizeState > 1
	end
end

function AnnualBoxController:getAnnualBoxInfo(isReset)
	if self._annualBoxInfo == nil or isReset then
		self._annualBoxInfo = {}
		self._annualBoxInfo.userCode = ""
		self._annualBoxInfo.invitePro = 0
		self._annualBoxInfo.helpPro = 0
		self._annualBoxInfo.invitePrizes = {}
	end

	return self._annualBoxInfo
end

function AnnualBoxController:saveShareTexture(tex2D)
	if tex2D == nil then
		return
	end

	local actId = AnnualBoxConfig.instance:getOpenActivityId()
	local savePath = string.format("%s/annualBoxShareTex_%s.png", UnityEngine.Application.persistentDataPath, actId)

	Framework.TextureUtil.SaveTextureToPath(tex2D, savePath)

	return savePath
end

function AnnualBoxController:getUserDataByST2D()
	local actId = AnnualBoxConfig.instance:getOpenActivityId()
	local idx = GameUtil.getUserData("AnnualBoxShareTex" .. actId)

	return checknumber(idx) == 1
end

function AnnualBoxController:openAnnualBoxShare(urlPath)
	local btplatformId = BootstrapUtil.getPlatformId()

	if Framework.OSDef.isEditor or SDKManager.isOfficial() or GameUtil.isOpenHarmony() or PermissionUtil.checkPermission("WRITE_EXTERNAL_STORAGE") then
		UIStateManager.instance:push(ViewName.AnnualBoxShare, urlPath)
	else
		PermissionUtil.registerPermissionListener(function(result)
			PermissionUtil.unregisterPermissionListener()
		end)
		PermissionUtil.requestPermission("WRITE_EXTERNAL_STORAGE", "分享功能需要授予存储权限，请您前往 [设置-权限管理-奥奇传说] 中开启，感谢。")
	end
end

AnnualBoxController.instance = AnnualBoxController.New()

return AnnualBoxController
