local var_0_0 = class("SummerRaceRankItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:BindItemRuntime_()
	arg_2_0:AddUIListener()
end

function var_0_0.BindItemRuntime_(arg_3_0)
	arg_3_0.rankController_ = arg_3_0.gameObject_:GetComponent(typeof(Controller))
	arg_3_0.commonPortrait_ = arg_3_0.headGo_ ~= nil and CommonHeadPortrait.New(arg_3_0.headGo_) or nil
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.checkBtn_, nil, function()
		if arg_4_0.clickHandler_ then
			arg_4_0.clickHandler_(arg_4_0.index_, arg_4_0.rankData_)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.rankData_ = arg_6_1
	arg_6_0.index_ = arg_6_2
	arg_6_0.clickHandler_ = arg_6_3

	arg_6_0:RefreshView()
end

function var_0_0.RefreshView(arg_7_0)
	if arg_7_0.rankData_ == nil then
		return
	end

	local var_7_0 = tonumber(arg_7_0.rankData_.rank) or arg_7_0.index_ or 0

	arg_7_0.rankLabel_.text = tostring(var_7_0)
	arg_7_0.nickLabel_.text = tostring(arg_7_0.rankData_.playerName or arg_7_0.rankData_.nick or "")
	arg_7_0.scoreLabel_.text = tostring(arg_7_0.rankData_.score or 0)
	arg_7_0.layerLabel_.text = tostring(arg_7_0.rankData_.layerText or arg_7_0.rankData_.difficulty or "")

	if arg_7_0.rankController_ ~= nil then
		arg_7_0.rankController_:SetSelectedIndex(var_7_0 < 4 and var_7_0 or 0)
	end

	if arg_7_0.commonPortrait_ ~= nil then
		local var_7_1 = PlayerData:GetPlayerInfo()
		local var_7_2 = arg_7_0.rankData_.portrait or arg_7_0.rankData_.isSelf and var_7_1.portrait or nil
		local var_7_3 = arg_7_0.rankData_.frame or arg_7_0.rankData_.icon_frame or arg_7_0.rankData_.isSelf and var_7_1.icon_frame or nil

		arg_7_0.commonPortrait_:RenderHead(var_7_2 or 0)
		arg_7_0.commonPortrait_:RenderFrame(var_7_3 or 0)
	end
end

function var_0_0.Dispose(arg_8_0)
	if arg_8_0.commonPortrait_ ~= nil then
		arg_8_0.commonPortrait_:Dispose()

		arg_8_0.commonPortrait_ = nil
	end

	arg_8_0.rankData_ = nil
	arg_8_0.clickHandler_ = nil

	arg_8_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
