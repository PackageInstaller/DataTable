local GameRoomSnackView = class("GameRoomSnackView", import(".GameRoomBaseSnackView"))

function GameRoomSnackView:getUIName()
	return "GameRoomSnackUI"
end

function GameRoomSnackView:OnSendMiniGameOPDone()
	self:updateCount()

	return
end

function GameRoomSnackView:OnGetAwardDone()
	if self.coinLayerVisible then
		self:openCoinLayer(true)
	end

	return
end

function GameRoomSnackView:addListener()
	GameRoomSnackView.super.addListener(self)

	if self:getGameRoomData() then
		self.gameHelpTip = self:getGameRoomData().game_help
	end

	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = self.gameHelpTip
		})

		return
	end, SFX_PANEL)

	return
end

function GameRoomSnackView:updateSDModel()
	local var_6_0 = getProxy(PlayerProxy):getData()
	local var_6_1 = getProxy(BayProxy)
	local var_6_2 = "Z28"

	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetSpineChar("Z28", true, function(arg_7_0)
		pg.UIMgr.GetInstance():LoadingOff()

		self.prefab = var_6_2
		self.model = arg_7_0
		tf(arg_7_0).localScale = Vector3(1, 1, 1)

		arg_7_0:GetComponent("SpineAnimUI"):SetAction("stand2", 0)
		setParent(arg_7_0, self.spineCharContainer)

		return
	end)

	return
end

function GameRoomSnackView:updateSelectedList(arg_8_1)
	arg_8_1 = arg_8_1 or {}

	for iter_8_0 = 1, GameRoomSnackView.Order_Num do
		local var_8_0 = self.selectedContainer:GetChild(iter_8_0 - 1)
		local var_8_1 = var_8_0:Find("Empty")
		local var_8_2 = var_8_0:Find("Full")
		local var_8_3 = var_8_2:Find("SnackImg")

		self.selectedTFList[iter_8_0] = var_8_0

		setActive(var_8_2, arg_8_1[iter_8_0])
		setActive(var_8_1, not arg_8_1[iter_8_0])

		if arg_8_1[iter_8_0] then
			setImageSprite(var_8_3, GetSpriteFromAtlas("ui/minigameui/newyearsnackui_atlas", "snack_" .. arg_8_1[iter_8_0]))
		end
	end

	return
end

function GameRoomSnackView:updateSnackList(arg_9_1)
	for iter_9_0 = 1, GameRoomSnackView.Snack_Num do
		local var_9_0 = self.snackContainer:GetChild(iter_9_0 - 1)

		setImageSprite(var_9_0:Find("SnackImg"), GetSpriteFromAtlas("ui/minigameui/newyearsnackui_atlas", "snack_" .. arg_9_1[iter_9_0]))
		setActive(var_9_0:Find("SelectedTag"), false)

		self.snackTFList[iter_9_0] = var_9_0
		iter_9_0 = iter_9_0 + 1
	end

	return
end

function GameRoomSnackView:updateSelectedOrderTag(arg_10_1)
	for iter_10_0, iter_10_1 in pairs(self.selectedSnackTFList) do
		local var_10_0 = iter_10_1:Find("SelectedTag")

		if arg_10_1 then
			setActive(var_10_0, false)
		else
			setImageSprite(var_10_0, GetSpriteFromAtlas("ui/minigameui/newyearsnackui_atlas", "order_" .. table.indexof(self.selectedIDList, iter_10_0, 1)))
		end
	end

	return
end

function GameRoomSnackView:openResultView()
	local var_11_0 = {
		orderIDList = self.orderIDList,
		selectedIDList = self.selectedIDList,
		countTime = self.countTime,
		score = self.score
	}

	var_11_0.correctNumToEXValue = self:GetMGData():getConfig("simple_config_data").correct_value
	var_11_0.scoreLevel = self:GetMGData():getConfig("simple_config_data").score_level

	function var_11_0.onSubmit(arg_12_0)
		self:SendSuccess((self.packageData.score or nil) and (self.packageData.score or 0))

		self.score = 0
		self.countTime = nil
		self.leftTime = self.orginSelectTime
		self.orderIDList = {}
		self.selectedIDList = {}
		self.snackIDList = {}

		self:updateSelectedOrderTag(true)

		self.selectedSnackTFList = {}

		self:openCoinLayer(true)
		self.animtor:SetBool("AniSwitch", GameRoomSnackView.Ani_Open_2_Close)
		self:setState(GameRoomSnackView.States_Before)

		return
	end

	function var_11_0.onContinue()
		self.score = self.packageData.score
		self.leftTime = self.packageData.countTime
		self.orderIDList = {}
		self.selectedIDList = {}
		self.snackIDList = {}
		self.selectedSnackTFList = {}

		self.animtor:SetBool("AniSwitch", GameRoomSnackView.Ani_Open_2_Close)
		self:setState(GameRoomSnackView.States_Memory)

		return
	end

	self.packageData = var_11_0
	self.snackResultView = NewYearSnackResultView.New(self._tf, self.event, self.packageData)

	self.snackResultView:Reset()
	self.snackResultView:Load()

	return
end

return GameRoomSnackView
