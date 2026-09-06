-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/aruisi/AruisiMainView.lua

module("logic.extensions.timelimitedchallenge.view.AruisiMainView", package.seeall)

local AruisiMainView = class("AruisiMainView", TimeLimitedMainView)

function AruisiMainView:unbindEvents()
	AruisiMainView.super.unbindEvents(self)
	self._btnVerify:RemoveClickListener()
end

function AruisiMainView:bindEvents()
	AruisiMainView.super.bindEvents(self)
	self._btnVerify:AddClickListener(self._onClickVerify, self)
end

function AruisiMainView:onExit()
	AruisiMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PetVerifySuccess, self._updateBuffUI, self)
end

function AruisiMainView:buildUI()
	AruisiMainView.super.buildUI(self)

	self._challengeId = 1
	self._btnVerify = self:getBtn("buff/btnVerify")
end

function AruisiMainView:_setEffectUrls()
	self._effPaths = {
		{
			goPath = "imgSlogan",
			path = "fx_ui_xianshitiaozhan/fx_ui_aruisixianshitiaozhan_biaoti.prefab"
		},
		{
			goPath = "btnStart",
			path = "fx_ui_xianshitiaozhan/fx_ui_aruisixianshitiaozhan_jinru.prefab"
		},
		{
			goPath = "",
			path = "fx_ui_xianshitiaozhan/fx_ui_aruisixianshitiaozhan_qifen.prefab"
		}
	}
end

function AruisiMainView:onEnter()
	AruisiMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PetVerifySuccess, self._updateBuffUI, self)
end

function AruisiMainView:_updateCircleUI()
	AruisiMainView.super._updateCircleUI(self)

	self._buffPlanId = self._circleCfg.buffPlanId

	PetverifyController.instance:getVerifyInfo(self._buffPlanId, GameUtil.handler(self._updateBuffUI, self))
end

function AruisiMainView:_updateBuffUI()
	local verifyCfg = PetverifyController.instance:getCurrPlanBuff(self._buffPlanId)

	self._hasBuff = verifyCfg ~= nil

	self._txtNull:SetActive(not self._hasBuff)
	self._buffCell:setActive(self._hasBuff)
	self._buffCell:updateWithPetVerifyCfg(verifyCfg)
end

function AruisiMainView:_onClickStart()
	if self._isEmpty then
		FloatWordMgr.instance:show("今天的挑战次数已经用完了")

		return
	end

	UIStateManager.instance:push(ViewName.AruisiDetailView)
end

function AruisiMainView:_onClickBuffTips()
	UIStateManager.instance:push(ViewName.PetverifytipView, self._buffPlanId)
end

function AruisiMainView:_onClickVerify()
	if self._buffPlanId == nil then
		print("buffPlanId为空")

		return
	end

	UIStateManager.instance:push(ViewName.PetverifyView, self._buffPlanId)
end

return AruisiMainView
