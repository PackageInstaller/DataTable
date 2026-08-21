local var_0_0 = class("MatrixHeroAttributePage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.nullController_ = ControllerUtil.GetController(arg_2_0.transform_, "null")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.detailView_ = WeaponServantDetailView.New(arg_3_0.m_detailGo)

	if arg_3_0.detailView_.btnlook1Btn_ then
		SetActive(arg_3_0.detailView_.btnlook1Btn_.gameObject, false)
	end
end

function var_0_0.SetMatirxHeroInfo(arg_4_0, arg_4_1)
	arg_4_0.heroId_ = arg_4_1

	local var_4_0 = arg_4_0:GetHeroData(arg_4_1)
	local var_4_1 = var_4_0:GetWeaponServantEffect()

	if var_4_1 ~= 0 then
		local var_4_2 = var_4_0:GetWeaponServantEffectLevel()
		local var_4_3 = {
			locked = 0,
			uid = 0,
			id = var_4_1,
			stage = var_4_2
		}

		arg_4_0.detailView_:SetDescBtn(true)
		arg_4_0.detailView_:SetWeaponServantData(var_4_3)
		arg_4_0.detailView_:RefreshEffectText(2)
		arg_4_0.nullController_:SetSelectedIndex(0)

		arg_4_0.m_countLab.text = "1/1"
	else
		arg_4_0.nullController_:SetSelectedIndex(1)

		arg_4_0.m_countLab.text = "0/1"
	end
end

function var_0_0.OnEnter(arg_5_0)
	if arg_5_0.detailView_ then
		arg_5_0.detailView_:OnEnter()
	end
end

function var_0_0.OnExit(arg_6_0)
	if arg_6_0.detailView_ then
		arg_6_0.detailView_:OnExit()
	end
end

function var_0_0.Hide(arg_7_0)
	SetActive(arg_7_0.gameObject_, false)
end

function var_0_0.Show(arg_8_0)
	SetActive(arg_8_0.gameObject_, true)
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()

	arg_9_0.handler_ = nil

	if arg_9_0.detailView_ then
		arg_9_0.detailView_:Dispose()

		arg_9_0.detailView_ = nil
	end

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.GetHeroData(arg_10_0, arg_10_1)
	return MatrixData:GetHeroData(arg_10_1)
end

return var_0_0
