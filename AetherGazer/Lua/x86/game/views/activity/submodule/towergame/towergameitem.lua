local var_0_0 = class("TowerGameItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.numcontroller_ = ControllerUtil.GetController(arg_3_0.transform_, "num")
	arg_3_0.statucontroller_ = ControllerUtil.GetController(arg_3_0.transform_, "statu")
	arg_3_0.isshowpointcontroller_ = ControllerUtil.GetController(arg_3_0.transform_, "showpoint")
	arg_3_0.selectcontroller_ = ControllerUtil.GetController(arg_3_0.transform_, "select")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if ActivityData:GetActivityIsOpen(arg_4_0.levelid_) then
			if arg_4_0.selectCallBack_ ~= nil then
				arg_4_0.selectCallBack_(arg_4_0.levelid_, arg_4_0.index_)
			end

			TowerGameData:SetLevel(arg_4_0.levelid_)
			arg_4_0:Go("towerGameSectionInfoView", {
				levelid = arg_4_0.levelid_
			})
		elseif ActivityData:GetActivityData(arg_4_0.levelid_).stopTime < manager.time:GetServerTime() then
			ShowTips(GetTips("TIME_OVER"))
		else
			local var_5_0 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(arg_4_0.levelid_).startTime)

			ShowTips(string.format(GetTips("OPEN_TIME"), var_5_0))
		end
	end)
end

function var_0_0.SetSelectCallBack(arg_6_0, arg_6_1)
	arg_6_0.selectCallBack_ = arg_6_1
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.index_ = arg_7_1
	arg_7_0.levelid_ = TowerGameCfg.all[arg_7_1]

	local var_7_0 = TowerGameCfg[arg_7_0.levelid_]

	arg_7_0.nametext_.text = GetI18NText(BattleTowerGameCfg[var_7_0.stage_id].name)

	arg_7_0.numcontroller_:SetSelectedState(string.format(arg_7_1))
	arg_7_0.statucontroller_:SetSelectedState(TowerGameData:GetLevelStatuByLevelId(arg_7_0.levelid_))

	local var_7_1, var_7_2 = TowerGameData:GetLevelIsShowPointByLevelID(arg_7_0.levelid_)

	arg_7_0.isshowpointcontroller_:SetSelectedState(var_7_1)

	arg_7_0.pointtext_.text = var_7_2

	arg_7_0:UpdateTime()
	manager.redPoint:bindUIandKey(arg_7_0.transform_, string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_NOT_FIGHT, arg_7_0.levelid_))
end

function var_0_0.RefreshSelect(arg_8_0, arg_8_1)
	if arg_8_0.levelid_ == arg_8_1 then
		arg_8_0.selectcontroller_:SetSelectedState("true")
	else
		arg_8_0.selectcontroller_:SetSelectedState("false")
	end
end

function var_0_0.UpdateTime(arg_9_0)
	if ActivityData:GetActivityData(arg_9_0.levelid_).stopTime < manager.time:GetServerTime() then
		arg_9_0.timetext_.text = GetTips("TIME_OVER")
	else
		local var_9_0 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(arg_9_0.levelid_).startTime)

		arg_9_0.timetext_.text = string.format(GetTips("OPEN_TIME"), var_9_0)
	end
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
	manager.redPoint:unbindUIandKey(arg_10_0.transform_, string.format("%s_%s", RedPointConst.MARDUK_TOWERGAME_NOT_FIGHT, arg_10_0.levelid_))

	arg_10_0.selectCallBack_ = nil
end

return var_0_0
