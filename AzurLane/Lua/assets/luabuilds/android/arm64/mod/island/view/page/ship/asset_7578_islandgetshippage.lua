class = var_0_10000

local var_0_0 = "IslandGetShipPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseShipDisplayPage"))
local var_0_2 = "hi"

function var_0_1.getUIName(arg_1_0)
	return "IslandGetShipUI"
end

function var_0_1.NeedCache(arg_2_0)
	return false
end

function var_0_1.Preload(arg_3_0, arg_3_1, arg_3_2)
	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_4_0)
			local var_4_0 = arg_3_0

			var_1.PlayTimeline(var_4_0, arg_4_0, arg_3_2)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_3_0

			var_1.PrepareCharacterScene(var_5_0, arg_5_0)

			return
		end
	}, function()
		IslandGuideChecker = var_2_10000

		var_2_10000.CheckGuide("ISLAND_GUIDE_12")

		existCall = var_0

		var_0(arg_3_1)

		return
	end)

	return
end

function var_0_1.PlayTimeline(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2:getConfig("unit_id")

	arg_7_0:PlayGetShipTimeline(var_7_0, arg_7_1)

	return
end

function var_0_1.OnLoaded(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.mainPanel = var_1.Find(var_8_0, "main")

	local var_8_1 = arg_8_0._tf

	arg_8_0.radarTr = var_1.Find(var_8_1, "main/rader")

	local var_8_2 = arg_8_0._tf
	local var_8_3 = var_1.Find(var_8_2, "main/rader/Quad")

	arg_8_0.drawPolygon = var_1.GetComponent(var_8_3, "DrawPolygon")

	local var_8_4 = arg_8_0._tf

	arg_8_0.back = var_1.Find(var_8_4, "main/back")

	local var_8_5 = arg_8_0._tf

	arg_8_0.goBtn = var_1.Find(var_8_5, "main/go")

	local var_8_6 = arg_8_0._tf

	arg_8_0.chatTr = var_1.Find(var_8_6, "chat")

	local var_8_7 = arg_8_0._tf
	local var_8_8 = var_1.Find(var_8_7, "chat/Text")
	local var_8_9 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_8_0.chatTxt = var_8_9(var_8_8, var_4(var_1_10006))

	local var_8_10 = arg_8_0._tf
	local var_8_11 = var_1.Find(var_8_10, "main/name")
	local var_8_12 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_8_0.nameTxt = var_8_12(var_8_11, var_4(var_1_10006))

	local var_8_13 = arg_8_0._tf
	local var_8_14 = var_1.Find(var_8_13, "main/en")
	local var_8_15 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_8_0.enNameTxt = var_8_15(var_8_14, var_4(var_1_10006))
	setActive = var_1

	var_1(arg_8_0.chatTr, false)

	local var_8_16 = {}
	local var_8_17 = arg_8_0._tf
	local var_8_18 = var_2.Find(var_8_17, "main/rader/1/Text")
	local var_8_19 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	var_8_16[1] = var_8_19(var_8_18, var_5(var_1_10007))

	local var_8_20 = arg_8_0._tf
	local var_8_21 = var_2.Find(var_8_20, "main/rader/2/Text")
	local var_8_22 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	var_8_16[2] = var_8_22(var_8_21, var_5(var_1_10007))

	local var_8_23 = arg_8_0._tf
	local var_8_24 = var_2.Find(var_8_23, "main/rader/3/Text")
	local var_8_25 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	var_8_16[3] = var_8_25(var_8_24, var_5(var_1_10007))

	local var_8_26 = arg_8_0._tf
	local var_8_27 = var_2.Find(var_8_26, "main/rader/4/Text")
	local var_8_28 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	var_8_16[4] = var_8_28(var_8_27, var_5(var_1_10007))

	local var_8_29 = arg_8_0._tf
	local var_8_30 = var_2.Find(var_8_29, "main/rader/5/Text")
	local var_8_31 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	var_8_16[5] = var_8_31(var_8_30, var_5(var_1_10007))

	local var_8_32 = arg_8_0._tf
	local var_8_33 = var_2.Find(var_8_32, "main/rader/6/Text")
	local var_8_34 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	var_8_16[6] = var_8_34(var_8_33, var_5(var_1_10007))
	arg_8_0.radarTxts = var_8_16

	return
end

function var_0_1.GetActiveCamName(arg_9_0)
	IslandConst = var_1_10001

	return var_1_10001.GET_CHARA_CAMERA_NAME
end

function var_0_1.OnInit(arg_10_0)
	onButton = var_1_10001

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0._tf

	local function var_10_2()
		local var_11_0 = arg_10_0

		var_0.Hide(var_11_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_0, var_10_1, var_10_2, var_1_10006)

	onButton = var_1_10001

	local var_10_3 = arg_10_0
	local var_10_4 = arg_10_0.back

	local function var_10_5()
		local var_12_0 = arg_10_0

		var_0.Hide(var_12_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_3, var_10_4, var_10_5, var_1_10006)

	onButton = var_1_10001

	local var_10_6 = arg_10_0
	local var_10_7 = arg_10_0.goBtn

	local function var_10_8()
		local var_13_0 = arg_10_0

		var_0.Hide(var_13_0)

		local var_13_1 = arg_10_0
		local var_13_2 = var_0.OpenScenePage

		IslandShipMainPage = var_2_10003

		var_13_2(var_13_1, var_2_10003)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_6, var_10_7, var_10_8, var_1_10006)
	arg_10_0:InitRaderTxt()

	return
end

function var_0_1.OnShow(arg_14_0, arg_14_1)
	arg_14_0.ship = arg_14_1
	setActive = var_1_10002

	var_1_10002(arg_14_0.mainPanel, false)

	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.LoadCharacter
	local var_14_2 = arg_14_0.ship

	var_14_1(var_14_0, var_5.GetModel(var_14_2))

	return
end

function var_0_1.OnCharLoaded(arg_15_0)
	arg_15_0.passTime = 0
	GetOrAddComponent = var_1

	local var_15_0 = arg_15_0.role.transform
	local var_15_1 = var_3.GetChild(var_15_0, 0)

	typeof = var_1_10004
	Animator = var_6
	arg_15_0.animator = var_1(var_15_1, var_1_10004(var_6))

	if not arg_15_0.handle then
		UpdateBeat = var_1
		arg_15_0.handle = var_1:CreateListener(arg_15_0.Update, arg_15_0)
	end

	UpdateBeat = var_1

	var_1:AddListener(arg_15_0.handle)
	arg_15_0:PlayAnimation()
	arg_15_0:UpdateChat(arg_15_0.ship)

	return
end

function var_0_1.Update(arg_16_0)
	local var_16_0 = arg_16_0.passTime

	Time = var_1_10002
	arg_16_0.passTime = var_16_0 + var_1_10002.deltaTime

	local var_16_1 = arg_16_0.animator
	local var_16_2 = var_1.GetCurrentAnimatorStateInfo(var_16_1, 0)

	if var_1.IsName(var_16_2, var_0_2) and not arg_16_0.endTime then
		local var_16_3 = var_1.length / arg_16_0.animator.speed

		arg_16_0.endTime = arg_16_0.passTime + var_16_3
	end

	if arg_16_0.endTime and arg_16_0.passTime >= arg_16_0.endTime then
		arg_16_0:OnHelloAnimEnd()

		arg_16_0.endTime = nil
	end

	return
end

function var_0_1.OnHelloAnimEnd(arg_17_0)
	setActive = var_1_10001

	var_1_10001(arg_17_0.mainPanel, true)
	arg_17_0:InitRader(arg_17_0.ship)
	arg_17_0:UpdateNames(arg_17_0.ship)

	setActive = var_1

	var_1(arg_17_0.chatTr, false)

	if arg_17_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_17_0.handle)

		arg_17_0.handle = nil
	end

	return
end

function var_0_1.PlayAnimation(arg_18_0)
	Animator = var_1_10001

	local var_18_0 = var_1_10001.StringToHash(var_0_2)

	for iter_18_0 = 1, arg_18_0.animator.layerCount do
		local var_18_1 = arg_18_0.animator

		var_6.CrossFadeInFixedTime(var_18_1, var_18_0, 0.2, iter_18_0 - 1)
	end

	return
end

function var_0_1.GetSmoothRotateObject(arg_19_0)
	local var_19_0 = arg_19_0._tf

	return var_1.Find(var_19_0, "main/event")
end

function var_0_1.UpdateChat(arg_20_0, arg_20_1)
	arg_20_0.chatTxt.text = arg_20_1:GetNewShipWord()

	return
end

function var_0_1.InitRaderTxt(arg_21_0)
	ipairs = var_1_10001
	IslandShipAttr = var_1_10003

	for iter_21_0, iter_21_1 in var_1_10001(var_1_10003.ATTRS) do
		IslandShipAttr = var_1_10006
		var_1_10006 = var_1_10006.ToChinese(iter_21_1)
		arg_21_0.radarTxts[iter_21_0].text = var_1_10006
	end

	return
end

function var_0_1.InitRader(arg_22_0, arg_22_1)
	IslandShipAttr = var_1_10002

	local var_22_0 = var_1_10002.ATTRS
	local var_22_1 = {}
	local var_22_2 = {}

	IslandCalcUtil = var_1_10005

	local var_22_3 = var_1_10005.GetUnReHexPoints(arg_22_0.radarTr.rect.width - 10, arg_22_0.radarTr.rect.height - 10, 30)

	table = var_1_10006

	local var_22_4 = var_1_10006.insert
	local var_22_5 = var_22_1

	Vector3 = var_9

	var_22_4(var_22_5, var_9(0, 0, 0))

	ipairs = var_22_4

	for iter_22_0, iter_22_1 in var_22_4(var_22_0) do
		local var_22_6 = arg_22_1:GetAttr(iter_22_1)

		table = var_12

		var_12.insert(var_22_1, arg_22_0:GetPoint(var_22_3[iter_22_0], var_22_6, 30))

		table = var_12

		var_12.insert(var_22_2, 0)

		table = var_12

		var_12.insert(var_22_2, iter_22_0)

		if iter_22_0 + 1 > #var_22_0 then
			table = var_12

			var_12.insert(var_22_2, 1)
		else
			table = var_12

			var_12.insert(var_22_2, iter_22_0 + 1)
		end
	end

	IslandCalcUtil = var_6

	local var_22_7 = var_6.Vetor3Table2Array(var_22_1)
	local var_22_8 = arg_22_0.drawPolygon

	var_7.draw(var_22_8, var_22_7, var_22_2)

	return
end

function var_0_1.GetPoint(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	Mathf = var_1_10004

	local var_23_0 = var_1_10004.Clamp01(arg_23_2 / arg_23_3)

	Vector2 = var_1_10005

	local var_23_1 = var_1_10005.Normalize(arg_23_1)

	Vector2 = var_6

	return var_23_1 * (var_6.Magnitude(arg_23_1) * var_23_0)
end

function var_0_1.UpdateNames(arg_24_0, arg_24_1)
	arg_24_0.nameTxt.text = arg_24_1:GetName()
	arg_24_0.enNameTxt.text = arg_24_1:GetEnName()

	return
end

function var_0_1.OnDestroy(arg_25_0)
	var_0_1.super.OnDestroy(arg_25_0)

	if arg_25_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_25_0.handle)

		arg_25_0.handle = nil
	end

	return
end

return var_0_1
