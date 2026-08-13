class = var_0_10000

local var_0_0 = "FriendInfoLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "FriendInfoUI"
end

function var_0_1.setFriend(arg_2_0, arg_2_1)
	arg_2_0.friend = arg_2_1

	return
end

function var_0_1.setFriendProxy(arg_3_0, arg_3_1)
	arg_3_0.friendProxy = arg_3_1

	return
end

function var_0_1.GetBtnTags(arg_4_0)
	return {
		"OPEN_RESUME",
		"OPEND_FRIEND",
		"OPEN_BACKYARD",
		"TOGGLE_BLACK",
		"OPEN_INFORM",
		"OPEN_ISLAND_CARD"
	}
end

function var_0_1.init(arg_5_0)
	arg_5_0:OverlayPanel(arg_5_0._tf)

	local var_5_0 = arg_5_0._tf

	arg_5_0.frame = var_1.Find(var_5_0, "frame")

	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_1.Find(var_5_1, "frame/left_bg/icon_bg/frame/icon")
	local var_5_3 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_5_0.iconTF = var_5_3(var_5_2, var_4(var_1_10006))

	local var_5_4 = arg_5_0._tf

	arg_5_0.starsTF = var_1.Find(var_5_4, "frame/left_bg/icon_bg/stars")

	local var_5_5 = arg_5_0._tf

	arg_5_0.starTF = var_1.Find(var_5_5, "frame/left_bg/icon_bg/stars/star")

	local var_5_6 = arg_5_0._tf
	local var_5_7 = var_1.Find(var_5_6, "frame/left_bg/name_bg/Text")
	local var_5_8 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_5_0.playerNameTF = var_5_8(var_5_7, var_4(var_1_10006))

	local var_5_9 = arg_5_0._tf
	local var_5_10 = var_1.Find(var_5_9, "frame/left_bg/icon_bg/lv/Text")
	local var_5_11 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_5_0.levelTF = var_5_11(var_5_10, var_4(var_1_10006))

	local var_5_12 = arg_5_0._tf

	arg_5_0.resumeEmblem = var_1.Find(var_5_12, "frame/left_bg/emblem")

	local var_5_13 = arg_5_0._tf
	local var_5_14 = var_1.Find(var_5_13, "frame/left_bg/emblem/Text")
	local var_5_15 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_5_0.resumeRank = var_5_15(var_5_14, var_4(var_1_10006))

	local var_5_16 = arg_5_0._tf

	arg_5_0.informPanel = var_1.Find(var_5_16, "inform_panel")

	local var_5_17 = arg_5_0._tf

	arg_5_0.toggleTpl = var_1.Find(var_5_17, "inform_panel/frame/window/main/Toggle")

	local var_5_18 = arg_5_0._tf

	arg_5_0.buttonTpl = var_1.Find(var_5_18, "inform_panel/frame/window/main/button")

	local var_5_19 = arg_5_0._tf

	arg_5_0.toggleContainer = var_1.Find(var_5_19, "inform_panel/frame/window/main/toggles")

	local var_5_20 = arg_5_0.informPanel

	arg_5_0.confirmBtn = var_1.Find(var_5_20, "frame/window/buttons/confirm_btn")

	local var_5_21 = arg_5_0.informPanel

	arg_5_0.cancelBtn = var_1.Find(var_5_21, "frame/window/buttons/cancel_btn")

	local var_5_22 = arg_5_0._tf

	arg_5_0.backBtn = var_1.Find(var_5_22, "inform_panel/frame/window/top/btnBack")

	local var_5_23 = arg_5_0._tf
	local var_5_24 = var_1.Find(var_5_23, "inform_panel/frame/window/name")
	local var_5_25 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_5_0.nameTF = var_5_25(var_5_24, var_4(var_1_10006))

	if arg_5_0.contextData.pos then
		if arg_5_0.contextData.backyardView then
			local var_5_26 = arg_5_0._tf
			local var_5_27 = var_2.Find(var_5_26, "frame_for_backyard")

			var_5_27.position = arg_5_0.contextData.pos
			Vector3 = var_3
			var_5_27.localPosition = var_3(var_5_27.localPosition.x, var_5_27.localPosition.y, 0)
		else
			arg_5_0.height = arg_5_0._tf.rect.height
			arg_5_0.frame.position = arg_5_0.contextData.pos

			local var_5_28 = arg_5_0.frame.localPosition
			local var_5_29 = -1 * (arg_5_0.height / 2 - arg_5_0.frame.sizeDelta.y) >= var_5_28.y and var_3 or var_5_28.y
			local var_5_30 = arg_5_0.frame

			Vector3 = var_1_10006
			var_5_30.localPosition = var_1_10006(var_5_28.x, var_5_29, 0)
		end
	end

	return
end

function var_0_1.didEnter(arg_6_0)
	arg_6_0:Init()

	onButton = var_1

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0._tf

	local function var_6_2()
		local var_7_0 = arg_6_0

		var_0.emit(var_7_0, var_0_1.ON_CLOSE)

		return
	end

	SOUND_BACK = var_1_10006

	var_1(var_6_0, var_6_1, var_6_2, var_1_10006)

	return
end

function var_0_1.Init(arg_8_0)
	local var_8_0 = arg_8_0.contextData.backyardView

	arg_8_0:initInfo()

	setActive = var_2

	local var_8_1 = arg_8_0._tf

	var_2(var_4.Find(var_8_1, "frame_for_backyard"), var_8_0)

	setActive = var_2

	local var_8_2 = arg_8_0._tf

	var_2(var_4.Find(var_8_2, "frame"), not var_8_0)

	local var_8_3

	if var_8_0 then
		local var_8_4 = arg_8_0._tf

		var_8_3 = var_3.Find(var_8_4, "frame_for_backyard/right_bg")
	else
		local var_8_5 = arg_8_0._tf

		var_8_3 = var_3.Find(var_8_5, "frame/right_bg")
	end

	arg_8_0.btnTFs = {}
	ipairs = var_3

	for iter_8_0, iter_8_1 in var_3(arg_8_0:GetBtnTags()) do
		local var_8_6 = var_8_3:GetChild(iter_8_0 - 1)

		setActive = var_1_10009

		var_1_10009(var_8_6, true)

		onButton = var_1_10009

		var_1_10009(arg_8_0, var_8_6, function()
			if iter_8_1 == "" then
				return
			end

			if iter_8_1 == "OPEN_INFORM" then
				local var_9_0 = arg_8_0.friend.id .. arg_8_0.contextData.msg

				getProxy = var_1
				ChatProxy = var_2_10003

				local var_9_1 = var_1(var_2_10003)

				table = var_2_10002

				if not var_2_10002.contains(var_9_1.informs, var_9_0) then
					local var_9_2 = arg_8_0

					var_2.openInfromPanel(var_9_2)
				else
					pg = var_2

					local var_9_3 = var_2.TipsMgr.GetInstance()
					local var_9_4 = var_2.ShowTips

					i18n = var_5

					var_9_4(var_9_3, var_5("chat_msg_inform"))
				end
			else
				local var_9_5 = arg_8_0
				local var_9_6 = var_0.emit

				FriendInfoMediator = var_2_10003

				var_9_6(var_9_5, var_2_10003[iter_8_1])
			end

			return
		end)

		var_1_10009 = arg_8_0.btnTFs
		var_1_10009[iter_8_0] = var_8_6
	end

	if arg_8_0.btnTFs[6] then
		setActive = var_3

		local var_8_7 = arg_8_0.btnTFs[6]

		LOCK_ISLAND_DISPLAY = iter_8_0

		var_3(var_8_7, not iter_8_0)
	end

	setActive = var_3

	var_3(arg_8_0.btnTFs[5], arg_8_0.contextData.msg)

	setButtonEnabled = var_3

	local var_8_8 = arg_8_0.btnTFs[2]
	local var_8_9 = arg_8_0.friendProxy

	var_3(var_8_8, not var_6.isFriend(var_8_9, arg_8_0.friend.id))
	arg_8_0:updateBlack()

	local var_8_10 = arg_8_0.contextData.form

	NotificationLayer = var_4

	if var_8_10 == var_4.FORM_BATTLE then
		setActive = var_8_10

		var_8_10(arg_8_0.btnTFs[3], false)
	end

	setActive = var_8_10

	local var_8_11 = arg_8_0._tf

	var_8_10(var_5.Find(var_8_11, "frame/left_bg"), false)

	return
end

function var_0_1.openInfromPanel(arg_10_0)
	setActive = var_1_10001

	var_1_10001(arg_10_0.informPanel, true)

	if not arg_10_0.isInitInform then
		arg_10_0.isInitInform = true

		arg_10_0:initInform()
	end

	return
end

function var_0_1.initInform(arg_11_0)
	arg_11_0.informInfoForBackYard = {}

	local var_11_0

	if arg_11_0.contextData.backyardView then
		var_1_10003 = arg_11_0.nameTF
		i18n = var_1_10004
		var_1_10004 = var_1_10004("inform_player", arg_11_0.friend.name)
		i18n = var_1_10005
		var_1_10003.text = var_1_10004 .. var_1_10005("backyard_theme_inform_them", arg_11_0.contextData.msg)
		require = var_1_10003

		local var_11_1 = var_1_10003("ShareCfg.InformForBackYardThemeTemplateCfg")

		ipairs = var_1_10003

		for iter_11_0, iter_11_1 in var_1_10003(var_11_1) do
			cloneTplTo = var_1_10008

			local var_11_2 = var_1_10008(arg_11_0.buttonTpl, arg_11_0.toggleContainer)
			local var_11_3 = var_1_10008.Find(var_11_2, "Label")

			var_9.GetComponent(var_11_3, "Text").text = iter_11_1.content

			local var_11_4 = false

			onButton = var_10

			var_10(arg_11_0, var_1_10008, function()
				var_11_4 = not var_11_4
				setActive = var_0

				local var_12_0 = var_1_10008

				var_0(var_2.Find(var_12_0, "Background/Checkmark"), var_11_4)

				if var_11_4 then
					table = var_0

					var_0.insert(arg_11_0.informInfoForBackYard, iter_11_0)
				else
					table = var_0

					if var_0.contains(arg_11_0.informInfoForBackYard, iter_11_0) then
						table = var_0

						var_0.removebyvalue(arg_11_0.informInfoForBackYard, iter_11_0)
					end
				end

				return
			end)
		end
	else
		var_1_10003 = arg_11_0.nameTF
		i18n = var_1_10004
		var_1_10003.text = var_1_10004("inform_player", arg_11_0.friend.name)
		require = var_1_10003

		local var_11_5 = var_1_10003("ShareCfg.informCfg")

		ipairs = var_1_10003

		for iter_11_2, iter_11_3 in var_1_10003(var_11_5) do
			cloneTplTo = var_1_10008

			local var_11_6 = var_1_10008(arg_11_0.toggleTpl, arg_11_0.toggleContainer)
			local var_11_7 = var_1_10008.Find(var_11_6, "Label")
			local var_11_8 = var_9.GetComponent(var_11_7, "Text")

			var_11_8.text = iter_11_3.content
			onToggle = var_11_8

			var_11_8(arg_11_0, var_1_10008, function(arg_13_0)
				if arg_13_0 then
					arg_11_0.informInfo = iter_11_3.content
				end

				return
			end)
		end
	end

	onButton = var_1_10003

	var_1_10003(arg_11_0, arg_11_0.confirmBtn, function()
		if not arg_11_0.contextData.msg then
			pg = var_0

			local var_14_0 = var_0.TipsMgr.GetInstance()
			local var_14_1 = var_0.ShowTips

			i18n = var_2_10003

			var_14_1(var_14_0, var_2_10003("inform_chat_msg"))

			return
		end

		if var_0 then
			if #arg_11_0.informInfoForBackYard == 0 then
				pg = var_0

				local var_14_2 = var_0.TipsMgr.GetInstance()
				local var_14_3 = var_0.ShowTips

				i18n = var_2_10003

				var_14_3(var_14_2, var_2_10003("inform_select_type"))

				return
			end

			local var_14_4 = arg_11_0
			local var_14_5 = var_0.emit

			FriendInfoMediator = var_2_10003

			var_14_5(var_14_4, var_2_10003.INFORM_BACKYARD, arg_11_0.friend.id, arg_11_0.informInfoForBackYard, arg_11_0.contextData.msg, arg_11_0.friend.name)
		else
			if not arg_11_0.informInfo then
				pg = var_0

				local var_14_6 = var_0.TipsMgr.GetInstance()
				local var_14_7 = var_0.ShowTips

				i18n = var_2_10003

				var_14_7(var_14_6, var_2_10003("inform_select_type"))

				return
			end

			local var_14_8 = arg_11_0
			local var_14_9 = var_0.emit

			FriendInfoMediator = var_2_10003

			var_14_9(var_14_8, var_2_10003.INFORM, arg_11_0.friend.id, arg_11_0.informInfo, arg_11_0.contextData.msg)
		end

		return
	end)

	onButton = var_1_10003

	var_1_10003(arg_11_0, arg_11_0.cancelBtn, function()
		local var_15_0 = arg_11_0

		var_0.closeInfromPanel(var_15_0)

		return
	end)

	onButton = var_1_10003

	var_1_10003(arg_11_0, arg_11_0.backBtn, function()
		local var_16_0 = arg_11_0

		var_0.closeInfromPanel(var_16_0)

		return
	end)

	return
end

function var_0_1.closeInfromPanel(arg_17_0)
	setActive = var_1_10001

	var_1_10001(arg_17_0.informPanel, false)

	arg_17_0.informInfo = nil

	return
end

function var_0_1.initInfo(arg_18_0)
	assert = var_1_10001

	var_1_10001(arg_18_0.friend, "self.friend is nil")

	pg = var_1_10001

	local var_18_0 = var_1_10001.ship_data_statistics[arg_18_0.friend.icon]

	assert = var_2

	var_2(var_18_0, "shipCfg is nil >> id ==" .. arg_18_0.friend.icon)

	pg = var_2

	local var_18_1 = var_2.ship_skin_template[var_18_0.skin_id]

	assert = var_3

	var_3(var_18_1, "skinCfg is nil >> id ==" .. var_18_0.skin_id)

	LoadSpriteAsync = var_3

	var_3("qicon/" .. var_18_1.painting, function(arg_19_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_18_0.iconTF) then
			if not arg_19_0 then
				local var_19_0 = arg_18_0.iconTF

				GetSpriteFromAtlas = var_2_10002
				var_19_0.sprite = var_2_10002("heroicon/unknown", "")
			else
				arg_18_0.iconTF.sprite = arg_19_0
			end
		end

		return
	end)

	for iter_18_0 = arg_18_0.starsTF.childCount, var_18_0.star - 1 do
		cloneTplTo = var_1_10008

		var_1_10008(arg_18_0.starTF, arg_18_0.starsTF)
	end

	for iter_18_1 = 1, var_18_0.star do
		local var_18_2 = arg_18_0.starsTF
		local var_18_3 = var_8.GetChild(var_18_2, iter_18_1 - 1)

		setActive = var_1_10009

		var_1_10009(var_18_3, iter_18_1 <= var_18_0.star)
	end

	arg_18_0.playerNameTF.text = arg_18_0.friend.name

	local var_18_4 = arg_18_0.levelTF

	var_18_4.text = arg_18_0.friend.level
	SeasonInfo = var_18_4

	local var_18_5 = var_18_4.getMilitaryRank(arg_18_0.friend.score, arg_18_0.friend.rank)

	SeasonInfo = var_5

	local var_18_6 = var_5.getEmblem(arg_18_0.friend.score, arg_18_0.friend.rank)

	LoadImageSpriteAsync = var_6

	var_6("emblem/" .. var_18_6, arg_18_0.resumeEmblem)

	return
end

function var_0_1.updateBlack(arg_20_0)
	local var_20_0 = arg_20_0.friendProxy
	local var_20_1 = var_1.getBlackPlayerById(var_20_0, arg_20_0.friend.id) ~= nil

	setActive = var_1_10002
	findTF = var_4

	var_1_10002(var_4(arg_20_0.btnTFs[4], "black"), not var_20_1)

	setActive = var_1_10002
	findTF = var_4

	var_1_10002(var_4(arg_20_0.btnTFs[4], "unblack"), var_20_1)

	return
end

function var_0_1.willExit(arg_21_0)
	return
end

return var_0_1
