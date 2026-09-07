local TrophyView = class("TrophyView")

TrophyView.GRAY_COLOR = Color(0.764, 0.764, 0.764, 0.784)

function TrophyView:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self._trophyNamePic = findTF(self._tf, "frame/trophyName/Text")
	self._trophyNameBG = findTF(self._tf, "frame/trophyName")
	self._trophyIcon = findTF(self._tf, "frame/trophyIcon")
	self._trophyDescUpper = findTF(self._tf, "frame/trophyDesc/Text_upper"):GetComponent(typeof(Text))
	self._trophyDescLower = findTF(self._tf, "frame/trophyDesc/Text_lower"):GetComponent(typeof(Text))
	self._trophyCountBG = findTF(self._tf, "frame/trophyCount")
	self._trophyCount = findTF(self._tf, "frame/trophyCount/Text"):GetComponent(typeof(Text))
	self._progressBar = findTF(self._tf, "frame/trophy_progress/Fill"):GetComponent(typeof(Slider))
	self._reminder = findTF(self._tf, "frame/reminder")

	return
end

function TrophyView:UpdateTrophyGroup(arg_2_1)
	self:updateInfoView((arg_2_1:getDisplayTrophy()))
	self:updateProgressView((arg_2_1:getProgressTrophy()))

	return
end

function TrophyView:ProgressingForm(arg_3_1)
	local var_3_0 = arg_3_1:getProgressTrophy()

	self:updateInfoView(var_3_0)
	self:updateProgressView(var_3_0)

	return
end

function TrophyView:ClaimForm(arg_4_1)
	local var_4_0 = arg_4_1:getMaxClaimedTrophy()

	if var_4_0 then
		self:updateInfoView(var_4_0)
		self:updateProgressView(var_4_0)
	end

	return
end

function TrophyView:updateInfoView(arg_5_1)
	self._trophy = arg_5_1
	self._trophyCount.text = arg_5_1:getConfig("rank")

	if not arg_5_1:isClaimed() and not arg_5_1:canClaimed() then
		setActive(self._trophyCount, false)
	end

	LoadImageSpriteAsync("medal/" .. arg_5_1:getConfig("icon"), self._trophyIcon, true)
	LoadImageSpriteAsync("medal/" .. arg_5_1:getConfig("label"), self._trophyNamePic, true)
	self:setGray(self._trophyIcon, not arg_5_1:isClaimed())
	self:setGray(self._trophyNamePic, not arg_5_1:isClaimed())
	self:setGray(self._trophyNameBG, not arg_5_1:isClaimed())
	self:setGray(self._trophyCountBG, not arg_5_1:isClaimed())

	self._trophyDescUpper.text = arg_5_1:getConfig("explain1")
	self._trophyDescLower.text = arg_5_1:getConfig("explain2")

	return
end

function TrophyView:setGray(arg_6_1, arg_6_2)
	setGray(arg_6_1, arg_6_2, true)

	arg_6_1:GetComponent(typeof(Image)).color = arg_6_2 and TrophyView.GRAY_COLOR or Color.white

	return
end

function TrophyView:updateProgressView(arg_7_1)
	self._progressTrophy = arg_7_1
	self._progressBar.value = arg_7_1:getProgressRate()

	setActive(self._reminder, self._progressTrophy:canClaimed() and not self._progressTrophy:isClaimed())

	return
end

function TrophyView:GetTrophyClaimTipsID()
	local var_8_0 = tonumber(self._trophy:getConfig("icon"))

	if var_8_0 < 9000 then
		var_8_0 = var_8_0 - var_8_0 % 10
	end

	return "xunzhang" .. var_8_0
end

function TrophyView:SetTrophyReminderMaterial(arg_9_1)
	if self._reminder then
		self._reminder:Find("Image01"):GetComponent(typeof(Image)).material = arg_9_1
	end

	return
end

function TrophyView:PlayClaimAnima(arg_10_1, arg_10_2, arg_10_3)
	self._isPlaying = true

	setActive(self._reminder, false)

	local var_10_0 = self._tf:GetComponent(typeof(Animator))

	var_10_0.enabled = true

	self._tf:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_11_0)
		arg_10_3()
		setActive(self._reminder, self._progressTrophy:canClaimed() and not self._progressTrophy:isClaimed())

		return
	end)
	var_10_0:Play("trophy_upper", -1, 0)
	setActive(arg_10_2, true)

	local var_10_1 = tf(arg_10_2)

	var_10_1:SetParent(findTF(self._tf, "frame"), false)

	var_10_1.localScale = Vector3(1, 1, 0)

	LuaHelper.SetParticleEndEvent(arg_10_2, function()
		self._isPlaying = false

		Object.Destroy(arg_10_2)

		return
	end)

	return
end

function TrophyView:IsPlaying()
	return self._isPlaying
end

return TrophyView
