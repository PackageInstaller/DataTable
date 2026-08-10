local var_0_0 = class("CustomStickerCollectSuitItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stPool_ = {}
	arg_3_0.stTail_ = 1
	arg_3_0.fgPool_ = {}
	arg_3_0.fgTail_ = 1
	arg_3_0.bgPool_ = {}
	arg_3_0.bgTail_ = 1
	arg_3_0.rewardState_ = "lock"
	arg_3_0.rewardController_ = arg_3_0.mainControllerEx_:GetController("reward")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.viewBtn_, nil, function()
		JumpTools.OpenPageByJump("customStickerPreviewPop", {
			suit = true,
			cfg = StickerSuitCfg[arg_4_0.suitID_]
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.rewardBtn_, nil, function()
		if arg_4_0.rewardState_ == "unlock" then
			PlayerAction.RequestToRewardStickerSuit(arg_4_0.suitID_)

			arg_4_0.rewardState_ = "rewarded"

			arg_4_0.rewardController_:SetSelectedState(arg_4_0.rewardState_)
		else
			local var_6_0 = StickerSuitCfg[arg_4_0.suitID_].reward

			JumpTools.OpenPageByJump("rewardPreview", {
				rewardList = var_6_0
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		end
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.suitID_ = arg_7_1

	local var_7_0 = StickerSuitCfg[arg_7_1]

	arg_7_0.stTail_, arg_7_0.fgTail_, arg_7_0.bgTail_ = 1, 1, 1

	local var_7_1 = 0
	local var_7_2 = #var_7_0.content

	for iter_7_0, iter_7_1 in ipairs(var_7_0.content) do
		local var_7_3 = ProfileDecorateItemCfg[iter_7_1]

		if var_7_3.item_type == 4 then
			if not arg_7_0.bgPool_[arg_7_0.bgTail_] then
				local var_7_4 = Object.Instantiate(arg_7_0.bgGo_, arg_7_0.rootTrs_)

				arg_7_0.bgPool_[arg_7_0.bgTail_] = CustomStickerListItem.New(var_7_4)
			end

			local var_7_5 = PlayerData:GetStickerBg(iter_7_1).lock

			arg_7_0.bgPool_[arg_7_0.bgTail_]:SetData(var_7_3, false, false, true, var_7_5, false, function()
				JumpTools.OpenPageByJump("customStickerCollectPop", {
					stickerID = var_7_3.id
				})
			end, true)

			arg_7_0.bgTail_ = arg_7_0.bgTail_ + 1

			if not var_7_5 then
				var_7_1 = var_7_1 + 1
			end
		elseif var_7_3.item_type == 5 then
			if not arg_7_0.stPool_[arg_7_0.stTail_] then
				local var_7_6 = Object.Instantiate(arg_7_0.stGo_, arg_7_0.rootTrs_)

				arg_7_0.stPool_[arg_7_0.stTail_] = CustomStickerListItem.New(var_7_6)
			end

			local var_7_7 = PlayerData:GetSticker(iter_7_1).lock

			arg_7_0.stPool_[arg_7_0.stTail_]:SetData(var_7_3, false, false, true, var_7_7, false, function()
				JumpTools.OpenPageByJump("customStickerCollectPop", {
					stickerID = var_7_3.id
				})
			end, true)

			arg_7_0.stTail_ = arg_7_0.stTail_ + 1

			if not var_7_7 then
				var_7_1 = var_7_1 + 1
			end
		elseif var_7_3.item_type == 6 then
			if not arg_7_0.fgPool_[arg_7_0.fgTail_] then
				local var_7_8 = Object.Instantiate(arg_7_0.fgGo_, arg_7_0.rootTrs_)

				arg_7_0.fgPool_[arg_7_0.fgTail_] = CustomStickerListItem.New(var_7_8)
			end

			local var_7_9 = PlayerData:GetStickerFg(iter_7_1).lock

			arg_7_0.fgPool_[arg_7_0.fgTail_]:SetData(var_7_3, false, false, true, var_7_9, false, function()
				JumpTools.OpenPageByJump("customStickerCollectPop", {
					stickerID = var_7_3.id
				})
			end, true)

			arg_7_0.fgTail_ = arg_7_0.fgTail_ + 1

			if not var_7_9 then
				var_7_1 = var_7_1 + 1
			end
		end
	end

	arg_7_0.titleImg_.spriteAsync = "TextureConfig/Sticker/Suit_l/Suit_l_" .. var_7_0.resource
	arg_7_0.titleText_.text = var_7_0.name
	arg_7_0.suitNumText_.text = var_7_1 .. "/" .. var_7_2

	arg_7_0.rootTrs_:SetAnchoredPositionX(0)

	if PlayerData:CheckStickerSuitReward(arg_7_0.suitID_) then
		arg_7_0.rewardState_ = "rewarded"
	elseif var_7_2 <= var_7_1 then
		arg_7_0.rewardState_ = "unlock"
	else
		arg_7_0.rewardState_ = "lock"
	end

	arg_7_0.rewardController_:SetSelectedState(arg_7_0.rewardState_)

	for iter_7_2 = #arg_7_0.fgPool_, 1, -1 do
		if iter_7_2 >= arg_7_0.fgTail_ then
			SetActive(arg_7_0.fgPool_[iter_7_2].gameObject_, false)
		else
			SetActive(arg_7_0.fgPool_[iter_7_2].gameObject_, true)
			arg_7_0.fgPool_[iter_7_2].transform_:SetAsFirstSibling()
		end
	end

	for iter_7_3 = #arg_7_0.bgPool_, 1, -1 do
		if iter_7_3 >= arg_7_0.bgTail_ then
			SetActive(arg_7_0.bgPool_[iter_7_3].gameObject_, false)
		else
			SetActive(arg_7_0.bgPool_[iter_7_3].gameObject_, true)
			arg_7_0.bgPool_[iter_7_3].transform_:SetAsFirstSibling()
		end
	end

	for iter_7_4 = 1, #arg_7_0.stPool_ do
		if iter_7_4 >= arg_7_0.stTail_ then
			SetActive(arg_7_0.stPool_[iter_7_4].gameObject_, false)
		else
			SetActive(arg_7_0.stPool_[iter_7_4].gameObject_, true)
			arg_7_0.stPool_[iter_7_4].transform_:SetAsLastSibling()
		end
	end
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)

	for iter_11_0 = 1, #arg_11_0.fgPool_ do
		if arg_11_0.fgPool_[iter_11_0] then
			arg_11_0.fgPool_[iter_11_0]:Dispose()

			arg_11_0.fgPool_[iter_11_0] = nil
		end
	end

	for iter_11_1 = 1, #arg_11_0.bgPool_ do
		if arg_11_0.bgPool_[iter_11_1] then
			arg_11_0.bgPool_[iter_11_1]:Dispose()

			arg_11_0.bgPool_[iter_11_1] = nil
		end
	end

	for iter_11_2 = 1, #arg_11_0.stPool_ do
		if arg_11_0.stPool_[iter_11_2] then
			arg_11_0.stPool_[iter_11_2]:Dispose()

			arg_11_0.stPool_[iter_11_2] = nil
		end
	end
end

return var_0_0
