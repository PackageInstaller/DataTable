local CivilizationGameHeroView = class("CivilizationGameHeroView", ReduxView)

function CivilizationGameHeroView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Culture/V4_2_GodEaterUI_Culture_PlayHeroMessagePopUI"
end

function CivilizationGameHeroView:UIParent()
	return manager.ui.uiPop.transform
end

function CivilizationGameHeroView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CivilizationGameHeroView:InitUI()
	self:BindCfgUI()

	self.itemList_ = {}

	for iter_4_0 = 1, 6 do
		self.itemList_[iter_4_0] = CivilizationHeroHexItem.New(self["hex" .. iter_4_0 .. "Go_"])
	end

	self.heroController_ = self.heroControllerEx_:GetController("iconhero")
end

function CivilizationGameHeroView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function CivilizationGameHeroView:OnEnter()
	self.heroID_ = self.params_.heroID

	self:RefreshUI()
end

function CivilizationGameHeroView:RefreshUI()
	local var_8_0 = ActivityCivilizationHeroCfg[self.heroID_]

	self.nameText_.text = ActivityCivilizationHeroCfg[self.heroID_].name
	self.descText_.text = var_8_0.description

	if self.heroID_ == 1 then
		self.heroController_:SetSelectedIndex(1)
	else
		self.heroController_:SetSelectedIndex(0)
	end

	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(var_8_0.hex_skill_1) do
		table.insert(var_8_1, iter_8_1)
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_0.hex_skill_2) do
		table.insert(var_8_1, iter_8_3)
	end

	for iter_8_4, iter_8_5 in ipairs(var_8_0.hex_skill_3) do
		table.insert(var_8_1, iter_8_5)
	end

	for iter_8_6 = 1, 6 do
		self.itemList_[iter_8_6]:SetData(var_8_1[iter_8_6])
	end
end

function CivilizationGameHeroView:OnTop()
	manager.windowBar:HideBar()
end

function CivilizationGameHeroView:OnExit()
	manager.windowBar:HideBar()
end

function CivilizationGameHeroView:Dispose()
	for iter_11_0, iter_11_1 in pairs(self.itemList_) do
		iter_11_1:Dispose()
	end

	self.itemList_ = {}

	CivilizationGameHeroView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

function CivilizationGameHeroView:OnExitInput()
	JumpTools.Back()

	return true
end

return CivilizationGameHeroView
