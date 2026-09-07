local MonopolyCar2026Game = class("MonopolyCar2026Game", import("..MonopolyCar2024.MonopolyCar2024Game"))
local var_0_1 = 1
local var_0_2 = 2

local function var_0_3(arg_1_0)
	local var_1_0 = arg_1_0 and arg_1_0.story

	return (arg_1_0 and arg_1_0.story) ~= nil and var_1_0 ~= "" and var_1_0 ~= "0"
end

local function var_0_4(arg_2_0)
	return pg.activity_monopolycar2026_story_event.all[arg_2_0] and pg.activity_monopolycar2026_story_event[pg.activity_monopolycar2026_story_event.all[arg_2_0]]
end

local function var_0_5(arg_3_0)
	for iter_3_0 = arg_3_0 - 1, 1, -1 do
		local var_3_0 = var_0_4(iter_3_0)

		if var_0_3(var_3_0) then
			return var_3_0
		end
	end

	return
end

local function var_0_6()
	for iter_4_0 = #pg.activity_monopolycar2026_story_event.all, 1, -1 do
		local var_4_0 = var_0_4(iter_4_0)

		if var_0_3(var_4_0) then
			return var_4_0
		end
	end

	return
end

local function var_0_7(arg_5_0)
	local var_5_0 = arg_5_0 and arg_5_0.main_story

	return (arg_5_0 and arg_5_0.main_story) ~= nil and var_5_0 ~= "" and var_5_0 ~= "0"
end

function MonopolyCar2026Game:NewPickPage(arg_6_1, arg_6_2)
	return MonopolyCar2026PickPage.New(arg_6_1, arg_6_2)
end

function MonopolyCar2026Game:NewBubblePage(arg_7_1, arg_7_2)
	return MonopolyCar2026BubblePage.New(arg_7_1:Find("bubble"), arg_7_2)
end

function MonopolyCar2026Game:InitUI()
	MonopolyCar2026Game.super.InitUI(self)

	self.labelLeftCount2 = findTF(self.btnStart, "labelLeftCount/Text_1")
	self.mainModeBtn = findTF(self._tf.parent, "mode/toggles/main")
	self.storyModeBtn = findTF(self._tf.parent, "mode/toggles/story")
	self.storyModeBtnTip = self.storyModeBtn:Find("tip")
	self.btnAutolock = findTF(self.topTr, "btnAuto/lock")

	setText(self.mainModeBtn:Find("Text"), i18n("mono_car_2026_toggle_main"))
	setText(self.mainModeBtn:Find("sel/Text"), i18n("mono_car_2026_toggle_main"))
	setText(self.storyModeBtn:Find("Text"), i18n("mono_car_2026_toggle_story"))
	setText(self.storyModeBtn:Find("sel/Text"), i18n("mono_car_2026_toggle_story"))

	self.storyCnt = findTF(self._tf.parent, "story/award/Text")
	self.storyTpl = findTF(self._tf.parent, "story/mapContainer/tpl")
	self.storyContainer = findTF(self._tf.parent, "story/mapContainer")
	self.storyAward = findTF(self._tf.parent, "story/award/award")
	self.storyAwardGot = findTF(self.storyAward, "icon_mask")
	self.mileageTxt = findTF(self._tf, "mileage/Text")
	self.hideList = {
		self.btnStart,
		self.btnBack,
		self.btnAuto,
		self.register
	}

	return
end

function MonopolyCar2026Game:UpdateAutoBtn()
	MonopolyCar2026Game.super.UpdateAutoBtn(self)
	setActive(self.btnAutolock, not (self.useCount >= 10))

	return
end

function MonopolyCar2026Game:OnEnterDone(arg_10_1)
	if not pg.NewStoryMgr.GetInstance():IsPlayed("BINHAIJISU1") then
		pg.NewStoryMgr.GetInstance():Play("BINHAIJISU1", arg_10_1, true)
	else
		arg_10_1()
	end

	return
end

function MonopolyCar2026Game:InitDone(arg_11_1)
	if not pg.NewStoryMgr.GetInstance():IsPlayed("BINHAIJISU2") then
		pg.NewStoryMgr.GetInstance():Play("BINHAIJISU2", arg_11_1, true)
	else
		arg_11_1()
	end

	return
end

function MonopolyCar2026Game:CheckMainStorys(arg_12_1)
	arg_12_1 = arg_12_1 or function()
		return
	end

	local var_12_0 = pg.activity_monopolycar2026_story_event
	local var_12_1 = pg.NewStoryMgr.GetInstance()
	local var_12_2 = {}
	local var_12_3 = self.turnCnt or 1

	for iter_12_0, iter_12_1 in ipairs(var_12_0.all) do
		if var_12_0[iter_12_1] and iter_12_1 <= var_12_3 - 1 and var_0_7(var_12_0[iter_12_1]) and not var_12_1:IsPlayed(var_12_0[iter_12_1].main_story) then
			table.insert(var_12_2, var_12_0[iter_12_1].main_story)
		end
	end

	if #var_12_2 <= 0 then
		self:PlayStepHideAnim(arg_12_1)

		return
	end

	local var_12_4 = {}

	for iter_12_2, iter_12_3 in ipairs(var_12_2) do
		table.insert(var_12_4, function(arg_14_0)
			if self.autoFlag then
				var_12_1:ForceAutoPlay(iter_12_3, arg_14_0, true, true)
			else
				var_12_1:Play(iter_12_3, arg_14_0, true)
			end

			return
		end)
	end

	seriesAsync(var_12_4, function()
		self:PlayStepHideAnim(arg_12_1)

		return
	end)

	return
end

function MonopolyCar2026Game:PlayStepHideAnim(arg_16_1)
	local var_16_0 = findTF(self.rollStep, "animroot"):GetComponent(typeof(Animation))

	var_16_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		self:SetRollStepAct(false)

		if arg_16_1 then
			arg_16_1()
		end

		return
	end)
	var_16_0:Play("anim_monopolycar_mainui_step_hide")

	return
end

function MonopolyCar2026Game:PlayRollAnimation(arg_18_1, arg_18_2)
	setText(findTF(self.rollStep, "animroot/Image/Text"), "00")

	local var_18_0 = self.btnStart:GetComponent(typeof(Animation))
	local var_18_1 = var_18_0:GetComponent(typeof(DftAniEvent))
	local var_18_2 = findTF(self.rollStep, "animroot"):GetComponent(typeof(Animation))
	local var_18_3 = var_18_2:GetComponent(typeof(DftAniEvent))

	var_18_3:SetTriggerEvent(function()
		setText(findTF(self.rollStep, "animroot/Image/Text"), "0" .. arg_18_1)

		return
	end)
	seriesAsync({
		function(arg_20_0)
			var_18_1:SetEndEvent(function()
				arg_20_0()

				return
			end)
			var_18_0:Play("anim_monopolycar_mainui_btn_hide")

			return
		end,
		function(arg_22_0)
			self:SetRollStepAct(true)
			arg_22_0()

			return
		end,
		function(arg_23_0)
			var_18_3:SetEndEvent(function()
				arg_23_0()

				return
			end)
			var_18_2:Play("anim_monopolycar_mainui_step_0" .. arg_18_1)

			return
		end
	}, function()
		var_18_0:Play("anim_monopolycar_mainui_btn_show")
		arg_18_2()

		return
	end)

	return
end

function MonopolyCar2026Game:InitMap()
	self.mapCells = {}

	for iter_26_0, iter_26_1 in ipairs(pg.activity_monopolycar2026_map_event.all) do
		local var_26_0 = cloneTplTo(self.tplMapCell, self.mapContainer, tostring(pg.activity_monopolycar2026_map_event[iter_26_1].event_id))
		local var_26_1 = Vector3(pg.activity_monopolycar2026_map_event[iter_26_1].pos.x, pg.activity_monopolycar2026_map_event[iter_26_1].pos.y, 0)

		var_26_0.localPosition = var_26_1

		setActive(var_26_0, false)

		local var_26_2 = {
			col = col,
			row = row,
			mapId = pg.activity_monopolycar2026_map_event[iter_26_1].event_id,
			tf = var_26_0,
			icon = pg.activity_event_monopoly_map[pg.activity_monopolycar2026_map_event[iter_26_1].event_id].icon,
			position = var_26_1
		}

		var_26_2.flip = pg.activity_monopolycar2026_map_event[iter_26_1].flip or 0

		table.insert(self.mapCells, var_26_2)
	end

	table.sort(self.mapCells, function(arg_27_0, arg_27_1)
		return arg_27_0.mapId < arg_27_1.mapId
	end)
	self:InitStoryMap()

	return
end

function MonopolyCar2026Game:SetRollStepAct(arg_28_1)
	if not arg_28_1 then
		setText(findTF(self.rollStep, "animroot/Image/Text"), "00")
	end

	setActive(self.rollStep, true)

	return
end

function MonopolyCar2026Game:InitStoryMap()
	self.storyCells = {}

	for iter_29_0, iter_29_1 in ipairs(pg.activity_monopolycar2026_story_event.all) do
		local var_29_0 = pg.activity_monopolycar2026_story_event[iter_29_1]
		local var_29_1 = cloneTplTo(self.storyTpl, self.storyContainer, tostring(iter_29_1))

		var_29_1.localPosition = Vector3(pg.activity_monopolycar2026_story_event[iter_29_1].pos.x, pg.activity_monopolycar2026_story_event[iter_29_1].pos.y, 0)

		local var_29_2 = var_0_3(pg.activity_monopolycar2026_story_event[iter_29_1])

		if var_29_2 then
			onButton(self, var_29_1, function()
				pg.NewStoryMgr.GetInstance():Play(var_29_0.story, nil, true)

				return
			end, SFX_PANEL)
		end

		GetImageSpriteFromAtlasAsync("SquareIcon/" .. pg.ship_skin_template[pg.activity_monopolycar2026_story_event[iter_29_1].icon].prefab, "", (findTF(var_29_1, "Image")))
		setActive(var_29_1, var_29_2)
		table.insert(self.storyCells, var_29_1)
	end

	self:UpdateStoriesUnlock()
	self:UpdateStoryAward()

	return
end

function MonopolyCar2026Game:UpdateStoryAward()
	local var_31_0 = var_0_6()
	local var_31_1 = var_31_0 and pg.NewStoryMgr.GetInstance():StoryName2StoryId(var_31_0.story)
	local var_31_2 = var_31_1 and pg.story_template[var_31_1]
	local var_31_3

	if var_31_1 and pg.story_template[var_31_1] then
		::label_31_0::

		var_31_3 = var_31_2.drop_client and var_31_2.drop_client[1]
	end

	if var_31_3 then
		updateDrop(self.storyAward, {
			type = var_31_3[1],
			id = var_31_3[2],
			count = var_31_3[3]
		})
	end

	return
end

function MonopolyCar2026Game:UpdateStoriesUnlock()
	local var_32_0 = pg.NewStoryMgr.GetInstance()
	local var_32_1 = 0

	for iter_32_0, iter_32_1 in ipairs(self.storyCells) do
		local var_32_2 = false

		if var_0_3((var_0_4(iter_32_0))) then
			var_32_1 = var_32_1 + 1
			var_32_2 = var_32_1 <= self.turnCnt
		end

		if var_32_2 and var_32_1 > 1 then
			local var_32_3 = var_0_5(iter_32_0)

			var_32_2 = not var_32_3 or var_32_0:IsPlayed(var_32_3.story)
		end

		setActive(iter_32_1, var_32_2)
	end

	return
end

function MonopolyCar2026Game:InitCar(arg_33_1)
	self.model = findTF(self.car, "car")
	self.model.transform.localScale = Vector3.one
	self.model.transform.localPosition = Vector3.zero

	self.model.transform:SetParent(self.car, false)

	self.modelIconTf = findTF(self.model, "icon")
	self.modelArrTf = findTF(self.model, "arr")

	if self.modelIconTf then
		self.modelIconBasePos = self.modelIconTf.localPosition
	end

	if self.modelArrTf then
		self.modelArrBaseScale = self.modelArrTf.localScale
	end

	if self.pos then
		self:UpdateCarPos(self.pos, false)
	end

	arg_33_1()

	return
end

function MonopolyCar2026Game:UpdateStory()
	self:UpdateStoriesUnlock()
	self:UpdateStoryUI()

	return
end

function MonopolyCar2026Game:UpdateUI()
	MonopolyCar2026Game.super.UpdateUI(self)
	setText(self.labelLeftCount2, i18n("monopoly2026_left_cnt", self.leftCount))
	setText(self.mileageTxt, self.pos .. "/" .. #self.mapCells .. "KM")
	setText(self.labelLeftCount, self.leftCount)
	setText(self.registerTxt, self.turnCnt)
	self:UpdateStoriesUnlock()
	self:UpdateStoryUI()

	return
end

function MonopolyCar2026Game:UpdateStoryUI()
	local var_36_0 = 0
	local var_36_1 = 0
	local var_36_2 = false
	local var_36_3 = pg.NewStoryMgr.GetInstance()
	local var_36_4 = 0

	for iter_36_0, iter_36_1 in ipairs(pg.activity_monopolycar2026_story_event.all) do
		local var_36_5 = var_0_3(pg.activity_monopolycar2026_story_event[iter_36_1])

		if var_36_5 then
			var_36_4 = var_36_4 + 1
			var_36_0 = var_36_0 + 1
		end

		local var_36_6 = false

		if var_36_5 then
			local var_36_7 = var_36_3:IsPlayed(pg.activity_monopolycar2026_story_event[iter_36_1].story)

			if var_36_7 then
				var_36_1 = var_36_1 + 1
			end

			local var_36_8 = var_36_4 <= self.turnCnt

			if var_36_4 <= self.turnCnt and var_36_4 > 1 then
				local var_36_9 = var_0_5(iter_36_0)

				var_36_8 = not var_36_9 or var_36_3:IsPlayed(var_36_9.story)
			end

			var_36_6 = var_36_8 and not var_36_7
			var_36_2 = var_36_2 or var_36_6
		else
			setActive(self.storyCells[iter_36_0], false)
		end

		setActive(self.storyCells[iter_36_0]:Find("tip"), var_36_6)
	end

	setText(self.storyCnt, i18n("monopoly2026_story_award", var_36_1, var_36_0))
	setActive(self.storyAwardGot, var_36_0 > 0 and var_36_1 == var_36_0)
	setActive(self.storyModeBtnTip, var_36_2)

	return
end

function MonopolyCar2026Game:UpdateCarPos(arg_37_1, arg_37_2)
	if self.model then
		assert(self.mapCells[arg_37_1], arg_37_1)
		self:ApplyModelFlip(self.mapCells[arg_37_1].flip or 0)

		self.car.localPosition = self.mapCells[arg_37_1].position

		self.car:SetAsLastSibling()
	end

	return
end

function MonopolyCar2026Game:ReadyMoveCar(arg_38_1, arg_38_2)
	if not arg_38_1 or #arg_38_1 <= 0 then
		if arg_38_2 then
			arg_38_2()
		end

		return
	end

	local var_38_0 = {}

	for iter_38_0 = 1, #arg_38_1 do
		table.insert(var_38_0, function(arg_39_0)
			self:UpdateCarPos(arg_38_1[iter_38_0], true)
			Timer.New(arg_39_0, 1, 1):Start()

			return
		end)
	end

	seriesAsync(var_38_0, arg_38_2)

	return
end

function MonopolyCar2026Game:ApplyModelFlip(arg_40_1)
	if not self.model then
		return
	end

	if self.modelIconTf and self.modelIconBasePos then
		local var_40_0 = 0

		if arg_40_1 == 1 then
			local var_40_1 = self.modelIconTf:GetComponent(typeof(RectTransform))
			local var_40_2 = self.modelArrTf and self.modelArrTf:GetComponent(typeof(RectTransform))
			local var_40_3

			if var_40_1 then
				var_40_3 = var_40_1.rect.height or 0

				local var_40_4

				if var_40_2 then
					var_40_4 = var_40_2.rect.height or 0
				end
			end

			var_40_0 = var_40_3 + var_40_4
		end

		self.modelIconTf.localPosition = Vector3(self.modelIconBasePos.x, self.modelIconBasePos.y - var_40_0, self.modelIconBasePos.z)
	end

	if self.modelArrTf and self.modelArrBaseScale then
		self.modelArrTf.localScale = Vector3(self.modelArrBaseScale.x, arg_40_1 == 1 and -1 or self.modelArrBaseScale.y, self.modelArrBaseScale.z)
	end

	return
end

function MonopolyCar2026Game:GetCarMoveType(arg_41_1, arg_41_2, arg_41_3)
	return arg_41_3 and stateWalkB or stateStandB, (Vector3(1, 1, 1))
end

function MonopolyCar2026Game:InitCheerLeaders(arg_42_1)
	self.cheerLeaders = {}

	arg_42_1()

	return
end

function MonopolyCar2026Game:RegisterUI()
	MonopolyCar2026Game.super.RegisterUI(self)
	onToggle(self, self.mainModeBtn, function(arg_44_0)
		if arg_44_0 then
			self:SwitchMode(var_0_1)
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.storyModeBtn, function(arg_45_0)
		if arg_45_0 then
			self:SwitchMode(var_0_2)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_monopoly_car2026.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.register, function()
		return
	end, SFX_PANEL)

	return
end

function MonopolyCar2026Game:SwitchMode(arg_48_1)
	self.mode = arg_48_1

	return
end

return MonopolyCar2026Game
