local PlayerVitaeBaseBtn = class("PlayerVitaeBaseBtn")

PlayerVitaeBaseBtn.HRZ_TYPE = 1
PlayerVitaeBaseBtn.VEC_TYPE = 2

function PlayerVitaeBaseBtn:Ctor(arg_1_1, arg_1_2)
	self.type = arg_1_2 or PlayerVitaeBaseBtn.HRZ_TYPE
	self.tpl = arg_1_1

	if isActive(arg_1_1) then
		setActive(arg_1_1, false)
	end

	self.isLoaded = false
	self.startPos = self.tpl.anchoredPosition
	self.tf = Object.Instantiate(self.tpl, self.tpl.parent).transform

	self:Hide()

	return
end

function PlayerVitaeBaseBtn:IsHrzType()
	return self.type == PlayerVitaeBaseBtn.HRZ_TYPE
end

function PlayerVitaeBaseBtn:NewGo()
	local var_3_0, var_3_1 = self:GetBgName()
	local var_3_2 = self.tf:GetComponent(typeof(Image))

	var_3_2.sprite = LoadSprite("ui/" .. var_3_0, var_3_1)

	var_3_2:SetNativeSize()
	self:Show()

	return self.tf
end

function PlayerVitaeBaseBtn:Load(arg_4_1)
	pg.DelegateInfo.New(self)

	self.on = findTF(self.tf, "on")
	self.off = findTF(self.tf, "off")
	self.block = findTF(self.tf, "block")
	self.stateTr = findTF(self.tf, "state")
	self.onTxt = findTF(self.tf, "on_Text")
	self.offTxt = findTF(self.tf, "off_Text")

	self:InitBtn()

	self.isLoaded = true

	return
end

function PlayerVitaeBaseBtn:IsActive()
	return false
end

function PlayerVitaeBaseBtn:Update(arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_1 then
		self:Hide()

		return
	end

	self.index = arg_6_2
	self.ship = arg_6_3

	if not self.isLoaded then
		self:Load(self:NewGo())
	else
		if self.flag ~= self:GetDefaultValue() then
			self:InitBtn()
		end

		self:Show()
	end

	self:UpdatePosition()

	return
end

function PlayerVitaeBaseBtn:UpdatePosition()
	if self:IsHrzType() then
		self:UpdatePositionForHrz()
	else
		self:UpdatePositionForVec()
	end

	return
end

function PlayerVitaeBaseBtn:SwitchToVecLayout()
	self.tf.anchoredPosition = Vector2(self.startPos.x, (self.index - 1) * (self.tf.sizeDelta.y + 20) + self.startPos.y)

	return
end

function PlayerVitaeBaseBtn:IsOverlap(arg_9_1)
	return arg_9_1 < self.tf.localPosition.x + self.tf.rect.width * 0.5
end

function PlayerVitaeBaseBtn:UpdatePositionForHrz()
	local var_10_0 = 0
	local var_10_1 = 20

	if PLATFORM_CODE == PLATFORM_US then
		var_10_0 = 310
		var_10_1 = 10
	else
		var_10_0 = self.tf.sizeDelta.x
	end

	local var_10_2 = (self.index - 1) * (var_10_0 + var_10_1) + self.startPos.x

	self.tf.anchorMax = Vector2(0, 0)
	self.tf.anchorMin = Vector2(0, 0)
	self.tf.anchoredPosition = Vector2(var_10_2, self.startPos.y)

	return
end

function PlayerVitaeBaseBtn:UpdatePositionForVec()
	self.tf.anchorMax = Vector2(0, 1)
	self.tf.anchorMin = Vector2(0, 1)
	self.tf.anchoredPosition = Vector2(self.startPos.x, (self.index - 1) * (self.tf.sizeDelta.y + 20) + self.startPos.y)

	return
end

local function var_0_1(arg_12_0, arg_12_1)
	if arg_12_0:IsHrzType() then
		arg_12_0.block.anchoredPosition = arg_12_1 and Vector2(-33, 0) or Vector2(-96, 0)
	else
		setActive(arg_12_0.off, not arg_12_1)
		setActive(arg_12_0.on, arg_12_1)

		local var_12_1 = arg_12_1 and "#5A6177" or "#FFFFFFFF"

		arg_12_0.onTxt:GetComponent(typeof(Text)).text = "<color=" .. (arg_12_1 and "#FFFFFFFF" or "#5A6177") .. ">ON</color>"
		arg_12_0.offTxt:GetComponent(typeof(Text)).text = "<color=" .. var_12_1 .. ">OFF</color>"
	end

	return
end

function PlayerVitaeBaseBtn:InitBtn()
	self.flag = self:GetDefaultValue()

	onButton(self, self.tf, function()
		if self:OnSwitch(not self.flag) then
			self.flag = not self.flag

			var_0_1(self, self.flag)
			self:OnSwitchDone()
		end

		return
	end, SFX_PANEL)
	self:UpdateBtnState(false, self.flag)

	return
end

function PlayerVitaeBaseBtn:UpdateBtnState(arg_15_1, arg_15_2)
	setActive(self.on, not arg_15_1)
	setActive(self.off, not arg_15_1)

	if self:IsHrzType() then
		setActive(self.block, not arg_15_1)
	end

	setActive(self.stateTr, arg_15_1)

	if not arg_15_1 then
		var_0_1(self, arg_15_2)
	end

	return
end

function PlayerVitaeBaseBtn:Show()
	setActive(self.tf, true)

	return
end

function PlayerVitaeBaseBtn:Hide()
	setActive(self.tf, false)

	return
end

function PlayerVitaeBaseBtn:ShowOrHide(arg_18_1)
	if arg_18_1 then
		self:Show()
	else
		self:Hide()
	end

	return
end

function PlayerVitaeBaseBtn:Dispose()
	if self.isLoaded then
		pg.DelegateInfo.Dispose(self)
		Object.Destroy(self.tf.gameObject)
	end

	self:OnDispose()

	return
end

function PlayerVitaeBaseBtn:GetBgName()
	assert(false, "overwrite me !!!")

	return
end

function PlayerVitaeBaseBtn:GetDefaultValue()
	assert(false, "overwrite me !!!")

	return
end

function PlayerVitaeBaseBtn:OnSwitch(arg_22_1)
	assert(false, "overwrite me !!!")

	return
end

function PlayerVitaeBaseBtn:OnSwitchDone()
	return
end

function PlayerVitaeBaseBtn:OnDispose()
	return
end

function PlayerVitaeBaseBtn:setParent(arg_25_1, arg_25_2)
	SetParent(self.tf, arg_25_1)
	self.tf:SetSiblingIndex(arg_25_2)

	return
end

return PlayerVitaeBaseBtn
