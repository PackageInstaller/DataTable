local var_0_0 = class("ShopPaintingView")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._painting = arg_1_1
	arg_1_0._paintingInitPos = arg_1_0._painting.anchoredPosition
	arg_1_0._paintingOffsetMin = Vector2(arg_1_0._painting.offsetMin.x, arg_1_0._painting.offsetMin.y)
	arg_1_0._paintingOffsetMax = Vector2(arg_1_0._painting.offsetMax.x, arg_1_0._painting.offsetMax.y)
	arg_1_0.touch = arg_1_0._painting:Find("paint_touch")
	arg_1_0.chat = arg_1_2
	arg_1_0.chatText = arg_1_0.chat:Find("Text")
	arg_1_0.name = nil
	arg_1_0.chatting = false
	arg_1_0.chatTrOffset = Vector3(118, -276, 0)

	pg.DelegateInfo.New(arg_1_0)

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
		onButton(arg_3_0, arg_3_0.touch, function()
			arg_3_5()

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.Load(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.name == "mingshi_live2d" and ShopMingShiPainting.New(arg_5_0._painting) or ShopMeshPainting.New(arg_5_0._painting)

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

	if type(arg_7_1) == "table" then
		var_7_0 = math.random(1, #arg_7_1)
		arg_7_1 = arg_7_1[var_7_0]
	end

	if type(arg_7_2) == "table" then
		arg_7_2 = arg_7_2[var_7_0]
	end

	if type(arg_7_3) == "table" then
		arg_7_3 = arg_7_3[var_7_0]
	end

	local function var_7_1()
		if arg_7_1 then
			arg_7_0:ShowShipWord(arg_7_1)
		end

		if arg_7_3 and arg_7_0.iShopPainting then
			arg_7_0.iShopPainting:Action(arg_7_3)
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

	if LeanTween.isTweening(go(arg_10_0.chat)) then
		LeanTween.cancel(go(arg_10_0.chat))
	end

	local var_10_0 = 0.3
	local var_10_1 = 3

	if arg_10_0._cueInfo then
		local var_10_2 = long2int(arg_10_0._cueInfo.length) / 1000

		if 3 < var_10_2 then
			var_10_1 = var_10_2
		end
	end

	setActive(arg_10_0.chat, true)
	setText(arg_10_0.chatText, arg_10_1)
	LeanTween.scale(arg_10_0.chat.gameObject, Vector3.New(1, 1, 1), var_10_0):setFrom(Vector3.New(0, 0, 0)):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
		if IsNil(arg_10_0.chat) then
			return
		end

		LeanTween.scale(arg_10_0.chat.gameObject, Vector3.New(0, 0, 1), var_10_0):setFrom(Vector3.New(1, 1, 1)):setEase(LeanTweenType.easeInBack):setDelay(var_10_1):setOnComplete(System.Action(function()
			if IsNil(arg_10_0.chat) then
				return
			end

			arg_10_0:StopChat()

			return
		end))

		return
	end))

	return
end

function var_0_0.StopChat(arg_13_0)
	arg_13_0.chatting = nil

	if LeanTween.isTweening(go(arg_13_0.chat)) then
		LeanTween.cancel(go(arg_13_0.chat))
	end

	setActive(arg_13_0.chat, false)
	arg_13_0:StopCV()

	return
end

local function var_0_1(arg_14_0, arg_14_1)
	local var_14_0
	local var_14_1

	if string.find(arg_14_1, "/") then
		local var_14_2 = string.split(arg_14_1, "/")

		var_14_0 = var_14_2[1]
		var_14_1 = var_14_2[2]
	elseif arg_14_0.name == "mingshi_live2d" then
		var_14_0 = "cv-chargeShop"
		var_14_1 = arg_14_1
	elseif string.find(arg_14_1, "ryza_shop") then
		var_14_0 = "cv-1090002"
		var_14_1 = arg_14_1
	elseif string.find(arg_14_1, "atelier_yumia_shop") then
		var_14_0 = "cv-1130002"
		var_14_1 = arg_14_1
	elseif string.find(arg_14_1, "dal_shop") then
		var_14_0 = "cv-1150006"
		var_14_1 = arg_14_1
	else
		var_14_0 = "cv-shop"
		var_14_1 = arg_14_1
	end

	return var_14_0, var_14_1
end

function var_0_0.PlayCV(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0, var_15_1 = var_0_1(arg_15_0, arg_15_1)

	arg_15_0:StopCV()
	pg.CriMgr.GetInstance():PlayCV_V3(var_15_0, var_15_1, arg_15_2)

	arg_15_0._currentVoice = var_15_0

	return
end

function var_0_0.StopCV(arg_16_0)
	if arg_16_0._currentVoice then
		pg.CriMgr.GetInstance():UnloadSoundEffect_V3(arg_16_0._currentVoice)
	end

	arg_16_0._currentVoice = nil
	arg_16_0._cueInfo = nil

	return
end

function var_0_0.UnLoad(arg_17_0)
	if arg_17_0.iShopPainting and arg_17_0.name then
		arg_17_0.iShopPainting:UnLoad(arg_17_0.name)

		arg_17_0.name = nil
		arg_17_0.iShopPainting = nil
	end

	return
end

function var_0_0.Show(arg_18_0, arg_18_1)
	if arg_18_1 then
		setActive(arg_18_0._painting, true)
	else
		setActive(arg_18_0._painting, false)

		arg_18_0.name = nil

		arg_18_0:StopCV()
	end

	return
end

function var_0_0.Dispose(arg_19_0)
	pg.DelegateInfo.Dispose(arg_19_0)
	arg_19_0:UnLoad()
	arg_19_0:StopCV()

	return
end

return var_0_0
