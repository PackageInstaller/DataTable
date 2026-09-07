ys = ys or {}

local CardPuzzleBoardClicker = class("CardPuzzleBoardClicker")

ys.Battle.CardPuzzleBoardClicker = CardPuzzleBoardClicker
CardPuzzleBoardClicker.__name = "CardPuzzleBoardClicker"
CardPuzzleBoardClicker.CLICK_STATE_CLICK = "CLICK_STATE_CLICK"
CardPuzzleBoardClicker.CLICK_STATE_DRAG = "CLICK_STATE_DRAG"
CardPuzzleBoardClicker.CLICK_STATE_RELEASE = "CLICK_STATE_RELEASE"
CardPuzzleBoardClicker.CLICK_STATE_NONE = "CLICK_STATE_NONE"

function CardPuzzleBoardClicker:Ctor(arg_1_1)
	self._go = arg_1_1

	self:Init()

	return
end

function CardPuzzleBoardClicker:Init()
	SetActive(self._go, true)

	self._distX, self._distY = 0, 0
	self._dirX, self._dirY = 0, 0
	self._prePress = false
	self._isPress = false

	local var_2_0 = pg.CameraFixMgr.GetInstance()

	self._screenWidth, self._screenHeight = var_2_0:GetCurrentWidth(), var_2_0:GetCurrentHeight()

	self._go:GetComponent("StickController"):SetStickFunc(function(arg_3_0, arg_3_1)
		self:updateStick(arg_3_0, arg_3_1)

		return
	end)

	return
end

function CardPuzzleBoardClicker:SetCardPuzzleComponent(arg_4_1)
	self._cardPuzzleInfo = arg_4_1

	return
end

function CardPuzzleBoardClicker:updateStick(arg_5_1, arg_5_2)
	if not self._cardPuzzleInfo:GetClickEnable() then
		return
	end

	self._initX = false
	self._initY = false

	if arg_5_2 == -1 then
		self._startX = nil
		self._startY = nil
		self._isPress = false
	else
		self._isPress = true

		local var_5_0 = arg_5_1.x
		local var_5_1 = arg_5_1.y

		if self._startX == nil then
			self._startX = var_5_0
			self._startY = var_5_1
			self._initX = true
			self._initY = true
		else
			local var_5_2 = var_5_0 - self._lastPosX

			if (var_5_0 - self._lastPosX) * self._dirX < 0 then
				self._startX = var_5_0
				self._initX = true
			end

			if var_5_2 ~= 0 then
				self._dirX = var_5_2
			end

			local var_5_3 = var_5_1 - self._lastPosY

			if (var_5_1 - self._lastPosY) * self._dirY < 0 then
				self._startY = var_5_1
				self._initY = true
			end

			if var_5_3 ~= 0 then
				self._dirY = var_5_3
			end
		end

		self._distX = (var_5_0 - self._startX) / self._screenWidth
		self._distY = (var_5_1 - self._startY) / self._screenHeight
	end

	self._lastPosX = arg_5_1.x
	self._lastPosY = arg_5_1.y

	self._cardPuzzleInfo:UpdateClickPos(self._lastPosX, self._lastPosY, not self._prePress and self._isPress and CardPuzzleBoardClicker.CLICK_STATE_CLICK or self._prePress and self._isPress and CardPuzzleBoardClicker.CLICK_STATE_DRAG or self._prePress and not self._isPress and CardPuzzleBoardClicker.CLICK_STATE_RELEASE or CardPuzzleBoardClicker.CLICK_STATE_NONE)

	self._prePress = self._isPress

	return
end

function CardPuzzleBoardClicker:GetDistance()
	return self._distX, self._distY
end

function CardPuzzleBoardClicker:IsFirstPress()
	return self._initX, self._initY
end

function CardPuzzleBoardClicker:IsPress()
	return self._isPress
end

function CardPuzzleBoardClicker:Dispose()
	return
end

return
