local IslandGetShipPage = class("IslandGetShipPage", import(".IslandBaseShipDisplayPage"))
local var_0_1 = "hi"

function IslandGetShipPage:getUIName()
	return "IslandGetShipUI"
end

function IslandGetShipPage:NeedCache()
	return false
end

function IslandGetShipPage:Preload(arg_3_1, arg_3_2)
	seriesAsync({
		function(arg_4_0)
			self:PlayTimeline(arg_4_0, arg_3_2)

			return
		end,
		function(arg_5_0)
			self:PrepareCharacterScene(arg_5_0)

			return
		end
	}, function()
		IslandGuideChecker.CheckGuide("ISLAND_GUIDE_12")
		existCall(arg_3_1)

		return
	end)

	return
end

function IslandGetShipPage:PlayTimeline(arg_7_1, arg_7_2)
	self:PlayGetShipTimeline(arg_7_2:getConfig("unit_id"), arg_7_1)

	return
end

function IslandGetShipPage:OnLoaded()
	self.mainPanel = self._tf:Find("main")
	self.radarTr = self._tf:Find("main/rader")
	self.drawPolygon = self._tf:Find("main/rader/Quad"):GetComponent("DrawPolygon")
	self.back = self._tf:Find("main/back")
	self.goBtn = self._tf:Find("main/go")
	self.chatTr = self._tf:Find("chat")
	self.chatTxt = self._tf:Find("chat/Text"):GetComponent(typeof(Text))
	self.nameTxt = self._tf:Find("main/name"):GetComponent(typeof(Text))
	self.enNameTxt = self._tf:Find("main/en"):GetComponent(typeof(Text))

	setActive(self.chatTr, false)

	local var_8_0 = {}

	var_8_0[1] = self._tf:Find("main/rader/1/Text"):GetComponent(typeof(Text))
	var_8_0[2] = self._tf:Find("main/rader/2/Text"):GetComponent(typeof(Text))
	var_8_0[3] = self._tf:Find("main/rader/3/Text"):GetComponent(typeof(Text))
	var_8_0[4] = self._tf:Find("main/rader/4/Text"):GetComponent(typeof(Text))
	var_8_0[5] = self._tf:Find("main/rader/5/Text"):GetComponent(typeof(Text))
	var_8_0[6] = self._tf:Find("main/rader/6/Text"):GetComponent(typeof(Text))
	self.radarTxts = var_8_0

	return
end

function IslandGetShipPage:GetActiveCamName()
	return IslandConst.GET_CHARA_CAMERA_NAME
end

function IslandGetShipPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.back, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.goBtn, function()
		self:Hide()
		self:OpenScenePage(IslandShipMainPage)

		return
	end, SFX_PANEL)
	self:InitRaderTxt()

	return
end

function IslandGetShipPage:OnShow(arg_14_1)
	self.ship = arg_14_1

	setActive(self.mainPanel, false)
	self:LoadCharacter(self.ship:GetModel())

	return
end

function IslandGetShipPage:OnCharLoaded()
	self.passTime = 0
	self.animator = GetOrAddComponent(self.role.transform:GetChild(0), typeof(Animator))
	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)
	self:PlayAnimation()
	self:UpdateChat(self.ship)

	return
end

function IslandGetShipPage:Update()
	self.passTime = self.passTime + Time.deltaTime

	local var_16_0 = self.animator:GetCurrentAnimatorStateInfo(0)

	if var_16_0:IsName(var_0_1) and not self.endTime then
		self.endTime = self.passTime + var_16_0.length / self.animator.speed
	end

	if self.endTime and self.passTime >= self.endTime then
		self:OnHelloAnimEnd()

		self.endTime = nil
	end

	return
end

function IslandGetShipPage:OnHelloAnimEnd()
	setActive(self.mainPanel, true)
	self:InitRader(self.ship)
	self:UpdateNames(self.ship)
	setActive(self.chatTr, false)

	if self.handle then
		UpdateBeat:RemoveListener(self.handle)

		self.handle = nil
	end

	return
end

function IslandGetShipPage:PlayAnimation()
	local var_18_0 = Animator.StringToHash(var_0_1)

	for iter_18_0 = 1, self.animator.layerCount do
		self.animator:CrossFadeInFixedTime(var_18_0, 0.2, iter_18_0 - 1)
	end

	return
end

function IslandGetShipPage:GetSmoothRotateObject()
	return self._tf:Find("main/event")
end

function IslandGetShipPage:UpdateChat(arg_20_1)
	self.chatTxt.text = arg_20_1:GetNewShipWord()

	return
end

function IslandGetShipPage:InitRaderTxt()
	for iter_21_0, iter_21_1 in ipairs(IslandShipAttr.ATTRS) do
		self.radarTxts[iter_21_0].text = IslandShipAttr.ToChinese(iter_21_1)
	end

	return
end

function IslandGetShipPage:InitRader(arg_22_1)
	local var_22_0 = {}
	local var_22_1 = {}
	local var_22_2 = IslandCalcUtil.GetUnReHexPoints(self.radarTr.rect.width - 10, self.radarTr.rect.height - 10, 30)

	table.insert(var_22_0, Vector3(0, 0, 0))

	for iter_22_0, iter_22_1 in ipairs(IslandShipAttr.ATTRS) do
		table.insert(var_22_0, self:GetPoint(var_22_2[iter_22_0], arg_22_1:GetAttr(iter_22_1), 30))
		table.insert(var_22_1, 0)
		table.insert(var_22_1, iter_22_0)

		if iter_22_0 + 1 > #IslandShipAttr.ATTRS then
			table.insert(var_22_1, 1)
		else
			table.insert(var_22_1, iter_22_0 + 1)
		end
	end

	self.drawPolygon:draw(IslandCalcUtil.Vetor3Table2Array(var_22_0), var_22_1)

	return
end

function IslandGetShipPage:GetPoint(arg_23_1, arg_23_2, arg_23_3)
	return Vector2.Normalize(arg_23_1) * (Vector2.Magnitude(arg_23_1) * Mathf.Clamp01(arg_23_2 / arg_23_3))
end

function IslandGetShipPage:UpdateNames(arg_24_1)
	self.nameTxt.text = arg_24_1:GetName()
	self.enNameTxt.text = arg_24_1:GetEnName()

	return
end

function IslandGetShipPage:OnDestroy()
	IslandGetShipPage.super.OnDestroy(self)

	if self.handle then
		UpdateBeat:RemoveListener(self.handle)

		self.handle = nil
	end

	return
end

return IslandGetShipPage
