local var_0_0 = class("PolyhedronTeamInfoSettingHead", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.emptyController = ControllerUtil.GetController(arg_3_0.transform_, "empty")
	arg_3_0.heroHead = PolyhedronHeroShortHead.New(arg_3_0.m_head)

	arg_3_0.heroHead:SetRedPointEnable(false)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_btn, nil, function()
		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.id)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.id = arg_6_2

	local var_6_0 = arg_6_1:GetHeroPolyData(arg_6_2)
	local var_6_1 = arg_6_1:GetTeamateRebornMaxColdDown()

	if var_6_0:IsDead() then
		arg_6_0.stateController:SetSelectedIndex(1)

		arg_6_0.m_coldNum.text = var_6_1 - var_6_0.reborn_cold_down
	else
		arg_6_0.stateController:SetSelectedIndex(0)
	end

	arg_6_0.heroHead:SetProxy(arg_6_3)
	arg_6_0.heroHead:SetHeroId(arg_6_2, HeroConst.HERO_DATA_TYPE.POLYHEDRON)
	arg_6_0.heroHead.lockedController_:SetSelectedState("false")
	SetActive(arg_6_0.heroHead.noticePos_.gameObject, false)
end

function var_0_0.SetFightData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.id = arg_7_2

	local var_7_0 = arg_7_1:GetHeroPolyData(arg_7_2)
	local var_7_1 = arg_7_1:GetTeamateRebornMaxColdDown()

	if arg_7_2 == nil or arg_7_2 == 0 then
		arg_7_0.emptyController:SetSelectedIndex(1)

		return
	else
		arg_7_0.emptyController:SetSelectedIndex(0)
	end

	arg_7_0.heroHead:SetProxy(arg_7_3)
	arg_7_0.heroHead:SetHeroId(arg_7_2, HeroConst.HERO_DATA_TYPE.POLYHEDRON)
	arg_7_0.heroHead.lockedController_:SetSelectedState("false")
	SetActive(arg_7_0.heroHead.noticePos_.gameObject, false)

	if var_7_0:IsDead() then
		arg_7_0.m_coldNum.text = var_7_1 - var_7_0.reborn_cold_down

		arg_7_0.stateController:SetSelectedIndex(4)
	elseif arg_7_1:GetLeaderHeroId() == arg_7_2 then
		arg_7_0.stateController:SetSelectedIndex(2)

		local var_7_2 = HeroData:GetHeroBattleUsingSkinInfo(arg_7_2).id

		arg_7_0.heroHead.headIcon_.sprite = HeroTools.GetHeadSprite(var_7_2)
	else
		arg_7_0.stateController:SetSelectedIndex(3)
	end
end

function var_0_0.RegistCallBack(arg_8_0, arg_8_1)
	arg_8_0.clickFunc = arg_8_1
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.heroHead:Dispose()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
