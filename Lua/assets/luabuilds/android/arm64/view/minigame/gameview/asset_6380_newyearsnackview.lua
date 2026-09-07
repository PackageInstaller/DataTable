local NewYearSnackView = class("NewYearSnackView", import(".SnackView"))

function NewYearSnackView:getUIName()
	return "NewYearSnack"
end

function NewYearSnackView:OnSendMiniGameOPDone()
	self:updateCount()

	return
end

function NewYearSnackView:addListener()
	NewYearSnackView.super.addListener(self)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_xinnian2021__meishi.tip
		})

		return
	end, SFX_PANEL)

	return
end

function NewYearSnackView:updateSDModel()
	local var_5_0 = getProxy(PlayerProxy):getData()
	local var_5_1 = getProxy(BayProxy)
	local var_5_2 = "Z28"

	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetSpineChar("Z28", true, function(arg_6_0)
		pg.UIMgr.GetInstance():LoadingOff()

		self.prefab = var_5_2
		self.model = arg_6_0
		tf(arg_6_0).localScale = Vector3(1, 1, 1)

		arg_6_0:GetComponent("SpineAnimUI"):SetAction("stand2", 0)
		setParent(arg_6_0, self.spineCharContainer)

		return
	end)

	return
end

function NewYearSnackView:updateSelectedList(arg_7_1)
	arg_7_1 = arg_7_1 or {}

	for iter_7_0 = 1, NewYearSnackView.Order_Num do
		local var_7_0 = self.selectedContainer:GetChild(iter_7_0 - 1)
		local var_7_1 = var_7_0:Find("Empty")
		local var_7_2 = var_7_0:Find("Full")
		local var_7_3 = var_7_2:Find("SnackImg")

		self.selectedTFList[iter_7_0] = var_7_0

		setActive(var_7_2, arg_7_1[iter_7_0])
		setActive(var_7_1, not arg_7_1[iter_7_0])

		if arg_7_1[iter_7_0] then
			setImageSprite(var_7_3, GetSpriteFromAtlas("ui/minigameui/newyearsnackui_atlas", "snack_" .. arg_7_1[iter_7_0]))
		end
	end

	return
end

function NewYearSnackView:updateSnackList(arg_8_1)
	for iter_8_0 = 1, NewYearSnackView.Snack_Num do
		local var_8_0 = self.snackContainer:GetChild(iter_8_0 - 1)

		setImageSprite(var_8_0:Find("SnackImg"), GetSpriteFromAtlas("ui/minigameui/newyearsnackui_atlas", "snack_" .. arg_8_1[iter_8_0]))
		setActive(var_8_0:Find("SelectedTag"), false)

		self.snackTFList[iter_8_0] = var_8_0
		iter_8_0 = iter_8_0 + 1
	end

	return
end

function NewYearSnackView:updateSelectedOrderTag(arg_9_1)
	for iter_9_0, iter_9_1 in pairs(self.selectedSnackTFList) do
		local var_9_0 = iter_9_1:Find("SelectedTag")

		if arg_9_1 then
			setActive(var_9_0, false)
		else
			setImageSprite(var_9_0, GetSpriteFromAtlas("ui/minigameui/newyearsnackui_atlas", "order_" .. table.indexof(self.selectedIDList, iter_9_0, 1)))
		end
	end

	return
end

function NewYearSnackView:openResultView()
	local var_10_0 = {
		orderIDList = self.orderIDList,
		selectedIDList = self.selectedIDList,
		countTime = self.countTime,
		score = self.score
	}

	var_10_0.correctNumToEXValue = self:GetMGData():getConfig("simple_config_data").correct_value
	var_10_0.scoreLevel = self:GetMGData():getConfig("simple_config_data").score_level

	function var_10_0.onSubmit(arg_11_0)
		if self:GetMGHubData().count > 0 then
			self:SendSuccess(arg_11_0)
		end

		self.score = 0
		self.countTime = nil
		self.leftTime = self.orginSelectTime
		self.orderIDList = {}
		self.selectedIDList = {}
		self.snackIDList = {}

		self:updateSelectedOrderTag(true)

		self.selectedSnackTFList = {}

		self.animtor:SetBool("AniSwitch", NewYearSnackView.Ani_Open_2_Close)
		self:setState(NewYearSnackView.States_Before)

		return
	end

	function var_10_0.onContinue()
		self.score = self.packageData.score
		self.leftTime = self.packageData.countTime
		self.orderIDList = {}
		self.selectedIDList = {}
		self.snackIDList = {}
		self.selectedSnackTFList = {}

		self.animtor:SetBool("AniSwitch", NewYearSnackView.Ani_Open_2_Close)
		self:setState(NewYearSnackView.States_Memory)

		return
	end

	self.packageData = var_10_0
	self.snackResultView = NewYearSnackResultView.New(self._tf, self.event, self.packageData)

	self.snackResultView:Reset()
	self.snackResultView:Load()

	return
end

return NewYearSnackView
