local var_0_0 = class("NewHeroArchiveHeroItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.index = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.roleImg_.immediate = true

	arg_3_0:AddUIListener()

	arg_3_0.superController_ = ControllerUtil.GetController(arg_3_0.transform_, "super")
	arg_3_0.profileController_ = ControllerUtil.GetController(arg_3_0.transform_, "profile")
	arg_3_0.maskController_ = ControllerUtil.GetController(arg_3_0.transform_, "mask")
end

function var_0_0.OnTop(arg_4_0)
	return
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		JumpTools.GoToSystem("/newHeroDetailArchive", {
			id = arg_5_0.data_.archive_id
		})
		SDKTools.SendMessageToSDK("chain_story_enter", {
			chain_story_enter_source = 2,
			record_id = arg_5_0.data_.archive_id
		})

		if arg_5_0.callback then
			arg_5_0.callback()
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		ShowTips(string.format(GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_HERO"), arg_5_0.recordData_.name))
	end)
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.data_ = arg_8_1
	arg_8_0.recordData_ = HeroRecordCfg[arg_8_0.data_.archive_id]
	arg_8_0.heroIdList_ = arg_8_0.recordData_.hero_id
	arg_8_0.type_ = arg_8_2

	arg_8_0:RefreshUI()
end

function var_0_0.SetClickCallBack(arg_9_0, arg_9_1)
	arg_9_0.callback = arg_9_1
end

function var_0_0.RefreshUI(arg_10_0)
	if not arg_10_0.favorItemList_ then
		arg_10_0.favorItemList_ = {}
	end

	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.favorItemList_) do
		SetActive(iter_10_1.gameObject_, false)
		iter_10_1:ResetData()
	end

	local var_10_1 = false

	for iter_10_2, iter_10_3 in ipairs(arg_10_0.heroIdList_) do
		if ArchiveData:GetTrustLevel(iter_10_3) > 0 then
			var_10_1 = true
		end
	end

	for iter_10_4, iter_10_5 in ipairs(arg_10_0.heroIdList_) do
		local var_10_2 = HeroData:GetHeroData(arg_10_0.heroIdList_[iter_10_4])

		if var_10_2.unlock == 1 then
			var_10_0 = var_10_0 + 1

			if not arg_10_0.favorItemList_[var_10_0] then
				local var_10_3 = Object.Instantiate(arg_10_0.favorabilityItem_)
				local var_10_4 = NewHeroArchiveHerofavorItemView.New(var_10_3, var_10_0)

				var_10_4.transform_:SetParent(arg_10_0.favorabilityList_, false)
				table.insert(arg_10_0.favorItemList_, var_10_4)
			end

			arg_10_0.data_ = ArchiveData:GetArchive(arg_10_0.data_.archive_id)

			arg_10_0.favorItemList_[var_10_0]:SetData(arg_10_0.data_, var_10_2.id, var_10_0)
			SetActive(arg_10_0.favorItemList_[var_10_0].gameObject_, true)
		end
	end

	arg_10_0:SetRoleImg()

	for iter_10_6, iter_10_7 in ipairs(arg_10_0.favorItemList_) do
		iter_10_7:RefreshUI(var_10_1)
	end

	if var_10_0 == 0 then
		arg_10_0.maskController_:SetSelectedState("true")
	else
		arg_10_0.maskController_:SetSelectedState("false")
	end

	if table.isEmpty(arg_10_0.recordData_.super_plot_id) then
		arg_10_0.superController_:SetSelectedState("no")
	else
		arg_10_0.superController_:SetSelectedState("yes")
	end

	local var_10_5 = 0

	for iter_10_8, iter_10_9 in pairs(arg_10_0.data_.video_list) do
		var_10_5 = var_10_5 + 1
	end

	local var_10_6 = var_10_5 + #ArchiveData:GetHasViewedSuperHeartList(arg_10_0.data_.archive_id)

	arg_10_0.heartText_.text = var_10_6 .. "/" .. #arg_10_0.recordData_.plot_id + #arg_10_0.recordData_.super_plot_id

	local var_10_7 = ArchiveData:GetAnedoteList(arg_10_0.heroIdList_)

	if not table.isEmpty(var_10_7) then
		arg_10_0.profileController_:SetSelectedState("yes")

		local var_10_8 = ArchiveData:GetIsViewedArhiveStoryList(arg_10_0.data_.archive_id)

		arg_10_0.profileText_.text = #var_10_8 .. "/" .. #var_10_7
	else
		arg_10_0.profileController_:SetSelectedState("no")
	end

	arg_10_0.nameText_.text = arg_10_0.recordData_.name

	manager.redPoint:unbindUIandKey(arg_10_0.redPoint_)
	manager.redPoint:bindUIandKey(arg_10_0.redPoint_, RedPointConst.HERO_HEART_STORY_ROOT_ID .. arg_10_0.data_.archive_id)
end

function var_0_0.SetRoleImg(arg_11_0)
	local var_11_0 = ArchiveData:GetSelectPicture(arg_11_0.data_.archive_id)

	if table.isEmpty(var_11_0) or var_11_0.type == 0 then
		local var_11_1 = false

		for iter_11_0, iter_11_1 in ipairs(arg_11_0.heroIdList_) do
			if HeroData:GetHeroData(iter_11_1).unlock == 1 and not var_11_1 then
				arg_11_0.roleImg_.spriteSync = "TextureConfig/Character/Icon/" .. iter_11_1
				var_11_1 = true
			end
		end

		if not var_11_1 then
			arg_11_0.roleImg_.spriteSync = "TextureConfig/Character/Icon/" .. arg_11_0.heroIdList_[1]
		end

		return
	end

	if var_11_0.type == 1 or var_11_0.type == 2 then
		arg_11_0.roleImg_.spriteSync = "TextureConfig/Character/Icon/" .. var_11_0.id
	elseif var_11_0.type == 3 then
		local var_11_2 = CollectPictureCfg[var_11_0.id].picture

		arg_11_0.roleImg_.spriteSync = "TextureConfig/IllustratedHandbook/Portrait/" .. var_11_2
	end
end

function var_0_0.OnExit(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	manager.redPoint:unbindUIandKey(arg_13_0.redPoint_)

	if arg_13_0.favorItemList_ then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0.favorItemList_) do
			iter_13_1:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
