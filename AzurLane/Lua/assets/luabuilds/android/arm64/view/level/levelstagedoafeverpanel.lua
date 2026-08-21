local var_0_0 = class("LevelStageDOAFeverPanel", import("view.base.BaseSubPanel"))

var_0_0.PAINTING_RANGE = {
	1,
	7
}

function var_0_0.getUIName(arg_1_0)
	return "LevelStageDOAFeverPanel"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.fillImg = arg_2_0._tf:Find("Fill")
	arg_2_0.maxImg = arg_2_0._tf:Find("Max")

	setActive(arg_2_0.maxImg, false)

	arg_2_0.ratioText = arg_2_0._tf:Find("Text")
	arg_2_0.banner = arg_2_0._tf:Find("Banner")

	setActive(arg_2_0.banner, false)

	arg_2_0.fillAnim = arg_2_0.fillImg:Find("Anim")

	return
end

function var_0_0.UpdateView(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = getProxy(ChapterProxy):GetLastDefeatedEnemy(arg_3_1.id)
	local var_3_1 = arg_3_1.defeatEnemies / pg.gameset.doa_fever_count.key_value
	local var_3_2 = pg.gameset.doa_fever_count.key_value <= arg_3_1.defeatEnemies

	seriesAsync({
		function(arg_4_0)
			LeanTween.cancel(go(arg_3_0.fillImg), true)

			if not var_3_0 or var_0 > var_0 then
				arg_4_0()

				return
			end

			setActive(arg_3_0.maxImg, false)
			setActive(arg_3_0.fillImg, true)
			setActive(arg_3_0.ratioText, true)
			setActive(arg_3_0.fillAnim, true)

			local var_4_0 = math.max(var_0 - 1, 0)
			local var_4_1 = arg_3_0.fillImg:GetComponent(typeof(Image))
			local var_4_2 = arg_3_0.fillImg.rect.height
			local var_4_3 = arg_3_0.fillAnim.rect.height
			local var_4_4 = 3.115264797507788

			LeanTween.value(go(arg_3_0.fillImg), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_5_0)
				local var_5_0 = Mathf.Lerp(var_4_0, var_0, arg_5_0) / var_0

				arg_3_0.fillAnim.anchoredPosition = Vector2(0, var_5_0 * var_0)
				arg_3_0.fillAnim.sizeDelta = Vector2(math.sqrt(math.max(var_4_2 * var_4_2 - var_5_0 * var_0 * (var_5_0 * var_0), 0)) * var_4_4, math.min(1.5 - arg_5_0, 1) * var_4_3)
				var_4_1.fillAmount = var_5_0

				setText(arg_3_0.ratioText, string.format("%02d.%d%%", math.floor(var_5_0 * 100), math.round(var_5_0 * 1000) % 10))

				return
			end)):setOnComplete(System.Action(arg_4_0))

			return
		end,
		function(arg_6_0)
			setActive(arg_3_0.fillImg, not var_3_2)
			setActive(arg_3_0.ratioText, not var_3_2)
			setActive(arg_3_0.maxImg, var_3_2)
			setActive(arg_3_0.fillAnim, false)

			arg_3_0.fillImg:GetComponent(typeof(Image)).fillAmount = var_3_1

			setText(arg_3_0.ratioText, string.format("%02d.%d%%", math.floor(var_3_1 * 100), math.round(var_3_1 * 1000) % 10))

			if var_3_0 and var_0 == var_0 then
				arg_3_0.viewParent:emit(LevelUIConst.FROZEN)
				pg.UIMgr.GetInstance():OverlayPanel(arg_3_0.banner)

				local var_6_0 = arg_3_0.banner:Find("Main/Painting")
				local var_6_1 = var_6_0:GetComponent(typeof(Image))

				setImageSprite(var_6_0, LoadSprite("ui/LevelStageDOAFeverPanel_atlas", tostring((math.random(arg_3_0.PAINTING_RANGE[1], arg_3_0.PAINTING_RANGE[2])))), true)
				setActive(arg_3_0.banner, true)

				var_6_0:GetComponent(typeof(Image)).enabled = true

				arg_3_0.banner:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
					var_6_1.enabled = false
					var_6_1.sprite = nil

					pg.UIMgr.GetInstance():UnOverlayPanel(arg_3_0.banner, arg_3_0._tf)
					setActive(arg_3_0.banner, false)
					arg_3_0.viewParent:emit(LevelUIConst.UN_FROZEN)
					arg_6_0()

					return
				end)
				onButton(arg_3_0, arg_3_0.banner, function()
					var_6_1.enabled = false
					var_6_1.sprite = nil

					pg.UIMgr.GetInstance():UnOverlayPanel(arg_3_0.banner, arg_3_0._tf)
					setActive(arg_3_0.banner, false)
					arg_3_0.viewParent:emit(LevelUIConst.UN_FROZEN)
					arg_6_0()

					return
				end)
			else
				arg_6_0()
			end

			return
		end,
		arg_3_2
	})

	return
end

return var_0_0
