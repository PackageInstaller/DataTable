local EquipItem = class("EquipItem", ReduxView)

function EquipItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function EquipItem:InitUI()
	self:BindCfgUI()

	self.starController_ = self.equipController_:GetController("star")
	self.posController_ = self.equipController_:GetController("equippos")
	self.lvController_ = self.equipController_:GetController("lv")
	self.selectController_ = self.equipController_:GetController("sel")
	self.emptyController_ = self.equipController_:GetController("empty")
	self.detailController_ = self.equipController_:GetController("lvstate")

	self:AddUIListeners()
end

function EquipItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		self:OnClick()
	end)
end

function EquipItem:RefreshData(arg_5_1, arg_5_2)
	self.info_ = arg_5_1
	self.isShowDetail_ = arg_5_2

	self:RefreshUI()
end

function EquipItem:RefreshUI()
	self.isEquip_ = self.info_ and self.info_.prefab_id ~= 0

	self.emptyController_:SetSelectedState(self.isEquip_ and "notEmpty" or "empty")
	self.detailController_:SetSelectedState(self.isEquip_ and self.isShowDetail_ and "show" or "hide")

	if self.isEquip_ then
		self:RefreshDetail()

		self.equipIcon_.sprite = ItemTools.getItemSprite(self.info_.prefab_id)
	end
end

function EquipItem:RefreshDetail()
	if self.isEquip_ then
		self.starController_:SetSelectedState(EquipCfg[self.info_.prefab_id].starlevel)
		self.posController_:SetSelectedState(EquipCfg[self.info_.prefab_id].pos)

		self.level_.text = string.format(GetTips("DORM_LEVEL_TIPS"), self.info_:GetLevel())

		if self.info_.race == 0 then
			self.lvController_:SetSelectedState("level")
		elseif table.keyof(RaceEffectCfg.all, self.info_.race) ~= nil then
			if RaceEffectCfg[self.info_.race] then
				self.imgGroup_.sprite = getSprite("Atlas/SystemGroupAtlas", RaceEffectCfg[self.info_.race].icon2)

				self.lvController_:SetSelectedState("group")
			end
		elseif HeroCfg[self.info_.race] then
			self.imgHeroIcon_.sprite = HeroTools.GetSmallHeadSprite(self.info_.race)

			self.lvController_:SetSelectedState("hero")
		end
	end
end

function EquipItem:ShowSelect(arg_8_1)
	self.selectController_:SetSelectedState(arg_8_1 and "select" or "unselect")
end

function EquipItem:OnClick()
	if self.clickFunc then
		self.clickFunc(self.info_, self)
	end
end

function EquipItem:RegistCallBack(arg_10_1)
	self.clickFunc = arg_10_1
end

function EquipItem:GetItemInfo()
	return self.info_
end

function EquipItem:ShowAnim()
	self.emptyController_:SetSelectedState("notEmpty")

	if self.info_ and self.info_.prefab_id ~= 0 then
		self.effectAnim_:Play("Fx_icon_qiehuan")
	else
		self.iconAnim_:Play("Fx_icon_chuandai")
		self.effectAnim_:Play("Fx_icon_chuandai")
	end
end

function EquipItem:Hide()
	self.emptyController_:SetSelectedState("empty")
end

function EquipItem:Dispose()
	self.clickFunc = nil

	self:RemoveAllListeners()
	EquipItem.super.Dispose(self)
end

return EquipItem
