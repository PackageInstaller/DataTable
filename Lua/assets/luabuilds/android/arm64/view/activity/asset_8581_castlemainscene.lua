local CastleMainScene = class("CastleMainScene", import("..base.BaseUI"))

CastleMainScene.optionsPath = {
	"main/top/btn_home"
}

local var_0_1 = "name"
local var_0_2 = "default_value"
local var_0_3 = "random_value"

CastleMainScene.ACT_ID = ActivityConst.CASTLE_ACT_ID
CastleMainScene.AWARD_ACT_ID = ActivityConst.CASTLE_AWARD_ID
CastleMainScene.SKILL_COLOR = {
	"#546190",
	"#835490",
	"#A57D55",
	"#C15348"
}
CastleMainScene.BAD_FILL_COLOR = Color(0.6588235294117647, 0.5019607843137255, 0.4823529411764706, 0.5)
CastleMainScene.NORMAL_FILL_COLOR = Color(1, 1, 1, 0.5)
CastleMainScene.TRANSPARENT_COLOR = Color(1, 1, 1, 0)
CastleMainScene.MARK_CURRENT = "1"
CastleMainScene.MARK_UNEXPLORED = "2"
CastleMainScene.MARK_BAD = "3"
CastleMainScene.MARK_EXPLORABLE = "4"
CastleMainScene.MAP_POS = {
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
CastleMainScene.ROOM_NUM = 17
CastleMainScene.WALK_SE = "event:/ui/castle_walk"
CastleMainScene.ROLL_SE = "event:/ui/caslte_roll"
CastleMainScene.CARD_SE = "event:/ui/huihua1"

function CastleMainScene:getUIName()
	return "CastleMainUI"
end

function CastleMainScene:init()
	self:InitData()
	self:InitTF()
	self:InitAward()
	self:InitCharacter()
	self:InitDice()
	self:InitVX()

	return
end

function CastleMainScene:InitTF()
	self.main = self._tf:Find("main")
	self.map = self.main:Find("map")
	self.floors = {
		self.map:Find("floor1"),
		self.map:Find("floor2")
	}
	self.rooms = {
		self.floors[1]:Find("rooms"),
		self.floors[2]:Find("rooms")
	}
	self.top = self.main:Find("top")
	self.buttonBack = self.top:Find("btn_back")
	self.buttonHelp = self.top:Find("btn_help")
	self.buttonAward = self.top:Find("btn_award")
	self.buttonCharacter = self.top:Find("btn_character")
	self.buttonDice = self.top:Find("btn_dice")
	self.diceRes = self.buttonDice:Find("dice_res")
	self.button1F = self.top:Find("btn_1F")
	self.button2F = self.top:Find("btn_2F")
	self.window = self._tf:Find("window")

	return
end

function CastleMainScene:InitData()
	self.storyMgr = pg.NewStoryMgr.GetInstance()
	self.activity = getProxy(ActivityProxy):getActivityById(CastleMainScene.ACT_ID)
	self.story2Map = {}
	self.map2Story = {}
	self.storyGroup = {}

	for iter_4_0, iter_4_1 in ipairs(self.activity:getConfig("config_data")[3]) do
		table.insert(self.storyGroup, iter_4_1[1][1])
		table.insert(self.storyGroup, iter_4_1[2][2])
		table.insert(self.storyGroup, iter_4_1[2][1])
	end

	for iter_4_2 = 1, CastleMainScene.ROOM_NUM do
		table.insert(self.map2Story, {})
	end

	for iter_4_3 = 1, #self.storyGroup do
		table.insert(self.story2Map, self.storyGroup[iter_4_3], CastleMainScene.MAP_POS[iter_4_3])
		table.insert(self.map2Story[CastleMainScene.MAP_POS[iter_4_3]], self.storyGroup[iter_4_3])
	end

	self.explorableStories = {}
	self.exploredStories = {}

	if self.activity.data1 ~= nil and self.activity.data1 ~= 0 then
		for iter_4_4 = 1, #self.storyGroup do
			table.insert((self:IsPlayed(self.storyGroup[iter_4_4]) or nil) and (self.exploredStories or self.explorableStories), self.storyGroup[iter_4_4])

			if self.storyGroup[iter_4_4] == self.activity.data1 then
				break
			end
		end
	end

	self.explorablePos = self.activity.data1
	self.currentPos = #self.exploredStories == 0 and 0 or self.exploredStories[#self.exploredStories]

	return
end

function CastleMainScene:InitAward()
	self.awardWindow = self.window:Find("award_window")
	self.buttonAwardGet = self.awardWindow:Find("award_bg/btn_get")
	self.awardWindowBg = self.awardWindow:Find("bg")
	self.awardItem = self.awardWindow:Find("award_bg/mask/item")
	self.awardItems = self.awardWindow:Find("award_bg/mask/content")
	self.awardActivity = getProxy(ActivityProxy):getActivityById(CastleMainScene.AWARD_ACT_ID)
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = self.awardActivity:getConfig("config_data")
	self.taskList = UIItemList.New(self.awardItems, self.awardItem)
	self.taskMap = {}

	for iter_5_0 = 1, #self.taskGroup do
		table.insert(self.taskMap, iter_5_0)
	end

	return
end

function CastleMainScene:InitDice()
	self.diceWindow = self.window:Find("dice_window")
	self.buttonDiceContinue = self.diceWindow:Find("btn_continue")
	self.dice = self.diceWindow:Find("dice")
	self.dices = {
		self.dice:Find("dice1"),
		self.dice:Find("dice2")
	}
	self.result = self.diceWindow:Find("result")
	self.success = self.result:Find("success")
	self.criticalSuccess = self.result:Find("critical_success")
	self.failure = self.result:Find("failure")
	self.criticalFailure = self.result:Find("critical_failure")

	return
end

function CastleMainScene:InitCharacter()
	self.characterWindow = self.window:Find("character_window")
	self.characterWindowBg = self.characterWindow:Find("bg")
	self.characterCard = self.characterWindowBg:Find("character_card")
	self.characterName = self.characterCard:Find("title_base/name")
	self.profession = self.characterCard:Find("title_base/profession")
	self.nameInput = self.characterName:Find("InputField")
	self.attrGroup = self.characterCard:Find("title_attr/attrGroup")
	self.skillGroup = self.characterCard:Find("title_skill/skillGroup")
	self.characterTip = self.characterCard:Find("tip")

	setText(self.characterTip, i18n("roll_unlock"))

	self.buttonRandom = self.characterCard:Find("random")
	self.randomLock = self.buttonRandom:Find("lock")
	self.randomText = self.buttonRandom:Find("Image")

	setText(self.characterCard:Find("title_base"), i18n("roll_card_info"))
	setText(self.characterCard:Find("title_attr"), i18n("roll_card_attr"))
	setText(self.characterCard:Find("title_skill"), i18n("roll_card_skill"))

	self.story2Attr = {}

	for iter_7_0, iter_7_1 in ipairs(self.activity:getConfig("config_client")[2]) do
		table.insert(self.story2Attr, iter_7_1[1], iter_7_1[2])
	end

	self.attrLock = {}

	return
end

function CastleMainScene:InitVX()
	for iter_8_0, iter_8_1 in ipairs({
		"success",
		"Csuccess",
		"failure",
		"Cfailure"
	}) do
		local var_8_0 = self.result:GetChild(iter_8_0 - 1)
		local var_8_1 = findTF(var_8_0, iter_8_1)

		setLocalScale(findTF(var_8_0, "VX/glow"), {
			x = var_8_1.rect.width,
			y = var_8_1.rect.height
		})
	end

	return
end

function CastleMainScene:didEnter()
	for iter_9_0 = 1, CastleMainScene.ROOM_NUM do
		local var_9_0 = self:GetRoomTF(iter_9_0)

		setText(findTF(var_9_0, "name"), i18n("roll_room_unexplored"))

		local var_9_1 = findTF(var_9_0, "explorable")

		setImageRaycastTarget(findTF(var_9_0, "fill"), true)
		onButton(self, var_9_0, function()
			for iter_10_0, iter_10_1 in ipairs(self.map2Story[iter_9_0]) do
				if table.contains(self.explorableStories, iter_10_1) then
					self:PlayStory(iter_10_1)

					break
				end
			end

			return
		end, SFX_PANEL)
	end

	if table.contains(self.explorableStories, self.storyGroup[15]) or table.contains(self.exploredStories, self.storyGroup[15]) then
		local var_9_2

		for iter_9_1 = #self.exploredStories, 1, -1 do
			if not self:IsBadEnd(self.exploredStories[iter_9_1]) then
				var_9_2 = self.exploredStories[iter_9_1]

				break
			end
		end

		local var_9_3

		if var_9_2 then
			var_9_3 = self.story2Map[var_9_2] or 0
		end

		local var_9_4 = var_9_3 > 10 and var_9_3 < 17

		setActive(self.floors[1], not (var_9_3 > 10 and var_9_3 < 17))
		setActive(self.floors[2], var_9_4)
		setActive(self.button1F, not var_9_4)
		setActive(self.button2F, var_9_4)
	else
		setActive(self.button1F, false)
		setActive(self.button2F, false)
	end

	self.taskList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			self:UpdateTask(arg_11_1, arg_11_2)
		end

		return
	end)
	self.nameInput:GetComponent(typeof(InputField)).onValueChanged:AddListener(function()
		if not nameValidityCheck(getInputText(self.nameInput), 0, 40, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"ship_renameShip_error_2011",
			"playerinfo_mask_word"
		}) then
			setInputText(self.nameInput, getProxy(PlayerProxy):getData().name)
		end

		return
	end)
	self:InitButton()
	self:UpdateFlush()

	local var_9_5 = self.activity:getConfig("config_data")[1]

	if var_9_5 and not self:IsPlayed(var_9_5) then
		self:emit(CastleMainMediator.CASTLE_ACT_OP, {
			cmd = 3,
			id = CastleMainScene.ACT_ID,
			arg1 = var_9_5
		})
	else
		self:CheckGuide()
	end

	return
end

function CastleMainScene:InitButton()
	onButton(self, self.button1F, function()
		setActive(self.button1F, false)
		setActive(self.button2F, true)
		setActive(self.floors[2], true)
		setActive(self.floors[1], false)

		return
	end, CastleMainScene.WALK_SE)
	onButton(self, self.button2F, function()
		setActive(self.button2F, false)
		setActive(self.button1F, true)
		setActive(self.floors[1], true)
		setActive(self.floors[2], false)

		return
	end, CastleMainScene.WALK_SE)
	onButton(self, self.buttonBack, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.buttonHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("roll_gametip")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.buttonAward, function()
		setActive(self.awardWindow, true)
		self:CheckAwardGet()
		self:ExplorableEffect(false)

		return
	end, SFX_PANEL)
	onButton(self, self.buttonAwardGet, function()
		local var_19_0 = underscore(self.taskGroup):chain():map(function(arg_20_0)
			return self.taskProxy:getTaskVO(arg_20_0)
		end):filter(function(arg_21_0)
			return arg_21_0:getTaskStatus() == 1
		end):value()

		if #var_19_0 > 0 then
			self:emit(CastleMainMediator.ON_TASK_SUBMIT, var_19_0)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.awardWindowBg, function()
		setActive(self.awardWindow, false)
		self:ExplorableEffect(true)

		return
	end, SFX_CANCEL)
	onButton(self, self.buttonCharacter, function()
		self:UpdateCard()
		setActive(self.characterWindow, true)
		pg.UIMgr.GetInstance():BlurPanel(self.characterCard)

		return
	end, SFX_PANEL)
	onButton(self, self.characterWindowBg, function()
		setActive(self.characterWindow, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.characterCard, self.characterWindowBg)
		self:UpdateFlush()
		self:CheckGuide()

		return
	end, SFX_CANCEL)
	onButton(self, self.buttonRandom, function()
		if self:IsFinish() then
			if #getInputText(self.nameInput) == 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("roll_noname"))
			else
				self:RollCharacterCard()
			end
		end

		return
	end, SFX_CANCEL)
	onButton(self, self.buttonDice, function()
		if self.diceCount < 1 then
			if table.contains(self.explorableStories, self.storyGroup[23]) or table.contains(self.explorableStories, self.storyGroup[24]) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("roll_ending_tip1"))
			elseif table.contains(self.exploredStories, self.storyGroup[23]) and table.contains(self.exploredStories, self.storyGroup[24]) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("roll_ending_tip2"))
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("roll_notimes"))
			end

			return
		end

		if self:IndexofStory(self.explorablePos) > self:IndexofStory(self.currentPos) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("roll_tip2"))

			return
		end

		self:emit(CastleMainMediator.CASTLE_ACT_OP, {
			cmd = 1,
			id = CastleMainScene.ACT_ID
		})

		return
	end, SFX_PANEL)
	onButton(self, self.buttonDiceContinue, function()
		setActive(self.diceWindow, false)
		self:UpdateFlush()
		self:CheckGuide()
		self:ExplorableEffect(true)

		return
	end, SFX_PANEL)

	return
end

function CastleMainScene:UpdateFlush()
	self.activity = getProxy(ActivityProxy):getActivityById(CastleMainScene.ACT_ID)
	self.awardActivity = getProxy(ActivityProxy):getActivityById(CastleMainScene.AWARD_ACT_ID)
	self.taskGroup = self.awardActivity:getConfig("config_data")

	self:UpdateDice()
	self:UpdateMap()
	self:UpdateAward()
	self:UpdateCharacter()

	if self:IndexofStory(self.explorablePos) == 15 and self:IndexofStory(self.explorablePos) > self:IndexofStory(self.currentPos) then
		setActive(self.button1F, true)
	end

	setActive(self.buttonDice, not self:IsFinish())

	return
end

function CastleMainScene:UpdateDice()
	self.diceCount = self.activity.data2

	if table.contains(self.explorableStories, self.explorablePos) and self:IsBadEnd(self.explorablePos) then
		self.diceCount = self.diceCount - 1
	end

	setText(self.diceRes, i18n("roll_times_left", self.diceCount))

	if self.explorablePos == self.currentPos and self.diceCount > 0 then
		self.buttonDice:GetComponent(typeof(Animation)):Play("anim_castle_dice_tiploop")
	else
		self.buttonDice:GetComponent(typeof(Animation)):Stop()
	end

	return
end

function CastleMainScene:UpdateMap()
	for iter_30_0 = 1, CastleMainScene.ROOM_NUM do
		self:ChangeRoomColor(iter_30_0, CastleMainScene.TRANSPARENT_COLOR)
		self:ChangeRoomMark(iter_30_0, nil)
	end

	for iter_30_1, iter_30_2 in ipairs(self.exploredStories) do
		setText(findTF(self:GetRoomTF(self.story2Map[iter_30_2]), "name"), i18n("roll_room" .. self.story2Map[iter_30_2]))
	end

	setActive(findTF(self.main, "finish_mask"), false)

	if self:IsFinish() then
		setActive(findTF(self.main, "finish_mask"), true)

		return
	end

	for iter_30_3, iter_30_4 in ipairs(self.exploredStories) do
		if self:IsBadEnd(iter_30_4) then
			if self.story2Map[iter_30_4] ~= 17 then
				if self.story2Map[iter_30_4] ~= 4 then
					self:ChangeRoomColor(self.story2Map[iter_30_4], CastleMainScene.BAD_FILL_COLOR)
				end

				self:ChangeRoomMark(self.story2Map[iter_30_4], CastleMainScene.MARK_BAD)
			end
		else
			self:ChangeRoomColor(self.story2Map[iter_30_4], CastleMainScene.NORMAL_FILL_COLOR)
		end
	end

	for iter_30_5, iter_30_6 in ipairs(self.explorableStories) do
		self:ChangeRoomMark(self.story2Map[iter_30_6], CastleMainScene.MARK_EXPLORABLE)
		self:ChangeRoomMark(self.story2Map[iter_30_6], CastleMainScene.MARK_UNEXPLORED, true)
	end

	if #self.exploredStories > 0 then
		local var_30_0

		for iter_30_7, iter_30_8 in ipairs(self.storyGroup) do
			if not self:IsBadEnd(iter_30_8) and table.contains(self.exploredStories, iter_30_8) then
				var_30_0 = iter_30_8
			end
		end

		self:ChangeRoomMark(self.story2Map[var_30_0], CastleMainScene.MARK_CURRENT, true)
	end

	setActive(self.button1F:Find("Image"), table.contains(self.explorableStories, self.storyGroup[24]))
	setActive(self.button2F:Find("Image"), table.contains(self.explorableStories, self.storyGroup[23]))

	return
end

function CastleMainScene:UpdateAward()
	self:CheckAwardGet()
	table.sort(self.taskMap, function(arg_32_0, arg_32_1)
		local var_32_0 = self.taskProxy:getTaskVO(self.taskGroup[arg_32_0]):getTaskStatus() == 2 and 1 or 0
		local var_32_1 = self.taskProxy:getTaskVO(self.taskGroup[arg_32_1]):getTaskStatus() == 2 and 1 or 0

		if var_32_0 == var_32_1 then
			return arg_32_0 < arg_32_1
		end

		return var_32_0 < var_32_1
	end)
	self.taskList:align(#self.taskGroup)

	local var_31_0 = self.storyMgr:StoryId2StoryName(self.activity:getConfig("config_client")[1][3])

	if not self:IsPlayed(var_31_0) then
		if getProxy(TaskProxy):isReceiveTasks(self.taskGroup) then
			playStory(var_31_0)
		end
	end

	return
end

function CastleMainScene:UpdateCharacter()
	setActive(self.randomLock, not self:IsFinish())
	setActive(self.randomText, self:IsFinish())

	self.nameInput:GetComponent(typeof(InputField)).interactable = self:IsFinish()

	setActive(self.characterName:Find("edit"), self:IsFinish())

	return
end

function CastleMainScene:UpdateTask(arg_34_1, arg_34_2)
	local var_34_0 = arg_34_2:Find("IconTpl")
	local var_34_1 = self.taskProxy:getTaskVO(self.taskGroup[self.taskMap[arg_34_1 + 1]])

	assert(var_34_1, "without this task by id: " .. self.taskGroup[self.taskMap[arg_34_1 + 1]])
	setText(arg_34_2:Find("title"), i18n("roll_reward_word" .. self.taskMap[arg_34_1 + 1]))

	local var_34_2 = var_34_1:getConfig("award_display")[1]
	local var_34_3 = {
		type = var_34_2[1],
		id = var_34_2[2],
		count = var_34_2[3]
	}

	updateDrop(var_34_0, var_34_3)
	onButton(self, var_34_0, function()
		self:emit(BaseUI.ON_DROP, var_34_3)

		return
	end, SFX_PANEL)
	setText(arg_34_2:Find("progress"), i18n("roll_reward_tip", var_34_1:getProgress(), (var_34_1:getConfig("target_num"))))
	setText(arg_34_2:Find("mask/Text"), i18n("roll_reward_got"))
	setActive(arg_34_2:Find("mask"), var_34_1:isReceive())

	return
end

function CastleMainScene:UpdateAttrLock()
	self.attrLock = {}

	for iter_36_0, iter_36_1 in ipairs(self.exploredStories) do
		if self.story2Attr[iter_36_1] ~= nil then
			for iter_36_2, iter_36_3 in ipairs(self.story2Attr[iter_36_1]) do
				table.insert(self.attrLock, iter_36_3)
			end
		end
	end

	return
end

function CastleMainScene:UpdateCard()
	self:UpdateAttrLock()
	setText(self.characterName, CastleMainScene.GetRollData(1, var_0_1) .. ":")
	setInputText(self.nameInput, getProxy(PlayerProxy):getData().name)
	setText(self.profession, CastleMainScene.GetRollData(2, var_0_1) .. ":")
	setText(findTF(self.profession, "Text"), CastleMainScene.GetRollData(2, var_0_2))

	for iter_37_0 = 1, self.attrGroup.childCount do
		local var_37_0 = self.attrGroup:GetChild(iter_37_0 - 1)

		for iter_37_1 = 1, var_37_0.childCount do
			local var_37_1 = var_37_0:GetChild(iter_37_1 - 1)
			local var_37_2 = (iter_37_1 - 1) * self.attrGroup.childCount + iter_37_0 + 2

			setText(findTF(var_37_1, "name"), CastleMainScene.GetRollData((iter_37_1 - 1) * self.attrGroup.childCount + iter_37_0 + 2, var_0_1))
			setText(findTF(var_37_1, "Text"), table.contains(self.attrLock, var_37_2) and CastleMainScene.GetRollData(var_37_2, var_0_2) or "---")
			setActive(findTF(var_37_1, "Text/Image"), not table.contains(self.attrLock, var_37_2))
		end
	end

	for iter_37_2 = 1, self.skillGroup.childCount do
		local var_37_3 = self.skillGroup:GetChild(iter_37_2 - 1)

		for iter_37_3 = 1, var_37_3.childCount do
			local var_37_4 = var_37_3:GetChild(iter_37_3 - 1)
			local var_37_5 = (iter_37_3 - 1) * self.attrGroup.childCount + iter_37_2 + 10

			setText(findTF(var_37_4, "group/skill_name"), table.contains(self.attrLock, (iter_37_3 - 1) * self.attrGroup.childCount + iter_37_2 + 10) and CastleMainScene.GetRollData(var_37_5, var_0_1) or "")
			setText(findTF(var_37_4, "group/Text"), table.contains(self.attrLock, var_37_5) and CastleMainScene.GetColorValue(var_37_5, CastleMainScene.GetRollData(var_37_5, var_0_2)) or "")
			setActive(findTF(var_37_4, "Image"), not table.contains(self.attrLock, var_37_5))
		end
	end

	return
end

function CastleMainScene:RollCharacterCard()
	for iter_38_0 = 1, self.attrGroup.childCount do
		local var_38_0 = self.attrGroup:GetChild(iter_38_0 - 1)

		for iter_38_1 = 1, var_38_0.childCount do
			local var_38_1 = CastleMainScene.GetRollData((iter_38_1 - 1) * self.attrGroup.childCount + iter_38_0 + 2, var_0_3)

			setText(findTF(var_38_0:GetChild(iter_38_1 - 1), "Text"), math.random(var_38_1[1], var_38_1[2]))
		end
	end

	local var_38_2 = CastleMainScene.GetRandomValue(i18n("roll_attr_list"), 8)

	for iter_38_2 = 1, self.skillGroup.childCount do
		local var_38_3 = self.skillGroup:GetChild(iter_38_2 - 1)

		for iter_38_3 = 1, var_38_3.childCount do
			local var_38_4 = var_38_3:GetChild(iter_38_3 - 1)

			setText(findTF(var_38_4, "group/skill_name"), var_38_2[1])
			setText(findTF(var_38_4, "group/Text"), CastleMainScene.GetColorValue((iter_38_3 - 1) * self.attrGroup.childCount + iter_38_2 + 10, CastleMainScene.GetRandomValue(CastleMainScene.GetRollData((iter_38_3 - 1) * self.attrGroup.childCount + iter_38_2 + 10, var_0_3), 1)[1]))
		end
	end

	return
end

function CastleMainScene:IsFinish()
	return #self.exploredStories == 24
end

function CastleMainScene:GetRandomValue(arg_40_1)
	local var_40_0 = {}

	for iter_40_0 = 1, #self do
		table.insert(var_40_0, iter_40_0)
	end

	shuffle(var_40_0)

	local var_40_1 = {}

	for iter_40_1 = 1, arg_40_1 do
		table.insert(var_40_1, self[var_40_0[iter_40_1]])
	end

	return var_40_1
end

function CastleMainScene:GetColorValue(arg_41_1)
	return setColorStr(arg_41_1, CastleMainScene.SKILL_COLOR[table.indexof(CastleMainScene.GetRollData(self, var_0_3), arg_41_1)])
end

function CastleMainScene:CheckAwardGet()
	local var_42_0 = false

	for iter_42_0, iter_42_1 in ipairs(self.taskGroup) do
		if self.taskProxy:getTaskVO(iter_42_1):getTaskStatus() == 1 then
			var_42_0 = true
		end
	end

	setActive(self.buttonAwardGet, var_42_0)
	setActive(findTF(self.buttonAward, "red"), var_42_0)

	return
end

function CastleMainScene:PlayStory(arg_43_1)
	if self:IsPlayed(arg_43_1) then
		return
	end

	self.waitPlayStory = arg_43_1

	self:emit(CastleMainMediator.CASTLE_ACT_OP, {
		cmd = 2,
		id = CastleMainScene.ACT_ID,
		arg1 = arg_43_1
	})

	return
end

function CastleMainScene:StoryActEnd(arg_44_1)
	if not self.waitPlayStory then
		return
	end

	local var_44_0, var_44_1 = self.storyMgr:StoryId2StoryName(self.waitPlayStory)

	local function var_44_2()
		if self.story2Attr[self.waitPlayStory] == nil then
			return false
		end

		local var_45_0 = 0

		for iter_45_0, iter_45_1 in ipairs(self.story2Attr[self.waitPlayStory]) do
			if not table.contains(self.attrLock, iter_45_1) then
				var_45_0 = var_45_0 + 1
			end
		end

		return var_45_0 > 0
	end

	playStory(var_44_0, function()
		if var_44_2() then
			self:UpdateCard()
			setActive(self.characterWindow, true)
			pg.UIMgr.GetInstance():BlurPanel(self.characterCard)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(CastleMainScene.CARD_SE)

			for iter_46_0, iter_46_1 in ipairs(self.story2Attr[self.waitPlayStory]) do
				if iter_46_1 < 11 then
					local var_46_0 = self.attrGroup:GetChild((iter_46_1 - 3) % self.attrGroup.childCount):GetChild((math.floor((iter_46_1 - 3) / self.attrGroup.childCount)))

					setText(findTF(var_46_0, "Text"), CastleMainScene.GetRollData(iter_46_1, var_0_2))
					findTF(var_46_0, "Text/Image"):GetComponent(typeof(Animation)):Play("anim_castle_skill")
				else
					local var_46_1 = self.skillGroup:GetChild((iter_46_1 - 11) % self.skillGroup.childCount):GetChild((math.floor((iter_46_1 - 11) / self.skillGroup.childCount)))

					setText(findTF(var_46_1, "group/skill_name"), CastleMainScene.GetRollData(iter_46_1, var_0_1))
					setText(findTF(var_46_1, "group/Text"), CastleMainScene.GetColorValue(iter_46_1, CastleMainScene.GetRollData(iter_46_1, var_0_2)))
					findTF(var_46_1, "Image"):GetComponent(typeof(Animation)):Play("anim_castle_skill")
				end
			end

			self:ExploreStory(self.waitPlayStory)
			self:UnlockStory(arg_44_1)
			self:UpdateAttrLock()
		else
			self:ExploreStory(self.waitPlayStory)
			self:UnlockStory(arg_44_1)
			self:UpdateAttrLock()
			self:UpdateFlush()
			self:CheckGuide()
		end

		return
	end)

	return
end

function CastleMainScene:FirstStory()
	local var_47_0, var_47_1 = self.storyMgr:StoryId2StoryName(self.activity:getConfig("config_data")[1])

	playStory(var_47_0, function()
		local var_48_0 = {
			8,
			59496,
			1
		}

		self:UpdateFlush()
		self:emit(BaseUI.ON_AWARD, {
			items = {
				{
					type = var_48_0[1],
					id = var_48_0[2],
					count = var_48_0[3]
				}
			},
			title = AwardInfoLayer.TITLE.ITEM,
			removeFunc = function()
				self:CheckGuide()

				return
			end
		})

		return
	end)

	return
end

function CastleMainScene:RollDice(arg_50_1, arg_50_2)
	for iter_50_0, iter_50_1 in ipairs({
		self.success,
		self.criticalSuccess,
		self.failure,
		self.criticalFailure
	}) do
		setActive(iter_50_1, false)
	end

	setActive(self.diceWindow, true)
	setActive(self.buttonDiceContinue, false)
	self:ExplorableEffect(false)
	setImageAlpha(self.buttonDiceContinue, 0)

	self.diceNumber = arg_50_1

	if arg_50_1 == 100 then
		arg_50_1 = 0
	end

	local var_50_0 = math.floor(arg_50_1 / 10)

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(CastleMainScene.ROLL_SE)
	self:SetAnim(self.dices[1], var_50_0, nil)
	self:SetAnim(self.dices[2], arg_50_1 % 10, function()
		LeanTween.delayedCall(go(self._tf), 0.12, System.Action(function()
			if self.diceNumber <= 5 then
				setActive(self.criticalSuccess, true)
			elseif self.diceNumber <= 50 then
				setActive(self.success, true)
			elseif self.diceNumber <= 94 then
				setActive(self.failure, true)
			else
				setActive(self.criticalFailure, true)
			end

			setActive(self.buttonDiceContinue, true)
			LeanTween.delayedCall(go(self._tf), 0.495, System.Action(function()
				LeanTween.alpha(self.buttonDiceContinue, 1, 0.26)

				return
			end))

			return
		end))

		return
	end)

	self.explorablePos = arg_50_2

	for iter_50_2, iter_50_3 in ipairs(self.storyGroup) do
		self:UnlockStory(iter_50_3)

		if iter_50_3 == arg_50_2 then
			break
		end
	end

	return
end

function CastleMainScene:SetAnim(arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = arg_54_1:GetComponent(typeof(SpineAnimUI))

	var_54_0:SetActionCallBack(nil)
	var_54_0:SetAction("roll" .. arg_54_2, 0)
	var_54_0:SetActionCallBack(function(arg_55_0)
		if arg_55_0 == "finish" then
			var_54_0:SetActionCallBack(nil)
			var_54_0:SetAction("normal" .. arg_54_2, 0)

			if arg_54_3 then
				arg_54_3()
			end
		end

		return
	end)

	return
end

function CastleMainScene:UnlockStory(arg_56_1)
	if table.contains(self.explorableStories, arg_56_1) or table.contains(self.exploredStories, arg_56_1) then
		return
	end

	table.insert(self.explorableStories, arg_56_1)

	if self:IndexofStory(arg_56_1) > self:IndexofStory(self.explorablePos) then
		self.explorablePos = arg_56_1
	end

	return
end

function CastleMainScene:ExploreStory(arg_57_1)
	if table.contains(self.exploredStories, arg_57_1) then
		return
	end

	if not table.contains(self.explorableStories, arg_57_1) then
		return
	end

	table.removebyvalue(self.explorableStories, arg_57_1)
	table.insert(self.exploredStories, arg_57_1)

	if self:IndexofStory(arg_57_1) > self:IndexofStory(self.currentPos) then
		self.currentPos = arg_57_1
	end

	return
end

function CastleMainScene:IndexofStory(arg_58_1)
	local var_58_0 = table.indexof(self.storyGroup, arg_58_1)

	if var_58_0 == false then
		return -1
	end

	return var_58_0
end

function CastleMainScene:IsPlayed(arg_59_1)
	local var_59_0, var_59_1 = self.storyMgr:StoryId2StoryName(arg_59_1)

	return self.storyMgr:IsPlayed(var_59_0, var_59_1)
end

function CastleMainScene:IsBadEnd(arg_60_1)
	return (table.indexof(self.storyGroup, arg_60_1) + 1) % 3 == 0
end

function CastleMainScene:ExplorableEffect(arg_61_1)
	for iter_61_0 = 1, CastleMainScene.ROOM_NUM do
		local var_61_0 = self:GetRoomTF(iter_61_0)

		setActive(findTF(var_61_0, "explorable/glow"), arg_61_1)
		setActive(findTF(var_61_0, "explorable/glow1"), arg_61_1)
	end

	return
end

function CastleMainScene:ChangeRoomColor(arg_62_1, arg_62_2)
	if arg_62_2 then
		setImageColor(findTF(self:GetRoomTF(arg_62_1), "fill"), arg_62_2)
	end

	return
end

function CastleMainScene:ChangeRoomMark(arg_63_1, arg_63_2, arg_63_3)
	cover = cover or false

	local var_63_0 = self:GetRoomTF(arg_63_1)
	local var_63_1 = findTF(var_63_0, "current")
	local var_63_2 = findTF(var_63_0, "unexplored")
	local var_63_3 = findTF(var_63_0, "bad")
	local var_63_4 = findTF(var_63_0, "explorable")

	if not arg_63_3 then
		for iter_63_0, iter_63_1 in ipairs({
			var_63_1,
			var_63_2,
			var_63_3,
			var_63_4
		}) do
			setActive(iter_63_1, false)
		end
	end

	if arg_63_2 then
		if arg_63_2 == CastleMainScene.MARK_CURRENT then
			setActive(var_63_1, true)
		elseif arg_63_2 == CastleMainScene.MARK_UNEXPLORED then
			setActive(var_63_2, true)
		elseif arg_63_2 == CastleMainScene.MARK_BAD then
			setActive(var_63_3, true)
		elseif arg_63_2 == CastleMainScene.MARK_EXPLORABLE then
			setActive(var_63_4, true)
		end
	end

	return
end

function CastleMainScene:GetRoomTF(arg_64_1)
	if arg_64_1 == CastleMainScene.ROOM_NUM then
		return self.rooms[1]:GetChild(self.rooms[1].childCount - 1)
	elseif arg_64_1 < self.rooms[1].childCount then
		return self.rooms[1]:GetChild(arg_64_1 - 1)
	end

	arg_64_1 = arg_64_1 - self.rooms[1].childCount

	return self.rooms[2]:GetChild(arg_64_1)
end

function CastleMainScene:CheckGuide()
	for iter_65_0, iter_65_1 in pairs({
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
		},
		{
			"story",
			self.storyMgr:StoryId2StoryName(self.activity:getConfig("config_client")[1][1]),
			function(arg_68_0)
				return #arg_68_0.exploredStories == 1 and arg_68_0:IndexofStory(arg_68_0.explorablePos) > arg_68_0:IndexofStory(arg_68_0.currentPos)
			end
		},
		{
			"story",
			self.storyMgr:StoryId2StoryName(self.activity:getConfig("config_client")[1][2]),
			function(arg_69_0)
				return #arg_69_0.exploredStories == 2 and arg_69_0:IndexofStory(arg_69_0.explorablePos) <= arg_69_0:IndexofStory(arg_69_0.currentPos)
			end
		},
		{
			"guide",
			"Castle002",
			function(arg_70_0)
				return arg_70_0:IndexofStory(arg_70_0.explorablePos) == 15 and arg_70_0:IndexofStory(arg_70_0.explorablePos) > arg_70_0:IndexofStory(arg_70_0.currentPos)
			end
		},
		{
			"story",
			self.storyMgr:StoryId2StoryName(self.activity:getConfig("config_client")[1][3]),
			function(arg_71_0)
				return getProxy(TaskProxy):isReceiveTasks(arg_71_0.taskGroup)
			end
		}
	}) do
		local var_65_0, var_65_1, var_65_2 = unpack(iter_65_1)

		if not self:IsPlayed(var_65_1) and var_65_2(self) then
			if var_65_0 == "guide" then
				pg.NewGuideMgr.GetInstance():Play(var_65_1, nil, function()
					self:emit(CastleMainMediator.UPDATE_GUIDE, var_65_1)

					return
				end)
			elseif var_65_0 == "story" then
				playStory(var_65_1)
			else
				assert(false)
			end

			break
		end
	end

	return
end

function CastleMainScene:PlaySE()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(self)

	return
end

function CastleMainScene:GetRollData(arg_74_1)
	return pg.roll_attr[self][arg_74_1]
end

function CastleMainScene:willExit()
	if isActive(self.characterWindow) then
		setActive(self.characterWindow, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.characterCard, self.characterWindowBg)
	end

	LeanTween.cancel(go(self._tf))

	return
end

function CastleMainScene:onBackPressed()
	if isActive(self.diceWindow) then
		return
	end

	self:emit(CastleMainScene.ON_BACK_PRESSED)

	return
end

return CastleMainScene
