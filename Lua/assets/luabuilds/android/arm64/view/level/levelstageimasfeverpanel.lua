local var_0_0 = class("LevelStageIMasFeverPanel", import("view.base.BaseSubPanel"))

function var_0_0.getUIName(arg_1_0)
	return "LevelStageIMasFeverPanel"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.fillImg = arg_2_0._tf:Find("Fill")
	arg_2_0.banner = arg_2_0._tf:Find("Banner")

	setActive(arg_2_0.banner, false)

	return
end

local var_0_1 = {
	[0] = 0,
	0.38,
	0.5471839,
	0.7228736,
	1
}
local var_0_2 = {
	"Yellow",
	"Red",
	"Blue"
}

function var_0_0.UpdateView(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = getProxy(ChapterProxy):GetLastDefeatedEnemy(arg_3_1.id)
	local var_3_1 = var_0_1[Mathf.Min(pg.gameset.doa_fever_count.key_value, arg_3_1.defeatEnemies)]

	seriesAsync({
		function(arg_4_0)
			LeanTween.cancel(go(arg_3_0.fillImg))

			local var_4_0

			if not var_3_0 or var_0 > var_0 then
				arg_4_0()

				do return end

				var_4_0 = arg_3_0.fillImg:GetComponent(typeof(Image))
			end

			local var_4_1 = var_0_1[math.max(var_0 - 1, 0)]

			LeanTween.value(go(arg_3_0.fillImg), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_5_0)
				var_4_0.fillAmount = Mathf.Lerp(var_4_1, var_3_1, arg_5_0)

				return
			end)):setOnComplete(System.Action(arg_4_0))

			return
		end,
		function(arg_6_0)
			arg_3_0.fillImg:GetComponent(typeof(Image)).fillAmount = var_3_1

			if var_3_0 and var_0 == var_0 then
				arg_3_0:ShowPanel(arg_3_1)
			end

			existCall(arg_3_2)

			return
		end
	})

	return
end

function var_0_0.ShowPanel(arg_7_0, arg_7_1)
	arg_7_0.viewParent:emit(LevelUIConst.FROZEN)
	pg.UIMgr.GetInstance():OverlayPanel(arg_7_0.banner)

	local var_7_0 = var_0_2[1]
	local var_7_1 = arg_7_1:GetBuffOfLinkAct()

	if var_7_1 then
		var_7_0 = var_0_2[table.indexof(pg.gameset.doa_fever_buff.description, var_7_1)]
	end

	local var_7_2 = arg_7_0.banner:Find(var_7_0)
	local var_7_3 = var_7_2:Find("Character")

	setImageSprite(var_7_3, LoadSprite("ui/LevelStageIMasFeverPanel_atlas", "character" .. tostring((math.random(1, 7)))))
	setActive(arg_7_0.banner, true)
	setActive(var_7_2, true)

	var_7_3:GetComponent(typeof(Image)).enabled = true

	var_7_2:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		arg_7_0:ClosePanel()

		return
	end)
	onButton(arg_7_0, arg_7_0.banner, function()
		arg_7_0:ClosePanel()

		return
	end)

	arg_7_0.showingPanel = true

	return
end

function var_0_0.ClosePanel(arg_9_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0.banner, arg_9_0._tf)
	setActive(arg_9_0.banner, false)
	arg_9_0.viewParent:emit(LevelUIConst.UN_FROZEN)

	arg_9_0.showingPanel = nil

	return
end

function var_0_0.OnDestroy(arg_10_0)
	if arg_10_0.showingPanel then
		arg_10_0:ClosePanel()
	end

	return
end

return var_0_0
