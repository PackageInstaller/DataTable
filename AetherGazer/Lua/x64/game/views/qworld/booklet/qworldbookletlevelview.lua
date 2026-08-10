local var_0_0 = class("QWorldBookletLevelView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_Com/QuanZhou_ScheduleUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.idList_ = QWorldBookletTools.GetNdLevelIDList()
	arg_3_0.receiveList_ = {}
	arg_3_0.showIdList_ = {}
	arg_3_0.curLv_ = 0
	arg_3_0.maxLv_ = 0
	arg_3_0.bookNameText.text = QWorldBookletTools.GetBookletSystemName()
	arg_3_0.bookNameText_.text = QWorldBookletTools.GetBookletSystemName()
	arg_3_0.levelLuaList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.levelUilist_, QWorldBookletLevelItem)
	arg_3_0.receivePointRewardHandler_ = handler(arg_3_0, arg_3_0.OnReceivePointReward)
	arg_3_0.onekeyController_ = arg_3_0.mainControllerEx_:GetController("onekey")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.receiveBtn_, nil, function()
		ActivityPointAction.ReceivePointReward(arg_5_0.receiveList_)
	end)
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_0.showIdList_[arg_7_1].id, arg_7_0.showIdList_[arg_7_1].ind, arg_7_0.showIdList_[arg_7_1].state)
end

function var_0_0.OnEnter(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_8_0.curLv_, arg_8_0.maxLv_ = QWorldBookletTools.GetNdLevelInfo()
	arg_8_0.levelText.text = arg_8_0.curLv_ .. "<size=60>/" .. arg_8_0.maxLv_ .. "</size>"
	arg_8_0.levelText_.text = arg_8_0.curLv_ .. "<size=60>/" .. arg_8_0.maxLv_ .. "</size>"

	arg_8_0:UpdateView()
	manager.redPoint:bindUIandKey(arg_8_0.receiveBtn_.transform, RedPointConst.QWORLD_BOOKLET_LEVEL_REWARD)
	manager.notify:RegistListener(RECEIVE_POINT_REWARD, arg_8_0.receivePointRewardHandler_)
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_9_0.receiveBtn_.transform, RedPointConst.QWORLD_BOOKLET_LEVEL_REWARD)
	manager.notify:RemoveListener(RECEIVE_POINT_REWARD, arg_9_0.receivePointRewardHandler_)
end

function var_0_0.OnReceivePointReward(arg_10_0)
	arg_10_0:UpdateView()
	QWorldBookletTools.UpdateLevelRewardRedPoint()
end

function var_0_0.UpdateView(arg_11_0)
	arg_11_0.receiveList_ = {}
	arg_11_0.showIdList_ = {}

	local var_11_0 = 1
	local var_11_1 = false

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.idList_) do
		local var_11_2 = ""

		if ActivityPointData:IsCompleteID(iter_11_1) then
			var_11_2 = "complete"
		elseif iter_11_0 <= arg_11_0.curLv_ then
			var_11_2 = "receive"

			table.insert(arg_11_0.receiveList_, iter_11_1)

			if not var_11_1 then
				var_11_1 = true
				var_11_0 = iter_11_0
			end
		else
			var_11_2 = "lock"

			if not var_11_1 then
				var_11_1 = true
				var_11_0 = iter_11_0
			end
		end

		table.insert(arg_11_0.showIdList_, {
			id = iter_11_1,
			ind = iter_11_0,
			state = var_11_2
		})
	end

	arg_11_0.levelLuaList_:StartScroll(#arg_11_0.showIdList_)
	arg_11_0.levelLuaList_:ScrollToIndex(var_11_0, false, false)
	arg_11_0.onekeyController_:SetSelectedState(#arg_11_0.receiveList_ > 0 and "true" or "false")
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)

	if arg_12_0.levelLuaList_ then
		arg_12_0.levelLuaList_:Dispose()

		arg_12_0.levelLuaList_ = nil
	end
end

return var_0_0
