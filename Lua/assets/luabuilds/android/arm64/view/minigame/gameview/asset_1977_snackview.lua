local SnackView = class("SnackView", import("..BaseMiniGameView"))

SnackView.States_Before = 0
SnackView.States_Memory = 1
SnackView.States_Select = 2
SnackView.States_Finished = 3
SnackView.Ani_Close_2_Open = true
SnackView.Ani_Open_2_Close = false
SnackView.Bubble_Fade_Time = 0.5
SnackView.Order_Num = 3
SnackView.Snack_Num = 9

function SnackView:getUIName()
	return "Snack"
end

function SnackView:init()
	self:initData()
	self:findUI()
	self:initList()
	self:addListener()

	return
end

function SnackView:didEnter()
	self:initTime()
	self:updateSDModel()
	self:setState(SnackView.States_Before)

	return
end

function SnackView:OnGetAwardDone(arg_4_1)
	if arg_4_1.cmd == MiniGameOPCommand.CMD_COMPLETE then
		local var_4_0 = self:GetMGHubData()

		if var_4_0.ultimate == 0 and var_4_0.usedtime >= var_4_0:getConfig("reward_need") then
			pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
				hubid = var_4_0.id,
				cmd = MiniGameOPCommand.CMD_ULTIMATE,
				args1 = {}
			})
		end
	elseif arg_4_1.cmd == MiniGameOPCommand.CMD_ULTIMATE then
		-- block empty
	end

	return
end

function SnackView:OnSendMiniGameOPDone()
	self:updateCount()

	local var_5_0 = getProxy(MiniGameProxy):GetMiniGameData(MiniGameDataCreator.ShrineGameID):GetRuntimeData("count") or 0

	pg.m02:sendNotification(GAME.MODIFY_MINI_GAME_DATA, {
		id = MiniGameDataCreator.ShrineGameID,
		map = {
			count = var_5_0 + 1
		}
	})

	return
end

function SnackView:onBackPressed()
	if self.state == SnackView.States_Before then
		self:emit(SnackView.ON_BACK_PRESSED)

		return
	end

	if self.timer then
		self.timer:Stop()
	end

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("tips_summergame_exit"),
		onYes = function()
			self.countTime = 0

			self.timer:Start()

			return
		end,
		onNo = function()
			self.timer:Start()

			return
		end
	})

	return
end

function SnackView:willExit()
	if self.timer then
		self.timer:Stop()
	end

	if self.prefab and self.model then
		PoolMgr.GetInstance():ReturnSpineChar(self.prefab, self.model)

		self.prefab = nil
		self.model = nil
	end

	return
end

function SnackView:findUI()
	local var_10_0 = self._tf:Find("ForNotch")

	self.backBtn = var_10_0:Find("BackBtn")
	self.helpBtn = var_10_0:Find("HelpBtn")
	self.countText = var_10_0:Find("Count/CountText")

	local var_10_1 = self._tf:Find("GameContent")

	self.startBtn = var_10_1:Find("StartBtn")

	local var_10_2 = var_10_1:Find("Tip")

	self.considerTipTF = var_10_2:Find("ConsiderTip")
	self.considerTimeText = self.considerTipTF:Find("TimeText")
	self.selectTipTF = var_10_2:Find("SelectTip")
	self.selectTimeText = self.selectTipTF:Find("TimeText")
	self.selectedContainer = var_10_1:Find("SelectedContainer")
	self.selectedTpl = var_10_1:Find("SelectedTpl")
	self.selectedContainerCG = GetComponent(self.selectedContainer, "CanvasGroup")
	self.snackContainer = var_10_1:Find("SnackContainer")
	self.animtor = GetComponent(self.snackContainer, "Animator")
	self.dftAniEvent = GetComponent(self.snackContainer, "DftAniEvent")

	self.dftAniEvent:SetEndEvent(function(arg_11_0)
		self:setState(SnackView.States_Select)

		return
	end)

	self.spineCharContainer = var_10_1:Find("SpineChar")

	return
end

function SnackView:initData()
	self.state = nil
	self.orderIDList = {}
	self.selectedIDList = {}
	self.snackIDList = {}
	self.score = 0
	self.packageData = {}
	self.selectedTFList = {}
	self.snackTFList = {}
	self.selectedSnackTFList = {}

	return
end

function SnackView:initTime()
	self.orginMemoryTime = self:GetMGData():getConfig("simple_config_data").memory_time
	self.orginSelectTime = self:GetMGData():getConfig("simple_config_data").select_time
	self.countTime = nil
	self.leftTime = self.orginSelectTime

	return
end

function SnackView:initTimer(arg_14_1)
	if self.state == SnackView.States_Memory then
		self.countTime = self.orginMemoryTime
	elseif self.state == SnackView.States_Select then
		self.countTime = self.leftTime
	end

	self.timer = Timer.New(arg_14_1, 1, -1)

	self.timer:Start()

	return
end

function SnackView:initList()
	for iter_15_0 = 1, SnackView.Order_Num do
		self.selectedTFList[iter_15_0] = self.selectedContainer:GetChild(iter_15_0 - 1)
	end

	for iter_15_1 = 1, SnackView.Snack_Num do
		self.snackTFList[iter_15_1] = self.snackContainer:GetChild(iter_15_1 - 1)
	end

	return
end

function SnackView:addListener()
	onButton(self, self.backBtn, function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_summer_food.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.startBtn, function()
		self:setState(SnackView.States_Memory)

		return
	end, SFX_PANEL)

	for iter_16_0 = 1, SnackView.Snack_Num do
		local var_16_0 = self.snackContainer:GetChild(iter_16_0 - 1)

		onButton(self, var_16_0, function()
			local var_20_0 = var_16_0:Find("SelectedTag")

			if isActive(var_20_0) == true then
				table.removebyvalue(self.selectedIDList, self.snackIDList[iter_16_0])
				self:updateSelectedList(self.selectedIDList)

				self.selectedSnackTFList[self.snackIDList[iter_16_0]] = nil

				setActive(var_20_0, false)
				self:updateSelectedOrderTag()
			else
				table.insert(self.selectedIDList, self.snackIDList[iter_16_0])
				self:updateSelectedList(self.selectedIDList)

				self.selectedSnackTFList[self.snackIDList[iter_16_0]] = var_16_0

				setActive(var_20_0, true)
				self:updateSelectedOrderTag()

				if #self.selectedIDList == SnackView.Order_Num then
					self.timer:Stop()
					self:setState(SnackView.States_Finished)
				end
			end

			return
		end, SFX_PANEL)
	end

	return
end

function SnackView:updateSDModel()
	local var_21_0 = getProxy(BayProxy):getShipById(getProxy(PlayerProxy):getData().character):getPrefab()

	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetSpineChar(var_21_0, true, function(arg_22_0)
		pg.UIMgr.GetInstance():LoadingOff()

		self.prefab = var_21_0
		self.model = arg_22_0
		tf(arg_22_0).localScale = Vector3(1, 1, 1)

		arg_22_0:GetComponent("SpineAnimUI"):SetAction("stand", 0)
		setParent(arg_22_0, self.spineCharContainer)

		return
	end)

	return
end

function SnackView:updateSelectedList(arg_23_1)
	arg_23_1 = arg_23_1 or {}

	for iter_23_0 = 1, SnackView.Order_Num do
		local var_23_0 = self.selectedContainer:GetChild(iter_23_0 - 1)
		local var_23_1 = var_23_0:Find("Empty")
		local var_23_2 = var_23_0:Find("Full")
		local var_23_3 = var_23_2:Find("SnackImg")

		self.selectedTFList[iter_23_0] = var_23_0

		setActive(var_23_2, arg_23_1[iter_23_0])
		setActive(var_23_1, not arg_23_1[iter_23_0])

		if arg_23_1[iter_23_0] then
			setImageSprite(var_23_3, GetSpriteFromAtlas("ui/snackui_atlas", "snack_" .. arg_23_1[iter_23_0]))
		end
	end

	return
end

function SnackView:updateSnackList(arg_24_1)
	for iter_24_0 = 1, SnackView.Snack_Num do
		local var_24_0 = self.snackContainer:GetChild(iter_24_0 - 1)

		setImageSprite(var_24_0:Find("SnackImg"), GetSpriteFromAtlas("ui/snackui_atlas", "snack_" .. arg_24_1[iter_24_0]))
		setActive(var_24_0:Find("SelectedTag"), false)

		self.snackTFList[iter_24_0] = var_24_0
		iter_24_0 = iter_24_0 + 1
	end

	return
end

function SnackView:updateCount()
	setText(self.countText, self:GetMGHubData().count)

	return
end

function SnackView:updateSelectedOrderTag(arg_26_1)
	for iter_26_0, iter_26_1 in pairs(self.selectedSnackTFList) do
		local var_26_0 = iter_26_1:Find("SelectedTag")

		if arg_26_1 then
			setActive(var_26_0, false)
		else
			setImageSprite(var_26_0, GetSpriteFromAtlas("ui/snackui_atlas", "order_" .. table.indexof(self.selectedIDList, iter_26_0, 1)))
		end
	end

	return
end

function SnackView:updateSnackInteractable(arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(self.snackTFList) do
		setButtonEnabled(iter_27_1, arg_27_1)
	end

	return
end

function SnackView:onStateChange()
	if self.state == SnackView.States_Before then
		setActive(self.selectedContainer, false)
		setActive(self.startBtn, true)
		setActive(self.considerTipTF, false)
		setActive(self.selectTipTF, false)
		self:updateCount()
		self:updateSnackInteractable(false)
	elseif self.state == SnackView.States_Memory then
		setActive(self.selectedContainer, true)
		setActive(self.startBtn, false)

		self.orderIDList = self:randFetch(3, 9)

		self:updateSelectedList(self.orderIDList)

		self.snackIDList = self:randFetch(9, 9)

		self:updateSnackList(self.snackIDList)
		self:updateSnackInteractable(false)

		local function var_28_0()
			self.countTime = self.countTime - 1

			setText(self.considerTimeText, self.countTime)

			if self.countTime == 0 then
				self.timer:Stop()
				self.animtor:SetBool("AniSwitch", SnackView.Ani_Close_2_Open)
			end

			return
		end

		LeanTween.value(go(self.selectedContainer), 0, 1, SnackView.Bubble_Fade_Time):setOnUpdate(System.Action_float(function(arg_30_0)
			self.selectedContainerCG.alpha = arg_30_0

			return
		end)):setOnComplete(System.Action(function()
			setActive(self.considerTipTF, true)
			setActive(self.selectTipTF, false)
			self:initTimer(var_28_0)
			setText(self.considerTimeText, self.countTime)

			return
		end))
	elseif self.state == SnackView.States_Select then
		setActive(self.considerTipTF, false)
		setActive(self.selectTipTF, true)
		self:updateSelectedList()
		self:updateSnackInteractable(true)
		self:initTimer(function()
			self.countTime = self.countTime - 1

			setText(self.selectTimeText, self.countTime)

			if self.countTime == 0 then
				self.timer:Stop()
				self:setState(SnackView.States_Finished)
			end

			return
		end)
		setText(self.selectTimeText, self.countTime)
	elseif self.state == SnackView.States_Finished then
		self:updateSnackInteractable(false)
		LeanTween.value(go(self.selectedContainer), 1, 0, SnackView.Bubble_Fade_Time):setOnUpdate(System.Action_float(function(arg_33_0)
			self.selectedContainerCG.alpha = arg_33_0

			return
		end)):setOnComplete(System.Action(function()
			self:openResultView()

			return
		end))
	end

	return
end

function SnackView:openResultView()
	local var_35_0 = {
		orderIDList = self.orderIDList,
		selectedIDList = self.selectedIDList,
		countTime = self.countTime,
		score = self.score
	}

	var_35_0.correctNumToEXValue = self:GetMGData():getConfig("simple_config_data").correct_value
	var_35_0.scoreLevel = self:GetMGData():getConfig("simple_config_data").score_level

	function var_35_0.onSubmit(arg_36_0)
		if self:GetMGHubData().count > 0 then
			self:SendSuccess(arg_36_0)
		end

		self.score = 0
		self.countTime = nil
		self.leftTime = self.orginSelectTime
		self.orderIDList = {}
		self.selectedIDList = {}
		self.snackIDList = {}

		self:updateSelectedOrderTag(true)

		self.selectedSnackTFList = {}

		self.animtor:SetBool("AniSwitch", SnackView.Ani_Open_2_Close)
		self:setState(SnackView.States_Before)

		return
	end

	function var_35_0.onContinue()
		self.score = self.packageData.score
		self.leftTime = self.packageData.countTime
		self.orderIDList = {}
		self.selectedIDList = {}
		self.snackIDList = {}
		self.selectedSnackTFList = {}

		self.animtor:SetBool("AniSwitch", SnackView.Ani_Open_2_Close)
		self:setState(SnackView.States_Memory)

		return
	end

	self.packageData = var_35_0
	self.snackResultView = SnackResultView.New(self._tf, self.event, self.packageData)

	self.snackResultView:Reset()
	self.snackResultView:Load()

	return
end

function SnackView:randFetch(arg_38_1, arg_38_2)
	local var_38_0 = {}
	local var_38_1 = {}

	for iter_38_0 = 1, arg_38_1 do
		local var_38_2 = math.random(iter_38_0, arg_38_2)
		local var_38_3 = var_38_1[var_38_2] or var_38_2

		var_38_1[var_38_2] = var_38_1[iter_38_0] or iter_38_0
		var_38_1[iter_38_0] = var_38_3

		table.insert(var_38_0, var_38_3)
	end

	return var_38_0
end

function SnackView:setState(arg_39_1)
	if self.state == arg_39_1 then
		return
	end

	self.state = arg_39_1

	self:onStateChange()

	return
end

return SnackView
