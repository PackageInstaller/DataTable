class = var_0_10000

local var_0_0 = "IslandSignInInvitationPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))
local var_0_2 = 1
local var_0_3 = 2

function var_0_1.getUIName(arg_1_0)
	return "IslandSignInInvitationUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.shareBtn = var_1.Find(var_2_0, "frame/public")

	local var_2_1 = arg_2_0._tf

	arg_2_0.onkeyBtn = var_1.Find(var_2_1, "frame/onkey")

	local var_2_2 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_2, "frame/close")

	local var_2_3 = {}
	local var_2_4 = var_0_2
	local var_2_5 = arg_2_0._tf

	var_2_3[var_2_4] = var_3.Find(var_2_5, "frame/toggles/1")

	local var_2_6 = var_0_3
	local var_2_7 = arg_2_0._tf

	var_2_3[var_2_6] = var_3.Find(var_2_7, "frame/toggles/2")
	arg_2_0.toggles = var_2_3

	local var_2_8 = {}
	local var_2_9 = var_0_2
	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_3.Find(var_2_10, "frame/toggles/1/Text")
	local var_2_12 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	var_2_8[var_2_9] = var_2_12(var_2_11, var_6(var_1_10008))

	local var_2_13 = var_0_3
	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_3.Find(var_2_14, "frame/toggles/2/Text")
	local var_2_16 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	var_2_8[var_2_13] = var_2_16(var_2_15, var_6(var_1_10008))
	arg_2_0.texts = var_2_8

	local var_2_17 = {}

	i18n = var_2_13
	var_2_17[1] = var_2_13("island_friend")
	i18n = var_2
	var_2_17[2] = var_2("island_guild")
	arg_2_0.names = var_2_17

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_1.Find(var_2_18, "frame/scrollrect")

	arg_2_0._scrollrect = var_1.GetComponent(var_2_19, "LScrollRect")

	function arg_2_0._scrollrect.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.OnInitItem(var_3_0, arg_3_0)

		return
	end

	local var_2_20 = arg_2_0._scrollrect

	function var_2_20.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	setText = var_2_20

	local var_2_21 = arg_2_0._tf
	local var_2_22 = var_3.Find(var_2_21, "frame/public/Text")

	i18n = var_4

	var_2_20(var_2_22, var_4("island_public_invitation"))

	setText = var_2_20

	local var_2_23 = arg_2_0._tf
	local var_2_24 = var_3.Find(var_2_23, "frame/onkey/Text")

	i18n = var_4

	var_2_20(var_2_24, var_4("island_onekey_invitation"))

	return
end

function var_0_1.OnInit(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10006)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.closeBtn

	local function var_5_5()
		local var_7_0 = arg_5_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10006)

	onButton = var_1_10001

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.shareBtn

	local function var_5_8()
		local var_8_0 = arg_5_0

		var_0.DoShare(var_8_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_6, var_5_7, var_5_8, var_1_10006)

	onButton = var_1_10001

	local var_5_9 = arg_5_0
	local var_5_10 = arg_5_0.onkeyBtn

	local function var_5_11()
		local var_9_0 = arg_5_0

		var_0.OnOneKey(var_9_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_9, var_5_10, var_5_11, var_1_10006)

	arg_5_0.cards = {}
	pairs = var_1

	for iter_5_0, iter_5_1 in var_1(arg_5_0.toggles) do
		local var_5_12 = arg_5_0.texts[iter_5_0]
		local var_5_13 = arg_5_0.names[iter_5_0]

		onToggle = var_1_10008

		local var_5_14 = arg_5_0
		local var_5_15 = iter_5_1

		local function var_5_16(arg_10_0)
			if arg_10_0 then
				local var_10_0 = arg_5_0

				var_1.SwitchPage(var_10_0, iter_5_0)
			end

			local var_10_1 = var_5_12

			if arg_10_0 then
				setColorStr = var_2_10002

				if not var_2_10002(var_5_13, "#FEFEFE") then
					setColorStr = var_2_10002
					var_2_10002 = var_2_10002(var_5_13, "#6B6E75")
				end

				var_10_1.text = var_2_10002

				return
			end
		end

		SFX_PANEL = var_1_10013

		var_1_10008(var_5_14, var_5_15, var_5_16, var_1_10013)

		setColorStr = var_1_10008
		var_5_12.text = var_1_10008(var_5_13, "#6B6E75")
	end

	return
end

function var_0_1.DoShare(arg_11_0)
	local var_11_0 = arg_11_0:GetIsland()
	local var_11_1 = var_1.GetAccessAgency(var_11_0)
	local var_11_2 = var_2.HasOpenFlag

	IslandConst = var_1_10006

	if var_11_2(var_11_1, var_1_10006.OPEN_SIGNIN) then
		pg = var_3

		local var_11_3 = var_3.TipsMgr.GetInstance()
		local var_11_4 = var_3.ShowTips

		i18n = var_6

		var_11_4(var_11_3, var_6("island_public_invitation_1"))

		return
	end

	local var_11_5 = arg_11_0
	local var_11_6 = arg_11_0.emit

	IslandMediator = var_6

	var_11_6(var_11_5, var_6.SHARE_SIGNIN)

	return
end

function var_0_1.OnOneKey(arg_12_0)
	local var_12_0 = {}

	ipairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(arg_12_0.displays) do
		table = var_1_10007

		var_1_10007.insert(var_12_0, iter_12_1.id)
	end

	local var_12_1 = arg_12_0
	local var_12_2 = arg_12_0.emit

	IslandMediator = iter_12_0

	var_12_2(var_12_1, iter_12_0.SIGN_IN_INVITATION, var_12_0)

	return
end

function var_0_1.AddListeners(arg_13_0)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.AddListener

	GAME = var_1_10004

	var_13_1(var_13_0, var_1_10004.ISLAND_SIGN_IN_INVITATION_DONE, arg_13_0.OnInvitation)

	local var_13_2 = arg_13_0
	local var_13_3 = arg_13_0.AddListener

	GAME = var_4

	var_13_3(var_13_2, var_4.ISLAND_SIGN_SHARE_SIGNIN_DONE, arg_13_0.OnShare)

	return
end

function var_0_1.RemoveListeners(arg_14_0)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.RemoveListener

	GAME = var_1_10004

	var_14_1(var_14_0, var_1_10004.ISLAND_SIGN_IN_INVITATION_DONE, arg_14_0.OnInvitation)

	local var_14_2 = arg_14_0
	local var_14_3 = arg_14_0.RemoveListener

	GAME = var_4

	var_14_3(var_14_2, var_4.ISLAND_SIGN_SHARE_SIGNIN_DONE, arg_14_0.OnShare)

	return
end

function var_0_1.OnInvitation(arg_15_0)
	arg_15_0:FlushList()

	return
end

function var_0_1.OnShare(arg_16_0)
	return
end

function var_0_1.GetDisplayData(arg_17_0, arg_17_1)
	local var_17_0 = {}

	if arg_17_1 == var_0_2 then
		getProxy = var_3
		FriendProxy = var_1_10005
		var_1_10005 = var_3(var_1_10005)
		var_17_0 = var_3.getAllFriends(var_1_10005)
	elseif arg_17_1 == var_0_3 then
		getProxy = var_3
		GuildProxy = var_1_10005

		local var_17_1 = var_3(var_1_10005)

		var_17_0 = var_3.getRawData(var_17_1) and var_3:getSortMemberWithoutSelf() or {}
	end

	return var_17_0
end

function var_0_1.SwitchPage(arg_18_0, arg_18_1)
	arg_18_0.pageIndex = arg_18_1

	arg_18_0:FlushList()

	return
end

function var_0_1.OnInitItem(arg_19_0, arg_19_1)
	IslandSignInInvitationCard = var_1_10002

	local var_19_0 = var_1_10002.New(arg_19_1)

	onButton = var_1_10003

	local var_19_1 = arg_19_0
	local var_19_2 = var_19_0.btn

	local function var_19_3()
		local var_20_0 = arg_19_0

		var_0.DoInvitation(var_20_0, var_19_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_19_1, var_19_2, var_19_3, var_1_10008)

	arg_19_0.cards[arg_19_1] = var_19_0

	return
end

function var_0_1.DoInvitation(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.emit

	IslandMediator = var_1_10005

	var_21_1(var_21_0, var_1_10005.SIGN_IN_INVITATION, {
		arg_21_1.player.id
	})

	return
end

function var_0_1.OnUpdateItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0

	if not arg_22_0.cards[arg_22_2] then
		arg_22_0:OnInitItem(arg_22_2)

		var_22_0 = arg_22_0.cards[arg_22_2]
	end

	local var_22_1 = arg_22_0:GetIsland()
	local var_22_2 = arg_22_0.displays[arg_22_1 + 1]
	local var_22_3 = var_22_1:GetSignInAgency()
	local var_22_4 = var_6.IsInvited(var_22_3, var_22_2.id)

	var_22_0:Update(var_22_2, var_22_4)

	return
end

function var_0_1.Show(arg_23_0)
	var_0_1.super.Show(arg_23_0)

	triggerToggle = var_1

	var_1(arg_23_0.toggles[var_0_2], true)

	return
end

function var_0_1.FlushList(arg_24_0)
	arg_24_0.displays = arg_24_0:GetDisplayData(arg_24_0.pageIndex)

	local var_24_0 = arg_24_0._scrollrect

	var_1.SetTotalCount(var_24_0, #arg_24_0.displays)

	return
end

function var_0_1.OnDestroy(arg_25_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_25_0._scrollrect)

	pairs = var_1_10001

	for iter_25_0, iter_25_1 in var_1_10001(arg_25_0.cards) do
		iter_25_1:Dispose()
	end

	arg_25_0.cards = nil

	return
end

return var_0_1
