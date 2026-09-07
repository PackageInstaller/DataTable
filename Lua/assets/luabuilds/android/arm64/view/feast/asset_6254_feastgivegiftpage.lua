local FeastGiveGiftPage = class("FeastGiveGiftPage", import("view.base.BaseSubView"))

function FeastGiveGiftPage:getUIName()
	return "FeastGiveGiftPage"
end

function FeastGiveGiftPage:OnLoaded()
	self.mask = self._tf:Find("mask")
	self.back = self._tf:Find("back")
	self.charContainer = self._tf:Find("char")
	self.charRect = self._tf:Find("char/rect")
	self.nameTxt = self._tf:Find("dialogue/name/Text"):GetComponent(typeof(Text))
	self.dialogueTxt = self._tf:Find("dialogue/Text"):GetComponent(typeof(Text))
	self.typer = self._tf:Find("dialogue/Text"):GetComponent(typeof(Typewriter))
	self.giftTr = self._tf:Find("dialogue/item/icon")
	self.effectTr = self._tf:Find("char/effect")
	self.giftTrPos = self.giftTr.localPosition
	self.tipTr = self._tf:Find("dialogue/tip"):GetComponent(typeof(Text))

	return
end

function FeastGiveGiftPage:BindEvents()
	self.eventId = self:bind(FeastScene.ON_GOT_GIFT, function(arg_4_0, arg_4_1)
		self:OnGotGift(arg_4_1)

		return
	end)

	return
end

function FeastGiveGiftPage:ClearBindEvents()
	if self.eventId then
		self:disconnect(self.eventId)

		self.eventId = nil
	end

	return
end

function FeastGiveGiftPage:OnGotGift(arg_6_1)
	if self.feastShip then
		self:BlockEvents()
		setActive(self.effectTr, true)
		seriesAsync({
			function(arg_7_0)
				self:UpdateGiftState(self.feastShip, arg_7_0)

				return
			end,
			function(arg_8_0)
				onButton(self, self.mask, function()
					self:UnBlockEvents()
					arg_8_0()

					return
				end, SFX_PANEL)

				return
			end,
			function(arg_10_0)
				self:emit(BaseUI.ON_ACHIEVE, arg_6_1, arg_10_0)

				return
			end,
			function(arg_11_0)
				pg.NewStoryMgr.GetInstance():Play(self.feastShip:GetGiftStory(), arg_11_0)

				return
			end
		}, function()
			setActive(self.effectTr, false)
			self:emit(FeastScene.ON_BACK_FEAST)

			return
		end)
	end

	return
end

function FeastGiveGiftPage:Show(arg_13_1)
	FeastGiveGiftPage.super.Show(self)
	self:UnBlockEvents()
	setActive(self.effectTr, false)

	self.feastShip = arg_13_1

	self:SetTipContent()
	seriesAsync({
		function(arg_14_0)
			self:LoadChar(arg_13_1, arg_14_0)

			return
		end,
		function(arg_15_0)
			self.giftTr.localPosition = self.giftTrPos

			self:LoadItem(arg_13_1, arg_15_0)

			return
		end
	}, function()
		self:BindEvents()
		self:UpdateShipName(arg_13_1)
		self:UpdateGiftState(arg_13_1)
		self:RegisterEvent()

		return
	end)

	return
end

function FeastGiveGiftPage:SetTipContent()
	self.tipTr.text = i18n("feast_drag_gift_tip")

	return
end

function FeastGiveGiftPage:CanInterAction()
	return not isActive(self.mask)
end

function FeastGiveGiftPage:BlockEvents()
	setActive(self.mask, true)

	return
end

function FeastGiveGiftPage:UnBlockEvents()
	setActive(self.mask, false)
	removeOnButton(self.mask)

	return
end

function FeastGiveGiftPage:RegisterEvent()
	onButton(self, self.back, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

local function var_0_1(arg_23_0, arg_23_1)
	return (LuaHelper.ScreenToLocal(arg_23_0:GetComponent("RectTransform"), arg_23_1, pg.UIMgr.GetInstance().overlayCameraComp))
end

function FeastGiveGiftPage:LoadChar(arg_24_1, arg_24_2)
	local var_24_0 = arg_24_1:GetPrefab()

	PoolMgr.GetInstance():GetPrefab("feastChar/" .. var_24_0, var_24_0, true, function(arg_25_0)
		if self.exited then
			PoolMgr.GetInstance():ReturnPrefab("feastChar/" .. var_24_0, var_24_0, arg_25_0)

			return
		end

		arg_25_0.transform:SetParent(self.charContainer)

		arg_25_0.transform.localScale = Vector3(1, 1, 0)
		arg_25_0.transform.localPosition = Vector3(0, 0, 0)
		self.loadedChar = {
			spineAnimUI = arg_25_0:GetComponent(typeof(SpineAnimUI)),
			name = var_24_0
		}

		if arg_24_2 then
			arg_24_2()
		end

		return
	end)

	return
end

function FeastGiveGiftPage:LoadItem(arg_26_1, arg_26_2)
	LoadSpriteAsync("FeastCharGift/" .. arg_26_1:GetPrefab(), function(arg_27_0)
		local var_27_0 = self.giftTr:GetComponent(typeof(Image))

		var_27_0.sprite = arg_27_0

		var_27_0:SetNativeSize()
		arg_26_2()

		return
	end)

	return
end

function FeastGiveGiftPage:UpdateShipName(arg_28_1)
	self.nameTxt.text = arg_28_1:GetShipName()

	return
end

function FeastGiveGiftPage:UpdateGiftState(arg_29_1, arg_29_2)
	self:ClearGiftEvent()
	parallelAsync({
		function(arg_30_0)
			self:UpdateContent(arg_29_1:GetDialogueForGift(), 4, arg_30_0)

			return
		end,
		function(arg_31_0)
			local var_31_0 = self.loadedChar.spineAnimUI

			if not arg_29_1:GotGift() then
				setActive(self.giftTr, true)
				self:AddGiftEvent()
				self.loadedChar.spineAnimUI:SetAction("activity_wait", 0)
			else
				setActive(self.giftTr, false)
				self.loadedChar.spineAnimUI:SetActionCallBack(function(arg_32_0)
					if arg_32_0 == "finish" then
						var_31_0:SetActionCallBack(nil)
						var_31_0:SetAction("activity_wait", 0)
						arg_31_0()
					end

					return
				end)
				self.loadedChar.spineAnimUI:SetAction("activity_getgift", 0)
			end

			return
		end
	}, function()
		if arg_29_2 then
			arg_29_2()
		end

		return
	end)

	return
end

function FeastGiveGiftPage:UpdateContent(arg_34_1, arg_34_2, arg_34_3)
	self.typer:setSpeed(31)

	self.dialogueTxt.text = arg_34_1

	self.typer:setSpeed(arg_34_2 / System.String.New(arg_34_1).Length)

	function self.typer.endFunc()
		if arg_34_3 then
			arg_34_3()
		end

		return
	end

	self.typer:Play()

	return
end

function FeastGiveGiftPage:AddGiftEvent()
	local var_36_0 = self.giftTr
	local var_36_1 = GetOrAddComponent(self.giftTr, typeof(EventTriggerListener))
	local var_36_2

	var_36_1:AddBeginDragFunc(function()
		var_36_0:SetAsLastSibling()

		var_36_2 = var_36_0.localPosition

		return
	end)
	var_36_1:AddDragFunc(function(arg_38_0, arg_38_1)
		var_36_0.localPosition = var_0_1(var_36_0.parent, arg_38_1.position)

		return
	end)
	var_36_1:AddDragEndFunc(function(arg_39_0, arg_39_1)
		if getBounds(self.charRect):Intersects((getBounds(var_36_0))) then
			self:Send()
		else
			var_36_0.localPosition = self.giftTrPos
		end

		return
	end)

	return
end

function FeastGiveGiftPage:ClearGiftEvent()
	local var_40_0 = GetOrAddComponent(self.giftTr, typeof(EventTriggerListener))

	var_40_0:AddBeginDragFunc(nil)
	var_40_0:AddDragFunc(nil)
	var_40_0:AddDragEndFunc(nil)
	var_40_0:RemoveBeginDragFunc()
	var_40_0:RemoveDragFunc()
	var_40_0:RemoveDragEndFunc()

	return
end

function FeastGiveGiftPage:Send()
	self:emit(FeastMediator.GIVE_GIFT, self.feastShip.tid)

	return
end

function FeastGiveGiftPage:Hide()
	FeastGiveGiftPage.super.Hide(self)
	self:ClearBindEvents()

	if self.loadedChar then
		self.loadedChar.spineAnimUI:SetActionCallBack(nil)
		PoolMgr.GetInstance():ReturnPrefab("feastChar/" .. self.loadedChar.name, self.loadedChar.name, self.loadedChar.spineAnimUI.gameObject)

		self.loadedChar = nil
	end

	self:ClearGiftEvent()

	return
end

function FeastGiveGiftPage:OnDestroy()
	return
end

return FeastGiveGiftPage
