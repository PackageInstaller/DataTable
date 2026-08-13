class = var_0_10000

local var_0_0 = "LevelStageIMasFeverPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubPanel"))

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
	ChapterProxy = var_1_10005

	local var_3_0 = var_1_10003(var_1_10005)
	local var_3_1 = var_3.GetLastDefeatedEnemy(var_3_0, arg_3_1.id)
	local var_3_2 = arg_3_1.defeatEnemies

	pg = var_3_0

	local var_3_3 = var_3_0.gameset.doa_fever_count.key_value
	local var_3_4 = var_0_2

	Mathf = var_1_10007

	local var_3_5 = var_3_4[var_1_10007.Min(var_3_3, var_3_2)]

	seriesAsync = var_7

	var_7({
		function(arg_4_0)
			LeanTween = var_2_10001

			local var_4_0 = var_2_10001.cancel

			go = var_2_10003

			var_4_0(var_2_10003(arg_3_0.fillImg))

			if not var_3_1 or var_3_2 > var_3_3 then
				arg_4_0()

				return
			end

			math = var_1

			local var_4_1 = var_1.max(var_3_2 - 1, 0)
			local var_4_2 = arg_3_0.fillImg
			local var_4_3 = var_2.GetComponent

			typeof = var_5
			Image = var_2_10007

			local var_4_4 = var_4_3(var_4_2, var_5(var_2_10007))
			local var_4_5 = var_0_2[var_4_1]

			LeanTween = var_4_2

			local var_4_6 = var_4_2.value

			go = var_2_10006

			local var_4_7 = var_4_6(var_2_10006(arg_3_0.fillImg), 0, 1, 1)
			local var_4_8 = var_4.setOnUpdate

			System = var_7

			local var_4_9 = var_4_8(var_4_7, var_7.Action_float(function(arg_5_0)
				Mathf = var_3_10001

				local var_5_0 = var_3_10001.Lerp(var_4_5, var_3_5, arg_5_0)

				var_4_4.fillAmount = var_5_0

				return
			end))
			local var_4_10 = var_4.setOnComplete

			System = var_7

			var_4_10(var_4_9, var_7.Action(arg_4_0))

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_3_0.fillImg
			local var_6_1 = var_1.GetComponent

			typeof = var_2_10004
			Image = var_2_10006
			var_6_1(var_6_0, var_2_10004(var_2_10006)).fillAmount = var_3_5

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

	LevelUIConst = var_1_10005

	var_7_1(var_7_0, var_1_10005.FROZEN)

	pg = var_7_1

	local var_7_2 = var_7_1.UIMgr.GetInstance()

	var_2.OverlayPanel(var_7_2, arg_7_0.banner)

	local var_7_3 = var_0_3[1]

	if arg_7_1:GetBuffOfLinkAct() then
		pg = var_7_2

		local var_7_4 = var_7_2.gameset.doa_fever_buff.description
		local var_7_5 = var_0_3

		table = var_1_10006
		var_7_3 = var_7_5[var_1_10006.indexof(var_7_4, var_3)]
	end

	local var_7_6 = arg_7_0.banner
	local var_7_7 = var_4.Find(var_7_6, var_7_3)
	local var_7_8 = var_4.Find(var_7_7, "Character")
	local var_7_9 = var_5.GetComponent

	typeof = var_1_10009
	Image = var_1_10011

	local var_7_10 = var_7_9(var_7_8, var_1_10009(var_1_10011))

	math = var_7_7

	local var_7_11 = var_7_7.random(1, 7)

	setImageSprite = var_7_8

	local var_7_12 = var_5

	LoadSprite = var_1_10011

	local var_7_13 = "ui/LevelStageIMasFeverPanel_atlas"
	local var_7_14 = "character"

	tostring = var_1_10015

	var_7_8(var_7_12, var_1_10011(var_7_13, var_7_14 .. var_1_10015(var_7_11)))

	setActive = var_7_8

	var_7_8(arg_7_0.banner, true)

	setActive = var_7_8

	var_7_8(var_4, true)

	var_7_10.enabled = true

	local function var_7_15()
		local var_8_0 = arg_7_0

		var_0.ClosePanel(var_8_0)

		return
	end

	local var_7_16 = var_4
	local var_7_17 = var_4.GetComponent

	typeof = var_1_10012
	DftAniEvent = var_14

	local var_7_18 = var_7_17(var_7_16, var_1_10012(var_14))

	var_9.SetEndEvent(var_7_18, var_7_15)

	onButton = var_10

	var_10(arg_7_0, arg_7_0.banner, var_7_15)

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

	LevelUIConst = var_4

	var_9_2(var_9_1, var_4.UN_FROZEN)

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
