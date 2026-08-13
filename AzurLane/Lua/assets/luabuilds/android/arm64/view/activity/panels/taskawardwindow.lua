class = var_0_10000

local var_0_0 = "TaskAwardWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".PtAwardWindow"))

local function var_0_2(arg_1_0)
	_ = var_1_10001

	local var_1_0 = var_1_10001.flatten(arg_1_0.tasklist)

	local function var_1_1(arg_2_0)
		ipairs = var_2_10001

		for iter_2_0, iter_2_1 in var_2_10001(arg_1_0.tasklist) do
			type = var_2_10006

			if var_2_10006(iter_2_1) == "table" then
				ipairs = var_2_10006

				for iter_2_2, iter_2_3 in var_2_10006(iter_2_1) do
					if iter_2_3 == arg_2_0 then
						return iter_2_0
					end
				end
			elseif arg_2_0 == iter_2_1 then
				return iter_2_0
			end
		end

		return
	end

	getProxy = var_3
	TaskProxy = var_1_10005

	local var_1_2 = var_3(var_1_10005)
	local var_1_3

	for iter_1_0 = #var_1_0, 1, -1 do
		local var_1_4 = var_1_0[iter_1_0]

		if var_1_2:getFinishTaskById(var_1_4) and var_10:isReceive() then
			var_1_3 = var_1_4
		end
	end

	var_1_3 = var_1_3 or var_1_0[(arg_1_0.index - 1) * 2 + 1]

	local var_1_5 = arg_1_0.UIlist

	var_5.make(var_1_5, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = var_1_0[arg_3_1 + 1]
			local var_3_1 = var_1_2
			local var_3_2

			if not var_4.getTaskById(var_3_1, var_3_0) then
				var_3_1 = var_1_2

				if not var_3_2.getFinishTaskById(var_3_1, var_3_0) then
					Task = var_3_2
					var_3_2 = var_3_2.New({
						id = var_3_0
					})
				end
			end

			GetPerceptualSize = var_2_10005

			local var_3_3 = var_2_10005(var_3_2:getConfig("name"))

			setText = var_3_1

			var_3_1(arg_3_2:Find("title/Text"), "PHASE " .. var_1_1(var_3_0))

			setText = var_3_1

			var_3_1(arg_3_2:Find("target/title"), var_3_2:getConfig("name"))

			setText = var_3_1

			var_3_1(arg_3_2:Find("target/Text"), "")

			if arg_3_2:Find("target/icon") then
				if arg_1_0.resIcon == "" then
					arg_1_0.resIcon = nil
				end

				if arg_1_0.resIcon then
					LoadImageSpriteAsync = var_6

					var_6(arg_1_0.resIcon, arg_3_2:Find("target/icon"), false)
				end

				setActive = var_6

				var_6(arg_3_2:Find("target/icon"), arg_1_0.resIcon)

				setActive = var_6

				var_6(arg_3_2:Find("target/mark"), arg_1_0.resIcon)
			end

			local var_3_4 = var_3_2:getConfig("award_display")[1]
			local var_3_5 = {
				type = var_3_4[1],
				id = var_3_4[2],
				count = var_3_4[3]
			}

			updateDrop = var_8

			var_8(arg_3_2:Find("award"), var_3_5)

			onButton = var_8

			local var_3_6 = arg_1_0.binder
			local var_3_7 = arg_3_2
			local var_3_8 = arg_3_2.Find(var_3_7, "award")

			local function var_3_9()
				local var_4_0 = arg_1_0.binder
				local var_4_1 = var_0.emit

				BaseUI = var_3_10003

				var_4_1(var_4_0, var_3_10003.ON_DROP, var_3_5)

				return
			end

			SFX_PANEL = var_3_7

			var_8(var_3_6, var_3_8, var_3_9, var_3_7)

			local var_3_10

			if var_1_3 then
				var_3_10 = var_3_0 < var_1_3
			end

			setActive = var_9

			local var_3_11 = arg_3_2:Find("award/mask")
			local var_3_12

			if not var_3_2:isReceive() then
				var_3_12 = var_3_10
			end

			var_9(var_3_11, var_3_12)
		end

		return
	end)

	local var_1_6 = arg_1_0.UIlist

	var_5.align(var_1_6, #var_1_0)

	return
end

function var_0_1.Show(arg_5_0, arg_5_1)
	arg_5_0.tasklist = arg_5_1.tasklist
	arg_5_0.ptId = arg_5_1.ptId
	arg_5_0.totalPt = arg_5_1.totalPt

	local var_5_0

	if not arg_5_1.index then
		var_5_0 = 1
	end

	arg_5_0.index = var_5_0
	arg_5_0.blur = arg_5_1.blur

	arg_5_0:updateResIcon(arg_5_1.resId, arg_5_1.resIcon, arg_5_1.type)
	var_0_2(arg_5_0)

	arg_5_0.totalTxt.text = arg_5_0.totalPt

	local var_5_1 = arg_5_0.totalTitleTxt

	i18n = var_3
	var_5_1.text = var_3("award_window_pt_title")
	setActive = var_5_1

	var_5_1(arg_5_0._tf, true)

	if arg_5_0.blur then
		pg = var_2

		local var_5_2 = var_2.UIMgr.GetInstance()

		var_2.BlurPanel(var_5_2, arg_5_0._tf)
	end

	return
end

return var_0_1
