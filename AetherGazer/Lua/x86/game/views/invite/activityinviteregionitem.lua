local var_0_0 = class("ActivityInviteRegionItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.SetDelegate(arg_2_0, arg_2_1)
	arg_2_0.delegate_ = arg_2_1
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.controller = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.regionBtn_, nil, function()
		local var_5_0 = InviteData:GetDataByPara("inviteTimes")
		local var_5_1 = InviteData:GetDataByPara("activityId")

		if not arg_4_0.completePlotTable[arg_4_0.plotId] then
			if var_5_0 == 0 then
				ShowTips("ACTIVITY_INVITE_TIME_NOT_ENOUGH")
			else
				InviteAction.CompletePlot(var_5_1, arg_4_0.plotId)
			end
		else
			JumpTools.GoToSystem("ActivityInvitePlotView", {
				id = arg_4_0.plotId
			})
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.plotId = arg_6_1
	arg_6_0.index = arg_6_2

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	local var_7_0 = ActivityInviteCfg[arg_7_0.plotId]

	arg_7_0.heroId = var_7_0.hero_id
	arg_7_0.completeHeroTable = InviteData:GetDataByPara("completeHeroTable")
	arg_7_0.completePlotTable = InviteData:GetDataByPara("completePlotTable")
	arg_7_0.inviteTimes = InviteData:GetDataByPara("inviteTimes")
	arg_7_0.regionNameTxt_.text = GetTips("ACTIVITY_INVITE_REGION" .. var_7_0.region)
	arg_7_0.regionImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/" .. var_7_0.image_route)

	SetActive(arg_7_0.gameObject_, arg_7_0.index <= 3 or #arg_7_0.completeHeroTable[arg_7_0.heroId] >= 4)
	arg_7_0.controller:SetSelectedState(arg_7_0.completePlotTable[arg_7_0.plotId] and "2" or "1")
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
