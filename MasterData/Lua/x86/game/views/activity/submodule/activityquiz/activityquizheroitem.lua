local ActivityQuizHeroItem = class("ActivityQuizHeroItem", ReduxView)

function ActivityQuizHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityQuizHeroItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityQuizHeroItem:InitUI()
	self:BindCfgUI()

	self.selectCon_ = ControllerUtil.GetController(self.transform_, "select")
end

function ActivityQuizHeroItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		ActivityQuizAction.ChangeHero(self.heroID_)
	end)
end

function ActivityQuizHeroItem:RefreshUI(arg_6_1)
	self.heroID_ = arg_6_1
	self.icon_.sprite = getSpriteViaConfig("DormHeroHeadIcon", self.heroID_)
end

function ActivityQuizHeroItem:RefreshSelect(arg_7_1)
	self.selectCon_:SetSelectedState(arg_7_1 and "on" or "off")
end

function ActivityQuizHeroItem:OnExit()
	return
end

function ActivityQuizHeroItem:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivityQuizHeroItem
