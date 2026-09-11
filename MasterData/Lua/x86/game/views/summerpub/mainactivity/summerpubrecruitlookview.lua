local SummerPubRecruitLookView = class("SummerPubRecruitLookView", ReduxView)

RECRUIT_PATH = "TextureConfig/Character/Icon/"

function SummerPubRecruitLookView:UIName()
	return "Widget/System/Activity_SummerPub/MainPub/Activity_SummerPub_RecruitLookPopUI"
end

function SummerPubRecruitLookView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerPubRecruitLookView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SummerPubRecruitLookView:InitUI()
	self:BindCfgUI()
end

function SummerPubRecruitLookView:AddUIListeners()
	self:AddBtnListener(self.m_bgmask, nil, function()
		self:Back()
	end)
end

function SummerPubRecruitLookView:OnEnter()
	cfg = SummerPubHeroCfg[self.params_.id]
	self.heroName_.text = GetI18NText(cfg.hero_name)
	self.heroDesc_.text = GetI18NText(cfg.resume_desc)
	self.heroHobby_.text = GetI18NText(cfg.resume_preference)
	self.heroIcon_.sprite = pureGetSpriteWithoutAtlas(RECRUIT_PATH .. cfg.resume_icon)
end

function SummerPubRecruitLookView:OnExit()
	return
end

function SummerPubRecruitLookView:Dispose()
	self.super.Dispose(self)
end

return SummerPubRecruitLookView
