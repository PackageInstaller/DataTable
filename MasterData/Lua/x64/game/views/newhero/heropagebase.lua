local HeroPageBase = class("HeroPageBase", ReduxView)

function HeroPageBase:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function HeroPageBase:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroPageBase:InitUI()
	return
end

function HeroPageBase:AddUIListener()
	return
end

function HeroPageBase:SetHeroInfo(arg_5_1)
	return
end

function HeroPageBase:PlayEnterAni()
	self.playableDirector_ = self.playableDirector_ or self:FindCom(typeof(PlayableDirector), "panel")

	if self.playableDirector_ then
		self.playableDirector_.time = 0

		self.playableDirector_:Play()
	end
end

function HeroPageBase:OnEnter()
	return
end

function HeroPageBase:OnExit()
	return
end

function HeroPageBase:Hide()
	SetActive(self.gameObject_, false)
end

function HeroPageBase:Show()
	SetActive(self.gameObject_, true)
end

function HeroPageBase:Dispose()
	self:RemoveAllListeners()

	self.handler_ = nil

	HeroPageBase.super.Dispose(self)
end

return HeroPageBase
