local MedalDetailPanel = class("MedalDetailPanel")

MedalDetailPanel.setColorstateText = "#73757f"
MedalDetailPanel.setColorstate = "#ed4646"

function MedalDetailPanel:SetIconScale(arg_1_1)
	self._iconScale = Vector2.New(arg_1_1, arg_1_1)

	return
end

function MedalDetailPanel:Ctor(arg_2_1, arg_2_2)
	self._go = arg_2_1
	self._tf = arg_2_1.transform
	self._parent = arg_2_2

	pg.DelegateInfo.New(self)
	self:InitUI()

	return
end

function MedalDetailPanel:InitUI()
	self._mask = findTF(self._tf, "mask")
	self._medalIcon = findTF(self._tf, "icon")
	self._medalLock = findTF(self._tf, "lock")
	self._nameText = findTF(self._tf, "name")
	self._descText = findTF(self._tf, "desc")
	self._progressBG = findTF(self._tf, "progress")
	self._progressText = findTF(self._tf, "progress/label")
	self._conditionText = findTF(self._tf, "condition")
	self._stateText = findTF(self._tf, "state")
	self._prevBtn = findTF(self._tf, "prevBtn")
	self._nextBtn = findTF(self._tf, "nextBtn")
	self._closeBtn = findTF(self._tf, "backbtn")

	onButton(self, self._mask, function()
		if self._parent.DETAIL_CLOSE_ANIM and self._parent.DETAIL_CLOSE_ANIM_Time then
			quickPlayAnimation(self._go, self._parent.DETAIL_CLOSE_ANIM)
			onDelayTick(function()
				self:SetActive(false)

				return
			end, self._parent.DETAIL_CLOSE_ANIM_Time)
		else
			self:SetActive(false)
		end

		return
	end, SFX_CANCEL)

	if self._closeBtn then
		onButton(self, self._closeBtn, function()
			if self._parent.DETAIL_CLOSE_ANIM and self._parent.DETAIL_CLOSE_ANIM_Time then
				quickPlayAnimation(self._go, self._parent.DETAIL_CLOSE_ANIM)
				onDelayTick(function()
					self:SetActive(false)

					return
				end, self._parent.DETAIL_CLOSE_ANIM_Time)
			else
				self:SetActive(false)
			end

			return
		end, SFX_CANCEL)
	end

	onButton(self, self._prevBtn, function()
		self._currentIndex = math.max(self._currentIndex - 1, 1)

		self:UpdateMedal()

		return
	end)
	onButton(self, self._nextBtn, function()
		self._currentIndex = math.min(self._currentIndex + 1, #self._medalGroup:GetMedalIds())

		self:UpdateMedal()

		return
	end)

	return
end

function MedalDetailPanel:SetMedalGroup(arg_10_1)
	self._medalGroup = arg_10_1

	return
end

function MedalDetailPanel:SetCurrentIndex(arg_11_1)
	self._currentIndex = arg_11_1

	return
end

function MedalDetailPanel:UpdateMedal()
	local var_12_0 = self._medalGroup:GetMedalIds()[self._currentIndex]

	self._medal = self._medalGroup:GetMedalList()[var_12_0]

	local var_12_1 = pg.activity_medal_template[var_12_0]

	setText(self._nameText, pg.activity_medal_template[var_12_0].activity_medal_name)
	setText(self._descText, var_12_1.activity_medal_desc)

	if self._medal.timeStamp then
		LoadImageSpriteAsync("activitymedal/" .. var_12_0, self._medalIcon, true)
	else
		LoadImageSpriteAsync("activitymedal/" .. var_12_0 .. "_l", self._medalIcon, true)
	end

	self._medalIcon.transform.localScale = self._iconScale

	SetActive(self._medalLock, not self._medal.timeStamp)

	if self._medal.timeStamp then
		setText(self._conditionText, i18n("word_gain_date") .. pg.TimeMgr.GetInstance():CTimeDescC(self._medal.timeStamp, "%Y/%m/%d"))
		setText(self._progressText, i18n("word_unlock"))
	else
		setText(self._conditionText, pg.task_data_template[var_12_1.task_id].desc)
		setText(self._progressText, i18n("word_lock"))
	end

	local var_12_2 = findTF(self._tf, "progress/lock")

	if var_12_2 then
		SetActive(var_12_2, not self._medal.timeStamp)
	end

	local var_12_3 = self._medalGroup:GetMedalGroupState()

	if var_12_3 == ActivityMedalGroup.STATE_EXPIRE then
		setText(self._stateText, setColorStr(i18n("word_cant_gain_anymore"), self._parent.setColorstateText or self.setColorstateText))
	elseif var_12_3 == ActivityMedalGroup.STATE_CLOSE then
		setText(self._stateText, setColorStr(i18n("word_activity_not_open"), self._parent.setColorstate or self.setColorstate))
	end

	SetActive(self._stateText, var_12_3 ~= ActivityMedalGroup.STATE_ACTIVE)
	SetActive(self._prevBtn, self._currentIndex ~= 1)
	SetActive(self._nextBtn, self._currentIndex ~= #self._medalGroup:GetMedalIds())

	return
end

function MedalDetailPanel:SetActive(arg_13_1)
	SetActive(self._go, arg_13_1)

	self._active = arg_13_1

	if arg_13_1 then
		pg.UIMgr.GetInstance():BlurPanel(self._go)
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(self._go, self._parent._tf)
	end

	return
end

function MedalDetailPanel:IsActive()
	return self._active
end

function MedalDetailPanel:Dispose()
	pg.DelegateInfo.Dispose(self)

	return
end

return MedalDetailPanel
