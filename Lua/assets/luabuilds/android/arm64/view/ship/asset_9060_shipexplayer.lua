local ShipExpLayer = class("ShipExpLayer", import("..base.BaseUI"))

ShipExpLayer.TypeDefault = 0
ShipExpLayer.TypeClass = 1

function ShipExpLayer:getUIName()
	return "ShipExpUI"
end

function ShipExpLayer:init()
	self._grade = self._tf:Find("grade")
	self._gradeLabel = self._grade:Find("label")
	self._levelText = self._grade:Find("Text")
	self._main = self._tf:Find("main")
	self._leftPanel = self._main:Find("leftPanel")
	self._topBar = self._leftPanel:Find("topBar")
	self._expResult = self._leftPanel:Find("expResult")
	self._expContainer = self._expResult:Find("expContainer")
	self._extpl = self:getTpl("ShipCardTpl", self._expContainer)
	self._skipBtn = self._tf:Find("skipLayer")

	setActive(self._topBar, false)

	return
end

function ShipExpLayer:didEnter()
	self.tweenTFs = {}
	self.timerId = {}

	onButton(self, self._skipBtn, function()
		self:skip()

		return
	end, SFX_CONFIRM)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:display()

	return
end

function ShipExpLayer:display()
	setActive(self._grade, true)
	setText(self._levelText, self.contextData.title)

	if self.contextData.type == ShipExpLayer.TypeClass then
		setActive(self._gradeLabel, false)
	else
		setActive(self._gradeLabel, true)
		LoadImageSpriteAsync("battlescore/" .. (self.contextData.isCri and "grade_label_task_perfect" or "grade_label_task_complete"), self._gradeLabel, true)
	end

	local var_5_0 = self.contextData.top

	setActive(self._topBar, self.contextData.top)

	if var_5_0 then
		setText(self._topBar:Find("text_1"), var_5_0.text1)
		setText(self._topBar:Find("text_2"), var_5_0.text2)
		setText(self._topBar:Find("text_3"), var_5_0.text3)

		self._topBar:Find("progress"):GetComponent(typeof(Image)).fillAmount = var_5_0.progress
	end

	self._expTFs = {}
	self._skipExp = {}
	self._maxRightDelay = 0

	local var_5_1 = {}

	for iter_5_0, iter_5_1 in ipairs(self.contextData.newShips) do
		var_5_1[iter_5_1.id] = iter_5_1
	end

	for iter_5_2, iter_5_3 in ipairs(self.contextData.oldShips) do
		local var_5_3 = var_5_1[iter_5_3.id]
		local var_5_4 = cloneTplTo(self._extpl, self._expContainer)
		local var_5_5 = findTF(var_5_4, "content")

		var_5_4.transform.anchoredPosition = Vector3(var_5_4.transform.anchoredPosition.x + (16.2 + rtf(var_5_4).rect.width) * (iter_5_2 - 1), var_5_4.transform.anchoredPosition.y, var_5_4.transform.anchoredPosition.z)
		self._expTFs[#self._expTFs + 1] = var_5_4

		flushShipCard(var_5_4, iter_5_3)
		setScrollText(findTF(var_5_5, "info/name_mask/name"), iter_5_3:GetColorName())

		local var_5_6 = findTF(var_5_5, "dockyard/lv/Text")
		local var_5_7 = findTF(var_5_5, "dockyard/lv_bg/levelUpLabel")
		local var_5_8 = findTF(var_5_5, "dockyard/lv_bg/levelup")

		setText(var_5_6, iter_5_3.level)

		local var_5_9 = findTF(var_5_5, "exp")
		local var_5_10 = findTF(var_5_9, "exp_text")
		local var_5_11 = findTF(var_5_9, "exp_progress")

		self._maxRightDelay = math.max(self._maxRightDelay, var_5_1[iter_5_3.id].level - iter_5_3.level + iter_5_2 * 0.5)

		local function var_5_12()
			SetActive(var_5_9, true)

			local var_6_0 = iter_5_3:getLevelExpConfig().exp
			local var_6_1 = var_5_3:getLevelExpConfig().exp

			var_5_11:GetComponent(typeof(Image)).fillAmount = iter_5_3.exp / var_6_0

			if iter_5_3.level < var_5_3.level then
				local var_6_2 = 0

				for iter_6_0 = iter_5_3.level, var_5_3.level - 1 do
					var_6_2 = var_6_2 + iter_5_3:getLevelExpConfig(iter_6_0).exp
				end

				self:PlayAnimation(var_5_4, 0, var_6_2 + var_5_3.exp - iter_5_3.exp, 1, 0, function(arg_7_0)
					setText(var_5_10, "+" .. math.ceil(arg_7_0))

					return
				end)

				local function var_6_3(arg_8_0)
					SetActive(var_5_7, true)
					SetActive(var_5_8, true)

					local var_8_0 = var_5_7.localPosition

					LeanTween.moveY(rtf(var_5_7), var_5_7.localPosition.y + 30, 0.5):setOnComplete(System.Action(function()
						SetActive(var_5_7, false)

						var_5_7.localPosition = var_8_0

						pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_BOAT_LEVEL_UP)

						return
					end))
					setText(var_5_6, arg_8_0)
					table.insert(self.tweenTFs, var_5_7)

					return
				end

				LeanTween.value(go(var_5_4), iter_5_3.exp / var_6_0, 1, 0.5):setOnUpdate(System.Action_float(function(arg_10_0)
					var_5_11:GetComponent(typeof(Image)).fillAmount = arg_10_0

					return
				end)):setOnComplete(System.Action(function()
					var_6_3(iter_5_3.level + 1)

					local var_11_0 = 0.1

					while iter_5_3.level + 1 + 1 <= var_5_3.level do
						local var_11_1 = iter_5_3.level + 1 + 1

						LeanTween.value(go(var_5_4), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_12_0)
							var_5_11:GetComponent(typeof(Image)).fillAmount = arg_12_0

							return
						end)):setDelay(var_11_0):setOnComplete(System.Action(function()
							var_6_3(var_11_1)

							return
						end))

						var_11_0 = var_11_0 + 1
					end

					self.timerId[iter_5_3.id] = pg.TimeMgr.GetInstance():AddTimer("delayTimer", var_11_0, 0, function()
						if var_5_3.level == var_5_3:getMaxLevel() then
							var_5_11:GetComponent(typeof(Image)).fillAmount = 1
							self._skipExp[iter_5_2] = false

							return
						end

						self:PlayAnimation(var_5_4, 0, var_5_3.exp / var_6_1, 0.5, 0, function(arg_15_0)
							var_5_11:GetComponent(typeof(Image)).fillAmount = arg_15_0
							self._skipExp[iter_5_2] = false

							return
						end)

						return
					end)

					return
				end))
				table.insert(self.tweenTFs, var_5_4)
			else
				setText(var_5_10, "+" .. math.ceil(var_5_3:getExp() - iter_5_3:getExp()))

				if iter_5_3.level == iter_5_3:getMaxLevel() then
					var_5_11:GetComponent(typeof(Image)).fillAmount = 1
					self._skipExp[iter_5_2] = false

					return
				end

				self:PlayAnimation(var_5_4, iter_5_3.exp / var_6_0, var_5_3.exp / var_6_0, 1, 0, function(arg_16_0)
					var_5_11:GetComponent(typeof(Image)).fillAmount = arg_16_0
					self._skipExp[iter_5_2] = false

					return
				end)
			end

			return
		end

		self._skipExp[iter_5_2] = function()
			LeanTween.cancel(go(var_5_7))
			LeanTween.cancel(go(var_5_4))
			SetActive(var_5_4, true)
			SetActive(var_5_9, true)
			setText(var_5_6, var_5_3.level)

			if iter_5_3.level == iter_5_3:getMaxLevel() then
				setText(var_5_10, "+" .. math.ceil(var_5_3:getExp() - iter_5_3:getExp()))

				var_5_11:GetComponent(typeof(Image)).fillAmount = 1
			else
				if iter_5_3.level < var_5_3.level then
					local var_17_0 = 0

					for iter_17_0 = iter_5_3.level, var_5_3.level - 1 do
						var_17_0 = var_17_0 + iter_5_3:getLevelExpConfig(iter_17_0).exp
					end

					setText(var_5_10, "+" .. var_17_0 + var_5_3.exp - iter_5_3.exp)
				else
					setText(var_5_10, "+" .. math.ceil(var_5_3.exp - iter_5_3.exp))
				end

				var_5_11:GetComponent(typeof(Image)).fillAmount = var_5_3.exp / var_5_3:getLevelExpConfig().exp
			end

			SetActive(var_5_7, false)

			var_5_4:GetComponent("CanvasGroup").alpha = 1
			rtf(var_5_4).anchoredPosition = Vector2(rtf(var_5_4).anchoredPosition.x, 0)

			return
		end

		local var_5_13 = var_5_4:GetComponent("CanvasGroup")

		setActive(var_5_4, false)
		LeanTween.moveY(rtf(var_5_4), 0, 0.2):setOnComplete(System.Action(function()
			setActive(var_5_4, true)
			var_5_12()

			return
		end)):setDelay(iter_5_2 * 0.2)
		table.insert(self.tweenTFs, var_5_4)
		LeanTween.value(go(var_5_4), 0, 1, 0.2):setOnUpdate(System.Action_float(function(arg_19_0)
			var_5_13.alpha = arg_19_0

			return
		end)):setDelay(iter_5_2 * 0.2)
	end

	return
end

function ShipExpLayer:skip()
	if _.any(self._skipExp, function(arg_21_0)
		return arg_21_0
	end) then
		for iter_20_0 = 1, #self._skipExp do
			if self._skipExp[iter_20_0] then
				self._skipExp[iter_20_0]()

				self._skipExp[iter_20_0] = false
			end
		end
	else
		self:emit(BaseUI.ON_CLOSE)
	end

	return
end

function ShipExpLayer:PlayAnimation(arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6)
	LeanTween.value(arg_22_1.gameObject, arg_22_2, arg_22_3, arg_22_4):setDelay(arg_22_5):setOnUpdate(System.Action_float(function(arg_23_0)
		arg_22_6(arg_23_0)

		return
	end))
	table.insert(self.tweenTFs, arg_22_1)

	return
end

function ShipExpLayer:willExit()
	for iter_24_0, iter_24_1 in pairs(self.tweenTFs) do
		if LeanTween.isTweening(go(iter_24_1)) then
			LeanTween.cancel(go(iter_24_1))
		end
	end

	self.tweenTFs = nil

	for iter_24_2, iter_24_3 in pairs(self.timerId) do
		pg.TimeMgr.GetInstance():RemoveTimer(iter_24_3)
	end

	self.timerId = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return ShipExpLayer
