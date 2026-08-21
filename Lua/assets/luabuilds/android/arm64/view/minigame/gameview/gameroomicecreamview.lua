local var_0_0 = class("GameRoomIceCreamView", import("..BaseMiniGameView"))
local var_0_1 = "EVENT_ICE_FINISH"
local var_0_2 = "EVENT_UPDATE_WAIT_TIME"
local var_0_3 = 0.05
local var_0_4 = 2
local var_0_5 = {
	{
		6,
		10
	},
	{
		8,
		12
	},
	{
		10,
		14
	}
}
local var_0_6 = 60
local var_0_7 = {
	750,
	250,
	300
}
local var_0_8 = {
	200,
	100
}
local var_0_9 = {
	100,
	50,
	20
}
local var_0_10 = 20
local var_0_11 = {
	point_boost = 100,
	wait_time_boost = 2,
	bullet_time = {
		0.1,
		4,
		0.8,
		5
	}
}
local var_0_12 = {
	{
		1
	},
	{
		0,
		1
	},
	{
		1,
		0,
		2
	}
}
local var_0_13 = {
	{
		1
	},
	{
		2
	},
	{
		1,
		3
	}
}
local var_0_14 = {
	"A",
	"B",
	"C",
	"D"
}
local var_0_15 = {
	"H",
	"J",
	"K",
	"I"
}
local var_0_16

local function var_0_17(arg_1_0)
	if var_0_16 then
		var_0_16:Pause(not arg_1_0)
	elseif arg_1_0 then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_topping", function(arg_2_0)
			assert(arg_2_0)

			var_0_16 = arg_2_0.playback

			return
		end)
	end

	return
end

function var_0_0.getUIName(arg_3_0)
	return "GameRoomIceCreamUI"
end

function var_0_0.initTimer(arg_4_0)
	arg_4_0.timer = Timer.New(function()
		arg_4_0:onTimer()

		return
	end, var_0_3, -1)

	return
end

function var_0_0.didEnter(arg_6_0)
	arg_6_0:initTimer()
	arg_6_0:initUI()
	arg_6_0:initGameUI()
	arg_6_0:openMainUI()

	return
end

function var_0_0.initUI(arg_7_0)
	arg_7_0.clickMask = arg_7_0._tf:Find("ui/click_mask")
	arg_7_0.rtResource = arg_7_0._tf:Find("Resource")
	arg_7_0.mainUI = arg_7_0._tf:Find("ui/main_ui")
	arg_7_0.listScrollRect = GetComponent(arg_7_0.mainUI:Find("right_panel/item_list/content"), typeof(ScrollRect))

	onButton(arg_7_0, arg_7_0.mainUI:Find("btn_back"), function()
		arg_7_0:emit(var_0_0.ON_BACK_PRESSED)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.mainUI:Find("bg/btn_help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = arg_7_0:getGameRoomData().game_help
		})

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.mainUI:Find("bg/btn_start"), function()
		arg_7_0:readyStart()

		return
	end, SFX_PANEL)

	arg_7_0.totalTimes = arg_7_0:getGameTotalTime()

	scrollTo(arg_7_0.listScrollRect, 0, 1 - (arg_7_0:getGameUsedTimes() - 4 < 0 and 0 or arg_7_0:getGameUsedTimes() - 4) / (arg_7_0.totalTimes - 4))
	onButton(arg_7_0, arg_7_0.mainUI:Find("right_panel/arrows_up"), function()
		local var_11_0 = arg_7_0.listScrollRect.normalizedPosition.y + 1 / (arg_7_0.totalTimes - 4)

		if arg_7_0.listScrollRect.normalizedPosition.y + 1 / (arg_7_0.totalTimes - 4) > 1 then
			var_11_0 = 1
		end

		scrollTo(arg_7_0.listScrollRect, 0, var_11_0)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.mainUI:Find("right_panel/arrows_down"), function()
		local var_12_0 = arg_7_0.listScrollRect.normalizedPosition.y - 1 / (arg_7_0.totalTimes - 4)

		if arg_7_0.listScrollRect.normalizedPosition.y - 1 / (arg_7_0.totalTimes - 4) < 0 then
			var_12_0 = 0
		end

		scrollTo(arg_7_0.listScrollRect, 0, var_12_0)

		return
	end, SFX_PANEL)

	local var_7_0 = pg.mini_game[arg_7_0:GetMGData().id].simple_config_data.drop_ids
	local var_7_1 = arg_7_0.mainUI:Find("right_panel/item_list/content")

	arg_7_0.itemList = UIItemList.New(var_7_1, var_7_1:GetChild(0))

	arg_7_0.itemList:make(function(arg_13_0, arg_13_1, arg_13_2)
		arg_13_1 = arg_13_1 + 1

		if arg_13_0 == UIItemList.EventUpdate then
			arg_13_2.name = arg_13_1

			GetImageSpriteFromAtlasAsync("ui/minigameui/icecreamgameui_atlas", "day_" .. arg_13_1, arg_13_2:Find("text"))

			local var_13_0 = arg_13_2:Find("IconTpl")
			local var_13_1 = {}

			var_13_1.type, var_13_1.id, var_13_1.count = unpack(var_7_0[arg_13_1])

			updateDrop(var_13_0, {})
			onButton(arg_7_0, var_13_0, function()
				arg_7_0:emit(var_0_0.ON_DROP, var_13_1)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_7_0.itemList:align(#pg.mini_game[arg_7_0:GetMGData().id].simple_config_data.drop_ids)

	arg_7_0.countUI = arg_7_0._tf:Find("ui/count_ui")
	arg_7_0.countAnimator = GetComponent(arg_7_0.countUI:Find("count"), typeof(Animator))
	arg_7_0.countDft = GetOrAddComponent(arg_7_0.countUI:Find("count"), typeof(DftAniEvent))

	arg_7_0.countDft:SetTriggerEvent(function()
		return
	end)
	arg_7_0.countDft:SetEndEvent(function()
		setActive(arg_7_0.countUI, false)
		arg_7_0:startGame()

		return
	end)

	arg_7_0.pauseUI = arg_7_0._tf:Find("ui/pause_ui")

	onButton(arg_7_0, arg_7_0.pauseUI:Find("panel/btn_confirm"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0.pauseUI, arg_7_0._tf:Find("ui"))
		setActive(arg_7_0.pauseUI, false)
		arg_7_0:resumeGame()

		return
	end, SFX_PANEL)

	arg_7_0.returnUI = arg_7_0._tf:Find("ui/return_ui")

	onButton(arg_7_0, arg_7_0.returnUI:Find("panel/btn_confirm"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0.returnUI, arg_7_0._tf:Find("ui"))
		setActive(arg_7_0.returnUI, false)
		arg_7_0:resumeGame()
		arg_7_0:endGame()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.returnUI:Find("panel/btn_cancel"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0.returnUI, arg_7_0._tf:Find("ui"))
		setActive(arg_7_0.returnUI, false)
		arg_7_0:resumeGame()

		return
	end, SFX_PANEL)

	arg_7_0.endUI = arg_7_0._tf:Find("ui/end_ui")

	onButton(arg_7_0, arg_7_0.endUI:Find("panel/btn_finish"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0.endUI, arg_7_0._tf:Find("ui"))
		setActive(arg_7_0.endUI, false)
		arg_7_0:openMainUI()

		return
	end, SFX_PANEL)

	arg_7_0.handle = arg_7_0.handle or UpdateBeat:CreateListener(arg_7_0.Update, arg_7_0)

	UpdateBeat:AddListener(arg_7_0.handle)

	return
end

function var_0_0.Update(arg_21_0)
	return
end

function var_0_0.initGameUI(arg_22_0)
	arg_22_0.gameUI = arg_22_0._tf:Find("ui/game_ui")
	arg_22_0.timeTF = arg_22_0.gameUI:Find("Score/time/Text")
	arg_22_0.scoreTF = arg_22_0.gameUI:Find("Score/point/Text")
	arg_22_0.addScoreTF = arg_22_0.gameUI:Find("Score/add_score")

	onButton(arg_22_0, arg_22_0.gameUI:Find("Button/btn_pause"), function()
		arg_22_0:pauseGame()
		pg.UIMgr.GetInstance():OverlayPanel(arg_22_0.pauseUI)
		setActive(arg_22_0.pauseUI, true)

		return
	end)
	onButton(arg_22_0, arg_22_0.gameUI:Find("Button/btn_back"), function()
		arg_22_0:pauseGame()
		pg.UIMgr.GetInstance():OverlayPanel(arg_22_0.returnUI)
		setActive(arg_22_0.returnUI, true)

		return
	end)

	arg_22_0.rtWalk = arg_22_0.gameUI:Find("Walk")
	arg_22_0.rtMake = arg_22_0.gameUI:Find("Make")
	arg_22_0.rtTime = arg_22_0.gameUI:Find("Time")
	arg_22_0.rtButton = arg_22_0.gameUI:Find("Button")

	for iter_22_0 = 1, 4 do
		onButton(arg_22_0, arg_22_0.rtButton:Find("L" .. iter_22_0), function()
			if not arg_22_0.iceBuild or arg_22_0.iceBuild.isLeftLock then
				return
			end

			if #arg_22_0.iceBuild._info[1] == #arg_22_0.targetList[arg_22_0.targetIndex]._info[1] then
				return
			end

			arg_22_0.iceBuild:MakeBall(iter_22_0)

			return
		end)
		onButton(arg_22_0, arg_22_0.rtButton:Find("R" .. iter_22_0), function()
			if not arg_22_0.iceBuild or arg_22_0.iceBuild.isRightLock then
				return
			end

			local var_26_0 = arg_22_0.targetList[arg_22_0.targetIndex]._info

			if #arg_22_0.iceBuild._info[2] == #arg_22_0.targetList[arg_22_0.targetIndex]._info[2] then
				return
			end

			if not arg_22_0.iceBuild._info[1][var_0_13[#var_26_0[1]][#arg_22_0.iceBuild._info[2] + 1]] then
				arg_22_0.iceBuild:MakeMissTopping(iter_22_0)
			else
				arg_22_0.iceBuild:MakeTopping(iter_22_0)
			end

			return
		end)
	end

	arg_22_0:bind(var_0_1, function(arg_27_0, ...)
		arg_22_0:ResultTarget(...)

		return
	end)
	arg_22_0:bind(var_0_2, function(arg_28_0, arg_28_1, ...)
		eachChild(arg_22_0.rtTime, function(arg_29_0)
			setActive(arg_29_0, arg_29_0.name == arg_28_1)

			return
		end)
		setSlider(arg_22_0.rtTime:Find(arg_28_1), ...)

		return
	end)

	return
end

function var_0_0.updateMainUI(arg_30_0)
	local var_30_0 = arg_30_0:getGameUsedTimes()
	local var_30_1 = arg_30_0:getGameTimes()

	for iter_30_0 = 1, arg_30_0.itemList.container.childCount do
		local var_30_3 = {
			award = true
		}

		if iter_30_0 <= var_30_0 then
			var_30_3.finish = true
		elseif iter_30_0 == var_30_0 + 1 and var_30_1 >= 1 then
			-- block empty
		elseif var_30_0 < iter_30_0 and iter_30_0 <= var_30_0 + var_30_1 then
			-- block empty
		else
			var_30_3.lock = true
			var_30_3.award = false
		end

		local var_30_4 = var_30_2:GetChild(iter_30_0 - 1)

		setActive(var_30_4:Find("finish"), var_30_3.finish)
		setActive(var_30_4:Find("lock"), var_30_3.lock)
		setActive(var_30_4:Find("IconTpl"), var_30_3.award)
	end

	arg_30_0.totalTimes = arg_30_0:getGameTotalTime()

	local var_30_5 = 1 - (arg_30_0:getGameUsedTimes() - 3 < 0 and 0 or arg_30_0:getGameUsedTimes() - 3) / (arg_30_0.totalTimes - 4)

	if var_30_5 > 1 then
		var_30_5 = 1
	end

	scrollTo(arg_30_0.listScrollRect, 0, var_30_5)
	arg_30_0:checkGet()

	return
end

function var_0_0.checkGet(arg_31_0)
	if arg_31_0:getUltimate() == 0 then
		if arg_31_0:getGameTotalTime() > arg_31_0:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_31_0:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

function var_0_0.openMainUI(arg_32_0)
	setActive(arg_32_0.gameUI, false)
	setActive(arg_32_0.mainUI, true)
	arg_32_0:openCoinLayer(true)
	arg_32_0:updateMainUI()

	return
end

function var_0_0.readyStart(arg_33_0)
	setActive(arg_33_0.mainUI, false)
	setActive(arg_33_0.countUI, true)
	arg_33_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/ddldaoshu2")
	arg_33_0:resetGame()
	arg_33_0:openCoinLayer(false)

	return
end

function var_0_0.resetGame(arg_34_0)
	arg_34_0.gameStartFlag = false
	arg_34_0.gamePause = false
	arg_34_0.gameEndFlag = false
	arg_34_0.scoreNum = 0
	arg_34_0.lastTime = var_0_6
	arg_34_0.targetNameList = {}
	arg_34_0.targetList = {}
	arg_34_0.iceBuild = nil
	arg_34_0.countList = {
		0,
		0,
		0
	}
	arg_34_0.effectTrigger = {
		bullet_time = {
			doingTime = 0,
			waitTime = 0
		},
		wait_time_boost = {
			count = 0
		},
		point_boost = {}
	}

	eachChild(arg_34_0.rtResource:Find("Character"), function(arg_35_0)
		table.insert(arg_34_0.targetNameList, arg_35_0.name)

		return
	end)
	removeAllChildren(arg_34_0.rtWalk)
	setActive(arg_34_0.gameUI:Find("BulletTimeMask"), false)
	setActive(arg_34_0.rtMake, false)
	setActive(arg_34_0.rtTime, false)
	setText(arg_34_0.scoreTF, arg_34_0.scoreNum)
	setActive(arg_34_0.addScoreTF, false)
	arg_34_0:setAnimatorSpeed(arg_34_0._tf, 1)

	return
end

local function var_0_18(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local function var_36_0(arg_37_0, arg_37_1)
		for iter_37_0 = math.max(#arg_37_1[1], 2), 1, -1 do
			setActive(arg_37_0:Find(iter_37_0), arg_37_1[1][iter_37_0])

			if arg_37_1[1][iter_37_0] then
				local var_37_0 = arg_37_0:Find(iter_37_0)

				GetImageSpriteFromAtlasAsync("ui/minigameui/icecreamgameui_atlas", var_0_14[arg_37_1[1][iter_37_0]], var_37_0:Find("Scoop"), true)
				setActive(var_37_0:Find("Topping"), arg_37_1[2][var_0_12[#arg_37_1[1]][iter_37_0]])

				if arg_37_1[2][var_0_12[#arg_37_1[1]][iter_37_0]] then
					GetImageSpriteFromAtlasAsync("ui/minigameui/icecreamgameui_atlas", var_0_15[arg_37_1[2][var_0_12[#arg_37_1[1]][iter_37_0]]], var_37_0:Find("Topping"), true)
				end
			end
		end

		return
	end

	;({}).Ctor = function(arg_38_0)
		arg_38_0._tf = arg_36_0
		arg_38_0._event = arg_36_1
		arg_38_0._info = arg_36_2
		arg_38_0.time = arg_36_3
		arg_38_0.pointBoost = 100
		arg_38_0.result = nil

		local var_38_0 = #arg_36_2[1] < 3 and "Cone" or "Bowl"

		for iter_38_0, iter_38_1 in ipairs({
			"IceCream",
			"Bubble",
			"BadCream"
		}) do
			eachChild(arg_36_0:Find(iter_38_1), function(arg_39_0)
				setActive(arg_39_0, arg_39_0.name == var_38_0)

				return
			end)
		end

		var_36_0(arg_36_0:Find("Bubble/" .. var_38_0), arg_36_2)
		GetImageSpriteFromAtlasAsync("ui/minigameui/icecreamgameui_atlas", "bubble_" .. #arg_36_2[1], arg_36_0:Find("Bubble"), true)
		setActive(arg_36_0:Find("Bubble/Boost"), false)

		arg_38_0.animator = GetComponent(arg_38_0._tf, typeof(Animator))

		arg_38_0._tf:GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function()
			arg_38_0.isLeave = true

			return
		end)

		return
	end
	;({}).Result = function(arg_41_0, arg_41_1, arg_41_2)
		arg_41_0.result = arg_41_1

		local var_41_0 = #arg_41_2[1] < 3 and "Cone" or "Bowl"

		if arg_41_1 == 0 then
			arg_41_0.animator:Play("Bad")
		elseif arg_41_1 == 1 then
			var_36_0(arg_41_0._tf:Find("IceCream/" .. var_41_0), arg_41_2)
			arg_41_0.animator:Play("Hmm")
		elseif arg_41_1 >= 2 then
			var_36_0(arg_41_0._tf:Find("IceCream/" .. var_41_0), arg_41_2)
			arg_41_0.animator:Play("Great")
		else
			assert(false)
		end

		return
	end

	;({}):Ctor()

	return {}
end

function var_0_0.CreateTarget(arg_42_0, arg_42_1)
	local var_42_0 = table.remove(arg_42_0.targetNameList, math.random(#arg_42_0.targetNameList))
	local var_42_1 = cloneTplTo(arg_42_0.rtResource:Find("Character/" .. var_42_0), arg_42_0.rtWalk, var_42_0)

	setAnchoredPosition(var_42_1, {
		x = arg_42_1 or -var_0_7[1]
	})

	local var_42_2 = {
		{},
		{}
	}

	if var_42_0 == "Agir" then
		local var_42_3 = {
			1,
			2
		}

		if not {
			1,
			2
		} then
			var_42_3 = {
				1,
				2,
				3
			}
		end

		if #arg_42_0.targetList > 0 then
			table.removebyvalue(var_42_3, #arg_42_0.targetList[#arg_42_0.targetList]._info[1])
		end

		for iter_42_0 = var_42_3[math.random(#var_42_3)], 1, -1 do
			table.insert(var_42_2[1], math.random(4))
		end

		for iter_42_1 = math.max(1, #var_42_2[1] - 1), 1, -1 do
			table.insert(var_42_2[2], table.remove({
				1,
				2,
				3,
				4
			}, math.random(#{
				1,
				2,
				3,
				4
			})))
		end

		arg_42_0.countList[#var_42_2[1]] = arg_42_0.countList[#var_42_2[1]] + 1

		table.insert(arg_42_0.targetList, var_0_18(var_42_1, arg_42_0, var_42_2, (math.clamp(var_0_5[#var_42_2[1]][2] - arg_42_0.countList[#var_42_2[1]], unpack(var_0_5[#var_42_2[1]])))))

		return
	end
end

function var_0_0.RemoveTarget(arg_43_0)
	assert(#arg_43_0.targetList > 0)

	local var_43_0 = table.remove(arg_43_0.targetList, 1)

	arg_43_0.targetIndex = arg_43_0.targetIndex - 1

	table.insert(arg_43_0.targetNameList, var_43_0._tf.name)
	Destroy(var_43_0._tf)

	return
end

function var_0_0.ResultTarget(arg_44_0, arg_44_1, arg_44_2, ...)
	assert(#arg_44_0.targetList > 0)

	arg_44_1 = math.ceil(arg_44_1 * arg_44_0.targetList[arg_44_0.targetIndex].pointBoost / 100)

	arg_44_0:addScore(arg_44_1, arg_44_2)
	arg_44_0.targetList[arg_44_0.targetIndex]:Result(arg_44_2, ...)
	arg_44_0:TriggerSpecialEffect(arg_44_2, ...)

	arg_44_0.targetIndex = arg_44_0.targetIndex + 1
	arg_44_0.iceBuild = nil

	onNextTick(function()
		setActive(arg_44_0.rtMake, false)
		setActive(arg_44_0.rtTime, false)

		return
	end)

	if arg_44_0.effectTrigger.bullet_time.doingTime > 0 then
		arg_44_0.effectTrigger.bullet_time.doingTime = 0

		arg_44_0:setAnimatorSpeed(arg_44_0._tf, 1)
		setActive(arg_44_0.gameUI:Find("BulletTimeMask"), false)
	end

	return
end

function var_0_0.TriggerSpecialEffect(arg_46_0, arg_46_1, arg_46_2)
	if arg_46_1 == 3 then
		if #arg_46_0.targetList[arg_46_0.targetIndex]._info[1] == 3 and arg_46_0.effectTrigger.bullet_time.waitTime <= 0 and math.random() < var_0_11.bullet_time[3] then
			arg_46_0.targetList[arg_46_0.targetIndex + 1].timeBoost = true
		end

		local var_46_0 = arg_46_0.effectTrigger.wait_time_boost

		var_46_0.count = arg_46_0.effectTrigger.wait_time_boost.count + 1

		if var_46_0.count == 2 then
			var_46_0.count = 0
			arg_46_0.targetList[arg_46_0.targetIndex + 1].time = arg_46_0.targetList[arg_46_0.targetIndex + 1].time + var_0_11.wait_time_boost
			arg_46_0.targetList[arg_46_0.targetIndex + 1].isWaitTimeBoost = true
		end

		local var_46_1 = arg_46_0.effectTrigger.point_boost

		if arg_46_0.effectTrigger.point_boost[arg_46_0.targetList[arg_46_0.targetIndex]._tf.name] == "finish" then
			-- block empty
		elseif var_46_1[arg_46_0.targetList[arg_46_0.targetIndex]._tf.name] == "count" then
			arg_46_0.targetList[arg_46_0.targetIndex + 1].pointBoost = arg_46_0.targetList[arg_46_0.targetIndex + 1].pointBoost + var_0_11.point_boost

			setActive(arg_46_0.targetList[arg_46_0.targetIndex + 1]._tf:Find("Bubble/Boost"), true)

			var_46_1[arg_46_0.targetList[arg_46_0.targetIndex]._tf.name] = "finish"
		else
			var_46_1[arg_46_0.targetList[arg_46_0.targetIndex]._tf.name] = "count"
		end
	else
		local var_46_2 = arg_46_0.effectTrigger.point_boost

		if arg_46_0.effectTrigger.point_boost[arg_46_0.targetList[arg_46_0.targetIndex]._tf.name] == "finish" then
			-- block empty
		else
			var_46_2[arg_46_0.targetList[arg_46_0.targetIndex]._tf.name] = nil
		end
	end

	return
end

local function var_0_19(arg_47_0, arg_47_1, arg_47_2, arg_47_3, arg_47_4)
	({
		Ctor = function(arg_48_0)
			arg_48_0._tf = arg_47_0
			arg_48_0._event = arg_47_1
			arg_48_0._info = {
				{},
				{}
			}
			arg_48_0.isLeftLock = false
			arg_48_0.isRightLock = false
			arg_48_0.missToppingMark = {}
			arg_48_0.waitTime = arg_47_3
			arg_48_0.isWaitTimeBoost = arg_47_4

			arg_48_0:Reset()
			arg_48_0:NextDeal()

			return
		end,
		NextDeal = function(arg_49_0)
			if arg_49_0.isLeftLock or arg_49_0.isRightLock then
				return
			end

			if #arg_49_0._info[1] < #arg_47_2[1] then
				arg_49_0:ReadyBall()
			elseif #arg_49_0._info[2] < #arg_47_2[2] then
				arg_49_0:ReadyTopping()
			else
				arg_49_0:Result()
			end

			return
		end,
		Result = function(arg_50_0, arg_50_1)
			arg_50_0.isResulted = true

			var_0_17(false)

			local var_50_0 = 0

			for iter_50_0, iter_50_1 in ipairs(arg_50_0._info) do
				for iter_50_2, iter_50_3 in ipairs(iter_50_1) do
					if (function(arg_51_0, arg_51_1, arg_51_2)
						arg_51_0[arg_51_1] = arg_51_0[arg_51_1] + arg_51_2

						return math.abs(arg_51_0[arg_51_1]) - math.abs(arg_51_0[arg_51_1])
					end)(({
						{
							0,
							0,
							0,
							0
						},
						{
							0,
							0,
							0,
							0
						}
					})[iter_50_0], arg_47_2[iter_50_0][iter_50_2], -1) < 0 then
						var_50_0 = var_50_0 + var_0_9[iter_50_0]
					end

					if (function(arg_51_0, arg_51_1, arg_51_2)
						arg_51_0[arg_51_1] = arg_51_0[arg_51_1] + arg_51_2

						return math.abs(arg_51_0[arg_51_1]) - math.abs(arg_51_0[arg_51_1])
					end)(({
						{
							0,
							0,
							0,
							0
						},
						{
							0,
							0,
							0,
							0
						}
					})[iter_50_0], iter_50_3, 1) < 0 then
						var_50_0 = var_50_0 + var_0_9[iter_50_0]
					end

					if arg_47_2[iter_50_0][iter_50_2] == iter_50_3 and (iter_50_0 == 1 or not arg_50_0.missToppingMark[iter_50_2]) then
						var_50_0 = var_50_0 + var_0_9[3]
					end
				end
			end

			if arg_50_1 then
				arg_50_0.result = arg_50_1
			else
				local var_50_1 = #arg_50_0._info[1] * var_0_9[1] + #arg_50_0._info[2] * var_0_9[2] + (#arg_50_0._info[1] + #arg_50_0._info[2]) * var_0_9[3]

				arg_50_0.result = var_50_0 == #arg_50_0._info[1] * var_0_9[1] + #arg_50_0._info[2] * var_0_9[2] + (#arg_50_0._info[1] + #arg_50_0._info[2]) * var_0_9[3] and 3 or table.equal(arg_50_0._info, arg_47_2) and 2 or var_50_0 >= var_50_1 / 2 and 1 or 0
			end

			local var_50_2 = arg_50_0._tf:GetComponent(typeof(Animator))

			if arg_50_0.result == 3 then
				arg_50_0.point = var_50_0 * (1 + var_0_10 / 100 + arg_50_0.waitTime / arg_47_3)

				var_50_2:Play("Perfect")
				pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_great")
			elseif arg_50_0.result == 2 then
				arg_50_0.point = var_50_0 * (1 + arg_50_0.waitTime / arg_47_3)

				var_50_2:Play("Pass")
			elseif arg_50_0.result == 1 then
				arg_50_0.point = var_50_0 * (1 + arg_50_0.waitTime / arg_47_3)

				var_50_2:Play("Pass")
			elseif arg_50_0.result == 0 then
				arg_50_0.point = 0

				var_50_2:Play("Fail")
				pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_fail")
			else
				assert(false)
			end

			return
		end,
		CountDown = function(arg_52_0, arg_52_1, arg_52_2)
			if arg_52_0.isResulted then
				return
			end

			if arg_52_0.waitTime > 0 then
				arg_52_0.waitTime = arg_52_0.waitTime - arg_52_1

				arg_52_0._event:emit(var_0_2, arg_52_2, 0, arg_47_3, arg_52_0.waitTime)
			else
				arg_52_0.waitTime = 0

				arg_52_0:Result(0)
			end

			if not arg_52_0.missTime then
				return
			end

			if arg_52_0.missTime > 0 then
				arg_52_0.missTime = arg_52_0.missTime - var_0_3
			else
				arg_52_0.missTime = nil

				arg_52_0:FailMissTopping()
			end

			return
		end,
		Reset = function(arg_53_0)
			arg_53_0._tf:GetComponent("DftAniEvent"):SetEndEvent(function()
				onNextTick(function()
					setActive(arg_53_0._tf, false)

					return
				end)
				arg_53_0._event:emit(var_0_1, arg_53_0.point, arg_53_0.result, arg_53_0._info)

				return
			end)
			arg_53_0._tf:GetComponent("DftAniEvent"):SetTriggerEvent(function()
				for iter_56_0 = arg_53_0._tf.name == "Cone" and 2 or 3, 1, -1 do
					setActive(arg_53_0._tf:Find(iter_56_0), false)
				end

				setActive(arg_53_0._tf:Find("Back"), false)

				if arg_53_0._tf.name == "Bowl" then
					setActive(arg_53_0._tf:Find("Front"), false)
				end

				return
			end)
			setActive(arg_53_0._tf:Find("Back"), true)

			if arg_53_0._tf.name == "Bowl" then
				setActive(arg_53_0._tf:Find("Front"), true)
			end

			for iter_53_0 = arg_53_0._tf.name == "Cone" and 2 or 3, 1, -1 do
				local var_53_0 = arg_53_0._tf:Find(iter_53_0)

				setActive(var_53_0, iter_53_0 <= #arg_47_2[1])

				if iter_53_0 <= #arg_47_2[1] then
					eachChild(var_53_0, function(arg_57_0)
						setActive(arg_57_0, false)

						return
					end)
					var_53_0:Find("Scoop"):GetComponent("DftAniEvent"):SetEndEvent(function()
						arg_53_0.isLeftLock = false

						if arg_53_0.successLeftLight then
							arg_53_0.successLeftLight = false

							setAnchoredPosition(var_53_0:Find("Good"), {
								x = 0,
								y = -10
							})
							setActive(var_53_0:Find("Good"), false)
							setActive(var_53_0:Find("Good"), true)
						end

						arg_53_0:NextDeal()

						return
					end)
					var_53_0:Find("Topping"):GetComponent("DftAniEvent"):SetEndEvent(function()
						arg_53_0.isRightLock = false

						if arg_53_0.successRightLight then
							arg_53_0.successRightLight = false

							setAnchoredPosition(var_53_0:Find("Good"), {
								x = 10,
								y = 6
							})
							setActive(var_53_0:Find("Good"), false)
							setActive(var_53_0:Find("Good"), true)
						end

						arg_53_0:NextDeal()

						return
					end)
				end
			end

			return
		end,
		ReadyBall = function(arg_60_0)
			setActive(arg_60_0._tf:Find(#arg_60_0._info[1] + 1):Find("Scoop_Next"), true)

			return
		end,
		MakeBall = function(arg_61_0, arg_61_1)
			arg_61_0.isLeftLock = true

			local var_61_0 = arg_61_0._tf:Find(#arg_61_0._info[1] + 1)

			setActive(var_61_0:Find("Scoop_Next"), false)
			setActive(var_61_0:Find("Scoop"), true)
			var_61_0:Find("Scoop"):GetComponent(typeof(Animator)):Play("Scoop_" .. var_0_14[arg_61_1])
			table.insert(arg_61_0._info[1], arg_61_1)

			arg_61_0.successLeftLight = arg_61_0._info[1][#arg_61_0._info[1]] == arg_47_2[1][#arg_61_0._info[1]]

			if arg_61_0.temporaryKey and var_0_13[#arg_47_2[1]][#arg_61_0._info[2] + 1] == #arg_61_0._info[1] then
				arg_61_0:SafeMissTopping()
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_flavour")

			return
		end,
		ReadyTopping = function(arg_62_0)
			setActive(arg_62_0._tf:Find(var_0_13[#arg_47_2[1]][#arg_62_0._info[2] + 1]):Find("Topping_Next"), true)

			return
		end,
		MakeTopping = function(arg_63_0, arg_63_1)
			arg_63_0.isRightLock = true

			local var_63_0 = arg_63_0._tf:Find(var_0_13[#arg_47_2[1]][#arg_63_0._info[2] + 1])

			setActive(var_63_0:Find("Topping_Next"), false)
			setActive(var_63_0:Find("Topping"), true)
			var_63_0:Find("Topping"):GetComponent(typeof(Animator)):Play("Topping_" .. var_0_15[arg_63_1])
			table.insert(arg_63_0._info[2], arg_63_1)

			arg_63_0.successRightLight = arg_63_0._info[2][#arg_63_0._info[2]] == arg_47_2[2][#arg_63_0._info[2]]

			pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_mixer")

			return
		end,
		MakeMissTopping = function(arg_64_0, arg_64_1)
			arg_64_0.isRightLock = true
			arg_64_0.temporaryKey = arg_64_1
			arg_64_0.missTime = var_0_4 * (var_0_13[#arg_47_2[1]][#arg_64_0._info[2] + 1] - #arg_64_0._info[1])

			var_0_17(true)

			local var_64_0 = arg_64_0._tf:Find(var_0_13[#arg_47_2[1]][#arg_64_0._info[2] + 1])

			setActive(var_64_0:Find("Topping_Next"), false)
			setActive(var_64_0:Find("Topping"), true)
			var_64_0:Find("Topping"):GetComponent(typeof(Animator)):Play("Topping_pre_" .. var_0_15[arg_64_1])

			return
		end,
		FailMissTopping = function(arg_65_0)
			arg_65_0.isRightLock = true
			arg_65_0.temporaryKey = nil
			arg_65_0.missTime = nil

			var_0_17(false)

			local var_65_0 = arg_65_0._tf:Find(var_0_13[#arg_47_2[1]][#arg_65_0._info[2] + 1])

			setActive(var_65_0:Find("Topping_Next"), false)
			setActive(var_65_0:Find("Topping"), true)
			var_65_0:Find("Topping"):GetComponent(typeof(Animator)):Play("Topping_Err_" .. var_0_15[arg_65_0.temporaryKey])

			return
		end,
		SafeMissTopping = function(arg_66_0)
			arg_66_0.isRightLock = true
			arg_66_0.temporaryKey = nil
			arg_66_0.missTime = nil

			var_0_17(false)

			local var_66_0 = arg_66_0._tf:Find(var_0_13[#arg_47_2[1]][#arg_66_0._info[2] + 1])

			setActive(var_66_0:Find("Topping_Next"), false)
			setActive(var_66_0:Find("Topping"), true)
			var_66_0:Find("Topping"):GetComponent(typeof(Animator)):Play("Topping_safe_" .. var_0_15[arg_66_0.temporaryKey])
			table.insert(arg_66_0._info[2], arg_66_0.temporaryKey)

			arg_66_0.successRightLight = arg_66_0._info[2][#arg_66_0._info[2]] == arg_47_2[2][#arg_66_0._info[2]]
			arg_66_0.missToppingMark[#arg_66_0._info[2]] = true

			pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_mixer")

			return
		end
	}).Ctor({
		Ctor = function(arg_48_0)
			arg_48_0._tf = arg_47_0
			arg_48_0._event = arg_47_1
			arg_48_0._info = {
				{},
				{}
			}
			arg_48_0.isLeftLock = false
			arg_48_0.isRightLock = false
			arg_48_0.missToppingMark = {}
			arg_48_0.waitTime = arg_47_3
			arg_48_0.isWaitTimeBoost = arg_47_4

			arg_48_0:Reset()
			arg_48_0:NextDeal()

			return
		end,
		NextDeal = function(arg_49_0)
			if arg_49_0.isLeftLock or arg_49_0.isRightLock then
				return
			end

			if #arg_49_0._info[1] < #arg_47_2[1] then
				arg_49_0:ReadyBall()
			elseif #arg_49_0._info[2] < #arg_47_2[2] then
				arg_49_0:ReadyTopping()
			else
				arg_49_0:Result()
			end

			return
		end,
		Result = function(arg_50_0, arg_50_1)
			arg_50_0.isResulted = true

			var_0_17(false)

			local var_50_0 = 0

			for iter_50_0, iter_50_1 in ipairs(arg_50_0._info) do
				for iter_50_2, iter_50_3 in ipairs(iter_50_1) do
					if (function(arg_51_0, arg_51_1, arg_51_2)
						arg_51_0[arg_51_1] = arg_51_0[arg_51_1] + arg_51_2

						return math.abs(arg_51_0[arg_51_1]) - math.abs(arg_51_0[arg_51_1])
					end)(({
						{
							0,
							0,
							0,
							0
						},
						{
							0,
							0,
							0,
							0
						}
					})[iter_50_0], arg_47_2[iter_50_0][iter_50_2], -1) < 0 then
						var_50_0 = var_50_0 + var_0_9[iter_50_0]
					end

					if (function(arg_51_0, arg_51_1, arg_51_2)
						arg_51_0[arg_51_1] = arg_51_0[arg_51_1] + arg_51_2

						return math.abs(arg_51_0[arg_51_1]) - math.abs(arg_51_0[arg_51_1])
					end)(({
						{
							0,
							0,
							0,
							0
						},
						{
							0,
							0,
							0,
							0
						}
					})[iter_50_0], iter_50_3, 1) < 0 then
						var_50_0 = var_50_0 + var_0_9[iter_50_0]
					end

					if arg_47_2[iter_50_0][iter_50_2] == iter_50_3 and (iter_50_0 == 1 or not arg_50_0.missToppingMark[iter_50_2]) then
						var_50_0 = var_50_0 + var_0_9[3]
					end
				end
			end

			if arg_50_1 then
				arg_50_0.result = arg_50_1
			else
				local var_50_1 = #arg_50_0._info[1] * var_0_9[1] + #arg_50_0._info[2] * var_0_9[2] + (#arg_50_0._info[1] + #arg_50_0._info[2]) * var_0_9[3]

				arg_50_0.result = var_50_0 == #arg_50_0._info[1] * var_0_9[1] + #arg_50_0._info[2] * var_0_9[2] + (#arg_50_0._info[1] + #arg_50_0._info[2]) * var_0_9[3] and 3 or table.equal(arg_50_0._info, arg_47_2) and 2 or var_50_0 >= var_50_1 / 2 and 1 or 0
			end

			local var_50_2 = arg_50_0._tf:GetComponent(typeof(Animator))

			if arg_50_0.result == 3 then
				arg_50_0.point = var_50_0 * (1 + var_0_10 / 100 + arg_50_0.waitTime / arg_47_3)

				var_50_2:Play("Perfect")
				pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_great")
			elseif arg_50_0.result == 2 then
				arg_50_0.point = var_50_0 * (1 + arg_50_0.waitTime / arg_47_3)

				var_50_2:Play("Pass")
			elseif arg_50_0.result == 1 then
				arg_50_0.point = var_50_0 * (1 + arg_50_0.waitTime / arg_47_3)

				var_50_2:Play("Pass")
			elseif arg_50_0.result == 0 then
				arg_50_0.point = 0

				var_50_2:Play("Fail")
				pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_fail")
			else
				assert(false)
			end

			return
		end,
		CountDown = function(arg_52_0, arg_52_1, arg_52_2)
			if arg_52_0.isResulted then
				return
			end

			if arg_52_0.waitTime > 0 then
				arg_52_0.waitTime = arg_52_0.waitTime - arg_52_1

				arg_52_0._event:emit(var_0_2, arg_52_2, 0, arg_47_3, arg_52_0.waitTime)
			else
				arg_52_0.waitTime = 0

				arg_52_0:Result(0)
			end

			if not arg_52_0.missTime then
				return
			end

			if arg_52_0.missTime > 0 then
				arg_52_0.missTime = arg_52_0.missTime - var_0_3
			else
				arg_52_0.missTime = nil

				arg_52_0:FailMissTopping()
			end

			return
		end,
		Reset = function(arg_53_0)
			arg_53_0._tf:GetComponent("DftAniEvent"):SetEndEvent(function()
				onNextTick(function()
					setActive(arg_53_0._tf, false)

					return
				end)
				arg_53_0._event:emit(var_0_1, arg_53_0.point, arg_53_0.result, arg_53_0._info)

				return
			end)
			arg_53_0._tf:GetComponent("DftAniEvent"):SetTriggerEvent(function()
				for iter_56_0 = arg_53_0._tf.name == "Cone" and 2 or 3, 1, -1 do
					setActive(arg_53_0._tf:Find(iter_56_0), false)
				end

				setActive(arg_53_0._tf:Find("Back"), false)

				if arg_53_0._tf.name == "Bowl" then
					setActive(arg_53_0._tf:Find("Front"), false)
				end

				return
			end)
			setActive(arg_53_0._tf:Find("Back"), true)

			if arg_53_0._tf.name == "Bowl" then
				setActive(arg_53_0._tf:Find("Front"), true)
			end

			for iter_53_0 = arg_53_0._tf.name == "Cone" and 2 or 3, 1, -1 do
				local var_53_0 = arg_53_0._tf:Find(iter_53_0)

				setActive(var_53_0, iter_53_0 <= #arg_47_2[1])

				if iter_53_0 <= #arg_47_2[1] then
					eachChild(var_53_0, function(arg_57_0)
						setActive(arg_57_0, false)

						return
					end)
					var_53_0:Find("Scoop"):GetComponent("DftAniEvent"):SetEndEvent(function()
						arg_53_0.isLeftLock = false

						if arg_53_0.successLeftLight then
							arg_53_0.successLeftLight = false

							setAnchoredPosition(var_53_0:Find("Good"), {
								x = 0,
								y = -10
							})
							setActive(var_53_0:Find("Good"), false)
							setActive(var_53_0:Find("Good"), true)
						end

						arg_53_0:NextDeal()

						return
					end)
					var_53_0:Find("Topping"):GetComponent("DftAniEvent"):SetEndEvent(function()
						arg_53_0.isRightLock = false

						if arg_53_0.successRightLight then
							arg_53_0.successRightLight = false

							setAnchoredPosition(var_53_0:Find("Good"), {
								x = 10,
								y = 6
							})
							setActive(var_53_0:Find("Good"), false)
							setActive(var_53_0:Find("Good"), true)
						end

						arg_53_0:NextDeal()

						return
					end)
				end
			end

			return
		end,
		ReadyBall = function(arg_60_0)
			setActive(arg_60_0._tf:Find(#arg_60_0._info[1] + 1):Find("Scoop_Next"), true)

			return
		end,
		MakeBall = function(arg_61_0, arg_61_1)
			arg_61_0.isLeftLock = true

			local var_61_0 = arg_61_0._tf:Find(#arg_61_0._info[1] + 1)

			setActive(var_61_0:Find("Scoop_Next"), false)
			setActive(var_61_0:Find("Scoop"), true)
			var_61_0:Find("Scoop"):GetComponent(typeof(Animator)):Play("Scoop_" .. var_0_14[arg_61_1])
			table.insert(arg_61_0._info[1], arg_61_1)

			arg_61_0.successLeftLight = arg_61_0._info[1][#arg_61_0._info[1]] == arg_47_2[1][#arg_61_0._info[1]]

			if arg_61_0.temporaryKey and var_0_13[#arg_47_2[1]][#arg_61_0._info[2] + 1] == #arg_61_0._info[1] then
				arg_61_0:SafeMissTopping()
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_flavour")

			return
		end,
		ReadyTopping = function(arg_62_0)
			setActive(arg_62_0._tf:Find(var_0_13[#arg_47_2[1]][#arg_62_0._info[2] + 1]):Find("Topping_Next"), true)

			return
		end,
		MakeTopping = function(arg_63_0, arg_63_1)
			arg_63_0.isRightLock = true

			local var_63_0 = arg_63_0._tf:Find(var_0_13[#arg_47_2[1]][#arg_63_0._info[2] + 1])

			setActive(var_63_0:Find("Topping_Next"), false)
			setActive(var_63_0:Find("Topping"), true)
			var_63_0:Find("Topping"):GetComponent(typeof(Animator)):Play("Topping_" .. var_0_15[arg_63_1])
			table.insert(arg_63_0._info[2], arg_63_1)

			arg_63_0.successRightLight = arg_63_0._info[2][#arg_63_0._info[2]] == arg_47_2[2][#arg_63_0._info[2]]

			pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_mixer")

			return
		end,
		MakeMissTopping = function(arg_64_0, arg_64_1)
			arg_64_0.isRightLock = true
			arg_64_0.temporaryKey = arg_64_1
			arg_64_0.missTime = var_0_4 * (var_0_13[#arg_47_2[1]][#arg_64_0._info[2] + 1] - #arg_64_0._info[1])

			var_0_17(true)

			local var_64_0 = arg_64_0._tf:Find(var_0_13[#arg_47_2[1]][#arg_64_0._info[2] + 1])

			setActive(var_64_0:Find("Topping_Next"), false)
			setActive(var_64_0:Find("Topping"), true)
			var_64_0:Find("Topping"):GetComponent(typeof(Animator)):Play("Topping_pre_" .. var_0_15[arg_64_1])

			return
		end,
		FailMissTopping = function(arg_65_0)
			arg_65_0.isRightLock = true
			arg_65_0.temporaryKey = nil
			arg_65_0.missTime = nil

			var_0_17(false)

			local var_65_0 = arg_65_0._tf:Find(var_0_13[#arg_47_2[1]][#arg_65_0._info[2] + 1])

			setActive(var_65_0:Find("Topping_Next"), false)
			setActive(var_65_0:Find("Topping"), true)
			var_65_0:Find("Topping"):GetComponent(typeof(Animator)):Play("Topping_Err_" .. var_0_15[arg_65_0.temporaryKey])

			return
		end,
		SafeMissTopping = function(arg_66_0)
			arg_66_0.isRightLock = true
			arg_66_0.temporaryKey = nil
			arg_66_0.missTime = nil

			var_0_17(false)

			local var_66_0 = arg_66_0._tf:Find(var_0_13[#arg_47_2[1]][#arg_66_0._info[2] + 1])

			setActive(var_66_0:Find("Topping_Next"), false)
			setActive(var_66_0:Find("Topping"), true)
			var_66_0:Find("Topping"):GetComponent(typeof(Animator)):Play("Topping_safe_" .. var_0_15[arg_66_0.temporaryKey])
			table.insert(arg_66_0._info[2], arg_66_0.temporaryKey)

			arg_66_0.successRightLight = arg_66_0._info[2][#arg_66_0._info[2]] == arg_47_2[2][#arg_66_0._info[2]]
			arg_66_0.missToppingMark[#arg_66_0._info[2]] = true

			pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_mixer")

			return
		end
	})

	return {
		Ctor = function(arg_48_0)
			arg_48_0._tf = arg_47_0
			arg_48_0._event = arg_47_1
			arg_48_0._info = {
				{},
				{}
			}
			arg_48_0.isLeftLock = false
			arg_48_0.isRightLock = false
			arg_48_0.missToppingMark = {}
			arg_48_0.waitTime = arg_47_3
			arg_48_0.isWaitTimeBoost = arg_47_4

			arg_48_0:Reset()
			arg_48_0:NextDeal()

			return
		end,
		NextDeal = function(arg_49_0)
			if arg_49_0.isLeftLock or arg_49_0.isRightLock then
				return
			end

			if #arg_49_0._info[1] < #arg_47_2[1] then
				arg_49_0:ReadyBall()
			elseif #arg_49_0._info[2] < #arg_47_2[2] then
				arg_49_0:ReadyTopping()
			else
				arg_49_0:Result()
			end

			return
		end,
		Result = function(arg_50_0, arg_50_1)
			arg_50_0.isResulted = true

			var_0_17(false)

			local var_50_0 = 0

			for iter_50_0, iter_50_1 in ipairs(arg_50_0._info) do
				for iter_50_2, iter_50_3 in ipairs(iter_50_1) do
					if (function(arg_51_0, arg_51_1, arg_51_2)
						arg_51_0[arg_51_1] = arg_51_0[arg_51_1] + arg_51_2

						return math.abs(arg_51_0[arg_51_1]) - math.abs(arg_51_0[arg_51_1])
					end)(({
						{
							0,
							0,
							0,
							0
						},
						{
							0,
							0,
							0,
							0
						}
					})[iter_50_0], arg_47_2[iter_50_0][iter_50_2], -1) < 0 then
						var_50_0 = var_50_0 + var_0_9[iter_50_0]
					end

					if (function(arg_51_0, arg_51_1, arg_51_2)
						arg_51_0[arg_51_1] = arg_51_0[arg_51_1] + arg_51_2

						return math.abs(arg_51_0[arg_51_1]) - math.abs(arg_51_0[arg_51_1])
					end)(({
						{
							0,
							0,
							0,
							0
						},
						{
							0,
							0,
							0,
							0
						}
					})[iter_50_0], iter_50_3, 1) < 0 then
						var_50_0 = var_50_0 + var_0_9[iter_50_0]
					end

					if arg_47_2[iter_50_0][iter_50_2] == iter_50_3 and (iter_50_0 == 1 or not arg_50_0.missToppingMark[iter_50_2]) then
						var_50_0 = var_50_0 + var_0_9[3]
					end
				end
			end

			if arg_50_1 then
				arg_50_0.result = arg_50_1
			else
				local var_50_1 = #arg_50_0._info[1] * var_0_9[1] + #arg_50_0._info[2] * var_0_9[2] + (#arg_50_0._info[1] + #arg_50_0._info[2]) * var_0_9[3]

				arg_50_0.result = var_50_0 == #arg_50_0._info[1] * var_0_9[1] + #arg_50_0._info[2] * var_0_9[2] + (#arg_50_0._info[1] + #arg_50_0._info[2]) * var_0_9[3] and 3 or table.equal(arg_50_0._info, arg_47_2) and 2 or var_50_0 >= var_50_1 / 2 and 1 or 0
			end

			local var_50_2 = arg_50_0._tf:GetComponent(typeof(Animator))

			if arg_50_0.result == 3 then
				arg_50_0.point = var_50_0 * (1 + var_0_10 / 100 + arg_50_0.waitTime / arg_47_3)

				var_50_2:Play("Perfect")
				pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_great")
			elseif arg_50_0.result == 2 then
				arg_50_0.point = var_50_0 * (1 + arg_50_0.waitTime / arg_47_3)

				var_50_2:Play("Pass")
			elseif arg_50_0.result == 1 then
				arg_50_0.point = var_50_0 * (1 + arg_50_0.waitTime / arg_47_3)

				var_50_2:Play("Pass")
			elseif arg_50_0.result == 0 then
				arg_50_0.point = 0

				var_50_2:Play("Fail")
				pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_fail")
			else
				assert(false)
			end

			return
		end,
		CountDown = function(arg_52_0, arg_52_1, arg_52_2)
			if arg_52_0.isResulted then
				return
			end

			if arg_52_0.waitTime > 0 then
				arg_52_0.waitTime = arg_52_0.waitTime - arg_52_1

				arg_52_0._event:emit(var_0_2, arg_52_2, 0, arg_47_3, arg_52_0.waitTime)
			else
				arg_52_0.waitTime = 0

				arg_52_0:Result(0)
			end

			if not arg_52_0.missTime then
				return
			end

			if arg_52_0.missTime > 0 then
				arg_52_0.missTime = arg_52_0.missTime - var_0_3
			else
				arg_52_0.missTime = nil

				arg_52_0:FailMissTopping()
			end

			return
		end,
		Reset = function(arg_53_0)
			arg_53_0._tf:GetComponent("DftAniEvent"):SetEndEvent(function()
				onNextTick(function()
					setActive(arg_53_0._tf, false)

					return
				end)
				arg_53_0._event:emit(var_0_1, arg_53_0.point, arg_53_0.result, arg_53_0._info)

				return
			end)
			arg_53_0._tf:GetComponent("DftAniEvent"):SetTriggerEvent(function()
				for iter_56_0 = arg_53_0._tf.name == "Cone" and 2 or 3, 1, -1 do
					setActive(arg_53_0._tf:Find(iter_56_0), false)
				end

				setActive(arg_53_0._tf:Find("Back"), false)

				if arg_53_0._tf.name == "Bowl" then
					setActive(arg_53_0._tf:Find("Front"), false)
				end

				return
			end)
			setActive(arg_53_0._tf:Find("Back"), true)

			if arg_53_0._tf.name == "Bowl" then
				setActive(arg_53_0._tf:Find("Front"), true)
			end

			for iter_53_0 = arg_53_0._tf.name == "Cone" and 2 or 3, 1, -1 do
				local var_53_0 = arg_53_0._tf:Find(iter_53_0)

				setActive(var_53_0, iter_53_0 <= #arg_47_2[1])

				if iter_53_0 <= #arg_47_2[1] then
					eachChild(var_53_0, function(arg_57_0)
						setActive(arg_57_0, false)

						return
					end)
					var_53_0:Find("Scoop"):GetComponent("DftAniEvent"):SetEndEvent(function()
						arg_53_0.isLeftLock = false

						if arg_53_0.successLeftLight then
							arg_53_0.successLeftLight = false

							setAnchoredPosition(var_53_0:Find("Good"), {
								x = 0,
								y = -10
							})
							setActive(var_53_0:Find("Good"), false)
							setActive(var_53_0:Find("Good"), true)
						end

						arg_53_0:NextDeal()

						return
					end)
					var_53_0:Find("Topping"):GetComponent("DftAniEvent"):SetEndEvent(function()
						arg_53_0.isRightLock = false

						if arg_53_0.successRightLight then
							arg_53_0.successRightLight = false

							setAnchoredPosition(var_53_0:Find("Good"), {
								x = 10,
								y = 6
							})
							setActive(var_53_0:Find("Good"), false)
							setActive(var_53_0:Find("Good"), true)
						end

						arg_53_0:NextDeal()

						return
					end)
				end
			end

			return
		end,
		ReadyBall = function(arg_60_0)
			setActive(arg_60_0._tf:Find(#arg_60_0._info[1] + 1):Find("Scoop_Next"), true)

			return
		end,
		MakeBall = function(arg_61_0, arg_61_1)
			arg_61_0.isLeftLock = true

			local var_61_0 = arg_61_0._tf:Find(#arg_61_0._info[1] + 1)

			setActive(var_61_0:Find("Scoop_Next"), false)
			setActive(var_61_0:Find("Scoop"), true)
			var_61_0:Find("Scoop"):GetComponent(typeof(Animator)):Play("Scoop_" .. var_0_14[arg_61_1])
			table.insert(arg_61_0._info[1], arg_61_1)

			arg_61_0.successLeftLight = arg_61_0._info[1][#arg_61_0._info[1]] == arg_47_2[1][#arg_61_0._info[1]]

			if arg_61_0.temporaryKey and var_0_13[#arg_47_2[1]][#arg_61_0._info[2] + 1] == #arg_61_0._info[1] then
				arg_61_0:SafeMissTopping()
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_flavour")

			return
		end,
		ReadyTopping = function(arg_62_0)
			setActive(arg_62_0._tf:Find(var_0_13[#arg_47_2[1]][#arg_62_0._info[2] + 1]):Find("Topping_Next"), true)

			return
		end,
		MakeTopping = function(arg_63_0, arg_63_1)
			arg_63_0.isRightLock = true

			local var_63_0 = arg_63_0._tf:Find(var_0_13[#arg_47_2[1]][#arg_63_0._info[2] + 1])

			setActive(var_63_0:Find("Topping_Next"), false)
			setActive(var_63_0:Find("Topping"), true)
			var_63_0:Find("Topping"):GetComponent(typeof(Animator)):Play("Topping_" .. var_0_15[arg_63_1])
			table.insert(arg_63_0._info[2], arg_63_1)

			arg_63_0.successRightLight = arg_63_0._info[2][#arg_63_0._info[2]] == arg_47_2[2][#arg_63_0._info[2]]

			pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_mixer")

			return
		end,
		MakeMissTopping = function(arg_64_0, arg_64_1)
			arg_64_0.isRightLock = true
			arg_64_0.temporaryKey = arg_64_1
			arg_64_0.missTime = var_0_4 * (var_0_13[#arg_47_2[1]][#arg_64_0._info[2] + 1] - #arg_64_0._info[1])

			var_0_17(true)

			local var_64_0 = arg_64_0._tf:Find(var_0_13[#arg_47_2[1]][#arg_64_0._info[2] + 1])

			setActive(var_64_0:Find("Topping_Next"), false)
			setActive(var_64_0:Find("Topping"), true)
			var_64_0:Find("Topping"):GetComponent(typeof(Animator)):Play("Topping_pre_" .. var_0_15[arg_64_1])

			return
		end,
		FailMissTopping = function(arg_65_0)
			arg_65_0.isRightLock = true
			arg_65_0.temporaryKey = nil
			arg_65_0.missTime = nil

			var_0_17(false)

			local var_65_0 = arg_65_0._tf:Find(var_0_13[#arg_47_2[1]][#arg_65_0._info[2] + 1])

			setActive(var_65_0:Find("Topping_Next"), false)
			setActive(var_65_0:Find("Topping"), true)
			var_65_0:Find("Topping"):GetComponent(typeof(Animator)):Play("Topping_Err_" .. var_0_15[arg_65_0.temporaryKey])

			return
		end,
		SafeMissTopping = function(arg_66_0)
			arg_66_0.isRightLock = true
			arg_66_0.temporaryKey = nil
			arg_66_0.missTime = nil

			var_0_17(false)

			local var_66_0 = arg_66_0._tf:Find(var_0_13[#arg_47_2[1]][#arg_66_0._info[2] + 1])

			setActive(var_66_0:Find("Topping_Next"), false)
			setActive(var_66_0:Find("Topping"), true)
			var_66_0:Find("Topping"):GetComponent(typeof(Animator)):Play("Topping_safe_" .. var_0_15[arg_66_0.temporaryKey])
			table.insert(arg_66_0._info[2], arg_66_0.temporaryKey)

			arg_66_0.successRightLight = arg_66_0._info[2][#arg_66_0._info[2]] == arg_47_2[2][#arg_66_0._info[2]]
			arg_66_0.missToppingMark[#arg_66_0._info[2]] = true

			pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-icecream_mixer")

			return
		end
	}
end

function var_0_0.DoIceCream(arg_67_0)
	setActive(arg_67_0.rtTime, true)
	setActive(arg_67_0.rtMake, true)

	local var_67_0 = arg_67_0.targetList[arg_67_0.targetIndex]
	local var_67_1 = #arg_67_0.targetList[arg_67_0.targetIndex]._info[1] < 3 and "Cone" or "Bowl"

	eachChild(arg_67_0.rtMake, function(arg_68_0)
		setActive(arg_68_0, arg_68_0.name == var_67_1)

		return
	end)

	local var_67_2 = arg_67_0.rtMake:Find(var_67_1)

	for iter_67_0 = var_67_1 == "Cone" and 2 or 3, 1, -1 do
		setActive(var_67_2:Find(iter_67_0), false)
	end

	arg_67_0.iceBuild = var_0_19(var_67_2, arg_67_0, var_67_0._info, var_67_0.time, var_67_0.isWaitTimeBoost)

	if var_67_0.timeBoost then
		arg_67_0.effectTrigger.bullet_time.doingTime = var_0_11.bullet_time[2]
		arg_67_0.effectTrigger.bullet_time.waitTime = var_0_11.bullet_time[4]

		arg_67_0:setAnimatorSpeed(arg_67_0._tf, 0.5)
		arg_67_0:setAnimatorSpeed(arg_67_0.rtMake, 1)
		setActive(arg_67_0.gameUI:Find("BulletTimeMask"), true)
	end

	return
end

function var_0_0.startGame(arg_69_0)
	setActive(arg_69_0.gameUI, true)

	arg_69_0.gameStartFlag = true

	arg_69_0:CreateTarget(-var_0_7[1] / 3)

	arg_69_0.targetIndex = 1

	arg_69_0:RandomBG()
	arg_69_0:timerStart()

	return
end

function var_0_0.RandomBG(arg_70_0)
	arg_70_0.poolBG = arg_70_0.poolBG or {
		GroupD = {
			1
		}
	}

	if not arg_70_0.poolBG.GroupAB or #arg_70_0.poolBG.GroupAB == 0 then
		arg_70_0.poolBG.GroupAB = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if not arg_70_0.poolBG["GroupC/Other"] or #arg_70_0.poolBG["GroupC/Other"] == 0 then
		arg_70_0.poolBG["GroupC/Other"] = {
			1,
			2,
			3,
			4
		}
	end

	arg_70_0.poolBG["GroupC/Manjuu"] = {
		1,
		2,
		3
	}

	for iter_70_0, iter_70_1 in pairs(arg_70_0.poolBG) do
		local var_70_0 = {}

		for iter_70_2 = iter_70_0 == "GroupC/Manjuu" and 2 or 1, 1, -1 do
			if iter_70_0 == "GroupD" then
				var_70_0[iter_70_1[1]] = true
				iter_70_1[1] = 3 - iter_70_1[1]
			else
				var_70_0[table.remove(iter_70_1, math.random(#iter_70_1))] = true
			end
		end

		local var_70_1 = arg_70_0.gameUI:Find("BG/" .. iter_70_0)

		for iter_70_3 = var_70_1.childCount, 1, -1 do
			setActive(var_70_1:GetChild(iter_70_3 - 1), var_70_0[iter_70_3])
		end
	end

	return
end

function var_0_0.getIntervalTime(arg_71_0)
	if arg_71_0.effectTrigger.bullet_time.doingTime > 0 then
		return var_0_3 * var_0_11.bullet_time[1]
	else
		return var_0_3
	end

	return
end

function var_0_0.onTimer(arg_72_0)
	local var_72_0 = arg_72_0.effectTrigger.bullet_time

	if arg_72_0.effectTrigger.bullet_time.doingTime > 0 then
		var_72_0.doingTime = var_72_0.doingTime - var_0_3

		if var_72_0.doingTime <= 0 then
			arg_72_0:setAnimatorSpeed(arg_72_0._tf, 1)
			setActive(arg_72_0.gameUI:Find("BulletTimeMask"), false)
		end
	elseif var_72_0.waitTime > 0 then
		var_72_0.waitTime = var_72_0.waitTime - var_0_3
	end

	arg_72_0.lastTime = arg_72_0.lastTime - arg_72_0:getIntervalTime()

	arg_72_0:updateWalker()

	if arg_72_0.lastTime <= 0 then
		arg_72_0:endGame()
	else
		setText(arg_72_0.timeTF, math.floor(arg_72_0.lastTime))

		if not arg_72_0.iceBuild and arg_72_0.targetList[arg_72_0.targetIndex]._tf.anchoredPosition.x > 0 then
			arg_72_0:DoIceCream()
		end

		if #arg_72_0.targetList == arg_72_0.targetIndex then
			arg_72_0:CreateTarget()
		end
	end

	if arg_72_0.iceBuild then
		arg_72_0.iceBuild:CountDown(arg_72_0:getIntervalTime(), var_72_0.doingTime > 0 and "frozen" or arg_72_0.iceBuild.isWaitTimeBoost and "extend" or "base")
	end

	return
end

function var_0_0.updateWalker(arg_73_0)
	for iter_73_0 = #arg_73_0.targetList, 1, -1 do
		local var_73_0 = arg_73_0.targetList[iter_73_0]._tf:GetComponent(typeof(Animator))
		local var_73_1 = var_73_0:GetCurrentAnimatorStateInfo(0)

		if arg_73_0.targetList[iter_73_0].result then
			if arg_73_0.targetList[iter_73_0].isLeave then
				setAnchoredPosition(arg_73_0.targetList[iter_73_0]._tf, {
					x = arg_73_0.targetList[iter_73_0]._tf.anchoredPosition.x + arg_73_0:getIntervalTime() * var_0_8[1]
				})

				if arg_73_0.targetList[iter_73_0]._tf.anchoredPosition.x > var_0_7[1] then
					arg_73_0:RemoveTarget()
				end
			end
		else
			local var_73_2 = var_0_7[3]

			if iter_73_0 > 1 then
				var_73_2 = math.min(var_73_2, arg_73_0.targetList[iter_73_0 - 1]._tf.anchoredPosition.x)
			end

			local var_73_3 = var_73_2 - arg_73_0.targetList[iter_73_0]._tf.anchoredPosition.x

			if var_73_2 - arg_73_0.targetList[iter_73_0]._tf.anchoredPosition.x < var_0_7[3] then
				if not arg_73_0.targetList[iter_73_0].state or arg_73_0.targetList[iter_73_0].state ~= "Stand" then
					arg_73_0.targetList[iter_73_0].state = "Stand"

					var_73_0:Play("Stand")
				end
			elseif var_73_3 < var_0_7[2] then
				setAnchoredPosition(arg_73_0.targetList[iter_73_0]._tf, {
					x = arg_73_0.targetList[iter_73_0]._tf.anchoredPosition.x + arg_73_0:getIntervalTime() * var_0_8[2]
				})

				if not arg_73_0.targetList[iter_73_0].state or arg_73_0.targetList[iter_73_0].state ~= "Walk" then
					arg_73_0.targetList[iter_73_0].state = "Walk"

					var_73_0:Play("Walk")
				end
			else
				setAnchoredPosition(arg_73_0.targetList[iter_73_0]._tf, {
					x = arg_73_0.targetList[iter_73_0]._tf.anchoredPosition.x + arg_73_0:getIntervalTime() * var_0_8[1]
				})

				if not arg_73_0.targetList[iter_73_0].state or arg_73_0.targetList[iter_73_0].state ~= "Run" then
					arg_73_0.targetList[iter_73_0].state = "Run"

					var_73_0:Play("Run")
				end
			end
		end
	end

	return
end

function var_0_0.setAnimatorSpeed(arg_74_0, arg_74_1, arg_74_2)
	for iter_74_0, iter_74_1 in ipairs((arg_74_1:GetComponentsInChildren(typeof(Animator), true):ToTable())) do
		iter_74_1.speed = arg_74_2
	end

	return
end

function var_0_0.timerStart(arg_75_0)
	if not arg_75_0.timer.running then
		arg_75_0.timer:Start()
	end

	if arg_75_0.effectTrigger.bullet_time.doingTime > 0 then
		arg_75_0:setAnimatorSpeed(arg_75_0._tf, 0.5)
		arg_75_0:setAnimatorSpeed(arg_75_0.rtMake, 1)
	else
		arg_75_0:setAnimatorSpeed(arg_75_0._tf, 1)
	end

	if arg_75_0.iceBuild and arg_75_0.iceBuild.missTime then
		var_0_17(true)
	end

	return
end

function var_0_0.timerStop(arg_76_0)
	if arg_76_0.timer.running then
		arg_76_0.timer:Stop()
	end

	arg_76_0:setAnimatorSpeed(arg_76_0._tf, 0)

	if arg_76_0.iceBuild and arg_76_0.iceBuild.missTime then
		var_0_17(false)
	end

	return
end

function var_0_0.addScore(arg_77_0, arg_77_1, arg_77_2)
	arg_77_0.scoreNum = arg_77_0.scoreNum + arg_77_1

	setText(arg_77_0.scoreTF, arg_77_0.scoreNum)
	setActive(arg_77_0.addScoreTF, false)
	setActive(arg_77_0.addScoreTF, true)

	local var_77_0 = arg_77_0.addScoreTF:Find("score_tf")

	setText(var_77_0, "+" .. arg_77_1)

	if arg_77_2 == 0 then
		setTextColor(var_77_0, Color.NewHex("ED666DFF"))
	elseif arg_77_2 == 1 then
		setTextColor(var_77_0, Color.NewHex("FAB149FF"))
	elseif arg_77_2 == 2 then
		setTextColor(var_77_0, Color.NewHex("C6CC15FF"))
	elseif arg_77_2 == 3 then
		setTextColor(var_77_0, Color.NewHex("80BF1CFF"))
	else
		assert(false)
	end

	return
end

function var_0_0.pauseGame(arg_78_0)
	arg_78_0.gamePause = true

	arg_78_0:timerStop()
	arg_78_0:pauseManagedTween()

	return
end

function var_0_0.resumeGame(arg_79_0)
	arg_79_0.gamePause = false

	arg_79_0:timerStart()
	arg_79_0:resumeManagedTween()

	return
end

function var_0_0.endGame(arg_80_0)
	if arg_80_0.gameEndFlag then
		return
	end

	arg_80_0:timerStop()

	arg_80_0.gameEndFlag = true

	setActive(arg_80_0.clickMask, true)
	arg_80_0:managedTween(LeanTween.delayedCall, function()
		arg_80_0.gameEndFlag = false
		arg_80_0.gameStartFlag = false

		setActive(arg_80_0.clickMask, false)
		arg_80_0:showEndUI()

		return
	end, 0.1, nil)

	return
end

function var_0_0.showEndUI(arg_82_0)
	pg.UIMgr.GetInstance():OverlayPanel(arg_82_0.endUI)
	setActive(arg_82_0.endUI, true)

	local var_82_0 = arg_82_0.scoreNum
	local var_82_1 = getProxy(GameRoomProxy):getRoomScore(arg_82_0:getGameRoomData().id)

	setActive(arg_82_0.endUI:Find("panel/now/Text/new"), var_82_1 < arg_82_0.scoreNum)

	if var_82_1 <= var_82_0 then
		var_82_1 = var_82_0

		arg_82_0:StoreDataToServer({
			var_82_0
		})
	end

	setText(arg_82_0.endUI:Find("panel/max/Text"), var_82_1)
	setText(arg_82_0.endUI:Find("panel/now/Text"), var_82_0)
	arg_82_0:SendSuccess(var_82_0)

	return
end

function var_0_0.getGameTimes(arg_83_0)
	return arg_83_0:GetMGHubData().count
end

function var_0_0.getGameUsedTimes(arg_84_0)
	return arg_84_0:GetMGHubData().usedtime
end

function var_0_0.getUltimate(arg_85_0)
	return arg_85_0:GetMGHubData().ultimate
end

function var_0_0.getGameTotalTime(arg_86_0)
	return (arg_86_0:GetMGHubData():getConfig("reward_need"))
end

function var_0_0.OnApplicationPaused(arg_87_0, arg_87_1)
	if arg_87_1 and not arg_87_0.gameEndFlag and arg_87_0.gameStartFlag and not arg_87_0.gamePause then
		arg_87_0:pauseGame()
		pg.UIMgr.GetInstance():OverlayPanel(arg_87_0.pauseUI)
		setActive(arg_87_0.pauseUI, true)
	end

	return
end

function var_0_0.onBackPressed(arg_88_0)
	if arg_88_0.gameEndFlag then
		return
	end

	if isActive(arg_88_0.pauseUI) then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_88_0.pauseUI, arg_88_0._tf:Find("ui"))
		setActive(arg_88_0.pauseUI, false)
		arg_88_0:resumeGame()

		return
	end

	if isActive(arg_88_0.returnUI) then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_88_0.returnUI, arg_88_0._tf:Find("ui"))
		setActive(arg_88_0.returnUI, false)
		arg_88_0:resumeGame()

		return
	end

	if isActive(arg_88_0.endUI) then
		return
	end

	if arg_88_0.gameStartFlag then
		arg_88_0:pauseGame()
		pg.UIMgr.GetInstance():OverlayPanel(arg_88_0.pauseUI)
		setActive(arg_88_0.pauseUI, true)

		return
	end

	arg_88_0:emit(var_0_0.ON_BACK_PRESSED)

	return
end

function var_0_0.willExit(arg_89_0)
	if arg_89_0.handle then
		UpdateBeat:RemoveListener(arg_89_0.handle)
	end

	arg_89_0:cleanManagedTween()

	if arg_89_0.timer and arg_89_0.timer.running then
		arg_89_0.timer:Stop()
	end

	Time.timeScale = 1
	arg_89_0.timer = nil

	return
end

return var_0_0
