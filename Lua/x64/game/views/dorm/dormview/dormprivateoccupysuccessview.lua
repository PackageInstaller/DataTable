local var_0_0 = class("DormPrivateOccupySuccessView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormUnlockTips"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.archiveID = arg_6_0.params_.archiveID

	local var_6_0 = DormData:GetHeroInfo(arg_6_0.archiveID):GetHeroId()

	if var_6_0 then
		arg_6_0.iconImg_.sprite = DormHeroTools.GetBackHomeHeadSprite(var_6_0)
	end

	if arg_6_0.archiveID and HeroRecordCfg[arg_6_0.archiveID] then
		local var_6_1 = GetI18NText(HeroRecordCfg[arg_6_0.archiveID].name)

		if var_6_1 then
			arg_6_0.nameTex_.text = string.format(GetTips("DORM_HERO_ROOM_NAME"), var_6_1)
		end
	else
		Debug.LogError("名字不存在")
	end
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.bgBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
