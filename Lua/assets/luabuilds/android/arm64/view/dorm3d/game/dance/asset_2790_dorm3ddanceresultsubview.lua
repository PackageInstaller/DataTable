local Dorm3dDanceResultSubView = class("Dorm3dDanceResultSubView", import("..Dorm3dGameBaseSubView"))
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

function Dorm3dDanceResultSubView:Init()
	self.resultCucoloris = self._tf:Find("top/cucoloris")
	self.resultScoreText = self._tf:Find("top/score")
	self.scoreAnim = self.resultScoreText:GetComponent(typeof(Animation))
	self.btnAgain = self._tf:Find("btn_again")
	self.btnExit = self._tf:Find("btn_exit")
	self.photoContainer = self._tf:Find("top/photos")
	self.photoTpl = self._tf:Find("tpl")
	self.rank = self._tf:Find("top/rank")

	setText(self.btnAgain:Find("Text"), i18n("dorm3d_cafe_minigame4"))
	setText(self.btnExit:Find("Text"), i18n("dorm3d_cafe_minigame5"))
	onButton(self, self.btnAgain, function()
		self.contextData.onAgain()

		return
	end, SFX_DORM_CLICK)
	onButton(self, self.btnExit, function()
		self.contextData.onExit()

		return
	end, SFX_DORM_BACK)

	self.LTList = {}

	return
end

function Dorm3dDanceResultSubView:Flush()
	self:ClearLeanTween()
	setActive(self.btnExit, false)
	setActive(self.btnAgain, false)

	self.photoTfs = {}

	local var_5_0 = 0
	local var_5_1 = {}

	for iter_5_0 = 1, #self.contextData.cucoloris do
		local var_5_2, var_5_3 = self.contextData.cucoloris[iter_5_0]:CalcScore(self.contextData.photoData[self.contextData.match[iter_5_0]])

		var_5_0 = var_5_0 + var_5_2

		table.insert(var_5_1, {
			score = var_5_0,
			rank = var_0_5(var_5_0),
			match = var_5_3
		})
	end

	for iter_5_1 = 1, #self.contextData.cucoloris do
		local var_5_4 = self.resultCucoloris:GetChild(iter_5_1 - 1)

		LoadImageSpriteAtlasAsync(self.contextData.cucoloris[iter_5_1]:GetIcon(), "", var_5_4:Find("Image"), true)
		LoadImageSpriteAtlasAsync(self.contextData.cucoloris[iter_5_1]:GetOutline(), "", var_5_4:Find("outline"), true)
		setText(var_5_4:Find("match"), i18n("dorm3d_cafe_minigame6", var_5_1[iter_5_1].match))
		setActive(var_5_4:Find("match"), false)
		setImageAlpha(var_5_4:Find("Image"), 1)
	end

	for iter_5_2 = 1, #self.contextData.photoData do
		local var_5_5 = self.photoContainer:GetChild(iter_5_2 - 1):Find("photo")

		self.photoTfs[iter_5_2] = var_5_5

		local var_5_6 = math.random(Dorm3dDanceConst.RESULT_RANDOM_RANGE_ANGLE[1], Dorm3dDanceConst.RESULT_RANDOM_RANGE_ANGLE[2])

		var_5_5.localPosition = Vector3(randx, math.random(Dorm3dDanceConst.RESULT_RANDOM_RANGE_POSY[1], Dorm3dDanceConst.RESULT_RANDOM_RANGE_POSY[2]), 0)
		var_5_5.localEulerAngles = Vector3(0, 0, var_5_6)
		var_5_5.localScale = Vector3.one

		self.contextData.onShowRealImage(iter_5_2, var_5_5:Find("mask/Image"), var_5_5:Find("mask"))
	end

	setText(self.resultScoreText, 0)
	self:ShowRank(var_0_4)

	local var_5_7 = {}
	local var_5_8 = 0
	local var_5_9 = #self.contextData.cucoloris

	local function var_5_10(arg_6_0, arg_6_1)
		var_5_7[arg_6_0 + var_5_8 * var_5_9] = arg_6_1
		var_5_8 = var_5_8 + 1

		return
	end

	local function var_5_11()
		for iter_7_0 = 1, #self.contextData.cucoloris do
			local var_7_0 = self.resultCucoloris:GetChild(iter_7_0 - 1)
			local var_7_1 = self.photoTfs[self.contextData.match[iter_7_0]]

			var_5_8 = 0

			var_5_10(iter_7_0, function(arg_8_0)
				table.insert(self.LTList, LeanTween.move(var_7_1, var_7_1.parent:InverseTransformPoint(var_7_0.position), Dorm3dDanceConst.PHOTO_MOVE_TIME):setOnComplete(System.Action(arg_8_0)).uniqueId)
				table.insert(self.LTList, LeanTween.rotateZ(go(var_7_1), 0, Dorm3dDanceConst.PHOTO_MOVE_TIME).uniqueId)
				table.insert(self.LTList, LeanTween.scale(var_7_1, Dorm3dDanceConst.PHOTO_SCALE, Dorm3dDanceConst.PHOTO_MOVE_TIME).uniqueId)

				return
			end)
			var_5_10(iter_7_0, function(arg_9_0)
				table.insert(self.LTList, LeanTween.alpha(var_7_0:Find("Image"), 0.5, Dorm3dDanceConst.CUCOLORIS_FADE_100_50):setOnComplete(System.Action(function()
					arg_9_0()
					table.insert(self.LTList, LeanTween.alpha(var_7_0:Find("Image"), 0, Dorm3dDanceConst.CUCOLORIS_FADE_50_0).uniqueId)

					return
				end)).uniqueId)

				return
			end)
			var_5_10(iter_7_0, function(arg_11_0)
				local function var_11_0()
					setText(self.resultScoreText, var_5_1[iter_7_0].score)
					self:ShowRank(var_5_1[iter_7_0].rank)
					table.insert(self.LTList, LeanTween.delayedCall(Dorm3dDanceConst.RANK_ANIM_TIME, System.Action(arg_11_0)).uniqueId)

					return
				end

				setActive(var_7_0:Find("match"), true)
				table.insert(self.LTList, LeanTween.delayedCall(Dorm3dDanceConst.MATCH_ANIM_TIME, System.Action(function()
					self.scoreAnim:Play("anim_score_enter")
					table.insert(self.LTList, LeanTween.delayedCall(Dorm3dDanceConst.SCORE_ANIM_TIME, System.Action(var_11_0)).uniqueId)

					return
				end)).uniqueId)

				return
			end)
		end

		seriesAsync(var_5_7, function()
			setActive(self.btnAgain, true)
			setActive(self.btnExit, true)

			return
		end)

		return
	end

	self._tf:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		var_5_11()

		return
	end)

	return
end

function Dorm3dDanceResultSubView:ShowRank(arg_16_1)
	setActive(self.rank:Find("S"), arg_16_1 == var_0_1)
	setActive(self.rank:Find("A"), arg_16_1 == var_0_2)
	setActive(self.rank:Find("B"), arg_16_1 == var_0_3)
	setActive(self.rank:Find("C"), arg_16_1 == var_0_4)

	return
end

function Dorm3dDanceResultSubView:ClearLeanTween()
	for iter_17_0, iter_17_1 in ipairs(self.LTList) do
		LeanTween.cancel(iter_17_1)
	end

	self.LTList = {}

	return
end

function Dorm3dDanceResultSubView:Dispose()
	self:ClearLeanTween()

	return
end

return Dorm3dDanceResultSubView
