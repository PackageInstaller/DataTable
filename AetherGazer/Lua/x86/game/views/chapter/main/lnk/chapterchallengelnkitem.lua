local var_0_0 = class("ChapterChallengeLnkItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.image_.immediate = true

	arg_1_0:AddListeners()

	arg_1_0.lockController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")
	arg_1_0.rewardItemList_ = {}

	for iter_1_0 = 1, 2 do
		arg_1_0.rewardItemList_[iter_1_0] = CommonItemView.New(arg_1_0["item" .. iter_1_0 .. "Go_"], true)
	end
end

function var_0_0.OnEnter(arg_2_0)
	return
end

function var_0_0.OnExit(arg_3_0)
	manager.redPoint:unbindUIandKey(arg_3_0.transform_)
	arg_3_0:StopTimer()
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	for iter_4_0 = 1, 2 do
		if arg_4_0.rewardItemList_[iter_4_0] then
			arg_4_0.rewardItemList_[iter_4_0]:Dispose()

			arg_4_0.rewardItemList_[iter_4_0] = nil
		end
	end

	arg_4_0.gameObject_ = nil
	arg_4_0.transform_ = nil
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.chapterClientID_ = arg_5_1

	local var_5_0 = ChapterClientCfg[arg_5_1]

	arg_5_0.isLock_ = JumpTools.GetLinkIsLocked(var_5_0.jump_system)
	arg_5_0.asset_pend_key = var_5_0.asset_pend_key
	arg_5_0.isAssetPendLock_ = not manager.assetPend:CheckAssetPend(arg_5_0.asset_pend_key)
	arg_5_0.image_.spriteAsync = SpritePathCfg.ChapterPaint.path .. var_5_0.chapter_paint_2
	arg_5_0.nameText_.text = var_5_0.name

	arg_5_0:RefreshLockState()
	arg_5_0:RefreshRewardItem()
	arg_5_0:AddTimer()
	manager.redPoint:bindUIandKey(arg_5_0.transform_, ChapterTools.GetRedPoint(arg_5_1))
	arg_5_0:Show(true)
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.button_, nil, function()
		local var_7_0 = ChapterClientCfg[arg_6_0.chapterClientID_]

		if not arg_6_0.isLock_ then
			SystemRedPoint:CancelNewTagByChapterId(arg_6_0.chapterClientID_)
		end

		if arg_6_0.isAssetPendLock_ then
			manager.assetPend:ShowAssetPendMessageBox(arg_6_0.asset_pend_key)

			return
		end

		JumpTools.JumpToPage2(var_7_0.jump_system)
	end)
end

function var_0_0.AddTimer(arg_8_0)
	arg_8_0:StopTimer()
	arg_8_0:RefreshTimeStamp(true)

	arg_8_0.timer_ = Timer.New(function()
		arg_8_0:RefreshTimeStamp()
	end, 1, -1)

	arg_8_0.timer_:Start()
end

function var_0_0.StopTimer(arg_10_0)
	if arg_10_0.timer_ then
		arg_10_0.timer_:Stop()

		arg_10_0.timer_ = nil
	end
end

function var_0_0.RefreshTimeStamp(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.chapterClientID_
	local var_11_1 = ChapterTools.GetChallengeNextRefreshTimeStamp(var_11_0)

	if arg_11_1 then
		if var_11_1 == 0 or arg_11_0.isLock_ then
			SetActive(arg_11_0.timeGo_, false)
		else
			SetActive(arg_11_0.timeGo_, true)
		end
	end

	if var_11_1 ~= 0 then
		arg_11_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_11_1, true)
	end
end

function var_0_0.RefreshLockState(arg_12_0)
	local var_12_0 = ChapterClientCfg[arg_12_0.chapterClientID_ or 0]

	if var_12_0 then
		arg_12_0.asset_pend_key = var_12_0.asset_pend_key
		arg_12_0.isAssetPendLock_ = not manager.assetPend:CheckAssetPend(arg_12_0.asset_pend_key)
	end

	if arg_12_0.isLock_ then
		arg_12_0.lockController_:SetSelectedState("true")
	elseif arg_12_0.isAssetPendLock_ then
		arg_12_0.lockController_:SetSelectedState("assetpend")
	else
		arg_12_0.lockController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshRewardItem(arg_13_0)
	if arg_13_0.isLock_ then
		SetActive(arg_13_0.itemRootGo_, false)
	else
		SetActive(arg_13_0.itemRootGo_, true)

		local var_13_0 = ChapterTools.GetSystemRewardInfo(arg_13_0.chapterClientID_)

		for iter_13_0 = 1, 2 do
			if var_13_0[iter_13_0] then
				local var_13_1 = clone(ItemTemplateData)

				var_13_1.id = var_13_0[iter_13_0]
				var_13_1.number = nil

				arg_13_0.rewardItemList_[iter_13_0]:SetData(var_13_1)
			else
				arg_13_0.rewardItemList_[iter_13_0]:SetData(nil)
			end
		end
	end
end

function var_0_0.Show(arg_14_0, arg_14_1)
	SetActive(arg_14_0.gameObject_, arg_14_1)
end

return var_0_0
