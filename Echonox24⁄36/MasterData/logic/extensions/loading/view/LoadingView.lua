-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loading/view/LoadingView.lua

module("logic.extensions.loading.view.LoadingView", package.seeall)

local LoadingView = class("LoadingView", ViewComponent)

function LoadingView:buildUI()
	self._titleTxt = self:getUIComponent("loading_-1173904182", UIComponentType.TextMeshProUGUI)
	self._contentTxt = self:getUIComponent("loading_2537689364964533647", UIComponentType.TextMeshProUGUI)
	self._loadingBgImg = self:getUIComponent("loading_1729668265", UIComponentType.RawImage)
end

function LoadingView:destroyUI()
	self._titleTxt = nil
	self._contentTxt = nil
	self._loadingBgImg = nil
end

function LoadingView:onEnter()
	PlayerAttributeGainTipsController.instance:freeze("loading")

	local info = self:getFirstParam()

	self._loadingBgImg.color = Color.New(1, 1, 1, 1)

	if info then
		if info.title then
			self._titleTxt.text = info.title
		end

		if info.content then
			self._contentTxt.text = info.content
		end

		if info.bgName then
			self._loadingBgImg.texture = LoadingFacade.instance:getAsset(GameUrl.getBigBgUrlByPrefix("loading", info.bgName))
		end
	end

	local bgColor = self:getOpenParam()[2]

	if bgColor then
		self._loadingBgImg.color = bgColor
	end

	settimer(0.55, self.checkActiveSign, self, false)
end

function LoadingView:onExit()
	PlayerAttributeGainTipsController.instance:unfreeze("loading", 0.2)
	removetimer(self.checkActiveSign, self)
end

function LoadingView:checkActiveSign()
	if not LoadingFacade.instance:isLoadingSignActive() then
		LoadingFacade.instance:hideLoading()
	end
end

return LoadingView
