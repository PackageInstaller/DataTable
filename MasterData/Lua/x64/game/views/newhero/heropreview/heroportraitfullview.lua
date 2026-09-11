local HeroPortraitFullView = class("HeroPortraitFullView", ReduxView)

function HeroPortraitFullView:UIName()
	return "Widget/System/ObtainUI/HeroMovie/PortraitFullUI"
end

function HeroPortraitFullView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroPortraitFullView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroPortraitFullView:InitUI()
	self:BindCfgUI()
end

function HeroPortraitFullView:AddUIListener()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

function HeroPortraitFullView:OnTop()
	manager.windowBar:SwitchBar({})
end

function HeroPortraitFullView:OnExit()
	manager.windowBar:HideBar()
end

function HeroPortraitFullView:OnEnter()
	self.skinID_ = self.params_.skinID
	self.portriatImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/PortraitDLC/" .. ((SkinCfg[self.skinID_] or nil) and (SkinCfg[self.skinID_].picture_id or "0")))
end

return HeroPortraitFullView
