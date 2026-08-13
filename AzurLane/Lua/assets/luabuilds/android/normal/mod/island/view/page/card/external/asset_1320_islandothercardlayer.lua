class = var_0_10000

local var_0_0 = "IslandOtherCardLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandSelfCardLayer"))

var_0_1.DOUBLE_CLICK_TIME = 0.5

function var_0_1.getUIName(arg_1_0)
	return "IslandOtherCardUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_3_0)
			pg = var_2_10001

			local var_3_0 = var_2_10001.m02
			local var_3_1 = var_1.sendNotification

			GAME = var_2_10003

			var_3_1(var_3_0, var_2_10003.ISLAND_GET_CARD_DATA, {
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

function var_0_1.init(arg_6_0)
	var_0_1.super.init(arg_6_0)

	setText = var_1

	local var_6_0 = arg_6_0._tf
	local var_6_1 = var_2.Find(var_6_0, "panel/achvs/tpl/empty/Text")

	i18n = var_6_0

	var_1(var_6_1, var_6_0("island_card_no_achv_other"))

	local var_6_2 = arg_6_0._tf

	arg_6_0.likeGreyTF = var_1.Find(var_6_2, "panel/photo/like_grey")

	local var_6_3 = {
		arg_6_0.photoSwitchBtn,
		arg_6_0.editBtn,
		arg_6_0.diyBtn,
		arg_6_0.setAchvsBtn
	}

	ipairs = var_2

	for iter_6_0, iter_6_1 in var_2(var_6_3) do
		setActive = var_1_10007

		var_1_10007(iter_6_1, false)

		removeOnButton = var_1_10007

		var_1_10007(iter_6_1)
	end

	arg_6_0.lableFlagLinkTFs = {
		arg_6_0.labelsTF
	}

	local var_6_4 = {
		arg_6_0.likeTF,
		arg_6_0.likeGreyTF
	}
	local var_6_5 = arg_6_0._tf

	var_6_4[3] = var_3.Find(var_6_5, "panel/btns/visit")
	arg_6_0.socialFlagLinkTFs = var_6_4

	return
end

function var_0_1.didEnter(arg_7_0)
	var_0_1.super.didEnter(arg_7_0)

	onButton = var_1

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0._tf

	var_1(var_7_0, var_3.Find(var_7_1, "panel/photo/like_btn"), function()
		local var_8_0 = arg_7_0.card

		if not var_0.ShowSocial(var_8_0) then
			return
		end

		local var_8_1 = arg_7_0

		var_0.GiveLike(var_8_1)

		return
	end)

	onButton = var_1

	local var_7_2 = arg_7_0
	local var_7_3 = arg_7_0.addBtn

	local function var_7_4()
		if arg_7_0.isFriend then
			return
		end

		local var_9_0 = arg_7_0.requestFriendBox

		var_0.ExecuteAction(var_9_0, "Show", arg_7_0.card.userId)

		return
	end

	SFX_PANEL = var_5

	var_1(var_7_2, var_7_3, var_7_4, var_5)

	onButton = var_1

	local var_7_5 = arg_7_0
	local var_7_6 = arg_7_0.removeBtn

	local function var_7_7()
		if not arg_7_0.isFriend then
			return
		end

		pg = var_0

		local var_10_0 = var_0.NewStyleMsgboxMgr.GetInstance()
		local var_10_1 = var_0.Show

		pg = var_2_10002

		local var_10_2 = var_2_10002.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX
		local var_10_3 = {}

		i18n = var_2_10004
		var_10_3.contentText = var_2_10004("remove_friend_tip")

		function var_10_3.onConfirm()
			local var_11_0 = arg_7_0
			local var_11_1 = var_0.emit

			IslandOtherCardMediator = var_3_10002

			var_11_1(var_11_0, var_3_10002.REMOVE_FRIEND, arg_7_0.card.userId)

			return
		end

		var_10_1(var_10_0, var_10_2, var_10_3)

		return
	end

	SFX_PANEL = var_5

	var_1(var_7_5, var_7_6, var_7_7, var_5)

	onButton = var_1

	local var_7_8 = arg_7_0
	local var_7_9 = arg_7_0.whitelistBtn

	local function var_7_10()
		if arg_7_0.card.whiteMark then
			pg = var_0

			local var_12_0 = var_0.TipsMgr.GetInstance()
			local var_12_1 = var_0.ShowTips

			i18n = var_2_10002

			var_12_1(var_12_0, var_2_10002("island_repeat_vip"))

			return
		end

		local var_12_2 = arg_7_0
		local var_12_3 = var_0.emit

		IslandOtherCardMediator = var_2_10002

		var_12_3(var_12_2, var_2_10002.ADD_WHITE_LIST, arg_7_0.card.userId)

		return
	end

	SFX_PANEL = var_5

	var_1(var_7_8, var_7_9, var_7_10, var_5)

	onButton = var_1

	local var_7_11 = arg_7_0
	local var_7_12 = arg_7_0.blacklistBtn

	local function var_7_13()
		if arg_7_0.card.blackMark then
			pg = var_0

			local var_13_0 = var_0.TipsMgr.GetInstance()
			local var_13_1 = var_0.ShowTips

			i18n = var_2_10002

			var_13_1(var_13_0, var_2_10002("island_repeat_blacklist"))

			return
		end

		local var_13_2 = arg_7_0
		local var_13_3 = var_0.emit

		IslandOtherCardMediator = var_2_10002

		var_13_3(var_13_2, var_2_10002.ADD_BLACK_LIST, arg_7_0.card.userId)

		return
	end

	SFX_PANEL = var_5

	var_1(var_7_11, var_7_12, var_7_13, var_5)

	return
end

function var_0_1.InitAchvUIList(arg_14_0)
	local var_14_0 = arg_14_0.achvUIList

	var_1.make(var_14_0, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			local var_15_0 = arg_14_0

			var_3.UpdataAchvItem(var_15_0, arg_15_1, arg_15_2)
		end

		return
	end)

	return
end

function var_0_1.InitBoxs(arg_16_0)
	IslandSetCardLabelBox = var_1_10001
	arg_16_0.setLabelBox = var_1_10001.New(arg_16_0._tf, arg_16_0.event)
	IslandRequestFriendBox = var_1
	arg_16_0.requestFriendBox = var_1.New(arg_16_0._tf, arg_16_0.event)

	return
end

function var_0_1.Flush(arg_17_0)
	var_0_1.super.Flush(arg_17_0)

	local var_17_0 = arg_17_0

	arg_17_0.FlushFlagTFs(var_17_0)

	getProxy = var_1
	FriendProxy = var_17_0

	local var_17_1 = var_1(var_17_0)

	arg_17_0.isFriend = var_1.isFriend(var_17_1, arg_17_0.card.userId)

	arg_17_0:FlushFriendBtns()
	arg_17_0:FlushLikeTFs()

	setText = var_1

	var_1(arg_17_0.likeGreyTF, arg_17_0.card.likeCnt)

	return
end

function var_0_1.FlushFlagTFs(arg_18_0)
	ipairs = var_1_10001

	for iter_18_0, iter_18_1 in var_1_10001(arg_18_0.lableFlagLinkTFs) do
		setActive = var_1_10006

		local var_18_0 = iter_18_1
		local var_18_1 = arg_18_0.card

		var_1_10006(var_18_0, var_8.ShowLabel(var_18_1))
	end

	ipairs = var_1

	for iter_18_2, iter_18_3 in var_1(arg_18_0.socialFlagLinkTFs) do
		setActive = var_1_10006

		local var_18_2 = iter_18_3
		local var_18_3 = arg_18_0.card

		var_1_10006(var_18_2, var_8.ShowSocial(var_18_3))
	end

	return
end

function var_0_1.FlushFriendBtns(arg_19_0)
	setActive = var_1_10001

	var_1_10001(arg_19_0.addBtn, not arg_19_0.isFriend)

	setActive = var_1_10001

	var_1_10001(arg_19_0.removeBtn, arg_19_0.isFriend)

	return
end

function var_0_1.FlushLikeTFs(arg_20_0)
	local var_20_0 = arg_20_0.card

	if not var_1.ShowSocial(var_20_0) then
		return
	end

	setActive = var_1

	var_1(arg_20_0.likeTF, arg_20_0.card.likeMark)

	setActive = var_1

	var_1(arg_20_0.likeGreyTF, not arg_20_0.card.likeMark)

	return
end

function var_0_1.UpdateGrayLabel(arg_21_0, arg_21_1)
	LoadImageSpriteAtlasAsync = var_1_10002

	var_1_10002("ui/islandcardui_atlas", "bg_label_gray", arg_21_1, true)

	setTextColor = var_1_10002

	local var_21_0 = arg_21_1
	local var_21_1 = arg_21_1.Find(var_21_0, "name")

	Color = var_21_0

	var_1_10002(var_21_1, var_21_0.NewHex("#F7F7F7"))

	setText = var_1_10002

	local var_21_2 = arg_21_1
	local var_21_3 = arg_21_1.Find(var_21_2, "name")

	i18n = var_21_2

	var_1_10002(var_21_3, var_21_2("island_card_edit_label"))

	setText = var_1_10002

	var_1_10002(arg_21_1:Find("value"), "")

	onButton = var_1_10002

	local var_21_4 = arg_21_0
	local var_21_5 = arg_21_1

	local function var_21_6()
		if arg_21_0.card.labelMark then
			pg = var_0

			local var_22_0 = var_0.TipsMgr.GetInstance()
			local var_22_1 = var_0.ShowTips

			i18n = var_2_10002

			var_22_1(var_22_0, var_2_10002("island_card_label_done"))

			return
		end

		local var_22_2 = arg_21_0.setLabelBox

		var_0.ExecuteAction(var_22_2, "Show", arg_21_0.card.userId, arg_21_0.card.labelData)

		return
	end

	SFX_PANEL = var_6

	var_1_10002(var_21_4, var_21_5, var_21_6, var_6)

	return
end

function var_0_1.GiveLike(arg_23_0)
	if arg_23_0.card.likeMark then
		pg = var_1

		local var_23_0 = var_1.TipsMgr.GetInstance()
		local var_23_1 = var_1.ShowTips

		i18n = var_1_10003

		var_23_1(var_23_0, var_1_10003("island_card_like_done"))

		return
	end

	local var_23_2 = arg_23_0
	local var_23_3 = arg_23_0.emit

	IslandOtherCardMediator = var_1_10003

	var_23_3(var_23_2, var_1_10003.GIVE_CARD_LIKE, arg_23_0.card.userId)

	return
end

function var_0_1.OnGiveLikeDone(arg_24_0)
	local var_24_0 = arg_24_0.card

	var_24_0.likeCnt = arg_24_0.card.likeCnt + 1
	setText = var_24_0

	var_24_0(arg_24_0.likeTF, arg_24_0.card.likeCnt)

	setText = var_24_0

	var_24_0(arg_24_0.likeGreyTF, arg_24_0.card.likeCnt)

	arg_24_0.card.likeMark = true

	arg_24_0:FlushLikeTFs()

	local var_24_1 = arg_24_0.likeTF
	local var_24_2 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004

	local var_24_3 = var_24_2(var_24_1, var_3(var_1_10004))

	var_1.Play(var_24_3)

	return
end

function var_0_1.OnGiveLabelDone(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.setLabelBox

	var_2.ExecuteAction(var_25_0, "Hide")

	local var_25_1 = arg_25_0.card

	var_2.AddLabel(var_25_1, arg_25_1)

	arg_25_0.card.labelMark = true

	arg_25_0:UpdataLabels()

	return
end

function var_0_1.OnAddFriendDone(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.requestFriendBox

	var_2.ExecuteAction(var_26_0, "Hide")

	return
end

function var_0_1.OnAddFriendPass(arg_27_0, arg_27_1)
	if arg_27_0.card.userId ~= arg_27_1 then
		return
	end

	arg_27_0.isFriend = true

	arg_27_0:FlushFriendBtns()

	return
end

function var_0_1.OnRemoveFriendDone(arg_28_0, arg_28_1)
	arg_28_0.isFriend = false

	arg_28_0:FlushFriendBtns()

	return
end

function var_0_1.OnAccessOpDone(arg_29_0, arg_29_1)
	IslandConst = var_1_10002

	local var_29_0

	if arg_29_1 == var_1_10002.ACCESS_OP_ADD_WHITELIST then
		var_29_0 = arg_29_0.card
		var_29_0.whiteMark = true
	else
		IslandConst = var_29_0

		if arg_29_1 == var_29_0.ACCESS_OP_ADD_BLACKLIST then
			arg_29_0.card.blackMark = true
		end
	end

	return
end

function var_0_1.willExit(arg_30_0)
	if not arg_30_0.contextData.isIslandPage then
		pg = var_1

		local var_30_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_30_0, arg_30_0._tf)
	end

	if arg_30_0.setLabelBox then
		local var_30_1 = arg_30_0.setLabelBox

		var_1.Destroy(var_30_1)

		arg_30_0.setLabelBox = nil
	end

	if arg_30_0.requestFriendBox then
		local var_30_2 = arg_30_0.requestFriendBox

		var_1.Destroy(var_30_2)

		arg_30_0.requestFriendBox = nil
	end

	return
end

return var_0_1
