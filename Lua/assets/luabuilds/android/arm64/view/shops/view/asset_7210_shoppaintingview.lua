local ShopPaintingView = class("ShopPaintingView")

function ShopPaintingView:Ctor(arg_1_1, arg_1_2)
	self._painting = arg_1_1
	self._paintingInitPos = self._painting.anchoredPosition
	self._paintingOffsetMin = Vector2(self._painting.offsetMin.x, self._painting.offsetMin.y)
	self._paintingOffsetMax = Vector2(self._painting.offsetMax.x, self._painting.offsetMax.y)
	self.touch = self._painting:Find("paint_touch")
	self.chat = arg_1_2
	self.chatText = self.chat:Find("Text")
	self.name = nil
	self.chatting = false
	self.chatTrOffset = Vector3(118, -276, 0)

	pg.DelegateInfo.New(self)

	return
end

function ShopPaintingView:InitChatPosition()
	return
end

function ShopPaintingView:Init(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	if not self.isInitChatPosition then
		self.isInitChatPosition = true

		self:InitChatPosition()
	end

	self:UnLoad()

	self.name = arg_3_1

	if arg_3_2 and self.secretaryTf then
		self._painting.anchoredPosition = self.secretaryTf.anchoredPosition
		self._painting.offsetMin = self.secretaryTf.offsetMin
		self._painting.offsetMax = self.secretaryTf.offsetMax
	else
		self._painting.anchoredPosition = self._paintingInitPos
		self._painting.offsetMin = self._paintingOffsetMin
		self._painting.offsetMax = self._paintingOffsetMax
	end

	self:Load(arg_3_3, arg_3_4)

	if arg_3_5 then
		onButton(self, self.touch, function()
			arg_3_5()

			return
		end, SFX_PANEL)
	end

	return
end

function ShopPaintingView:Load(arg_5_1, arg_5_2)
	local var_5_0 = self.name == "mingshi_live2d" and ShopMingShiPainting.New(self._painting) or ShopMeshPainting.New(self._painting)

	self.iShopPainting = var_5_0

	var_5_0:Load(self.name, arg_5_1, arg_5_2)

	return
end

function ShopPaintingView:setSecretaryPos(arg_6_1)
	if arg_6_1 then
		self.secretaryTf = arg_6_1
	end

	return
end

function ShopPaintingView:Chat(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
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
			self:ShowShipWord(arg_7_1)
		end

		if arg_7_3 and self.iShopPainting then
			self.iShopPainting:Action(arg_7_3)
		end

		return
	end

	if not self.chatting or arg_7_4 then
		self:StopChat()

		if arg_7_2 then
			self:PlayCV(arg_7_2, function(arg_9_0)
				if arg_9_0 then
					self._cueInfo = arg_9_0.cueInfo
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

function ShopPaintingView:ShowShipWord(arg_10_1)
	self.chatting = true

	if LeanTween.isTweening(go(self.chat)) then
		LeanTween.cancel(go(self.chat))
	end

	local var_10_0 = 0.3
	local var_10_1 = 3

	if self._cueInfo then
		local var_10_2 = long2int(self._cueInfo.length) / 1000

		if var_10_1 < var_10_2 then
			var_10_1 = var_10_2
		end
	end

	setActive(self.chat, true)
	setText(self.chatText, arg_10_1)
	LeanTween.scale(self.chat.gameObject, Vector3.New(1, 1, 1), var_10_0):setFrom(Vector3.New(0, 0, 0)):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
		if IsNil(self.chat) then
			return
		end

		LeanTween.scale(self.chat.gameObject, Vector3.New(0, 0, 1), var_10_0):setFrom(Vector3.New(1, 1, 1)):setEase(LeanTweenType.easeInBack):setDelay(var_10_1):setOnComplete(System.Action(function()
			if IsNil(self.chat) then
				return
			end

			self:StopChat()

			return
		end))

		return
	end))

	return
end

function ShopPaintingView:StopChat()
	self.chatting = nil

	if LeanTween.isTweening(go(self.chat)) then
		LeanTween.cancel(go(self.chat))
	end

	setActive(self.chat, false)
	self:StopCV()

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

function ShopPaintingView:PlayCV(arg_15_1, arg_15_2)
	local var_15_0, var_15_1 = var_0_1(self, arg_15_1)

	self:StopCV()
	pg.CriMgr.GetInstance():PlayCV_V3(var_15_0, var_15_1, arg_15_2)

	self._currentVoice = var_15_0

	return
end

function ShopPaintingView:StopCV()
	if self._currentVoice then
		pg.CriMgr.GetInstance():UnloadSoundEffect_V3(self._currentVoice)
	end

	self._currentVoice = nil
	self._cueInfo = nil

	return
end

function ShopPaintingView:UnLoad()
	if self.iShopPainting and self.name then
		self.iShopPainting:UnLoad(self.name)

		self.name = nil
		self.iShopPainting = nil
	end

	return
end

function ShopPaintingView:Show(arg_18_1)
	if arg_18_1 then
		setActive(self._painting, true)
	else
		setActive(self._painting, false)

		self.name = nil

		self:StopCV()
	end

	return
end

function ShopPaintingView:Dispose()
	pg.DelegateInfo.Dispose(self)
	self:UnLoad()
	self:StopCV()

	return
end

return ShopPaintingView
