local var_0_0 = class("IslandSignInInvitationPage", import("...base.IslandBasePage"))
local var_0_1 = 1
local var_0_2 = 2

function var_0_0.getUIName(arg_1_0)
	return "IslandSignInInvitationUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.shareBtn = arg_2_0._tf:Find("frame/public")
	arg_2_0.onkeyBtn = arg_2_0._tf:Find("frame/onkey")
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/close")
	arg_2_0.toggles = {
		[var_0_1] = arg_2_0._tf:Find("frame/toggles/1"),
		[var_0_2] = arg_2_0._tf:Find("frame/toggles/2")
	}
	;({})[var_0_1] = arg_2_0._tf:Find("frame/toggles/1/Text"):GetComponent(typeof(Text))
	;({})[var_0_2] = arg_2_0._tf:Find("frame/toggles/2/Text"):GetComponent(typeof(Text))
	arg_2_0.texts = {}
	arg_2_0.names = {
		i18n("island_friend"),
		i18n("island_guild")
	}
	arg_2_0._scrollrect = arg_2_0._tf:Find("frame/scrollrect"):GetComponent("LScrollRect")

	function arg_2_0._scrollrect.onInitItem(arg_3_0)
		arg_2_0:OnInitItem(arg_3_0)

		return
	end

	function arg_2_0._scrollrect.onUpdateItem(arg_4_0, arg_4_1)
		arg_2_0:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	setText(arg_2_0._tf:Find("frame/public/Text"), i18n("island_public_invitation"))
	setText(arg_2_0._tf:Find("frame/onkey/Text"), i18n("island_onekey_invitation"))

	return
end

function var_0_0.OnInit(arg_5_0)
	onButton(arg_5_0, arg_5_0._tf, function()
		arg_5_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.closeBtn, function()
		arg_5_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.shareBtn, function()
		arg_5_0:DoShare()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.onkeyBtn, function()
		arg_5_0:OnOneKey()

		return
	end, SFX_PANEL)

	arg_5_0.cards = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0.toggles) do
		local var_5_0 = arg_5_0.texts[iter_5_0]
		local var_5_1 = arg_5_0.names[iter_5_0]

		onToggle(arg_5_0, iter_5_1, function(arg_10_0)
			if arg_10_0 then
				arg_5_0:SwitchPage(iter_5_0)
			end

			local var_10_0 = var_5_0

			var_10_0.text = arg_10_0 and setColorStr(var_5_1, "#FEFEFE") or setColorStr(var_5_1, "#6B6E75")

			return
		end, SFX_PANEL)

		arg_5_0.texts[iter_5_0].text = setColorStr(arg_5_0.names[iter_5_0], "#6B6E75")
	end

	return
end

function var_0_0.DoShare(arg_11_0)
	if arg_11_0:GetIsland():GetAccessAgency():HasOpenFlag(IslandConst.OPEN_SIGNIN) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_public_invitation_1"))

		return
	end

	arg_11_0:emit(IslandMediator.SHARE_SIGNIN)

	return
end

function var_0_0.OnOneKey(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.displays) do
		table.insert({}, iter_12_1.id)
	end

	arg_12_0:emit(IslandMediator.SIGN_IN_INVITATION, {})

	return
end

function var_0_0.AddListeners(arg_13_0)
	arg_13_0:AddListener(GAME.ISLAND_SIGN_IN_INVITATION_DONE, arg_13_0.OnInvitation)
	arg_13_0:AddListener(GAME.ISLAND_SIGN_SHARE_SIGNIN_DONE, arg_13_0.OnShare)

	return
end

function var_0_0.RemoveListeners(arg_14_0)
	arg_14_0:RemoveListener(GAME.ISLAND_SIGN_IN_INVITATION_DONE, arg_14_0.OnInvitation)
	arg_14_0:RemoveListener(GAME.ISLAND_SIGN_SHARE_SIGNIN_DONE, arg_14_0.OnShare)

	return
end

function var_0_0.OnInvitation(arg_15_0)
	arg_15_0:FlushList()

	return
end

function var_0_0.OnShare(arg_16_0)
	return
end

function var_0_0.GetDisplayData(arg_17_0, arg_17_1)
	local var_17_0 = {}

	if arg_17_1 == var_0_1 then
		var_17_0 = getProxy(FriendProxy):getAllFriends()
	elseif arg_17_1 == var_0_2 then
		local var_17_1 = getProxy(GuildProxy):getRawData()

		var_17_0 = var_17_1 and var_17_1:getSortMemberWithoutSelf() or {}
	end

	return var_17_0
end

function var_0_0.SwitchPage(arg_18_0, arg_18_1)
	arg_18_0.pageIndex = arg_18_1

	arg_18_0:FlushList()

	return
end

function var_0_0.OnInitItem(arg_19_0, arg_19_1)
	local var_19_0 = IslandSignInInvitationCard.New(arg_19_1)

	onButton(arg_19_0, var_19_0.btn, function()
		arg_19_0:DoInvitation(var_19_0)

		return
	end, SFX_PANEL)

	arg_19_0.cards[arg_19_1] = var_19_0

	return
end

function var_0_0.DoInvitation(arg_21_0, arg_21_1)
	arg_21_0:emit(IslandMediator.SIGN_IN_INVITATION, {
		arg_21_1.player.id
	})

	return
end

function var_0_0.OnUpdateItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.cards[arg_22_2]

	if not arg_22_0.cards[arg_22_2] then
		arg_22_0:OnInitItem(arg_22_2)

		var_22_0 = arg_22_0.cards[arg_22_2]
	end

	local var_22_1 = arg_22_0:GetIsland():GetSignInAgency()

	var_22_0:Update(arg_22_0.displays[arg_22_1 + 1], (var_22_1:IsInvited(arg_22_0.displays[arg_22_1 + 1].id)))

	return
end

function var_0_0.Show(arg_23_0)
	var_0_0.super.Show(arg_23_0)
	triggerToggle(arg_23_0.toggles[var_0_1], true)

	return
end

function var_0_0.FlushList(arg_24_0)
	arg_24_0.displays = arg_24_0:GetDisplayData(arg_24_0.pageIndex)

	arg_24_0._scrollrect:SetTotalCount(#arg_24_0.displays)

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
