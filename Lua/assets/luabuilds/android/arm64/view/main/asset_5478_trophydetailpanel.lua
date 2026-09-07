local TrophyDetailPanel = class("TrophyDetailPanel")

function TrophyDetailPanel:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self._parent = arg_1_2

	pg.DelegateInfo.New(self)

	self._medalIcon = findTF(self._tf, "center/medalBG/icon")
	self._nameLabel = findTF(self._tf, "center/name")
	self._timeStamp = findTF(self._tf, "center/timeStamp/Text"):GetComponent(typeof(Text))
	self._desc = findTF(self._tf, "center/desc/Text"):GetComponent(typeof(Text))
	self._progressBar = findTF(self._tf, "center/progress_bar/progress")
	self._rank = findTF(self._tf, "center/rank/Text"):GetComponent(typeof(Text))
	self._lock = findTF(self._tf, "center/medalBG/lock")
	self._conditionList = findTF(self._tf, "center/conditions/container")
	self._conditionTpl = findTF(self._tf, "center/conditions/condition_tpl")

	onButton(self, self._go, function()
		self:SetActive(false)

		return
	end, SFX_CANCEL)

	self._stepper = findTF(self._tf, "center/stepper")
	self._preTrophyBtn = findTF(self._stepper, "pre")
	self._postTrophyBtn = findTF(self._stepper, "post")
	self._pageText = findTF(self._stepper, "page")
	self._backTipsText = findTF(self._tf, "center/backTips/GameObject (1)")

	setText(self._backTipsText, i18n("world_collection_back"))
	onButton(self, self._postTrophyBtn, function()
		self:UpdateTrophy((self._trophyGroup:getPostTrophy(self._trophy)))

		return
	end)
	onButton(self, self._preTrophyBtn, function()
		self:UpdateTrophy((self._trophyGroup:getPreTrophy(self._trophy)))

		return
	end)

	self._active = false

	return
end

function TrophyDetailPanel:SetTrophyGroup(arg_5_1)
	self._trophyGroup = arg_5_1

	return
end

function TrophyDetailPanel:UpdateTrophy(arg_6_1)
	if arg_6_1 == nil then
		return
	end

	self._trophy = arg_6_1
	self._rank.text = arg_6_1:getConfig("rank")
	self._desc.text = arg_6_1:getConfig("desc")

	if arg_6_1:isClaimed() then
		local var_6_0 = pg.TimeMgr.GetInstance():STimeDescS(arg_6_1.timestamp, "*t")

		self._timeStamp.text = var_6_0.year .. "/" .. var_6_0.month .. "/" .. var_6_0.day
	else
		self._timeStamp.text = "-"
	end

	removeAllChildren(self._conditionList)
	LoadImageSpriteAsync("medal/" .. arg_6_1:getConfig("icon"), self._medalIcon, true)
	SetActive(self._lock, not arg_6_1:isClaimed())
	LoadImageSpriteAsync("medal/" .. arg_6_1:getConfig("label"), self._nameLabel, true)

	local function var_6_1(arg_7_0, arg_7_1)
		setText(findTF(arg_7_0, "desc"), arg_7_1:getConfig("condition"))

		local var_7_0, var_7_1 = arg_7_1:getProgress()

		if arg_7_1:getTargetType() == Trophy.INTAMACT_TYPE then
			setText(findTF(arg_7_0, "progress"), arg_7_1:isDummy() and "" or "[" .. math.modf(var_7_0 / 100) .. "/" .. math.modf(var_7_1 / 100) .. "]")
		else
			setText(findTF(arg_7_0, "progress"), arg_7_1:isDummy() and "" or "[" .. var_7_0 .. "/" .. var_7_1 .. "]")
		end

		return
	end

	if not arg_6_1:isComplexTrophy() then
		var_6_1(cloneTplTo(self._conditionTpl, self._conditionList), arg_6_1)
	else
		for iter_6_0, iter_6_1 in pairs(arg_6_1:getSubTrophy()) do
			var_6_1(cloneTplTo(self._conditionTpl, self._conditionList), iter_6_1)
		end
	end

	self._progressBar:GetComponent(typeof(Image)).fillAmount = arg_6_1:getProgressRate()

	self:updateStepper(arg_6_1)

	return
end

function TrophyDetailPanel:updateStepper(arg_8_1)
	setText(self._pageText, self._trophyGroup:getTrophyIndex(self._trophy) .. "/" .. self._trophyGroup:getTrophyCount())

	return
end

function TrophyDetailPanel:SetActive(arg_9_1)
	SetActive(self._go, arg_9_1)

	self._active = arg_9_1

	if arg_9_1 then
		pg.UIMgr.GetInstance():BlurPanel(self._go)
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(self._go, self._parent)
	end

	return
end

function TrophyDetailPanel:IsActive()
	return self._active
end

function TrophyDetailPanel:Dispose()
	pg.DelegateInfo.Dispose(self)

	return
end

return TrophyDetailPanel
