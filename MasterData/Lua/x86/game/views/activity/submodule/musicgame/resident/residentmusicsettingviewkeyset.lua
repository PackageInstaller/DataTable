local var_0_0 = partialClass("ResidentMusicSettingView", ReduxView)

function var_0_0:InitKeySetUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.keyContent_)
	self:InitKeySetListener()

	if GameToSDK.IsEditorOrPcPlatform() then
		SetActive(self.keySetBtn_, true)
	else
		SetActive(self.keySetBtn_, false)
	end

	self.useTrackCountKeySet = MusicConst.MusicTrackEnum.Four

	self:InitKeySetList()
	self:RefreshKeyShow()
end

function var_0_0:InitKeySetListener()
	self:AddBtnListener(self.resetBtn_, nil, function()
		MusicData:SaveTrackKeySetData(self.useTrackCountKeySet, (MusicData:GetDefaultKeyData(self.useTrackCountKeySet)))
		self:UpdateTrackListUI()
	end)
	self:AddBtnListener(self.returnBtn_, nil, function()
		self.showStateController:SetSelectedState("normal")
	end)
	self:AddBtnListener(self.fourBtn_, nil, function()
		self:SetUseTrackCount(MusicConst.MusicTrackEnum.Four)
	end)
	self:AddBtnListener(self.fiveBtn_, nil, function()
		self:SetUseTrackCount(MusicConst.MusicTrackEnum.Five)
	end)
	self:AddBtnListener(self.sixBtn_, nil, function()
		self:SetUseTrackCount(MusicConst.MusicTrackEnum.Six)
	end)
end

function var_0_0:SetUseTrackCount(arg_8_1)
	if self.useTrackCountKeySet == arg_8_1 then
		return
	end

	self.useTrackCountKeySet = arg_8_1

	if arg_8_1 == MusicConst.MusicTrackEnum.Four then
		self.keyPosController:SetSelectedState("four")
	elseif arg_8_1 == MusicConst.MusicTrackEnum.Five then
		self.keyPosController:SetSelectedState("five")
	elseif arg_8_1 == MusicConst.MusicTrackEnum.Six then
		self.keyPosController:SetSelectedState("six")
	end

	self:RefreshKeyShow()
end

function var_0_0:InitKeySetList()
	self.keySetList_ = {}

	for iter_9_0 = 1, 6 do
		local var_9_0 = MusicKeySetItem.New(Object.Instantiate(self.keyItem_, self.keyContent), iter_9_0)

		self.keySetList_[iter_9_0] = var_9_0

		var_9_0:Show(false)
		var_9_0:SetKeyChanged(function(arg_10_0)
			self:OnKeyChanged(iter_9_0, arg_10_0.keyName, arg_10_0.oldKeyName)
		end)
	end
end

function var_0_0:OnKeyChanged(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = true

	for iter_11_0, iter_11_1 in pairs(self.trackKeyData) do
		if iter_11_0 ~= arg_11_1 and iter_11_1 == arg_11_2 then
			var_11_0 = false

			break
		end
	end

	if var_11_0 then
		self.trackKeyData[arg_11_1] = arg_11_2

		MusicData:SaveTrackKeySetData(self.useTrackCountKeySet, self.trackKeyData)
		self:UpdateTrackListUI()
	end

	JumpTools.Back()
end

function var_0_0:RefreshKeyShow()
	self:ChangeTrackListShowState()
	self:UpdateTrackListUI()
end

function var_0_0:ChangeTrackListShowState()
	for iter_13_0 = 1, self.useTrackCountKeySet do
		if self.keySetList_[iter_13_0] then
			self.keySetList_[iter_13_0]:Show(true)
		end
	end

	for iter_13_1 = self.useTrackCountKeySet + 1, 6 do
		if self.keySetList_[iter_13_1] then
			self.keySetList_[iter_13_1]:Show(false)
		end
	end
end

function var_0_0:UpdateTrackListUI()
	local var_14_0 = MusicData:GetTrackKeySetData(self.useTrackCountKeySet)

	self.trackKeyData = var_14_0

	for iter_14_0 = 1, self.useTrackCountKeySet do
		if self.keySetList_[iter_14_0] then
			self.keySetList_[iter_14_0]:SetData(var_14_0[iter_14_0])
		end
	end
end

function var_0_0:DisposeSet()
	for iter_15_0, iter_15_1 in pairs(self.keySetList_) do
		iter_15_1:Dispose()

		iter_15_1 = nil
	end
end
