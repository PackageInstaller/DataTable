class = var_0_10000

local var_0_0 = var_0_10000("TrophyDetailPanel")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._parent = arg_1_2
	pg = var_3

	var_3.DelegateInfo.New(arg_1_0)

	findTF = var_3
	arg_1_0._medalIcon = var_3(arg_1_0._tf, "center/medalBG/icon")
	findTF = var_3
	arg_1_0._nameLabel = var_3(arg_1_0._tf, "center/name")
	findTF = var_3

	local var_1_0 = var_3(arg_1_0._tf, "center/timeStamp/Text")
	local var_1_1 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0._timeStamp = var_1_1(var_1_0, var_6(var_1_10008))
	findTF = var_3

	local var_1_2 = var_3(arg_1_0._tf, "center/desc/Text")
	local var_1_3 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0._desc = var_1_3(var_1_2, var_6(var_1_10008))
	findTF = var_3
	arg_1_0._progressBar = var_3(arg_1_0._tf, "center/progress_bar/progress")
	findTF = var_3

	local var_1_4 = var_3(arg_1_0._tf, "center/rank/Text")
	local var_1_5 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0._rank = var_1_5(var_1_4, var_6(var_1_10008))
	findTF = var_3
	arg_1_0._lock = var_3(arg_1_0._tf, "center/medalBG/lock")
	findTF = var_3
	arg_1_0._conditionList = var_3(arg_1_0._tf, "center/conditions/container")
	findTF = var_3
	arg_1_0._conditionTpl = var_3(arg_1_0._tf, "center/conditions/condition_tpl")
	onButton = var_3

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0._go

	local function var_1_8()
		local var_2_0 = arg_1_0

		var_0.SetActive(var_2_0, false)

		return
	end

	SFX_CANCEL = var_1_10008

	var_3(var_1_6, var_1_7, var_1_8, var_1_10008)

	findTF = var_3
	arg_1_0._stepper = var_3(arg_1_0._tf, "center/stepper")
	findTF = var_3
	arg_1_0._preTrophyBtn = var_3(arg_1_0._stepper, "pre")
	findTF = var_3
	arg_1_0._postTrophyBtn = var_3(arg_1_0._stepper, "post")
	findTF = var_3
	arg_1_0._pageText = var_3(arg_1_0._stepper, "page")
	findTF = var_3
	arg_1_0._backTipsText = var_3(arg_1_0._tf, "center/backTips/GameObject (1)")
	setText = var_3

	local var_1_9 = arg_1_0._backTipsText

	i18n = var_6

	var_3(var_1_9, var_6("world_collection_back"))

	onButton = var_3

	var_3(arg_1_0, arg_1_0._postTrophyBtn, function()
		local var_3_0 = arg_1_0._trophyGroup
		local var_3_1 = var_0.getPostTrophy(var_3_0, arg_1_0._trophy)
		local var_3_2 = arg_1_0

		var_1.UpdateTrophy(var_3_2, var_3_1)

		return
	end)

	onButton = var_3

	var_3(arg_1_0, arg_1_0._preTrophyBtn, function()
		local var_4_0 = arg_1_0._trophyGroup
		local var_4_1 = var_0.getPreTrophy(var_4_0, arg_1_0._trophy)
		local var_4_2 = arg_1_0

		var_1.UpdateTrophy(var_4_2, var_4_1)

		return
	end)

	arg_1_0._active = false

	return
end

function var_0_0.SetTrophyGroup(arg_5_0, arg_5_1)
	arg_5_0._trophyGroup = arg_5_1

	return
end

function var_0_0.UpdateTrophy(arg_6_0, arg_6_1)
	if arg_6_1 == nil then
		return
	end

	arg_6_0._trophy = arg_6_1
	arg_6_0._rank.text = arg_6_1:getConfig("rank")
	arg_6_0._desc.text = arg_6_1:getConfig("desc")

	local var_6_1

	if arg_6_1:isClaimed() then
		pg = var_6_1

		local var_6_0 = var_6_1.TimeMgr.GetInstance()

		var_6_1 = var_6_1.STimeDescS(var_6_0, arg_6_1.timestamp, "*t")
		arg_6_0._timeStamp.text = var_6_1.year .. "/" .. var_6_1.month .. "/" .. var_6_1.day
	else
		var_6_1 = arg_6_0._timeStamp
		var_6_1.text = "-"
	end

	removeAllChildren = var_6_1

	var_6_1(arg_6_0._conditionList)

	LoadImageSpriteAsync = var_6_1

	var_6_1("medal/" .. arg_6_1:getConfig("icon"), arg_6_0._medalIcon, true)

	SetActive = var_6_1

	var_6_1(arg_6_0._lock, not arg_6_1:isClaimed())

	LoadImageSpriteAsync = var_6_1

	var_6_1("medal/" .. arg_6_1:getConfig("label"), arg_6_0._nameLabel, true)

	local function var_6_2(arg_7_0, arg_7_1)
		setText = var_2_10002
		findTF = var_2_10004

		var_2_10002(var_2_10004(arg_7_0, "desc"), arg_7_1:getConfig("condition"))

		local var_7_0, var_7_1 = arg_7_1:getProgress()
		local var_7_2 = arg_7_1
		local var_7_3 = arg_7_1.getTargetType(var_7_2)

		Trophy = var_5

		if var_7_3 == var_5.INTAMACT_TYPE then
			setText = var_7_3
			findTF = var_7_2
			var_7_2 = var_7_2(arg_7_0, "progress")

			local var_7_4

			if arg_7_1:isDummy() then
				var_7_4 = ""
			else
				var_7_4 = "["
				math = var_8

				local var_7_5 = var_8.modf(var_7_0 / 100)
				local var_7_6 = "/"

				math = var_10
				var_7_4 = var_7_4 .. var_7_5 .. var_7_6 .. var_10.modf(var_7_1 / 100) .. "]"
			end

			var_7_3(var_7_2, var_7_4)
		else
			setText = var_7_3
			findTF = var_7_2

			var_7_3(var_7_2(arg_7_0, "progress"), arg_7_1:isDummy() and "" or "[" .. var_7_0 .. "/" .. var_7_1 .. "]")
		end

		return
	end

	local var_6_3

	if not arg_6_1:isComplexTrophy() then
		cloneTplTo = var_6_3
		var_6_3 = var_6_3(arg_6_0._conditionTpl, arg_6_0._conditionList)

		var_6_2(var_6_3, arg_6_1)
	else
		pairs = var_6_3

		for iter_6_0, iter_6_1 in var_6_3(arg_6_1:getSubTrophy()) do
			cloneTplTo = var_6_4

			local var_6_4 = var_6_4(arg_6_0._conditionTpl, arg_6_0._conditionList)

			var_6_2(var_6_4, iter_6_1)
		end
	end

	local var_6_5 = arg_6_0._progressBar
	local var_6_6 = var_3.GetComponent

	typeof = iter_6_0
	Image = var_6_4
	var_6_6(var_6_5, iter_6_0(var_6_4)).fillAmount = arg_6_1:getProgressRate()

	arg_6_0:updateStepper(arg_6_1)

	return
end

function var_0_0.updateStepper(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._trophyGroup
	local var_8_1 = var_2.getTrophyIndex(var_8_0, arg_8_0._trophy)
	local var_8_2 = arg_8_0._trophyGroup
	local var_8_3 = var_3.getTrophyCount(var_8_2)

	setText = var_8_0

	var_8_0(arg_8_0._pageText, var_8_1 .. "/" .. var_8_3)

	return
end

function var_0_0.SetActive(arg_9_0, arg_9_1)
	SetActive = var_1_10002

	var_1_10002(arg_9_0._go, arg_9_1)

	arg_9_0._active = arg_9_1

	if arg_9_1 then
		pg = var_1_10002

		local var_9_0 = var_1_10002.UIMgr.GetInstance()

		var_1_10002.BlurPanel(var_9_0, arg_9_0._go)
	else
		pg = var_1_10002

		local var_9_1 = var_1_10002.UIMgr.GetInstance()

		var_2.UnOverlayPanel(var_9_1, arg_9_0._go, arg_9_0._parent)
	end

	return
end

function var_0_0.IsActive(arg_10_0)
	return arg_10_0._active
end

function var_0_0.Dispose(arg_11_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_11_0)

	return
end

return var_0_0
