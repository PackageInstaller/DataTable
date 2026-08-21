local var_0_0 = class("IslandFriendListPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandFriendListUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.morePanel = arg_2_0._tf:Find("scrollrect/content/more_panel")
	arg_2_0.whiteBtn = arg_2_0.morePanel:Find("white")
	arg_2_0.blackBtn = arg_2_0.morePanel:Find("black")
	arg_2_0.delBtn = arg_2_0.morePanel:Find("del")
	arg_2_0.cards = {}
	arg_2_0._scrollrect = arg_2_0._tf:Find("scrollrect"):GetComponent("LScrollRect")

	function arg_2_0._scrollrect.onInitItem(arg_3_0)
		arg_2_0:OnInitItem(arg_3_0)

		return
	end

	function arg_2_0._scrollrect.onUpdateItem(arg_4_0, arg_4_1)
		arg_2_0:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	setText(arg_2_0.morePanel:Find("white/Text"), i18n("island_whiteList"))
	setText(arg_2_0.morePanel:Find("black/Text"), i18n("island_blackList"))

	if arg_2_0.delBtn then
		setText(arg_2_0.morePanel:Find("del/Text"), i18n("island_btn_label_del"))
	end

	return
end

function var_0_0.CreateCard(arg_5_0, arg_5_1)
	return IslandFriendCard.New(arg_5_1)
end

function var_0_0.OnInitItem(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:CreateCard(arg_6_1)

	onButton(arg_6_0, var_6_0.visitBtn, function()
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandVisit(playerId))
		arg_6_0:emit(IslandMediator.ENTER_ISLAND, var_6_0.player.id)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, var_6_0.moreBtn, function()
		if arg_6_0.isOpenMore then
			arg_6_0:CloseMorePanel()
		else
			arg_6_0:OpenMorePanel(var_6_0.player, (var_6_0.moreBtn.parent.parent:InverseTransformPoint(var_6_0.moreBtn.position)))
		end

		return
	end, SFX_PANEL)
	onButton(arg_6_0, var_6_0.cardBtn, function()
		arg_6_0:emit(IslandMediator.OPEN_PAGE, "IslandOtherCardPage", {
			var_6_0.player.id
		})

		return
	end, SFX_PANEL)

	arg_6_0.cards[arg_6_1] = var_6_0

	return
end

function var_0_0.OpenMorePanel(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.isOpenMore = true

	setActive(arg_10_0.morePanel, true)
	arg_10_0.morePanel:SetAsLastSibling()

	arg_10_0.morePanel.localPosition = arg_10_2 - Vector3(110, 0, 0)
	arg_10_0.whiteBtn = arg_10_0.morePanel:Find("white")
	arg_10_0.blackBtn = arg_10_0.morePanel:Find("black")
	arg_10_0.delBtn = arg_10_0.morePanel:Find("del")

	arg_10_0:InitMoreBtns(arg_10_1)

	return
end

function var_0_0.InitMoreBtns(arg_11_0, arg_11_1)
	onButton(arg_11_0, arg_11_0.whiteBtn, function()
		arg_11_0:emit(IslandMediator.ADD_WHITE_LIST, arg_11_1.id)

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.blackBtn, function()
		arg_11_0:emit(IslandMediator.ADD_BLACK_LIST, arg_11_1.id)

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.delBtn, function()
		pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX, {
			contentText = i18n("remove_friend_tip"),
			onConfirm = function()
				arg_11_0:emit(IslandMediator.REMOVE_FRIEND, arg_11_1.id)

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.CloseMorePanel(arg_16_0)
	arg_16_0.isOpenMore = false

	setActive(arg_16_0.morePanel, false)

	return
end

function var_0_0.OnUpdateItem(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0.cards[arg_17_2] then
		arg_17_0:OnInitItem(arg_17_2)
	end

	arg_17_0.cards[arg_17_2]:Update(arg_17_0.displays[arg_17_1 + 1])

	return
end

function var_0_0.Show(arg_18_0)
	var_0_0.super.Show(arg_18_0)
	arg_18_0:InitList()

	return
end

function var_0_0.Hide(arg_19_0)
	var_0_0.super.Hide(arg_19_0)

	if arg_19_0.isOpenMore then
		arg_19_0:CloseMorePanel()
	end

	return
end

function var_0_0.Flush(arg_20_0)
	arg_20_0:InitList()

	return
end

function var_0_0.GetData(arg_21_0, arg_21_1)
	local var_21_0 = getProxy(FriendProxy):getAllFriends()

	if #var_21_0 <= 0 then
		return arg_21_1({})
	end

	local var_21_1 = {}

	for iter_21_0, iter_21_1 in pairs(var_21_0) do
		table.insert(var_21_1, iter_21_1.id)
	end

	arg_21_0:emit(IslandMediator.GET_GIFT_TAG, var_21_1, function()
		arg_21_1(var_21_0)

		return
	end)

	return
end

function var_0_0.InitList(arg_23_0)
	pg.UIMgr.GetInstance():LoadingOn()
	arg_23_0:GetData(function(arg_24_0)
		pg.UIMgr.GetInstance():LoadingOff()

		arg_23_0.displays = arg_24_0

		arg_23_0._scrollrect:SetTotalCount(#arg_23_0.displays)

		return
	end)

	return
end

function var_0_0.OnDestroy(arg_25_0)
	ClearLScrollrect(arg_25_0._scrollrect)

	for iter_25_0, iter_25_1 in pairs(arg_25_0.cards) do
		iter_25_1:Dispose()
	end

	arg_25_0.cards = nil

	return
end

return var_0_0
