class = var_0_10000

local var_0_0 = "LevelStageDOAFeverPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubPanel"))

var_0_1.PAINTING_RANGE = {
	1,
	7
}

function var_0_1.getUIName(arg_1_0)
	return "LevelStageDOAFeverPanel"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.fillImg = var_1.Find(var_2_0, "Fill")

	local var_2_1 = arg_2_0._tf

	arg_2_0.maxImg = var_1.Find(var_2_1, "Max")
	setActive = var_1

	var_1(arg_2_0.maxImg, false)

	local var_2_2 = arg_2_0._tf

	arg_2_0.ratioText = var_1.Find(var_2_2, "Text")

	local var_2_3 = arg_2_0._tf

	arg_2_0.banner = var_1.Find(var_2_3, "Banner")
	setActive = var_1

	var_1(arg_2_0.banner, false)

	local var_2_4 = arg_2_0.fillImg

	arg_2_0.fillAnim = var_1.Find(var_2_4, "Anim")

	return
end

function var_0_1.UpdateView(arg_3_0, arg_3_1, arg_3_2)
	getProxy = var_1_10003
	ChapterProxy = var_1_10004

	local var_3_0 = var_1_10003(var_1_10004)
	local var_3_1 = var_3.GetLastDefeatedEnemy(var_3_0, arg_3_1.id)
	local var_3_2 = arg_3_1.defeatEnemies

	pg = var_5

	local var_3_3 = var_3_2 / var_5.gameset.doa_fever_count.key_value
	local var_3_4 = var_5 <= var_3_2

	seriesAsync = var_1_10008

	var_1_10008({
		function(arg_4_0)
			LeanTween = var_2_10001

			local var_4_0 = var_2_10001.cancel

			go = var_2_10002

			var_4_0(var_2_10002(arg_3_0.fillImg), true)

			if not var_3_1 or var_3_2 > var_0 then
				arg_4_0()

				return
			end

			setActive = var_1

			var_1(arg_3_0.maxImg, false)

			setActive = var_1

			var_1(arg_3_0.fillImg, true)

			setActive = var_1

			var_1(arg_3_0.ratioText, true)

			setActive = var_1

			var_1(arg_3_0.fillAnim, true)

			math = var_1

			local var_4_1 = var_1.max(var_3_2 - 1, 0)
			local var_4_2 = arg_3_0.fillImg
			local var_4_3 = var_2.GetComponent

			typeof = var_2_10004
			Image = var_2_10005

			local var_4_4 = var_4_3(var_4_2, var_2_10004(var_2_10005))
			local var_4_5 = arg_3_0.fillImg.rect.height
			local var_4_6 = arg_3_0.fillAnim.rect.height
			local var_4_7 = 3.115264797507788

			LeanTween = var_2_10007

			local var_4_8 = var_2_10007.value

			go = var_2_10008

			local var_4_9 = var_4_8(var_2_10008(arg_3_0.fillImg), 0, 1, 1)
			local var_4_10 = var_7.setOnUpdate

			System = var_9

			local var_4_11 = var_4_10(var_4_9, var_9.Action_float(function(arg_5_0)
				Mathf = var_3_10001

				local var_5_0 = var_3_10001.Lerp(var_4_1, var_3_2, arg_5_0) / var_0 * var_0
				local var_5_1 = arg_3_0.fillAnim

				Vector2 = var_4
				var_5_1.anchoredPosition = var_4(0, var_5_0)
				math = var_5_1

				local var_5_2 = var_5_1.sqrt

				math = var_4

				local var_5_3 = var_5_2(var_4.max(var_4_5 * var_4_5 - var_5_0 * var_5_0, 0)) * var_4_7

				math = var_4

				local var_5_4 = var_4.min(1.5 - arg_5_0, 1) * var_4_6
				local var_5_5 = arg_3_0.fillAnim

				Vector2 = var_6
				var_5_5.sizeDelta = var_6(var_5_3, var_5_4)

				local var_5_6 = var_4_4

				var_5_6.fillAmount = var_1
				setText = var_5_6

				local var_5_7 = arg_3_0.ratioText

				string = var_7

				local var_5_8 = var_7.format
				local var_5_9 = "%02d.%d%%"

				math = var_3_10009

				local var_5_10 = var_3_10009.floor(var_1 * 100)

				math = var_10

				var_5_6(var_5_7, var_5_8(var_5_9, var_5_10, var_10.round(var_1 * 1000) % 10))

				return
			end))
			local var_4_12 = var_7.setOnComplete

			System = var_9

			var_4_12(var_4_11, var_9.Action(arg_4_0))

			return
		end,
		function(arg_6_0)
			setActive = var_2_10001

			var_2_10001(arg_3_0.fillImg, not var_3_4)

			setActive = var_2_10001

			var_2_10001(arg_3_0.ratioText, not var_3_4)

			setActive = var_2_10001

			var_2_10001(arg_3_0.maxImg, var_3_4)

			setActive = var_2_10001

			var_2_10001(arg_3_0.fillAnim, false)

			local var_6_0 = arg_3_0.fillImg
			local var_6_1 = var_1.GetComponent

			typeof = var_3
			Image = var_2_10004

			local var_6_2 = var_6_1(var_6_0, var_3(var_2_10004))

			var_6_2.fillAmount = var_3_3
			setText = var_6_2

			local var_6_3 = arg_3_0.ratioText

			string = var_3

			local var_6_4 = var_3.format
			local var_6_5 = "%02d.%d%%"

			math = var_2_10005

			local var_6_6 = var_2_10005.floor(var_3_3 * 100)

			math = var_6

			var_6_2(var_6_3, var_6_4(var_6_5, var_6_6, var_6.round(var_3_3 * 1000) % 10))

			if var_3_1 and var_3_2 == var_0 then
				local var_6_7 = arg_3_0.viewParent
				local var_6_8 = var_1.emit

				LevelUIConst = var_3

				var_6_8(var_6_7, var_3.FROZEN)

				pg = var_6_8

				local var_6_9 = var_6_8.UIMgr.GetInstance()

				var_1.OverlayPanel(var_6_9, arg_3_0.banner)

				local var_6_10 = arg_3_0.banner
				local var_6_11 = var_1.Find(var_6_10, "Main/Painting")
				local var_6_12 = var_1.GetComponent

				typeof = var_6_5
				Image = var_6_6

				local var_6_13 = var_6_12(var_6_11, var_6_5(var_6_6))

				math = var_6_11

				local var_6_14 = var_6_11.random(arg_3_0.PAINTING_RANGE[1], arg_3_0.PAINTING_RANGE[2])

				setImageSprite = var_4

				local var_6_15 = var_1

				LoadSprite = var_6

				local var_6_16 = "ui/LevelStageDOAFeverPanel_atlas"

				tostring = var_2_10008

				var_4(var_6_15, var_6(var_6_16, var_2_10008(var_6_14)), true)

				setActive = var_4

				var_4(arg_3_0.banner, true)

				var_6_13.enabled = true

				local function var_6_17()
					var_6_13.enabled = false

					local var_7_0 = var_6_13

					var_7_0.sprite = nil
					pg = var_7_0

					local var_7_1 = var_7_0.UIMgr.GetInstance()

					var_0.UnOverlayPanel(var_7_1, arg_3_0.banner, arg_3_0._tf)

					setActive = var_0

					var_0(arg_3_0.banner, false)

					local var_7_2 = arg_3_0.viewParent
					local var_7_3 = var_0.emit

					LevelUIConst = var_2

					var_7_3(var_7_2, var_2.UN_FROZEN)
					arg_6_0()

					return
				end

				local var_6_18 = arg_3_0.banner
				local var_6_19 = var_5.GetComponent

				typeof = var_7
				DftAniEvent = var_8

				local var_6_20 = var_6_19(var_6_18, var_7(var_8))

				var_5.SetEndEvent(var_6_20, var_6_17)

				onButton = var_6

				var_6(arg_3_0, arg_3_0.banner, var_6_17)
			else
				arg_6_0()
			end

			return
		end,
		arg_3_2
	})

	return
end

return var_0_1
