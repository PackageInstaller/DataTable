local var_0_0 = class("NewWarChessHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.transform_, "skilltype")
	arg_3_0.skillClickHandler_ = handler(arg_3_0, arg_3_0.OnSkillItemClick)
	arg_3_0.skillItem_ = NewWarChessSkillItem.New(arg_3_0.skillGo_)
	arg_3_0.buffItem_ = NewWarChessBuffItem.New(arg_3_0.buffGo_)
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.heroInfo_ = arg_4_1
	arg_4_0.cfg_ = NewWarChessHeroCfg[arg_4_0.heroInfo_[1]]
	arg_4_0.heroImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_4_0.cfg_.hero_id)
	arg_4_0.heroNameText_.text = arg_4_0.cfg_.description

	if arg_4_0.cfg_.effect_type == NewChessConst.HERO_EFFECT_TYPE.BUFF then
		arg_4_0.statusController_:SetSelectedState("buff")

		local var_4_0 = manager.NewChessManager.buffManager_:GetBuffEntity(arg_4_0.cfg_.effect_id)

		arg_4_0.buffItem_:SetData(1, 0, var_4_0)

		local var_4_1 = NewWarChessBuffPoolCfg[arg_4_0.cfg_.effect_id]

		arg_4_0.skillDesText_.text = NewChessTools.GetBuffDes(var_4_0)
	else
		arg_4_0.statusController_:SetSelectedState("skill")

		local var_4_2 = NewWarChessData:GetSkillInfo(arg_4_0.cfg_.effect_id)

		arg_4_0.skillItem_:SetData(var_4_2)

		local var_4_3 = NewWarChessDiceSkillCfg[arg_4_0.cfg_.effect_id]

		arg_4_0.skillDesText_.text = var_4_3.simple_description
	end

	local var_4_4 = math.ceil(arg_4_0.heroInfo_[2] / NewChessConst.HERO_HP_RATE * 100)

	arg_4_0.hpText_.text = var_4_4 .. "%"
	arg_4_0.hpImage_.fillAmount = arg_4_0.heroInfo_[2] / NewChessConst.HERO_HP_RATE
end

function var_0_0.EnableSkillItemClick(arg_5_0)
	arg_5_0.skillItem_:SetClickCallBack(arg_5_0.skillClickHandler_)
end

function var_0_0.BindSkillRedPoint(arg_6_0)
	arg_6_0.skillItem_:BindSkillRedPoint()
end

function var_0_0.OnSkillItemClick(arg_7_0, arg_7_1)
	JumpTools.OpenPageByJump("/newWarChessDiceSkillView", {
		skillID = arg_7_1
	})
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.skillClickHandler_ = nil

	arg_8_0.skillItem_:Dispose()
	arg_8_0.buffItem_:Dispose()
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
