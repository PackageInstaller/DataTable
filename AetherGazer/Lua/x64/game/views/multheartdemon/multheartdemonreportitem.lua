local var_0_0 = class("MultHeartDemonCombatItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stateController = arg_4_0.controlExCo_:GetController("state")
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.index = arg_5_1
	arg_5_0.data = arg_5_2

	arg_5_0:UpdateView()
end

function var_0_0.UpdatePlayer(arg_6_0, arg_6_1)
	local var_6_0
	local var_6_1 = HeroStandardSystemCfg[arg_6_1.heroId]

	if var_6_1 then
		arg_6_0.playerIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. var_6_1.skin_id)
		var_6_0 = var_6_1.hero_id
	else
		var_6_0 = arg_6_1.heroId

		local var_6_2 = HeroData:GetHeroUsingSkinInfo(var_6_0).id

		arg_6_0.playerIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. var_6_2)
	end

	arg_6_0.playerNameTxt_.text = HeroTools.GetHeroFullName(var_6_0)
	arg_6_0.playerSlider_.value = arg_6_1.heroHP == 0 and 0 or arg_6_1.heroHP / 100
	arg_6_0.playerHp_.text = arg_6_1.heroHP .. "%"
end

function var_0_0.UpdateAI(arg_7_0, arg_7_1)
	arg_7_0.aiSlider_.value = arg_7_1.bossHP == 0 and 0 or arg_7_1.bossHP / 100
	arg_7_0.aiHp_.text = arg_7_1.bossHP .. "%"
	arg_7_0.aiIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_7_1.bossId - 4000)
	arg_7_0.aiNameTxt_.text = arg_7_0.nameTable[arg_7_1.bossId]
end

function var_0_0.UpdateView(arg_8_0)
	if arg_8_0.data then
		local var_8_0 = arg_8_0.data.stageData[#arg_8_0.data.stageData - arg_8_0.index + 1]

		arg_8_0.nameTable = MultHeartDemonData:GetDataByPara("nameTable")

		arg_8_0:UpdateAI(var_8_0)
		arg_8_0:UpdatePlayer(var_8_0)
		arg_8_0.stateController:SetSelectedState(var_8_0.bossHP == 0 and "true" or "false")

		arg_8_0.scoreTxt_.text = var_8_0.maxScore
		arg_8_0.timeImg_.sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemonUI_" .. 1505 + arg_8_0.index)
	end
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:UpdateView()
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
	Object.Destroy(arg_10_0.gameObject_)
end

return var_0_0
