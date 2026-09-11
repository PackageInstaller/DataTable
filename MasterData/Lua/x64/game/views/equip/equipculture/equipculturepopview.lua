local EquipCulturePopView = class("EquipCulturePopView", (import("game.views.pop.PopLevelUpBaseView")))

function EquipCulturePopView:UIName()
	return "Widget/System/Hero_equip/Develop/EquipupPopUI"
end

function EquipCulturePopView:UIParent()
	return manager.ui.uiPop.transform
end

function EquipCulturePopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function EquipCulturePopView:InitUI()
	self:BindCfgUI()

	self.attrs_ = {}

	for iter_4_0 = 1, 2 do
		local var_4_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_4_0, self["attr_" .. iter_4_0])
		table.insert(self.attrs_, var_4_0)
	end

	self.stateController_ = self.transCon_:GetController("state")
	self.upgradeController_ = self.transCon_:GetController("upgrade")
end

function EquipCulturePopView:AddUIListener()
	self:AddBtnListener(self.btnBack_, nil, function()
		SetActive(self.oldLv_.gameObject, false)
		manager.notify:Invoke(EQUIP_CULTURE_SUCCESS)
		self:Back()

		if self.params_.callback then
			self.params_.callback()

			self.params_.callback = nil
		end
	end)
end

function EquipCulturePopView:OnEnter()
	self:CheckBack()
	self:RefreshUI()
end

function EquipCulturePopView:RefreshUI()
	SetActive(self.oldLv_.gameObject, true)
	self:RefreshType(self.params_.type)

	if self.params_.type ~= "reset" then
		if not self.params_.oldEquip or not self.params_.newEquip then
			return
		end

		local var_8_0 = self.params_.oldEquip:GetLevel()
		local var_8_1 = self.params_.newEquip:GetLevel()
		local var_8_2 = EquipTools.CountEquipAttribute(self.params_.newEquip)

		for iter_8_0, iter_8_1 in pairs((EquipTools.CountEquipAttribute(self.params_.oldEquip))) do
			local var_8_3 = math.floor(iter_8_1)
			local var_8_4 = math.floor(var_8_2[iter_8_0])

			if PublicAttrCfg[iter_8_0].percent and PublicAttrCfg[iter_8_0].percent == 1 then
				var_8_3 = iter_8_1 / 10 .. "%"
				var_8_4 = var_8_2[iter_8_0] / 10 .. "%"
			end

			self.attrs_[1].name_.text = GetI18NText(PublicAttrCfg[iter_8_0].name)
			self.attrs_[1].icon_.sprite = getSprite("Atlas/SystemCommonAtlas", PublicAttrCfg[iter_8_0].icon)
			self.attrs_[1].oldVal_.text = var_8_3
			self.attrs_[1].newVal_.text = var_8_4
		end
	end
end

function EquipCulturePopView:RefreshType(arg_9_1)
	local var_9_0 = self.params_.oldEquip
	local var_9_1 = self.params_.newEquip

	self.stateController_:SetSelectedState(arg_9_1 == "reset" and "reset" or "lv")
	self.upgradeController_:SetSelectedState("hide")

	if arg_9_1 == "levelup" then
		self.oldLv_.text = var_9_0:GetLevel()
		self.newLv_.text = var_9_1:GetLevel()
		self.mainTitle_.text = GetTips("EQUIP_LEVELUP_POP")

		if self.params_.breakTimes and self.params_.breakTimes > 0 then
			self.upgradeController_:SetSelectedState("show")

			self.oldUpgradeLv_.text = var_9_0:GetMaxLv()
			self.nowUpgradeLv_.text = var_9_1:GetMaxLv()
			self.params_.breakTimes = nil
		end
	elseif arg_9_1 == "upgrade" then
		self.oldLv_.text = var_9_0:GetMaxLv()
		self.newLv_.text = var_9_1:GetMaxLv()
		self.mainTitle_.text = GetTips("EQUIP_UPGRADE_POP")

		self:ShowUpGradeTips()
	elseif arg_9_1 == "reset" then
		self.resetHeroIcon_.sprite = SpritePathCfg.HeroMediumIcon.path .. self.params_.heroId
		self.resetDesc_.text = string.format(GetTips("EQUIP_HERO_RESET_POP"), HeroTools.GetHeroFullName(self.params_.heroId))
	end
end

function EquipCulturePopView:ShowUpGradeTips()
	local var_10_0

	var_10_0 = Timer.New(function()
		var_10_0:Stop()
		ShowTips("EQUIP_BREAK_SUCCESS")
	end, 1, 0)

	;(nil):Start()
end

function EquipCulturePopView:RefreshSkill(arg_12_1, arg_12_2)
	for iter_12_0 = 1, #arg_12_1 do
		if iter_12_0 > #self.skillItems_ then
			local var_12_0 = Object.Instantiate(self.skillItem_, self.skillParent_.transform)

			self.skillItems_[iter_12_0] = {
				gameObject = var_12_0,
				icon_ = self:FindCom(typeof(Image), "icon", var_12_0.transform),
				name_ = self:FindCom(typeof(Text), "lv", var_12_0.transform),
				lv_ = self:FindCom(typeof(Text), "name", var_12_0.transform)
			}
		end

		local var_12_1 = arg_12_1[iter_12_0]

		self.skillItems_[iter_12_0].icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. EquipSkillCfg[arg_12_1[iter_12_0].id].icon)
		self.skillItems_[iter_12_0].name_.text = GetI18NText(EquipSkillCfg[arg_12_1[iter_12_0].id].name)
		self.skillItems_[iter_12_0].lv_.text = GetTips("LEVEL") .. var_12_1.num
	end

	for iter_12_1, iter_12_2 in ipairs(self.skillItems_) do
		SetActive(iter_12_2.gameObject, iter_12_1 <= #arg_12_1)
	end
end

function EquipCulturePopView:GetPlayBackwardsAnimator()
	return {
		{
			self.animator_,
			"Fx_CompopUI04_xs",
			false
		}
	}, nil
end

function EquipCulturePopView:Dispose()
	EquipCulturePopView.super.Dispose(self)
end

return EquipCulturePopView
