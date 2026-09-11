local HeroActionView = class("HeroActionView", ReduxView)

function HeroActionView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function HeroActionView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function HeroActionView:InitUI()
	self:BindCfgUI()

	self.heroActList_ = {
		"happy",
		"sad",
		"angry"
	}
	self.punishActList_ = {
		"happy",
		"angry"
	}
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, HeroActionItem)
	self.sizeCon_ = ControllerUtil.GetController(self.transform_, "size")
end

function HeroActionView:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:Refresh(self.list_[arg_4_1])
end

function HeroActionView:AddUIListeners()
	return
end

function HeroActionView:OnEnter()
	self.list_ = self.heroActList_

	self.scrollHelper_:StartScroll(#self.list_)
end

function HeroActionView:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function HeroActionView:RefreshList(arg_8_1)
	if arg_8_1 == 1 then
		self.list_ = self.heroActList_ or self.punishActList_
	end

	self.sizeCon_:SetSelectedState(arg_8_1 == 1 and "true" or "false")
	self.scrollHelper_:StartScroll(#self.list_)
end

function HeroActionView:OnExit()
	self:RemoveAllEventListener()
end

function HeroActionView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	self.super.Dispose(self)
end

return HeroActionView
