local Shrine2022View = class("Shrine2022View", import("..BaseMiniGameView"))

Shrine2022View.SHRINE_SELECT_SHIP_VIEW_CLS = Shrine2022SelectShipView
Shrine2022View.SHRINE_SHIP_WORD_VIEW_CLS = Shrine2022ShipWordView
Shrine2022View.SHRINE_SELECT_BUFF_VIEW_CLS = Shrine2022SelectBuffView

function Shrine2022View:getUIName()
	return "Shrine2022UI"
end

function Shrine2022View:init()
	self:findUI()
	self:addListener()

	return
end

function Shrine2022View:didEnter()
	self:initData()
	self:updateDataView()
	self:updateCardList()
	self:updateCardBuffTag()
	self:updateCommanderBuff()

	return
end

function Shrine2022View:onBackPressed()
	if self.shrineSelectShipView and self.shrineSelectShipView:CheckState(BaseSubView.STATES.INITED) then
		self.shrineSelectShipView:closeSelf()
	elseif self.shrineSelectBuffView and self.shrineSelectBuffView:CheckState(BaseSubView.STATES.INITED) then
		self.shrineSelectBuffView:closeMySelf()
	elseif self.shrineShipWordView and self.shrineShipWordView:CheckState(BaseSubView.STATES.INITED) then
		self.shrineShipWordView:closeMySelf()
	else
		self:emit(Shrine2022View.ON_BACK_PRESSED)
	end

	return
end

function Shrine2022View:OnSendMiniGameOPDone(arg_5_1)
	local var_5_0 = arg_5_1.argList

	self:PrintLog("后端返回,游戏ID,操作类型", arg_5_1.argList[1], arg_5_1.argList[2])

	if arg_5_1.argList[1] == self.commanderGameID then
		if arg_5_1.argList[2] == 1 then
			self:updateDataView()
			self:updateCommanderBuff()
		elseif arg_5_1.argList[2] == 2 then
			local var_5_1 = self.playerProxy:getData()
			local var_5_2 = {}

			var_5_2.gold = self:GetMGData():getConfig("config_data")[1]

			var_5_1:consume(var_5_2)
			self.playerProxy:updatePlayer(var_5_1)
			self:updateDataView()
			self:updateCommanderBuff(true)
		elseif arg_5_1.argList[2] == 3 then
			local var_5_3 = self.playerProxy:getData()
			local var_5_4 = {}

			var_5_4.gold = self:GetMGData():getConfig("config_data")[1]

			var_5_3:consume(var_5_4)
			self.playerProxy:updatePlayer(var_5_3)
		end
	elseif arg_5_1.argList[1] == self.shipGameID then
		if arg_5_1.argList[2] == 1 then
			self:updateDataView()
			self:updateCommanderBuff()
		elseif arg_5_1.argList[2] == 2 then
			local var_5_5 = self.playerProxy:getData()
			local var_5_6 = {}

			var_5_6.gold = self:getShipGameData():getConfig("config_data")[1]

			var_5_5:consume(var_5_6)
			self.playerProxy:updatePlayer(var_5_5)

			local var_5_7 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SHRINE)

			if var_5_7 and not var_5_7:isEnd() then
				var_5_7.data2 = var_5_7.data2 + 1

				getProxy(ActivityProxy):updateActivity(var_5_7)
			end

			self:SendOperator(MiniGameOPCommand.CMD_SPECIAL_GAME, {
				self.commanderGameID,
				1
			})
			self:updateCardList()
			self:updateCardBuffTag()
			self:openFakeDrop(function()
				self:openShipWordView(var_5_0[5])

				return
			end)
		end
	end

	return
end

function Shrine2022View:OnModifyMiniGameDataDone(arg_7_1)
	return
end

function Shrine2022View:willExit()
	if self.shrineSelectShipView and self.shrineSelectShipView:CheckState(BaseSubView.STATES.INITED) then
		self.shrineSelectShipView:Destroy()
	elseif self.shrineSelectBuffView and self.shrineSelectBuffView:CheckState(BaseSubView.STATES.INITED) then
		self.shrineSelectBuffView:Destroy()
	elseif self.shrineShipWordView and self.shrineShipWordView:CheckState(BaseSubView.STATES.INITED) then
		self.shrineShipWordView:Destroy()
	end

	self:cleanManagedTween()

	return
end

function Shrine2022View:setUIData()
	local var_9_0 = self._tf:Find("Res")

	self.curBuffSpriteList = {
		getImageSprite(var_9_0:Find("CurBuff1")),
		getImageSprite(var_9_0:Find("CurBuff2")),
		(getImageSprite(var_9_0:Find("CurBuff3")))
	}
	self.shipCardSpriteList = {}

	for iter_9_0 = 1, 7 do
		table.insert(self.shipCardSpriteList, (LoadSprite("Shrine2022/" .. "shipcard_" .. iter_9_0, "shipcard_" .. iter_9_0)))
	end

	self.curBuffPosStart = 160
	self.curBuffPosEnd = -70

	return
end

function Shrine2022View:updateShipCardUI(arg_10_1, arg_10_2)
	setImageSprite(arg_10_1, self.shipCardSpriteList[arg_10_2], true)

	return
end

function Shrine2022View:initData()
	self.playerProxy = getProxy(PlayerProxy)
	self.miniGameProxy = getProxy(MiniGameProxy)
	self.commanderGameID = self.contextData.miniGameId
	self.shipGameID = pg.mini_game[self.commanderGameID].simple_config_data.shipGameID
	self.cardPosList = {
		{
			x = -447,
			y = 205
		},
		{
			x = -154,
			y = 205
		},
		{
			x = 145,
			y = 205
		},
		{
			x = 445,
			y = 205
		},
		{
			x = -299,
			y = -160
		},
		{
			x = 0,
			y = -160
		},
		{
			x = 302,
			y = -160
		}
	}

	if not self:isInitedShipGameData() then
		self:PrintLog("请求舰娘游戏数据", self.shipGameID)
		self:SendOperator(MiniGameOPCommand.CMD_SPECIAL_GAME, {
			self.shipGameID,
			1
		})
	end

	if not self:isInitedCommanderGameData() then
		self:PrintLog("请求指挥官游戏数据", self.commanderGameID)
		self:SendOperator(MiniGameOPCommand.CMD_SPECIAL_GAME, {
			self.commanderGameID,
			1
		})
	end

	return
end

function Shrine2022View:findUI()
	local var_12_0 = self._tf:Find("Adapt")

	self.tipGoldTF = var_12_0:Find("TipGold")
	self.backBtn = var_12_0:Find("BackBtn")
	self.helpBtn = var_12_0:Find("HelpBtn")

	local var_12_1 = self._tf:Find("Data")

	self.countText = var_12_1:Find("Count")
	self.goldText = var_12_1:Find("Gold")
	self.countText2 = var_12_1:Find("Count2")
	self.cardTpl = self._tf:Find("CardTpl")
	self.cardContainer = self._tf:Find("CardContainer")
	self.cardUIItemList = UIItemList.New(self.cardContainer, self.cardTpl)
	self.selectBuffBtn = self._tf:Find("Decorate/String/SelectBuffBtn")
	self.selectBuffLight = self._tf:Find("Decorate/String/SelectBuffLight")
	self.curBuffTF = self._tf:Find("Decorate/String/SelectBuffBtn/CurBuff")
	self.curBuffImg = self.curBuffTF:Find("BuffImg")

	self:setUIData()

	return
end

function Shrine2022View:addListener()
	onButton(self, self.backBtn, function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.Pray_activity_tips1.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.selectBuffBtn, function()
		self:openSelectBuffView()

		return
	end, SFX_PANEL)

	return
end

function Shrine2022View:updateDataView()
	if not self:isInitedCommanderGameData() then
		self:PrintLog("无指挥官数据,返回")

		return
	end

	self:PrintLog("刷新指挥官次数与金币")

	local var_17_0 = self:GetMGData():GetRuntimeData("count")

	setText(self.countText, var_17_0)
	setText(self.countText2, (self:getShipGameData():GetRuntimeData("count")))
	setText(self.goldText, self.playerProxy:getData().gold)
	setActive(self.selectBuffLight, var_17_0 > 0 and not self:isHaveCommanderBuff())

	return
end

function Shrine2022View:updateCardList()
	if not self:isInitedShipGameData() then
		self:PrintLog("无舰娘数据,返回")

		return
	end

	self:PrintLog("刷新舰娘显示")

	self.cardTFList = {}

	self.cardUIItemList:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			local var_19_0 = arg_19_1 + 1

			self.cardTFList[arg_19_1 + 1] = arg_19_2

			self:updateCardImg(arg_19_1 + 1)
			setLocalPosition(arg_19_2, self.cardPosList[arg_19_1 + 1])
			onButton(self, arg_19_2:Find("Empty"), function()
				self:openSelectShipView(var_19_0)

				return
			end, SFX_PANEL)
			onButton(self, arg_19_2:Find("Ship"), function()
				self:openShipWordView((self:getSelectedShipByCardIndex(var_19_0)))

				return
			end, SFX_PANEL)
		end

		return
	end)

	local var_18_0 = self:getShipGameData():GetRuntimeData("count")
	local var_18_1 = self:getSelectedShipCount()
	local var_18_2 = #self:getShipGameData():getConfig("config_data")[2]
	local var_18_3 = var_18_2 < var_18_0 + var_18_1 and var_18_2 or var_18_0 + var_18_1

	self:PrintLog("舰娘次数相关", var_18_0, var_18_1, var_18_2 < var_18_0 + var_18_1 and var_18_2 or var_18_0 + var_18_1)
	self.cardUIItemList:align(var_18_3)

	return
end

function Shrine2022View:updateCardImg(arg_22_1)
	local var_22_0 = self.cardTFList[arg_22_1]:Find("Empty")
	local var_22_1 = self.cardTFList[arg_22_1]:Find("Ship")
	local var_22_2 = self:getSelectedShipByCardIndex(arg_22_1)

	if var_22_2 > 0 then
		self:updateShipCardUI(var_22_1, var_22_2)
	end

	setActive(var_22_0, var_22_2 == 0)
	setActive(var_22_1, var_22_2 > 0)

	return
end

function Shrine2022View:updateCardSelecting(arg_23_1, arg_23_2)
	setActive(self.cardTFList[arg_23_1]:Find("Selecting"), arg_23_2)

	return
end

function Shrine2022View:updateCardBuffTag()
	if not self:isInitedShipGameData() then
		self:PrintLog("无舰娘数据,返回")

		return
	end

	self:PrintLog("刷新舰娘BuffTtag")

	for iter_24_0, iter_24_1 in ipairs(self.cardTFList) do
		setActive(iter_24_1:Find("Ship/Buff"), false)
	end

	local var_24_0 = self:getShipGameData():getConfig("config_data")[2]

	for iter_24_2, iter_24_3 in ipairs(self.playerProxy:getData().buff_list) do
		local var_24_2 = table.indexof(var_24_0, iter_24_3.id, 1)

		if var_24_2 then
			if pg.TimeMgr.GetInstance():GetServerTime() < iter_24_3.timestamp then
				setActive(self.cardTFList[self:getCardIndexByShip(var_24_2)]:Find("Ship/Buff"), true)

				break
			end

			break
		end
	end

	return
end

function Shrine2022View:updateCommanderBuff(arg_25_1)
	if not self:isInitedCommanderGameData() then
		self:PrintLog("无指挥官数据,返回")

		return
	end

	self:PrintLog("刷新指挥官Buff")

	local var_25_0 = self:GetMGData():getConfig("config_data")[2]
	local var_25_1

	for iter_25_0, iter_25_1 in ipairs(self.playerProxy:getData().buff_list) do
		var_25_1 = table.indexof(var_25_0, iter_25_1.id, 1)

		if var_25_1 then
			if pg.TimeMgr.GetInstance():GetServerTime() < iter_25_1.timestamp then
				setImageSprite(self.curBuffImg, self.curBuffSpriteList[var_25_1])
				setActive(self.curBuffTF, true)

				break
			end

			var_25_1 = nil

			break
		end
	end

	if not var_25_1 then
		setActive(self.curBuffTF, false)
	elseif arg_25_1 then
		local var_25_2 = self.curBuffPosStart
		local var_25_3 = self.curBuffPosEnd
		local var_25_4 = {
			x = rtf(self.curBuffTF).localPosition.x,
			y = self.curBuffPosStart
		}

		setLocalPosition(self.curBuffTF, var_25_4)
		self:managedTween(LeanTween.value, nil, go(self.curBuffTF), 0, 1, 0.5):setEase(LeanTweenType.easeOutBack):setOnUpdate(System.Action_float(function(arg_26_0)
			var_25_4.y = var_25_2 + (var_25_3 - var_25_2) * arg_26_0

			setAnchoredPosition(self.curBuffTF, var_25_4)

			return
		end))
	end

	return
end

function Shrine2022View:openSelectShipView(arg_27_1)
	if self:getShipGameData():getConfig("config_data")[1] > self.playerProxy:getData().gold then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	self:updateCardSelecting(arg_27_1, true)
	setActive(self.tipGoldTF, false)

	self.shrineSelectShipView = self.SHRINE_SELECT_SHIP_VIEW_CLS.New(self._tf.parent, self.event, {
		shipGameID = self.shipGameID,
		selectingCardIndex = arg_27_1,
		onClose = function()
			self:updateCardSelecting(arg_27_1, false)
			setActive(self.tipGoldTF, true)
			setActive(self.cardTFList[arg_27_1]:Find("Empty"), true)
			setActive(self.cardTFList[arg_27_1]:Find("Ship"), false)

			return
		end,
		onSelect = function(arg_29_0)
			local var_29_0 = self.cardTFList[arg_27_1]:Find("Ship")

			self:updateShipCardUI(var_29_0, arg_29_0)
			setActive(self.cardTFList[arg_27_1]:Find("Empty"), false)
			setActive(var_29_0, true)

			return
		end,
		onConfirm = function(arg_30_0)
			local var_30_0 = self:getShipGameData()

			if var_30_0:GetRuntimeData("count") <= 0 then
				self:PrintLog("Error, count <= 0")
			else
				local var_30_1 = var_30_0:getConfig("config_data")[2][arg_30_0]

				self:PrintLog("发送选船操作", self.shipGameID, 2, var_30_1, arg_27_1, arg_30_0)
				self:SendOperator(MiniGameOPCommand.CMD_SPECIAL_GAME, {
					self.shipGameID,
					2,
					var_30_1,
					arg_27_1,
					arg_30_0
				})
			end

			return
		end
	})

	self.shrineSelectShipView:Reset()
	self.shrineSelectShipView:Load()

	return
end

function Shrine2022View:openSelectBuffView()
	if self:GetMGData():getConfig("config_data")[1] > self.playerProxy:getData().gold then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	if self:GetMGData():GetRuntimeData("count") <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("pray_cant_tips"))

		return
	end

	self.shrineSelectBuffView = self.SHRINE_SELECT_BUFF_VIEW_CLS.New(self._tf.parent, self.event, {
		onClose = function()
			return
		end,
		onSelect = function(arg_33_0)
			local var_33_0 = self:GetMGData()

			if var_33_0:GetRuntimeData("count") <= 0 then
				self:PrintLog("Error, count <= 0")
			else
				local var_33_1 = var_33_0:getConfig("config_data")[2][arg_33_0]

				self:PrintLog("发送选Buff操作", self.commanderGameID, 2, var_33_1)
				self:SendOperator(MiniGameOPCommand.CMD_SPECIAL_GAME, {
					self.commanderGameID,
					2,
					var_33_1
				})
			end

			return
		end
	})

	self.shrineSelectBuffView:Reset()
	self.shrineSelectBuffView:Load()

	return
end

function Shrine2022View:openShipWordView(arg_34_1)
	self.shrineShipWordView = self.SHRINE_SHIP_WORD_VIEW_CLS.New(self._tf, self.event, {
		curSelectShip = arg_34_1
	})

	self.shrineShipWordView:Reset()
	self.shrineShipWordView:Load()

	return
end

function Shrine2022View:openFakeDrop(arg_35_1)
	local var_35_0 = self:getShipGameData():getConfig("simple_config_data")

	LoadContextCommand.LoadLayerOnTopContext(Context.New({
		mediator = AwardInfoMediator,
		viewComponent = AwardInfoLayer,
		data = {
			items = {
				{
					type = var_35_0[1],
					id = var_35_0[2],
					count = var_35_0[3]
				}
			}
		},
		onRemoved = function()
			if arg_35_1 then
				arg_35_1()
			end

			return
		end
	}))

	return
end

function Shrine2022View:isInitedCommanderGameData()
	if not self:GetMGData():GetRuntimeData("isInited") then
		return false
	else
		return true
	end

	return
end

function Shrine2022View:isInitedShipGameData()
	if not self:getShipGameData():GetRuntimeData("isInited") then
		return false
	else
		return true
	end

	return
end

function Shrine2022View:isHaveCommanderBuff()
	local var_39_0 = self:GetMGData():getConfig("config_data")[2]
	local var_39_1

	for iter_39_0, iter_39_1 in ipairs(self.playerProxy:getData().buff_list) do
		var_39_1 = table.indexof(var_39_0, iter_39_1.id, 1)

		if var_39_1 then
			if pg.TimeMgr.GetInstance():GetServerTime() < iter_39_1.timestamp then
				return var_39_1
			else
				return nil
			end
		end
	end

	return var_39_1
end

function Shrine2022View:getSelectedShipByCardIndex(arg_40_1)
	for iter_40_0, iter_40_1 in ipairs(self:getShipGameData():GetRuntimeData("kvpElements")[1]) do
		if iter_40_1.key == arg_40_1 then
			return iter_40_1.value
		end
	end

	return 0
end

function Shrine2022View:getCardIndexByShip(arg_41_1)
	for iter_41_0, iter_41_1 in ipairs(self:getShipGameData():GetRuntimeData("kvpElements")[1]) do
		if iter_41_1.value == arg_41_1 then
			return iter_41_1.key
		end
	end

	return 0
end

function Shrine2022View:getSelectedShipCount()
	return #self:getShipGameData():GetRuntimeData("kvpElements")[1]
end

function Shrine2022View:getShipGameData()
	return self.miniGameProxy:GetMiniGameData(self.shipGameID)
end

function Shrine2022View:PrintLog(...)
	if IsUnityEditor then
		print(...)
	end

	return
end

function Shrine2022View.IsNeedShowTipWithoutActivityFinalReward()
	local var_45_0 = false
	local var_45_1 = getProxy(MiniGameProxy):GetMiniGameDataByType(MiniGameConst.MG_TYPE_3)

	if var_45_1 then
		var_45_0 = (var_45_1:GetRuntimeData("count") or 0) > 0
	end

	local var_45_2
	local var_45_3 = getProxy(MiniGameProxy):GetMiniGameDataByType(MiniGameConst.MG_TYPE_3)

	if var_45_3 then
		local var_45_4 = var_45_3:getConfig("config_data")[2]

		for iter_45_0, iter_45_1 in ipairs(getProxy(PlayerProxy):getData().buff_list) do
			var_45_2 = table.indexof(var_45_4, iter_45_1.id, 1)

			if var_45_2 then
				if pg.TimeMgr.GetInstance():GetServerTime() > iter_45_1.timestamp then
					var_45_2 = nil
				end

				break
			end
		end
	end

	if var_45_2 then
		var_45_0 = false
	end

	local var_45_5 = false
	local var_45_6 = getProxy(MiniGameProxy):GetMiniGameDataByType(MiniGameConst.MG_TYPE_5)

	if var_45_6 then
		var_45_5 = (var_45_6:GetRuntimeData("count") or 0) > 0
	end

	local var_45_7
	local var_45_8 = getProxy(MiniGameProxy):GetMiniGameDataByType(MiniGameConst.MG_TYPE_5)

	if var_45_8 then
		local var_45_9 = var_45_8:getConfig("config_data")[2]

		for iter_45_2, iter_45_3 in ipairs(getProxy(PlayerProxy):getData().buff_list) do
			var_45_7 = table.indexof(var_45_9, iter_45_3.id, 1)

			if var_45_7 then
				if pg.TimeMgr.GetInstance():GetServerTime() > iter_45_3.timestamp then
					var_45_7 = nil
				end

				break
			end
		end
	end

	return var_45_0 or (var_45_7 or nil) and false
end

function Shrine2022View.IsNeedShowTipForShipCount()
	local var_46_0 = false
	local var_46_1 = getProxy(MiniGameProxy):GetMiniGameDataByType(MiniGameConst.MG_TYPE_5)

	if var_46_1 then
		var_46_0 = (var_46_1:GetRuntimeData("count") or 0) > 0
	end

	local var_46_2
	local var_46_3 = getProxy(MiniGameProxy):GetMiniGameDataByType(MiniGameConst.MG_TYPE_5)

	if var_46_3 then
		local var_46_4 = var_46_3:getConfig("config_data")[2]

		for iter_46_0, iter_46_1 in ipairs(getProxy(PlayerProxy):getData().buff_list) do
			var_46_2 = table.indexof(var_46_4, iter_46_1.id, 1)

			if var_46_2 then
				if pg.TimeMgr.GetInstance():GetServerTime() > iter_46_1.timestamp then
					var_46_2 = nil
				end

				break
			end
		end
	end

	return (var_46_2 or nil) and false
end

return Shrine2022View
