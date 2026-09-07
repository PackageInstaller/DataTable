local NewNavalTacticsShipCard = class("NewNavalTacticsShipCard", import(".NewNavalTacticsBaseCard"))

function NewNavalTacticsShipCard:OnInit()
	self.skillNameTxt = findTF(self._tf, "skill/name_Text"):GetComponent(typeof(Text))
	self.skillIcon = findTF(self._tf, "skill/icon"):GetComponent(typeof(Image))
	self.skillExpSlider = findTF(self._tf, "skill/exp"):GetComponent(typeof(Slider))
	self.skillLevelTxt = findTF(self._tf, "skill/level"):GetComponent(typeof(Text))
	self.skillNextExp = findTF(self._tf, "skill/next"):GetComponent(typeof(Text))
	self.timeTxt = findTF(self._tf, "timer_Text"):GetComponent(typeof(Text))
	self.cancelBtn = findTF(self._tf, "cancel_btn")
	self.quickFinishBtn = findTF(self._tf, "quick_finish_btn")

	onButton(self, self.cancelBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("tactics_lesson_cancel"),
			onYes = function()
				self:OnCancel()

				return
			end
		})

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self._tf, "skill"), function()
		self:emit(NewNavalTacticsMediator.ON_SKILL, self.skillVO:GetDisplayId(), self.skillVO)

		return
	end, SFX_PANEL)
	onButton(self, self.quickFinishBtn, function()
		self:emit(NewNavalTacticsMediator.ON_QUICK_FINISH, self.student.id)

		return
	end, SFX_PANEL)

	return
end

function NewNavalTacticsShipCard:LoadShipCard()
	ResourceMgr.Inst:getAssetAsync("template/shipcardtpl", "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_7_0)
		local var_7_0 = Object.Instantiate(arg_7_0, self._tf)

		var_7_0.transform.localScale = Vector3(1.28, 1.28, 1)
		var_7_0.transform.localPosition = Vector3(0, 251, 0)
		self.shipCard = DockyardShipItem.New(var_7_0, ShipStatus.TAG_HIDE_ALL)

		self:UpdateShipCard()

		return
	end), true, true)

	return
end

function NewNavalTacticsShipCard:OnUpdate(arg_8_1)
	self.student = arg_8_1
	self.ship = getProxy(BayProxy):RawGetShipById(self.student.shipId)
	self.skillVO = ShipSkill.New(self.ship.skills[self.student:getSkillId(self.ship)], self.ship.id)

	self:UpdateSkill()

	if not self.shipCard then
		self:LoadShipCard()
	else
		self:UpdateShipCard()
	end

	self:AddTimer()
	setActive(self.quickFinishBtn, getProxy(NavalAcademyProxy):getDailyFinishCnt() > 0)

	return
end

function NewNavalTacticsShipCard:UpdateSkill()
	self.skillNameTxt.text = shortenString(self.skillVO:GetName(), 8)
	self.skillLevelTxt.text = self.skillVO.level

	LoadSpriteAsync("skillicon/" .. self.skillVO:GetIcon(), function(arg_10_0)
		self.skillIcon.sprite = arg_10_0

		return
	end)

	if self.skillVO:IsMaxLevel() then
		self.skillNextExp.text = "MAX"
		self.skillExpSlider.value = 1
	else
		local var_9_2 = self.skillVO:GetNextLevelExp()

		self.skillNextExp.text = self.skillVO.exp .. "/" .. var_9_2
		self.skillExpSlider.value = self.skillVO.exp / var_9_2
	end

	return
end

function NewNavalTacticsShipCard:AddTimer()
	self:RemoveTimer()

	local var_11_0 = self.student:getFinishTime()

	self.timer = Timer.New(function()
		local var_12_0 = var_11_0 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_12_0 < 0 then
			self:OnFinish()
		else
			self.timeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_12_0)
		end

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function NewNavalTacticsShipCard:OnFinish()
	self:RemoveTimer()

	self.timeTxt.text = ""

	self:emit(NewNavalTacticsMediator.ON_CANCEL, self.student.id, Student.CANCEL_TYPE_AUTO)

	return
end

function NewNavalTacticsShipCard:OnCancel()
	self:emit(NewNavalTacticsMediator.ON_CANCEL, self.student.id, Student.CANCEL_TYPE_MANUAL)

	return
end

function NewNavalTacticsShipCard:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function NewNavalTacticsShipCard:UpdateShipCard()
	if self.ship.id == self.shipID then
		return
	end

	self.shipCard:update(self.ship)

	self.shipID = self.ship.id

	return
end

function NewNavalTacticsShipCard:OnDispose()
	self:RemoveTimer()

	if LeanTween.isTweening(self.skillExpSlider.gameObject) then
		LeanTween.cancel(self.skillExpSlider.gameObject)
	end

	if LeanTween.isTweening(self.skillNextExp.gameObject) then
		LeanTween.cancel(self.skillNextExp.gameObject)
	end

	return
end

function NewNavalTacticsShipCard:DoAddExpAnim(arg_18_1, arg_18_2, arg_18_3)
	if arg_18_2.level - arg_18_1.level > 0 then
		self:DoLevelUpAnim(arg_18_1, arg_18_2, arg_18_3)
	else
		self:DoUnLevelUpAnim(arg_18_1, arg_18_2, arg_18_3)
	end

	return
end

function NewNavalTacticsShipCard:DoLevelUpAnim(arg_19_1, arg_19_2, arg_19_3)
	seriesAsync({
		function(arg_20_0)
			self:Curr2One(arg_19_1, arg_20_0)

			return
		end,
		function(arg_21_0)
			self:Zero2One(arg_19_1, arg_19_2, arg_21_0)

			return
		end,
		function(arg_22_0)
			self:Zero2New(arg_19_2, arg_22_0)

			return
		end
	}, arg_19_3)

	return
end

function NewNavalTacticsShipCard:Curr2One(arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1:GetNextLevelExp()

	LeanTween.value(self.skillExpSlider.gameObject, arg_23_1.exp / var_23_0, 1, 1 - arg_23_1.exp / var_23_0):setOnUpdate(System.Action_float(function(arg_24_0)
		self.skillExpSlider.value = arg_24_0

		return
	end))
	LeanTween.value(self.skillNextExp.gameObject, arg_23_1.exp, var_23_0, 1 - arg_23_1.exp / var_23_0 + 0.001):setOnUpdate(System.Action_float(function(arg_25_0)
		self.skillNextExp.text = math.ceil(arg_25_0) .. "/" .. var_23_0

		return
	end)):setOnComplete(System.Action(function()
		self.skillLevelTxt.text = arg_23_1.level + 1

		arg_23_2()

		return
	end))

	return
end

function NewNavalTacticsShipCard:Zero2One(arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_1.level + 1

	if arg_27_1.level + 1 == arg_27_2.level then
		arg_27_3()

		return
	end

	local function var_27_1(arg_28_0)
		LeanTween.value(self.skillExpSlider.gameObject, 0, 1, 0.3):setOnUpdate(System.Action_float(function(arg_29_0)
			self.skillExpSlider.value = arg_29_0

			return
		end))

		local var_28_0 = ShipSkill.StaticGetNextLevelExp(var_27_0)

		LeanTween.value(self.skillNextExp.gameObject, 0, var_28_0, 0.3 + 0.001):setOnUpdate(System.Action_float(function(arg_30_0)
			self.skillNextExp.text = math.ceil(arg_30_0) .. "/" .. var_28_0

			return
		end)):setOnComplete(System.Action(function()
			self.skillLevelTxt.text = var_27_0 + 1
			var_27_0 = var_27_0 + 1

			arg_28_0()

			return
		end))

		return
	end

	local var_27_2 = {}

	for iter_27_0 = 1, arg_27_2.level - arg_27_1.level - 1 do
		table.insert(var_27_2, var_27_1)
	end

	seriesAsync(var_27_2, arg_27_3)

	return
end

function NewNavalTacticsShipCard:Zero2New(arg_32_1, arg_32_2)
	local var_32_0 = arg_32_1:GetNextLevelExp()

	if arg_32_1.exp / var_32_0 == 0 or arg_32_1:IsMaxLevel() then
		arg_32_2()

		return
	end

	LeanTween.value(self.skillExpSlider.gameObject, 0, arg_32_1.exp / var_32_0, arg_32_1.exp / var_32_0):setOnUpdate(System.Action_float(function(arg_33_0)
		self.skillExpSlider.value = arg_33_0

		return
	end))
	LeanTween.value(self.skillNextExp.gameObject, 0, var_32_0, arg_32_1.exp / var_32_0 + 0.001):setOnUpdate(System.Action_float(function(arg_34_0)
		self.skillNextExp.text = math.ceil(arg_34_0) .. "/" .. var_32_0

		return
	end)):setOnComplete(System.Action(arg_32_2))

	return
end

function NewNavalTacticsShipCard:DoUnLevelUpAnim(arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = arg_35_2:GetNextLevelExp()

	LeanTween.value(self.skillExpSlider.gameObject, arg_35_1.exp / var_35_0, arg_35_2.exp / var_35_0, 1):setOnUpdate(System.Action_float(function(arg_36_0)
		self.skillExpSlider.value = arg_36_0

		return
	end))
	LeanTween.value(self.skillNextExp.gameObject, arg_35_1.exp, arg_35_2.exp, 1.001):setOnUpdate(System.Action_float(function(arg_37_0)
		self.skillNextExp.text = math.ceil(arg_37_0) .. "/" .. var_35_0

		return
	end)):setOnComplete(System.Action(arg_35_3))

	return
end

return NewNavalTacticsShipCard
