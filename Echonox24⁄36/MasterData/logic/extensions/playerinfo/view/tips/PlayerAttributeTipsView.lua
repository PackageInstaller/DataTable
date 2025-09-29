-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/tips/PlayerAttributeTipsView.lua

module("logic.extensions.playerinfo.view.tips.PlayerAttributeTipsView", package.seeall)

local M = class("PlayerAttributeTipsView", ViewComponent)

function M:ctor()
	return
end

function M:buildUI()
	local bgGo = goutil.findChild(self.mainGO, "common_blur_rt")

	self._bgBlur = bgGo:GetComponent(UIComponentType.RawImage)
	self._screenshotImage = CaptureScreenshotImage.Get(bgGo)

	local clickGo = goutil.findChild(self.mainGO, "click")

	self._click = Astral.UIClickTrigger.Get(clickGo)
end

function M:bindEvents()
	self._click:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._click:RemoveClickListener()
end

function M:_onClickClose()
	self:close()
end

function M:onEnter()
	self:setScreenShotImage()
end

function M:setScreenShotImage()
	local uiRoot = ViewMgr.instance:getUIRoot()
	local rectTransform = uiRoot.transform
	local width = rectTransform.rect.width
	local height = rectTransform.rect.height

	goutil.setWidth(self._bgBlur.transform, width)
	goutil.setHeight(self._bgBlur.transform, height)
	self._screenshotImage:Clear()
	self._screenshotImage:Build(width, height)
	self._screenshotImage:CaptureFrame(self._onCaptureFinish, self)
end

function M:_onCaptureFinish()
	local downSample = 1
	local iteration = 4
	local renderTexture = SpaceX.CommandBufferEffectUtils.Blur(self._bgBlur.texture, CommonPreloader.instance:getMaterialsCommAsset(CommonResPath.BlurMat), downSample, iteration)

	self._screenshotImage:SetRenderTexture(renderTexture)
	goutil.setActive(self.mainGO, true)
end

function M:onExit()
	self._screenshotImage:Clear()
end

return M
