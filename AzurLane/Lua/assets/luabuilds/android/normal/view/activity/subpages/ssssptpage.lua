class = var_0_10000

local var_0_0 = "SSSSPtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))
local var_0_2 = {
	{
		11,
		1.5
	},
	{
		19,
		2
	},
	{
		25,
		3
	},
	{
		28,
		4
	}
}
local var_0_3 = 0.25
local var_0_4 = 20
local var_0_5 = 20
local var_0_6 = 0.75
local var_0_7 = 3
local var_0_8 = 0.75
local var_0_9 = 5
local var_0_10 = "he"

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.maskNode = var_1.Find(var_1_0, "mask")

	local var_1_1 = arg_1_0.maskNode

	arg_1_0.role = var_1.Find(var_1_1, "role")

	local var_1_2 = arg_1_0.maskNode

	arg_1_0.food = var_1.Find(var_1_2, "food")

	local var_1_3 = arg_1_0.maskNode

	arg_1_0.monster = var_1.Find(var_1_3, "monster")

	local var_1_4 = arg_1_0.maskNode

	arg_1_0.reflectNode = var_1.Find(var_1_4, "reflection")

	local var_1_5 = arg_1_0.reflectNode

	arg_1_0.monsterReflect = var_1.Find(var_1_5, "monster_reflection")

	local var_1_6 = arg_1_0.reflectNode

	arg_1_0.roleReflect = var_1.Find(var_1_6, "role_reflection")

	local var_1_7 = arg_1_0.bg

	arg_1_0.feedBtn = var_1.Find(var_1_7, "feed_btn")

	local var_1_8 = arg_1_0._tf

	arg_1_0.window = var_1.Find(var_1_8, "window")
	GetComponent = var_1

	local var_1_9 = arg_1_0.window
	local var_1_10 = var_2.Find(var_1_9, "panel/monster")

	typeof = var_1_9
	Animator = var_4
	arg_1_0.monsterAni = var_1(var_1_10, var_1_9(var_4))

	local var_1_11 = arg_1_0.window

	arg_1_0.spineRole = var_1.Find(var_1_11, "panel/spinechar")

	local var_1_12 = arg_1_0.window

	arg_1_0.spriteRole = var_1.Find(var_1_12, "panel/spritechar")
	arg_1_0.isPlaying = false
	arg_1_0.coutinuePlay = {}

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	setActive = var_1

	var_1(arg_2_0.window, false)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.monster

	local function var_2_2()
		if arg_2_0.monster.localScale.x == var_0_2[#var_0_2][2] then
			local var_3_0 = arg_2_0

			var_0.OpenMonsterWin(var_3_0)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.window
	local var_2_5 = var_3.Find(var_2_4, "close")

	local function var_2_6()
		setActive = var_2_10000

		var_2_10000(arg_2_0.window, false)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_3, var_2_5, var_2_6, var_5)

	onButton = var_1

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0.window
	local var_2_9 = var_3.Find(var_2_8, "close_btn")

	local function var_2_10()
		setActive = var_2_10000

		var_2_10000(arg_2_0.window, false)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_7, var_2_9, var_2_10, var_5)

	onButton = var_1

	local var_2_11 = arg_2_0
	local var_2_12 = arg_2_0.feedBtn

	local function var_2_13()
		local var_6_0 = {}
		local var_6_1 = arg_2_0.ptData
		local var_6_2 = var_1.GetAward(var_6_1)

		getProxy = var_6_1
		PlayerProxy = var_2_10003

		local var_6_3 = var_6_1(var_2_10003)
		local var_6_4 = var_2.getRawData(var_6_3)

		pg = var_6_3

		local var_6_5 = var_6_3.gameset.urpt_chapter_max.description[1]

		LOCK_UR_SHIP = var_2_10005

		if var_2_10005 then
			var_2_10005 = 0
		else
			getProxy = var_2_10005
			BagProxy = var_2_10006
			var_2_10006 = var_2_10005(var_2_10006)
			var_2_10005 = var_2_10005.GetLimitCntById(var_2_10006, var_6_5)
		end

		Task = var_2_10006

		local var_6_6, var_6_7 = var_2_10006.StaticJudgeOverflow(var_6_4.gold, var_6_4.oil, var_2_10005, true, true, {
			{
				var_6_2.type,
				var_6_2.id,
				var_6_2.count
			}
		})

		if var_6_6 then
			table = var_8

			var_8.insert(var_6_0, function(arg_7_0)
				pg = var_3_10001

				local var_7_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_7_1 = var_1.ShowMsgBox
				local var_7_2 = {}

				MSGBOX_TYPE_ITEM_BOX = var_3_10004
				var_7_2.type = var_3_10004
				i18n = var_3_10004
				var_7_2.content = var_3_10004("award_max_warning")
				var_7_2.items = var_6_7
				var_7_2.onYes = arg_7_0

				var_7_1(var_7_0, var_7_2)

				return
			end)
		end

		seriesAsync = var_8

		var_8(var_6_0, function()
			local function var_8_0()
				local var_9_0 = arg_2_0

				var_0.PlayFeedAni(var_9_0)

				return
			end

			local var_8_1 = arg_2_0.ptData
			local var_8_2, var_8_3 = var_1.GetResProgress(var_8_1)
			local var_8_4 = arg_2_0
			local var_8_5 = var_3.emit

			ActivityMediator = var_3_10005

			local var_8_6 = var_3_10005.EVENT_PT_OPERATION
			local var_8_7 = {
				cmd = 1
			}
			local var_8_8 = arg_2_0.ptData

			var_8_7.activity_id = var_7.GetId(var_8_8)
			var_8_7.arg1 = var_8_3
			var_8_7.callback = var_8_0

			var_8_5(var_8_4, var_8_6, var_8_7)

			return
		end)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_11, var_2_12, var_2_13, var_5)

	setActive = var_1

	local var_2_14 = arg_2_0.bg

	var_1(var_2.Find(var_2_14, "blink_effect"), true)
	arg_2_0:UpdateMonster()

	return
end

function var_0_1.OnUpdateFlush(arg_10_0)
	var_0_1.super.OnUpdateFlush(arg_10_0)

	local var_10_0 = arg_10_0.ptData
	local var_10_1, var_10_2, var_10_3 = var_1.GetLevelProgress(var_10_0)
	local var_10_4 = arg_10_0.ptData
	local var_10_5, var_10_6, var_10_7 = var_4.GetResProgress(var_10_4)

	setText = var_1_10007

	local var_10_8 = arg_10_0.step

	setColorStr = var_1_10009

	var_1_10007(var_10_8, var_1_10009(var_10_1, "#f0dbff") .. "/" .. var_10_2)

	setText = var_1_10007

	local var_10_9 = arg_10_0.progress

	if 1 <= var_10_7 then
		setColorStr = var_9

		local var_10_10

		if not var_9(var_10_5, "#f0dbff") then
			var_10_10 = var_10_5
		end

		var_1_10007(var_10_9, var_10_10 .. "/" .. var_10_6)

		isActive = var_1_10007

		if var_1_10007(arg_10_0.getBtn) and arg_10_0:IsSpecialPhase() then
			setActive = var_7

			var_7(arg_10_0.getBtn, false)

			setActive = var_7

			var_7(arg_10_0.feedBtn, true)
		else
			setActive = var_7

			var_7(arg_10_0.feedBtn, false)
		end

		return
	end
end

function var_0_1.IsSpecialPhase(arg_11_0)
	local var_11_0 = arg_11_0.ptData
	local var_11_1 = var_1.GetLevelProgress(var_11_0)
	local var_11_2 = false

	ipairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(var_0_2) do
		if var_11_1 == iter_11_1[1] then
			var_11_2 = true
		end
	end

	return var_11_2
end

function var_0_1.GetMonsterScale(arg_12_0, arg_12_1)
	local var_12_0 = 1

	ipairs = var_1_10003

	for iter_12_0, iter_12_1 in var_1_10003(var_0_2) do
		if arg_12_1 > iter_12_1[1] then
			var_12_0 = iter_12_1[2]
		end
	end

	return var_12_0
end

function var_0_1.UpdateMonster(arg_13_0)
	local var_13_0 = arg_13_0.ptData
	local var_13_1 = var_1.GetLevelProgress(var_13_0)
	local var_13_2 = arg_13_0
	local var_13_3 = arg_13_0.GetMonsterScale(var_13_2, var_13_1)

	setLocalScale = var_13_2

	local var_13_4 = arg_13_0.monster

	Vector2 = var_1_10005

	var_13_2(var_13_4, var_1_10005(var_13_3, var_13_3))

	setLocalScale = var_13_2

	local var_13_5 = arg_13_0.monsterReflect

	Vector2 = var_5

	var_13_2(var_13_5, var_5(var_13_3, var_13_3))

	return
end

function var_0_1.PlayFeedAni(arg_14_0)
	if arg_14_0.isPlaying then
		local var_14_0 = arg_14_0.ptData
		local var_14_1 = var_1.GetLevelProgress(var_14_0) - 1

		table = var_14_0

		var_14_0.insert(arg_14_0.coutinuePlay, var_14_1)

		return
	end

	arg_14_0.isPlaying = true

	local var_14_2 = arg_14_0
	local var_14_3 = arg_14_0.managedTween

	LeanTween = var_1_10003

	local var_14_4 = var_14_3(var_14_2, var_1_10003.moveX, function()
		local var_15_0 = arg_14_0

		var_0.PlayThrowFoodAni(var_15_0, function()
			local var_16_0 = arg_14_0

			var_0.PlayMonsterAni(var_16_0)

			return
		end)

		return
	end, arg_14_0.role, arg_14_0.role.localPosition.x + var_0_4, var_0_3)

	var_1.setLoopPingPong(var_14_4, 1)

	return
end

function var_0_1.PlayThrowFoodAni(arg_17_0, arg_17_1)
	Vector2 = var_1_10002

	local var_17_0 = var_1_10002(280, -70)

	Vector2 = var_3

	local var_17_1 = var_3(500, -70)
	local var_17_2 = 1
	local var_17_3 = (var_17_1.x - var_17_0.x) / var_0_7
	local var_17_4 = (var_17_1.y - var_17_0.y) / var_0_7

	setLocalPosition = var_7

	var_7(arg_17_0.food, var_17_0)

	setActive = var_7

	var_7(arg_17_0.food, true)

	Timer = var_7
	arg_17_0.foodTimer = var_7.New(function()
		Vector2 = var_2_10000

		local var_18_0 = var_2_10000(var_17_0.x + var_17_3 * var_17_2, var_17_0.y + var_17_4 * var_17_2)

		setLocalPosition = var_1

		var_1(arg_17_0.food, var_18_0)

		if var_17_2 == var_0_7 then
			local var_18_1 = arg_17_0.foodTimer

			var_1.Stop(var_18_1)

			setActive = var_1

			var_1(arg_17_0.food, false)

			if arg_17_1 then
				arg_17_1()
			end
		else
			var_17_2 = var_17_2 + 1
		end

		return
	end, var_0_6 / var_0_7, var_0_7)

	local var_17_5 = arg_17_0.foodTimer

	var_7.Start(var_17_5)

	return
end

function var_0_1.PlayMonsterAni(arg_19_0)
	local var_19_0 = arg_19_0.monster.localScale.x
	local var_19_2

	if not arg_19_0.coutinuePlay[1] or not arg_19_0.coutinuePlay[1] then
		local var_19_1 = arg_19_0.ptData

		var_19_2 = var_2.GetLevelProgress(var_19_1)
	end

	local var_19_3 = arg_19_0:GetMonsterScale(var_19_2)
	local var_19_4 = 1
	local var_19_5 = (var_19_3 - var_19_0) / var_0_9

	setLocalScale = var_6

	local var_19_6 = arg_19_0.monster

	Vector2 = var_1_10008

	var_6(var_19_6, var_1_10008(var_19_0, var_19_0))

	setLocalScale = var_6

	local var_19_7 = arg_19_0.monsterReflect

	Vector2 = var_8

	var_6(var_19_7, var_8(var_19_0, var_19_0))

	Timer = var_6
	arg_19_0.monsterTimer = var_6.New(function()
		Vector2 = var_2_10000

		local var_20_0 = var_2_10000(var_19_0 + var_19_5 * var_19_4, var_19_0 + var_19_5 * var_19_4)

		setLocalScale = var_1

		var_1(arg_19_0.monster, var_20_0)

		setLocalScale = var_1

		var_1(arg_19_0.monsterReflect, var_20_0)

		if var_19_4 == var_0_9 then
			local var_20_1 = arg_19_0.monsterTimer

			var_1.Stop(var_20_1)

			arg_19_0.monsterTimer = nil
			arg_19_0.isPlaying = false

			if #arg_19_0.coutinuePlay > 0 then
				table = var_1

				var_1.remove(arg_19_0.coutinuePlay, 1)

				local var_20_2 = arg_19_0

				var_1.PlayFeedAni(var_20_2)
			end
		else
			var_19_4 = var_19_4 + 1
		end

		return
	end, var_0_8 / var_0_9, var_0_9)

	local var_19_8 = arg_19_0
	local var_19_9 = arg_19_0.managedTween

	LeanTween = var_8

	local var_19_10 = var_19_9(var_19_8, var_8.moveX, function()
		local var_21_0 = arg_19_0
		local var_21_1 = var_0.managedTween

		LeanTween = var_2_10002

		local var_21_2 = var_21_1(var_21_0, var_2_10002.moveY, function()
			local var_22_0 = arg_19_0.monsterTimer

			var_0.Start(var_22_0)

			return
		end, arg_19_0.monster, arg_19_0.monster.localPosition.y + var_0_5, var_0_3)

		var_0.setLoopPingPong(var_21_2, 2)

		return
	end, arg_19_0.monster, arg_19_0.monster.localPosition.x + var_0_4, var_0_3)

	var_6.setLoopPingPong(var_19_10, 2)

	return
end

function var_0_1.OpenMonsterWin(arg_23_0)
	setActive = var_1_10001

	var_1_10001(arg_23_0.window, true)

	local var_23_0 = arg_23_0.monsterAni

	var_1.Play(var_23_0, "ATK")

	setLocalPosition = var_1

	local var_23_1 = arg_23_0.spriteRole

	Vector2 = var_3

	var_1(var_23_1, var_3(-180, -115))

	LeanTween = var_1

	local var_23_2 = var_1.isTweening

	go = var_23_1

	if var_23_2(var_23_1(arg_23_0.spriteRole)) then
		LeanTween = var_1

		local var_23_3 = var_1.cancel

		go = var_2

		var_23_3(var_2(arg_23_0.spriteRole))
	end

	local var_23_4 = arg_23_0
	local var_23_5 = arg_23_0.managedTween

	LeanTween = var_3

	local var_23_6 = var_23_5(var_23_4, var_3.moveX, nil, arg_23_0.spriteRole, arg_23_0.spriteRole.localPosition.x + 20, 0.8)

	var_1.setLoopPingPong(var_23_6)

	return
end

function var_0_1.OnHideFlush(arg_24_0)
	setActive = var_1_10001

	var_1_10001(arg_24_0.window, false)

	return
end

function var_0_1.OnDestroy(arg_25_0)
	arg_25_0:cleanManagedTween()

	if arg_25_0.foodTimer then
		local var_25_0 = arg_25_0.foodTimer

		var_1.Stop(var_25_0)

		arg_25_0.foodTimer = nil
	end

	if arg_25_0.monsterTimer then
		local var_25_1 = arg_25_0.monsterTimer

		var_1.Stop(var_25_1)

		arg_25_0.monsterTimer = nil
	end

	if arg_25_0.model then
		PoolMgr = var_1

		local var_25_2 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_25_2, var_0_10, arg_25_0.model)

		arg_25_0.model = nil
	end

	return
end

return var_0_1
