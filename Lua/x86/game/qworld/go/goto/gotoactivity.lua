local var_0_0 = class("GotoActivity", BaseGoto)

function var_0_0.GetBasePath(arg_1_0)
	return "game.qworld.go.gotoActivityImpl."
end

function var_0_0.Ctor(arg_2_0)
	arg_2_0.template = {
		[ActivityConst.ACTIVITY_RED_ENVELOPE] = "GotoRedEnvelopeActivity",
		[ActivityConst.ACTIVITY_BLOOD_CARD] = "GotoBloodCardActivity",
		[ActivityConst.ACTIVITY_SPRING_SHOP] = "GotoSpringShopActivity",
		[ActivityConst.AUTO_COOK] = "GotoAutoCookActivity",
		[ActivityConst.ACTIVITY_SPRING_QUIZ] = "GotoQuizActivity",
		[ActivityConst.EAT_SNAKE] = "GotoEatSnakeActivity",
		[ActivityConst.ACTIVITY_3_11_MUSIC] = "GotoMusicActivity",
		[ActivityConst.ACTIVITY_3_11_ZUMA] = "GotoZumaActivity"
	}
end

function var_0_0.Go(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, ...)
	local var_3_0 = arg_3_2[1]

	if not arg_3_0:CheckActivityOpen(var_3_0) then
		return
	end

	arg_3_0:StartGo(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, ...)
end

function var_0_0.StartGo(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, ...)
	local var_4_0 = arg_4_2[1]

	QWorldMgr:ActiveControl(false)
	QWorldMgr:StartBlackFade(QWorldConst.GOTO_BLACK_FADE_ENTER_TIME, QWorldConst.GOTO_BLACK_FADE_EXIT_TIME, QWorldConst.GOTO_BLACK_FADE_CENTER_TIME, function()
		local var_5_0 = arg_4_0:InstantiateEntity(var_4_0)

		var_5_0:TryTeleport()
		QWorldLuaBridge.CloseUI(false)
		QWorldMgr:StartSetCamera()
		var_5_0:OnEnter(arg_4_2, arg_4_3)

		if QWorldMgr:PostCheck() then
			var_5_0:EnableCamera(arg_4_4)
			arg_4_0:ProcessPlayParams(arg_4_5)
		end

		QWorldData:SetIsBackQWorld(false)
	end)
end

function var_0_0.CheckActivityOpen(arg_6_0, arg_6_1)
	local var_6_0 = true

	if arg_6_0.template[arg_6_1] then
		if not ActivityData:GetActivityIsOpen(arg_6_1) then
			Debug.LogError("活动未开启: " .. arg_6_1)

			var_6_0 = false
		end
	else
		Debug.LogError("不存在的活动: " .. arg_6_1)

		var_6_0 = false
	end

	return var_6_0
end

return var_0_0
