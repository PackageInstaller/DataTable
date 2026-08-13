class = var_0_10000

local var_0_0 = "VoteDiaplayPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "VoteDisplay"
end

function var_0_1.OnInit(arg_2_0)
	findTF = var_1_10001
	arg_2_0.paitingTF = var_1_10001(arg_2_0._tf, "painting")
	findTF = var_1

	local var_2_0 = var_1(arg_2_0._tf, "filter_bg/Text")
	local var_2_1 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.numberTxt = var_2_1(var_2_0, var_3(var_1_10004))
	findTF = var_1

	local var_2_2 = var_1(arg_2_0._tf, "frame/bg/name")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTxt = var_2_3(var_2_2, var_3(var_1_10004))
	findTF = var_1

	local var_2_4 = var_1(arg_2_0._tf, "frame/bg/en_name")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.enNameTxt = var_2_5(var_2_4, var_3(var_1_10004))
	findTF = var_1

	local var_2_6 = var_1(arg_2_0._tf, "frame/bg/scroll/desc")
	local var_2_7 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.descTxt = var_2_7(var_2_6, var_3(var_1_10004))
	findTF = var_1

	local var_2_8 = var_1(arg_2_0._tf, "frame/bg/InputField")
	local var_2_9 = var_1.GetComponent

	typeof = var_3
	InputField = var_1_10004
	arg_2_0.valueInput = var_2_9(var_2_8, var_3(var_1_10004))
	findTF = var_1
	arg_2_0.addBtn = var_1(arg_2_0._tf, "frame/bg/add")
	findTF = var_1
	arg_2_0.miunsBtn = var_1(arg_2_0._tf, "frame/bg/miuns")
	findTF = var_1
	arg_2_0.maxBtn = var_1(arg_2_0._tf, "frame/bg/max")
	findTF = var_1
	arg_2_0.submitBtn = var_1(arg_2_0._tf, "frame/bg/submit")
	findTF = var_1

	local var_2_10 = var_1(arg_2_0._tf, "frame/bg/rank")
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.rankTxt = var_2_11(var_2_10, var_3(var_1_10004))
	findTF = var_1

	local var_2_12 = var_1(arg_2_0._tf, "frame/bg/votes")
	local var_2_13 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.votesTxt = var_2_13(var_2_12, var_3(var_1_10004))
	findTF = var_1

	local var_2_14 = var_1(arg_2_0._tf, "frame/bg/shiptype")
	local var_2_15 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.shiptypeTxt = var_2_15(var_2_14, var_3(var_1_10004))
	findTF = var_1

	local var_2_16 = var_1(arg_2_0._tf, "frame/bg/nation")
	local var_2_17 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.nationImg = var_2_17(var_2_16, var_3(var_1_10004))
	findTF = var_1
	arg_2_0.bg1 = var_1(arg_2_0._tf, "frame/bg/bg1")
	findTF = var_1
	arg_2_0.bg2 = var_1(arg_2_0._tf, "frame/bg/bg2")

	return
end

function var_0_1.Open(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_0.callback = arg_3_5
	assert = var_1_10006

	var_1_10006(arg_3_0.callback)

	arg_3_0.maxValue = arg_3_3
	arg_3_0.rank = arg_3_2
	arg_3_0.value = 1
	setActive = var_6

	var_6(arg_3_0.bg1, not arg_3_4)

	setActive = var_6

	var_6(arg_3_0.bg2, arg_3_4)

	arg_3_0.votes = arg_3_4 or "-"
	setActive = var_6

	var_6(arg_3_0._tf, true)

	arg_3_0.numberTxt.text = "X" .. arg_3_3

	if arg_3_1 ~= arg_3_0.voteShip then
		arg_3_0.voteShip = arg_3_1

		arg_3_0:Update(arg_3_1)
	end

	onInputEndEdit = var_6

	local var_3_0 = arg_3_0

	go = var_8

	var_6(var_3_0, var_8(arg_3_0.valueInput), function()
		getInputText = var_2_10000
		go = var_2_10001

		local var_4_0 = var_2_10000(var_2_10001(arg_3_0.valueInput))

		tonumber = var_1

		if var_1(var_4_0) < 1 then
			arg_3_0.value = 1
		elseif var_1 > arg_3_0.maxValue then
			local var_4_1 = arg_3_0

			math = var_2_10003
			var_4_1.value = var_2_10003.max(1, arg_3_0.maxValue)
		else
			arg_3_0.value = var_1
		end

		local var_4_2 = arg_3_0

		var_2.UpdateCnt(var_4_2)

		return
	end)

	pg = var_6

	local var_3_1 = var_6.UIMgr.GetInstance()

	var_6.BlurPanel(var_3_1, arg_3_0._tf)

	return
end

function var_0_1.UpdateCnt(arg_5_0)
	arg_5_0.valueInput.text = arg_5_0.value

	return
end

function var_0_1.Update(arg_6_0, arg_6_1)
	arg_6_0.nameTxt.text = arg_6_1:getShipName()
	arg_6_0.enNameTxt.text = arg_6_1:getEnName()
	arg_6_0.descTxt.text = arg_6_1:GetDesc()
	arg_6_0.votesTxt.text = arg_6_0.votes
	arg_6_0.rankTxt.text = arg_6_0.rank

	local var_6_0 = arg_6_0.shiptypeTxt
	local var_6_1 = arg_6_1

	var_6_0.text = arg_6_1.getShipTypeName(var_6_1)

	local var_6_2 = arg_6_1:getNationality()
	local var_6_3

	if var_6_2 then
		LoadSprite = var_6_1

		local var_6_4 = "prints/"

		nation2print = var_1_10006
		var_6_3 = var_6_1(var_6_4 .. var_1_10006(var_6_2) .. "_0")
	else
		GetSpriteFromAtlas = var_6_1
		var_6_3 = var_6_1("ui/VoteUI_atlas", "nation")
	end

	arg_6_0.nationImg.sprite = var_6_3

	arg_6_0:UpdateCnt()

	onButton = var_4

	var_4(arg_6_0, arg_6_0._tf, function()
		local var_7_0 = arg_6_0

		var_0.Close(var_7_0)

		return
	end)

	onButton = var_4

	local var_6_5 = arg_6_0
	local var_6_6 = arg_6_0.addBtn

	local function var_6_7()
		if arg_6_0.value >= arg_6_0.maxValue then
			return
		end

		arg_6_0.value = arg_6_0.value + 1

		local var_8_0 = arg_6_0

		var_0.UpdateCnt(var_8_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_4(var_6_5, var_6_6, var_6_7, var_1_10008)

	onButton = var_4

	local var_6_8 = arg_6_0
	local var_6_9 = arg_6_0.miunsBtn

	local function var_6_10()
		if arg_6_0.value == 1 then
			return
		end

		arg_6_0.value = arg_6_0.value - 1

		local var_9_0 = arg_6_0

		var_0.UpdateCnt(var_9_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_4(var_6_8, var_6_9, var_6_10, var_1_10008)

	onButton = var_4

	local var_6_11 = arg_6_0
	local var_6_12 = arg_6_0.maxBtn

	local function var_6_13()
		if arg_6_0.maxValue == 0 then
			return
		end

		arg_6_0.value = arg_6_0.maxValue

		local var_10_0 = arg_6_0

		var_0.UpdateCnt(var_10_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_4(var_6_11, var_6_12, var_6_13, var_1_10008)

	onButton = var_4

	local var_6_14 = arg_6_0
	local var_6_15 = arg_6_0.submitBtn

	local function var_6_16()
		arg_6_0.callback(arg_6_0.value)

		local var_11_0 = arg_6_0

		var_0.Close(var_11_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_4(var_6_14, var_6_15, var_6_16, var_1_10008)

	arg_6_0.paintingName = arg_6_1:getPainting()
	LoadPaintingPrefabAsync = var_4

	var_4(arg_6_0.paitingTF, arg_6_0.paintingName, arg_6_0.paintingName, "jiesuan")

	return
end

function var_0_1.Close(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_12_0, arg_12_0._tf, arg_12_0._parent)

	setActive = var_1

	var_1(arg_12_0._tf, false)

	retPaintingPrefab = var_1

	var_1(arg_12_0.paitingTF, arg_12_0.paintingName)

	arg_12_0.callback = nil
	arg_12_0.maxValue = 0
	arg_12_0.rank = 0
	arg_12_0.value = 1
	arg_12_0.voteShip = nil

	return
end

function var_0_1.OnDestroy(arg_13_0)
	arg_13_0:Close()

	return
end

return var_0_1
