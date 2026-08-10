local var_0_0 = class("DrawRolePool", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.poolId = arg_1_2
	arg_1_0.showId = arg_1_3

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:InitRole()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:AdaptScreen()
	arg_3_0:BindCfgUI()
	arg_3_0:InitController()
end

function var_0_0.InitRole(arg_4_0)
	arg_4_0.roleItemDic_ = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.detailBtn_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			isDraw = true,
			hid = arg_5_0.upId_
		})
	end)

	if arg_5_0.changeUpBtn_ then
		arg_5_0:AddBtnListener(arg_5_0.changeUpBtn_, nil, function()
			DrawTools:GoToSelectUpHeroView(arg_5_0.poolId, arg_5_0.showId)
		end)
	end
end

function var_0_0.InitController(arg_8_0)
	arg_8_0.firstController_ = arg_8_0.controllerEx_:GetController("first")
	arg_8_0.chooseController_ = arg_8_0.controllerEx_:GetController("choose")
end

function var_0_0.Dispose(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.roleItemDic_) do
		Object.Destroy(iter_9_1)
	end

	arg_9_0.roleItemDic_ = {}

	Object.Destroy(arg_9_0.gameObject_)
	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.Refresh(arg_10_0, arg_10_1)
	arg_10_0.upId_ = DrawData:GetPollUpID(arg_10_0.poolId)

	arg_10_0:UpdateChooseStatus()
	arg_10_0:UpdateFirstStatus()
	arg_10_0:UpdateChangeCount()
	arg_10_0:UpdateRole()
end

function var_0_0.UpdateChooseStatus(arg_11_0)
	arg_11_0.chooseController_:SetSelectedState(arg_11_0.upId_ == 0 and "NotSelected" or "Choose")
end

function var_0_0.UpdateFirstStatus(arg_12_0)
	local var_12_0 = DrawData:GetIsFirstSSR()

	arg_12_0.firstController_:SetSelectedState(var_12_0 and "true" or "false")

	if var_12_0 then
		arg_12_0:UpdateFirstUI()
	end
end

function var_0_0.UpdateFirstUI(arg_13_0)
	local var_13_0 = DrawData:GetPoolDrawTimes(arg_13_0.poolId)
	local var_13_1 = GameSetting.draw_ssr_lucky_num_first_time.value[1]

	arg_13_0.drawTime_.text = string.format("%d/%d", var_13_0, var_13_1)
end

function var_0_0.UpdateChangeCount(arg_14_0)
	local var_14_0 = DrawPoolCfg[arg_14_0.poolId].pool_change

	SetActive(arg_14_0.changeCountText_.gameObject, var_14_0 > 0)

	if var_14_0 > 0 then
		local var_14_1 = var_14_0 - DrawData:GetPoolUpTimes(arg_14_0.poolId)

		arg_14_0.changeCountText_.text = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(var_14_1))
	end
end

function var_0_0.UpdateRole(arg_15_0)
	arg_15_0:TryCreateRoleItem()
	arg_15_0:UpdateRoleActive()
	arg_15_0:UpdateRoleInfo()
end

function var_0_0.TryCreateRoleItem(arg_16_0)
	if arg_16_0.upId_ == 0 then
		return
	end

	if not arg_16_0.roleItemDic_[arg_16_0.upId_] then
		arg_16_0.roleItemDic_[arg_16_0.upId_] = arg_16_0:CreateRoleItemGo()
	end
end

function var_0_0.UpdateRoleActive(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.roleItemDic_) do
		SetActive(iter_17_1, iter_17_0 == arg_17_0.upId_)
	end
end

function var_0_0.UpdateRoleInfo(arg_18_0)
	if arg_18_0.upId_ == 0 then
		return
	end

	arg_18_0.heroName_.text = HeroTools.GetHeroFullName(arg_18_0.upId_)
	arg_18_0.heroRareIcon_.sprite = HeroTools.GetHeroRareSprite(arg_18_0.upId_)
	arg_18_0.heroRaceIcon_.sprite = HeroTools.GetHeroRaceIcon(arg_18_0.upId_)
end

function var_0_0.CreateRoleItemGo(arg_19_0)
	local var_19_0 = Asset.Load("Widget/System/PoolRole/PoolRole_" .. arg_19_0.upId_)

	return GameObject.Instantiate(var_19_0, arg_19_0.roleContentTrans_)
end

function var_0_0.ShowCountDownText(arg_20_0, arg_20_1)
	if arg_20_0.countdownText_ then
		SetActive(arg_20_0.countdownText_.gameObject, arg_20_1)
	end

	if arg_20_0.countDownGo_ then
		SetActive(arg_20_0.countDownGo_, arg_20_1)
	end
end

function var_0_0.SetCountDownText(arg_21_0, arg_21_1)
	if arg_21_0.countdownText_ then
		arg_21_0.countdownText_.text = string.format(GetTips("TIME_DISPLAY_14"), manager.time:GetLostTimeStrWith3Unit(arg_21_1))
	end
end

function var_0_0.GetPoolId(arg_22_0)
	return arg_22_0.poolId
end

function var_0_0.GetShowId(arg_23_0)
	return arg_23_0.showId
end

function var_0_0.ShowRightPanel(arg_24_0)
	return true
end

function var_0_0.SetActive(arg_25_0, arg_25_1)
	SetActive(arg_25_0.gameObject_, arg_25_1)
end

return var_0_0
