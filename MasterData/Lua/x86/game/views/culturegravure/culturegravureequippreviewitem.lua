local CultureGravureEquipPreviewItem = class("CultureGravureEquipPreviewItem", ReduxView)

function CultureGravureEquipPreviewItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CultureGravureEquipPreviewItem:Init()
	self:InitUI()
	self:AddListeners()
end

function CultureGravureEquipPreviewItem:InitUI()
	self:BindCfgUI()

	self.statusController_ = self.control_:GetController("status")
	self.qualityController_ = self.control_:GetController("quality")
	self.enchantController_ = self.control_:GetController("enchant")
	self.resetController_ = self.control_:GetController("reset")
	self.emptyController_ = self.control_:GetController("empty")
	self.starController_ = ControllerUtil.GetController(self.equipItem_, "star")
	self.posController_ = ControllerUtil.GetController(self.equipItem_, "position")
end

function CultureGravureEquipPreviewItem:AddListeners()
	return
end

function CultureGravureEquipPreviewItem:SetData(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_1 and (arg_5_1.equip_id ~= 0 or arg_5_3) then
		local var_5_0 = EquipCfg[arg_5_1.prefab_id]

		self.imgIcon_.sprite = ItemTools.getItemSprite(arg_5_1.prefab_id, nil, true)
		self.textName_.text = ItemTools.getItemName(arg_5_1.prefab_id)

		self.starController_:SetSelectedState(var_5_0.starlevel)
		self.qualityController_:SetSelectedState(var_5_0.starlevel)
		self.enchantController_:SetSelectedState(arg_5_1:GetEnchantCount())

		self.level_ = arg_5_1:GetLevel()
		self.textLv_.text = string.format(GetTips("LEVEL") .. "：%s/%s", self.level_, (arg_5_1:GetMaxLv()))

		self.posController_:SetSelectedState(var_5_0.pos)
		self:RreshReset(arg_5_1)
	end

	if arg_5_1 == nil or arg_5_1.equip_id == 0 and not arg_5_3 then
		self.statusController_:SetSelectedState("empty")
		self.emptyController_:SetSelectedState(arg_5_4)
	elseif arg_5_2 == "had" and arg_5_3 then
		self.statusController_:SetSelectedState("equipped")
	else
		self.statusController_:SetSelectedState("current")
	end
end

function CultureGravureEquipPreviewItem:RreshReset(arg_6_1)
	if arg_6_1 and arg_6_1.race ~= 0 then
		self.resetController_:SetSelectedState("true")

		if table.keyof(RaceEffectCfg.all, arg_6_1.race) ~= nil then
			self.textReset_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(RaceEffectCfg[arg_6_1.race].name))
			self.imgReset_.sprite = getSprite("Atlas/SystemGroupAtlas", RaceEffectCfg[arg_6_1.race].icon2)
			self.imgReset_.color = Color(0.49019607843137253, 0.5411764705882353, 0.596078431372549)
		else
			self.textReset_.text = string.format(GetTips("EQUIP_HERO_ATTRIBUTE_UP"), HeroTools.GetHeroFullName(arg_6_1.race))
			self.imgReset_.sprite = HeroTools.GetSmallHeadSprite(arg_6_1.race)
			self.imgReset_.color = Color.white
		end
	else
		self.resetController_:SetSelectedState("false")
	end
end

function CultureGravureEquipPreviewItem:Dispose()
	CultureGravureEquipPreviewItem.super.Dispose(self)
end

return CultureGravureEquipPreviewItem
