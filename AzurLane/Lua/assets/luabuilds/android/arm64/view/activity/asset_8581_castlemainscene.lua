class = var_0_10000

local var_0_0 = "CastleMainScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.optionsPath = {
	"main/top/btn_home"
}

local var_0_2 = "name"
local var_0_3 = "default_value"
local var_0_4 = "random_value"

ActivityConst = var_0_10004
var_0_1.ACT_ID = var_0_10004.CASTLE_ACT_ID
ActivityConst = var_4
var_0_1.AWARD_ACT_ID = var_4.CASTLE_AWARD_ID
var_0_1.SKILL_COLOR = {
	"#546190",
	"#835490",
	"#A57D55",
	"#C15348"
}
Color = var_4
var_0_1.BAD_FILL_COLOR = var_4(0.6588235294117647, 0.5019607843137255, 0.4823529411764706, 0.5)
Color = var_4
var_0_1.NORMAL_FILL_COLOR = var_4(1, 1, 1, 0.5)
Color = var_4
var_0_1.TRANSPARENT_COLOR = var_4(1, 1, 1, 0)
var_0_1.MARK_CURRENT = "1"
var_0_1.MARK_UNEXPLORED = "2"
var_0_1.MARK_BAD = "3"
var_0_1.MARK_EXPLORABLE = "4"
var_0_1.MAP_POS = {
	1,
	2,
	3,
	3,
	4,
	5,
	5,
	6,
	7,
	7,
	8,
	9,
	9,
	10,
	11,
	11,
	12,
	13,
	13,
	14,
	15,
	15,
	17,
	16
}
var_0_1.ROOM_NUM = 17
var_0_1.WALK_SE = "event:/ui/castle_walk"
var_0_1.ROLL_SE = "event:/ui/caslte_roll"
var_0_1.CARD_SE = "event:/ui/huihua1"

function var_0_1.getUIName(arg_1_0)
	return "CastleMainUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:InitData()
	arg_2_0:InitTF()
	arg_2_0:InitAward()
	arg_2_0:InitCharacter()
	arg_2_0:InitDice()
	arg_2_0:InitVX()

	return
end

function var_0_1.InitTF(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.main = var_1.Find(var_3_0, "main")

	local var_3_1 = arg_3_0.main

	arg_3_0.map = var_1.Find(var_3_1, "map")

	local var_3_2 = {}
	local var_3_3 = arg_3_0.map

	var_3_2[1] = var_2.Find(var_3_3, "floor1")

	local var_3_4 = arg_3_0.map

	var_3_2[2] = var_2.Find(var_3_4, "floor2")
	arg_3_0.floors = var_3_2

	local var_3_5 = {}
	local var_3_6 = arg_3_0.floors[1]

	var_3_5[1] = var_2.Find(var_3_6, "rooms")

	local var_3_7 = arg_3_0.floors[2]

	var_3_5[2] = var_2.Find(var_3_7, "rooms")
	arg_3_0.rooms = var_3_5

	local var_3_8 = arg_3_0.main

	arg_3_0.top = var_1.Find(var_3_8, "top")

	local var_3_9 = arg_3_0.top

	arg_3_0.buttonBack = var_1.Find(var_3_9, "btn_back")

	local var_3_10 = arg_3_0.top

	arg_3_0.buttonHelp = var_1.Find(var_3_10, "btn_help")

	local var_3_11 = arg_3_0.top

	arg_3_0.buttonAward = var_1.Find(var_3_11, "btn_award")

	local var_3_12 = arg_3_0.top

	arg_3_0.buttonCharacter = var_1.Find(var_3_12, "btn_character")

	local var_3_13 = arg_3_0.top

	arg_3_0.buttonDice = var_1.Find(var_3_13, "btn_dice")

	local var_3_14 = arg_3_0.buttonDice

	arg_3_0.diceRes = var_1.Find(var_3_14, "dice_res")

	local var_3_15 = arg_3_0.top

	arg_3_0.button1F = var_1.Find(var_3_15, "btn_1F")

	local var_3_16 = arg_3_0.top

	arg_3_0.button2F = var_1.Find(var_3_16, "btn_2F")

	local var_3_17 = arg_3_0._tf

	arg_3_0.window = var_1.Find(var_3_17, "window")

	return
end

function var_0_1.InitData(arg_4_0)
	pg = var_1_10001
	arg_4_0.storyMgr = var_1_10001.NewStoryMgr.GetInstance()
	getProxy = var_1
	ActivityProxy = var_1_10003

	local var_4_0 = var_1(var_1_10003)

	arg_4_0.activity = var_1.getActivityById(var_4_0, var_0_1.ACT_ID)
	arg_4_0.story2Map = {}
	arg_4_0.map2Story = {}
	arg_4_0.storyGroup = {}
	ipairs = var_1

	local var_4_1 = arg_4_0.activity

	for iter_4_0, iter_4_1 in var_1(var_3.getConfig(var_4_1, "config_data")[3]) do
		table = var_6

		var_6.insert(arg_4_0.storyGroup, iter_4_1[1][1])

		table = var_6

		var_6.insert(arg_4_0.storyGroup, iter_4_1[2][2])

		table = var_6

		var_6.insert(arg_4_0.storyGroup, iter_4_1[2][1])
	end

	for iter_4_2 = 1, var_0_1.ROOM_NUM do
		table = iter_4_1

		iter_4_1.insert(arg_4_0.map2Story, {})
	end

	for iter_4_3 = 1, #arg_4_0.storyGroup do
		table = iter_4_1

		iter_4_1.insert(arg_4_0.story2Map, arg_4_0.storyGroup[iter_4_3], var_0_1.MAP_POS[iter_4_3])

		table = iter_4_1

		iter_4_1.insert(arg_4_0.map2Story[var_0_1.MAP_POS[iter_4_3]], arg_4_0.storyGroup[iter_4_3])
	end

	arg_4_0.explorableStories = {}
	arg_4_0.exploredStories = {}

	if arg_4_0.activity.data1 ~= nil and arg_4_0.activity.data1 ~= 0 then
		for iter_4_4 = 1, #arg_4_0.storyGroup do
			table = iter_4_1
			iter_4_1 = iter_4_1.insert

			local var_4_2

			if not arg_4_0:IsPlayed(arg_4_0.storyGroup[iter_4_4]) or not arg_4_0.exploredStories then
				var_4_2 = arg_4_0.explorableStories
			end

			iter_4_1(var_4_2, arg_4_0.storyGroup[iter_4_4])

			if arg_4_0.storyGroup[iter_4_4] == arg_4_0.activity.data1 then
				break
			end
		end
	end

	arg_4_0.explorablePos = arg_4_0.activity.data1
	arg_4_0.currentPos = #arg_4_0.exploredStories == 0 and 0 or arg_4_0.exploredStories[#arg_4_0.exploredStories]

	return
end

function var_0_1.InitAward(arg_5_0)
	local var_5_0 = arg_5_0.window

	arg_5_0.awardWindow = var_1.Find(var_5_0, "award_window")

	local var_5_1 = arg_5_0.awardWindow

	arg_5_0.buttonAwardGet = var_1.Find(var_5_1, "award_bg/btn_get")

	local var_5_2 = arg_5_0.awardWindow

	arg_5_0.awardWindowBg = var_1.Find(var_5_2, "bg")

	local var_5_3 = arg_5_0.awardWindow

	arg_5_0.awardItem = var_1.Find(var_5_3, "award_bg/mask/item")

	local var_5_4 = arg_5_0.awardWindow

	arg_5_0.awardItems = var_1.Find(var_5_4, "award_bg/mask/content")
	getProxy = var_1
	ActivityProxy = var_5_4

	local var_5_5 = var_1(var_5_4)

	arg_5_0.awardActivity = var_1.getActivityById(var_5_5, var_0_1.AWARD_ACT_ID)
	getProxy = var_1
	TaskProxy = var_5_5
	arg_5_0.taskProxy = var_1(var_5_5)

	local var_5_6 = arg_5_0.awardActivity

	arg_5_0.taskGroup = var_1.getConfig(var_5_6, "config_data")
	UIItemList = var_1
	arg_5_0.taskList = var_1.New(arg_5_0.awardItems, arg_5_0.awardItem)
	arg_5_0.taskMap = {}

	for iter_5_0 = 1, #arg_5_0.taskGroup do
		table = var_1_10005

		var_1_10005.insert(arg_5_0.taskMap, iter_5_0)
	end

	return
end

function var_0_1.InitDice(arg_6_0)
	local var_6_0 = arg_6_0.window

	arg_6_0.diceWindow = var_1.Find(var_6_0, "dice_window")

	local var_6_1 = arg_6_0.diceWindow

	arg_6_0.buttonDiceContinue = var_1.Find(var_6_1, "btn_continue")

	local var_6_2 = arg_6_0.diceWindow

	arg_6_0.dice = var_1.Find(var_6_2, "dice")

	local var_6_3 = {}
	local var_6_4 = arg_6_0.dice

	var_6_3[1] = var_2.Find(var_6_4, "dice1")

	local var_6_5 = arg_6_0.dice

	var_6_3[2] = var_2.Find(var_6_5, "dice2")
	arg_6_0.dices = var_6_3

	local var_6_6 = arg_6_0.diceWindow

	arg_6_0.result = var_1.Find(var_6_6, "result")

	local var_6_7 = arg_6_0.result

	arg_6_0.success = var_1.Find(var_6_7, "success")

	local var_6_8 = arg_6_0.result

	arg_6_0.criticalSuccess = var_1.Find(var_6_8, "critical_success")

	local var_6_9 = arg_6_0.result

	arg_6_0.failure = var_1.Find(var_6_9, "failure")

	local var_6_10 = arg_6_0.result

	arg_6_0.criticalFailure = var_1.Find(var_6_10, "critical_failure")

	return
end

function var_0_1.InitCharacter(arg_7_0)
	local var_7_0 = arg_7_0.window

	arg_7_0.characterWindow = var_1.Find(var_7_0, "character_window")

	local var_7_1 = arg_7_0.characterWindow

	arg_7_0.characterWindowBg = var_1.Find(var_7_1, "bg")

	local var_7_2 = arg_7_0.characterWindowBg

	arg_7_0.characterCard = var_1.Find(var_7_2, "character_card")

	local var_7_3 = arg_7_0.characterCard

	arg_7_0.characterName = var_1.Find(var_7_3, "title_base/name")

	local var_7_4 = arg_7_0.characterCard

	arg_7_0.profession = var_1.Find(var_7_4, "title_base/profession")

	local var_7_5 = arg_7_0.characterName

	arg_7_0.nameInput = var_1.Find(var_7_5, "InputField")

	local var_7_6 = arg_7_0.characterCard

	arg_7_0.attrGroup = var_1.Find(var_7_6, "title_attr/attrGroup")

	local var_7_7 = arg_7_0.characterCard

	arg_7_0.skillGroup = var_1.Find(var_7_7, "title_skill/skillGroup")

	local var_7_8 = arg_7_0.characterCard

	arg_7_0.characterTip = var_1.Find(var_7_8, "tip")
	setText = var_1

	local var_7_9 = arg_7_0.characterTip

	i18n = var_4

	var_1(var_7_9, var_4("roll_unlock"))

	local var_7_10 = arg_7_0.characterCard

	arg_7_0.buttonRandom = var_1.Find(var_7_10, "random")

	local var_7_11 = arg_7_0.buttonRandom

	arg_7_0.randomLock = var_1.Find(var_7_11, "lock")

	local var_7_12 = arg_7_0.buttonRandom

	arg_7_0.randomText = var_1.Find(var_7_12, "Image")
	setText = var_1

	local var_7_13 = arg_7_0.characterCard
	local var_7_14 = var_3.Find(var_7_13, "title_base")

	i18n = var_4

	var_1(var_7_14, var_4("roll_card_info"))

	setText = var_1

	local var_7_15 = arg_7_0.characterCard
	local var_7_16 = var_3.Find(var_7_15, "title_attr")

	i18n = var_4

	var_1(var_7_16, var_4("roll_card_attr"))

	setText = var_1

	local var_7_17 = arg_7_0.characterCard
	local var_7_18 = var_3.Find(var_7_17, "title_skill")

	i18n = var_4

	var_1(var_7_18, var_4("roll_card_skill"))

	local var_7_19 = arg_7_0.activity
	local var_7_20 = var_1.getConfig(var_7_19, "config_client")[2]

	arg_7_0.story2Attr = {}
	ipairs = var_2

	for iter_7_0, iter_7_1 in var_2(var_7_20) do
		table = var_1_10007

		var_1_10007.insert(arg_7_0.story2Attr, iter_7_1[1], iter_7_1[2])
	end

	arg_7_0.attrLock = {}

	return
end

function var_0_1.InitVX(arg_8_0)
	ipairs = var_1_10001

	for iter_8_0, iter_8_1 in var_1_10001({
		"success",
		"Csuccess",
		"failure",
		"Cfailure"
	}) do
		local var_8_0 = arg_8_0.result
		local var_8_1 = var_6.GetChild(var_8_0, iter_8_0 - 1)

		findTF = var_1_10007
		var_1_10007 = var_1_10007(var_8_1, iter_8_1)
		findTF = var_8_0

		local var_8_2 = var_8_0(var_8_1, "VX/glow")

		setLocalScale = var_9

		var_9(var_8_2, {
			x = var_1_10007.rect.width,
			y = var_1_10007.rect.height
		})
	end

	return
end

function var_0_1.didEnter(arg_9_0)
	for iter_9_0 = 1, var_0_1.ROOM_NUM do
		var_1_10007 = arg_9_0

		local var_9_0 = arg_9_0.GetRoomTF(var_1_10007, iter_9_0)

		findTF = var_1_10006
		var_1_10006 = var_1_10006(var_9_0, "name")
		setText = var_1_10007

		local var_9_1 = var_1_10006

		i18n = var_1_10010

		var_1_10007(var_9_1, var_1_10010("roll_room_unexplored"))

		findTF = var_1_10007
		var_1_10007 = var_1_10007(var_9_0, "explorable")
		setImageRaycastTarget = var_8
		findTF = var_1_10010

		var_8(var_1_10010(var_9_0, "fill"), true)

		onButton = var_8
		var_1_10010 = arg_9_0

		local var_9_2 = var_9_0

		local function var_9_3()
			ipairs = var_2_10000

			for iter_10_0, iter_10_1 in var_2_10000(arg_9_0.map2Story[iter_9_0]) do
				table = var_2_10005

				if var_2_10005.contains(arg_9_0.explorableStories, iter_10_1) then
					local var_10_0 = arg_9_0

					var_2_10005.PlayStory(var_10_0, iter_10_1)

					break
				end
			end

			return
		end

		SFX_PANEL = var_13

		var_8(var_1_10010, var_9_2, var_9_3, var_13)
	end

	table = var_1

	local var_9_4

	if not var_1.contains(arg_9_0.explorableStories, arg_9_0.storyGroup[15]) then
		table = var_9_4
		var_9_4 = var_9_4.contains(arg_9_0.exploredStories, arg_9_0.storyGroup[15])
	end

	local var_9_5

	if var_9_4 then
		var_9_5 = nil

		for iter_9_1 = #arg_9_0.exploredStories, 1, -1 do
			if not arg_9_0:IsBadEnd(arg_9_0.exploredStories[iter_9_1]) then
				var_9_5 = arg_9_0.exploredStories[iter_9_1]

				break
			end
		end

		local var_9_6

		if not var_9_5 or not arg_9_0.story2Map[var_9_5] then
			var_9_6 = 0
		end

		local var_9_7 = var_9_6 > 10 and var_9_6 < 17

		setActive = var_5

		var_5(arg_9_0.floors[1], not var_9_7)

		setActive = var_5

		var_5(arg_9_0.floors[2], var_9_7)

		setActive = var_5

		var_5(arg_9_0.button1F, not var_9_7)

		setActive = var_5

		var_5(arg_9_0.button2F, var_9_7)
	else
		setActive = var_9_5

		var_9_5(arg_9_0.button1F, false)

		setActive = var_9_5

		var_9_5(arg_9_0.button2F, false)
	end

	local var_9_8 = arg_9_0.taskList

	var_2.make(var_9_8, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = arg_9_0

			var_3.UpdateTask(var_11_0, arg_11_1, arg_11_2)
		end

		return
	end)

	local var_9_9 = arg_9_0.nameInput
	local var_9_10 = var_2.GetComponent

	typeof = var_5
	InputField = var_1_10007

	local var_9_11 = var_9_10(var_9_9, var_5(var_1_10007)).onValueChanged

	var_2.AddListener(var_9_11, function()
		nameValidityCheck = var_2_10000
		getInputText = var_2_10002

		if not var_2_10000(var_2_10002(arg_9_0.nameInput), 0, 40, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"ship_renameShip_error_2011",
			"playerinfo_mask_word"
		}) then
			setInputText = var_0

			local var_12_0 = arg_9_0.nameInput

			getProxy = var_3
			PlayerProxy = var_5

			local var_12_1 = var_3(var_5)

			var_0(var_12_0, var_3.getData(var_12_1).name)
		end

		return
	end)
	arg_9_0:InitButton()
	arg_9_0:UpdateFlush()

	local var_9_12 = arg_9_0.activity

	if var_2.getConfig(var_9_12, "config_data")[1] and not arg_9_0:IsPlayed(var_2) then
		local var_9_13 = arg_9_0
		local var_9_14 = arg_9_0.emit

		CastleMainMediator = var_6

		var_9_14(var_9_13, var_6.CASTLE_ACT_OP, {
			cmd = 3,
			id = var_0_1.ACT_ID,
			arg1 = var_2
		})
	else
		arg_9_0:CheckGuide()
	end

	return
end

function var_0_1.InitButton(arg_13_0)
	onButton = var_1_10001

	var_1_10001(arg_13_0, arg_13_0.button1F, function()
		setActive = var_2_10000

		var_2_10000(arg_13_0.button1F, false)

		setActive = var_2_10000

		var_2_10000(arg_13_0.button2F, true)

		setActive = var_2_10000

		var_2_10000(arg_13_0.floors[2], true)

		setActive = var_2_10000

		var_2_10000(arg_13_0.floors[1], false)

		return
	end, var_0_1.WALK_SE)

	onButton = var_1_10001

	var_1_10001(arg_13_0, arg_13_0.button2F, function()
		setActive = var_2_10000

		var_2_10000(arg_13_0.button2F, false)

		setActive = var_2_10000

		var_2_10000(arg_13_0.button1F, true)

		setActive = var_2_10000

		var_2_10000(arg_13_0.floors[1], true)

		setActive = var_2_10000

		var_2_10000(arg_13_0.floors[2], false)

		return
	end, var_0_1.WALK_SE)

	onButton = var_1_10001

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.buttonBack

	local function var_13_2()
		local var_16_0 = arg_13_0

		var_0.closeView(var_16_0)

		return
	end

	SFX_CANCEL = var_6

	var_1_10001(var_13_0, var_13_1, var_13_2, var_6)

	onButton = var_1_10001

	local var_13_3 = arg_13_0
	local var_13_4 = arg_13_0.buttonHelp

	local function var_13_5()
		i18n = var_2_10000

		local var_17_0 = var_2_10000("roll_gametip")

		pg = var_2_10001

		local var_17_1 = var_2_10001.MsgboxMgr.GetInstance()
		local var_17_2 = var_1.ShowMsgBox
		local var_17_3 = {}

		MSGBOX_TYPE_HELP = var_2_10005
		var_17_3.type = var_2_10005
		var_17_3.helps = var_17_0

		var_17_2(var_17_1, var_17_3)

		return
	end

	SFX_PANEL = var_6

	var_1_10001(var_13_3, var_13_4, var_13_5, var_6)

	onButton = var_1_10001

	local var_13_6 = arg_13_0
	local var_13_7 = arg_13_0.buttonAward

	local function var_13_8()
		setActive = var_2_10000

		var_2_10000(arg_13_0.awardWindow, true)

		local var_18_0 = arg_13_0

		var_0.CheckAwardGet(var_18_0)

		local var_18_1 = arg_13_0

		var_0.ExplorableEffect(var_18_1, false)

		return
	end

	SFX_PANEL = var_6

	var_1_10001(var_13_6, var_13_7, var_13_8, var_6)

	onButton = var_1_10001

	local var_13_9 = arg_13_0
	local var_13_10 = arg_13_0.buttonAwardGet

	local function var_13_11()
		underscore = var_2_10000

		local var_19_0 = var_2_10000(arg_13_0.taskGroup)
		local var_19_1 = var_0.chain(var_19_0)
		local var_19_2 = var_0.map(var_19_1, function(arg_20_0)
			local var_20_0 = arg_13_0.taskProxy

			return var_1.getTaskVO(var_20_0, arg_20_0)
		end)
		local var_19_3 = var_0.filter(var_19_2, function(arg_21_0)
			return arg_21_0:getTaskStatus() == 1
		end)

		if #var_0.value(var_19_3) > 0 then
			local var_19_4 = arg_13_0
			local var_19_5 = var_1.emit

			CastleMainMediator = var_2_10004

			var_19_5(var_19_4, var_2_10004.ON_TASK_SUBMIT, var_0)
		end

		return
	end

	SFX_PANEL = var_6

	var_1_10001(var_13_9, var_13_10, var_13_11, var_6)

	onButton = var_1_10001

	local var_13_12 = arg_13_0
	local var_13_13 = arg_13_0.awardWindowBg

	local function var_13_14()
		setActive = var_2_10000

		var_2_10000(arg_13_0.awardWindow, false)

		local var_22_0 = arg_13_0

		var_0.ExplorableEffect(var_22_0, true)

		return
	end

	SFX_CANCEL = var_6

	var_1_10001(var_13_12, var_13_13, var_13_14, var_6)

	onButton = var_1_10001

	local var_13_15 = arg_13_0
	local var_13_16 = arg_13_0.buttonCharacter

	local function var_13_17()
		local var_23_0 = arg_13_0

		var_0.UpdateCard(var_23_0)

		setActive = var_0

		var_0(arg_13_0.characterWindow, true)

		pg = var_0

		local var_23_1 = var_0.UIMgr.GetInstance()

		var_0.BlurPanel(var_23_1, arg_13_0.characterCard)

		return
	end

	SFX_PANEL = var_6

	var_1_10001(var_13_15, var_13_16, var_13_17, var_6)

	onButton = var_1_10001

	local var_13_18 = arg_13_0
	local var_13_19 = arg_13_0.characterWindowBg

	local function var_13_20()
		setActive = var_2_10000

		var_2_10000(arg_13_0.characterWindow, false)

		pg = var_2_10000

		local var_24_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_24_0, arg_13_0.characterCard, arg_13_0.characterWindowBg)

		local var_24_1 = arg_13_0

		var_0.UpdateFlush(var_24_1)

		local var_24_2 = arg_13_0

		var_0.CheckGuide(var_24_2)

		return
	end

	SFX_CANCEL = var_6

	var_1_10001(var_13_18, var_13_19, var_13_20, var_6)

	onButton = var_1_10001

	local var_13_21 = arg_13_0
	local var_13_22 = arg_13_0.buttonRandom

	local function var_13_23()
		local var_25_0 = arg_13_0

		if var_0.IsFinish(var_25_0) then
			getInputText = var_0

			if #var_0(arg_13_0.nameInput) == 0 then
				pg = var_1

				local var_25_1 = var_1.TipsMgr.GetInstance()
				local var_25_2 = var_1.ShowTips

				i18n = var_2_10004

				var_25_2(var_25_1, var_2_10004("roll_noname"))
			else
				local var_25_3 = arg_13_0

				var_1.RollCharacterCard(var_25_3)
			end
		end

		return
	end

	SFX_CANCEL = var_6

	var_1_10001(var_13_21, var_13_22, var_13_23, var_6)

	onButton = var_1_10001

	local var_13_24 = arg_13_0
	local var_13_25 = arg_13_0.buttonDice

	local function var_13_26()
		if arg_13_0.diceCount < 1 then
			table = var_0

			if not var_0.contains(arg_13_0.explorableStories, arg_13_0.storyGroup[23]) then
				table = var_26_1

				local var_26_1

				if var_26_1.contains(arg_13_0.explorableStories, arg_13_0.storyGroup[24]) then
					pg = var_26_1

					local var_26_0 = var_26_1.TipsMgr.GetInstance()

					var_26_1 = var_26_1.ShowTips
					i18n = var_3

					var_26_1(var_26_0, var_3("roll_ending_tip1"))
				else
					table = var_26_1

					local var_26_3

					if var_26_1.contains(arg_13_0.exploredStories, arg_13_0.storyGroup[23]) then
						table = var_26_3

						if var_26_3.contains(arg_13_0.exploredStories, arg_13_0.storyGroup[24]) then
							pg = var_26_3

							local var_26_2 = var_26_3.TipsMgr.GetInstance()

							var_26_3 = var_26_3.ShowTips
							i18n = var_3

							var_26_3(var_26_2, var_3("roll_ending_tip2"))

							goto label_26_0
						end
					end

					pg = var_26_3

					local var_26_4 = var_26_3.TipsMgr.GetInstance()
					local var_26_5 = var_0.ShowTips

					i18n = var_3

					var_26_5(var_26_4, var_3("roll_notimes"))
				end

				::label_26_0::

				do return end

				local var_26_6 = arg_13_0
				local var_26_7 = var_0.IndexofStory(var_26_6, arg_13_0.explorablePos)
				local var_26_8 = arg_13_0

				if var_26_7 > var_1.IndexofStory(var_26_8, arg_13_0.currentPos) then
					pg = var_26_7

					local var_26_9 = var_26_7.TipsMgr.GetInstance()
					local var_26_10 = var_0.ShowTips

					i18n = var_26_8

					var_26_10(var_26_9, var_26_8("roll_tip2"))

					return
				end

				local var_26_11 = arg_13_0
				local var_26_12 = var_0.emit

				CastleMainMediator = var_26_8

				var_26_12(var_26_11, var_26_8.CASTLE_ACT_OP, {
					cmd = 1,
					id = var_0_1.ACT_ID
				})

				return
			end
		end
	end

	SFX_PANEL = var_6

	var_1_10001(var_13_24, var_13_25, var_13_26, var_6)

	onButton = var_1_10001

	local var_13_27 = arg_13_0
	local var_13_28 = arg_13_0.buttonDiceContinue

	local function var_13_29()
		setActive = var_2_10000

		var_2_10000(arg_13_0.diceWindow, false)

		local var_27_0 = arg_13_0

		var_0.UpdateFlush(var_27_0)

		local var_27_1 = arg_13_0

		var_0.CheckGuide(var_27_1)

		local var_27_2 = arg_13_0

		var_0.ExplorableEffect(var_27_2, true)

		return
	end

	SFX_PANEL = var_6

	var_1_10001(var_13_27, var_13_28, var_13_29, var_6)

	return
end

function var_0_1.UpdateFlush(arg_28_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_28_0 = var_1_10001(var_1_10003)

	arg_28_0.activity = var_1.getActivityById(var_28_0, var_0_1.ACT_ID)
	getProxy = var_1
	ActivityProxy = var_28_0

	local var_28_1 = var_1(var_28_0)

	arg_28_0.awardActivity = var_1.getActivityById(var_28_1, var_0_1.AWARD_ACT_ID)

	local var_28_2 = arg_28_0.awardActivity

	arg_28_0.taskGroup = var_1.getConfig(var_28_2, "config_data")

	arg_28_0:UpdateDice()
	arg_28_0:UpdateMap()
	arg_28_0:UpdateAward()
	arg_28_0:UpdateCharacter()

	if arg_28_0:IndexofStory(arg_28_0.explorablePos) == 15 and arg_28_0:IndexofStory(arg_28_0.explorablePos) > arg_28_0:IndexofStory(arg_28_0.currentPos) then
		setActive = var_1_10002

		var_1_10002(arg_28_0.button1F, true)
	end

	setActive = var_1_10002

	var_1_10002(arg_28_0.buttonDice, not arg_28_0:IsFinish())

	return
end

function var_0_1.UpdateDice(arg_29_0)
	arg_29_0.diceCount = arg_29_0.activity.data2
	table = var_1

	if var_1.contains(arg_29_0.explorableStories, arg_29_0.explorablePos) and arg_29_0:IsBadEnd(arg_29_0.explorablePos) then
		arg_29_0.diceCount = arg_29_0.diceCount - 1
	end

	setText = var_1

	local var_29_0 = arg_29_0.diceRes

	i18n = var_4

	var_1(var_29_0, var_4("roll_times_left", arg_29_0.diceCount))

	if arg_29_0.explorablePos == arg_29_0.currentPos and arg_29_0.diceCount > 0 then
		local var_29_1 = arg_29_0.buttonDice
		local var_29_2 = var_1.GetComponent

		typeof = var_4
		Animation = var_6

		local var_29_3 = var_29_2(var_29_1, var_4(var_6))

		var_1.Play(var_29_3, "anim_castle_dice_tiploop")
	else
		local var_29_4 = arg_29_0.buttonDice
		local var_29_5 = var_1.GetComponent

		typeof = var_4
		Animation = var_6

		local var_29_6 = var_29_5(var_29_4, var_4(var_6))

		var_1.Stop(var_29_6)
	end

	return
end

function var_0_1.UpdateMap(arg_30_0)
	for iter_30_0 = 1, var_0_1.ROOM_NUM do
		arg_30_0:ChangeRoomColor(iter_30_0, var_0_1.TRANSPARENT_COLOR)
		arg_30_0:ChangeRoomMark(iter_30_0, nil)
	end

	ipairs = var_1

	for iter_30_1, iter_30_2 in var_1(arg_30_0.exploredStories) do
		local var_30_0 = arg_30_0.story2Map[iter_30_2]
		local var_30_1 = arg_30_0:GetRoomTF(var_30_0)

		setText = var_1_10008
		findTF = var_10

		local var_30_2 = var_10(var_30_1, "name")

		i18n = var_1_10011

		var_1_10008(var_30_2, var_1_10011("roll_room" .. var_30_0))
	end

	setActive = var_1
	findTF = var_3

	var_1(var_3(arg_30_0.main, "finish_mask"), false)

	local var_30_3 = arg_30_0

	if arg_30_0.IsFinish(var_30_3) then
		setActive = var_1
		findTF = var_30_3

		var_1(var_30_3(arg_30_0.main, "finish_mask"), true)

		return
	end

	ipairs = var_1

	for iter_30_3, iter_30_4 in var_1(arg_30_0.exploredStories) do
		local var_30_4 = arg_30_0.story2Map[iter_30_4]

		if arg_30_0:IsBadEnd(iter_30_4) then
			if var_30_4 ~= 17 then
				if var_30_4 ~= 4 then
					arg_30_0:ChangeRoomColor(var_30_4, var_0_1.BAD_FILL_COLOR)
				end

				arg_30_0:ChangeRoomMark(var_30_4, var_0_1.MARK_BAD)
			end
		else
			arg_30_0:ChangeRoomColor(var_30_4, var_0_1.NORMAL_FILL_COLOR)
		end
	end

	ipairs = var_1

	for iter_30_5, iter_30_6 in var_1(arg_30_0.explorableStories) do
		local var_30_5 = arg_30_0.story2Map[iter_30_6]

		arg_30_0:ChangeRoomMark(var_30_5, var_0_1.MARK_EXPLORABLE)
		arg_30_0:ChangeRoomMark(var_30_5, var_0_1.MARK_UNEXPLORED, true)
	end

	local var_30_6 = #arg_30_0.exploredStories

	if 0 < var_30_6 then
		var_30_6 = nil
		ipairs = var_2

		for iter_30_7, iter_30_8 in var_2(arg_30_0.storyGroup) do
			if not arg_30_0:IsBadEnd(iter_30_8) then
				table = var_7

				if var_7.contains(arg_30_0.exploredStories, iter_30_8) then
					var_30_6 = iter_30_8
				end
			end
		end

		iter_30_5 = arg_30_0

		arg_30_0.ChangeRoomMark(iter_30_5, arg_30_0.story2Map[var_30_6], var_0_1.MARK_CURRENT, true)
	end

	setActive = var_30_6

	local var_30_7 = arg_30_0.button1F
	local var_30_8 = var_3.Find(var_30_7, "Image")

	table = iter_30_5

	var_30_6(var_30_8, iter_30_5.contains(arg_30_0.explorableStories, arg_30_0.storyGroup[24]))

	setActive = var_30_6

	local var_30_9 = arg_30_0.button2F
	local var_30_10 = var_3.Find(var_30_9, "Image")

	table = var_4

	var_30_6(var_30_10, var_4.contains(arg_30_0.explorableStories, arg_30_0.storyGroup[23]))

	return
end

function var_0_1.UpdateAward(arg_31_0)
	arg_31_0:CheckAwardGet()

	table = var_1

	var_1.sort(arg_31_0.taskMap, function(arg_32_0, arg_32_1)
		local var_32_0 = arg_31_0.taskProxy
		local var_32_1 = var_2.getTaskVO(var_32_0, arg_31_0.taskGroup[arg_32_0])
		local var_32_2 = var_2.getTaskStatus(var_32_1) == 2 and 1 or 0
		local var_32_3 = arg_31_0.taskProxy
		local var_32_4 = var_3.getTaskVO(var_32_3, arg_31_0.taskGroup[arg_32_1])

		if var_32_2 == (var_3.getTaskStatus(var_32_4) == 2 and 1 or 0) then
			return arg_32_0 < arg_32_1
		end

		return var_32_2 < var_3
	end)

	local var_31_0 = arg_31_0.taskList

	var_1.align(var_31_0, #arg_31_0.taskGroup)

	local var_31_1 = arg_31_0.storyMgr
	local var_31_2 = var_1.StoryId2StoryName
	local var_31_3 = arg_31_0.activity
	local var_31_4 = var_31_2(var_31_1, var_4.getConfig(var_31_3, "config_client")[1][3])
	local var_31_5 = arg_31_0

	if not arg_31_0.IsPlayed(var_31_5, var_31_4) then
		getProxy = var_2
		TaskProxy = var_31_5

		local var_31_6 = var_2(var_31_5)

		if var_2.isReceiveTasks(var_31_6, arg_31_0.taskGroup) then
			playStory = var_2

			var_2(var_31_4)
		end
	end

	return
end

function var_0_1.UpdateCharacter(arg_33_0)
	setActive = var_1_10001

	var_1_10001(arg_33_0.randomLock, not arg_33_0:IsFinish())

	setActive = var_1_10001

	local var_33_0 = arg_33_0.randomText
	local var_33_1 = arg_33_0

	var_1_10001(var_33_0, arg_33_0.IsFinish(var_33_1))

	local var_33_2 = arg_33_0.nameInput
	local var_33_3 = var_1.GetComponent

	typeof = var_4
	InputField = var_33_1

	local var_33_4 = var_33_3(var_33_2, var_4(var_33_1))

	var_33_4.interactable = arg_33_0:IsFinish()
	setActive = var_33_4

	local var_33_5 = arg_33_0.characterName

	var_33_4(var_3.Find(var_33_5, "edit"), arg_33_0:IsFinish())

	return
end

function var_0_1.UpdateTask(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0.taskMap[arg_34_1 + 1]
	local var_34_1 = arg_34_2:Find("IconTpl")
	local var_34_2 = arg_34_0.taskGroup[var_34_0]
	local var_34_3 = arg_34_0.taskProxy
	local var_34_4 = var_6.getTaskVO(var_34_3, var_34_2)

	assert = var_7

	var_7(var_34_4, "without this task by id: " .. var_34_2)

	setText = var_7

	local var_34_5 = arg_34_2:Find("title")

	i18n = var_10

	var_7(var_34_5, var_10("roll_reward_word" .. var_34_0))

	local var_34_6 = var_34_4:getConfig("award_display")[1]
	local var_34_7 = {
		type = var_34_6[1],
		id = var_34_6[2],
		count = var_34_6[3]
	}

	updateDrop = var_9

	var_9(var_34_1, var_34_7)

	onButton = var_9

	local var_34_8 = arg_34_0
	local var_34_9 = var_34_1

	local function var_34_10()
		local var_35_0 = arg_34_0
		local var_35_1 = var_0.emit

		BaseUI = var_2_10003

		var_35_1(var_35_0, var_2_10003.ON_DROP, var_34_7)

		return
	end

	SFX_PANEL = var_1_10014

	var_9(var_34_8, var_34_9, var_34_10, var_1_10014)

	local var_34_11 = var_34_4
	local var_34_12 = var_34_4.getProgress(var_34_11)
	local var_34_13 = var_34_4:getConfig("target_num")

	setText = var_34_11

	local var_34_14 = arg_34_2:Find("progress")

	i18n = var_1_10014

	var_34_11(var_34_14, var_1_10014("roll_reward_tip", var_34_12, var_34_13))

	setText = var_34_11

	local var_34_15 = arg_34_2:Find("mask/Text")

	i18n = var_14

	var_34_11(var_34_15, var_14("roll_reward_got"))

	setActive = var_34_11

	var_34_11(arg_34_2:Find("mask"), var_34_4:isReceive())

	return
end

function var_0_1.UpdateAttrLock(arg_36_0)
	arg_36_0.attrLock = {}
	ipairs = var_1

	for iter_36_0, iter_36_1 in var_1(arg_36_0.exploredStories) do
		if arg_36_0.story2Attr[iter_36_1] ~= nil then
			ipairs = var_6

			for iter_36_2, iter_36_3 in var_6(arg_36_0.story2Attr[iter_36_1]) do
				table = var_1_10011

				var_1_10011.insert(arg_36_0.attrLock, iter_36_3)
			end
		end
	end

	return
end

function var_0_1.UpdateCard(arg_37_0)
	arg_37_0:UpdateAttrLock()

	setText = var_1

	var_1(arg_37_0.characterName, var_0_1.GetRollData(1, var_0_2) .. ":")

	setInputText = var_1

	local var_37_0 = arg_37_0.nameInput

	getProxy = var_4
	PlayerProxy = var_6

	local var_37_1 = var_4(var_6)

	var_1(var_37_0, var_4.getData(var_37_1).name)

	setText = var_1

	var_1(arg_37_0.profession, var_0_1.GetRollData(2, var_0_2) .. ":")

	setText = var_1
	findTF = var_3

	var_1(var_3(arg_37_0.profession, "Text"), var_0_1.GetRollData(2, var_0_3))

	for iter_37_0 = 1, arg_37_0.attrGroup.childCount do
		local var_37_2 = arg_37_0.attrGroup
		local var_37_3 = var_5.GetChild(var_37_2, iter_37_0 - 1)

		for iter_37_1 = 1, var_37_3.childCount do
			local var_37_4 = var_37_3:GetChild(iter_37_1 - 1)
			local var_37_5 = (iter_37_1 - 1) * arg_37_0.attrGroup.childCount + iter_37_0 + 2

			setText = var_12
			findTF = var_1_10014

			var_12(var_1_10014(var_37_4, "name"), var_0_1.GetRollData(var_37_5, var_0_2))

			setText = var_12
			findTF = var_1_10014
			var_1_10014 = var_1_10014(var_37_4, "Text")
			table = var_1_10015

			if not var_1_10015.contains(arg_37_0.attrLock, var_37_5) or not var_0_1.GetRollData(var_37_5, var_0_3) then
				var_1_10015 = "---"
			end

			var_12(var_1_10014, var_1_10015)

			setActive = var_12
			findTF = var_1_10014
			var_1_10014 = var_1_10014(var_37_4, "Text/Image")
			table = var_1_10015

			var_12(var_1_10014, not var_1_10015.contains(arg_37_0.attrLock, var_37_5))
		end
	end

	for iter_37_2 = 1, arg_37_0.skillGroup.childCount do
		local var_37_6 = arg_37_0.skillGroup
		local var_37_7 = var_5.GetChild(var_37_6, iter_37_2 - 1)

		for iter_37_3 = 1, var_37_7.childCount do
			local var_37_8 = var_37_7:GetChild(iter_37_3 - 1)
			local var_37_9 = (iter_37_3 - 1) * arg_37_0.attrGroup.childCount + iter_37_2 + 10

			setText = var_12
			findTF = var_1_10014
			var_1_10014 = var_1_10014(var_37_8, "group/skill_name")
			table = var_1_10015

			if not var_1_10015.contains(arg_37_0.attrLock, var_37_9) or not var_0_1.GetRollData(var_37_9, var_0_2) then
				var_1_10015 = ""
			end

			var_12(var_1_10014, var_1_10015)

			setText = var_12
			findTF = var_1_10014
			var_1_10014 = var_1_10014(var_37_8, "group/Text")
			table = var_1_10015

			if not var_1_10015.contains(arg_37_0.attrLock, var_37_9) or not var_0_1.GetColorValue(var_37_9, var_0_1.GetRollData(var_37_9, var_0_3)) then
				var_1_10015 = ""
			end

			var_12(var_1_10014, var_1_10015)

			setActive = var_12
			findTF = var_1_10014
			var_1_10014 = var_1_10014(var_37_8, "Image")
			table = var_1_10015

			var_12(var_1_10014, not var_1_10015.contains(arg_37_0.attrLock, var_37_9))
		end
	end

	return
end

function var_0_1.RollCharacterCard(arg_38_0)
	for iter_38_0 = 1, arg_38_0.attrGroup.childCount do
		local var_38_0 = arg_38_0.attrGroup
		local var_38_1 = var_5.GetChild(var_38_0, iter_38_0 - 1)

		for iter_38_1 = 1, var_38_1.childCount do
			local var_38_2 = var_38_1:GetChild(iter_38_1 - 1)
			local var_38_3 = (iter_38_1 - 1) * arg_38_0.attrGroup.childCount + iter_38_0 + 2
			local var_38_4 = var_0_1.GetRollData(var_38_3, var_0_4)

			setText = var_13
			findTF = var_15

			local var_38_5 = var_15(var_38_2, "Text")

			math = var_1_10016

			var_13(var_38_5, var_1_10016.random(var_38_4[1], var_38_4[2]))
		end
	end

	local var_38_6 = var_0_1.GetRandomValue

	i18n = var_3

	local var_38_7 = var_38_6(var_3("roll_attr_list"), 8)
	local var_38_8 = 1

	for iter_38_2 = 1, arg_38_0.skillGroup.childCount do
		local var_38_9 = arg_38_0.skillGroup
		local var_38_10 = var_7.GetChild(var_38_9, iter_38_2 - 1)

		for iter_38_3 = 1, var_38_10.childCount do
			local var_38_11 = var_38_10:GetChild(iter_38_3 - 1)
			local var_38_12 = (iter_38_3 - 1) * arg_38_0.attrGroup.childCount + iter_38_2 + 10

			setText = var_14
			findTF = var_1_10016

			var_14(var_1_10016(var_38_11, "group/skill_name"), var_38_7[var_38_8])

			var_38_8 = var_38_8 + 1
			setText = var_14
			findTF = var_1_10016

			var_14(var_1_10016(var_38_11, "group/Text"), var_0_1.GetColorValue(var_38_12, var_0_1.GetRandomValue(var_0_1.GetRollData(var_38_12, var_0_4), 1)[1]))
		end
	end

	return
end

function var_0_1.IsFinish(arg_39_0)
	return #arg_39_0.exploredStories == 24
end

function var_0_1.GetRandomValue(arg_40_0, arg_40_1)
	local var_40_0 = {}

	for iter_40_0 = 1, #arg_40_0 do
		table = var_1_10007

		var_1_10007.insert(var_40_0, iter_40_0)
	end

	shuffle = var_3

	var_3(var_40_0)

	local var_40_1 = {}

	for iter_40_1 = 1, arg_40_1 do
		table = var_1_10008

		var_1_10008.insert(var_40_1, arg_40_0[var_40_0[iter_40_1]])
	end

	return var_40_1
end

function var_0_1.GetColorValue(arg_41_0, arg_41_1)
	local var_41_0 = var_0_1.GetRollData(arg_41_0, var_0_4)

	table = var_1_10003

	local var_41_1 = var_1_10003.indexof(var_41_0, arg_41_1)

	setColorStr = var_4

	return var_4(arg_41_1, var_0_1.SKILL_COLOR[var_41_1])
end

function var_0_1.CheckAwardGet(arg_42_0)
	local var_42_0 = false

	ipairs = var_1_10002

	for iter_42_0, iter_42_1 in var_1_10002(arg_42_0.taskGroup) do
		local var_42_1 = arg_42_0.taskProxy
		local var_42_2 = var_7.getTaskVO(var_42_1, iter_42_1)

		if var_7.getTaskStatus(var_42_2) == 1 then
			var_42_0 = true
		end
	end

	setActive = var_2

	var_2(arg_42_0.buttonAwardGet, var_42_0)

	setActive = var_2
	findTF = var_4

	var_2(var_4(arg_42_0.buttonAward, "red"), var_42_0)

	return
end

function var_0_1.PlayStory(arg_43_0, arg_43_1)
	if arg_43_0:IsPlayed(arg_43_1) then
		return
	end

	arg_43_0.waitPlayStory = arg_43_1

	local var_43_0 = arg_43_0
	local var_43_1 = arg_43_0.emit

	CastleMainMediator = var_5

	var_43_1(var_43_0, var_5.CASTLE_ACT_OP, {
		cmd = 2,
		id = var_0_1.ACT_ID,
		arg1 = arg_43_1
	})

	return
end

function var_0_1.StoryActEnd(arg_44_0, arg_44_1)
	if not arg_44_0.waitPlayStory then
		return
	end

	local var_44_0 = arg_44_0.storyMgr
	local var_44_1, var_44_2 = var_2.StoryId2StoryName(var_44_0, arg_44_0.waitPlayStory)

	local function var_44_3()
		if arg_44_0.story2Attr[arg_44_0.waitPlayStory] == nil then
			return false
		end

		local var_45_0 = 0

		ipairs = var_1

		for iter_45_0, iter_45_1 in var_1(arg_44_0.story2Attr[arg_44_0.waitPlayStory]) do
			table = var_2_10006

			if not var_2_10006.contains(arg_44_0.attrLock, iter_45_1) then
				var_45_0 = var_45_0 + 1
			end
		end

		return var_45_0 > 0
	end

	playStory = var_5

	var_5(var_44_1, function()
		if var_44_3() then
			local var_46_0 = arg_44_0

			var_0.UpdateCard(var_46_0)

			setActive = var_0

			var_0(arg_44_0.characterWindow, true)

			pg = var_0

			local var_46_1 = var_0.UIMgr.GetInstance()

			var_0.BlurPanel(var_46_1, arg_44_0.characterCard)

			pg = var_0

			local var_46_2 = var_0.CriMgr.GetInstance()

			var_0.PlaySoundEffect_V3(var_46_2, var_0_1.CARD_SE)

			ipairs = var_0

			for iter_46_0, iter_46_1 in var_0(arg_44_0.story2Attr[arg_44_0.waitPlayStory]) do
				if iter_46_1 < 11 then
					local var_46_3 = iter_46_1 - 3

					math = var_2_10006
					var_2_10006 = var_2_10006.floor(var_46_3 / arg_44_0.attrGroup.childCount)

					local var_46_4 = var_46_3 % arg_44_0.attrGroup.childCount
					local var_46_5 = arg_44_0.attrGroup
					local var_46_6 = var_8.GetChild(var_46_5, var_46_4)
					local var_46_7 = var_8.GetChild(var_46_6, var_2_10006)

					setText = var_2_10009
					findTF = var_11

					var_2_10009(var_11(var_46_7, "Text"), var_0_1.GetRollData(iter_46_1, var_0_3))

					findTF = var_2_10009

					local var_46_8 = var_2_10009(var_46_7, "Text/Image")

					var_2_10009 = var_2_10009.GetComponent
					typeof = var_12
					Animation = var_14

					local var_46_9 = var_2_10009(var_46_8, var_12(var_14))

					var_2_10009.Play(var_46_9, "anim_castle_skill")
				else
					local var_46_10 = iter_46_1 - 11

					math = var_2_10006
					var_2_10006 = var_2_10006.floor(var_46_10 / arg_44_0.skillGroup.childCount)

					local var_46_11 = var_46_10 % arg_44_0.skillGroup.childCount
					local var_46_12 = arg_44_0.skillGroup
					local var_46_13 = var_8.GetChild(var_46_12, var_46_11)
					local var_46_14 = var_8.GetChild(var_46_13, var_2_10006)

					setText = var_2_10009
					findTF = var_11

					var_2_10009(var_11(var_46_14, "group/skill_name"), var_0_1.GetRollData(iter_46_1, var_0_2))

					setText = var_2_10009
					findTF = var_11

					var_2_10009(var_11(var_46_14, "group/Text"), var_0_1.GetColorValue(iter_46_1, var_0_1.GetRollData(iter_46_1, var_0_3)))

					findTF = var_2_10009

					local var_46_15 = var_2_10009(var_46_14, "Image")

					var_2_10009 = var_2_10009.GetComponent
					typeof = var_12
					Animation = var_14

					local var_46_16 = var_2_10009(var_46_15, var_12(var_14))

					var_2_10009.Play(var_46_16, "anim_castle_skill")
				end
			end

			local var_46_17 = arg_44_0

			var_0.ExploreStory(var_46_17, arg_44_0.waitPlayStory)

			local var_46_18 = arg_44_0

			var_0.UnlockStory(var_46_18, arg_44_1)

			local var_46_19 = arg_44_0

			var_0.UpdateAttrLock(var_46_19)
		else
			local var_46_20 = arg_44_0

			var_0.ExploreStory(var_46_20, arg_44_0.waitPlayStory)

			local var_46_21 = arg_44_0

			var_0.UnlockStory(var_46_21, arg_44_1)

			local var_46_22 = arg_44_0

			var_0.UpdateAttrLock(var_46_22)

			local var_46_23 = arg_44_0

			var_0.UpdateFlush(var_46_23)

			local var_46_24 = arg_44_0

			var_0.CheckGuide(var_46_24)
		end

		return
	end)

	return
end

function var_0_1.FirstStory(arg_47_0)
	local var_47_0 = arg_47_0.activity
	local var_47_1 = var_1.getConfig(var_47_0, "config_data")[1]
	local var_47_2 = arg_47_0.storyMgr
	local var_47_3, var_47_4 = var_2.StoryId2StoryName(var_47_2, var_47_1)

	playStory = var_47_2

	var_47_2(var_47_3, function()
		local var_48_0 = {
			8,
			59496,
			1
		}
		local var_48_1 = {
			type = var_48_0[1],
			id = var_48_0[2],
			count = var_48_0[3]
		}
		local var_48_2 = arg_47_0

		var_2.UpdateFlush(var_48_2)

		local var_48_3 = arg_47_0
		local var_48_4 = var_2.emit

		BaseUI = var_2_10005

		local var_48_5 = var_2_10005.ON_AWARD
		local var_48_6 = {
			items = {
				var_48_1
			}
		}

		AwardInfoLayer = var_7
		var_48_6.title = var_7.TITLE.ITEM

		function var_48_6.removeFunc()
			local var_49_0 = arg_47_0

			var_0.CheckGuide(var_49_0)

			return
		end

		var_48_4(var_48_3, var_48_5, var_48_6)

		return
	end)

	return
end

function var_0_1.RollDice(arg_50_0, arg_50_1, arg_50_2)
	ipairs = var_1_10003

	for iter_50_0, iter_50_1 in var_1_10003({
		arg_50_0.success,
		arg_50_0.criticalSuccess,
		arg_50_0.failure,
		arg_50_0.criticalFailure
	}) do
		setActive = var_1_10008

		var_1_10008(iter_50_1, false)
	end

	setActive = var_3

	var_3(arg_50_0.diceWindow, true)

	setActive = var_3

	var_3(arg_50_0.buttonDiceContinue, false)
	arg_50_0:ExplorableEffect(false)

	setImageAlpha = var_3

	var_3(arg_50_0.buttonDiceContinue, 0)

	arg_50_0.diceNumber = arg_50_1

	if arg_50_1 == 100 then
		arg_50_1 = 0
	end

	math = var_3

	local var_50_0 = var_3.floor(arg_50_1 / 10)
	local var_50_1 = arg_50_1 % 10

	pg = var_5

	local var_50_2 = var_5.CriMgr.GetInstance()

	var_5.PlaySoundEffect_V3(var_50_2, var_0_1.ROLL_SE)
	arg_50_0:SetAnim(arg_50_0.dices[1], var_50_0, nil)
	arg_50_0:SetAnim(arg_50_0.dices[2], var_50_1, function()
		LeanTween = var_2_10000

		local var_51_0 = var_2_10000.delayedCall

		go = var_2_10002

		local var_51_1 = var_2_10002(arg_50_0._tf)
		local var_51_2 = 0.12

		System = var_4

		var_51_0(var_51_1, var_51_2, var_4.Action(function()
			if arg_50_0.diceNumber <= 5 then
				setActive = var_0

				var_0(arg_50_0.criticalSuccess, true)
			elseif arg_50_0.diceNumber <= 50 then
				setActive = var_0

				var_0(arg_50_0.success, true)
			elseif arg_50_0.diceNumber <= 94 then
				setActive = var_0

				var_0(arg_50_0.failure, true)
			else
				setActive = var_0

				var_0(arg_50_0.criticalFailure, true)
			end

			setActive = var_0

			var_0(arg_50_0.buttonDiceContinue, true)

			LeanTween = var_0

			local var_52_0 = var_0.delayedCall

			go = var_2

			local var_52_1 = var_2(arg_50_0._tf)
			local var_52_2 = 0.495

			System = var_4

			var_52_0(var_52_1, var_52_2, var_4.Action(function()
				LeanTween = var_4_10000

				var_4_10000.alpha(arg_50_0.buttonDiceContinue, 1, 0.26)

				return
			end))

			return
		end))

		return
	end)

	arg_50_0.explorablePos = arg_50_2
	ipairs = var_5

	for iter_50_2, iter_50_3 in var_5(arg_50_0.storyGroup) do
		arg_50_0:UnlockStory(iter_50_3)

		if iter_50_3 == arg_50_2 then
			break
		end
	end

	return
end

function var_0_1.SetAnim(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = arg_54_1
	local var_54_1 = arg_54_1.GetComponent

	typeof = var_1_10007
	SpineAnimUI = var_1_10009

	local var_54_2 = var_54_1(var_54_0, var_1_10007(var_1_10009))

	var_4.SetActionCallBack(var_54_2, nil)
	var_4:SetAction("roll" .. arg_54_2, 0)
	var_4:SetActionCallBack(function(arg_55_0)
		if arg_55_0 == "finish" then
			local var_55_0 = var_0

			var_1.SetActionCallBack(var_55_0, nil)

			local var_55_1 = var_0

			var_1.SetAction(var_55_1, "normal" .. arg_54_2, 0)

			if arg_54_3 then
				arg_54_3()
			end
		end

		return
	end)

	return
end

function var_0_1.UnlockStory(arg_56_0, arg_56_1)
	table = var_1_10002

	if not var_1_10002.contains(arg_56_0.explorableStories, arg_56_1) then
		table = var_2

		if var_2.contains(arg_56_0.exploredStories, arg_56_1) then
			return
		end

		table = var_2

		var_2.insert(arg_56_0.explorableStories, arg_56_1)

		if arg_56_0:IndexofStory(arg_56_1) > arg_56_0:IndexofStory(arg_56_0.explorablePos) then
			arg_56_0.explorablePos = arg_56_1
		end

		return
	end
end

function var_0_1.ExploreStory(arg_57_0, arg_57_1)
	table = var_1_10002

	if var_1_10002.contains(arg_57_0.exploredStories, arg_57_1) then
		return
	end

	table = var_2

	if not var_2.contains(arg_57_0.explorableStories, arg_57_1) then
		return
	end

	table = var_2

	var_2.removebyvalue(arg_57_0.explorableStories, arg_57_1)

	table = var_2

	var_2.insert(arg_57_0.exploredStories, arg_57_1)

	if arg_57_0:IndexofStory(arg_57_1) > arg_57_0:IndexofStory(arg_57_0.currentPos) then
		arg_57_0.currentPos = arg_57_1
	end

	return
end

function var_0_1.IndexofStory(arg_58_0, arg_58_1)
	table = var_1_10002

	if var_1_10002.indexof(arg_58_0.storyGroup, arg_58_1) == false then
		return -1
	end

	return var_2
end

function var_0_1.IsPlayed(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_0.storyMgr
	local var_59_1, var_59_2 = var_2.StoryId2StoryName(var_59_0, arg_59_1)
	local var_59_3 = arg_59_0.storyMgr

	return var_4.IsPlayed(var_59_3, var_59_1, var_59_2)
end

function var_0_1.IsBadEnd(arg_60_0, arg_60_1)
	table = var_1_10002

	return (var_1_10002.indexof(arg_60_0.storyGroup, arg_60_1) + 1) % 3 == 0
end

function var_0_1.ExplorableEffect(arg_61_0, arg_61_1)
	for iter_61_0 = 1, var_0_1.ROOM_NUM do
		local var_61_0 = arg_61_0:GetRoomTF(iter_61_0)

		setActive = var_1_10007
		findTF = var_9

		var_1_10007(var_9(var_61_0, "explorable/glow"), arg_61_1)

		setActive = var_1_10007
		findTF = var_9

		var_1_10007(var_9(var_61_0, "explorable/glow1"), arg_61_1)
	end

	return
end

function var_0_1.ChangeRoomColor(arg_62_0, arg_62_1, arg_62_2)
	local var_62_0 = arg_62_0
	local var_62_1 = arg_62_0.GetRoomTF(var_62_0, arg_62_1)

	findTF = var_1_10004

	local var_62_2 = var_1_10004(var_62_1, "fill")

	if arg_62_2 then
		setImageColor = var_62_0

		var_62_0(var_62_2, arg_62_2)
	end

	return
end

function var_0_1.ChangeRoomMark(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
	cover = var_1_10004

	local var_63_0

	var_63_0 = var_1_10004 or false

	local var_63_1 = cover
	local var_63_2 = arg_63_0
	local var_63_3 = arg_63_0.GetRoomTF(var_63_2, arg_63_1)

	findTF = var_1_10005

	local var_63_4 = var_1_10005(var_63_3, "current")

	findTF = var_63_2

	local var_63_5 = var_63_2(var_63_3, "unexplored")

	findTF = var_7

	local var_63_6 = var_7(var_63_3, "bad")

	findTF = var_8

	local var_63_7 = var_8(var_63_3, "explorable")

	if not arg_63_3 then
		ipairs = var_9

		for iter_63_0, iter_63_1 in var_9({
			var_63_4,
			var_63_5,
			var_63_6,
			var_63_7
		}) do
			setActive = var_1_10014

			var_1_10014(iter_63_1, false)
		end
	end

	if arg_63_2 then
		if arg_63_2 == var_0_1.MARK_CURRENT then
			setActive = var_9

			var_9(var_63_4, true)
		elseif arg_63_2 == var_0_1.MARK_UNEXPLORED then
			setActive = var_9

			var_9(var_63_5, true)
		elseif arg_63_2 == var_0_1.MARK_BAD then
			setActive = var_9

			var_9(var_63_6, true)
		elseif arg_63_2 == var_0_1.MARK_EXPLORABLE then
			setActive = var_9

			var_9(var_63_7, true)
		end
	end

	return
end

function var_0_1.GetRoomTF(arg_64_0, arg_64_1)
	if arg_64_1 == var_0_1.ROOM_NUM then
		local var_64_0 = arg_64_0.rooms[1]

		return var_2.GetChild(var_64_0, arg_64_0.rooms[1].childCount - 1)
	elseif arg_64_1 < arg_64_0.rooms[1].childCount then
		local var_64_1 = arg_64_0.rooms[1]

		return var_2.GetChild(var_64_1, arg_64_1 - 1)
	end

	arg_64_1 = arg_64_1 - arg_64_0.rooms[1].childCount

	local var_64_2 = arg_64_0.rooms[2]

	return var_2.GetChild(var_64_2, arg_64_1)
end

function var_0_1.CheckGuide(arg_65_0)
	pairs = var_1_10001

	local var_65_0 = {
		{
			"guide",
			"Castle000",
			function(arg_66_0)
				return #arg_66_0.exploredStories == 0
			end
		},
		{
			"guide",
			"Castle001",
			function(arg_67_0)
				return #arg_67_0.exploredStories == 1 and arg_67_0:IndexofStory(arg_67_0.explorablePos) <= arg_67_0:IndexofStory(arg_67_0.currentPos)
			end
		}
	}
	local var_65_1 = {
		"story"
	}
	local var_65_2 = arg_65_0.storyMgr
	local var_65_3 = var_5.StoryId2StoryName
	local var_65_4 = arg_65_0.activity

	var_65_1[2] = var_65_3(var_65_2, var_8.getConfig(var_65_4, "config_client")[1][1])
	var_65_1[3] = function(arg_68_0)
		return #arg_68_0.exploredStories == 1 and arg_68_0:IndexofStory(arg_68_0.explorablePos) > arg_68_0:IndexofStory(arg_68_0.currentPos)
	end
	var_65_0[3] = var_65_1

	local var_65_5 = {
		"story"
	}
	local var_65_6 = arg_65_0.storyMgr
	local var_65_7 = var_5.StoryId2StoryName
	local var_65_8 = arg_65_0.activity

	var_65_5[2] = var_65_7(var_65_6, var_8.getConfig(var_65_8, "config_client")[1][2])
	var_65_5[3] = function(arg_69_0)
		return #arg_69_0.exploredStories == 2 and arg_69_0:IndexofStory(arg_69_0.explorablePos) <= arg_69_0:IndexofStory(arg_69_0.currentPos)
	end
	var_65_0[4] = var_65_5
	var_65_0[5] = {
		"guide",
		"Castle002",
		function(arg_70_0)
			return arg_70_0:IndexofStory(arg_70_0.explorablePos) == 15 and arg_70_0:IndexofStory(arg_70_0.explorablePos) > arg_70_0:IndexofStory(arg_70_0.currentPos)
		end
	}

	local var_65_9 = {
		"story"
	}
	local var_65_10 = arg_65_0.storyMgr
	local var_65_11 = var_5.StoryId2StoryName
	local var_65_12 = arg_65_0.activity

	var_65_9[2] = var_65_11(var_65_10, var_8.getConfig(var_65_12, "config_client")[1][3])
	var_65_9[3] = function(arg_71_0)
		getProxy = var_2_10001
		TaskProxy = var_2_10003

		local var_71_0 = var_2_10001(var_2_10003)

		return var_1.isReceiveTasks(var_71_0, arg_71_0.taskGroup)
	end
	var_65_0[6] = var_65_9

	for iter_65_0, iter_65_1 in var_1_10001(var_65_0) do
		unpack = var_1_10006

		local var_65_13, var_65_14

		var_1_10006, var_65_13, var_65_14 = var_1_10006(iter_65_1)

		if not arg_65_0:IsPlayed(var_65_13) and var_65_14(arg_65_0) then
			if var_1_10006 == "guide" then
				pg = var_9

				local var_65_15 = var_9.NewGuideMgr.GetInstance()

				var_9.Play(var_65_15, var_65_13, nil, function()
					local var_72_0 = arg_65_0
					local var_72_1 = var_0.emit

					CastleMainMediator = var_2_10003

					var_72_1(var_72_0, var_2_10003.UPDATE_GUIDE, var_65_13)

					return
				end)
			elseif var_1_10006 == "story" then
				playStory = var_9

				var_9(var_65_13)
			else
				assert = var_9

				var_9(false)
			end

			break
		end
	end

	return
end

function var_0_1.PlaySE(arg_73_0)
	pg = var_1_10001

	local var_73_0 = var_1_10001.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_73_0, arg_73_0)

	return
end

function var_0_1.GetRollData(arg_74_0, arg_74_1)
	pg = var_1_10002

	return var_1_10002.roll_attr[arg_74_0][arg_74_1]
end

function var_0_1.willExit(arg_75_0)
	isActive = var_1_10001

	local var_75_0

	if var_1_10001(arg_75_0.characterWindow) then
		setActive = var_1

		var_1(arg_75_0.characterWindow, false)

		pg = var_1
		var_75_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_75_0, arg_75_0.characterCard, arg_75_0.characterWindowBg)
	end

	LeanTween = var_1

	local var_75_1 = var_1.cancel

	go = var_75_0

	var_75_1(var_75_0(arg_75_0._tf))

	return
end

function var_0_1.onBackPressed(arg_76_0)
	isActive = var_1_10001

	if var_1_10001(arg_76_0.diceWindow) then
		return
	end

	arg_76_0:emit(var_0_1.ON_BACK_PRESSED)

	return
end

return var_0_1
