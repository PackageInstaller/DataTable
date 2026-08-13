class = var_0_10000

local var_0_0 = "LevelStageSSSSFeverPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubPanel"))

function var_0_1.getUIName(arg_1_0)
	return "LevelStageSSSSFeverPanel"
end

var_0_1.stepCount = 10
var_0_1.enemyCount = 4

local var_0_2 = {
	liuhua = {
		9401,
		9403,
		9406,
		9409,
		9412,
		9415
	},
	mengya = {
		9421,
		9423,
		9426,
		9429,
		9432,
		9435
	},
	qianlai = {
		9441,
		9443,
		9446,
		9449,
		9452,
		9455
	}
}
local var_0_3 = {
	qian = {
		9461,
		9463,
		9466,
		9469,
		9472,
		9475
	},
	he = {
		9481,
		9483,
		9486,
		9489,
		9492,
		9495
	}
}

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.GetBarTFGroup
	local var_2_2 = arg_2_0._tf

	arg_2_0.barGroup1 = var_2_1(var_2_0, var_3.Find(var_2_2, "Bar1"))

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.GetBarTFGroup
	local var_2_5 = arg_2_0._tf

	arg_2_0.barGroup2 = var_2_4(var_2_3, var_3.Find(var_2_5, "Bar2"))

	local var_2_6 = arg_2_0._tf

	arg_2_0.banner = var_1.Find(var_2_6, "Banner")
	setActive = var_1

	var_1(arg_2_0.banner, false)

	arg_2_0.buff2Character = {}
	pairs = var_1

	for iter_2_0, iter_2_1 in var_1(var_0_2) do
		ipairs = var_1_10006

		for iter_2_2, iter_2_3 in var_1_10006(iter_2_1) do
			arg_2_0.buff2Character[iter_2_3] = iter_2_0
		end
	end

	arg_2_0.buff2Enemy = {}
	pairs = var_1

	for iter_2_4, iter_2_5 in var_1(var_0_3) do
		ipairs = var_1_10006

		for iter_2_6, iter_2_7 in var_1_10006(iter_2_5) do
			arg_2_0.buff2Enemy[iter_2_7] = iter_2_4
		end
	end

	AutoLoader = var_1
	arg_2_0.loader = var_1.New()
	AsyncExcutionRequestPackage = var_1
	arg_2_0.animations = var_1.New({})
	AsyncExcutionRequestPackage = var_1
	arg_2_0.PanelAnimations = var_1.New({})
	arg_2_0.cleanActions = {}

	return
end

function var_0_1.GetIcon(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1.buff_list
	local var_3_1

	if not arg_3_2 or not arg_3_0.buff2Character then
		var_3_1 = arg_3_0.buff2Enemy
	end

	ipairs = var_1_10005

	for iter_3_0, iter_3_1 in var_1_10005(var_3_0) do
		if var_3_1[iter_3_1] then
			return var_3_1[iter_3_1]
		end
	end

	return ""
end

function var_0_1.GetBarTFGroup(arg_4_0, arg_4_1)
	return {
		main = arg_4_1,
		fillImg = arg_4_1:Find("Fill"),
		ratioText = arg_4_1:Find("Text"),
		iconImg = arg_4_1:Find("Icon")
	}
end

local var_0_4 = {
	1590001,
	1590051
}

function var_0_1.UpdateView(arg_5_0, arg_5_1, arg_5_2)
	table = var_1_10003

	if var_1_10003.contains(var_0_4, arg_5_1.id) then
		arg_5_0:Hide()

		existCall = var_3

		var_3(arg_5_2)

		return
	end

	arg_5_0:UpdateKaijuBar(arg_5_1)
	arg_5_0:UpdateSyberSquadBar(arg_5_1)

	local var_5_0 = arg_5_0.animations

	var_3.Resume(var_5_0)

	local var_5_1 = arg_5_0.PanelAnimations

	var_3.Insert(var_5_1, function(arg_6_0)
		existCall = var_2_10001

		var_2_10001(arg_5_2)
		arg_6_0()

		return
	end)

	local var_5_2 = arg_5_0.PanelAnimations

	var_3.Resume(var_5_2)

	return
end

function var_0_1.UpdateKaijuBar(arg_7_0, arg_7_1)
	getProxy = var_1_10002
	ChapterProxy = var_1_10003

	local var_7_0 = var_1_10002(var_1_10003)
	local var_7_1 = var_2.GetExtendChapterData(var_7_0, arg_7_1.id, "FleetMoveDistance")
	local var_7_2 = arg_7_1.moveStep
	local var_7_3 = arg_7_1
	local var_7_4 = arg_7_1.isLoop(var_7_3) and 0 or var_0_1.stepCount

	math = var_7_3

	local var_7_5 = var_7_3.min(var_7_2 / var_7_4, 1)
	local var_7_6 = arg_7_0.barGroup1.fillImg
	local var_7_7 = var_6.GetComponent

	typeof = var_1_10009
	Image = var_1_10010

	local var_7_8 = var_7_7(var_7_6, var_1_10009(var_1_10010))
	local var_7_9 = arg_7_0.barGroup1.ratioText

	if var_7_1 and var_7_2 <= var_7_4 then
		local var_7_10 = arg_7_0.animations

		var_9.Insert(var_7_10, function(arg_8_0)
			local var_8_0 = (var_7_2 - var_7_1) / var_7_4

			math = var_2_10003

			local var_8_1 = var_2_10003.min(var_7_1, var_7_4 - var_1)

			LeanTween = var_4

			local var_8_2 = var_4.value

			go = var_5

			local var_8_3 = var_8_2(var_5(var_0), 0, 1, var_8_1)
			local var_8_4 = var_4.setOnUpdate

			System = var_6

			local var_8_5 = var_8_4(var_8_3, var_6.Action_float(function(arg_9_0)
				Mathf = var_3_10001

				local var_9_0 = var_3_10001.Lerp(var_8_0, var_7_5, arg_9_0)
				local var_9_1 = var_7_8

				var_9_1.fillAmount = var_9_0
				setText = var_9_1

				local var_9_2 = var_7_9

				string = var_4

				local var_9_3 = var_4.format
				local var_9_4 = "%02d%%"

				math = var_3_10006

				var_9_1(var_9_2, var_9_3(var_9_4, var_3_10006.floor(var_9_0 * 100)))

				return
			end))
			local var_8_6 = var_4.setOnComplete

			System = var_6

			var_8_6(var_8_5, var_6.Action(arg_8_0))

			return
		end)
	end

	local var_7_11 = arg_7_0:GetIcon(arg_7_1, false)
	local var_7_12 = arg_7_0.animations

	var_10.Insert(var_7_12, function(arg_10_0)
		local var_10_0 = var_7_8

		var_10_0.fillAmount = var_7_5
		setText = var_10_0

		local var_10_1 = var_7_9

		string = var_2_10003

		local var_10_2 = var_2_10003.format
		local var_10_3 = "%02d%%"

		math = var_2_10005

		var_10_0(var_10_1, var_10_2(var_10_3, var_2_10005.floor(var_7_5 * 100)))

		if var_7_5 >= 1 then
			local var_10_4 = arg_7_0.loader

			var_1.GetSpriteQuiet(var_10_4, "ui/LevelStageSSSSFeverPanel_atlas", "icon_" .. var_7_11, arg_7_0.barGroup1.iconImg, true)
		end

		arg_10_0()

		return
	end)

	if var_7_1 and var_7_4 > var_7_2 - var_7_1 and var_7_4 <= var_7_2 then
		local var_7_13 = arg_7_0.PanelAnimations

		var_10.Insert(var_7_13, function(arg_11_0)
			local var_11_0 = arg_7_0

			var_1.ShowPanel(var_11_0, var_7_11, "Kaiju", arg_11_0, var_7_11 == "he" and "" or "2")

			return
		end)
	end

	return
end

function var_0_1.UpdateSyberSquadBar(arg_12_0, arg_12_1)
	getProxy = var_1_10002
	ChapterProxy = var_1_10003

	local var_12_0 = var_1_10002(var_1_10003)
	local var_12_1 = var_2.GetLastDefeatedEnemy(var_12_0, arg_12_1.id)
	local var_12_2 = arg_12_1.defeatEnemies
	local var_12_3 = arg_12_1
	local var_12_4 = arg_12_1.isLoop(var_12_3) and 0 or var_0_1.enemyCount

	math = var_12_3

	local var_12_5 = var_12_3.min(var_12_2 / var_12_4, 1)
	local var_12_6 = arg_12_0.barGroup2.fillImg
	local var_12_7 = var_6.GetComponent

	typeof = var_1_10009
	Image = var_1_10010

	local var_12_8 = var_12_7(var_12_6, var_1_10009(var_1_10010))
	local var_12_9 = arg_12_0.barGroup2.ratioText

	if var_12_1 and var_12_2 <= var_12_4 then
		local var_12_10 = arg_12_0.animations

		var_9.Insert(var_12_10, function(arg_13_0)
			math = var_2_10001

			local var_13_0 = var_2_10001.max(var_12_2 - 1, 0) / var_12_4

			LeanTween = var_3

			local var_13_1 = var_3.value

			go = var_2_10004

			local var_13_2 = var_13_1(var_2_10004(var_0), 0, 1, 1)
			local var_13_3 = var_3.setOnUpdate

			System = var_5

			local var_13_4 = var_13_3(var_13_2, var_5.Action_float(function(arg_14_0)
				Mathf = var_3_10001

				local var_14_0 = var_3_10001.Lerp(var_13_0, var_12_5, arg_14_0)
				local var_14_1 = var_12_8

				var_14_1.fillAmount = var_14_0
				setText = var_14_1

				local var_14_2 = var_12_9

				string = var_4

				local var_14_3 = var_4.format
				local var_14_4 = "%02d%%"

				math = var_3_10006

				var_14_1(var_14_2, var_14_3(var_14_4, var_3_10006.floor(var_14_0 * 100)))

				return
			end))
			local var_13_5 = var_3.setOnComplete

			System = var_5

			var_13_5(var_13_4, var_5.Action(arg_13_0))

			return
		end)
	end

	local var_12_11 = arg_12_0:GetIcon(arg_12_1, true)
	local var_12_12 = arg_12_0.animations

	var_10.Insert(var_12_12, function(arg_15_0)
		local var_15_0 = var_12_8

		var_15_0.fillAmount = var_12_5
		setText = var_15_0

		local var_15_1 = var_12_9

		string = var_2_10003

		local var_15_2 = var_2_10003.format
		local var_15_3 = "%02d%%"

		math = var_2_10005

		var_15_0(var_15_1, var_15_2(var_15_3, var_2_10005.floor(var_12_5 * 100)))

		if var_12_5 >= 1 then
			local var_15_4 = arg_12_0.loader

			var_1.GetSpriteQuiet(var_15_4, "ui/LevelStageSSSSFeverPanel_atlas", "icon_" .. var_12_11, arg_12_0.barGroup2.iconImg, true)
		end

		arg_15_0()

		return
	end)

	if var_12_1 and var_12_2 == var_12_4 then
		local var_12_13 = arg_12_0.PanelAnimations

		var_10.Insert(var_12_13, function(arg_16_0)
			local var_16_0 = arg_12_0

			var_1.ShowPanel(var_16_0, var_12_11, "SyberSquad", arg_16_0)

			return
		end)
	end

	return
end

function var_0_1.ShowPanel(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.emit

	LevelUIConst = var_1_10007

	var_17_1(var_17_0, var_1_10007.FROZEN)

	pg = var_17_1

	local var_17_2 = var_17_1.UIMgr.GetInstance()

	var_5.BlurPanel(var_17_2, arg_17_0.banner)

	local var_17_3 = arg_17_0.banner
	local var_17_4 = var_5.Find(var_17_3, arg_17_2)
	local var_17_5 = var_5.Find(var_17_4, "Character")
	local var_17_6 = var_6.GetComponent

	typeof = var_1_10009
	Image = var_1_10010

	local var_17_7 = var_17_6(var_17_5, var_1_10009(var_1_10010))
	local var_17_8 = arg_17_0.loader

	var_8.GetSpriteQuiet(var_17_8, "ui/LevelStageSSSSFeverPanel_atlas", arg_17_1, var_6, true)

	setActive = var_8

	var_8(arg_17_0.banner, true)

	setAnchoredPosition = var_8

	var_8(var_5, {
		x = 2436
	})

	setActive = var_8

	var_8(var_5, true)

	var_17_7.enabled = true

	local var_17_9

	if arg_17_4 ~= nil then
		setActive = var_8
		var_17_9 = var_5

		var_8(var_5.Find(var_17_9, "Word"), false)

		setActive = var_8
		var_17_9 = var_5

		var_8(var_5.Find(var_17_9, "Word2"), false)

		setActive = var_8
		var_17_9 = var_5

		var_8(var_5.Find(var_17_9, "Word" .. arg_17_4), true)
	end

	local var_17_10 = var_5
	local var_17_11 = var_5.GetComponent

	typeof = var_17_9
	DftAniEvent = var_11

	local var_17_12 = var_17_11(var_17_10, var_17_9(var_11))
	local var_17_13

	local function var_17_14()
		table = var_2_10000

		var_2_10000.removebyvalue(arg_17_0.cleanActions, var_17_14)

		local var_18_0 = var_17_12

		var_0.SetEndEvent(var_18_0, nil)

		var_17_7.enabled = false

		local var_18_1 = var_17_7

		var_18_1.sprite = nil
		pg = var_18_1

		local var_18_2 = var_18_1.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_18_2, arg_17_0.banner, arg_17_0._tf)

		setActive = var_0

		var_0(arg_17_0.banner, false)

		setActive = var_0

		var_0(var_0, false)

		local var_18_3 = arg_17_0
		local var_18_4 = var_0.emit

		LevelUIConst = var_2

		var_18_4(var_18_3, var_2.UN_FROZEN)

		return
	end

	local function var_17_15()
		var_17_14()

		existCall = var_0

		var_0(arg_17_3)

		return
	end

	var_17_12:SetEndEvent(var_17_15)

	onButton = var_11

	var_11(arg_17_0, arg_17_0.banner, var_17_15)

	table = var_11

	var_11.insert(arg_17_0.cleanActions, var_17_14)

	return
end

function var_0_1.CloseActions(arg_20_0)
	if arg_20_0.animations and not arg_20_0.animations.stopped then
		local var_20_0 = arg_20_0.animations

		var_1.Stop(var_20_0)
	end

	arg_20_0.animations = nil

	if arg_20_0.PanelAnimations and not arg_20_0.PanelAnimations.stopped then
		local var_20_1 = arg_20_0.PanelAnimations

		var_1.Stop(var_20_1)
	end

	arg_20_0.PanelAnimations = nil

	if arg_20_0.cleanActions then
		_ = var_1

		var_1.each(arg_20_0.cleanActions, function(arg_21_0)
			arg_21_0()

			return
		end)
	end

	arg_20_0.cleanActions = nil

	local var_20_2 = arg_20_0.loader

	var_1.ClearRequests(var_20_2)

	return
end

function var_0_1.OnHide(arg_22_0)
	arg_22_0:CloseActions()

	return
end

return var_0_1
