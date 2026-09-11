local IlluIllustrationDetailPopView = class("IlluIllustrationDetailPopView", ReduxView)

function IlluIllustrationDetailPopView:UIName()
	return "Widget/System/IllustratedHandbook/IlluIllustrationSettingPopUI"
end

function IlluIllustrationDetailPopView:UIParent()
	return manager.ui.uiPop.transform
end

function IlluIllustrationDetailPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function IlluIllustrationDetailPopView:InitUI()
	self:BindCfgUI()

	self.img_.immediate = true
	self.typeCon_ = ControllerUtil.GetController(self.gameObject_.transform, "type")
end

function IlluIllustrationDetailPopView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.addBtn_, nil, function()
		if #IllustratedData:GetAllLoadingSet() >= GameSetting.loading_pic_max.value[1] then
			ShowTips("SET_FAILED")

			return
		end

		IllustratedAction.ChangeLoadingSet(true, self.ID_)
		ShowTips("SET_CONFIRMED")
		self:Back()
	end)
	self:AddBtnListener(self.removeBtn, nil, function()
		IllustratedAction.ChangeLoadingSet(false, self.ID_)
		self:Back()
	end)
end

function IlluIllustrationDetailPopView:OnEnter()
	self.ID_ = self.params_.ID
	self.type_ = self.params_.type_
	self.cfg_ = CollectPictureCfg[self.ID_]

	self:RefreshUI()
end

function IlluIllustrationDetailPopView:RefreshUI()
	self.img_.spriteSync = self.type_ == 5 and "TextureConfig/Loading/" .. self.cfg_.picture or "TextureConfig/Background/" .. self.cfg_.picture
	self.name_.text = GetI18NText(self.cfg_.name)
	self.desc_.text = GetI18NText(self.cfg_.desc)

	if IllustratedData:IsInLoadingSet(self.ID_) then
		self.typeCon_:SetSelectedState("remove")

		self.title_.text = string.format(GetTips("REMOVE_CONFIRMED"), GetI18NText(self.cfg_.name), #IllustratedData:GetAllLoadingSet() .. "/" .. GameSetting.loading_pic_max.value[1])
	else
		self.typeCon_:SetSelectedState("add")

		self.title_.text = string.format(GetTips("SET_CONFIRMED_2"), GetI18NText(self.cfg_.name), #IllustratedData:GetAllLoadingSet() .. "/" .. GameSetting.loading_pic_max.value[1])
	end
end

function IlluIllustrationDetailPopView:OnExit()
	return
end

function IlluIllustrationDetailPopView:Dispose()
	self:RemoveAllListeners()
	IlluIllustrationDetailPopView.super.Dispose(self)
end

return IlluIllustrationDetailPopView
