local var_0_0 = import("game.views.newHero.pages.HeroSkillPage")
local var_0_1 = class("MatrixHeroSkillPage", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.skillItemGo_ = {}
	arg_1_0.skillItem_ = {}

	for iter_1_0 = 1, 6 do
		arg_1_0.skillItemGo_[iter_1_0] = arg_1_0["skillItem" .. iter_1_0 .. "Go_"]
		arg_1_0.skillItem_[iter_1_0] = MatrixHeroSkillItem.New(arg_1_0, arg_1_0.skillItemGo_[iter_1_0])
	end

	SetActive(arg_1_0.teachingBtn_.gameObject, false)
end

function var_0_1.AddUIListener(arg_2_0)
	for iter_2_0 = 1, 6 do
		arg_2_0.skillItem_[iter_2_0]:RegistCallBack(function(arg_3_0)
			JumpTools.OpenPageByJump("matrixSkillUpgrade", {
				skillId = arg_3_0.id,
				heroId = arg_3_0.heroId,
				standardId = arg_2_0.standardID,
				servantId = arg_3_0.servantId,
				lv = arg_3_0.lv
			})
		end)
	end

	arg_2_0:AddBtnListener(arg_2_0.buttonComboSkill_, nil, function()
		arg_2_0:Go("matrixOrigin/matrixComboSkillInfo", {
			heroId = arg_2_0.heroInfo_.id
		})
	end)
end

function var_0_1.OnEnter(arg_5_0, arg_5_1)
	return
end

function var_0_1.SetMatirxHeroInfo(arg_6_0, arg_6_1)
	arg_6_0.heroId_ = arg_6_1

	local var_6_0 = arg_6_0:GetHeroData(arg_6_1)
	local var_6_1 = var_6_0:GetStandardId()

	arg_6_0.standardID = var_6_1

	local var_6_2

	if var_6_0:GetIsOwnerHero() then
		local var_6_3 = var_6_0:GetEntrySnapShot()

		var_6_2 = GetPracticalData(var_6_3)
	else
		var_6_2 = GetVirtualData(var_6_1)
	end

	arg_6_0.heroInfo_ = var_6_2
	arg_6_0.heroInfo_.servantId = var_6_0:GetWeaponServantEffect()

	arg_6_0:UpdateView()
end

function var_0_1.RefreshSkillItemS(arg_7_0)
	arg_7_0.skillList_ = arg_7_0:GetMatrixHeroSkillInfo(arg_7_0.heroInfo_)

	for iter_7_0 = 1, 6 do
		arg_7_0.skillItem_[iter_7_0]:RefreshData(arg_7_0, arg_7_0.skillList_[iter_7_0])
	end
end

function var_0_1.GetMatrixHeroSkillInfo(arg_8_0, arg_8_1)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.skill) do
		if SkillTools.GetIsDodgeSkill(iter_8_1.skill_id) then
			var_8_0[iter_8_1.skill_id] = 1
		else
			var_8_0[iter_8_1.skill_id] = iter_8_1.skill_level
		end
	end

	local var_8_1 = {}

	for iter_8_2, iter_8_3 in ipairs(HeroCfg[arg_8_1.id].skills) do
		local var_8_2 = HeroTools.GetHeroSkillAddLevel(arg_8_1, iter_8_3)

		if SkillTools.GetIsDodgeSkill(iter_8_3) then
			var_8_2 = 0
		end

		table.insert(var_8_1, {
			isCanUp = false,
			id = iter_8_3,
			heroId = arg_8_1.id,
			lv = var_8_0[iter_8_3] or 0,
			addSkillLv = var_8_2,
			servantId = arg_8_1.servantId
		})
	end

	return var_8_1
end

function var_0_1.GetHeroData(arg_9_0, arg_9_1)
	return MatrixData:GetHeroData(arg_9_1)
end

return var_0_1
