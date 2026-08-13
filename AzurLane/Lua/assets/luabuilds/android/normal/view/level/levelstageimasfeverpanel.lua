class = var_0_10000

local var_0_0 = "LevelStageIMasFeverPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubPanel"))

function var_0_1.getUIName(arg_1_0)
	return "LevelStageIMasFeverPanel"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.fillImg = var_1.Find(var_2_0, "Fill")

	local var_2_1 = arg_2_0._tf

	arg_2_0.banner = var_1.Find(var_2_1, "Banner")
	setActive = var_1

	var_1(arg_2_0.banner, false)

	return
end

local var_0_2 = {
	[0] = 0,
	0.38,
	0.5471839,
	0.7228736,
	1
}
local var_0_3 = {
	"Yellow",
	"Red",
	"Blue"
}

function var_0_1.UpdateView(arg_3_0, arg_3_1, arg_3_2)
	getProxy = var_1_10003
	ChapterProxy = var_1_10004

	local var_3_0 = var_1_10003(var_1_10004)
	local var_3_1 = var_3.GetLastDefeatedEnemy(var_3_0, arg_3_1.id)
	local var_3_2 = arg_3_1.defeatEnemies

	pg = var_5

	local var_3_3 = var_5.gameset.doa_fever_count.key_value
	local var_3_4 = var_0_2

	Mathf = var_1_10007

	local var_3_5 = var_3_4[var_1_10007.Min(var_3_3, var_3_2)]

	seriesAsync = var_7

	var_7({
		function(arg_4_0)
			LeanTween = var_2_10001

			local var_4_0 = var_2_10001.cancel

			go = var_2_10002

			var_4_0(var_2_10002(arg_3_0.fillImg))

			if not var_3_1 or var_3_2 > var_3_3 then
				arg_4_0()

				return
			end

			math = var_1

			local var_4_1 = var_1.max(var_3_2 - 1, 0)
			local var_4_2 = arg_3_0.fillImg
			local var_4_3 = var_2.GetComponent

			typeof = var_2_10004
			Image = var_2_10005

			local var_4_4 = var_4_3(var_4_2, var_2_10004(var_2_10005))
			local var_4_5 = var_0_2[var_4_1]

			LeanTween = var_4

			local var_4_6 = var_4.value

			go = var_2_10005

			local var_4_7 = var_4_6(var_2_10005(arg_3_0.fillImg), 0, 1, 1)
			local var_4_8 = var_4.setOnUpdate

			System = var_6

			local var_4_9 = var_4_8(var_4_7, var_6.Action_float(function(arg_5_0)
				Mathf = var_3_10001

				local var_5_0 = var_3_10001.Lerp(var_4_5, var_3_5, arg_5_0)

				var_4_4.fillAmount = var_5_0

				return
			end))
			local var_4_10 = var_4.setOnComplete

			System = var_6

			var_4_10(var_4_9, var_6.Action(arg_4_0))

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_3_0.fillImg
			local var_6_1 = var_1.GetComponent

			typeof = var_2_10003
			Image = var_2_10004
			var_6_1(var_6_0, var_2_10003(var_2_10004)).fillAmount = var_3_5

			if var_3_1 and var_3_2 == var_3_3 then
				local var_6_2 = arg_3_0

				var_1.ShowPanel(var_6_2, arg_3_1)
			end

			existCall = var_1

			var_1(arg_3_2)

			return
		end
	})

	return
end

function var_0_1.ShowPanel(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.viewParent
	local var_7_1 = var_2.emit

	LevelUIConst = var_1_10004

	var_7_1(var_7_0, var_1_10004.FROZEN)

	pg = var_7_1

	local var_7_2 = var_7_1.UIMgr.GetInstance()

	var_2.OverlayPanel(var_7_2, arg_7_0.banner)

	local var_7_3 = var_0_3[1]
	local var_7_4 = arg_7_1

	if arg_7_1.GetBuffOfLinkAct(var_7_4) then
		pg = var_7_4

		local var_7_5 = var_7_4.gameset.doa_fever_buff.description
		local var_7_6 = var_0_3

		table = var_1_10006
		var_7_3 = var_7_6[var_1_10006.indexof(var_7_5, var_3)]
	end

	local var_7_7 = arg_7_0.banner
	local var_7_8 = var_4.Find(var_7_7, var_7_3)
	local var_7_9 = var_4.Find(var_7_8, "Character")
	local var_7_10 = var_5.GetComponent

	typeof = var_1_10008
	Image = var_1_10009

	local var_7_11 = var_7_10(var_7_9, var_1_10008(var_1_10009))

	math = var_7_9

	local var_7_12 = var_7_9.random(1, 7)

	setImageSprite = var_8

	local var_7_13 = var_5

	LoadSprite = var_1_10010

	local var_7_14 = "ui/LevelStageIMasFeverPanel_atlas"
	local var_7_15 = "character"

	tostring = var_1_10013

	var_8(var_7_13, var_1_10010(var_7_14, var_7_15 .. var_1_10013(var_7_12)))

	setActive = var_8

	var_8(arg_7_0.banner, true)

	setActive = var_8

	var_8(var_4, true)

	var_7_11.enabled = true

	local function var_7_16()
		local var_8_0 = arg_7_0

		var_0.ClosePanel(var_8_0)

		return
	end

	local var_7_17 = var_4
	local var_7_18 = var_4.GetComponent

	typeof = var_7_14
	DftAniEvent = var_12

	local var_7_19 = var_7_18(var_7_17, var_7_14(var_12))

	var_9.SetEndEvent(var_7_19, var_7_16)

	onButton = var_10

	var_10(arg_7_0, arg_7_0.banner, var_7_16)

	arg_7_0.showingPanel = true

	return
end

function var_0_1.ClosePanel(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_0, arg_9_0.banner, arg_9_0._tf)

	setActive = var_1

	var_1(arg_9_0.banner, false)

	local var_9_1 = arg_9_0.viewParent
	local var_9_2 = var_1.emit

	LevelUIConst = var_3

	var_9_2(var_9_1, var_3.UN_FROZEN)

	arg_9_0.showingPanel = nil

	return
end

function var_0_1.OnDestroy(arg_10_0)
	if arg_10_0.showingPanel then
		arg_10_0:ClosePanel()
	end

	return
end

return var_0_1
