local EatSnakeShowPopView = class("EatSnakeShowPopView", ReduxView)

function EatSnakeShowPopView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_3_10_SnakegameUI/SandPlay_3_10_SnakegameCodexpopUI"
end

function EatSnakeShowPopView:UIParent()
	return manager.ui.uiPop.transform
end

function EatSnakeShowPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function EatSnakeShowPopView:InitUI()
	self:BindCfgUI()

	self.controller = self.controller_:GetController("select")
end

function EatSnakeShowPopView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function EatSnakeShowPopView:OnEnter()
	self:UpdateData()
	self:UpdateView()
end

function EatSnakeShowPopView:UpdateData()
	return
end

function EatSnakeShowPopView:UpdateView()
	self.cfg = ActivityEatSnakeCfg[self.params_.id]
	self.image_.sprite = pureGetSpriteWithoutAtlas(self.cfg.image)
	self.nameText_.text = self.cfg.name
	self.descText_.text = self.cfg.desc

	self.controller:SetSelectedState(self.params_.isLock and "false" or "true")
end

function EatSnakeShowPopView:OnExit()
	return
end

function EatSnakeShowPopView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function EatSnakeShowPopView:Dispose()
	EatSnakeShowPopView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return EatSnakeShowPopView
