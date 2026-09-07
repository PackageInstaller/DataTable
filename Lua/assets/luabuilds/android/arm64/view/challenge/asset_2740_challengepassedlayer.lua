local ChallengePassedLayer = class("ChallengePassedLayer", import("..base.BaseUI"))

ChallengePassedLayer.BOSS_NUM = 5
ChallengePassedLayer.GROW_TIME = 0.55

function ChallengePassedLayer:getUIName()
	return "ChallengePassedUI"
end

function ChallengePassedLayer:init()
	self:findUI()
	self:initData()
	self:addListener()

	return
end

function ChallengePassedLayer:didEnter()
	self.tweenObjs = {}

	pg.UIMgr.GetInstance():OverlayPanel(self._tf)
	self:updatePainting(self.paintingName, self.paintingTF, self.paintingShadow1, true)

	if self.paintingNamemNext then
		self:updatePainting(self.paintingNamemNext, self.paintingNextTF, self.paintingNextShadow1)
	end

	self:updateSlider(self.curIndex)
	self:moveSlider(self.curIndex)
	onButton(self, self._tf, function()
		self:emit(ChallengePassedLayer.ON_CLOSE)

		return
	end)
	self._tf:GetComponent("DftAniEvent"):SetEndEvent(function(arg_5_0)
		self:emit(ChallengePassedLayer.ON_CLOSE)

		return
	end)

	return
end

function ChallengePassedLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	LeanTween.cancel(go(self.slider))

	for iter_6_0, iter_6_1 in ipairs(self.tweenObjs) do
		LeanTween.cancel(iter_6_1)
	end

	self.tweenObjs = {}

	return
end

function ChallengePassedLayer:onBackPressed()
	triggerButton(self._tf)

	return
end

function ChallengePassedLayer:findUI()
	self.bg = self._tf:Find("BG")
	self.paintingTF = self._tf:Find("Painting")
	self.paintingShadow1 = self._tf:Find("Painting/PaintingShadow1")
	self.paintingNextTF = self._tf:Find("PaintingNext")
	self.paintingNextShadow1 = self._tf:Find("PaintingNext/PaintingShadow1")
	self.material1 = self._tf:Find("material1"):GetComponent(typeof(Image)).material
	self.slider = self._tf:Find("Slider")
	self.squareContainer = self.slider:Find("SquareList")
	self.squareTpl = self.slider:Find("Squre")
	self.squareList = UIItemList.New(self.squareContainer, self.squareTpl)
	self.sliderSC = GetComponent(self.slider, "Slider")

	return
end

function ChallengePassedLayer:initData()
	local var_9_0 = getProxy(ChallengeProxy):getUserChallengeInfo(self.contextData.mode)

	self.curIndex = var_9_0:getLevel()

	local var_9_1 = self.curIndex % ChallengeConst.BOSS_NUM

	if self.curIndex % ChallengeConst.BOSS_NUM == 0 then
		var_9_1 = ChallengeConst.BOSS_NUM
	end

	local var_9_2 = var_9_0:getDungeonIDList()
	local var_9_3 = var_9_2[var_9_1]
	local var_9_4 = 0

	if self.contextData.mode == ChallengeProxy.MODE_CASUAL then
		if var_9_1 ~= ChallengeConst.BOSS_NUM then
			var_9_4 = var_9_2[var_9_1 + 1]
		end
	else
		var_9_4 = var_9_1 == ChallengeConst.BOSS_NUM and var_9_0:getNextInfiniteDungeonIDList()[1] or var_9_2[var_9_1 + 1]
	end

	self.paintingName = pg.expedition_challenge_template[var_9_3].char_icon[1]

	if var_9_4 ~= 0 then
		self.paintingNamemNext = pg.expedition_challenge_template[var_9_4].char_icon[1]
	end

	return
end

function ChallengePassedLayer:addListener()
	onButton(self, self._tf, function()
		LeanTween.cancel(go(self.slider))
		self:emit(ChallengePassedLayer.ON_CLOSE)

		return
	end, SFX_CANCEL)

	return
end

function ChallengePassedLayer:updatePainting(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	setPaintingPrefab(arg_12_2, arg_12_1, "chuanwu")

	local var_12_0 = arg_12_2:Find("fitter"):GetChild(0)

	if var_12_0 then
		local var_12_1 = GetComponent(var_12_0, "MeshImage")

		if arg_12_4 then
			var_12_1.material = self.material1

			var_12_1.material:SetFloat("_LineDensity", 7)
			;(function(arg_13_0)
				arg_13_0.material:SetFloat("_LineGray", 0.3)
				arg_13_0.material:SetFloat("_TearDistance", 0)
				LeanTween.cancel(arg_13_0.gameObject)
				table.insert(self.tweenObjs, arg_13_0.gameObject)
				LeanTween.value(arg_13_0.gameObject, 0, 2, 2):setLoopClamp():setOnUpdate(System.Action_float(function(arg_14_0)
					if arg_14_0 >= 1.2 then
						arg_13_0.material:SetFloat("_LineGray", 0.3)
					elseif arg_14_0 >= 1.1 then
						arg_13_0.material:SetFloat("_LineGray", 0.45)
					elseif arg_14_0 >= 1.03 then
						arg_13_0.material:SetFloat("_TearDistance", 0)
					elseif arg_14_0 >= 1 then
						arg_13_0.material:SetFloat("_TearDistance", 0.3)
					elseif arg_14_0 >= 0.35 then
						arg_13_0.material:SetFloat("_LineGray", 0.3)
					elseif arg_14_0 >= 0.3 then
						arg_13_0.material:SetFloat("_LineGray", 0.4)
					elseif arg_14_0 >= 0.25 then
						arg_13_0.material:SetFloat("_LineGray", 0.3)
					elseif arg_14_0 >= 0.2 then
						arg_13_0.material:SetFloat("_LineGray", 0.4)
					end

					return
				end))

				return
			end)(var_12_1)
		end
	end

	setPaintingPrefabAsync(arg_12_3, arg_12_1, "chuanwu")

	local var_12_2 = arg_12_3:Find("fitter"):GetChild(0)

	if var_12_2 then
		var_12_2:GetComponent("Image").color = Color.New(1, 1, 1, 0.15)
	end

	arg_12_3.localScale = Vector3(2.2, 2.2, 1)

	return
end

function ChallengePassedLayer:updateSlider(arg_15_1)
	local var_15_0 = arg_15_1 or self.curIndex

	if (arg_15_1 or self.curIndex) > ChallengeConst.BOSS_NUM and (var_15_0 % ChallengeConst.BOSS_NUM ~= 0 or not ChallengeConst.BOSS_NUM) then
		::label_15_0::

		var_15_0 = var_15_0 % ChallengeConst.BOSS_NUM
	end

	self.sliderSC.value = (var_15_0 - 1) * (1 / (ChallengeConst.BOSS_NUM - 1))

	self.squareList:make(function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_16_2:Find("UnFinished")
		local var_16_1 = arg_16_2:Find("Finished")
		local var_16_2 = arg_16_2:Find("Challengeing")
		local var_16_3 = arg_16_2:Find("Arrow")

		if arg_16_0 == UIItemList.EventUpdate then
			if arg_16_1 + 1 < var_15_0 then
				setActive(var_16_3, false)
				;(function()
					setActive(var_16_1, true)
					setActive(var_16_0, false)
					setActive(var_16_2, false)

					return
				end)()
			elseif arg_16_1 + 1 == var_15_0 then
				setActive(var_16_3, true)
				;(function()
					setActive(var_16_1, false)
					setActive(var_16_0, false)
					setActive(var_16_2, true)

					return
				end)()
			elseif arg_16_1 + 1 > var_15_0 then
				setActive(var_16_3, false)
				;(function()
					setActive(var_16_1, false)
					setActive(var_16_0, true)
					setActive(var_16_2, false)

					return
				end)()
			end
		end

		return
	end)
	self.squareList:align(ChallengeConst.BOSS_NUM)

	return
end

function ChallengePassedLayer:moveSlider(arg_20_1)
	local var_20_0 = arg_20_1 or self.curIndex

	if (arg_20_1 or self.curIndex) > ChallengeConst.BOSS_NUM and (var_20_0 % ChallengeConst.BOSS_NUM ~= 0 or not ChallengeConst.BOSS_NUM) then
		::label_20_0::

		var_20_0 = var_20_0 % ChallengeConst.BOSS_NUM

		local var_20_1, var_20_2 = (var_20_0 - 1) * (1 / (ChallengeConst.BOSS_NUM - 1)), go(self.slider)
	end

	LeanTween.value(var_20_2, var_20_1, var_20_0 * (1 / (ChallengeConst.BOSS_NUM - 1)), ChallengePassedLayer.GROW_TIME):setDelay(1.4):setOnUpdate(System.Action_float(function(arg_21_0)
		self.sliderSC.value = arg_21_0

		return
	end)):setOnComplete(System.Action(function()
		self:updateSlider(var_20_0 + 1)

		return
	end))

	return
end

return ChallengePassedLayer
