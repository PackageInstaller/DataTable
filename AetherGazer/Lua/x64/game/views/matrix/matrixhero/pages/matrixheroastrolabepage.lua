local var_0_0 = import("game.views.newHero.pages.NewHeroAstrolabePage")
local var_0_1 = class("MatrixHeroAstrolabePage", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	ComponentBinder.GetInstance():BindCfgUI(arg_2_0, arg_2_0.m_content)

	arg_2_0.infoSGo_ = {}
end

function var_0_1.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListenerScale(arg_3_0.adjustBtn_, nil, function()
		JumpTools.OpenPageByJump("matrixOrigin/matrixAstrolabeAdjust", {
			heroId = arg_3_0.heroInfo_.id,
			selectPos = {
				0
			}
		})
	end)
end

function var_0_1.OnEnter(arg_5_0)
	return
end

function var_0_1.SelectItem(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:GetItemInfo()

	JumpTools.OpenPageByJump("matrixOrigin/matrixAstrolabeAdjust", {
		heroId = arg_6_0.heroInfo_.id,
		selectPos = {
			var_6_0.posX,
			var_6_0.posY
		}
	})
end

function var_0_1.SetMatirxHeroInfo(arg_7_0, arg_7_1)
	arg_7_0.heroId_ = arg_7_1

	local var_7_0 = arg_7_0:GetHeroData(arg_7_1)
	local var_7_1 = var_7_0:GetStandardId()
	local var_7_2

	if var_7_0:GetIsOwnerHero() then
		local var_7_3 = var_7_0:GetEntrySnapShot()

		var_7_2 = GetPracticalData(var_7_3)
	else
		var_7_2 = GetVirtualData(var_7_1)
	end

	arg_7_0.heroInfo_ = var_7_2
	arg_7_0.heroInfo_.using_astrolabe = var_7_0:GetAstrolabeEffectList()
	arg_7_0.heroInfo_.unlocked_astrolabe = HeroAstrolabeCfg.all
	arg_7_0.heroInfo_.servantId = var_7_0:GetWeaponServantEffect()

	arg_7_0:UpdateView()

	local var_7_4 = #var_7_0:GetAstrolabeEffectList()
	local var_7_5 = arg_7_0:GetAstrolabeMaxCount()

	arg_7_0.m_countLab.text = var_7_4 .. "/" .. var_7_5
end

function var_0_1.UpdateNotice(arg_8_0)
	return
end

function var_0_1.RefreshAstrolabeEffect(arg_9_0)
	local var_9_0 = AstrolabeTools.GetAcitveEffect(arg_9_0.heroInfo_.using_astrolabe)
	local var_9_1 = #var_9_0
	local var_9_2 = var_9_1 > 0
	local var_9_3 = ""

	for iter_9_0 = 1, var_9_1 do
		local var_9_4 = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[var_9_0[iter_9_0].id]
		local var_9_5 = HeroAstrolabeCfg[var_9_4[1]]

		var_9_3 = var_9_3 .. string.format("<size=32><color=#FFFFFF>%s\n\n</color></size>", GetI18NText(var_9_5.suit_name))

		local var_9_6 = var_9_0[iter_9_0].num

		for iter_9_1 = 1, var_9_6 do
			var_9_3 = var_9_3 .. GetI18NText(SkillTools.GetAstrolabeDescByServant(var_9_4[iter_9_1], arg_9_0.heroInfo_.servantId)) .. (iter_9_1 == var_9_6 and "" or "\n\n")
		end

		var_9_3 = var_9_3 .. (iter_9_0 == var_9_1 and "" or "\n\n")
	end

	SetActive(arg_9_0.nullGo_, not var_9_2)
	SetActive(arg_9_0.desGo_, var_9_2)

	arg_9_0.desText_.text = GetI18NText(var_9_3)
end

function var_0_1.GetHeroAstrolabeInfoView(arg_10_0)
	return MatrixHeroAstrolabeInfoView
end

function var_0_1.GetHeroData(arg_11_0, arg_11_1)
	return MatrixData:GetHeroData(arg_11_1)
end

function var_0_1.GetAstrolabeMaxCount(arg_12_0)
	return MatrixData:GetAstrolabeMaxCount()
end

return var_0_1
