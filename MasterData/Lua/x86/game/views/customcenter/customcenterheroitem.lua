local CustomCenterHeroItem = class("CustomCenterHeroItem", ReduxView)

function CustomCenterHeroItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.controllerEx_:GetController("selected")
	self.useController_ = self.controllerEx_:GetController("use")
end

function CustomCenterHeroItem:Dispose()
	CustomCenterHeroItem.super.Dispose(self)
end

function CustomCenterHeroItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.heroID_ == self.selectID_ then
			return
		end

		manager.notify:Invoke(CUSTOM_CENTER_SELECT_HERO, self.heroID_)
	end)
end

function CustomCenterHeroItem:SetHeroData(arg_5_1, arg_5_2)
	self.heroID_ = arg_5_1

	self:RefreshUI()
	self:SetSelected(arg_5_2)
end

function CustomCenterHeroItem:RefreshUI()
	self.nameText_.text = HeroTools.GetHeroFullName(self.heroID_)
	self.headIcon_.sprite = HeroTools.GetHeadSprite((PlayerData:GetCacheHeroSkinID(self.heroID_)))

	self:RefreshSelectedState()
	self:RefreshSkinCnt()
end

function CustomCenterHeroItem:SetSelected(arg_7_1)
	self.selectID_ = arg_7_1

	self:RefreshSelectedState()
end

function CustomCenterHeroItem:RefreshSelectedState()
	self.selectController_:SetSelectedState(tostring(self.selectID_ == self.heroID_))
end

function CustomCenterHeroItem:RefreshSkinCnt()
	local var_9_0 = CustomCenterTools.GetHeroUseSkinCnt(self.heroID_)

	if var_9_0 > 0 then
		self.useController_:SetSelectedState("true")

		self.skinCntText_.text = var_9_0

		return
	end

	self.useController_:SetSelectedState("false")
end

return CustomCenterHeroItem
