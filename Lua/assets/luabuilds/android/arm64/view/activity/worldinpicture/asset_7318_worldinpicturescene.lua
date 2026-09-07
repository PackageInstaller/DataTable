local WorldInPictureScene = class("WorldInPictureScene", import("...base.BaseUI"))
local var_0_1 = 0
local var_0_2 = 1

function WorldInPictureScene:getUIName()
	return "WorldInPictureUI"
end

function WorldInPictureScene:emit(...)
	if self.inAniming then
		return
	end

	WorldInPictureScene.super.emit(self, ...)

	return
end

function WorldInPictureScene:OnOpenCellErro(arg_3_1)
	if arg_3_1 then
		self.onkeyTravelProcess = false

		self:UpdateTravelBtnState()
	end

	return
end

function WorldInPictureScene:OnOpenCell(arg_4_1, arg_4_2, arg_4_3)
	self:CloseSelector(arg_4_1, arg_4_2)
	self:HideBox(arg_4_1, arg_4_2)

	self.inAniming = true

	local var_4_0 = self.cells[arg_4_1][arg_4_2]

	self:DoAnimtion("picture_faguang", self.cells[arg_4_1][arg_4_2].gameObject.transform.anchoredPosition, function()
		var_4_0.alpha = 1

		if arg_4_3 and self.data:ExistBox(arg_4_1, arg_4_2) then
			self:RpAnim(arg_4_1, arg_4_2)
		end

		self:HightLightOpenArea(arg_4_1, arg_4_2)
		self:UpdatePoints()
		self:UpdateSwitcherState()
		self:UpdateChar(Vector2(arg_4_1, arg_4_2), not self.data:IsFirstTravel())
		self:SaveCharPosition(arg_4_1, arg_4_2)

		self.inAniming = false
		self.forceStopTravelPorcess = false

		if arg_4_3 then
			self.onkeyTravelProcess = false

			self:UpdateTravelBtnState()

			if not self.onkeyTravelProcess or not self.data:FindNextTravelable() then
				self:emit(WorldInPictureMediator.RESULT_ONEKEY_AWARD)
			elseif self.onkeyTravelProcess == true then
				triggerButton(self.onekeyTravelBtn)
			end
		end

		return
	end)

	return
end

function WorldInPictureScene:CloseSelector(arg_6_1, arg_6_2)
	if self.data:IsFirstTravel() then
		for iter_6_0, iter_6_1 in ipairs(self.selectors) do
			for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
				iter_6_3.alpha = 0
			end
		end
	else
		local var_6_0 = self.selectors[arg_6_1][arg_6_2]

		if self.selectors[arg_6_1][arg_6_2] and var_6_0.alpha ~= 0 then
			var_6_0.alpha = 0
		end
	end

	return
end

function WorldInPictureScene:HightLightOpenArea(arg_7_1, arg_7_2)
	_.each({
		Vector2(arg_7_1 + 1, arg_7_2),
		Vector2(arg_7_1, arg_7_2 + 1),
		Vector2(arg_7_1 - 1, arg_7_2),
		Vector2(arg_7_1, arg_7_2 - 1)
	}, function(arg_8_0)
		if self.data:IsOpened(arg_8_0.x, arg_8_0.y) or self.data:OutSide(arg_8_0.x, arg_8_0.y) then
			return
		end

		if not self.selectors[arg_8_0.x] or not self.selectors[arg_8_0.x][arg_8_0.y] then
			self:CreateSelector(arg_8_0.x, arg_8_0.y)
		else
			self.selectors[arg_8_0.x][arg_8_0.y].alpha = 1
		end

		return
	end)

	return
end

function WorldInPictureScene:RpAnim(arg_9_1, arg_9_2)
	local var_9_0 = self:GetRedPacket()

	var_9_0.anchoredPosition = self.cells[arg_9_1][arg_9_2].gameObject.transform.anchoredPosition + Vector2(48, 48)

	LeanTween.value(var_9_0.gameObject, var_9_0.anchoredPosition.y, var_9_0.anchoredPosition.y + 35, 0.75):setOnUpdate(System.Action_float(function(arg_10_0)
		var_9_0.anchoredPosition = Vector2(var_9_0.anchoredPosition.x, arg_10_0)

		return
	end)):setOnComplete(System.Action(function()
		if self.exited then
			return
		end

		setActive(var_9_0, false)
		table.insert(self.redpackets, var_9_0)

		return
	end))

	return
end

function WorldInPictureScene:HideBox(arg_12_1, arg_12_2)
	local var_12_0

	if self.boxes[arg_12_1] then
		var_12_0 = self.boxes[arg_12_1][arg_12_2]
	end

	if var_12_0 then
		var_12_0.alpha = 0
	end

	return
end

function WorldInPictureScene:OnDrawAreaErro(arg_13_1)
	if arg_13_1 then
		self.onkeyDrawPorcess = false

		self:UpdateDrawBtnState()
	end

	return
end

function WorldInPictureScene:OnDrawArea(arg_14_1, arg_14_2, arg_14_3)
	self:HideDrawarea(arg_14_1, arg_14_2)

	self.inAniming = true

	self:CreateAnimal(arg_14_1, arg_14_2, false, function(arg_15_0)
		local var_15_0 = self.data:GetDrawAnimData(arg_14_1, arg_14_2)

		self:DoAnimtion("picture_bichu", Vector2(var_15_0[2] + (arg_15_0.sizeDelta.x * arg_15_0.localScale.x * 0.5 + 90), var_15_0[3] - arg_15_0.sizeDelta.y * arg_15_0.localScale.y * 0.5), function()
			LeanTween.value(arg_15_0.gameObject, 0, 1, 0.5):setOnUpdate(System.Action_float(function(arg_17_0)
				if self.exited then
					return
				end

				arg_15_0:GetComponent(typeof(CanvasGroup)).alpha = arg_17_0

				return
			end))
			self:UpdatePoints()

			self.inAniming = false
			self.forceStopDrawPorcess = false

			if arg_14_3 then
				self.onkeyDrawPorcess = false

				self:UpdateDrawBtnState()

				if not self.onkeyDrawPorcess or not self.data:FindNextDrawableAreaHead() then
					self:emit(WorldInPictureMediator.RESULT_ONEKEY_AWARD)
				elseif arg_14_3 and self.onkeyDrawPorcess == true then
					triggerButton(self.onekeyDrawBtn)
				end
			end

			return
		end)

		return
	end)

	return
end

function WorldInPictureScene:HideDrawarea(arg_18_1, arg_18_2)
	local var_18_0

	if self.drawableAare[arg_18_1] then
		var_18_0 = self.drawableAare[arg_18_1][arg_18_2]
	end

	if var_18_0 then
		var_18_0.alpha = 0
	end

	return
end

function WorldInPictureScene:SetData(arg_19_1)
	self.data = arg_19_1

	return
end

function WorldInPictureScene:init()
	Input.multiTouchEnabled = false
	self.redpacket = self._tf:Find("redpackets/redpacket")
	self.lineHrzTpl = self._tf:Find("lines/line_hrz")
	self.lineVecTpl = self._tf:Find("lines/line_vec")
	self.animalTpl = self._tf:Find("animals/animal")
	self.areaTpl = self._tf:Find("drawablearea/area")
	self.boxTpl = self._tf:Find("boxes/box")
	self.selectorTpl = self._tf:Find("selectors/selector")
	self.tpl = self._tf:Find("grids/grid")
	self.backBtn = self._tf:Find("back")
	self.helpBtn = self._tf:Find("help")
	self.travelPointTxt = self._tf:Find("points/travel"):GetComponent(typeof(Text))
	self.drawPointTxt = self._tf:Find("points/draw"):GetComponent(typeof(Text))
	self.travelProgressTxt = self._tf:Find("progress/travel"):GetComponent(typeof(Text))
	self.drawProgressTxt = self._tf:Find("progress/draw"):GetComponent(typeof(Text))
	self.switchBtn = self._tf:Find("swticher")
	self.onDisable = self.switchBtn:Find("on_disable")
	self.btnOn = self.switchBtn:Find("on_enable/draw")
	self.btnOff = self.switchBtn:Find("on_enable/off")
	self.onekeyTravelBtn = self._tf:Find("onekey_travel")
	self.onekeyTravelingBtn = self._tf:Find("onekey_travel/Image")
	self.onekeyDrawBtn = self._tf:Find("onekey_draw")
	self.onekeyDrawingBtn = self._tf:Find("onekey_draw/Image")
	self.char = self._tf:Find("char/char")

	setActive(self.char, false)

	self.selectorContainer = self._tf:Find("selectors"):GetComponent(typeof(CanvasGroup))
	self.drawableAreaContainer = self._tf:Find("drawablearea"):GetComponent(typeof(CanvasGroup))
	self.startPos = self.tpl.anchoredPosition
	self.offset = Vector2(0.5, 0.5)
	self.width = self.tpl.sizeDelta.x
	self.height = self.tpl.sizeDelta.y
	self.cells = {}
	self.selectors = {}
	self.boxes = {}
	self.drawableAare = {}
	self.animals = {}
	self.redpackets = {
		self.redpacket
	}

	return
end

function WorldInPictureScene:didEnter()
	onButton(self, self.backBtn, function()
		if self.opType == var_0_1 and self.onkeyTravelProcess then
			self.onkeyTravelProcess = false

			self:UpdateTravelBtnState()

			return
		elseif self.opType == var_0_2 and self.onkeyDrawPorcess then
			self.onkeyDrawPorcess = false

			self:UpdateDrawBtnState()

			return
		end

		self:emit(WorldInPictureScene.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.worldinpicture_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.onekeyTravelBtn, function()
		if self.forceStopTravelPorcess then
			return
		end

		if self.data:IsTravelAll() then
			return
		end

		if self.data:GetTravelPoint() <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("worldinpicture_tavel_point_tip"))

			return
		end

		if self.onkeyTravelProcess then
			self.onkeyTravelProcess = false
			self.forceStopTravelPorcess = true

			self:UpdateTravelBtnState()

			return
		end

		local var_24_0, var_24_1 = self.data:FindNextTravelable()

		if var_24_0 and var_24_1 then
			self.onkeyTravelProcess = true

			self:UpdateTravelBtnState()
			self:emit(WorldInPictureMediator.ON_AUTO_TRAVEL, var_24_0.x, var_24_0.y, var_24_1)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.onekeyDrawBtn, function()
		if self.forceStopDrawPorcess then
			return
		end

		if self.data:IsDrawAll() then
			return
		end

		if self.data:GetDrawPoint() <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("worldinpicture_draw_point_tip"))

			return
		end

		if self.onkeyDrawPorcess then
			self.onkeyDrawPorcess = false
			self.forceStopDrawPorcess = true

			self:UpdateDrawBtnState()

			return
		end

		local var_25_0, var_25_1 = self.data:FindNextDrawableAreaHead()

		if var_25_0 and var_25_1 then
			self.onkeyDrawPorcess = true

			self:UpdateDrawBtnState()
			self:emit(WorldInPictureMediator.ON_AUTO_DRAW, var_25_0.x, var_25_0.y, var_25_1)
		end

		return
	end, SFX_PANEL)

	self.opType = var_0_1

	onButton(self, self.onDisable, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("worldinpicture_not_area_can_draw"))

		return
	end, SFX_PANEL)
	onButton(self, self.btnOn, function()
		if self.opType == var_0_1 and self.onkeyTravelProcess then
			self.onkeyTravelProcess = false

			self:UpdateTravelBtnState()

			return
		elseif self.opType == var_0_2 and self.onkeyDrawPorcess then
			self.onkeyDrawPorcess = false

			self:UpdateDrawBtnState()

			return
		end

		if self.inAniming then
			return
		end

		self.opType = var_0_2

		self:UpdateSwitcherState()

		return
	end, SFX_PANEL)
	onButton(self, self.btnOff, function()
		if self.opType == var_0_1 and self.onkeyTravelProcess then
			self.onkeyTravelProcess = false

			self:UpdateTravelBtnState()

			return
		elseif self.opType == var_0_2 and self.onkeyDrawPorcess then
			self.onkeyDrawPorcess = false

			self:UpdateDrawBtnState()

			return
		end

		if self.inAniming then
			return
		end

		self.opType = var_0_1

		self:UpdateSwitcherState()

		return
	end, SFX_PANEL)
	self:UpdateSwitcherState()
	self:InitView()

	return
end

function WorldInPictureScene:UpdateDrawBtnState()
	setActive(self.onekeyDrawingBtn, self.onkeyDrawPorcess)

	return
end

function WorldInPictureScene:UpdateTravelBtnState()
	setActive(self.onekeyTravelingBtn, self.onkeyTravelProcess)

	return
end

function WorldInPictureScene:GetRecordCharPos()
	local var_31_0 = getProxy(PlayerProxy)

	return Vector2(tonumber(var_31_0[1]), tonumber(string.split(PlayerPrefs.GetString("WorldInPictureScene_1" .. var_31_0:getRawData().id, "0#0"), "#")[2]))
end

function WorldInPictureScene:SaveCharPosition(arg_32_1, arg_32_2)
	PlayerPrefs.SetString("WorldInPictureScene_1" .. getProxy(PlayerProxy):getRawData().id, arg_32_1 .. "#" .. arg_32_2)
	PlayerPrefs.Save()

	return
end

function WorldInPictureScene:moveChar(arg_33_1, arg_33_2, arg_33_3)
	if LeanTween.isTweening(go(self.char)) then
		LeanTween.cancel(go(self.char))
	end

	if isActive(self.char) then
		self:hideChar(function()
			self:showChar(arg_33_1, arg_33_2, arg_33_3)

			return
		end)
	else
		self:showChar(arg_33_1, arg_33_2, arg_33_3)
	end

	return
end

function WorldInPictureScene:showChar(arg_35_1, arg_35_2, arg_35_3)
	self.char.transform.localPosition = Vector3(arg_35_1, arg_35_2 + 50)

	setActive(self.char, true)
	LeanTween.value(go(self.char), 0, 1, 0.2):setOnUpdate(System.Action_float(function(arg_36_0)
		GetOrAddComponent(self.char, typeof(CanvasGroup)).alpha = arg_36_0

		return
	end))
	LeanTween.moveLocal(go(self.char), Vector3(arg_35_1, arg_35_2, 0), 0.2):setOnComplete(System.Action(function()
		if arg_35_3 then
			arg_35_3()
		end

		return
	end))

	return
end

function WorldInPictureScene:hideChar(arg_38_1)
	LeanTween.value(go(self.char), 1, 0, 0.2):setOnUpdate(System.Action_float(function(arg_39_0)
		GetOrAddComponent(self.char, typeof(CanvasGroup)).alpha = arg_39_0

		return
	end))
	LeanTween.moveLocal(go(self.char), Vector3(self.char.transform.localPosition.x, self.char.transform.localPosition.y + 50, 0), 0.2):setOnComplete(System.Action(function()
		setActive(self.char, false)

		if arg_38_1 then
			arg_38_1()
		end

		return
	end))

	return
end

function WorldInPictureScene:UpdateChar(arg_41_1, arg_41_2)
	if arg_41_1 == Vector2.zero then
		setActive(self.char, false)

		return
	end

	if LeanTween.isTweening(self.char) then
		LeanTween.cancel(self.char)
	end

	if self.data:IsTravelAll() then
		setActive(self.char, false)

		return
	end

	local var_41_0 = Vector2(self.cells[arg_41_1.x][arg_41_1.y].gameObject.transform.anchoredPosition.x, self.cells[arg_41_1.x][arg_41_1.y].gameObject.transform.anchoredPosition.y - 50)

	if arg_41_2 then
		self:moveChar(var_41_0.x, var_41_0.y, function()
			return
		end)
	else
		self.char.transform.localPosition = var_41_0
	end

	return
end

function WorldInPictureScene:UpdateSwitcherState()
	local var_43_0 = self.opType == var_0_2
	local var_43_1 = self.data:AnyAreaCanDraw()

	setActive(self.btnOff, self.opType == var_0_2)
	setActive(self.onDisable, not var_43_0 and not var_43_1)
	setActive(self.btnOn, not var_43_0 and var_43_1)
	setActive(self.onekeyTravelBtn, not var_43_0)
	setActive(self.onekeyDrawBtn, var_43_0)
	setActive(self.char, not var_43_0 and not self.data:IsTravelAll())

	self.selectorContainer.alpha = var_43_0 and 0 or 1
	self.drawableAreaContainer.alpha = var_43_0 and 1 or 0

	if var_43_0 then
		self:UpdateDrawableAreas()
	end

	return
end

function WorldInPictureScene:InitView()
	local var_44_0, var_44_1 = self.data:GetMapRowAndColumn()
	local var_44_2 = {}

	for iter_44_0 = 1, var_44_0 do
		table.insert(var_44_2, function(arg_45_0)
			for iter_45_0 = var_44_1, 1, -1 do
				self:CreateCell(iter_44_0, iter_45_0, (iter_44_0 - 1) * var_44_1 + iter_45_0)
			end

			onNextTick(arg_45_0)

			return
		end)
	end

	seriesAsync(var_44_2, function()
		self:InitLines()
		self:UpdateChar(self:GetRecordCharPos())

		return
	end)
	self:UpdatePoints()

	return
end

function WorldInPictureScene:InitLines()
	local var_47_0, var_47_1 = self.data:GetMapRowAndColumn()
	local var_47_2 = self.tpl.sizeDelta.y * var_47_0 + 10

	for iter_47_0 = 1, var_47_1 - 1 do
		local var_47_3

		if iter_47_0 == 1 then
			var_47_3 = self.lineVecTpl or Object.Instantiate(self.lineVecTpl, self.lineVecTpl.parent)
		end

		var_47_3.sizeDelta = Vector2(var_47_3.sizeDelta.x, var_47_2)
		var_47_3.anchoredPosition = Vector2(self.cells[1][iter_47_0].gameObject.transform.anchoredPosition.x + self.cells[1][iter_47_0].gameObject.transform.sizeDelta.x * 0.5 + self.offset.x, var_47_3.anchoredPosition.y)
	end

	local var_47_4 = self.tpl.sizeDelta.x * var_47_1 + 20

	for iter_47_1 = 1, var_47_0 - 1 do
		local var_47_5

		if iter_47_1 == 1 then
			var_47_5 = self.lineHrzTpl or Object.Instantiate(self.lineHrzTpl, self.lineHrzTpl.parent)
		end

		var_47_5.sizeDelta = Vector2(var_47_5.sizeDelta.x, var_47_4)
		var_47_5.anchoredPosition = Vector2(var_47_5.anchoredPosition.x, self.cells[iter_47_1][1].gameObject.transform.anchoredPosition.y - self.cells[iter_47_1][1].gameObject.transform.sizeDelta.y * 0.5 + self.offset.y)
	end

	return
end

function WorldInPictureScene:CreateCell(arg_48_1, arg_48_2, arg_48_3)
	if self.exited then
		return
	end

	local var_48_0

	if arg_48_2 == 1 and arg_48_1 == 1 then
		var_48_0 = self.tpl or Object.Instantiate(self.tpl, self.tpl.parent).transform
	end

	local var_48_1 = self.startPos.x + (arg_48_2 - 1) * (self.width + self.offset.x)
	local var_48_2 = self.startPos.y - (arg_48_1 - 1) * (self.height + self.offset.y)

	LoadSpriteAtlasAsync("ui/WorldInPicture_atlas", "view_" .. arg_48_3 - 1, function(arg_49_0)
		if self.exited then
			return
		end

		local var_49_0 = var_48_0:GetComponent(typeof(Image))

		var_49_0.sprite = arg_49_0

		var_49_0:SetNativeSize()

		var_48_0.anchoredPosition = Vector2(var_48_1, var_48_2)

		self:CreateSelector(arg_48_1, arg_48_2)
		self:CreateBox(arg_48_1, arg_48_2)
		self:CreateDrawableArea(arg_48_1, arg_48_2)
		self:CreateAnimal(arg_48_1, arg_48_2, true)

		return
	end)

	self.cells[arg_48_1] = self.cells[arg_48_1] or {}

	onButton(self, var_48_0, function()
		if self.opType == var_0_1 then
			if self.onkeyTravelProcess then
				self.onkeyTravelProcess = false

				self:UpdateTravelBtnState()

				return
			end

			if self.data:IsTravelAll() then
				return
			end

			if self.data:GetTravelPoint() <= 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("worldinpicture_tavel_point_tip"))

				return
			end

			if self.data:CanSelect(arg_48_1, arg_48_2) then
				self:emit(WorldInPictureMediator.ON_TRAVEL, arg_48_1, arg_48_2, arg_48_3)
			end
		elseif self.opType == var_0_2 then
			if self.onkeyDrawPorcess then
				self.onkeyDrawPorcess = false

				self:UpdateDrawBtnState()

				return
			end

			if self.data:IsDrawAll() then
				return
			end

			if self.data:GetDrawPoint() <= 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("worldinpicture_draw_point_tip"))

				return
			end

			if self.data:CanDraw(arg_48_1, arg_48_2) then
				local var_50_0, var_50_1, var_50_2 = self.data:Convert2DrawAreaHead(arg_48_1, arg_48_2)

				self:emit(WorldInPictureMediator.ON_DRAW, var_50_0, var_50_1, var_50_2)
			end
		end

		return
	end, SFX_PANEL)

	local var_48_3 = var_48_0:GetComponent(typeof(CanvasGroup))

	var_48_3.alpha = self.data:IsOpened(arg_48_1, arg_48_2) and 1 or 0
	self.cells[arg_48_1][arg_48_2] = var_48_3

	return
end

function WorldInPictureScene:CreateSelector(arg_51_1, arg_51_2)
	if not self.data:CanSelect(arg_51_1, arg_51_2) then
		return
	end

	local var_51_0

	if table.getCount(self.selectors) == 0 then
		var_51_0 = self.selectorTpl or Object.Instantiate(self.selectorTpl, self.selectorTpl.parent).transform
	end

	var_51_0.anchoredPosition = self.cells[arg_51_1][arg_51_2].gameObject.transform.anchoredPosition + Vector2(-5, -4.8)

	local var_51_1 = var_51_0:GetComponent(typeof(CanvasGroup))

	var_51_1.alpha = 1
	self.selectors[arg_51_1] = self.selectors[arg_51_1] or {}
	self.selectors[arg_51_1][arg_51_2] = var_51_1

	return
end

function WorldInPictureScene:CreateBox(arg_52_1, arg_52_2)
	if not self.data:ExistBox(arg_52_1, arg_52_2) or self.data:IsOpened(arg_52_1, arg_52_2) then
		return
	end

	local var_52_0

	if table.getCount(self.boxes) == 0 then
		var_52_0 = self.boxTpl or Object.Instantiate(self.boxTpl, self.boxTpl.parent).transform
	end

	local var_52_1 = var_52_0:GetComponent(typeof(CanvasGroup))

	var_52_1.alpha = 1
	var_52_0.anchoredPosition = self.cells[arg_52_1][arg_52_2].gameObject.transform.anchoredPosition
	self.boxes[arg_52_1] = self.boxes[arg_52_1] or {}
	self.boxes[arg_52_1][arg_52_2] = var_52_1

	return
end

function WorldInPictureScene:CreateDrawableArea(arg_53_1, arg_53_2)
	local var_53_0 = self.data:GetDrawableArea(arg_53_1, arg_53_2)

	if not var_53_0 or self.data:IsDrawed(arg_53_1, arg_53_2) then
		return
	end

	local var_53_1

	if table.getCount(self.drawableAare) == 0 then
		var_53_1 = self.areaTpl or Object.Instantiate(self.areaTpl, self.areaTpl.parent).transform
	end

	local var_53_2 = var_53_0[#var_53_0] - var_53_0[1] + Vector2(1, 1)

	var_53_1.anchoredPosition = self.cells[arg_53_1][arg_53_2].gameObject.transform.anchoredPosition - Vector2((self.tpl.sizeDelta * 0.5).x, -(self.tpl.sizeDelta * 0.5).y)

	local var_53_3 = var_53_1:GetComponent(typeof(CanvasGroup))

	var_53_3.alpha = 1
	self.drawableAare[arg_53_1] = self.drawableAare[arg_53_1] or {}
	self.drawableAare[arg_53_1][arg_53_2] = var_53_3

	return
end

function WorldInPictureScene:UpdateDrawableAreas()
	for iter_54_0, iter_54_1 in ipairs((self.data:GetDrawableAreasState())) do
		local var_54_0 = iter_54_1.position

		if self.drawableAare[iter_54_1.position.x] and self.drawableAare[var_54_0.x][var_54_0.y] then
			self.drawableAare[var_54_0.x][var_54_0.y].alpha = iter_54_1.open and 1 or 0
		end
	end

	return
end

function WorldInPictureScene:CreateAnimal(arg_55_1, arg_55_2, arg_55_3, arg_55_4)
	if not self.data:GetDrawableArea(arg_55_1, arg_55_2) or not self.data:IsDrawed(arg_55_1, arg_55_2) then
		return
	end

	local var_55_0

	if table.getCount(self.animals) == 0 then
		var_55_0 = self.animalTpl or Object.Instantiate(self.animalTpl, self.animalTpl.parent).transform
	end

	local var_55_1 = self.data:GetDrawAnimData(arg_55_1, arg_55_2)

	LoadSpriteAtlasAsync("ui/WorldInPicture_atlas", var_55_1[1], function(arg_56_0)
		if self.exited then
			return
		end

		local var_56_0 = var_55_0:GetComponent(typeof(Image))

		var_56_0.sprite = arg_56_0

		var_56_0:SetNativeSize()

		var_55_0.localScale = Vector3(var_55_1[4] or 1, var_55_1[4] or 1, 1)

		if arg_55_4 then
			arg_55_4(var_55_0)
		end

		return
	end)

	var_55_0.localScale = Vector3.zero
	var_55_0.localPosition = Vector2(var_55_1[2], var_55_1[3])
	self.animals[arg_55_1] = self.animals[arg_55_1] or {}

	local var_55_2 = var_55_0:GetComponent(typeof(CanvasGroup))

	var_55_2.alpha = arg_55_3 and 1 or 0
	self.animals[arg_55_1][arg_55_2] = var_55_2

	return
end

local function var_0_3(arg_57_0, arg_57_1)
	return "<color=#DAC6B3>" .. arg_57_0 .. "</color><color=#A38052>/" .. arg_57_1 .. "</color>"
end

function WorldInPictureScene:UpdatePoints()
	self.travelPointTxt.text = self.data:GetTravelPoint()
	self.drawPointTxt.text = self.data:GetDrawPoint()
	self.travelProgressTxt.text = var_0_3(self.data:GetTravelProgress(), self.data:GetMaxTravelCnt())
	self.drawProgressTxt.text = var_0_3(self.data:GetDrawProgress(), self.data:GetMaxDrawCnt())

	return
end

function WorldInPictureScene:DoAnimtion(arg_59_1, arg_59_2, arg_59_3)
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	local function var_59_0(arg_60_0)
		self[arg_59_1] = arg_60_0
		arg_60_0.anchoredPosition = arg_59_2

		setActive(arg_60_0, true)

		self.timer = Timer.New(function()
			setActive(arg_60_0, false)
			self.timer:Stop()

			self.timer = nil

			arg_59_3()

			return
		end, 0.6, 1)

		self.timer:Start()

		return
	end

	if not self[arg_59_1] then
		self:LoadEffect(arg_59_1, var_59_0)
	else
		var_59_0(self[arg_59_1])
	end

	return
end

function WorldInPictureScene:GetRedPacket()
	if #self.redpackets <= 0 then
		table.insert(self.redpackets, Object.Instantiate(self.redpacket, self.redpacket.parent).transform)
	end

	local var_62_0 = table.remove(self.redpackets, 1)

	setActive(var_62_0, true)

	return var_62_0
end

function WorldInPictureScene:LoadEffect(arg_63_1, arg_63_2)
	ResourceMgr.Inst:getAssetAsync("UI/" .. arg_63_1, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_64_0)
		if self.exited then
			return
		end

		arg_63_2(Object.Instantiate(arg_64_0, self._tf).transform)

		return
	end), true, true)

	return
end

function WorldInPictureScene:willExit()
	for iter_65_0, iter_65_1 in ipairs(self.redpackets) do
		if LeanTween.isTweening(iter_65_1.gameObject) then
			LeanTween.cancel(iter_65_1)
		end
	end

	if LeanTween.isTweening(self.char) then
		LeanTween.cancel(self.char)
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	Input.multiTouchEnabled = true

	return
end

return WorldInPictureScene
