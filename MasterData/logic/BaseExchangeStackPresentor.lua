-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exchange/view/stack/BaseExchangeStackPresentor.lua

module("logic.extensions.exchange.view.stack.BaseExchangeStackPresentor", package.seeall)

local BaseExchangeStackPresentor = class("BaseExchangeStackPresentor", ViewPresentor)

function BaseExchangeStackPresentor:ctor()
	BaseExchangeStackPresentor.super.ctor(self)
end

function BaseExchangeStackPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BaseExchangeStackPresentor:dependWhatResources()
	return {
		"ui/views/exchange/exchangestack.prefab"
	}
end

function BaseExchangeStackPresentor:buildViews()
	return {
		BaseExchangeStackView.New()
	}
end

function BaseExchangeStackPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return BaseExchangeStackPresentor
