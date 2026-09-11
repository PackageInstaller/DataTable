local NewHeroArchiveHeroItemView = class("NewHeroArchiveHeroItemView", ReduxView)

function NewHeroArchiveHeroItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.index = arg_1_2

	self:Init()
end

function NewHeroArchiveHeroItemView:Init()
	self:InitUI()
end

function NewHeroArchiveHeroItemView:InitUI()
	self:BindCfgUI()

	self.roleImg_.immediate = true

	self:AddUIListener()

	self.superController_ = ControllerUtil.GetController(self.transform_, "super")
	self.profileController_ = ControllerUtil.GetController(self.transform_, "profile")
	self.maskController_ = ControllerUtil.GetController(self.transform_, "mask")
end

function NewHeroArchiveHeroItemView:OnTop()
	return
end

function NewHeroArchiveHeroItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.GoToSystem("/newHeroDetailArchive", {
			id = self.data_.archive_id
		})
		SDKTools.SendMessageToSDK("chain_story_enter", {
			chain_story_enter_source = 2,
			record_id = self.data_.archive_id
		})

		if self.callback then
			self.callback()
		end
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		ShowTips(string.format(GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_HERO"), self.recordData_.name))
	end)
end

function NewHeroArchiveHeroItemView:SetData(arg_8_1, arg_8_2)
	self.data_ = arg_8_1
	self.recordData_ = HeroRecordCfg[self.data_.archive_id]
	self.heroIdList_ = self.recordData_.hero_id
	self.type_ = arg_8_2

	self:RefreshUI()
end

function NewHeroArchiveHeroItemView:SetClickCallBack(arg_9_1)
	self.callback = arg_9_1
end

function NewHeroArchiveHeroItemView:RefreshUI()
	self.favorItemList_ = self.favorItemList_ or {}

	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(self.favorItemList_) do
		SetActive(iter_10_1.gameObject_, false)
		iter_10_1:ResetData()
	end

	local var_10_1 = false

	for iter_10_2, iter_10_3 in ipairs(self.heroIdList_) do
		if ArchiveData:GetTrustLevel(iter_10_3) > 0 then
			var_10_1 = true
		end
	end

	for iter_10_4, iter_10_5 in ipairs(self.heroIdList_) do
		local var_10_2 = HeroData:GetHeroData(self.heroIdList_[iter_10_4])

		if var_10_2.unlock == 1 then
			var_10_0 = var_10_0 + 1

			if not self.favorItemList_[var_10_0] then
				local var_10_3 = NewHeroArchiveHerofavorItemView.New(Object.Instantiate(self.favorabilityItem_), var_10_0)

				var_10_3.transform_:SetParent(self.favorabilityList_, false)
				table.insert(self.favorItemList_, var_10_3)
			end

			self.data_ = ArchiveData:GetArchive(self.data_.archive_id)

			self.favorItemList_[var_10_0]:SetData(self.data_, var_10_2.id, var_10_0)
			SetActive(self.favorItemList_[var_10_0].gameObject_, true)
		end
	end

	self:SetRoleImg()

	for iter_10_6, iter_10_7 in ipairs(self.favorItemList_) do
		iter_10_7:RefreshUI(var_10_1)
	end

	if var_10_0 == 0 then
		self.maskController_:SetSelectedState("true")
	else
		self.maskController_:SetSelectedState("false")
	end

	if table.isEmpty(self.recordData_.super_plot_id) then
		self.superController_:SetSelectedState("no")
	else
		self.superController_:SetSelectedState("yes")
	end

	local var_10_4 = 0

	for iter_10_8, iter_10_9 in pairs(self.data_.video_list) do
		var_10_4 = var_10_4 + 1
	end

	self.heartText_.text = var_10_4 + #ArchiveData:GetHasViewedSuperHeartList(self.data_.archive_id) .. "/" .. #self.recordData_.plot_id + #self.recordData_.super_plot_id

	local var_10_5 = ArchiveData:GetAnedoteList(self.heroIdList_)

	if not table.isEmpty(var_10_5) then
		self.profileController_:SetSelectedState("yes")

		self.profileText_.text = #ArchiveData:GetIsViewedArhiveStoryList(self.data_.archive_id) .. "/" .. #var_10_5
	else
		self.profileController_:SetSelectedState("no")
	end

	self.nameText_.text = self.recordData_.name

	manager.redPoint:unbindUIandKey(self.redPoint_)
	manager.redPoint:bindUIandKey(self.redPoint_, RedPointConst.HERO_HEART_STORY_ROOT_ID .. self.data_.archive_id)
end

function NewHeroArchiveHeroItemView:SetRoleImg()
	local var_11_0 = ArchiveData:GetSelectPicture(self.data_.archive_id)

	if table.isEmpty(var_11_0) or var_11_0.type == 0 then
		local var_11_1 = false

		for iter_11_0, iter_11_1 in ipairs(self.heroIdList_) do
			if HeroData:GetHeroData(iter_11_1).unlock == 1 and not var_11_1 then
				self.roleImg_.spriteSync = "TextureConfig/Character/Icon/" .. iter_11_1
				var_11_1 = true
			end
		end

		if not var_11_1 then
			self.roleImg_.spriteSync = "TextureConfig/Character/Icon/" .. self.heroIdList_[1]
		end

		return
	end

	if var_11_0.type == 1 or var_11_0.type == 2 then
		self.roleImg_.spriteSync = "TextureConfig/Character/Icon/" .. var_11_0.id
	elseif var_11_0.type == 3 then
		self.roleImg_.spriteSync = "TextureConfig/IllustratedHandbook/Portrait/" .. CollectPictureCfg[var_11_0.id].picture
	end
end

function NewHeroArchiveHeroItemView:OnExit()
	return
end

function NewHeroArchiveHeroItemView:Dispose()
	manager.redPoint:unbindUIandKey(self.redPoint_)

	if self.favorItemList_ then
		for iter_13_0, iter_13_1 in ipairs(self.favorItemList_) do
			iter_13_1:Dispose()
		end
	end

	NewHeroArchiveHeroItemView.super.Dispose(self)
end

return NewHeroArchiveHeroItemView
