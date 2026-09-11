local GotoSystem = class("GotoSystem", BaseGoto)

function GotoSystem:GetBasePath()
	return "game.qworld.go.gotoSystemImpl."
end

function GotoSystem:Ctor()
	self.template = {
		[QWorldSystemConst.SEA_WARFARE] = "GotoSeaWarfare"
	}
end

function GotoSystem:Go(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, ...)
	if not self:CheckSystemOpen(arg_3_2[1]) then
		return
	end

	self:StartGo(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, ...)
end

function GotoSystem:StartGo(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, ...)
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

			local var_5_0 = self:InstantiateEntity(var_4_0)

			var_5_0:SetCameraParams(arg_4_4)
			var_5_0:OnEnter(arg_4_2, arg_4_3, self:GetTagId())

			if QWorldMgr:PostCheck() then
				var_5_0:EnableCamera(arg_4_4)
				self:ProcessPlayParams(arg_4_5)
			end

			QWorldData:SetIsBackQWorld(false)
		end)
	else
		QWorldLuaBridge.CloseUI(false)
		QWorldMgr:StartSetCamera()

		local var_4_2 = self:InstantiateEntity(arg_4_2[1])

		var_4_2:SetCameraParams(arg_4_4)
		var_4_2:OnEnter(arg_4_2, arg_4_3, self:GetTagId())

		if QWorldMgr:PostCheck() then
			var_4_2:EnableCamera(arg_4_4)
			self:ProcessPlayParams(arg_4_5)
		end

		QWorldData:SetIsBackQWorld(false)
	end
end

function GotoSystem:CheckSystemOpen(arg_6_1)
	return true
end

return GotoSystem
