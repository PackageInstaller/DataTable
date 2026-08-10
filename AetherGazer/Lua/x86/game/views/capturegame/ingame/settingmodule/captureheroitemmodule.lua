local var_0_0 = class("CaptureHeroItemModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.staticCtx = {
		controller = arg_3_0.controller_:GetController("default0")
	}
	arg_3_0.context = {
		skinId = -1
	}
	arg_3_0.labelTxt_.text = GetTips("CAPTURE_GAME_IN_HOLDER")

	arg_3_0:AddListener()
end

function var_0_0.AddListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.clickBtn_, nil, function()
		arg_4_0:OnHeroClick()
	end)
end

function var_0_0.OnHeroClick(arg_6_0)
	local var_6_0 = arg_6_0:GetCurHolderIdx()

	if CaptureGameMgr:GetPlaceHolderMgr():HolderSelectedSkin(arg_6_0:GetCurHolderIdx()) == arg_6_0.context.skinId then
		return
	end

	CaptureGameMgr:GetPlaceHolderMgr():SwitchSkin(var_6_0, arg_6_0.context.skinId)
	arg_6_0:Render()
end

function var_0_0.GetCurHolderIdx(arg_7_0)
	return CaptureGameMgr:GetPlaceHolderMgr():GetCurrentSelect()
end

function var_0_0.RenderView(arg_8_0, arg_8_1)
	arg_8_0.context.skinId = arg_8_1

	arg_8_0:Render()
end

function var_0_0.Render(arg_9_0)
	local var_9_0 = CaptureGameMgr:GetPlaceHolderMgr():HolderSelectedSkin(arg_9_0:GetCurHolderIdx())
	local var_9_1 = SkinCfg[arg_9_0.context.skinId]

	arg_9_0.heroIcon_.sprite = HeroTools.GetHeadSprite(var_9_1.picture_id)

	if var_9_0 == arg_9_0.context.skinId then
		arg_9_0.staticCtx.controller:SetSelectedState("nowselect")
	else
		arg_9_0.staticCtx.controller:SetSelectedState("normal")
	end

	if CaptureGameMgr:GetPlaceHolderMgr():GetSkinHolderId(arg_9_0.context.skinId) ~= -1 then
		SetActive(arg_9_0.decorator_, true)
	else
		SetActive(arg_9_0.decorator_, false)
	end
end

function var_0_0.OnEnter(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.staticCtx.controller = nil

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
