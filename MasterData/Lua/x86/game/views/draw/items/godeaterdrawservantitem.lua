local GodEaterDrawServantItem = class("GodEaterDrawServantItem", ReduxView)

function GodEaterDrawServantItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GodEaterDrawServantItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.selectController_ = self.controller_:GetController("select")
end

function GodEaterDrawServantItem:InitUI()
	self:BindCfgUI()
end

function GodEaterDrawServantItem:AddUIListener()
	self:AddBtnListener(self.button_, nil, function()
		if self.clickFunc then
			self.clickFunc(self.id_)
		end
	end)
	self:AddBtnListener(self.lookBtn_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = self.id_
		})
	end)
end

function GodEaterDrawServantItem:AddEventListeners()
	return
end

function GodEaterDrawServantItem:SetData(arg_8_1, arg_8_2)
	self.index_ = arg_8_1
	self.id_ = arg_8_2
	self.cfg_ = HeroCfg[self.id_]

	self:UpdateView()
end

function GodEaterDrawServantItem:RegistClickFunc(arg_9_1)
	self.clickFunc = arg_9_1
end

function GodEaterDrawServantItem:UpdateView()
	self.roleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.id_)
	self.campImg_.sprite = HeroTools.GetHeroRaceIcon(self.id_)
	self.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(self.id_)
	self.nameText_.text = self.cfg_.name
	self.suffixText_.text = self.cfg_.suffix
end

function GodEaterDrawServantItem:RefreshSelect(arg_11_1)
	if arg_11_1 then
		self.selectController_:SetSelectedState("true")
	else
		self.selectController_:SetSelectedState("false")
	end
end

function GodEaterDrawServantItem:OnEnter()
	self:AddEventListeners()
end

function GodEaterDrawServantItem:OnExit()
	self:RemoveAllEventListener()
end

function GodEaterDrawServantItem:Dispose()
	self.data_ = nil

	GodEaterDrawServantItem.super.Dispose(self)
end

return GodEaterDrawServantItem
