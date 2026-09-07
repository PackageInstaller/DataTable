local SenrankaguraTrainScene = class("SenrankaguraTrainScene", import("..base.BaseUI"))

SenrankaguraTrainScene.optionsPath = {
	"top/btn_home"
}
SenrankaguraTrainScene.ACT_ID = ActivityConst.SENRANKAGURA_TRAIN_ACT_ID
SenrankaguraTrainScene.SCROLL_OFFSET = 4.13
SenrankaguraTrainScene.DIALOG_TIME = 0.5
SenrankaguraTrainScene.DEFAULT_DIALOG_TIME = 4

function SenrankaguraTrainScene:getUIName()
	return "SenrankaguraTrainUI"
end

function SenrankaguraTrainScene:init()
	self:InitData()
	self:InitTF()

	return
end

function SenrankaguraTrainScene:InitTF()
	self.top = self._tf:Find("top")
	self.buttonAward = self.top:Find("btn_award")
	self.buttonBack = self.top:Find("btn_back")
	self.buttonHelp = self.top:Find("btn_help")
	self.ptText = self.top:Find("pt/Text")
	self.main = self._tf:Find("main")
	self.tachie = self.main:Find("group_left/group/tachie")
	self.dialog = self.main:Find("group_left/group/dialog")
	self.attrGroup = self.main:Find("attr")
	self.scroll = self.main:Find("scroll")
	self.window = self._tf:Find("window")
	self.levelWindow = self.window:Find("level_window")
	self.levelPtText = self.levelWindow:Find("pt/Text")
	self.levelBg = self.levelWindow:Find("bg")
	self.levelWindowConfirmButton = self.levelBg:Find("btn_confirm")
	self.levelWindowCancelButton = self.levelBg:Find("btn_cancel")
	self.levelTip = self.levelBg:Find("tip")
	self.levelAttrGroup = self.levelBg:Find("attr")
	self.awardWindow = self.window:Find("award_window")
	self.awardContent = self.awardWindow:Find("bg/mask/content")
	self.awardItem = self.awardWindow:Find("bg/mask/item")
	self.showWindow = self.window:Find("show_window")
	self.showSkipButton = self.showWindow:Find("bg/btn_skip")
	self.spine = self.showWindow:Find("bg/spine")
	self.testLevel = self.top:Find("testlevel")
	self.testAward = self.top:Find("testaward")

	return
end

function SenrankaguraTrainScene:InitData()
	self.activity = getProxy(ActivityProxy):getActivityById(SenrankaguraTrainScene.ACT_ID)
	self.ptCount = self.activity.data1
	self.attrLevel = self.activity.data1_list
	self.awardGotList = self.activity.data2_list
	self.ptDemand = pg.activity_event_pt_consume[1].target
	self.rewardList = pg.activity_event_pt_consume[1].reward_display
	self.showList = self.activity:getConfig("config_client").show_list
	self.wordsKey = self.activity:getConfig("config_client").words_key
	self.standAnim = self.activity:getConfig("config_client").stand_anim

	return
end

function SenrankaguraTrainScene:InitButton()
	for iter_5_0 = 1, self.attrGroup.childCount do
		onButton(self, self.attrGroup:GetChild(iter_5_0 - 1), function()
			if self.attrLevel[iter_5_0] > 1 then
				return
			end

			self.currentAttr = iter_5_0

			setActive(self.levelWindow, true)
			eachChild(self.levelAttrGroup, function(arg_7_0)
				setActive(arg_7_0, false)

				return
			end)
			setActive(self.levelAttrGroup:GetChild(iter_5_0 - 1), true)
			setText(self.levelTip, i18n("senran_pt_consume_tip", self.ptDemand[iter_5_0][self.attrLevel[iter_5_0] + 1], self.attrLevel[iter_5_0] + 1))

			return
		end, SFX_PANEL)
	end

	onButton(self, self.levelWindowConfirmButton, function()
		local var_8_0 = self.ptDemand[self.currentAttr][self.attrLevel[self.currentAttr] + 1]

		if var_8_0 > self.ptCount then
			pg.TipsMgr.GetInstance():ShowTips(i18n("senran_pt_not_enough"))
		else
			self:emit(SenrankaguraTrainMediator.LEVEL_UP, {
				cmd = 2,
				id = SenrankaguraTrainScene.ACT_ID,
				arg1 = self.currentAttr,
				cost = var_8_0,
				arg_list = {
					self.lvTotal + 1
				}
			})
		end

		return
	end, SFX_PANEL)
	onButton(self, self.levelWindowCancelButton, function()
		setActive(self.levelWindow, false)

		return
	end, SFX_CANCEL)
	onButton(self, self.buttonBack, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.buttonHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("senran_pt_help")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.buttonAward, function()
		local var_12_0 = 0

		for iter_12_0 = 1, #self.rewardList do
			if not table.contains(self.awardGotList, iter_12_0) then
				var_12_0 = iter_12_0 - 1

				break
			end
		end

		if var_12_0 ~= 0 then
			scrollTo(self.awardContent, nil, 1 - var_12_0 / (#self.rewardList - SenrankaguraTrainScene.SCROLL_OFFSET))
		end

		setActive(self.awardWindow, true)

		return
	end, SFX_PANEL)
	onButton(self, findTF(self.awardWindow, "black"), function()
		setActive(self.awardWindow, false)

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.levelWindow, "black"), function()
		setActive(self.levelWindow, false)

		return
	end, SFX_CANCEL)
	onButton(self, self.showSkipButton, function()
		setActive(self.showWindow, false)
		self:GetAward(self.awardList)

		return
	end, SFX_CANCEL)

	for iter_5_1 = 1, self.tachie.childCount do
		local var_5_0 = self.tachie:GetChild(iter_5_1 - 1)

		onButton(self, var_5_0, function()
			if not self.tachieClickable then
				return
			end

			self:ShowDialog(math.random(2, 4), function()
				self.tachieClickable = false

				return
			end)

			return
		end, SFX_PANEL)
		setActive(var_5_0, false)

		if PLATFORM_CODE ~= PLATFORM_CH then
			local var_5_1 = findTF(var_5_0, "Image")

			if var_5_1 then
				setActive(var_5_1, false)
			end
		end
	end

	return
end

function SenrankaguraTrainScene:didEnter()
	self:InitButton()

	self.taskList = UIItemList.New(self.awardContent, self.awardItem)

	self.taskList:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			self:UpdateTask(arg_19_1, arg_19_2)
		end

		return
	end)

	local var_18_0 = math.random(self.tachie.childCount)

	setActive(self.tachie:GetChild(var_18_0 - 1), true)

	self.wordsGroup = pg.gametip[self.wordsKey[var_18_0]].tip

	local var_18_1 = {}

	for iter_18_0 = 1, #self.standAnim do
		table.insert(var_18_1, iter_18_0)
	end

	shuffle(var_18_1)

	for iter_18_1 = 1, self.scroll.childCount do
		PoolMgr.GetInstance():GetSpineChar(self.standAnim[var_18_1[iter_18_1]], false, function(arg_20_0)
			arg_20_0.transform.localScale = Vector3.one

			arg_20_0.transform:SetParent(self.scroll:GetChild(iter_18_1 - 1), false)
			arg_20_0:GetComponent(typeof(SpineAnimUI)):SetAction("stand2", 0)

			return
		end)
	end

	self:ShowDialog(1, function()
		self.tachieClickable = false

		return
	end)
	self:UpdateFlush()

	return
end

function SenrankaguraTrainScene:UpdateTask(arg_22_1, arg_22_2)
	arg_22_1 = arg_22_1 + 1

	local var_22_0 = arg_22_2:Find("IconTpl")

	setText(findTF(arg_22_2, "title"), "PHASE" .. arg_22_1)

	local var_22_1 = {
		type = self.rewardList[arg_22_1][1],
		id = self.rewardList[arg_22_1][2],
		count = self.rewardList[arg_22_1][3]
	}

	updateDrop(var_22_0, var_22_1)
	onButton(self, var_22_0, function()
		self:emit(BaseUI.ON_DROP, var_22_1)

		return
	end, SFX_PANEL)
	setText(arg_22_2:Find("progress"), i18n("senran_pt_rank", arg_22_1))
	setActive(arg_22_2:Find("mask"), (table.contains(self.awardGotList, arg_22_1)))

	return
end

function SenrankaguraTrainScene:ShowDialog(arg_24_1, arg_24_2)
	self.LTList = {}

	if arg_24_2 then
		arg_24_2()
	end

	local var_24_0 = "event:/cv/" .. self.wordsGroup[arg_24_1][1]

	setText(findTF(self.dialog, "Text"), self.wordsGroup[arg_24_1][2])
	setLocalScale(self.dialog, {
		z = 0,
		x = 0,
		y = 0
	})
	table.insert(self.LTList, LeanTween.scale(self.dialog, Vector3.New(1, 1, 1), SenrankaguraTrainScene.DIALOG_TIME):setEase(LeanTweenType.easeOutSine).uniqueId)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_24_0, function(arg_25_0)
		self.playSoundInfo = arg_25_0

		table.insert(self.LTList, LeanTween.delayedCall(go(self.dialog), (arg_25_0 or nil) and arg_25_0:GetLength() * 0.001 - SenrankaguraTrainScene.DIALOG_TIME, System.Action(function()
			self:HideDialog()

			return
		end)).uniqueId)

		return
	end)

	return
end

function SenrankaguraTrainScene:HideDialog()
	table.insert(self.LTList, LeanTween.scale(self.dialog, Vector3.New(0, 0, 0), SenrankaguraTrainScene.DIALOG_TIME):setEase(LeanTweenType.easeOutSine):setOnComplete(System.Action(function()
		self.tachieClickable = true

		return
	end)).uniqueId)

	return
end

function SenrankaguraTrainScene:LevelUp(arg_29_1)
	self.awardList = arg_29_1

	setActive(self.levelWindow, false)
	setActive(self.showWindow, true)
	self:UpdateFlush()
	self:SetAnim(self.spine, self.showList[self.currentAttr][self.attrLevel[self.currentAttr]], function()
		setActive(self.showWindow, false)
		self:GetAward(arg_29_1)

		return
	end)

	return
end

function SenrankaguraTrainScene:GetAward(arg_31_1)
	self:emit(BaseUI.ON_ACHIEVE, arg_31_1, function()
		self.awardList = nil

		self:ShowDialog(5, function()
			self.tachieClickable = false

			if self.playSoundInfo and self.playSoundInfo.channelPlayer ~= nil then
				pg.CriMgr.GetInstance():StopPlaybackInfoForce(self.playSoundInfo)
			end

			for iter_33_0, iter_33_1 in pairs(self.LTList) do
				LeanTween.cancel(iter_33_1)
			end

			return
		end)

		return
	end)
	self:UpdateFlush()

	return
end

function SenrankaguraTrainScene:UpdateFlush()
	self.activity = getProxy(ActivityProxy):getActivityById(SenrankaguraTrainScene.ACT_ID)
	self.ptCount = self.activity.data1
	self.attrLevel = self.activity.data1_list
	self.awardGotList = self.activity.data2_list
	self.lvTotal = 0

	for iter_34_0, iter_34_1 in pairs(self.attrLevel) do
		self.lvTotal = self.lvTotal + iter_34_1
	end

	setText(self.ptText, self.ptCount)
	setText(self.levelPtText, self.ptCount)

	local function var_34_0(arg_35_0, arg_35_1)
		for iter_35_0 = 1, arg_35_0.childCount do
			local var_35_0 = arg_35_0:GetChild(iter_35_0 - 1)

			eachChild(var_35_0, function(arg_36_0)
				setActive(arg_36_0, false)

				return
			end)
			setActive(var_35_0:GetChild(self.attrLevel[iter_35_0]), true)

			if arg_35_1 and self.attrLevel[iter_35_0] < 2 and self.ptDemand[iter_35_0][self.attrLevel[iter_35_0] + 1] <= self.ptCount then
				setActive(findTF(var_35_0, "red"), true)
			end
		end

		return
	end

	var_34_0(self.attrGroup, true)
	var_34_0(self.levelAttrGroup, false)
	self.taskList:align(#self.rewardList)

	return
end

function SenrankaguraTrainScene:SetAnim(arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = arg_37_1:GetComponent(typeof(SpineAnimUI))

	var_37_0:SetActionCallBack(nil)
	var_37_0:SetAction(arg_37_2, 0)
	var_37_0:SetActionCallBack(function(arg_38_0)
		if arg_38_0 == "finish" then
			var_37_0:SetActionCallBack(nil)

			if arg_37_3 then
				arg_37_3()
			end
		end

		return
	end)

	return
end

function SenrankaguraTrainScene:willExit()
	for iter_39_0, iter_39_1 in pairs(self.LTList) do
		LeanTween.cancel(iter_39_1)
	end

	return
end

function SenrankaguraTrainScene.IsShowRed()
	local var_40_0 = getProxy(ActivityProxy):getActivityById(SenrankaguraTrainScene.ACT_ID)

	for iter_40_0, iter_40_1 in pairs(var_40_0.data1_list) do
		if iter_40_1 < 2 and var_40_0.data1 >= pg.activity_event_pt_consume[1].target[iter_40_0][iter_40_1 + 1] then
			return true
		end
	end

	return false
end

return SenrankaguraTrainScene
