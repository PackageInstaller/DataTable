class = var_0_10000

local var_0_0 = "GuildApplyRedPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "GuildApplyRedUI"
end

function var_0_1.OnLoaded(arg_2_0)
	findTF = var_1_10001

	local var_2_0 = var_1_10001(arg_2_0._tf, "panel/frame/policy_container/input_frame/shipicon/icon")
	local var_2_1 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.iconTF = var_2_1(var_2_0, var_4(var_1_10006))
	findTF = var_1
	arg_2_0.circle = var_1(arg_2_0._tf, "panel/frame/policy_container/input_frame/shipicon/frame")
	findTF = var_1

	local var_2_2 = var_1(arg_2_0._tf, "panel/frame/policy_container/input_frame/Text")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.manifesto = var_2_3(var_2_2, var_4(var_1_10006))
	findTF = var_1
	arg_2_0.starsTF = var_1(arg_2_0._tf, "panel/frame/policy_container/input_frame/shipicon/stars")
	findTF = var_1
	arg_2_0.starTF = var_1(arg_2_0._tf, "panel/frame/policy_container/input_frame/shipicon/stars/star")
	findTF = var_1
	arg_2_0.applyBtn = var_1(arg_2_0._tf, "panel/frame/confirm_btn")
	findTF = var_1
	arg_2_0.cancelBtn = var_1(arg_2_0._tf, "panel/frame/cancel_btn")
	findTF = var_1

	local var_2_4 = var_1(arg_2_0._tf, "panel/frame/name")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.nameTF = var_2_5(var_2_4, var_4(var_1_10006))
	findTF = var_1

	local var_2_6 = var_1(arg_2_0._tf, "panel/frame/info/level/Text")
	local var_2_7 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.levelTF = var_2_7(var_2_6, var_4(var_1_10006))
	findTF = var_1

	local var_2_8 = var_1(arg_2_0._tf, "panel/frame/info/count/Text")
	local var_2_9 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.countTF = var_2_9(var_2_8, var_4(var_1_10006))
	findTF = var_1

	local var_2_10 = var_1(arg_2_0._tf, "panel/frame/policy_container/name/Text")
	local var_2_11 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.flagName = var_2_11(var_2_10, var_4(var_1_10006))
	findTF = var_1

	local var_2_12 = var_1(arg_2_0._tf, "panel/frame/policy_container/policy/Text")
	local var_2_13 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.policyTF = var_2_13(var_2_12, var_4(var_1_10006))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.applyBtn

	local function var_3_2()
		pg = var_2_10000

		local var_4_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_4_1 = var_0.ShowMsgBox
		local var_4_2 = {
			hideNo = true,
			yesText = "text_confirm",
			limit = 20
		}

		MSGBOX_TYPE_INPUT = var_2_10004
		var_4_2.type = var_2_10004
		i18n = var_2_10004
		var_4_2.placeholder = var_2_10004("guild_request_msg_placeholder")
		i18n = var_4
		var_4_2.title = var_4("guild_request_msg_title")

		function var_4_2.onYes(arg_5_0)
			local var_5_0 = arg_3_0
			local var_5_1 = var_1.emit

			JoinGuildMediator = var_3_10004

			var_5_1(var_5_0, var_3_10004.APPLY, arg_3_0.guildVO.id, arg_5_0)

			return
		end

		var_4_1(var_4_0, var_4_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.cancelBtn

	local function var_3_5()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	arg_7_0.guildVO = arg_7_1

	arg_7_0:UpdateApplyPanel()

	pg = var_2

	local var_7_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_7_0, arg_7_0._tf)
	var_0_1.super.Show(arg_7_0)

	return
end

function var_0_1.UpdateApplyPanel(arg_8_0)
	local var_8_0 = arg_8_0.guildVO

	Ship = var_1_10002

	local var_8_1 = var_1_10002.New({
		configId = var_8_0:getCommader().icon
	})

	LoadSpriteAsync = var_1_10003

	var_1_10003("QIcon/" .. var_8_1:getPainting(), function(arg_9_0)
		arg_8_0.iconTF.sprite = arg_9_0

		return
	end)

	pg = var_1_10003

	local var_8_2 = var_1_10003.ship_data_statistics[var_8_1.configId]

	arg_8_0.manifesto.text = var_8_0.manifesto

	for iter_8_0 = arg_8_0.starsTF.childCount, var_8_2.star - 1 do
		cloneTplTo = var_1_10009

		var_1_10009(arg_8_0.starTF, arg_8_0.starsTF)
	end

	for iter_8_1 = 1, var_4 do
		local var_8_3 = arg_8_0.starsTF
		local var_8_4 = var_9.GetChild(var_8_3, iter_8_1 - 1)

		setActive = var_1_10010

		var_1_10010(var_8_4, iter_8_1 <= var_8_2.star)
	end

	arg_8_0.nameTF.text = var_8_0.name

	local var_8_5 = arg_8_0.levelTF
	local var_8_6

	if not (var_8_0.level < 9) or not ("0" .. var_8_0.level) then
		var_8_6 = var_8_0.level
	end

	var_8_5.text = var_8_6

	local var_8_7 = arg_8_0.countTF
	local var_8_8 = var_8_0.memberCount
	local var_8_9 = "/"
	local var_8_10 = var_8_0

	var_8_7.text = var_8_8 .. var_8_9 .. var_8_0.getMaxMember(var_8_10)
	arg_8_0.flagName.text = var_8_0:getCommader().name
	arg_8_0.policyTF.text = var_8_0:getPolicyName()

	local var_8_11 = var_8_0
	local var_8_12 = var_8_0.getCommader(var_8_11)

	AttireFrame = var_6

	local var_8_13 = var_6.attireFrameRes
	local var_8_14 = var_8_12
	local var_8_15 = var_8_12.id

	getProxy = var_8_10
	PlayerProxy = var_1_10012

	local var_8_16 = var_8_10(var_1_10012)
	local var_8_17 = var_8_15 == var_10.getRawData(var_8_16).id

	AttireConst = var_10

	local var_8_18 = var_8_13(var_8_14, var_8_17, var_10.TYPE_ICON_FRAME, var_8_12.propose)

	PoolMgr = var_8_11

	local var_8_19 = var_8_11.GetInstance()

	var_7.GetPrefab(var_8_19, "IconFrame/" .. var_8_18, var_8_18, true, function(arg_10_0)
		IsNil = var_2_10001

		if var_2_10001(arg_8_0._tf) then
			return
		end

		if arg_8_0.circle then
			arg_10_0.name = var_8_18
			findTF = var_1

			local var_10_0 = var_1(arg_10_0.transform, "icon")
			local var_10_1 = var_1.GetComponent

			typeof = var_2_10005
			Image = var_2_10007
			var_10_1(var_10_0, var_2_10005(var_2_10007)).raycastTarget = false
			setParent = var_3

			var_3(arg_10_0, arg_8_0.circle, false)
		else
			PoolMgr = var_1

			local var_10_2 = var_1.GetInstance()

			var_1.ReturnPrefab(var_10_2, "IconFrame/" .. var_8_18, var_8_18, arg_10_0)
		end

		return
	end)

	return
end

function var_0_1.Hide(arg_11_0)
	var_0_1.super.Hide(arg_11_0)

	pg = var_1

	local var_11_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_11_0, arg_11_0._tf, arg_11_0._parentTf)

	local var_11_1 = arg_11_0.circle.childCount

	if 0 < var_11_1 then
		local var_11_2 = arg_11_0.circle
		local var_11_3 = var_1.GetChild(var_11_2, 0).gameObject

		PoolMgr = var_2

		local var_11_4 = var_2.GetInstance()

		var_2.ReturnPrefab(var_11_4, "IconFrame/" .. var_11_3.name, var_11_3.name, var_11_3)
	end

	return
end

function var_0_1.OnDestroy(arg_12_0)
	if arg_12_0:isShowing() then
		arg_12_0:Hide()
	end

	return
end

return var_0_1
