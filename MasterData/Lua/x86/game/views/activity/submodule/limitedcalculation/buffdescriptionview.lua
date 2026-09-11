local BuffDescriptionView = class("BuffDescriptionView", ReduxView)

function BuffDescriptionView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function BuffDescriptionView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function BuffDescriptionView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, BuffDescriptionItem)
end

function BuffDescriptionView:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:RefreshUI(self.list_[arg_4_1])
end

function BuffDescriptionView:AddUIListeners()
	return
end

function BuffDescriptionView:OnEnter()
	return
end

function BuffDescriptionView:RefreshUI(arg_7_1, arg_7_2)
	self.id_ = arg_7_1
	self.type_ = arg_7_2
	self.cfg_ = ActivityLimitCalculationCfg[self.id_]

	if self.type_ == "buff" then
		self.title_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_PLAYER_LEVEL"), self.cfg_.player_level)
		self.list_ = self.cfg_.player_affix
	elseif self.type_ == "debuff" then
		self.title_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_ENEMY_LEVEL"), self.cfg_.enemy_level)
		self.list_ = self.cfg_.enemy_affix
	end

	self.scrollHelper_:StartScroll(#self.list_)
end

function BuffDescriptionView:OnExit()
	return
end

function BuffDescriptionView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	BuffDescriptionView.super.Dispose(self)
end

return BuffDescriptionView
