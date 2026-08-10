local var_0_0 = class("StoreItemInfo", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.storeHeadInfoView_ = StoreHeadInfo.New(arg_1_0.itemHeadGo_)
	arg_1_0.hideBtnController_ = arg_1_0.controllerEx_:GetController("btnState")
	arg_1_0.btnController_ = arg_1_0.controllerEx_:GetController("btn")
	arg_1_0.switchBtnController_ = arg_1_0.controllerEx_:GetController("tab")
	arg_1_0.uiList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexSourceItem), arg_1_0.uiListGo_, StoreItemSource)
	arg_1_0.selectInfoType_ = StoreConst.ITEM_INFO_TYPE.DESC
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.storeHeadInfoView_:OnEnter()
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0.storeHeadInfoView_:OnExit()
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	arg_4_0.uiList_:Dispose()

	arg_4_0.uiList_ = nil

	arg_4_0.storeHeadInfoView_:Dispose()

	arg_4_0.storeHeadInfoView_ = nil
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.switchBtn_, nil, function()
		if arg_5_0.selectInfoType_ == StoreConst.ITEM_INFO_TYPE.DESC then
			arg_5_0.selectInfoType_ = StoreConst.ITEM_INFO_TYPE.SOURCE
		else
			arg_5_0.selectInfoType_ = StoreConst.ITEM_INFO_TYPE.DESC
		end

		arg_5_0:RefreshInfo()
	end)
	arg_5_0:AddBtnListener(arg_5_0.useBtn_, nil, function()
		local var_7_0 = ItemCfg[arg_5_0.itemData_.id]
		local var_7_1 = ItemTools.GetItemExpiredTimeByInfo(arg_5_0.itemData_)

		if var_7_1 ~= 0 and var_7_1 <= manager.time:GetServerTime() then
			ShowTips("ITEM_EXPIRE")

			return
		end

		if var_7_0.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM or var_7_0.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM_LIMIT_TIME or var_7_0.sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_ONE then
			arg_5_0:CheckHeroOptionalOne(var_7_0, var_7_1)

			return
		end

		if var_7_0.type == ItemConst.ITEM_TYPE.GIFT and ItemConst.ITEM_SUB_TYPE.FUKUBUKURO == var_7_0.sub_type then
			JumpTools.OpenPageByJump("popFukubukuroSelect", {
				popItemInfo = {
					arg_5_0.itemData_.id,
					arg_5_0.itemData_.number,
					0,
					arg_5_0.itemData_.timeValid
				},
				instance_id = arg_5_0.itemData_.instance_id
			})

			return
		end

		if var_7_0.sub_type == ItemConst.ITEM_SUB_TYPE.LIMIT_TIME_SKIN_ITEM then
			JumpTools.OpenPageByJump("limitTimeSkinUsePop", {
				itemData = arg_5_0.itemData_
			})

			return
		end

		arg_5_0:CheckItemUse(var_7_0, var_7_1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.composeBtn_, nil, function()
		JumpTools.OpenPageByJump("synthesise", {
			id = ItemCfg[arg_5_0.itemData_.id].compose_id
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.decomposeBtn_, nil, function()
		JumpTools.OpenPageByJump("synthesise", {
			id = ItemCfg[arg_5_0.itemData_.id].decompose_id
		})
	end)
end

function var_0_0.SetData(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.itemData_ = arg_10_1

	arg_10_0.storeHeadInfoView_:SetData(arg_10_1)

	local var_10_0 = arg_10_1.id

	arg_10_0.descText_.text = ItemTools.getItemDesc(var_10_0)

	local var_10_1 = ItemCfg[var_10_0]
	local var_10_2 = false

	if var_10_1.compose_id ~= 0 and var_10_1.decompose_id ~= 0 then
		arg_10_0.btnController_:SetSelectedState("state3")
	elseif var_10_1.compose_id ~= 0 then
		arg_10_0.btnController_:SetSelectedState("state1")
	elseif var_10_1.decompose_id ~= 0 then
		arg_10_0.btnController_:SetSelectedState("state2")
	elseif ItemTools.isCanUseItem(var_10_0) then
		arg_10_0.btnController_:SetSelectedState("state0")
	else
		var_10_2 = true
	end

	if var_10_1.sub_type == ItemConst.ITEM_SUB_TYPE.LIMIT_TIME_SKIN_ITEM and ItemTools.HasOwnAllLimitCardItems(var_10_0) then
		arg_10_0.useBtnText_.text = GetTips("TIP_EXCHANGE")
	else
		arg_10_0.useBtnText_.text = GetTips("TIP_USE")
	end

	if var_10_2 then
		arg_10_0.hideBtnController_:SetSelectedState("hide")
	else
		arg_10_0.hideBtnController_:SetSelectedState("show")
	end

	if not arg_10_2 then
		arg_10_0.selectInfoType_ = StoreConst.ITEM_INFO_TYPE.DESC
	end

	arg_10_0:RefreshInfo()

	arg_10_0.sourceList_ = ItemTools.GetItemSourceList(var_10_0)

	arg_10_0.uiList_:StartScroll(#arg_10_0.sourceList_)
end

function var_0_0.RefreshInfo(arg_11_0)
	if arg_11_0.selectInfoType_ == StoreConst.ITEM_INFO_TYPE.DESC then
		arg_11_0.switchBtnController_:SetSelectedState("desc")
	else
		arg_11_0.switchBtnController_:SetSelectedState("source")
	end
end

function var_0_0.IndexSourceItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_0.sourceList_[arg_12_1])
end

function var_0_0.CheckSelectItem(arg_13_0)
	local var_13_0 = ItemCfg[arg_13_0.itemData_.id]

	if var_13_0.sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_ONE or var_13_0.sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_MULTI and not _G.SkipTip.SkipExchangeHero2 then
		local var_13_1 = true

		for iter_13_0 = 1, #var_13_0.param do
			local var_13_2 = var_13_0.param[iter_13_0][1]

			var_13_2 = ItemCfg[var_13_2].hero_id or var_13_2

			if WeaponServantCfg[var_13_2] or SkinCfg[var_13_2] then
				var_13_1 = false

				break
			end

			if HeroCfg[var_13_2] == nil or HeroData:GetHeroOmegaNeedPiece(var_13_2) > 0 then
				var_13_1 = false

				break
			end
		end

		return var_13_1
	end
end

function var_0_0.CheckHeroOptionalOne(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = 1

	if arg_14_1.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM then
		JumpTools.OpenPageByJump("optionalItemSelect", {
			popItemInfo = {
				arg_14_0.itemData_.id,
				arg_14_0.itemData_.number,
				0,
				arg_14_2
			},
			selectNum = var_14_0
		})
	end

	if arg_14_1.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM_LIMIT_TIME or arg_14_1.sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_ONE then
		if arg_14_0:CheckSelectItem() and not _G.SkipTip.SkipExchangeHero2 then
			ShowMessageBox({
				content = GetTips("CHOICEBOX_CHOSEN_ALL_MAX"),
				OkCallback = function()
					JumpTools.OpenPageByJump("optionalItemSelect", {
						noPop = true,
						popItemInfo = {
							arg_14_0.itemData_.id,
							arg_14_0.itemData_.number,
							0,
							arg_14_2
						},
						selectNum = var_14_0
					})
				end,
				ToggleCallback = function(arg_16_0)
					_G.SkipTip.SkipExchangeHero2 = arg_16_0
				end
			})
		else
			JumpTools.OpenPageByJump("optionalItemSelect", {
				popItemInfo = {
					arg_14_0.itemData_.id,
					arg_14_0.itemData_.number,
					0,
					arg_14_2
				},
				selectNum = var_14_0,
				noPop = _G.SkipTip.SkipExchangeHero2
			})
		end
	end
end

function var_0_0.CheckItemUse(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1.sub_type == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_MULTI or arg_17_1.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM_MULT then
		if arg_17_0:CheckSelectItem() and not _G.SkipTip.SkipExchangeHero2 then
			ShowMessageBox({
				content = GetTips("CHOICEBOX_CHOSEN_ALL_MAX"),
				OkCallback = function()
					JumpTools.OpenPageByJump("optionalItemSelect", {
						selectNum = 1,
						popItemInfo = {
							arg_17_0.itemData_.id,
							arg_17_0.itemData_.number,
							0,
							arg_17_2
						},
						noPop = _G.SkipTip.SkipExchangeHero2
					})
				end,
				ToggleCallback = function(arg_19_0)
					_G.SkipTip.SkipExchangeHero2 = arg_19_0
				end
			})
		else
			JumpTools.OpenPageByJump("optionalItemSelect", {
				selectNum = 1,
				popItemInfo = {
					arg_17_0.itemData_.id,
					arg_17_0.itemData_.number,
					0,
					arg_17_2
				},
				noPop = _G.SkipTip.SkipExchangeHero2
			})
		end
	elseif arg_17_1.sub_type == ItemConst.ITEM_SUB_TYPE.BIRTHDAY_ITEM then
		arg_17_0:UseStoryItem(function()
			local var_20_0 = BirthdayCfg[BirthdayCfg.get_id_list_by_commemorative_props_id[arg_17_0.itemData_.id][1]].story_id

			manager.story:StartStory(var_20_0)
		end)
	elseif arg_17_1.sub_type == ItemConst.ITEM_SUB_TYPE.STORY_ITEM then
		arg_17_0:UseStoryItem(function()
			local var_21_0 = ItemCfg[arg_17_0.itemData_.id].param[1]

			manager.story:StartStory(var_21_0)
		end)
	else
		JumpTools.OpenPageByJump("itemUse", {
			itemData = arg_17_0.itemData_
		})
	end
end

function var_0_0.UseStoryItem(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.itemData_.id
	local var_22_1 = 1
	local var_22_2 = arg_22_0.itemData_.timeValid
	local var_22_3 = {
		item_info = {
			id = var_22_0,
			num = var_22_1,
			time_valid = var_22_2
		},
		use_list = {}
	}

	CommonAction.TryToUseItemWitchCallback({
		var_22_3
	}, function(arg_23_0)
		arg_22_1()
	end)
end

return var_0_0
