local var_0_0 = class("GuildImpeachTipsView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Club/ClubImpeachTips"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:AddImpeachTimer()
	GuildData:SetImpeachFlag()
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0:StopImpeahTimer()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.buttonClose_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.buttonCancel_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.buttonOk_, nil, function()
		GuildAction.GuildCancelImpeach(function(arg_11_0)
			if isSuccess(arg_11_0.result) then
				arg_7_0:Back()
			else
				ShowTips(arg_11_0.result)
			end
		end)
	end)
end

function var_0_0.AddImpeachTimer(arg_12_0)
	local var_12_0 = GuildData:GetGuildInfo()
	local var_12_1 = GetTips("CLUB_IMPEACH_CD")

	arg_12_0.textCountdown_.text = string.format("%s%s", var_12_1, manager.time:DescCDTime(var_12_0.impeachTime - manager.time:GetServerTime(), "%H:%M:%S"))
	arg_12_0.impeachTimer_ = Timer.New(function()
		local var_13_0 = var_12_0.impeachTime - manager.time:GetServerTime()

		arg_12_0.textCountdown_.text = string.format("%s%s", var_12_1, manager.time:DescCDTime(var_13_0, "%H:%M:%S"))

		if var_13_0 <= 0 then
			arg_12_0:StopImpeahTimer()
			manager.redPoint:setTip(RedPointConst.GUILD_IMPEACH, 0)
			GuildAction.RequiredGuildMemberList(function()
				return
			end)
			arg_12_0:Back()
		end
	end, 1, -1)

	arg_12_0.impeachTimer_:Start()
end

function var_0_0.StopImpeahTimer(arg_15_0)
	if arg_15_0.impeachTimer_ then
		arg_15_0.impeachTimer_:Stop()

		arg_15_0.impeachTimer_ = nil
	end
end

return var_0_0
