local var_0_0 = class("Dorm3dDanceResultSubView", import("..Dorm3dGameBaseSubView"))
local var_0_1 = "S"
local var_0_2 = "A"
local var_0_3 = "B"
local var_0_4 = "C"

local function var_0_5(arg_1_0)
	for iter_1_0, iter_1_1 in pairs(Dorm3dDanceConst.SCORE_RANGE) do
		if arg_1_0 >= iter_1_1[1] and arg_1_0 <= iter_1_1[2] then
			return iter_1_0
		end
	end

	return var_0_4
end

function var_0_0.Init(arg_2_0)
	arg_2_0.resultCucoloris = arg_2_0._tf:Find("top/cucoloris")
	arg_2_0.resultScoreText = arg_2_0._tf:Find("top/score")
	arg_2_0.scoreAnim = arg_2_0.resultScoreText:GetComponent(typeof(Animation))
	arg_2_0.btnAgain = arg_2_0._tf:Find("btn_again")
	arg_2_0.btnExit = arg_2_0._tf:Find("btn_exit")
	arg_2_0.photoContainer = arg_2_0._tf:Find("top/photos")
	arg_2_0.photoTpl = arg_2_0._tf:Find("tpl")
	arg_2_0.rank = arg_2_0._tf:Find("top/rank")

	setText(arg_2_0.btnAgain:Find("Text"), i18n("dorm3d_cafe_minigame4"))
	setText(arg_2_0.btnExit:Find("Text"), i18n("dorm3d_cafe_minigame5"))
	onButton(arg_2_0, arg_2_0.btnAgain, function()
		arg_2_0.contextData.onAgain()

		return
	end, SFX_DORM_CLICK)
	onButton(arg_2_0, arg_2_0.btnExit, function()
		arg_2_0.contextData.onExit()

		return
	end, SFX_DORM_BACK)

	arg_2_0.LTList = {}

	return
end

function var_0_0.Flush(arg_5_0)
	arg_5_0:ClearLeanTween()
	setActive(arg_5_0.btnExit, false)
	setActive(arg_5_0.btnAgain, false)

	arg_5_0.photoTfs = {}

	local var_5_0 = 0
	local var_5_1 = {}

	for iter_5_0 = 1, #arg_5_0.contextData.cucoloris do
		local var_5_2, var_5_3 = arg_5_0.contextData.cucoloris[iter_5_0]:CalcScore(arg_5_0.contextData.photoData[arg_5_0.contextData.match[iter_5_0]])

		var_5_0 = var_5_0 + var_5_2

		table.insert({}, {
			score = var_5_0,
			rank = var_0_5(var_5_0),
			match = var_5_3
		})
	end

	for iter_5_1 = 1, #arg_5_0.contextData.cucoloris do
		local var_5_4 = arg_5_0.resultCucoloris:GetChild(iter_5_1 - 1)

		LoadImageSpriteAtlasAsync(arg_5_0.contextData.cucoloris[iter_5_1]:GetIcon(), "", var_5_4:Find("Image"), true)
		LoadImageSpriteAtlasAsync(arg_5_0.contextData.cucoloris[iter_5_1]:GetOutline(), "", var_5_4:Find("outline"), true)
		setText(var_5_4:Find("match"), i18n("dorm3d_cafe_minigame6", ({})[iter_5_1].match))
		setActive(var_5_4:Find("match"), false)
		setImageAlpha(var_5_4:Find("Image"), 1)
	end

	for iter_5_2 = 1, #arg_5_0.contextData.photoData do
		local var_5_5 = arg_5_0.photoContainer:GetChild(iter_5_2 - 1):Find("photo")

		arg_5_0.photoTfs[iter_5_2] = var_5_5

		local var_5_6 = math.random(Dorm3dDanceConst.RESULT_RANDOM_RANGE_ANGLE[1], Dorm3dDanceConst.RESULT_RANDOM_RANGE_ANGLE[2])

		var_5_5.localPosition = Vector3(randx, math.random(Dorm3dDanceConst.RESULT_RANDOM_RANGE_POSY[1], Dorm3dDanceConst.RESULT_RANDOM_RANGE_POSY[2]), 0)
		var_5_5.localEulerAngles = Vector3(0, 0, var_5_6)
		var_5_5.localScale = Vector3.one

		arg_5_0.contextData.onShowRealImage(iter_5_2, var_5_5:Find("mask/Image"), var_5_5:Find("mask"))
	end

	setText(arg_5_0.resultScoreText, 0)
	arg_5_0:ShowRank(var_0_4)

	local var_5_7 = {}
	local var_5_8 = 0
	local var_5_9 = #arg_5_0.contextData.cucoloris

	local function var_5_10(arg_6_0, arg_6_1)
		var_5_7[arg_6_0 + var_5_8 * var_5_9] = arg_6_1
		var_5_8 = var_5_8 + 1

		return
	end

	local function var_5_11()
		for iter_7_0 = 1, #arg_5_0.contextData.cucoloris do
			local var_7_0 = arg_5_0.resultCucoloris:GetChild(iter_7_0 - 1)
			local var_7_1 = arg_5_0.photoTfs[arg_5_0.contextData.match[iter_7_0]]

			var_5_8 = 0

			var_5_10(iter_7_0, function(arg_8_0)
				table.insert(arg_5_0.LTList, LeanTween.move(var_7_1, var_7_1.parent:InverseTransformPoint(var_7_0.position), Dorm3dDanceConst.PHOTO_MOVE_TIME):setOnComplete(System.Action(arg_8_0)).uniqueId)
				table.insert(arg_5_0.LTList, LeanTween.rotateZ(go(var_7_1), 0, Dorm3dDanceConst.PHOTO_MOVE_TIME).uniqueId)
				table.insert(arg_5_0.LTList, LeanTween.scale(var_7_1, Dorm3dDanceConst.PHOTO_SCALE, Dorm3dDanceConst.PHOTO_MOVE_TIME).uniqueId)

				return
			end)
			var_5_10(iter_7_0, function(arg_9_0)
				table.insert(arg_5_0.LTList, LeanTween.alpha(var_7_0:Find("Image"), 0.5, Dorm3dDanceConst.CUCOLORIS_FADE_100_50):setOnComplete(System.Action(function()
					arg_9_0()
					table.insert(arg_5_0.LTList, LeanTween.alpha(var_7_0:Find("Image"), 0, Dorm3dDanceConst.CUCOLORIS_FADE_50_0).uniqueId)

					return
				end)).uniqueId)

				return
			end)
			var_5_10(iter_7_0, function(arg_11_0)
				local function var_11_0()
					setText(arg_5_0.resultScoreText, var_5_1[iter_7_0].score)
					arg_5_0:ShowRank(var_5_1[iter_7_0].rank)
					table.insert(arg_5_0.LTList, LeanTween.delayedCall(Dorm3dDanceConst.RANK_ANIM_TIME, System.Action(arg_11_0)).uniqueId)

					return
				end

				setActive(var_7_0:Find("match"), true)
				table.insert(arg_5_0.LTList, LeanTween.delayedCall(Dorm3dDanceConst.MATCH_ANIM_TIME, System.Action(function()
					arg_5_0.scoreAnim:Play("anim_score_enter")
					table.insert(arg_5_0.LTList, LeanTween.delayedCall(Dorm3dDanceConst.SCORE_ANIM_TIME, System.Action(var_11_0)).uniqueId)

					return
				end)).uniqueId)

				return
			end)
		end

		seriesAsync(var_5_7, function()
			setActive(arg_5_0.btnAgain, true)
			setActive(arg_5_0.btnExit, true)

			return
		end)

		return
	end

	arg_5_0._tf:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		var_5_11()

		return
	end)

	return
end

function var_0_0.ShowRank(arg_16_0, arg_16_1)
	setActive(arg_16_0.rank:Find("S"), arg_16_1 == var_0_1)
	setActive(arg_16_0.rank:Find("A"), arg_16_1 == var_0_2)
	setActive(arg_16_0.rank:Find("B"), arg_16_1 == var_0_3)
	setActive(arg_16_0.rank:Find("C"), arg_16_1 == var_0_4)

	return
end

function var_0_0.ClearLeanTween(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.LTList) do
		LeanTween.cancel(iter_17_1)
	end

	arg_17_0.LTList = {}

	return
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:ClearLeanTween()

	return
end

return var_0_0
