local var_0_0 = class("ChallengePassedLayer", import("..base.BaseUI"))

var_0_0.BOSS_NUM = 5
var_0_0.GROW_TIME = 0.55

function var_0_0.getUIName(arg_1_0)
	return "ChallengePassedUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:initData()
	arg_2_0:addListener()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0.tweenObjs = {}

	pg.UIMgr.GetInstance():OverlayPanel(arg_3_0._tf)
	arg_3_0:updatePainting(arg_3_0.paintingName, arg_3_0.paintingTF, arg_3_0.paintingShadow1, true)

	if arg_3_0.paintingNamemNext then
		arg_3_0:updatePainting(arg_3_0.paintingNamemNext, arg_3_0.paintingNextTF, arg_3_0.paintingNextShadow1)
	end

	arg_3_0:updateSlider(arg_3_0.curIndex)
	arg_3_0:moveSlider(arg_3_0.curIndex)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:emit(var_0_0.ON_CLOSE)

		return
	end)
	arg_3_0._tf:GetComponent("DftAniEvent"):SetEndEvent(function(arg_5_0)
		arg_3_0:emit(var_0_0.ON_CLOSE)

		return
	end)

	return
end

function var_0_0.willExit(arg_6_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_6_0._tf)
	LeanTween.cancel(go(arg_6_0.slider))

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.tweenObjs) do
		LeanTween.cancel(iter_6_1)
	end

	arg_6_0.tweenObjs = {}

	return
end

function var_0_0.onBackPressed(arg_7_0)
	triggerButton(arg_7_0._tf)

	return
end

function var_0_0.findUI(arg_8_0)
	arg_8_0.bg = arg_8_0._tf:Find("BG")
	arg_8_0.paintingTF = arg_8_0._tf:Find("Painting")
	arg_8_0.paintingShadow1 = arg_8_0._tf:Find("Painting/PaintingShadow1")
	arg_8_0.paintingNextTF = arg_8_0._tf:Find("PaintingNext")
	arg_8_0.paintingNextShadow1 = arg_8_0._tf:Find("PaintingNext/PaintingShadow1")
	arg_8_0.material1 = arg_8_0._tf:Find("material1"):GetComponent(typeof(Image)).material
	arg_8_0.slider = arg_8_0._tf:Find("Slider")
	arg_8_0.squareContainer = arg_8_0.slider:Find("SquareList")
	arg_8_0.squareTpl = arg_8_0.slider:Find("Squre")
	arg_8_0.squareList = UIItemList.New(arg_8_0.squareContainer, arg_8_0.squareTpl)
	arg_8_0.sliderSC = GetComponent(arg_8_0.slider, "Slider")

	return
end

function var_0_0.initData(arg_9_0)
	local var_9_0 = getProxy(ChallengeProxy):getUserChallengeInfo(arg_9_0.contextData.mode)

	arg_9_0.curIndex = var_9_0:getLevel()

	local var_9_1 = arg_9_0.curIndex % ChallengeConst.BOSS_NUM

	if arg_9_0.curIndex % ChallengeConst.BOSS_NUM == 0 then
		var_9_1 = ChallengeConst.BOSS_NUM
	end

	local var_9_2 = var_9_0:getDungeonIDList()
	local var_9_3 = var_9_2[var_9_1]
	local var_9_4 = 0

	if arg_9_0.contextData.mode == ChallengeProxy.MODE_CASUAL then
		if var_9_1 ~= ChallengeConst.BOSS_NUM then
			var_9_4 = var_9_2[var_9_1 + 1]
		end
	else
		var_9_4 = var_9_1 == ChallengeConst.BOSS_NUM and var_9_0:getNextInfiniteDungeonIDList()[1] or var_9_2[var_9_1 + 1]
	end

	arg_9_0.paintingName = pg.expedition_challenge_template[var_9_3].char_icon[1]

	if var_9_4 ~= 0 then
		arg_9_0.paintingNamemNext = pg.expedition_challenge_template[var_9_4].char_icon[1]
	end

	return
end

function var_0_0.addListener(arg_10_0)
	onButton(arg_10_0, arg_10_0._tf, function()
		LeanTween.cancel(go(arg_10_0.slider))
		arg_10_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.updatePainting(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	setPaintingPrefab(arg_12_2, arg_12_1, "chuanwu")

	local var_12_0 = arg_12_2:Find("fitter"):GetChild(0)

	if var_12_0 then
		local var_12_1 = GetComponent(var_12_0, "MeshImage")

		if arg_12_4 then
			var_12_1.material = arg_12_0.material1

			var_12_1.material:SetFloat("_LineDensity", 7)
			;(function(arg_13_0)
				arg_13_0.material:SetFloat("_LineGray", 0.3)
				arg_13_0.material:SetFloat("_TearDistance", 0)
				LeanTween.cancel(arg_13_0.gameObject)
				table.insert(arg_12_0.tweenObjs, arg_13_0.gameObject)
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

function var_0_0.updateSlider(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1 or arg_15_0.curIndex

	if (arg_15_1 or arg_15_0.curIndex) > ChallengeConst.BOSS_NUM and (var_15_0 % ChallengeConst.BOSS_NUM ~= 0 or not ChallengeConst.BOSS_NUM) then
		::label_15_0::

		var_15_0 = var_15_0 % ChallengeConst.BOSS_NUM
	end

	arg_15_0.sliderSC.value = (var_15_0 - 1) * (1 / (ChallengeConst.BOSS_NUM - 1))

	arg_15_0.squareList:make(function(arg_16_0, arg_16_1, arg_16_2)
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
	arg_15_0.squareList:align(ChallengeConst.BOSS_NUM)

	return
end

function var_0_0.moveSlider(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1 or arg_20_0.curIndex

	if (arg_20_1 or arg_20_0.curIndex) > ChallengeConst.BOSS_NUM and (var_20_0 % ChallengeConst.BOSS_NUM ~= 0 or not ChallengeConst.BOSS_NUM) then
		::label_20_0::

		var_20_0 = var_20_0 % ChallengeConst.BOSS_NUM
	end

	LeanTween.value(go(arg_20_0.slider), (var_20_0 - 1) * (1 / (ChallengeConst.BOSS_NUM - 1)), var_20_0 * (1 / (ChallengeConst.BOSS_NUM - 1)), var_0_0.GROW_TIME):setDelay(1.4):setOnUpdate(System.Action_float(function(arg_21_0)
		arg_20_0.sliderSC.value = arg_21_0

		return
	end)):setOnComplete(System.Action(function()
		arg_20_0:updateSlider(var_20_0 + 1)

		return
	end))

	return
end

return var_0_0
