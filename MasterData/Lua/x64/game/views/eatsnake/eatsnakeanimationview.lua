local EatSnakeAnimationView = class("EatSnakeAnimationView", ReduxView)

function EatSnakeAnimationView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_3_10_SnakegameUI/SandPlay_3_10_SnakegameUnlockpopUI"
end

function EatSnakeAnimationView:UIParent()
	return manager.ui.uiPop.transform
end

function EatSnakeAnimationView:Init()
	self:InitUI()
	self:AddUIListener()
end

function EatSnakeAnimationView:InitUI()
	self:BindCfgUI()

	self.animController_ = self.animCon_:GetController("animEffect")
end

function EatSnakeAnimationView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self.Back()
		JumpTools.GoToSystem("eatSnakeResult", {
			type = 1,
			time = self.params_.time,
			id = self.params_.id,
			parent = self.params_.parent
		})
	end)
end

function EatSnakeAnimationView:OnEnter()
	self.animController_:SetSelectedState(table.indexof(ActivityEatSnakeCfg.all, self.params_.id))
	self:UpdateData()
	self:UpdateView()
end

function EatSnakeAnimationView:UpdateData()
	self.cfg = ActivityEatSnakeCfg[self.params_.id]
end

function EatSnakeAnimationView:UpdateView()
	self.image_.sprite = pureGetSpriteWithoutAtlas(self.cfg.image)
	self.nameTxt_.text = self.cfg.name
	self.time = TimeTools.StartAfterSeconds(5, function()
		self.Back()
		JumpTools.GoToSystem("eatSnakeResult", {
			type = 1,
			time = self.params_.time,
			id = self.params_.id,
			parent = self.params_.parent
		})
	end, {})
end

function EatSnakeAnimationView:OnExit()
	if self.time then
		self.time:Stop()

		self.time = nil
	end
end

function EatSnakeAnimationView:Dispose()
	EatSnakeAnimationView.super.Dispose(self)
end

return EatSnakeAnimationView
