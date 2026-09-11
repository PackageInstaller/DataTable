local MatrixSelectHeroItem = class("MatrixSelectHeroItem", ReduxView)

function MatrixSelectHeroItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index = 0

	self:initUI()
	self:AddUIListener()
end

function MatrixSelectHeroItem:initUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.m_statetController, "state")
	self.captainController_ = ControllerUtil.GetController(self.m_statetController, "captain")
	self.lockController = ControllerUtil.GetController(self.m_statetController, "lock")
	self.levelController = ControllerUtil.GetController(self.m_statetController, "level")
end

function MatrixSelectHeroItem:CheckHeroLock(arg_3_1)
	local var_3_0 = HeroData:GetHeroData(arg_3_1)

	if not var_3_0 or var_3_0.unlock ~= 1 then
		return true, GetTips("MATRIX_SINGULARITY_HERO_UNLOCK")
	elseif GameSetting.matrix_singularity_hero_level_limited.value[1] > var_3_0.level then
		return true, string.format(GetTips("MATRIX_SINGULARITY_HERO_LEVEL_UNLOCK"), GameSetting.matrix_singularity_hero_level_limited.value[1])
	end

	return false
end

function MatrixSelectHeroItem:AddUIListener()
	self:AddBtnListener(self.m_clickBtn, nil, function()
		if self.difficulty == 3 then
			local var_5_0, var_5_1 = self:CheckHeroLock(self.heroId)

			if var_5_0 then
				ShowTips(var_5_1)

				return
			end
		end

		if self.clickFunc then
			self.clickFunc()
		end
	end)
end

function MatrixSelectHeroItem:Refresh(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.heroStandardId = arg_6_1

	if not HeroStandardSystemCfg[arg_6_1] then
		return
	end

	local var_6_0 = HeroStandardSystemCfg[arg_6_1].hero_id

	self.m_icon.sprite = getSpriteViaConfig("HeroIcon", SkinCfg[MatrixData:GetHeroSkin(HeroStandardSystemCfg[arg_6_1].hero_id) or var_6_0].picture_id)
	self.m_name.text = GetI18NText(HeroCfg[HeroStandardSystemCfg[arg_6_1].hero_id].name)
	self.m_tip.text = GetI18NText(HeroStandardSystemCfg[arg_6_1].hero_desc) or ""
	self.difficulty = arg_6_4
	self.heroId = var_6_0

	if arg_6_4 == 3 then
		if self:CheckHeroLock(var_6_0) then
			arg_6_2 = 2

			self.lockController:SetSelectedIndex(1)
			self.levelController:SetSelectedIndex(0)
		else
			self.lockController:SetSelectedIndex(0)
			self.levelController:SetSelectedIndex(1)

			self.m_levelLab.text = HeroData:GetHeroData(var_6_0).level
		end

		self.m_clickBtn.interactable = true
	else
		self.lockController:SetSelectedIndex(0)
		self.levelController:SetSelectedIndex(0)

		self.m_clickBtn.interactable = arg_6_2 == 0 or arg_6_2 == 1
	end

	self.stateController_:SetSelectedIndex(arg_6_2)
	self.captainController_:SetSelectedIndex(arg_6_3 and 1 or 0)
end

function MatrixSelectHeroItem:RegistCallBack(arg_7_1)
	self.clickFunc = arg_7_1
end

return MatrixSelectHeroItem
