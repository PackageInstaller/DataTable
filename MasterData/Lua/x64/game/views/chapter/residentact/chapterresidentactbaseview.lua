local ChapterResidentActBaseView = class("ChapterResidentActBaseView", ReduxView)

function ChapterResidentActBaseView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(Asset.Load((ChapterResidentTools.GetResidentActPrafabPath(arg_1_1))), arg_1_2)
	self.chapterID = arg_1_1
	self.activityID = ChapterClientCfg[self.chapterID].activity_id

	self:Init()
end

function ChapterResidentActBaseView:Init()
	self:InitUI()
	self:AddUIListener()

	if self.rewardListGo_ then
		self.rewardList_ = LuaList.New(handler(self, self.IndexRewardItem), self.rewardListGo_, CommonItemView)
	end

	self.btnStateController_ = self.controller_:GetController("btnState")

	self:BindRed(true)
end

function ChapterResidentActBaseView:IndexRewardItem(arg_3_1, arg_3_2)
	arg_3_2:SetData(self.rewards[arg_3_1])
end

function ChapterResidentActBaseView:AddUIListener()
	if self.goBtn_ then
		self:AddBtnListener(self.goBtn_, nil, function()
			ChapterResidentTools.GotoResidentActView(self.activityID)
		end)
	end

	if self.loadBtn_ then
		self:AddBtnListener(self.loadBtn_, nil, function()
			manager.assetPend:ShowAssetPendMessageBox(ChapterClientCfg[self.chapterID].asset_pend_key)
		end)
	end

	if self.descBtn_ then
		self:AddBtnListener(self.descBtn_, nil, function()
			ChapterResidentTools.OpenResidentActTips(self.activityID)
		end)
	end
end

function ChapterResidentActBaseView:BindRed(arg_8_1)
	local var_8_0 = ActivityTools.GetRedPointKey(self.activityID) .. self.activityID

	if arg_8_1 then
		if self.goBtn_ then
			manager.redPoint:bindUIandKey(self.goBtn_.transform, var_8_0)
		end

		if self.loadBtn_ then
			manager.redPoint:bindUIandKey(self.loadBtn_.transform, var_8_0)
		end
	else
		if self.goBtn_ then
			manager.redPoint:unbindUIandKey(self.goBtn_.transform, var_8_0)
		end

		if self.loadBtn_ then
			manager.redPoint:unbindUIandKey(self.loadBtn_.transform, var_8_0)
		end
	end
end

function ChapterResidentActBaseView:InitUI()
	self:BindCfgUI()
end

function ChapterResidentActBaseView:RefreshUI()
	if self.titleDescTxt_ then
		self.titleDescTxt_.text = ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID][1]].desc
	end

	self:RefreshProgressUI()
	self:RefreshRewardUI()
	self:RefreshBtnState()

	if not getData("ResidentAct", "NewTag_" .. self.activityID) then
		saveData("ResidentAct", "NewTag_" .. self.activityID, true)
		manager.redPoint:setTip(RedPointConst.RESIDENT_ACT_NEW_TAG .. self.activityID, 0, RedPointStyle.SHOW_NEW_TAG)
	end
end

function ChapterResidentActBaseView:RefreshBtnState()
	if self.btnStateController_ then
		if not manager.assetPend:CheckAssetPend(ChapterClientCfg[self.chapterID].asset_pend_key) then
			self.btnStateController_:SetSelectedState("assetpend")
		else
			self.btnStateController_:SetSelectedState("normal")
		end
	end
end

function ChapterResidentActBaseView:RefreshRewardUI()
	local var_12_0 = ActivityCfg[self.activityID]

	if self.rewardList_ then
		local var_12_1 = {}

		for iter_12_0, iter_12_1 in ipairs(var_12_0.reward_show_permanent ~= "" and var_12_0.reward_show_permanent or {}) do
			table.insert(var_12_1, rewardToItemTemplate({
				id = iter_12_1
			}, nil, true))
		end

		self.rewards = ItemTools.SortRewardItemList(var_12_1)

		self.rewardList_:StartScroll(#self.rewards)
	end
end

function ChapterResidentActBaseView:RefreshProgressUI()
	local var_13_0, var_13_1, var_13_2 = ChapterResidentTools.GetResidentActProgress(self.activityID)

	if self.progressValueTxt_ then
		self.progressValueTxt_.text = var_13_2 and var_13_2 or var_13_0 .. "/" .. var_13_1
	end

	if self.progressValueImg_ then
		self.progressValueImg_.fillAmount = var_13_0 / var_13_1
	end
end

function ChapterResidentActBaseView:SetActive(arg_14_1)
	SetActive(self.gameObject_, arg_14_1)
end

function ChapterResidentActBaseView:Dispose()
	self:BindRed(false)

	if self.rewardList_ then
		self.rewardList_:Dispose()

		self.rewardList_ = nil
	end

	ChapterResidentActBaseView.super.Dispose(self)
end

return ChapterResidentActBaseView
