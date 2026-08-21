local var_0_0 = class("CoreVerificationBossItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.bossType_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.heroHeadItem_ = {}

	for iter_3_0 = 1, 6 do
		arg_3_0.heroHeadItem_[iter_3_0] = CoreVerificationRoleIcon.New(arg_3_0["hero" .. iter_3_0 .. "Go_"])
	end

	arg_3_0.passController_ = arg_3_0.mainControllerEx_:GetController("passState")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.mainBtn_, nil, function()
		arg_4_0:Go("/coreVerificationInfo", {
			bossType = arg_4_0.bossType_
		})
	end)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {
		hero_id = arg_6_0.lockHero_[arg_6_1],
		skin_id = HeroTools.HeroUsingSkinInfo(arg_6_0.lockHero_[arg_6_1]).id
	}

	arg_6_2:SetData(var_6_0)
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0.lockHero_ = CoreVerificationData:GetLockHeroByBossType(arg_7_0.bossType_)

	local var_7_0, var_7_1, var_7_2 = CoreVerificationData:GetMaxPassByBossType(arg_7_0.bossType_)

	if var_7_0 then
		arg_7_0.passController_:SetSelectedState("complete")

		arg_7_0.timeText_.text = manager.time:DescCdTime2(var_7_2)
	else
		arg_7_0.passController_:SetSelectedState("empty")
	end

	for iter_7_0 = 1, 6 do
		arg_7_0.heroHeadItem_[iter_7_0]:SetData(arg_7_0.lockHero_[iter_7_0])
	end

	arg_7_0.diffText_.text = var_7_1

	local var_7_3 = CoreVerificationData:GetBossUICfgByBossType(arg_7_0.bossType_)

	arg_7_0.bossImg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.BossAttribute.path, var_7_3.icon))

	local var_7_4 = CoreVerificationData:GetRecommendByBossType(arg_7_0.bossType_)

	if var_7_4[1] then
		SetActive(arg_7_0.recommend1Img_.gameObject, true)

		arg_7_0.recommend1Img_.sprite = HeroTools.GetSkillAttributeIcon(var_7_4[1])
	else
		SetActive(arg_7_0.recommend1Img_.gameObject, false)
	end

	if var_7_4[2] then
		SetActive(arg_7_0.recommend2Img_.gameObject, true)

		arg_7_0.recommend2Img_.sprite = HeroTools.GetSkillAttributeIcon(var_7_4[2])
	else
		SetActive(arg_7_0.recommend2Img_.gameObject, false)
	end

	if table.isEmpty(var_7_4) then
		SetActive(arg_7_0.recommend1Img_.gameObject, true)

		arg_7_0.recommend1Img_.sprite = HeroTools.GetSkillAttributeIcon()
	end
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0 = 1, 6 do
		if arg_8_0.heroHeadItem_[iter_8_0] then
			arg_8_0.heroHeadItem_[iter_8_0]:Dispose()

			arg_8_0.heroHeadItem_[iter_8_0] = nil
		end
	end

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
