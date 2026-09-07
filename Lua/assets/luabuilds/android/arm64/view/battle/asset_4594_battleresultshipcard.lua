local BattleResultShipCard = class("BattleResultShipCard")

function BattleResultShipCard:Ctor(arg_1_1)
	self._expTF = arg_1_1

	self:init()

	return
end

function BattleResultShipCard:init()
	self._expContent = findTF(self._expTF, "content")
	self._expInfo = findTF(self._expContent, "exp")
	self._nameTxt = findTF(self._expContent, "info/name_mask/name")
	self._intimacyUpFX = findTF(self._expContent, "heartsfly")
	self._intimacyDownFX = findTF(self._expContent, "heartsbroken")
	self._lvText = findTF(self._expContent, "dockyard/lv/Text")
	self._lvUp = findTF(self._expContent, "dockyard/lv_bg/levelUpLabel")
	self._lvFX = findTF(self._expContent, "dockyard/lv_bg/levelup")
	self._expText = findTF(self._expInfo, "exp_text")
	self._expProgress = findTF(self._expInfo, "exp_progress")
	self._expImage = self._expProgress:GetComponent(typeof(Image))
	self._expBuff = findTF(self._expInfo, "exp_buff_mask/exp_buff")

	self._expTF:GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function(arg_3_0)
		self:expAnimation()

		return
	end)
	SetActive(self._expTF, false)

	return
end

function BattleResultShipCard:SetShipVO(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	flushShipCard(self._expTF, arg_4_1)

	self._oldShipVO = arg_4_1
	self._newShipVO = arg_4_2
	self._isMVP = arg_4_3
	self._buffName = arg_4_4

	self:setShipInfo()

	return
end

function BattleResultShipCard:RegisterPreEXPTF(arg_5_1)
	arg_5_1:GetTF():GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_6_0)
		setActive(self._expTF, true)

		return
	end)

	return
end

function BattleResultShipCard:ConfigCallback(arg_7_1)
	self._expTF:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_8_0)
		arg_7_1()

		return
	end)

	return
end

function BattleResultShipCard:setShipInfo()
	setScrollText(self._nameTxt, self._oldShipVO:GetColorName())
	setActive(findTF(self._expContent, "mvp"), self._isMVP)
	SetActive(self._expBuff, self._buffName ~= nil)
	setScrollText(self._expBuff, self._buffName or "")

	return
end

function BattleResultShipCard:expAnimation()
	SetActive(self._expInfo, true)
	SetActive(self._intimacyUpFX, self._oldShipVO:getIntimacy() < self._newShipVO:getIntimacy())
	SetActive(self._intimacyDownFX, self._oldShipVO:getIntimacy() > self._newShipVO:getIntimacy())

	local var_10_0 = self._oldShipVO:getConfig("rarity")
	local var_10_1 = getExpByRarityFromLv1(var_10_0, self._oldShipVO.level)

	self._expImage.fillAmount = self._oldShipVO:getExp() / var_10_1

	if self._oldShipVO.level < self._newShipVO.level then
		local var_10_2 = 0

		for iter_10_0 = self._oldShipVO.level, self._newShipVO.level - 1 do
			var_10_2 = var_10_2 + getExpByRarityFromLv1(var_10_0, iter_10_0)
		end

		self.playAnimation(self._expTF, 0, var_10_2 + self._newShipVO:getExp() - self._oldShipVO:getExp(), 1, 0, function(arg_11_0)
			setText(self._expText, "+" .. math.ceil(arg_11_0))

			return
		end)

		self._animationLV = self._oldShipVO.level

		self:loopAnimation(self._oldShipVO:getExp() / var_10_1, 1, 0.7, true)
	else
		setText(self._expText, "+" .. math.ceil(self._newShipVO:getExp() - self._oldShipVO:getExp()))

		if self._oldShipVO.level == self._oldShipVO:getMaxLevel() then
			self._expImage.fillAmount = 1

			return
		end

		self.playAnimation(self._expTF, self._oldShipVO:getExp() / var_10_1, self._newShipVO:getExp() / var_10_1, 1, 0, function(arg_12_0)
			self._expImage.fillAmount = arg_12_0

			return
		end)
	end

	return
end

function BattleResultShipCard:loopAnimation(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = getExpByRarityFromLv1(self._oldShipVO:getConfig("rarity"), self._newShipVO.level)

	LeanTween.value(go(self._expTF), arg_13_1, arg_13_2, arg_13_3):setOnUpdate(System.Action_float(function(arg_14_0)
		self._expImage.fillAmount = arg_14_0

		return
	end)):setOnComplete(System.Action(function()
		self._animationLV = self._animationLV + 1

		if arg_13_4 then
			self:levelUpEffect()
		end

		if self._newShipVO.level == self._animationLV then
			if self._animationLV == self._newShipVO:getMaxLevel() then
				self._expImage.fillAmount = 1
			else
				self:loopAnimation(0, self._newShipVO:getExp() / var_13_0, 1, false)
			end
		elseif self._newShipVO.level > self._animationLV then
			self:loopAnimation(0, 1, 0.7, true)
		end

		return
	end))

	return
end

function BattleResultShipCard:levelUpEffect()
	SetActive(self._lvUp, true)
	SetActive(self._lvFX, true)

	local var_16_0 = self._lvUp.localPosition

	LeanTween.moveY(rtf(self._lvUp), self._lvUp.localPosition.y + 30, 0.5):setOnComplete(System.Action(function()
		SetActive(self._lvUp, false)

		self._lvUp.localPosition = var_16_0

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_BOAT_LEVEL_UP)

		return
	end))

	if self._animationLV <= self._newShipVO.level then
		setText(self._lvText, self._animationLV)
	end

	return
end

function BattleResultShipCard:Play()
	setActive(self._expTF, true)

	return
end

function BattleResultShipCard:SkipAnimation()
	self._expTF:GetComponent(typeof(Animator)).enabled = false

	SetActive(self._expTF, true)
	SetActive(self._expContent, true)
	SetActive(self._expInfo, true)

	self._expTF:GetComponent(typeof(CanvasGroup)).alpha = 1

	LeanTween.cancel(go(self._lvUp))
	LeanTween.cancel(go(self._expTF))
	SetActive(self._intimacyUpFX, self._oldShipVO:getIntimacy() < self._newShipVO:getIntimacy())
	SetActive(self._intimacyDownFX, self._oldShipVO:getIntimacy() > self._newShipVO:getIntimacy())

	self._expContent.localPosition = Vector3(0, 0, 0)

	setText(self._lvText, self._newShipVO.level)

	if self._oldShipVO.level == self._oldShipVO:getMaxLevel() then
		setText(self._expText, "+" .. math.ceil(self._newShipVO:getExp() - self._oldShipVO:getExp()))

		self._expImage.fillAmount = 1
	else
		local var_19_0 = self._oldShipVO:getConfig("rarity")

		if self._oldShipVO.level < self._newShipVO.level then
			local var_19_1 = 0

			for iter_19_0 = self._oldShipVO.level, self._newShipVO.level - 1 do
				var_19_1 = var_19_1 + getExpByRarityFromLv1(var_19_0, iter_19_0)
			end

			setText(self._expText, "+" .. var_19_1 + self._newShipVO:getExp() - self._oldShipVO:getExp())
		else
			setText(self._expText, "+" .. math.ceil(self._newShipVO:getExp() - self._oldShipVO:getExp()))
		end

		self._expImage.fillAmount = self._newShipVO:getExp() / getExpByRarityFromLv1(var_19_0, self._newShipVO.level)
	end

	SetActive(self._lvUp, false)

	return
end

function BattleResultShipCard:GetTF()
	return self._expTF
end

function BattleResultShipCard:playAnimation(arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	LeanTween.value(self.gameObject, arg_21_1, arg_21_2, arg_21_3):setDelay(arg_21_4):setOnUpdate(System.Action_float(function(arg_22_0)
		arg_21_5(arg_22_0)

		return
	end))

	return
end

function BattleResultShipCard:Dispose()
	self._oldShipVO = nil
	self._newShipVO = nil

	return
end

return BattleResultShipCard
