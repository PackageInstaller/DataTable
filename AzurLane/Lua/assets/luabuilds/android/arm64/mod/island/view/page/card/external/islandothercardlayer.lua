local var_0_0 = class("IslandOtherCardLayer", import(".IslandSelfCardLayer"))

var_0_0.DOUBLE_CLICK_TIME = 0.5

function var_0_0.getUIName(arg_1_0)
	return "IslandOtherCardUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	seriesAsync({
		function(arg_3_0)
			pg.m02:sendNotification(GAME.ISLAND_GET_CARD_DATA, {
				userId = arg_2_0.contextData.userId,
				callback = function(arg_4_0)
					arg_2_0.card = arg_4_0

					arg_3_0()

					return
				end
			})

			return
		end
	}, function()
		arg_2_1()

		return
	end)

	return
end

function var_0_0.init(arg_6_0)
	var_0_0.super.init(arg_6_0)
	setText(arg_6_0._tf:Find("panel/achvs/tpl/empty/Text"), i18n("island_card_no_achv_other"))

	arg_6_0.likeGreyTF = arg_6_0._tf:Find("panel/photo/like_grey")

	for iter_6_0, iter_6_1 in ipairs({
		arg_6_0.photoSwitchBtn,
		arg_6_0.editBtn,
		arg_6_0.diyBtn,
		arg_6_0.setAchvsBtn
	}) do
		setActive(iter_6_1, false)
		removeOnButton(iter_6_1)
	end

	arg_6_0.lableFlagLinkTFs = {
		arg_6_0.labelsTF
	}
	arg_6_0.socialFlagLinkTFs = {
		arg_6_0.likeTF,
		arg_6_0.likeGreyTF,
		arg_6_0._tf:Find("panel/btns/visit")
	}

	return
end

function var_0_0.didEnter(arg_7_0)
	var_0_0.super.didEnter(arg_7_0)
	onButton(arg_7_0, arg_7_0._tf:Find("panel/photo/like_btn"), function()
		if not arg_7_0.card:ShowSocial() then
			return
		end

		arg_7_0:GiveLike()

		return
	end)
	onButton(arg_7_0, arg_7_0.addBtn, function()
		if arg_7_0.isFriend then
			return
		end

		arg_7_0.requestFriendBox:ExecuteAction("Show", arg_7_0.card.userId)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.removeBtn, function()
		if not arg_7_0.isFriend then
			return
		end

		pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX, {
			contentText = i18n("remove_friend_tip"),
			onConfirm = function()
				arg_7_0:emit(IslandOtherCardMediator.REMOVE_FRIEND, arg_7_0.card.userId)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.whitelistBtn, function()
		if arg_7_0.card.whiteMark then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_repeat_vip"))

			return
		end

		arg_7_0:emit(IslandOtherCardMediator.ADD_WHITE_LIST, arg_7_0.card.userId)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.blacklistBtn, function()
		if arg_7_0.card.blackMark then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_repeat_blacklist"))

			return
		end

		arg_7_0:emit(IslandOtherCardMediator.ADD_BLACK_LIST, arg_7_0.card.userId)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.InitAchvUIList(arg_14_0)
	arg_14_0.achvUIList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			arg_14_0:UpdataAchvItem(arg_15_1, arg_15_2)
		end

		return
	end)

	return
end

function var_0_0.InitBoxs(arg_16_0)
	arg_16_0.setLabelBox = IslandSetCardLabelBox.New(arg_16_0._tf, arg_16_0.event)
	arg_16_0.requestFriendBox = IslandRequestFriendBox.New(arg_16_0._tf, arg_16_0.event)

	return
end

function var_0_0.Flush(arg_17_0)
	var_0_0.super.Flush(arg_17_0)
	arg_17_0:FlushFlagTFs()

	arg_17_0.isFriend = getProxy(FriendProxy):isFriend(arg_17_0.card.userId)

	arg_17_0:FlushFriendBtns()
	arg_17_0:FlushLikeTFs()
	setText(arg_17_0.likeGreyTF, arg_17_0.card.likeCnt)

	return
end

function var_0_0.FlushFlagTFs(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.lableFlagLinkTFs) do
		setActive(iter_18_1, arg_18_0.card:ShowLabel())
	end

	for iter_18_2, iter_18_3 in ipairs(arg_18_0.socialFlagLinkTFs) do
		setActive(iter_18_3, arg_18_0.card:ShowSocial())
	end

	return
end

function var_0_0.FlushFriendBtns(arg_19_0)
	setActive(arg_19_0.addBtn, not arg_19_0.isFriend)
	setActive(arg_19_0.removeBtn, arg_19_0.isFriend)

	return
end

function var_0_0.FlushLikeTFs(arg_20_0)
	if not arg_20_0.card:ShowSocial() then
		return
	end

	setActive(arg_20_0.likeTF, arg_20_0.card.likeMark)
	setActive(arg_20_0.likeGreyTF, not arg_20_0.card.likeMark)

	return
end

function var_0_0.UpdateGrayLabel(arg_21_0, arg_21_1)
	LoadImageSpriteAtlasAsync("ui/islandcardui_atlas", "bg_label_gray", arg_21_1, true)
	setTextColor(arg_21_1:Find("name"), Color.NewHex("#F7F7F7"))
	setText(arg_21_1:Find("name"), i18n("island_card_edit_label"))
	setText(arg_21_1:Find("value"), "")
	onButton(arg_21_0, arg_21_1, function()
		if arg_21_0.card.labelMark then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_card_label_done"))

			return
		end

		arg_21_0.setLabelBox:ExecuteAction("Show", arg_21_0.card.userId, arg_21_0.card.labelData)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.GiveLike(arg_23_0)
	if arg_23_0.card.likeMark then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_card_like_done"))

		return
	end

	arg_23_0:emit(IslandOtherCardMediator.GIVE_CARD_LIKE, arg_23_0.card.userId)

	return
end

function var_0_0.OnGiveLikeDone(arg_24_0)
	arg_24_0.card.likeCnt = arg_24_0.card.likeCnt + 1

	setText(arg_24_0.likeTF, arg_24_0.card.likeCnt)
	setText(arg_24_0.likeGreyTF, arg_24_0.card.likeCnt)

	arg_24_0.card.likeMark = true

	arg_24_0:FlushLikeTFs()
	arg_24_0.likeTF:GetComponent(typeof(Animation)):Play()

	return
end

function var_0_0.OnGiveLabelDone(arg_25_0, arg_25_1)
	arg_25_0.setLabelBox:ExecuteAction("Hide")
	arg_25_0.card:AddLabel(arg_25_1)

	arg_25_0.card.labelMark = true

	arg_25_0:UpdataLabels()

	return
end

function var_0_0.OnAddFriendDone(arg_26_0, arg_26_1)
	arg_26_0.requestFriendBox:ExecuteAction("Hide")

	return
end

function var_0_0.OnAddFriendPass(arg_27_0, arg_27_1)
	if arg_27_0.card.userId ~= arg_27_1 then
		return
	end

	arg_27_0.isFriend = true

	arg_27_0:FlushFriendBtns()

	return
end

function var_0_0.OnRemoveFriendDone(arg_28_0, arg_28_1)
	arg_28_0.isFriend = false

	arg_28_0:FlushFriendBtns()

	return
end

function var_0_0.OnAccessOpDone(arg_29_0, arg_29_1)
	if arg_29_1 == IslandConst.ACCESS_OP_ADD_WHITELIST then
		arg_29_0.card.whiteMark = true
	elseif arg_29_1 == IslandConst.ACCESS_OP_ADD_BLACKLIST then
		arg_29_0.card.blackMark = true
	end

	return
end

function var_0_0.willExit(arg_30_0)
	if not arg_30_0.contextData.isIslandPage then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_30_0._tf)
	end

	if arg_30_0.setLabelBox then
		arg_30_0.setLabelBox:Destroy()

		arg_30_0.setLabelBox = nil
	end

	if arg_30_0.requestFriendBox then
		arg_30_0.requestFriendBox:Destroy()

		arg_30_0.requestFriendBox = nil
	end

	return
end

return var_0_0
