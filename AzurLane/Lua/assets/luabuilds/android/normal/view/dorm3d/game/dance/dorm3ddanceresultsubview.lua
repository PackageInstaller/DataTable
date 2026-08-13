class = var_0_10000

local var_0_0 = "Dorm3dDanceResultSubView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..Dorm3dGameBaseSubView"))
local var_0_2 = "S"
local var_0_3 = "A"
local var_0_4 = "B"
local var_0_5 = "C"

local function var_0_6(arg_1_0)
	pairs = var_1_10001
	Dorm3dDanceConst = var_1_10002

	for iter_1_0, iter_1_1 in var_1_10001(var_1_10002.SCORE_RANGE) do
		if arg_1_0 >= iter_1_1[1] and arg_1_0 <= iter_1_1[2] then
			return iter_1_0
		end
	end

	return var_0_5
end

function var_0_1.Init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.resultCucoloris = var_1.Find(var_2_0, "top/cucoloris")

	local var_2_1 = arg_2_0._tf

	arg_2_0.resultScoreText = var_1.Find(var_2_1, "top/score")

	local var_2_2 = arg_2_0.resultScoreText
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_2_0.scoreAnim = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0._tf

	arg_2_0.btnAgain = var_1.Find(var_2_4, "btn_again")

	local var_2_5 = arg_2_0._tf

	arg_2_0.btnExit = var_1.Find(var_2_5, "btn_exit")

	local var_2_6 = arg_2_0._tf

	arg_2_0.photoContainer = var_1.Find(var_2_6, "top/photos")

	local var_2_7 = arg_2_0._tf

	arg_2_0.photoTpl = var_1.Find(var_2_7, "tpl")

	local var_2_8 = arg_2_0._tf

	arg_2_0.rank = var_1.Find(var_2_8, "top/rank")
	setText = var_1

	local var_2_9 = arg_2_0.btnAgain
	local var_2_10 = var_2.Find(var_2_9, "Text")

	i18n = var_2_9

	var_1(var_2_10, var_2_9("dorm3d_cafe_minigame4"))

	setText = var_1

	local var_2_11 = arg_2_0.btnExit
	local var_2_12 = var_2.Find(var_2_11, "Text")

	i18n = var_2_11

	var_1(var_2_12, var_2_11("dorm3d_cafe_minigame5"))

	onButton = var_1

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0.btnAgain

	local function var_2_15()
		arg_2_0.contextData.onAgain()

		return
	end

	SFX_DORM_CLICK = var_1_10005

	var_1(var_2_13, var_2_14, var_2_15, var_1_10005)

	onButton = var_1

	local var_2_16 = arg_2_0
	local var_2_17 = arg_2_0.btnExit

	local function var_2_18()
		arg_2_0.contextData.onExit()

		return
	end

	SFX_DORM_BACK = var_1_10005

	var_1(var_2_16, var_2_17, var_2_18, var_1_10005)

	arg_2_0.LTList = {}

	return
end

function var_0_1.Flush(arg_5_0)
	arg_5_0:ClearLeanTween()

	setActive = var_1

	var_1(arg_5_0.btnExit, false)

	setActive = var_1

	var_1(arg_5_0.btnAgain, false)

	arg_5_0.photoTfs = {}

	local var_5_0 = 0
	local var_5_1 = {}

	for iter_5_0 = 1, #arg_5_0.contextData.cucoloris do
		local var_5_2 = arg_5_0.contextData.cucoloris[iter_5_0]
		local var_5_3 = arg_5_0.contextData.photoData[arg_5_0.contextData.match[iter_5_0]]

		var_1_10010 = var_5_2

		local var_5_4

		var_5_4, var_1_10010 = var_5_2.CalcScore(var_1_10010, var_5_3)
		var_5_0 = var_5_0 + var_5_4
		table = var_1_10011

		var_1_10011.insert(var_5_1, {
			score = var_5_0,
			rank = var_0_6(var_5_0),
			match = var_1_10010
		})
	end

	for iter_5_1 = 1, #arg_5_0.contextData.cucoloris do
		local var_5_5 = arg_5_0.resultCucoloris
		local var_5_6 = var_7.GetChild(var_5_5, iter_5_1 - 1)

		LoadImageSpriteAtlasAsync = var_5_5
		var_1_10010 = arg_5_0.contextData.cucoloris[iter_5_1]

		local var_5_7 = var_9.GetIcon(var_1_10010)

		var_1_10010 = ""
		var_1_10012 = var_5_6

		var_5_5(var_5_7, var_1_10010, var_5_6.Find(var_1_10012, "Image"), true)

		LoadImageSpriteAtlasAsync = var_5_5
		var_1_10010 = arg_5_0.contextData.cucoloris[iter_5_1]

		local var_5_8 = var_9.GetOutline(var_1_10010)

		var_1_10010 = ""
		var_1_10012 = var_5_6

		var_5_5(var_5_8, var_1_10010, var_5_6.Find(var_1_10012, "outline"), true)

		setText = var_5_5
		var_1_10010 = var_5_6

		local var_5_9 = var_5_6.Find(var_1_10010, "match")

		i18n = var_1_10010

		var_5_5(var_5_9, var_1_10010("dorm3d_cafe_minigame6", var_5_1[iter_5_1].match))

		setActive = var_5_5
		var_1_10010 = var_5_6

		var_5_5(var_5_6.Find(var_1_10010, "match"), false)

		setImageAlpha = var_5_5
		var_1_10010 = var_5_6

		var_5_5(var_5_6.Find(var_1_10010, "Image"), 1)
	end

	for iter_5_2 = 1, #arg_5_0.contextData.photoData do
		local var_5_10 = arg_5_0.photoContainer
		local var_5_11 = var_7.GetChild(var_5_10, iter_5_2 - 1)
		local var_5_12 = var_7.Find(var_5_11, "photo")
		local var_5_13 = arg_5_0.photoTfs

		var_5_13[iter_5_2] = var_5_12
		math = var_5_13

		local var_5_14 = var_5_13.random

		Dorm3dDanceConst = var_1_10010
		var_1_10010 = var_1_10010.RESULT_RANDOM_RANGE_POSY[1]
		Dorm3dDanceConst = var_1_10011

		local var_5_15 = var_5_14(var_1_10010, var_1_10011.RESULT_RANDOM_RANGE_POSY[2])

		math = var_1_10010
		var_1_10010 = var_1_10010.random
		Dorm3dDanceConst = var_1_10011
		var_1_10011 = var_1_10011.RESULT_RANDOM_RANGE_ANGLE[1]
		Dorm3dDanceConst = var_1_10012
		var_1_10010 = var_1_10010(var_1_10011, var_1_10012.RESULT_RANDOM_RANGE_ANGLE[2])
		Vector3 = var_1_10011
		randx = var_1_10012
		var_5_12.localPosition = var_1_10011(var_1_10012, var_5_15, 0)
		Vector3 = var_1_10011
		var_5_12.localEulerAngles = var_1_10011(0, 0, var_1_10010)
		Vector3 = var_1_10011
		var_5_12.localScale = var_1_10011.one

		arg_5_0.contextData.onShowRealImage(iter_5_2, var_5_12:Find("mask/Image"), var_5_12:Find("mask"))
	end

	setText = var_3

	var_3(arg_5_0.resultScoreText, 0)
	arg_5_0:ShowRank(var_0_5)

	local var_5_16 = {}
	local var_5_17 = 0
	local var_5_18 = #arg_5_0.contextData.cucoloris

	local function var_5_19(arg_6_0, arg_6_1)
		var_5_16[arg_6_0 + var_5_17 * var_5_18] = arg_6_1
		var_5_17 = var_5_17 + 1

		return
	end

	local function var_5_20()
		for iter_7_0 = 1, #arg_5_0.contextData.cucoloris do
			local var_7_0 = arg_5_0.contextData.match[iter_7_0]
			local var_7_1 = arg_5_0.resultCucoloris
			local var_7_2 = var_5.GetChild(var_7_1, iter_7_0 - 1)
			local var_7_3 = arg_5_0.photoTfs[var_7_0]

			var_5_17 = 0

			var_5_19(iter_7_0, function(arg_8_0)
				local var_8_0 = var_7_2.position
				local var_8_1 = var_7_3.parent
				local var_8_2 = var_2.InverseTransformPoint(var_8_1, var_8_0)

				table = var_8_1

				local var_8_3 = var_8_1.insert
				local var_8_4 = arg_5_0.LTList

				LeanTween = var_3_10005

				local var_8_5 = var_3_10005.move
				local var_8_6 = var_7_3
				local var_8_7 = var_8_2

				Dorm3dDanceConst = var_3_10008

				local var_8_8 = var_8_5(var_8_6, var_8_7, var_3_10008.PHOTO_MOVE_TIME)
				local var_8_9 = var_5.setOnComplete

				System = var_8_7

				var_8_3(var_8_4, var_8_9(var_8_8, var_8_7.Action(arg_8_0)).uniqueId)

				table = var_8_3

				local var_8_10 = var_8_3.insert
				local var_8_11 = arg_5_0.LTList

				LeanTween = var_5

				local var_8_12 = var_5.rotateZ

				go = var_8_8

				local var_8_13 = var_8_8(var_7_3)
				local var_8_14 = 0

				Dorm3dDanceConst = var_8

				var_8_10(var_8_11, var_8_12(var_8_13, var_8_14, var_8.PHOTO_MOVE_TIME).uniqueId)

				table = var_8_10

				local var_8_15 = var_8_10.insert
				local var_8_16 = arg_5_0.LTList

				LeanTween = var_5

				local var_8_17 = var_5.scale
				local var_8_18 = var_7_3

				Dorm3dDanceConst = var_8_14

				local var_8_19 = var_8_14.PHOTO_SCALE

				Dorm3dDanceConst = var_8

				var_8_15(var_8_16, var_8_17(var_8_18, var_8_19, var_8.PHOTO_MOVE_TIME).uniqueId)

				return
			end)
			var_5_19(iter_7_0, function(arg_9_0)
				local function var_9_0()
					arg_9_0()

					table = var_0

					local var_10_0 = var_0.insert
					local var_10_1 = arg_5_0.LTList

					LeanTween = var_4_10002

					local var_10_2 = var_4_10002.alpha
					local var_10_3 = var_7_2
					local var_10_4 = var_3.Find(var_10_3, "Image")
					local var_10_5 = 0

					Dorm3dDanceConst = var_5

					var_10_0(var_10_1, var_10_2(var_10_4, var_10_5, var_5.CUCOLORIS_FADE_50_0).uniqueId)

					return
				end

				table = var_3_10002

				local var_9_1 = var_3_10002.insert
				local var_9_2 = arg_5_0.LTList

				LeanTween = var_3_10004

				local var_9_3 = var_3_10004.alpha
				local var_9_4 = var_7_2
				local var_9_5 = var_5.Find(var_9_4, "Image")
				local var_9_6 = 0.5

				Dorm3dDanceConst = var_7

				local var_9_7 = var_9_3(var_9_5, var_9_6, var_7.CUCOLORIS_FADE_100_50)
				local var_9_8 = var_4.setOnComplete

				System = var_9_6

				var_9_1(var_9_2, var_9_8(var_9_7, var_9_6.Action(var_9_0)).uniqueId)

				return
			end)
			var_5_19(iter_7_0, function(arg_11_0)
				local function var_11_0()
					setText = var_4_10000

					var_4_10000(arg_5_0.resultScoreText, var_5_1[iter_7_0].score)

					local var_12_0 = arg_5_0

					var_0.ShowRank(var_12_0, var_5_1[iter_7_0].rank)

					table = var_0

					local var_12_1 = var_0.insert
					local var_12_2 = arg_5_0.LTList

					LeanTween = var_2

					local var_12_3 = var_2.delayedCall

					Dorm3dDanceConst = var_3

					local var_12_4 = var_3.RANK_ANIM_TIME

					System = var_4_10004

					var_12_1(var_12_2, var_12_3(var_12_4, var_4_10004.Action(arg_11_0)).uniqueId)

					return
				end

				local function var_11_1()
					local var_13_0 = arg_5_0.scoreAnim

					var_0.Play(var_13_0, "anim_score_enter")

					table = var_0

					local var_13_1 = var_0.insert
					local var_13_2 = arg_5_0.LTList

					LeanTween = var_2

					local var_13_3 = var_2.delayedCall

					Dorm3dDanceConst = var_4_10003

					local var_13_4 = var_4_10003.SCORE_ANIM_TIME

					System = var_4_10004

					var_13_1(var_13_2, var_13_3(var_13_4, var_4_10004.Action(var_11_0)).uniqueId)

					return
				end

				setActive = var_3_10003

				local var_11_2 = var_7_2

				var_3_10003(var_4.Find(var_11_2, "match"), true)

				table = var_3_10003

				local var_11_3 = var_3_10003.insert
				local var_11_4 = arg_5_0.LTList

				LeanTween = var_5

				local var_11_5 = var_5.delayedCall

				Dorm3dDanceConst = var_6

				local var_11_6 = var_6.MATCH_ANIM_TIME

				System = var_3_10007

				var_11_3(var_11_4, var_11_5(var_11_6, var_3_10007.Action(var_11_1)).uniqueId)

				return
			end)
		end

		seriesAsync = var_0

		var_0(var_5_16, function()
			setActive = var_3_10000

			var_3_10000(arg_5_0.btnAgain, true)

			setActive = var_3_10000

			var_3_10000(arg_5_0.btnExit, true)

			return
		end)

		return
	end

	local var_5_21 = arg_5_0._tf
	local var_5_22 = var_8.GetComponent

	typeof = var_1_10010
	DftAniEvent = var_1_10011

	local var_5_23 = var_5_22(var_5_21, var_1_10010(var_1_10011))

	var_8.SetEndEvent(var_5_23, function()
		var_5_20()

		return
	end)

	return
end

function var_0_1.ShowRank(arg_16_0, arg_16_1)
	setActive = var_1_10002

	local var_16_0 = arg_16_0.rank

	var_1_10002(var_3.Find(var_16_0, "S"), arg_16_1 == var_0_2)

	setActive = var_1_10002

	local var_16_1 = arg_16_0.rank

	var_1_10002(var_3.Find(var_16_1, "A"), arg_16_1 == var_0_3)

	setActive = var_1_10002

	local var_16_2 = arg_16_0.rank

	var_1_10002(var_3.Find(var_16_2, "B"), arg_16_1 == var_0_4)

	setActive = var_1_10002

	local var_16_3 = arg_16_0.rank

	var_1_10002(var_3.Find(var_16_3, "C"), arg_16_1 == var_0_5)

	return
end

function var_0_1.ClearLeanTween(arg_17_0)
	ipairs = var_1_10001

	for iter_17_0, iter_17_1 in var_1_10001(arg_17_0.LTList) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_17_1)
	end

	arg_17_0.LTList = {}

	return
end

function var_0_1.Dispose(arg_18_0)
	arg_18_0:ClearLeanTween()

	return
end

return var_0_1
