local var_0_0 = class("SenrankaguraMainPage", import(".TemplatePage.PreviewTemplatePage"))

var_0_0.SWITCH_INTERVAL = 6
var_0_0.SWITCH_TIME = 0.5
var_0_0.SWITCH_WIDTH = 367
var_0_0.TACHIE_DELAY = 0.03

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD/mask")
	arg_1_0.btnList = arg_1_0.bg:Find("btn_list")
	arg_1_0.main = arg_1_0.bg:Find("main")
	arg_1_0.totalNum = arg_1_0.main.childCount
	arg_1_0.randomList = {}
	arg_1_0.children = {}

	for iter_1_0 = 1, arg_1_0.totalNum do
		local var_1_0 = arg_1_0.main:GetChild(iter_1_0 - 1)

		table.insert(arg_1_0.children, var_1_0)
		setActive(var_1_0, false)

		if PLATFORM_CODE ~= PLATFORM_CH then
			local var_1_1 = findTF(var_1_0, "hx")

			if var_1_1 then
				setActive(var_1_1, false)
			end
		end
	end

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.btnList:Find("mountain"), function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SENRANKAGURA_BACKHILL)

		return
	end, SFX_PANEL)

	for iter_2_0 = 1, arg_2_0.totalNum do
		table.insert(arg_2_0.randomList, iter_2_0)
	end

	shuffle(arg_2_0.randomList)

	arg_2_0.index = 1

	setActive(arg_2_0.children[arg_2_0.randomList[arg_2_0.index]], true)

	arg_2_0.LTList = {}

	function arg_2_0.Interval()
		table.insert(arg_2_0.LTList, LeanTween.delayedCall(go(arg_2_0._tf), var_0_0.SWITCH_INTERVAL, System.Action(arg_2_0.FadeIn)).uniqueId)

		return
	end

	function arg_2_0.FadeIn()
		arg_2_0.index = arg_2_0.index % arg_2_0.totalNum + 1

		local var_5_0 = var_0_0.SWITCH_WIDTH

		setActive(arg_2_0.children[arg_2_0.randomList[arg_2_0.index]], true)

		local var_5_1 = {
			0,
			var_0_0.TACHIE_DELAY,
			var_0_0.TACHIE_DELAY
		}

		table.insert(arg_2_0.LTList, LeanTween.delayedCall(go(arg_2_0._tf), var_0_0.SWITCH_TIME + var_0_0.TACHIE_DELAY, System.Action(arg_2_0.Interval)).uniqueId)
		table.Foreach({
			findTF(arg_2_0.children[arg_2_0.randomList[arg_2_0.index]], "bg"),
			findTF(arg_2_0.children[arg_2_0.randomList[arg_2_0.index]], "tachie"),
			findTF(arg_2_0.children[arg_2_0.randomList[arg_2_0.index]], "hx")
		}, function(arg_6_0, arg_6_1)
			setImageAlpha(arg_6_1, 0)
			setAnchoredPosition(arg_6_1, {
				x = var_5_0 + rtf(arg_6_1).anchoredPosition.x
			})

			if var_5_1[arg_6_0] > 0 then
				table.insert(arg_2_0.LTList, LeanTween.delayedCall(go(arg_6_1), var_5_1[arg_6_0], System.Action(function()
					table.insert(arg_2_0.LTList, LeanTween.alpha(arg_6_1, 1, var_0_0.SWITCH_TIME):setEase(LeanTweenType.easeOutSine).uniqueId)
					table.insert(arg_2_0.LTList, LeanTween.moveX(rtf(arg_6_1), 0 + var_0, var_0_0.SWITCH_TIME):setEase(LeanTweenType.easeOutSine).uniqueId)

					return
				end)).uniqueId)
			else
				(function()
					table.insert(arg_2_0.LTList, LeanTween.alpha(arg_6_1, 1, var_0_0.SWITCH_TIME):setEase(LeanTweenType.easeOutSine).uniqueId)
					table.insert(arg_2_0.LTList, LeanTween.moveX(rtf(arg_6_1), 0 + var_0, var_0_0.SWITCH_TIME):setEase(LeanTweenType.easeOutSine).uniqueId)

					return
				end)()
			end

			return
		end)
		table.Foreach({
			findTF(arg_2_0.children[arg_2_0.randomList[arg_2_0.index]], "bg"),
			findTF(arg_2_0.children[arg_2_0.randomList[arg_2_0.index]], "tachie"),
			findTF(arg_2_0.children[arg_2_0.randomList[arg_2_0.index]], "hx")
		}, function(arg_8_0, arg_8_1)
			local var_8_0 = rtf(arg_8_1).anchoredPosition.x

			local function var_8_1()
				setAnchoredPosition(arg_8_1, {
					x = var_8_0
				})

				return
			end

			if var_5_1[arg_8_0] > 0 then
				table.insert(arg_2_0.LTList, LeanTween.delayedCall(go(arg_8_1), var_5_1[arg_8_0], System.Action(function()
					table.insert(arg_2_0.LTList, LeanTween.alpha(arg_8_1, 0, var_0_0.SWITCH_TIME):setEase(LeanTweenType.easeOutSine).uniqueId)
					table.insert(arg_2_0.LTList, LeanTween.moveX(rtf(arg_8_1), -var_5_0 + var_8_0, var_0_0.SWITCH_TIME):setOnComplete(System.Action(var_8_1)):setEase(LeanTweenType.easeOutSine).uniqueId)

					return
				end)).uniqueId)
			else
				(function()
					table.insert(arg_2_0.LTList, LeanTween.alpha(arg_8_1, 0, var_0_0.SWITCH_TIME):setEase(LeanTweenType.easeOutSine).uniqueId)
					table.insert(arg_2_0.LTList, LeanTween.moveX(rtf(arg_8_1), -var_5_0 + var_8_0, var_0_0.SWITCH_TIME):setOnComplete(System.Action(var_8_1)):setEase(LeanTweenType.easeOutSine).uniqueId)

					return
				end)()
			end

			return
		end)

		return
	end

	arg_2_0.Interval()

	return
end

function var_0_0.OnDestroy(arg_11_0)
	local var_11_0 = arg_11_0.LTList or {}

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		LeanTween.cancel(iter_11_1)
	end

	return
end

return var_0_0
