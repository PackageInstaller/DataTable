local BulletinSwitchView = class("BulletinSwitchView", ReduxView)

function BulletinSwitchView:UIName()
	return "Widget/System/Bulletin/BulletinUI_new"
end

function BulletinSwitchView:UIParent()
	return manager.ui.uiPop.transform
end

function BulletinSwitchView:Init()
	self:InitUI()
	self:AddUIListener()
	self:AddEventListener()
end

function BulletinSwitchView:InitUI()
	self:BindCfgUI()

	self.contentView_ = BulletinContentView.New(self.mainContent_)
	self.titleItems_ = {
		self.titleItem1_:GetComponent(typeof(Toggle)),
		self.titleItem2_:GetComponent(typeof(Toggle)),
		self.titleItem3_:GetComponent(typeof(Toggle))
	}
	self.toggles_ = {
		self.toggle1_,
		self.toggle2_,
		self.toggle3_
	}
end

function BulletinSwitchView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)

	for iter_5_0, iter_5_1 in ipairs(self.toggles_) do
		self:AddToggleListener(iter_5_1, function(arg_8_0)
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

				if not self.ignoreToggleListener then
					for iter_8_0, iter_8_1 in pairs(var_8_0) do
						self:SelectItem(BulletinData.GetBulletinPageList()[iter_8_1])

						break
					end
				end

				self:UpdateLayout()
			end
		end)
	end
end

function BulletinSwitchView:AddEventListener()
	self:RegistEventListener(BULLETIN_LIST_UPDATE, handler(self, self.OnBulletinListUpdate))
	self:RegistEventListener(RED_POINT_UPDATE, handler(self, self.RedPointUpdate))
end

function BulletinSwitchView:OnBulletinListUpdate()
	self:UpdateBtnItems()
end

function BulletinSwitchView:OnBulletinDelete(arg_11_1)
	self:UpdateBtnItems()

	if self.currentItem_ ~= nil and self.currentItem_.data_ ~= nil and self.currentItem_.data_.id == arg_11_1.id then
		local var_11_0 = self:FindFirstBulletin(arg_11_1)

		if var_11_0 then
			self:SelectItem(var_11_0)
		else
			self:Back()
		end
	end
end

function BulletinSwitchView:OnSubscribe()
	return
end

function BulletinSwitchView:RedPointUpdate(arg_13_1)
	if arg_13_1 == RedPointConst.BULLETIN_UNREAD_101 then
		SetActive(self.notice1_, manager.redPoint:getTipValue(RedPointConst.BULLETIN_UNREAD_101) > 0)
	elseif arg_13_1 == RedPointConst.BULLETIN_UNREAD_102 then
		SetActive(self.notice2_, manager.redPoint:getTipValue(RedPointConst.BULLETIN_UNREAD_102) > 0)
	elseif arg_13_1 == RedPointConst.BULLETIN_UNREAD_104 then
		SetActive(self.notice3_, manager.redPoint:getTipValue(RedPointConst.BULLETIN_UNREAD_104) > 0)
	end
end

function BulletinSwitchView:UpdateTimer()
	self:RemoveAllUpdateTimer()

	self.updateTimers_ = {}

	for iter_14_0, iter_14_1 in pairs(BulletinData.GetBulletinPageList()) do
		local var_14_0 = iter_14_1.id
		local var_14_1 = Timer.New(function()
			self.updateTimers_[var_14_0]:Stop()

			self.updateTimers_[var_14_0] = nil

			BulletinAction.BulletinDelete(var_14_0)
			self:UpdateBtnItems()

			if self:GetViewProp("bulletinID") == var_14_0 then
				local var_15_0 = self:FindFirstBulletin(iter_14_1)

				if var_15_0 then
					self:SelectItem(var_15_0)
				else
					self:Back()
				end
			end
		end, iter_14_1.endTime - manager.time:GetServerTime(), 1)

		var_14_1:Start()

		self.updateTimers_[iter_14_1.id] = var_14_1
	end
end

function BulletinSwitchView:RemoveAllUpdateTimer()
	for iter_16_0, iter_16_1 in pairs(self.updateTimers_ or {}) do
		iter_16_1:Stop()
	end

	self.updateTimers_ = nil
end

function BulletinSwitchView:FindFirstBulletin(arg_17_1)
	local var_17_0 = BulletinData.GetBulletinIDList()

	if #var_17_0[arg_17_1.type] > 0 then
		for iter_17_0, iter_17_1 in pairs(var_17_0[arg_17_1.type]) do
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

function BulletinSwitchView:OnEnter()
	self.ignoreToggleListener = true
	self.treeScrollRect_.verticalNormalizedPosition = 1

	self:UpdateBtnItems()
	self:SetViewProp("bulletinID", self.params_.bulletinID)
	self.contentView_:SetBulletInId(self:GetViewProp("bulletinID"))

	for iter_18_0, iter_18_1 in pairs(BulletinData.GetBulletinPageList()) do
		if iter_18_1.id == self.params_.bulletinID then
			self:SelectItem(iter_18_1)

			break
		end
	end

	SetActive(self.notice1_, manager.redPoint:getTipValue(RedPointConst.BULLETIN_UNREAD_101) > 0)
	SetActive(self.notice2_, manager.redPoint:getTipValue(RedPointConst.BULLETIN_UNREAD_102) > 0)
	SetActive(self.notice3_, manager.redPoint:getTipValue(RedPointConst.BULLETIN_UNREAD_104) > 0)
	BulletinData.SaveDailyLoginPopBulletin()

	self.ignoreToggleListener = false
end

function BulletinSwitchView:ClearBtnItems()
	if self.activityBtnItems_ then
		for iter_19_0, iter_19_1 in ipairs(self.activityBtnItems_) do
			iter_19_1:Dispose()
		end

		self.activityBtnItems_ = nil
	end

	if self.gameBtnItems_ then
		for iter_19_2, iter_19_3 in ipairs(self.gameBtnItems_) do
			iter_19_3:Dispose()
		end

		self.gameBtnItems_ = nil
	end

	if self.infoBtnItems_ then
		for iter_19_4, iter_19_5 in pairs(self.infoBtnItems_) do
			iter_19_5:Dispose()
		end

		self.infoBtnItems_ = nil
	end
end

function BulletinSwitchView:UpdateBtnItems()
	self.activityBtnItems_ = self.activityBtnItems_ or {}
	self.gameBtnItems_ = self.gameBtnItems_ or {}
	self.infoBtnItems_ = self.infoBtnItems_ or {}

	local var_20_0 = BulletinData.GetBulletinIDList()[101] or {}
	local var_20_1 = BulletinData.GetBulletinIDList()[102] or {}
	local var_20_2 = BulletinData.GetBulletinIDList()[104] or {}

	self:UpdateBtnItemByList(self.activityBtnItems_, var_20_0, self.activityContainer_)
	self:UpdateBtnItemByList(self.gameBtnItems_, var_20_1, self.gameContainer_)
	self:UpdateBtnItemByList(self.infoBtnItems_, var_20_2, self.infoContainer_)

	if #var_20_0 ~= 0 then
		SetActive(self.titleItem1_, true)
	else
		SetActive(self.titleItem1_, false)
	end

	if #var_20_1 ~= 0 then
		SetActive(self.titleItem2_, true)
	else
		SetActive(self.titleItem2_, false)
	end

	if #var_20_2 ~= 0 then
		SetActive(self.titleItem3_, true)
	else
		SetActive(self.titleItem3_, false)
	end

	self:UpdateLayout()
end

function BulletinSwitchView:UpdateLayout()
	local var_21_0 = BulletinData.GetBulletinIDList()[101] or {}
	local var_21_1 = BulletinData.GetBulletinIDList()[102] or {}
	local var_21_2 = BulletinData.GetBulletinIDList()[104] or {}

	if #var_21_0 ~= 0 then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.activityContainer_)
	end

	if #var_21_1 ~= 0 then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.gameContainer_)
	end

	if #var_21_2 ~= 0 then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.infoContainer_)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.treeContainer_)
end

function BulletinSwitchView:UpdateBtnItemByList(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in pairs(arg_22_2) do
		var_22_0 = var_22_0 + 1

		local var_22_1 = BulletinData.GetBulletinPageList()[iter_22_1]

		if var_22_0 <= #arg_22_1 then
			arg_22_1[var_22_0]:SetData(var_22_1)
		else
			local var_22_2 = Object.Instantiate(self.btnItemPrefab_, arg_22_3)

			SetActive(var_22_2, true)

			local var_22_3 = BulletinBtnItem.New(handler(self, self.OnClickBtnItem), var_22_2)

			var_22_3:SetData(var_22_1)
			table.insert(arg_22_1, var_22_3)
		end

		local var_22_4 = arg_22_1[var_22_0]

		if arg_22_1[var_22_0] then
			if self.currentId_ and self.currentId_ == iter_22_1 then
				self.currentItem_ = var_22_4

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

function BulletinSwitchView:OnClickBtnItem(arg_23_1)
	self:SelectItem(arg_23_1)
end

function BulletinSwitchView:SelectItem(arg_24_1)
	if self.currentItem_ then
		self.currentItem_:SetSelected(false)
	end

	self.contentView_:SwitchBulletinPage(arg_24_1.id)

	if getData("bulletin", "bulletin_" .. arg_24_1.id) ~= "true" then
		BulletinAction.BulletinRead(arg_24_1.id)
	end

	local var_24_0
	local var_24_1 = false
	local var_24_2 = false
	local var_24_3 = false

	if arg_24_1.type == 101 then
		var_24_0 = self.activityBtnItems_
		var_24_1 = true
	elseif arg_24_1.type == 102 then
		var_24_0 = self.gameBtnItems_
		var_24_2 = true
	elseif arg_24_1.type == 104 then
		var_24_0 = self.infoBtnItems_
		var_24_3 = true
	end

	self.titleItems_[1].isOn = var_24_1
	self.titleItems_[2].isOn = var_24_2
	self.titleItems_[3].isOn = var_24_3

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if iter_24_1.data_.id == arg_24_1.id then
			self.currentItem_ = iter_24_1

			iter_24_1:SetSelected(true)

			self.currentId_ = iter_24_1.data_.id

			break
		end
	end
end

function BulletinSwitchView:GetFirstBulletin()
	local var_25_0 = manager.time:GetServerTime()

	for iter_25_0, iter_25_1 in ipairs({
		101,
		102,
		104
	}) do
		local var_25_1 = BulletinData.GetBulletinIDList()[iter_25_1]

		if var_25_1 then
			for iter_25_2, iter_25_3 in pairs(var_25_1) do
				local var_25_2 = BulletinData.GetBulletinPageList()[iter_25_3]

				if var_25_0 < var_25_2.endTime then
					return var_25_2
				end
			end
		end
	end

	return false
end

function BulletinSwitchView:OnExit()
	manager.windowBar:HideBar()

	for iter_26_0, iter_26_1 in pairs(self.activityBtnItems_) do
		iter_26_1:OnExit()
	end

	for iter_26_2, iter_26_3 in pairs(self.gameBtnItems_) do
		iter_26_3:OnExit()
	end

	for iter_26_4, iter_26_5 in pairs(self.infoBtnItems_) do
		iter_26_5:OnExit()
	end

	self:RemoveAllUpdateTimer()
end

function BulletinSwitchView:OnExitInput()
	JumpTools.Back()

	return true
end

function BulletinSwitchView:Dispose()
	self:RemoveAllListeners()
	self:RemoveAllEventListener()

	if self.contentView_ then
		self.contentView_:Dispose()

		self.contentView_ = nil
	end

	self:ClearBtnItems()
	BulletinSwitchView.super.Dispose(self)
end

return BulletinSwitchView
