local SculpturePuzzlePage = class("SculpturePuzzlePage", import("view.base.BaseSubView"))

function SculpturePuzzlePage:getUIName()
	return "SculpturePuzzleUI"
end

function SculpturePuzzlePage:OnLoaded()
	self.backBtn = self._tf:Find("back")
	self.lineTr = self._tf:Find("frame/line")
	self.frameTr = self._tf:Find("frame")
	self.tipBtn = self._tf:Find("frame/tip")
	self.tipGrayBtn = self._tf:Find("frame/tip_gray")
	self.tipGrayBtnTxt = self.tipGrayBtn:Find("Text"):GetComponent(typeof(Text))

	setActive(self.tipGrayBtn, false)
	setText(self._tf:Find("frame/tip_text"), i18n("sculpture_puzzle_tip"))

	return
end

function SculpturePuzzlePage:OnInit()
	self.slots = {}

	return
end

function SculpturePuzzlePage:Show(arg_4_1, arg_4_2, arg_4_3)
	SculpturePuzzlePage.super.Show(self)
	self:Clear()

	self.id = arg_4_1
	self.activity = arg_4_2

	if arg_4_3 then
		arg_4_3()
	end

	seriesAsync({
		function(arg_5_0)
			self:LoadLine(arg_5_0)

			return
		end,
		function(arg_6_0)
			self:LoadPuzzle(arg_6_0)

			return
		end
	}, function()
		self:RegisterEvent()

		return
	end)
	pg.BgmMgr.GetInstance():Push(self.__cname, "bar-soft")

	return
end

function SculpturePuzzlePage:LoadLine(arg_8_1)
	ResourceMgr.Inst:getAssetAsync("ui/" .. self.activity:GetResorceName(self.id) .. "_puzzle_line", "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_9_0)
		local var_9_0 = Object.Instantiate(arg_9_0, self.lineTr)

		eachChild(var_9_0, function(arg_10_0)
			self.slots[arg_10_0.gameObject.name] = {
				flag = false,
				tr = arg_10_0
			}

			return
		end)

		self.puzzleLine = var_9_0

		arg_8_1()

		return
	end), true, true)

	return
end

function Screen2Local(arg_11_0, arg_11_1)
	return (LuaHelper.ScreenToLocal(arg_11_0:GetComponent("RectTransform"), arg_11_1, (GameObject.Find("UICamera"):GetComponent("Camera"))))
end

function TrPosition2LocalPos(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0 == arg_12_1 then
		return arg_12_2
	else
		local var_12_0 = arg_12_1:InverseTransformPoint((arg_12_0:TransformPoint(arg_12_2)))

		return Vector3(var_12_0.x, var_12_0.y, 0)
	end

	return
end

function SculpturePuzzlePage:HandlePuzzlePart(arg_13_1)
	eachChild(arg_13_1, function(arg_14_0)
		local var_14_0 = arg_14_0:GetComponent(typeof(EventTriggerListener))
		local var_14_1
		local var_14_2

		var_14_0:AddBeginDragFunc(function()
			var_14_2 = arg_14_0:GetSiblingIndex()

			arg_14_0:SetAsLastSibling()

			var_14_1 = arg_14_0.localPosition

			return
		end)
		var_14_0:AddDragFunc(function(arg_16_0, arg_16_1)
			arg_14_0.localPosition = Screen2Local(arg_14_0.parent, arg_16_1.position)

			return
		end)
		var_14_0:AddDragEndFunc(function(arg_17_0, arg_17_1)
			local var_17_0 = TrPosition2LocalPos(self.slots[arg_14_0.gameObject.name].tr.parent, arg_14_0.parent, self.slots[arg_14_0.gameObject.name].tr.localPosition)

			if Vector2.Distance(var_17_0, arg_14_0.localPosition) < 50 then
				self.slots[arg_14_0.gameObject.name].flag = true
				arg_14_0.localPosition = var_17_0

				ClearEventTrigger(var_14_0)
				Object.Destroy(var_14_0)

				if self:IsFinishAll() then
					self:emit(SculptureMediator.ON_JOINT_SCULPTURE, self.id)
				end
			else
				arg_14_0.localPosition = var_14_1
			end

			arg_14_0:SetSiblingIndex(var_14_2)

			return
		end)

		return
	end)

	return
end

function SculpturePuzzlePage:IsFinishAll()
	for iter_18_0, iter_18_1 in pairs(self.slots) do
		if iter_18_1.flag == false then
			return false
		end
	end

	return true
end

function SculpturePuzzlePage:LoadPuzzle(arg_19_1)
	ResourceMgr.Inst:getAssetAsync("ui/" .. self.activity:GetResorceName(self.id) .. "_puzzle", "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_20_0)
		local var_20_0 = Object.Instantiate(arg_20_0, self.frameTr)

		self:HandlePuzzlePart(var_20_0.transform)

		self.puzzle = var_20_0

		arg_19_1()

		return
	end), true, true)

	return
end

function SculpturePuzzlePage:RegisterEvent()
	onButton(self, self.backBtn, function()
		self.contextData.miniMsgBox:ExecuteAction("Show", {
			showNo = true,
			content = i18n("sculpture_drawline_exit"),
			onYes = function()
				self:Hide()

				return
			end
		})

		return
	end, SFX_PANEL)

	local var_21_0 = 0

	onButton(self, self.tipBtn, function()
		if self:IsFinishAll() or var_21_0 > 0 then
			return
		end

		local var_24_0 = {}

		for iter_24_0, iter_24_1 in pairs(self.slots) do
			if iter_24_1.flag == false then
				table.insert(var_24_0, iter_24_1.tr)
			end
		end

		if #var_24_0 == 0 then
			return
		end

		var_21_0 = 10

		self:BlinkSlots({
			var_24_0[math.random(1, #var_24_0)]
		})
		setActive(self.tipBtn, false)
		setActive(self.tipGrayBtn, true)
		self:AddTimer(function()
			var_21_0 = 0

			setActive(self.tipBtn, true)
			setActive(self.tipGrayBtn, false)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function SculpturePuzzlePage:AddTimer(arg_26_1)
	self:ClearTimer()

	local var_26_0 = 11

	self.timer = Timer.New(function()
		var_26_0 = var_26_0 - 1
		self.tipGrayBtnTxt.text = var_26_0 .. "s"

		if var_26_0 <= 0 then
			arg_26_1()
		end

		return
	end, 1, 10)

	self.timer.func()
	self.timer:Start()

	return
end

function SculpturePuzzlePage:ClearTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function SculpturePuzzlePage:BlinkSlots(arg_29_1, arg_29_2)
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		local var_29_1 = iter_29_1:GetComponent(typeof(Image))
		local var_29_2 = var_29_1.color

		table.insert(var_29_0, function(arg_30_0)
			LeanTween.value(iter_29_1.gameObject, 0.5, 1, 0.3):setLoopPingPong(3):setOnUpdate(System.Action_float(function(arg_31_0)
				var_29_1.color = Color.New(var_29_2.r, var_29_2.g, var_29_2.b, arg_31_0)

				return
			end)):setOnComplete(System.Action(function()
				var_29_1.color = Color.New(var_29_2.r, var_29_2.g, var_29_2.b, 0)

				arg_30_0()

				return
			end))

			return
		end)
	end

	parallelAsync(var_29_0, arg_29_2)

	return
end

function SculpturePuzzlePage:Clear()
	if self.puzzleLine then
		Object.Destroy(self.puzzleLine.gameObject)

		self.puzzleLine = nil
	end

	if self.puzzle then
		Object.Destroy(self.puzzle.gameObject)

		self.puzzle = nil
	end

	self.slots = {}

	return
end

function SculpturePuzzlePage:Hide()
	SculpturePuzzlePage.super.Hide(self)
	pg.BgmMgr.GetInstance():Pop(self.__cname)

	return
end

function SculpturePuzzlePage:OnDestroy()
	self:ClearTimer()

	for iter_35_0, iter_35_1 in pairs(self.slots) do
		if LeanTween.isTweening(iter_35_1.tr.gameObject) then
			LeanTween.cancel(iter_35_1.tr.gameObject)
		end
	end

	return
end

return SculpturePuzzlePage
