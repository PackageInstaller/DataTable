local var_0_0 = partialClass("ResidentMusicSettingView", ReduxView)

function var_0_0.InitKeySetUI(arg_1_0)
	ComponentBinder.GetInstance():BindCfgUI(arg_1_0, arg_1_0.keyContent_)
	arg_1_0:InitKeySetListener()

	if GameToSDK.IsEditorOrPcPlatform() then
		SetActive(arg_1_0.keySetBtn_, true)
	else
		SetActive(arg_1_0.keySetBtn_, false)
	end

	arg_1_0.useTrackCountKeySet = MusicConst.MusicTrackEnum.Four

	arg_1_0:InitKeySetList()
	arg_1_0:RefreshKeyShow()
end

function var_0_0.InitKeySetListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.resetBtn_, nil, function()
		local var_3_0 = MusicData:GetDefaultKeyData(arg_2_0.useTrackCountKeySet)

		MusicData:SaveTrackKeySetData(arg_2_0.useTrackCountKeySet, var_3_0)
		arg_2_0:UpdateTrackListUI()
	end)
	arg_2_0:AddBtnListener(arg_2_0.returnBtn_, nil, function()
		arg_2_0.showStateController:SetSelectedState("normal")
	end)
	arg_2_0:AddBtnListener(arg_2_0.fourBtn_, nil, function()
		arg_2_0:SetUseTrackCount(MusicConst.MusicTrackEnum.Four)
	end)
	arg_2_0:AddBtnListener(arg_2_0.fiveBtn_, nil, function()
		arg_2_0:SetUseTrackCount(MusicConst.MusicTrackEnum.Five)
	end)
	arg_2_0:AddBtnListener(arg_2_0.sixBtn_, nil, function()
		arg_2_0:SetUseTrackCount(MusicConst.MusicTrackEnum.Six)
	end)
end

function var_0_0.SetUseTrackCount(arg_8_0, arg_8_1)
	if arg_8_0.useTrackCountKeySet == arg_8_1 then
		return
	end

	arg_8_0.useTrackCountKeySet = arg_8_1

	if arg_8_1 == MusicConst.MusicTrackEnum.Four then
		arg_8_0.keyPosController:SetSelectedState("four")
	elseif arg_8_1 == MusicConst.MusicTrackEnum.Five then
		arg_8_0.keyPosController:SetSelectedState("five")
	elseif arg_8_1 == MusicConst.MusicTrackEnum.Six then
		arg_8_0.keyPosController:SetSelectedState("six")
	end

	arg_8_0:RefreshKeyShow()
end

function var_0_0.InitKeySetList(arg_9_0)
	arg_9_0.keySetList_ = {}

	for iter_9_0 = 1, 6 do
		local var_9_0 = MusicKeySetItem.New(Object.Instantiate(arg_9_0.keyItem_, arg_9_0.keyContent), iter_9_0)

		arg_9_0.keySetList_[iter_9_0] = var_9_0

		var_9_0:Show(false)
		var_9_0:SetKeyChanged(function(arg_10_0)
			arg_9_0:OnKeyChanged(iter_9_0, arg_10_0.keyName, arg_10_0.oldKeyName)
		end)
	end
end

function var_0_0.OnKeyChanged(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = true
	local var_11_1 = -1

	for iter_11_0, iter_11_1 in pairs(arg_11_0.trackKeyData) do
		if iter_11_0 ~= arg_11_1 and iter_11_1 == arg_11_2 then
			var_11_0 = false

			local var_11_2 = iter_11_0

			break
		end
	end

	if var_11_0 then
		arg_11_0.trackKeyData[arg_11_1] = arg_11_2

		MusicData:SaveTrackKeySetData(arg_11_0.useTrackCountKeySet, arg_11_0.trackKeyData)
		arg_11_0:UpdateTrackListUI()
	end

	JumpTools.Back()
end

function var_0_0.RefreshKeyShow(arg_12_0)
	arg_12_0:ChangeTrackListShowState()
	arg_12_0:UpdateTrackListUI()
end

function var_0_0.ChangeTrackListShowState(arg_13_0)
	for iter_13_0 = 1, arg_13_0.useTrackCountKeySet do
		local var_13_0 = arg_13_0.keySetList_[iter_13_0]

		if var_13_0 then
			var_13_0:Show(true)
		end
	end

	for iter_13_1 = arg_13_0.useTrackCountKeySet + 1, 6 do
		local var_13_1 = arg_13_0.keySetList_[iter_13_1]

		if var_13_1 then
			var_13_1:Show(false)
		end
	end
end

function var_0_0.UpdateTrackListUI(arg_14_0)
	local var_14_0 = MusicData:GetTrackKeySetData(arg_14_0.useTrackCountKeySet)

	arg_14_0.trackKeyData = var_14_0

	for iter_14_0 = 1, arg_14_0.useTrackCountKeySet do
		local var_14_1 = arg_14_0.keySetList_[iter_14_0]

		if var_14_1 then
			var_14_1:SetData(var_14_0[iter_14_0])
		end
	end
end

function var_0_0.DisposeSet(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.keySetList_) do
		iter_15_1:Dispose()

		iter_15_1 = nil
	end
end
