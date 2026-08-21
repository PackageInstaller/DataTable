local var_0_0 = import("game.views.newHero.HeroPageBase")
local var_0_1 = class("HeroSkillPage", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.skillItemGo_ = {}
	arg_3_0.skillItem_ = {}

	for iter_3_0 = 1, 6 do
		arg_3_0.skillItemGo_[iter_3_0] = arg_3_0["skillItem" .. iter_3_0 .. "Go_"]
		arg_3_0.skillItem_[iter_3_0] = HeroSkillViewItem.New(arg_3_0, arg_3_0.skillItemGo_[iter_3_0])

		if iter_3_0 == 6 then
			arg_3_0.skillItem_[iter_3_0]:SetAniState(false)
			arg_3_0.skillItem_[iter_3_0]:SetShowAdd(false)
		end
	end

	arg_3_0.skillitem6Ani_.enabled = false
	arg_3_0.comboskillAni_.enabled = false
end

function var_0_1.AddUIListener(arg_4_0)
	for iter_4_0 = 1, 6 do
		arg_4_0.skillItem_[iter_4_0]:RegistCallBack(function(arg_5_0)
			arg_4_0:Go("/skillView", {
				skillId = arg_5_0.id,
				heroInfo = arg_4_0.heroInfo_,
				proxy = arg_4_0.heroViewProxy_,
				aniEndPos = arg_4_0.skillTrs_.position
			})
		end)
	end

	arg_4_0:AddBtnListener(arg_4_0.buttonComboSkill_, nil, function()
		JumpTools.OpenPageByJump("comboSkillInfo", {
			heroID = arg_4_0.heroInfo_.id
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.teachingBtn_, nil, function()
		local var_7_0 = HeroCfg[arg_4_0.heroInfo_.id]

		BattleTeachData:SetCacheTeachHeroID(arg_4_0.heroInfo_.id)

		if var_7_0 and var_7_0.study_stage and var_7_0.study_stage[1] then
			JumpTools.OpenPageByJump("/teachStage", {
				switchType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
				heroID = arg_4_0.heroInfo_.id
			})
			JumpTools.OpenPageByJump("teachSectionInfo", {
				sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
				section = var_7_0.study_stage[1]
			})
		end
	end)
end

function var_0_1.SetHeroInfo(arg_8_0, arg_8_1)
	arg_8_0.heroInfo_ = arg_8_1
end

function var_0_1.UpdateView(arg_9_0)
	arg_9_0:RefreshSkillItemS()
	arg_9_0:RefreshTeachRedPoint()
	arg_9_0:RefreshComboSkillBtn()
end

function var_0_1.RefreshSkillItemS(arg_10_0)
	if not arg_10_0.heroInfo_ then
		return
	end

	arg_10_0.skillList_ = arg_10_0.heroViewProxy_:GetHeroSkillInfo(arg_10_0.heroInfo_.id)

	for iter_10_0 = 1, 6 do
		arg_10_0.skillItem_[iter_10_0]:RefreshData(arg_10_0.skillList_[iter_10_0])
	end
end

function var_0_1.RefreshTeachRedPoint(arg_11_0)
	local var_11_0 = HeroCfg[arg_11_0.heroInfo_.id].study_stage[1]
	local var_11_1 = BattleTeachData:GetHeroTeachInfo(arg_11_0.heroInfo_.id, var_11_0) <= 0 and not arg_11_0.extra_ and 1 or 0

	manager.redPoint:setTip(RedPointConst.HERO_TEACH_ID, var_11_1)
end

function var_0_1.RefreshComboSkillBtn(arg_12_0)
	local var_12_0 = ComboSkillTools.GetHeroComboSkill(arg_12_0.heroInfo_.id)

	if var_12_0 and #var_12_0 > 0 then
		SetActive(arg_12_0.buttonComboSkill_.gameObject, true)
	else
		SetActive(arg_12_0.buttonComboSkill_.gameObject, false)
	end
end

function var_0_1.OnHeroSkillUpgrade(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:RefreshSkillItemS()
end

function var_0_1.CameraEnter(arg_14_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		2,
		0
	})
end

function var_0_1.OnEnter(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.heroViewProxy_ = arg_15_1

	for iter_15_0 = 1, 6 do
		arg_15_0.skillItem_[iter_15_0]:SetProxy(arg_15_1)
	end

	arg_15_0.isSkillReturn = arg_15_2.isSkillReturn or false

	arg_15_0:BindRedPointUI()
	arg_15_0:AniUpdate()
end

function var_0_1.AniUpdate(arg_16_0)
	if arg_16_0.isSkillReturn then
		arg_16_0.skillAni_.enabled = false

		for iter_16_0 = 1, 5 do
			arg_16_0.skillItem_[iter_16_0]:SetAniState(false)
		end

		arg_16_0.handler_.params_.isSkillReturn = false
		arg_16_0.isSkillReturn = false
	else
		if arg_16_0.skillCxTimer then
			arg_16_0.skillCxTimer:Stop()

			arg_16_0.skillCxTimer = nil
		end

		arg_16_0.skillAni_:Update(0.5)
		arg_16_0.skillAni_:Play("Fx_skill_cx", 0, 0)
	end
end

function var_0_1.Show(arg_17_0)
	SetActive(arg_17_0.gameObject_, true)

	arg_17_0.skillitem6Ani_.enabled = false
	arg_17_0.comboskillAni_.enabled = false

	if not arg_17_0.isSkillReturn then
		arg_17_0:AniUpdate()
	end

	arg_17_0:RefreshSkillItemS()
	arg_17_0:RefreshComboSkillBtn()
end

function var_0_1.HideAni(arg_18_0)
	arg_18_0.skillAni_:Play("Fx_HeroSkillUI_change")

	arg_18_0.skillAni_.enabled = true

	for iter_18_0 = 1, 5 do
		arg_18_0.skillItem_[iter_18_0]:SetAniState(true)
	end
end

function var_0_1.Hide(arg_19_0)
	arg_19_0:HideAni()
	SetActive(arg_19_0.gameObject_, false)
end

function var_0_1.BindRedPointUI(arg_20_0)
	manager.redPoint:bindUIandKey(arg_20_0.teachingBtn_.transform, RedPointConst.HERO_TEACH_ID)
end

function var_0_1.OnExit(arg_21_0)
	manager.redPoint:unbindUIandKey(arg_21_0.teachingBtn_.transform, RedPointConst.HERO_TEACH_ID)
end

function var_0_1.Dispose(arg_22_0)
	for iter_22_0 = 1, 6 do
		arg_22_0.skillItem_[iter_22_0]:Dispose()
	end

	arg_22_0.skillItem_ = nil

	if arg_22_0.skillCxTimer then
		arg_22_0.skillCxTimer:Stop()

		arg_22_0.skillCxTimer = nil
	end

	var_0_1.super.Dispose(arg_22_0)
end

return var_0_1
