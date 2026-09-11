local MatrixHeroSkillPage = class("MatrixHeroSkillPage", (import("game.views.newHero.pages.HeroSkillPage")))

function MatrixHeroSkillPage:InitUI()
	self:BindCfgUI()

	self.skillItemGo_ = {}
	self.skillItem_ = {}

	for iter_1_0 = 1, 6 do
		self.skillItemGo_[iter_1_0] = self["skillItem" .. iter_1_0 .. "Go_"]
		self.skillItem_[iter_1_0] = MatrixHeroSkillItem.New(self, self.skillItemGo_[iter_1_0])
	end

	SetActive(self.teachingBtn_.gameObject, false)
end

function MatrixHeroSkillPage:AddUIListener()
	for iter_2_0 = 1, 6 do
		self.skillItem_[iter_2_0]:RegistCallBack(function(arg_3_0)
			JumpTools.OpenPageByJump("matrixSkillUpgrade", {
				skillId = arg_3_0.id,
				heroId = arg_3_0.heroId,
				standardId = self.standardID,
				servantId = arg_3_0.servantId,
				lv = arg_3_0.lv
			})
		end)
	end

	self:AddBtnListener(self.buttonComboSkill_, nil, function()
		self:Go("matrixOrigin/matrixComboSkillInfo", {
			heroId = self.heroInfo_.id
		})
	end)
end

function MatrixHeroSkillPage:OnEnter(arg_5_1)
	return
end

function MatrixHeroSkillPage:SetMatirxHeroInfo(arg_6_1)
	self.heroId_ = arg_6_1

	local var_6_0 = self:GetHeroData(arg_6_1)
	local var_6_1 = var_6_0:GetStandardId()

	self.standardID = var_6_1
	self.heroInfo_ = var_6_0:GetIsOwnerHero() and GetPracticalData((var_6_0:GetEntrySnapShot())) or GetVirtualData(var_6_1)
	self.heroInfo_.servantId = var_6_0:GetWeaponServantEffect()

	self:UpdateView()
end

function MatrixHeroSkillPage:RefreshSkillItemS()
	self.skillList_ = self:GetMatrixHeroSkillInfo(self.heroInfo_)

	for iter_7_0 = 1, 6 do
		self.skillItem_[iter_7_0]:RefreshData(self, self.skillList_[iter_7_0])
	end
end

function MatrixHeroSkillPage:GetMatrixHeroSkillInfo(arg_8_1)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.skill) do
		var_8_0[iter_8_1.skill_id] = SkillTools.GetIsDodgeSkill(iter_8_1.skill_id) and 1 or iter_8_1.skill_level
	end

	local var_8_1 = {}

	for iter_8_2, iter_8_3 in ipairs(HeroCfg[arg_8_1.id].skills) do
		local var_8_2 = HeroTools.GetHeroSkillAddLevel(arg_8_1, iter_8_3)

		if SkillTools.GetIsDodgeSkill(iter_8_3) then
			var_8_2 = 0
		end

		local var_8_4 = {
			isCanUp = false,
			id = iter_8_3,
			heroId = arg_8_1.id
		}

		var_8_4.lv = var_8_0[iter_8_3] or 0
		var_8_4.addSkillLv = var_8_2
		var_8_4.servantId = arg_8_1.servantId

		table.insert(var_8_1, var_8_4)
	end

	return var_8_1
end

function MatrixHeroSkillPage:GetHeroData(arg_9_1)
	return MatrixData:GetHeroData(arg_9_1)
end

return MatrixHeroSkillPage
