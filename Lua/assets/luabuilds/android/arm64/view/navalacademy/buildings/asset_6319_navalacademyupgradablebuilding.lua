local NavalAcademyUpgradableBuilding = class("NavalAcademyUpgradableBuilding", import(".NavalAcademyBuilding"))

function NavalAcademyUpgradableBuilding:Ctor(arg_1_1)
	NavalAcademyUpgradableBuilding.super.Ctor(self, arg_1_1)

	self.nameTF = findTF(self._tf, "name")
	self.levelTxt = findTF(self._tf, "name/level"):GetComponent(typeof(Text))
	self.timeTF = findTF(self._tf, "time")
	self.timeTxt = findTF(self._tf, "time/Text"):GetComponent(typeof(Text))
	self.floatTF = findTF(self._tf, "float")
	self.floatTxt = self.floatTF:Find("Text"):GetComponent(typeof(Text))
	self.bubble = findTF(self._tf, "popup")
	self.heigh = self.bubble.localPosition.y

	setActive(self.floatTF, false)
	setText(findTF(self._tf, "time/label"), i18n("class_label_upgrading"))

	return
end

function NavalAcademyUpgradableBuilding:OnInit()
	self:UpdateResField()
	self:UpdateBubble()

	return
end

function NavalAcademyUpgradableBuilding:FloatAni()
	LeanTween.moveLocalY(go(self.bubble), self.heigh + 20, 2):setFrom(self.heigh):setLoopPingPong()

	return
end

function NavalAcademyUpgradableBuilding:UpdateBubble()
	local var_4_0 = self:GetResField():HasRes()

	if var_4_0 then
		self:FloatAni()
	end

	setActive(self.bubble, var_4_0)
	onButton(self, self.bubble, function()
		self:emit(NavalAcademyMediator.ON_GET_RES, self:GetResField():GetResourceType())

		return
	end, SFX_PANEL)

	return
end

function NavalAcademyUpgradableBuilding:PlayGetResAnim(arg_6_1)
	self:UpdateBubble()

	self.floatTxt.text = "+" .. arg_6_1

	setActive(self.floatTF, true)
	LeanTween.moveY(rtf(self.floatTF), 30, 1):setFrom(0):setOnComplete(System.Action(function()
		setActive(self.floatTF, false)

		return
	end))

	return
end

function NavalAcademyUpgradableBuilding:UpdateResField()
	self:RemoveTimer()

	local var_8_0 = self:GetResField()

	self.levelTxt.text = "Lv." .. var_8_0:GetLevel()

	local var_8_1 = var_8_0:IsStarting()

	setActive(self.timeTF, var_8_1)
	setActive(self.nameTF, not var_8_1)

	if var_8_1 then
		self:AddTimer()
	end

	self:RefreshTip()

	return
end

function NavalAcademyUpgradableBuilding:AddTimer()
	local var_9_0 = self:GetResField()

	self.timer = Timer.New(function()
		local var_10_0 = var_9_0:GetDuration()

		if var_10_0 and var_10_0 > 0 then
			self.timeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_10_0)
		else
			self:UpdateResField()
		end

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function NavalAcademyUpgradableBuilding:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function NavalAcademyUpgradableBuilding:IsTip()
	return self:GetResField():CanUpgrade()
end

function NavalAcademyUpgradableBuilding:Dispose()
	NavalAcademyUpgradableBuilding.super.Dispose(self)
	self:RemoveTimer()

	if LeanTween.isTweening(go(self.floatTF)) then
		LeanTween.cancel(go(self.floatTF))
	end

	LeanTween.cancel(go(self.bubble))

	return
end

function NavalAcademyUpgradableBuilding:GetResField()
	assert(false)

	return
end

return NavalAcademyUpgradableBuilding
