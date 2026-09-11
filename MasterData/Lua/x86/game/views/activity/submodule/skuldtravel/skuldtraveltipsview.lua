local SkuldTravelTipsView = class("SkuldTravelTipsView", ReduxView)

function SkuldTravelTipsView:UIName()
	return "UI/EmptyDream/EDream_travelled/EDream_travelling"
end

function SkuldTravelTipsView:UIParent()
	return manager.ui.uiMain.transform
end

function SkuldTravelTipsView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldTravelTipsView:InitUI()
	self:BindCfgUI()
end

function SkuldTravelTipsView:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		gameContext:Go("/skuldTravelView")
	end)
	self:AddBtnListener(self.bgbtn_, nil, function()
		gameContext:Go("/skuldTravelView")
	end)
end

function SkuldTravelTipsView:Dispose()
	self.super.Dispose(self)
end

return SkuldTravelTipsView
