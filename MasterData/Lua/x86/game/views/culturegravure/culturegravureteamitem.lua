local CultureGravureTeamItem = class("CultureGravureTeamItem", ReduxView)

function CultureGravureTeamItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CultureGravureTeamItem:Init()
	self:InitUI()
	self:AddListeners()
end

function CultureGravureTeamItem:InitUI()
	self:BindCfgUI()

	self.isShowDetail_ = false
	self.detailController_ = self.itemCon_:GetController("detail")

	self:InitHero()
end

function CultureGravureTeamItem:InitHero()
	self.heros = {}

	for iter_4_0 = 1, 3 do
		local var_4_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_4_0, self["hero_" .. iter_4_0])

		var_4_0.selectController = var_4_0.heroCon_:GetController("selected")
		var_4_0.lockController = var_4_0.heroCon_:GetController("lock")
		var_4_0.astroCon = {}

		for iter_4_1 = 1, 3 do
			var_4_0.astroCon[iter_4_1] = ControllerUtil.GetController(var_4_0["astro_" .. iter_4_1], "color")
		end

		for iter_4_2 = 1, 2 do
			local var_4_1 = var_4_0["equipBtn_" .. iter_4_2]

			self:AddBtnListener(var_4_0["equipBtn_" .. iter_4_2], nil, function()
				self.equipClickCb(EquipSuitCfg[self.teamCfg_.hero_equip_suit[iter_4_0][iter_4_2]].name, GetI18NText(EquipTools.GetEffectDesc(EquipSuitCfg[self.teamCfg_.hero_equip_suit[iter_4_0][iter_4_2]].suit_effect[1])), Vector3(var_4_1.transform.position.x, var_4_1.transform.position.y, var_4_1.transform.position.z), var_4_0.rightTrans_, iter_4_0 ~= 3)
			end)
		end

		table.insert(self.heros, var_4_0)
	end
end

function CultureGravureTeamItem:AddListeners()
	self:AddBtnListener(self.detailBtn_, nil, function()
		self:clickFun()
	end)
end

function CultureGravureTeamItem:RegisterTeamClick(arg_8_1)
	self.clickFun = arg_8_1
end

function CultureGravureTeamItem:SetEquipClickCallBack(arg_9_1)
	self.equipClickCb = arg_9_1
end

function CultureGravureTeamItem:SetData(arg_10_1, arg_10_2)
	self.teamCfg_ = RecommandTeamCfg[arg_10_1]

	self:IsShowDetail(false)

	for iter_10_0 = 1, 3 do
		self.heros[iter_10_0].heroIconImg_.sprite = HeroTools.GetHeadSprite(RecommandTeamCfg[arg_10_1].hero_id[iter_10_0])
		self.heros[iter_10_0].typeIconImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(RecommandTeamCfg[arg_10_1].hero_id[iter_10_0])
		self.heros[iter_10_0].nameText_.text = HeroCfg[RecommandTeamCfg[arg_10_1].hero_id[iter_10_0]].name
		self.heros[iter_10_0].rolePosText_.text = RecommandTeamCfg[arg_10_1].hero_desc[iter_10_0]

		for iter_10_1, iter_10_2 in ipairs(RecommandTeamCfg[arg_10_1].hero_astrolabe[iter_10_0]) do
			self.heros[iter_10_0].astroCon[iter_10_1]:SetSelectedState(AstrolabeTools.GetAstrolabeItemPos(iter_10_2, RecommandTeamCfg[arg_10_1].hero_id[iter_10_0]) or 1)
		end

		self.heros[iter_10_0].equip_1.spriteSync = "TextureConfig/Equip/icon_s/" .. EquipSuitCfg[RecommandTeamCfg[arg_10_1].hero_equip_suit[iter_10_0][1]].icon
		self.heros[iter_10_0].equip_2.spriteSync = "TextureConfig/Equip/icon_s/" .. EquipSuitCfg[RecommandTeamCfg[arg_10_1].hero_equip_suit[iter_10_0][2]].icon

		self.heros[iter_10_0].lockController:SetSelectedState(tostring(not HeroTools.GetHeroIsUnlock(RecommandTeamCfg[arg_10_1].hero_id[iter_10_0])))
	end
end

function CultureGravureTeamItem:IsShowDetail(arg_11_1)
	if arg_11_1 ~= nil then
		self.isShowDetail_ = arg_11_1

		self.detailController_:SetSelectedState(tostring(arg_11_1))
	else
		self.isShowDetail_ = not self.isShowDetail_

		self.detailController_:SetSelectedState(tostring(self.isShowDetail_))
	end
end

function CultureGravureTeamItem:Dispose()
	CultureGravureTeamItem.super.Dispose(self)
end

return CultureGravureTeamItem
