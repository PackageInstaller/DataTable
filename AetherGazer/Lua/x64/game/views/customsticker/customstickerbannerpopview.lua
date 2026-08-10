local var_0_0 = class("CustomStickerBannerPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/UserInfor/sticker_new/StickerBannerUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.curSuitID_ = 0
	arg_4_0.curDynamicBg_ = nil
	arg_4_0.stPool_ = {}
	arg_4_0.stTail_ = 1
	arg_4_0.fgPool_ = {}
	arg_4_0.fgTail_ = 1
	arg_4_0.bgPool_ = {}
	arg_4_0.bgTail_ = 1
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.jumpBtn_, nil, function()
		JumpTools.OpenPageByJump("/customStickerCollect", {
			suit = arg_5_0.curSuitID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.retBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.curSuitID_ = arg_8_0.params_.suit or 30601

	arg_8_0:UpdateView()
end

function var_0_0.UpdateView(arg_9_0)
	local var_9_0 = StickerSuitCfg[arg_9_0.curSuitID_]
	local var_9_1

	arg_9_0.stTail_, arg_9_0.fgTail_, arg_9_0.bgTail_ = 1, 1, 1

	for iter_9_0, iter_9_1 in ipairs(var_9_0.content) do
		local var_9_2 = ProfileDecorateItemCfg[iter_9_1]

		if var_9_2.item_type == 4 then
			var_9_1 = var_9_1 or var_9_2

			if not arg_9_0.bgPool_[arg_9_0.bgTail_] then
				local var_9_3 = Object.Instantiate(arg_9_0.bgGo_, arg_9_0.rootTrs_)

				arg_9_0.bgPool_[arg_9_0.bgTail_] = CustomStickerListItem.New(var_9_3)
			end

			local var_9_4 = PlayerData:GetStickerBg(iter_9_1).lock

			arg_9_0.bgPool_[arg_9_0.bgTail_]:SetData(var_9_2, false, false, true, false, var_9_4, nil)

			arg_9_0.bgTail_ = arg_9_0.bgTail_ + 1
		elseif var_9_2.item_type == 5 then
			if not arg_9_0.stPool_[arg_9_0.stTail_] then
				local var_9_5 = Object.Instantiate(arg_9_0.stGo_, arg_9_0.rootTrs_)

				arg_9_0.stPool_[arg_9_0.stTail_] = CustomStickerListItem.New(var_9_5)
			end

			local var_9_6 = PlayerData:GetSticker(iter_9_1).lock

			arg_9_0.stPool_[arg_9_0.stTail_]:SetData(var_9_2, false, false, true, false, var_9_6, nil)

			arg_9_0.stTail_ = arg_9_0.stTail_ + 1
		elseif var_9_2.item_type == 6 then
			if not arg_9_0.fgPool_[arg_9_0.fgTail_] then
				local var_9_7 = Object.Instantiate(arg_9_0.fgGo_, arg_9_0.rootTrs_)

				arg_9_0.fgPool_[arg_9_0.fgTail_] = CustomStickerListItem.New(var_9_7)
			end

			local var_9_8 = PlayerData:GetStickerFg(iter_9_1).lock

			arg_9_0.fgPool_[arg_9_0.fgTail_]:SetData(var_9_2, false, false, true, false, var_9_8, nil)

			arg_9_0.fgTail_ = arg_9_0.fgTail_ + 1
		end
	end

	arg_9_0.titleText_.text = var_9_0.name

	for iter_9_2 = #arg_9_0.fgPool_, 1, -1 do
		if iter_9_2 >= arg_9_0.fgTail_ then
			SetActive(arg_9_0.fgPool_[iter_9_2].gameObject_, false)
		else
			SetActive(arg_9_0.fgPool_[iter_9_2].gameObject_, true)
			arg_9_0.fgPool_[iter_9_2].transform_:SetAsFirstSibling()
		end
	end

	for iter_9_3 = #arg_9_0.bgPool_, 1, -1 do
		if iter_9_3 >= arg_9_0.bgTail_ then
			SetActive(arg_9_0.bgPool_[iter_9_3].gameObject_, false)
		else
			SetActive(arg_9_0.bgPool_[iter_9_3].gameObject_, true)
			arg_9_0.bgPool_[iter_9_3].transform_:SetAsFirstSibling()
		end
	end

	for iter_9_4 = 1, #arg_9_0.stPool_ do
		if iter_9_4 >= arg_9_0.stTail_ then
			SetActive(arg_9_0.stPool_[iter_9_4].gameObject_, false)
		else
			SetActive(arg_9_0.stPool_[iter_9_4].gameObject_, true)
			arg_9_0.stPool_[iter_9_4].transform_:SetAsLastSibling()
		end
	end

	arg_9_0:DestroyDynamicBg()

	arg_9_0.bgStaticImg_.enabled = false

	if var_9_1 then
		if var_9_1.type == 1 then
			arg_9_0.bgStaticImg_.spriteAsync = "TextureConfig/Sticker/Background_l/Stickerbg_l_" .. var_9_1.resource
			arg_9_0.bgStaticImg_.enabled = true
		elseif var_9_1.type == 2 then
			arg_9_0.curDynamicBg_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Bg/Bgitem_" .. var_9_1.resource), arg_9_0.bgDynamicTrs_)
			arg_9_0.bgStaticImg_.enabled = false
		end
	end
end

function var_0_0.DestroyDynamicBg(arg_10_0)
	if arg_10_0.curDynamicBg_ then
		Object.Destroy(arg_10_0.curDynamicBg_)

		arg_10_0.curDynamicBg_ = nil
	end
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:DestroyDynamicBg()

	if arg_12_0.bgList_ then
		arg_12_0.bgList_:Dispose()

		arg_12_0.bgList_ = nil
	end

	for iter_12_0 = 1, #arg_12_0.fgPool_ do
		if arg_12_0.fgPool[iter_12_0] then
			arg_12_0.fgPool[iter_12_0]:Dispose()

			arg_12_0.fgPool[iter_12_0] = nil
		end
	end

	for iter_12_1 = 1, #arg_12_0.bgPool_ do
		if arg_12_0.bgPool_[iter_12_1] then
			arg_12_0.bgPool_[iter_12_1]:Dispose()

			arg_12_0.bgPool_[iter_12_1] = nil
		end
	end

	for iter_12_2 = 1, #arg_12_0.stPool_ do
		if arg_12_0.stPool_[iter_12_2] then
			arg_12_0.stPool_[iter_12_2]:Dispose()

			arg_12_0.stPool_[iter_12_2] = nil
		end
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
