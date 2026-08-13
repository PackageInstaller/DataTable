class = var_0_10000

local var_0_0 = var_0_10000("ShopPaintingView")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._painting = arg_1_1
	arg_1_0._paintingInitPos = arg_1_0._painting.anchoredPosition
	Vector2 = var_3
	arg_1_0._paintingOffsetMin = var_3(arg_1_0._painting.offsetMin.x, arg_1_0._painting.offsetMin.y)
	Vector2 = var_3
	arg_1_0._paintingOffsetMax = var_3(arg_1_0._painting.offsetMax.x, arg_1_0._painting.offsetMax.y)

	local var_1_0 = arg_1_0._painting

	arg_1_0.touch = var_3.Find(var_1_0, "paint_touch")
	arg_1_0.chat = arg_1_2

	local var_1_1 = arg_1_0.chat

	arg_1_0.chatText = var_3.Find(var_1_1, "Text")
	arg_1_0.name = nil
	arg_1_0.chatting = false
	Vector3 = var_3
	arg_1_0.chatTrOffset = var_3(118, -276, 0)
	pg = var_3

	var_3.DelegateInfo.New(arg_1_0)

	return
end

function var_0_0.InitChatPosition(arg_2_0)
	return
end

function var_0_0.Init(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	if not arg_3_0.isInitChatPosition then
		arg_3_0.isInitChatPosition = true

		arg_3_0:InitChatPosition()
	end

	arg_3_0:UnLoad()

	arg_3_0.name = arg_3_1

	if arg_3_2 and arg_3_0.secretaryTf then
		arg_3_0._painting.anchoredPosition = arg_3_0.secretaryTf.anchoredPosition
		arg_3_0._painting.offsetMin = arg_3_0.secretaryTf.offsetMin
		arg_3_0._painting.offsetMax = arg_3_0.secretaryTf.offsetMax
	else
		arg_3_0._painting.anchoredPosition = arg_3_0._paintingInitPos
		arg_3_0._painting.offsetMin = arg_3_0._paintingOffsetMin
		arg_3_0._painting.offsetMax = arg_3_0._paintingOffsetMax
	end

	arg_3_0:Load(arg_3_3, arg_3_4)

	if arg_3_5 then
		onButton = var_6

		local var_3_0 = arg_3_0
		local var_3_1 = arg_3_0.touch

		local function var_3_2()
			arg_3_5()

			return
		end

		SFX_PANEL = var_1_10011

		var_6(var_3_0, var_3_1, var_3_2, var_1_10011)
	end

	return
end

function var_0_0.Load(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0

	if arg_5_0.name == "mingshi_live2d" then
		ShopMingShiPainting = var_4
		var_5_0 = var_4.New(arg_5_0._painting)
	else
		ShopMeshPainting = var_4
		var_5_0 = var_4.New(arg_5_0._painting)
	end

	arg_5_0.iShopPainting = var_5_0

	var_5_0:Load(arg_5_0.name, arg_5_1, arg_5_2)

	return
end

function var_0_0.setSecretaryPos(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.secretaryTf = arg_6_1
	end

	return
end

function var_0_0.Chat(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = 1

	type = var_1_10006

	if var_1_10006(arg_7_1) == "table" then
		math = var_6
		arg_7_1 = arg_7_1[var_6.random(1, #arg_7_1)]
	end

	type = var_6

	if var_6(arg_7_2) == "table" then
		arg_7_2 = arg_7_2[var_7_0]
	end

	type = var_6

	if var_6(arg_7_3) == "table" then
		arg_7_3 = arg_7_3[var_7_0]
	end

	local function var_7_1()
		if arg_7_1 then
			local var_8_0 = arg_7_0

			var_0.ShowShipWord(var_8_0, arg_7_1)
		end

		if arg_7_3 and arg_7_0.iShopPainting then
			local var_8_1 = arg_7_0.iShopPainting

			var_0.Action(var_8_1, arg_7_3)
		end

		return
	end

	if not arg_7_0.chatting or arg_7_4 then
		arg_7_0:StopChat()

		if arg_7_2 then
			arg_7_0:PlayCV(arg_7_2, function(arg_9_0)
				if arg_9_0 then
					arg_7_0._cueInfo = arg_9_0.cueInfo
				end

				var_7_1()

				return
			end)
		else
			var_7_1()
		end
	end

	return
end

function var_0_0.ShowShipWord(arg_10_0, arg_10_1)
	arg_10_0.chatting = true
	LeanTween = var_2

	local var_10_0 = var_2.isTweening

	go = var_1_10004

	if var_10_0(var_1_10004(arg_10_0.chat)) then
		LeanTween = var_2

		local var_10_1 = var_2.cancel

		go = var_4

		var_10_1(var_4(arg_10_0.chat))
	end

	local var_10_2 = 0.3
	local var_10_3 = 3

	if arg_10_0._cueInfo then
		long2int = var_4

		if var_10_3 < var_4(arg_10_0._cueInfo.length) / 1000 then
			var_10_3 = var_4
		end
	end

	setActive = var_4

	var_4(arg_10_0.chat, true)

	setText = var_4

	var_4(arg_10_0.chatText, arg_10_1)

	LeanTween = var_4

	local var_10_4 = var_4.scale
	local var_10_5 = arg_10_0.chat.gameObject

	Vector3 = var_7

	local var_10_6 = var_10_4(var_10_5, var_7.New(1, 1, 1), var_10_2)
	local var_10_7 = var_4.setFrom

	Vector3 = var_7

	local var_10_8 = var_10_7(var_10_6, var_7.New(0, 0, 0))
	local var_10_9 = var_4.setEase

	LeanTweenType = var_7

	local var_10_10 = var_10_9(var_10_8, var_7.easeOutBack)
	local var_10_11 = var_4.setOnComplete

	System = var_7

	var_10_11(var_10_10, var_7.Action(function()
		IsNil = var_2_10000

		if var_2_10000(arg_10_0.chat) then
			return
		end

		LeanTween = var_0

		local var_11_0 = var_0.scale
		local var_11_1 = arg_10_0.chat.gameObject

		Vector3 = var_2_10003

		local var_11_2 = var_11_0(var_11_1, var_2_10003.New(0, 0, 1), var_10_2)
		local var_11_3 = var_0.setFrom

		Vector3 = var_3

		local var_11_4 = var_11_3(var_11_2, var_3.New(1, 1, 1))
		local var_11_5 = var_0.setEase

		LeanTweenType = var_3

		local var_11_6 = var_11_5(var_11_4, var_3.easeInBack)
		local var_11_7 = var_0.setDelay(var_11_6, var_10_3)
		local var_11_8 = var_0.setOnComplete

		System = var_3

		var_11_8(var_11_7, var_3.Action(function()
			IsNil = var_3_10000

			if var_3_10000(arg_10_0.chat) then
				return
			end

			local var_12_0 = arg_10_0

			var_0.StopChat(var_12_0)

			return
		end))

		return
	end))

	return
end

function var_0_0.StopChat(arg_13_0)
	arg_13_0.chatting = nil
	LeanTween = var_1

	local var_13_0 = var_1.isTweening

	go = var_1_10003

	local var_13_1

	if var_13_0(var_1_10003(arg_13_0.chat)) then
		LeanTween = var_13_1
		var_13_1 = var_13_1.cancel
		go = var_3

		var_13_1(var_3(arg_13_0.chat))
	end

	setActive = var_13_1

	var_13_1(arg_13_0.chat, false)
	arg_13_0:StopCV()

	return
end

local function var_0_1(arg_14_0, arg_14_1)
	local var_14_0
	local var_14_1

	string = var_1_10004

	if var_1_10004.find(arg_14_1, "/") then
		string = var_4
		var_14_0 = var_4.split(arg_14_1, "/")[1]
		var_14_1 = var_4[2]
	elseif arg_14_0.name == "mingshi_live2d" then
		var_14_0 = "cv-chargeShop"
		var_14_1 = arg_14_1
	else
		string = var_4

		if var_4.find(arg_14_1, "ryza_shop") then
			var_14_0 = "cv-1090002"
			var_14_1 = arg_14_1
		else
			string = var_4

			if var_4.find(arg_14_1, "atelier_yumia_shop") then
				var_14_0 = "cv-1130002"
				var_14_1 = arg_14_1
			else
				string = var_4

				if var_4.find(arg_14_1, "dal_shop") then
					var_14_0 = "cv-1150006"
					var_14_1 = arg_14_1
				else
					var_14_0 = "cv-shop"
					var_14_1 = arg_14_1
				end
			end
		end
	end

	return var_14_0, var_14_1
end

function var_0_0.PlayCV(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0, var_15_1 = var_0_1(arg_15_0, arg_15_1)

	arg_15_0:StopCV()

	pg = var_5

	local var_15_2 = var_5.CriMgr.GetInstance()

	var_5.PlayCV_V3(var_15_2, var_15_0, var_15_1, arg_15_2)

	arg_15_0._currentVoice = var_15_0

	return
end

function var_0_0.StopCV(arg_16_0)
	if arg_16_0._currentVoice then
		pg = var_1

		local var_16_0 = var_1.CriMgr.GetInstance()

		var_1.UnloadSoundEffect_V3(var_16_0, arg_16_0._currentVoice)
	end

	arg_16_0._currentVoice = nil
	arg_16_0._cueInfo = nil

	return
end

function var_0_0.UnLoad(arg_17_0)
	if arg_17_0.iShopPainting and arg_17_0.name then
		local var_17_0 = arg_17_0.iShopPainting

		var_1.UnLoad(var_17_0, arg_17_0.name)

		arg_17_0.name = nil
		arg_17_0.iShopPainting = nil
	end

	return
end

function var_0_0.Show(arg_18_0, arg_18_1)
	if arg_18_1 then
		setActive = var_1_10002

		var_1_10002(arg_18_0._painting, true)
	else
		setActive = var_1_10002

		var_1_10002(arg_18_0._painting, false)

		arg_18_0.name = nil

		arg_18_0:StopCV()
	end

	return
end

function var_0_0.Dispose(arg_19_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_19_0)
	arg_19_0:UnLoad()
	arg_19_0:StopCV()

	return
end

return var_0_0
