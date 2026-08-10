local var_0_0 = class("BulletinSwitchView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Bulletin/BulletinUI_new"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
	arg_3_0:AddEventListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.contentView_ = BulletinContentView.New(arg_4_0.mainContent_)
	arg_4_0.titleItems_ = {
		arg_4_0.titleItem1_:GetComponent(typeof(Toggle)),
		arg_4_0.titleItem2_:GetComponent(typeof(Toggle)),
		arg_4_0.titleItem3_:GetComponent(typeof(Toggle))
	}
	arg_4_0.toggles_ = {
		arg_4_0.toggle1_,
		arg_4_0.toggle2_,
		arg_4_0.toggle3_
	}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.closeBtn_, nil, function()
		arg_5_0:Back()
	end)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.toggles_) do
		arg_5_0:AddToggleListener(iter_5_1, function(arg_8_0)
			if arg_8_0 then
				OperationRecorder.Record("bulletin", "changeType")

				local var_8_0

				if iter_5_0 == 1 then
					var_8_0 = BulletinData.GetBulletinIDList()[101]

					SDKTools.SendMessageToSDK("announcement_touch", {
						touch_times_activity = 1,
						touch_times_game = 0
					})
				elseif iter_5_0 == 2 then
					var_8_0 = BulletinData.GetBulletinIDList()[102]

					SDKTools.SendMessageToSDK("announcement_touch", {
						touch_times_game = 1,
						touch_times_activity = 0
					})
				else
					var_8_0 = BulletinData.GetBulletinIDList()[104]
				end

				if not arg_5_0.ignoreToggleListener then
					for iter_8_0, iter_8_1 in pairs(var_8_0) do
						arg_5_0:SelectItem(BulletinData.GetBulletinPageList()[iter_8_1])

						break
					end
				end

				arg_5_0:UpdateLayout()
			end
		end)
	end
end

function var_0_0.AddEventListener(arg_9_0)
	arg_9_0:RegistEventListener(BULLETIN_LIST_UPDATE, handler(arg_9_0, arg_9_0.OnBulletinListUpdate))
	arg_9_0:RegistEventListener(RED_POINT_UPDATE, handler(arg_9_0, arg_9_0.RedPointUpdate))
end

function var_0_0.OnBulletinListUpdate(arg_10_0)
	arg_10_0:UpdateBtnItems()
end

function var_0_0.OnBulletinDelete(arg_11_0, arg_11_1)
	arg_11_0:UpdateBtnItems()

	if arg_11_0.currentItem_ ~= nil and arg_11_0.currentItem_.data_ ~= nil and arg_11_0.currentItem_.data_.id == arg_11_1.id then
		local var_11_0 = arg_11_0:FindFirstBulletin(arg_11_1)

		if var_11_0 then
			arg_11_0:SelectItem(var_11_0)
		else
			arg_11_0:Back()
		end
	end
end

function var_0_0.OnSubscribe(arg_12_0)
	return
end

function var_0_0.RedPointUpdate(arg_13_0, arg_13_1)
	if arg_13_1 == RedPointConst.BULLETIN_UNREAD_101 then
		local var_13_0 = manager.redPoint:getTipValue(RedPointConst.BULLETIN_UNREAD_101)

		SetActive(arg_13_0.notice1_, var_13_0 > 0)
	elseif arg_13_1 == RedPointConst.BULLETIN_UNREAD_102 then
		local var_13_1 = manager.redPoint:getTipValue(RedPointConst.BULLETIN_UNREAD_102)

		SetActive(arg_13_0.notice2_, var_13_1 > 0)
	elseif arg_13_1 == RedPointConst.BULLETIN_UNREAD_104 then
		local var_13_2 = manager.redPoint:getTipValue(RedPointConst.BULLETIN_UNREAD_104)

		SetActive(arg_13_0.notice3_, var_13_2 > 0)
	end
end

function var_0_0.UpdateTimer(arg_14_0)
	arg_14_0:RemoveAllUpdateTimer()

	arg_14_0.updateTimers_ = {}

	for iter_14_0, iter_14_1 in pairs(BulletinData.GetBulletinPageList()) do
		local var_14_0 = iter_14_1.id
		local var_14_1 = Timer.New(function()
			arg_14_0.updateTimers_[var_14_0]:Stop()

			arg_14_0.updateTimers_[var_14_0] = nil

			BulletinAction.BulletinDelete(var_14_0)
			arg_14_0:UpdateBtnItems()

			if arg_14_0:GetViewProp("bulletinID") == var_14_0 then
				local var_15_0 = arg_14_0:FindFirstBulletin(iter_14_1)

				if var_15_0 then
					arg_14_0:SelectItem(var_15_0)
				else
					arg_14_0:Back()
				end
			end
		end, iter_14_1.endTime - manager.time:GetServerTime(), 1)

		var_14_1:Start()

		arg_14_0.updateTimers_[var_14_0] = var_14_1
	end
end

function var_0_0.RemoveAllUpdateTimer(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.updateTimers_ or {}) do
		iter_16_1:Stop()
	end

	arg_16_0.updateTimers_ = nil
end

function var_0_0.FindFirstBulletin(arg_17_0, arg_17_1)
	local var_17_0 = BulletinData.GetBulletinIDList()
	local var_17_1 = var_17_0[arg_17_1.type]

	if #var_17_1 > 0 then
		for iter_17_0, iter_17_1 in pairs(var_17_1) do
			return BulletinData.GetBulletinPageList()[iter_17_1]
		end
	end

	for iter_17_2, iter_17_3 in pairs(var_17_0) do
		if #iter_17_3 > 0 then
			for iter_17_4, iter_17_5 in pairs(iter_17_3) do
				return BulletinData.GetBulletinPageList()[iter_17_5]
			end
		end
	end

	return nil
end

function var_0_0.OnEnter(arg_18_0)
	arg_18_0.ignoreToggleListener = true
	arg_18_0.treeScrollRect_.verticalNormalizedPosition = 1

	arg_18_0:UpdateBtnItems()
	arg_18_0:SetViewProp("bulletinID", arg_18_0.params_.bulletinID)
	arg_18_0.contentView_:SetBulletInId(arg_18_0:GetViewProp("bulletinID"))

	for iter_18_0, iter_18_1 in pairs(BulletinData.GetBulletinPageList()) do
		if iter_18_1.id == arg_18_0.params_.bulletinID then
			arg_18_0:SelectItem(iter_18_1)

			break
		end
	end

	SetActive(arg_18_0.notice1_, manager.redPoint:getTipValue(RedPointConst.BULLETIN_UNREAD_101) > 0)
	SetActive(arg_18_0.notice2_, manager.redPoint:getTipValue(RedPointConst.BULLETIN_UNREAD_102) > 0)
	SetActive(arg_18_0.notice3_, manager.redPoint:getTipValue(RedPointConst.BULLETIN_UNREAD_104) > 0)
	BulletinData.SaveDailyLoginPopBulletin()

	arg_18_0.ignoreToggleListener = false
end

function var_0_0.ClearBtnItems(arg_19_0)
	if arg_19_0.activityBtnItems_ then
		for iter_19_0, iter_19_1 in ipairs(arg_19_0.activityBtnItems_) do
			iter_19_1:Dispose()
		end

		arg_19_0.activityBtnItems_ = nil
	end

	if arg_19_0.gameBtnItems_ then
		for iter_19_2, iter_19_3 in ipairs(arg_19_0.gameBtnItems_) do
			iter_19_3:Dispose()
		end

		arg_19_0.gameBtnItems_ = nil
	end

	if arg_19_0.infoBtnItems_ then
		for iter_19_4, iter_19_5 in pairs(arg_19_0.infoBtnItems_) do
			iter_19_5:Dispose()
		end

		arg_19_0.infoBtnItems_ = nil
	end
end

function var_0_0.UpdateBtnItems(arg_20_0)
	if not arg_20_0.activityBtnItems_ then
		arg_20_0.activityBtnItems_ = {}
	end

	if not arg_20_0.gameBtnItems_ then
		arg_20_0.gameBtnItems_ = {}
	end

	if not arg_20_0.infoBtnItems_ then
		arg_20_0.infoBtnItems_ = {}
	end

	local var_20_0 = BulletinData.GetBulletinIDList()[101] or {}
	local var_20_1 = BulletinData.GetBulletinIDList()[102] or {}
	local var_20_2 = BulletinData.GetBulletinIDList()[104] or {}

	arg_20_0:UpdateBtnItemByList(arg_20_0.activityBtnItems_, var_20_0, arg_20_0.activityContainer_)
	arg_20_0:UpdateBtnItemByList(arg_20_0.gameBtnItems_, var_20_1, arg_20_0.gameContainer_)
	arg_20_0:UpdateBtnItemByList(arg_20_0.infoBtnItems_, var_20_2, arg_20_0.infoContainer_)

	if #var_20_0 ~= 0 then
		SetActive(arg_20_0.titleItem1_, true)
	else
		SetActive(arg_20_0.titleItem1_, false)
	end

	if #var_20_1 ~= 0 then
		SetActive(arg_20_0.titleItem2_, true)
	else
		SetActive(arg_20_0.titleItem2_, false)
	end

	if #var_20_2 ~= 0 then
		SetActive(arg_20_0.titleItem3_, true)
	else
		SetActive(arg_20_0.titleItem3_, false)
	end

	arg_20_0:UpdateLayout()
end

function var_0_0.UpdateLayout(arg_21_0)
	local var_21_0 = BulletinData.GetBulletinIDList()[101] or {}
	local var_21_1 = BulletinData.GetBulletinIDList()[102] or {}
	local var_21_2 = BulletinData.GetBulletinIDList()[104] or {}

	if #var_21_0 ~= 0 then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_0.activityContainer_)
	end

	if #var_21_1 ~= 0 then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_0.gameContainer_)
	end

	if #var_21_2 ~= 0 then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_0.infoContainer_)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_0.treeContainer_)
end

function var_0_0.UpdateBtnItemByList(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in pairs(arg_22_2) do
		var_22_0 = var_22_0 + 1

		local var_22_1 = BulletinData.GetBulletinPageList()[iter_22_1]

		if var_22_0 <= #arg_22_1 then
			arg_22_1[var_22_0]:SetData(var_22_1)
		else
			local var_22_2 = Object.Instantiate(arg_22_0.btnItemPrefab_, arg_22_3)

			SetActive(var_22_2, true)

			local var_22_3 = BulletinBtnItem.New(handler(arg_22_0, arg_22_0.OnClickBtnItem), var_22_2)

			var_22_3:SetData(var_22_1)
			table.insert(arg_22_1, var_22_3)
		end

		local var_22_4 = arg_22_1[var_22_0]

		if var_22_4 then
			if arg_22_0.currentId_ and arg_22_0.currentId_ == iter_22_1 then
				arg_22_0.currentItem_ = var_22_4

				var_22_4:SetSelected(true)
			else
				var_22_4:SetSelected(false)
			end
		end
	end

	local var_22_5 = 0

	for iter_22_2, iter_22_3 in pairs(arg_22_2) do
		var_22_5 = var_22_5 + 1
	end

	while var_22_5 < #arg_22_1 do
		arg_22_1[#arg_22_1]:Dispose()
		table.remove(arg_22_1, #arg_22_1)
	end
end

function var_0_0.OnClickBtnItem(arg_23_0, arg_23_1)
	arg_23_0:SelectItem(arg_23_1)
end

function var_0_0.SelectItem(arg_24_0, arg_24_1)
	if arg_24_0.currentItem_ then
		arg_24_0.currentItem_:SetSelected(false)
	end

	arg_24_0.contentView_:SwitchBulletinPage(arg_24_1.id)

	if getData("bulletin", "bulletin_" .. arg_24_1.id) ~= "true" then
		BulletinAction.BulletinRead(arg_24_1.id)
	end

	local var_24_0
	local var_24_1 = false
	local var_24_2 = false
	local var_24_3 = false

	if arg_24_1.type == 101 then
		var_24_0 = arg_24_0.activityBtnItems_
		var_24_1 = true
	elseif arg_24_1.type == 102 then
		var_24_0 = arg_24_0.gameBtnItems_
		var_24_2 = true
	elseif arg_24_1.type == 104 then
		var_24_0 = arg_24_0.infoBtnItems_
		var_24_3 = true
	end

	arg_24_0.titleItems_[1].isOn = var_24_1
	arg_24_0.titleItems_[2].isOn = var_24_2
	arg_24_0.titleItems_[3].isOn = var_24_3

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if iter_24_1.data_.id == arg_24_1.id then
			arg_24_0.currentItem_ = iter_24_1

			iter_24_1:SetSelected(true)

			arg_24_0.currentId_ = iter_24_1.data_.id

			break
		end
	end
end

function var_0_0.GetFirstBulletin(arg_25_0)
	local var_25_0 = manager.time:GetServerTime()
	local var_25_1 = {
		101,
		102,
		104
	}

	for iter_25_0, iter_25_1 in ipairs(var_25_1) do
		local var_25_2 = BulletinData.GetBulletinIDList()[iter_25_1]

		if var_25_2 then
			for iter_25_2, iter_25_3 in pairs(var_25_2) do
				local var_25_3 = BulletinData.GetBulletinPageList()[iter_25_3]

				if var_25_0 < var_25_3.endTime then
					return var_25_3
				end
			end
		end
	end

	return false
end

function var_0_0.OnExit(arg_26_0)
	manager.windowBar:HideBar()

	for iter_26_0, iter_26_1 in pairs(arg_26_0.activityBtnItems_) do
		iter_26_1:OnExit()
	end

	for iter_26_2, iter_26_3 in pairs(arg_26_0.gameBtnItems_) do
		iter_26_3:OnExit()
	end

	for iter_26_4, iter_26_5 in pairs(arg_26_0.infoBtnItems_) do
		iter_26_5:OnExit()
	end

	arg_26_0:RemoveAllUpdateTimer()
end

function var_0_0.OnExitInput(arg_27_0)
	JumpTools.Back()

	return true
end

function var_0_0.Dispose(arg_28_0)
	arg_28_0:RemoveAllListeners()
	arg_28_0:RemoveAllEventListener()

	if arg_28_0.contentView_ then
		arg_28_0.contentView_:Dispose()

		arg_28_0.contentView_ = nil
	end

	arg_28_0:ClearBtnItems()
	var_0_0.super.Dispose(arg_28_0)
end

return var_0_0
