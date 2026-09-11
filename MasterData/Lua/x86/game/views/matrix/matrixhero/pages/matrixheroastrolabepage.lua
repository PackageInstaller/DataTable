local MatrixHeroAstrolabePage = class("MatrixHeroAstrolabePage", (import("game.views.newHero.pages.NewHeroAstrolabePage")))

function MatrixHeroAstrolabePage:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function MatrixHeroAstrolabePage:InitUI()
	self:BindCfgUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.m_content)

	self.infoSGo_ = {}
end

function MatrixHeroAstrolabePage:AddUIListener()
	self:AddBtnListenerScale(self.adjustBtn_, nil, function()
		JumpTools.OpenPageByJump("matrixOrigin/matrixAstrolabeAdjust", {
			heroId = self.heroInfo_.id,
			selectPos = {
				0
			}
		})
	end)
end

function MatrixHeroAstrolabePage:OnEnter()
	return
end

function MatrixHeroAstrolabePage:SelectItem(arg_6_1)
	local var_6_0 = arg_6_1:GetItemInfo()

	JumpTools.OpenPageByJump("matrixOrigin/matrixAstrolabeAdjust", {
		heroId = self.heroInfo_.id,
		selectPos = {
			var_6_0.posX,
			var_6_0.posY
		}
	})
end

function MatrixHeroAstrolabePage:SetMatirxHeroInfo(arg_7_1)
	self.heroId_ = arg_7_1

	local var_7_0 = self:GetHeroData(arg_7_1)

	self.heroInfo_ = var_7_0:GetIsOwnerHero() and GetPracticalData((var_7_0:GetEntrySnapShot())) or GetVirtualData((var_7_0:GetStandardId()))
	self.heroInfo_.using_astrolabe = var_7_0:GetAstrolabeEffectList()
	self.heroInfo_.unlocked_astrolabe = HeroAstrolabeCfg.all
	self.heroInfo_.servantId = var_7_0:GetWeaponServantEffect()

	self:UpdateView()

	self.m_countLab.text = #var_7_0:GetAstrolabeEffectList() .. "/" .. self:GetAstrolabeMaxCount()
end

function MatrixHeroAstrolabePage:UpdateNotice()
	return
end

function MatrixHeroAstrolabePage:RefreshAstrolabeEffect()
	local var_9_0 = AstrolabeTools.GetAcitveEffect(self.heroInfo_.using_astrolabe)
	local var_9_1 = #var_9_0
	local var_9_2 = #var_9_0 > 0
	local var_9_3 = ""

	for iter_9_0 = 1, #var_9_0 do
		local var_9_4 = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[var_9_0[iter_9_0].id]

		var_9_3 = var_9_3 .. string.format("<size=32><color=#FFFFFF>%s\n\n</color></size>", GetI18NText(HeroAstrolabeCfg[HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[var_9_0[iter_9_0].id][1]].suit_name))

		local var_9_5 = var_9_0[iter_9_0].num

		for iter_9_1 = 1, var_9_0[iter_9_0].num do
			var_9_3 = var_9_3 .. GetI18NText(SkillTools.GetAstrolabeDescByServant(var_9_4[iter_9_1], self.heroInfo_.servantId)) .. (iter_9_1 == var_9_5 and "" or "\n\n")
		end

		var_9_3 = var_9_3 .. (iter_9_0 == var_9_1 and "" or "\n\n")
	end

	SetActive(self.nullGo_, not var_9_2)
	SetActive(self.desGo_, var_9_2)

	self.desText_.text = GetI18NText(var_9_3)
end

function MatrixHeroAstrolabePage:GetHeroAstrolabeInfoView()
	return MatrixHeroAstrolabeInfoView
end

function MatrixHeroAstrolabePage:GetHeroData(arg_11_1)
	return MatrixData:GetHeroData(arg_11_1)
end

function MatrixHeroAstrolabePage:GetAstrolabeMaxCount()
	return MatrixData:GetAstrolabeMaxCount()
end

return MatrixHeroAstrolabePage
