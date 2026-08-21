local var_0_0 = class("GotoSystem", BaseGoto)

function var_0_0.GetBasePath(arg_1_0)
	return "game.qworld.go.gotoSystemImpl."
end

function var_0_0.Ctor(arg_2_0)
	arg_2_0.template = {
		[QWorldSystemConst.SEA_WARFARE] = "GotoSeaWarfare"
	}
end

function var_0_0.Go(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, ...)
	local var_3_0 = arg_3_2[1]

	if not arg_3_0:CheckSystemOpen(var_3_0) then
		return
	end

	arg_3_0:StartGo(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, ...)
end

function var_0_0.StartGo(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, ...)
	local var_4_0 = arg_4_2[1]
	local var_4_1 = false

	if arg_4_5 then
		var_4_1 = arg_4_5.immediate
	end

	QWorldMgr:ActiveControl(false)

	if not var_4_1 then
		QWorldMgr:StartBlackFade(QWorldConst.GOTO_BLACK_FADE_ENTER_TIME, QWorldConst.GOTO_BLACK_FADE_EXIT_TIME, QWorldConst.GOTO_BLACK_FADE_CENTER_TIME, function()
			QWorldLuaBridge.CloseUI(false)
			QWorldMgr:StartSetCamera()

			local var_5_0 = arg_4_0:InstantiateEntity(var_4_0)

			var_5_0:SetCameraParams(arg_4_4)
			var_5_0:OnEnter(arg_4_2, arg_4_3, arg_4_0:GetTagId())

			if QWorldMgr:PostCheck() then
				var_5_0:EnableCamera(arg_4_4)
				arg_4_0:ProcessPlayParams(arg_4_5)
			end

			QWorldData:SetIsBackQWorld(false)
		end)
	else
		QWorldLuaBridge.CloseUI(false)
		QWorldMgr:StartSetCamera()

		local var_4_2 = arg_4_0:InstantiateEntity(var_4_0)

		var_4_2:SetCameraParams(arg_4_4)
		var_4_2:OnEnter(arg_4_2, arg_4_3, arg_4_0:GetTagId())

		if QWorldMgr:PostCheck() then
			var_4_2:EnableCamera(arg_4_4)
			arg_4_0:ProcessPlayParams(arg_4_5)
		end

		QWorldData:SetIsBackQWorld(false)
	end
end

function var_0_0.CheckSystemOpen(arg_6_0, arg_6_1)
	return true
end

return var_0_0
