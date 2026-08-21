local var_0_0 = class("ChapterChallengeItemView", import("..ChapterBaseItemView"))

function var_0_0.OnEnter(arg_1_0)
	var_0_0.super.OnEnter(arg_1_0)
	arg_1_0:AddCountdown()
	arg_1_0:AddRedPoint()
end

function var_0_0.OnExit(arg_2_0)
	var_0_0.super.OnExit(arg_2_0)
	arg_2_0:RemoveCountdown()
	arg_2_0:RemoveRedPoint()
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.RefreshCustomItem(arg_4_0, arg_4_1)
	if arg_4_0.oldCfgID_ ~= arg_4_1.id then
		arg_4_0.nameText_.text = GetI18NText(arg_4_1.name)

		SetSpriteWithoutAtlasAsync(arg_4_0.icon_, arg_4_1.drop_icon)

		arg_4_0.oldCfgID_ = arg_4_1.id
	end
end

function var_0_0.AddCountdown(arg_5_0)
	return
end

function var_0_0.RemoveCountdown(arg_6_0)
	if arg_6_0.timer_ then
		arg_6_0.timer_:Stop()

		arg_6_0.timer_ = nil
	end
end

function var_0_0.GetLostTime(arg_7_0)
	return 0
end

function var_0_0.ClickItem(arg_8_0, arg_8_1)
	if arg_8_0:CheckLock() then
		return
	end

	local var_8_0 = ChapterClientCfg[arg_8_1].chapter_list[1]

	arg_8_0:Go("/challenge", {
		chapterID = var_8_0
	})
end

function var_0_0.AddRedPoint(arg_9_0)
	manager.redPoint:bindUIandKey(arg_9_0.panelTf_, ChapterTools.GetRedPoint(arg_9_0.chapterClientID_))
end

function var_0_0.RemoveRedPoint(arg_10_0)
	manager.redPoint:unbindUIandKey(arg_10_0.panelTf_)
end

return var_0_0
