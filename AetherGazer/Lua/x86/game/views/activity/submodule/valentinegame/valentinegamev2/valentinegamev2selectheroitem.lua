local var_0_0 = class("ValentineGameV2SelectHeroItem", ReduxView)

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

	arg_3_0.lockController_ = ControllerUtil.GetController(arg_3_0.transform_, "mask")
	arg_3_0.getController_ = ControllerUtil.GetController(arg_3_0.transform_, "Invited")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if ActivityData:GetActivityIsOpen(arg_4_0.activityID_) then
			ValentineGameData:SetNotNewOpen(arg_4_0.activityID_)
			JumpTools.OpenPageByJump("/valentineGameV2HeroInfoView", {
				activityID = arg_4_0.activityID_
			})
		elseif manager.time:GetServerTime() < ActivityData:GetActivityData(arg_4_0.activityID_).startTime then
			local var_5_0 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(arg_4_0.activityID_).startTime)

			ShowTips(string.format(GetTips("OPEN_TIME"), var_5_0))
		else
			ShowTips(GetTips("TIME_OVER"))
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.activityID_ = arg_6_1
	arg_6_0.cfg_ = ActivityValentineCfg[arg_6_0.activityID_]
	arg_6_0.nameText_.text = arg_6_0.cfg_.name
	arg_6_0.iconImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/Role/" .. arg_6_0.cfg_.hero_id)

	arg_6_0:RefreshStatus()
	manager.redPoint:bindUIandKey(arg_6_0.redTrans_, RedPointConst.VALENTINE_GAME .. "_" .. arg_6_0.activityID_)
	arg_6_0:RegistEventListener(ACTIVITY_UPDATE, handler(arg_6_0, arg_6_0.OnActivityUpdate))
end

function var_0_0.RefreshStatus(arg_7_0)
	if ActivityData:GetActivityIsOpen(arg_7_0.activityID_) then
		arg_7_0.lockController_:SetSelectedState("false")

		if ValentineGameData:GetData(arg_7_0.activityID_) and ValentineGameData:GetData(arg_7_0.activityID_).isClear then
			arg_7_0.getController_:SetSelectedState("yes")
		else
			arg_7_0.getController_:SetSelectedState("no")
		end
	else
		arg_7_0.lockController_:SetSelectedState("true")
		arg_7_0.getController_:SetSelectedState("no")

		if manager.time:GetServerTime() < ActivityData:GetActivityData(arg_7_0.activityID_).startTime then
			local var_7_0 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(arg_7_0.activityID_).startTime)

			arg_7_0.lockText_.text = string.format(GetTips("OPEN_TIME"), var_7_0)
		else
			arg_7_0.lockText_.text = GetTips("TIME_OVER")
		end
	end
end

function var_0_0.RefreshTimeText(arg_8_0)
	if not ActivityData:GetActivityIsOpen(arg_8_0.activityID_) and manager.time:GetServerTime() < ActivityData:GetActivityData(arg_8_0.activityID_).startTime then
		local var_8_0 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(arg_8_0.activityID_).startTime)

		arg_8_0.lockText_.text = string.format(GetTips("OPEN_TIME"), var_8_0)
	end
end

function var_0_0.OnActivityUpdate(arg_9_0, arg_9_1)
	if arg_9_1 == arg_9_0.activityID_ then
		arg_9_0:RefreshStatus()
	end
end

function var_0_0.OnExit(arg_10_0)
	manager.redPoint:unbindUIandKey(arg_10_0.redTrans_, RedPointConst.VALENTINE_GAME .. "_" .. arg_10_0.activityID_)
	arg_10_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
