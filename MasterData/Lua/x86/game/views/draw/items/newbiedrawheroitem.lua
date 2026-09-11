local NewBieDrawHeroItem = class("NewBieDrawHeroItem", ReduxView)

function NewBieDrawHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NewBieDrawHeroItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.selectController_ = self.controller_:GetController("select")
end

function NewBieDrawHeroItem:InitUI()
	self:BindCfgUI()
end

function NewBieDrawHeroItem:AddUIListener()
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

function NewBieDrawHeroItem:AddEventListeners()
	return
end

function NewBieDrawHeroItem:SetData(arg_8_1, arg_8_2)
	self.index_ = arg_8_1
	self.id_ = arg_8_2
	self.cfg_ = HeroCfg[self.id_]

	self:UpdateView()
end

function NewBieDrawHeroItem:RegistClickFunc(arg_9_1)
	self.clickFunc = arg_9_1
end

function NewBieDrawHeroItem:UpdateView()
	self.roleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.id_)
	self.campImg_.sprite = HeroTools.GetHeroRaceIcon(self.id_)
	self.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(self.id_)
	self.nameText_.text = self.cfg_.name
	self.suffixText_.text = self.cfg_.suffix
end

function NewBieDrawHeroItem:RefreshSelect(arg_11_1)
	if arg_11_1 then
		self.selectController_:SetSelectedState("true")
	else
		self.selectController_:SetSelectedState("false")
	end
end

function NewBieDrawHeroItem:OnEnter()
	self:AddEventListeners()
end

function NewBieDrawHeroItem:OnExit()
	self:RemoveAllEventListener()
end

function NewBieDrawHeroItem:Dispose()
	self.data_ = nil

	NewBieDrawHeroItem.super.Dispose(self)
end

return NewBieDrawHeroItem
