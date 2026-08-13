class = var_0_10000

local var_0_0 = var_0_10000("PtAwardWindow")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0.binder = arg_1_2

	local var_1_0 = arg_1_0._tf

	arg_1_0.scrollPanel = var_3.Find(var_1_0, "window/panel")
	UIItemList = var_3

	local var_1_1 = var_3.New
	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_5.Find(var_1_2, "window/panel/list")
	local var_1_4 = arg_1_0._tf

	arg_1_0.UIlist = var_1_1(var_1_3, var_6.Find(var_1_4, "window/panel/list/item"))

	local var_1_5 = arg_1_0._tf

	arg_1_0.ptTF = var_3.Find(var_1_5, "window/pt")

	local var_1_6 = arg_1_0._tf
	local var_1_7 = var_3.Find(var_1_6, "window/pt/Text")
	local var_1_8 = var_3.GetComponent

	typeof = var_6
	Text = var_1_4
	arg_1_0.totalTxt = var_1_8(var_1_7, var_6(var_1_4))

	local var_1_9 = arg_1_0._tf
	local var_1_10 = var_3.Find(var_1_9, "window/pt/title")
	local var_1_11 = var_3.GetComponent

	typeof = var_6
	Text = var_1_4
	arg_1_0.totalTitleTxt = var_1_11(var_1_10, var_6(var_1_4))

	local var_1_12 = arg_1_0._tf
	local var_1_13 = var_3.Find(var_1_12, "window/pt/icon/image")
	local var_1_14 = var_3.GetComponent

	typeof = var_6
	Image = var_1_4
	arg_1_0.totalTitleIcon = var_1_14(var_1_13, var_6(var_1_4))

	local var_1_15 = arg_1_0._tf

	arg_1_0.closeBtn = var_3.Find(var_1_15, "window/top/btnBack")

	local var_1_16 = arg_1_0._tf

	arg_1_0.ptIcon = var_3.Find(var_1_16, "window/pt/icon")
	onButton = var_3

	local var_1_17 = arg_1_0.binder
	local var_1_18 = arg_1_0._tf

	local function var_1_19()
		local var_2_0 = arg_1_0

		var_0.Hide(var_2_0)

		return
	end

	SFX_PANEL = var_1_4

	var_3(var_1_17, var_1_18, var_1_19, var_1_4)

	onButton = var_3

	local var_1_20 = arg_1_0.binder
	local var_1_21 = arg_1_0.closeBtn

	local function var_1_22()
		local var_3_0 = arg_1_0

		var_0.Hide(var_3_0)

		return
	end

	SFX_PANEL = var_1_4

	var_3(var_1_20, var_1_21, var_1_22, var_1_4)

	return
end

function var_0_0.UpdateList(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	assert = var_1_10005

	var_1_10005(#arg_4_1 == #arg_4_2)

	local var_4_0 = arg_4_0.UIlist

	var_5.make(var_4_0, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_4_1[arg_5_1 + 1]
			local var_5_1 = arg_4_2[arg_5_1 + 1]

			GetPerceptualSize = var_5

			local var_5_2 = var_5(arg_4_0.resTitle)

			setText = var_2_10006

			var_2_10006(arg_5_2:Find("title/Text"), "PHASE " .. arg_5_1 + 1)

			setText = var_2_10006

			var_2_10006(arg_5_2:Find("target/Text"), var_5_1)

			local var_5_3

			if arg_5_2:Find("target/icon") then
				if arg_4_0.resIcon == "" then
					var_5_3 = arg_4_0
					var_5_3.resIcon = nil
				end

				if arg_4_0.resIcon then
					LoadImageSpriteAsync = var_5_3

					var_5_3(arg_4_0.resIcon, arg_5_2:Find("target/icon"), false)
				end

				setActive = var_5_3

				var_5_3(arg_5_2:Find("target/icon"), arg_4_0.resIcon)

				setActive = var_5_3

				var_5_3(arg_5_2:Find("target/mark"), arg_4_0.resIcon)
			end

			setText = var_5_3

			var_5_3(arg_5_2:Find("target/title"), arg_4_0.resTitle)

			Drop = var_5_3

			local var_5_4 = var_5_3.Create(var_5_0)

			updateDrop = var_7

			var_7(arg_5_2:Find("award"), var_5_4, {
				hideName = true
			})

			onButton = var_7

			local var_5_5 = arg_4_0.binder
			local var_5_6 = arg_5_2
			local var_5_7 = arg_5_2.Find(var_5_6, "award")

			local function var_5_8()
				local var_6_0 = arg_4_0.binder
				local var_6_1 = var_0.emit

				BaseUI = var_3_10003

				var_6_1(var_6_0, var_3_10003.ON_DROP, var_5_4)

				return
			end

			SFX_PANEL = var_5_6

			var_7(var_5_5, var_5_7, var_5_8, var_5_6)

			setActive = var_7

			var_7(arg_5_2:Find("award/mask"), arg_5_1 + 1 <= arg_4_3)

			IsNil = var_7

			if not var_7(arg_5_2:Find("mask")) then
				local var_5_9

				if arg_4_4 then
					pg = var_5_9
					var_5_9 = var_5_9.TimeMgr.GetInstance()

					local var_5_10 = arg_4_4[arg_5_1 + 1]

					setActive = var_9

					var_9(arg_5_2:Find("mask"), var_5_10 > var_5_9:GetServerTime())

					local var_5_11 = var_5_9
					local var_5_12 = var_5_9.STimeDescS(var_5_11, var_5_10, "%m")
					local var_5_13 = var_5_9:STimeDescS(var_5_10, "%d")

					setText = var_5_11

					local var_5_14 = arg_5_2:Find("mask/Text")

					i18n = var_14

					var_5_11(var_5_14, var_14("unlock_date_tip", var_5_12, var_5_13))
				else
					setActive = var_5_9

					var_5_9(arg_5_2:Find("mask"), false)
				end
			end
		end

		return
	end)

	local var_4_1 = arg_4_0.UIlist

	var_5.align(var_4_1, #arg_4_1)

	scrollTo = var_5

	var_5(arg_4_0.scrollPanel, 0, 1 - arg_4_3 * 166 / (#arg_4_2 * 166 + 20 - 570))

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.dropList
	local var_7_1 = arg_7_1.targets
	local var_7_2 = arg_7_1.level
	local var_7_3 = arg_7_1.count
	local var_7_4 = arg_7_1.resId
	local var_7_5 = arg_7_1.type

	arg_7_0.blur = arg_7_1.blur

	local var_7_6 = arg_7_1.unlockStamps

	arg_7_0.resIcon = nil

	arg_7_0:UpdateTitle(var_7_5)
	arg_7_0:updateResIcon(arg_7_1.resId, arg_7_1.resIcon, arg_7_1.type)
	arg_7_0:UpdateList(var_7_0, var_7_1, var_7_2, var_7_6)

	arg_7_0.totalTxt.text = var_7_3

	local var_7_7 = arg_7_0.totalTitleTxt

	var_7_7.text = arg_7_0.cntTitle
	Canvas = var_7_7

	var_7_7.ForceUpdateCanvases()

	setActive = var_9

	var_9(arg_7_0._tf, true)

	if arg_7_0.blur then
		pg = var_9

		local var_7_8 = var_9.UIMgr.GetInstance()

		var_9.BlurPanel(var_7_8, arg_7_0._tf)
	end

	return
end

function var_0_0.UpdateTitle(arg_8_0, arg_8_1)
	local var_8_0 = ""

	if arg_8_1 == 2 then
		i18n = var_1_10003
		var_1_10003 = var_1_10003("pt_cosume", var_8_0)
		i18n = var_1_10004

		local var_8_1 = "pt_total_count"

		i18n = var_1_10007
		arg_8_0.cntTitle = var_1_10004(var_8_1, var_1_10007("pt_cosume", var_8_0))
		arg_8_0.resTitle = var_1_10003
		string = var_1_10003
		arg_8_0.cntTitle = var_1_10003.gsub(arg_8_0.cntTitle, "：", "")
	elseif arg_8_1 == 3 then
		i18n = var_1_10003
		var_1_10003 = var_1_10003("pt_ship_goal")
		i18n = var_1_10004
		arg_8_0.cntTitle = var_1_10004("pt_ship_now")
		arg_8_0.resTitle = var_1_10003
	elseif arg_8_1 == 4 then
		i18n = var_1_10003
		var_1_10003 = var_1_10003("cumulative_victory_target_tip")
		i18n = var_1_10004
		arg_8_0.cntTitle = var_1_10004("cumulative_victory_now_tip")
		arg_8_0.resTitle = var_1_10003
	elseif arg_8_1 == 5 then
		i18n = var_1_10003
		var_1_10003 = var_1_10003("npcfriendly_count")
		i18n = var_1_10004
		arg_8_0.cntTitle = var_1_10004("npcfriendly_total_count")
		arg_8_0.resTitle = var_1_10003
	elseif arg_8_1 == 6 then
		i18n = var_1_10003
		var_1_10003 = var_1_10003("activity_yanhua_tip2")
		i18n = var_1_10004
		arg_8_0.cntTitle = var_1_10004("activity_yanhua_tip3")
		arg_8_0.resTitle = var_1_10003
	else
		i18n = var_1_10003

		local var_8_2 = var_1_10003("target_get_tip")

		i18n = var_1_10004
		arg_8_0.cntTitle = var_1_10004("pt_total_count", var_8_0)
		arg_8_0.resTitle = var_8_2
		string = var_8_2
		arg_8_0.cntTitle = var_8_2.gsub(arg_8_0.cntTitle, "：", "")
	end

	return
end

function var_0_0.updateResIcon(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3 == 2 or arg_9_3 ~= 3 and arg_9_3 ~= 4 and arg_9_3 ~= 5 and arg_9_3 ~= 6 then
		if arg_9_1 then
			Drop = var_1_10004
			var_1_10004 = var_1_10004.New

			local var_9_0 = {}

			DROP_TYPE_RESOURCE = var_1_10007
			var_9_0.type = var_1_10007
			var_9_0.id = arg_9_1

			local var_9_1 = var_1_10004(var_9_0)

			arg_9_0.resIcon = var_1_10004.getIcon(var_9_1)
		elseif arg_9_2 then
			arg_9_0.resIcon = arg_9_2
		end

		if arg_9_0.ptIcon and arg_9_0.resIcon and arg_9_0.resIcon ~= "" then
			setActive = var_1_10004

			var_1_10004(arg_9_0.ptIcon, true)

			LoadImageSpriteAsync = var_1_10004

			var_1_10004(arg_9_0.resIcon, arg_9_0.totalTitleIcon, false)
		else
			setActive = var_1_10004

			var_1_10004(arg_9_0.ptIcon, false)
		end
	else
		setActive = var_1_10004

		var_1_10004(arg_9_0.ptIcon, false)
	end

	return
end

function var_0_0.Hide(arg_10_0)
	if arg_10_0.blur then
		pg = var_1

		local var_10_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_10_0, arg_10_0._tf)
	end

	setActive = var_1

	var_1(arg_10_0._tf, false)

	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:Hide()

	removeOnButton = var_1

	var_1(arg_11_0._tf)

	removeOnButton = var_1

	var_1(arg_11_0.closeBtn)

	return
end

return var_0_0
