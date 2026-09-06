-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/BirthdayWishesView.lua

module("logic.extensions.birthdaywishes.view.BirthdayWishesView", package.seeall)

local BirthdayWishesView = class("BirthdayWishesView", TableViewComponent)

function BirthdayWishesView:ctor()
	BirthdayWishesView.super.ctor(self)

	self._gtItemList = nil
	self._tokenProxys = nil
end

function BirthdayWishesView:bindEvents()
	BirthdayWishesView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "birthdaywishes")
	end, self)
	self._recordBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.GiftRecordsPopup, self._actCfg.activityId)
	end, self)
	self._blessBtn:AddClickListener(self._onClickBlessBtn, self)

	for i = 1, #self._gtItemList do
		self._gtItemList[i].sendBtn:AddClickListener(function()
			self:_onClickSendBtn(i)
		end, self)
	end

	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
end

function BirthdayWishesView:unbindEvents()
	BirthdayWishesView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._recordBtn:RemoveClickListener()
	self._blessBtn:RemoveClickListener()

	for _, item in pairs(self._gtItemList) do
		item.sendBtn:RemoveClickListener()
	end

	GameUtil.rmClickHandler(self._btnTask)
end

function BirthdayWishesView:onExit()
	BirthdayWishesView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataBirthdayWishesInfo, self._updataShowGiftInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataBirthdayWishesOpenGift, self._handleUpdataBirthdayWishesOpenGift, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataBirthdayWishesGiveaway, self._updataShowGiftInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataBirthdayWishesBlessText, self._updataShowGiftInfo, self)
	MaterialController.instance:unregisterLocalNotify("ItemUsed", self._updataShowItemUsed, self)
	RedPointController.instance:unregRedPoint(self._redBtnTask)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil
	self._curViewDatas = nil
end

function BirthdayWishesView:destroyUI()
	BirthdayWishesView.super.destroyUI(self)

	self._gtItemList = nil
	self._tokenProxys = nil
end

function BirthdayWishesView:buildUI()
	BirthdayWishesView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")

	local giftTokenGo = self:getGo("giftTokenGo")

	self._gtItemList = {}
	self._gtItemList[1] = {
		goodsPos = goutil.findChild(giftTokenGo, "tokenGo_1/goodsPos"),
		sendBtn = Framework.ButtonAdapter.GetFrom(giftTokenGo, "tokenGo_1/sendBtn"),
		sendTxtGo = goutil.findChild(giftTokenGo, "tokenGo_1/sendBtn/sendTxt")
	}
	self._gtItemList[2] = {
		goodsPos = goutil.findChild(giftTokenGo, "tokenGo_2/goodsPos"),
		sendBtn = Framework.ButtonAdapter.GetFrom(giftTokenGo, "tokenGo_2/sendBtn"),
		sendTxtGo = goutil.findChild(giftTokenGo, "tokenGo_2/sendBtn/sendTxt")
	}
	self._gtItemList[3] = {
		goodsPos = goutil.findChild(giftTokenGo, "tokenGo_3/goodsPos"),
		sendBtn = Framework.ButtonAdapter.GetFrom(giftTokenGo, "tokenGo_3/sendBtn"),
		sendTxtGo = goutil.findChild(giftTokenGo, "tokenGo_3/sendBtn/sendTxt")
	}
	self._bubbleTxt = goutil.findChildTextComponent(giftTokenGo, "bubbleGo/bubbleTxt")
	self._recordBtn = Framework.ButtonAdapter.GetFrom(giftTokenGo, "recordBtn")
	self._blessBtn = self:getBtn("blessBtn")
	self._blessTxt = self:getTxt("blessBtn/blessTxt")
	self._redpointGo = self:getGo("blessBtn/redpointGo")
	self._timeTxt = self:getTxt("timeGo/timeTxt")
	self._btnTask = self:getGo("btnTask")
	self._redBtnTask = self:getGo("btnTask/redPoint")
	self._bubbleTxt.text = ""
	self._timeTxt.text = ""

	GameUtil.SetActive(self._redpointGo, false)
end

function BirthdayWishesView:onEnter()
	BirthdayWishesView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataBirthdayWishesInfo, self._updataShowGiftInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataBirthdayWishesOpenGift, self._handleUpdataBirthdayWishesOpenGift, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataBirthdayWishesGiveaway, self._updataShowGiftInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataBirthdayWishesBlessText, self._updataShowGiftInfo, self)
	MaterialController.instance:registerLocalNotify("ItemUsed", self._updataShowItemUsed, self)

	local actId = BirthdayWishesConfig.instance:getBirthdayWishesActivityId()

	self._actId = actId

	if checknumber(actId) <= 0 then
		self:close()

		return
	end

	self._actCfg = BirthdayWishesConfig.instance:getBirthdayWishesBaseCfg(actId)
	self._timeTxt.text = self._actCfg.timeShow

	local cfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.BirthdayWishes, self._actCfg.activityId)

	self._endTime = GameUtil.string2time(cfg.endTime)

	local taskRedId = EventTaskSummaryController.instance:getCurRedIdByActivityType(GameEnum.ActivityType.BirthdayWishes)

	if taskRedId > 0 then
		RedPointController.instance:regRedPoint(self._redBtnTask, taskRedId)
	end

	self:_showAllTokenItemInfo()
	self:_updataShowGiftInfo(true)

	local effPath = "20211126/xiaonuoshengrihui/fx_ui_xiaonuoshengrihui.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
	BirthdayWishesController.instance:csGetBirthdayWishesUserInfoReq(self._actCfg.activityId)
end

function BirthdayWishesView:_handleUpdataBirthdayWishesOpenGift(changeSetId, prizeStrList)
	MaterialController.instance:showChangeSetInTemp(changeSetId)
	self:_updataShowGiftInfo()
end

function BirthdayWishesView:_showAllTokenItemInfo()
	self._tokenProxys = {}

	local cfg

	for i = 1, #self._gtItemList do
		cfg = BirthdayWishesConfig.instance:getBirthdayWishesTokenCfg(self._actCfg.tokenIds[i])

		MaterialMgr.resetAll(self._gtItemList[i].goodsPos)

		if cfg and cfg.tokenId > 0 then
			cfg = BirthdayWishesConfig.instance:getTokenCfgByTokenId(cfg.tokenId)

			if cfg and not string.nilorempty(cfg.reward) then
				local proxy = MaterialMgr.setCellByCfg(cfg.reward, self._gtItemList[i].goodsPos)

				self._tokenProxys[i] = {
					proxy = proxy,
					reward = cfg.reward,
					buddyCommon = cfg.buddyCommon,
					tokenId = cfg.tokenId
				}
			end
		end
	end
end

function BirthdayWishesView:_updataShowGiftInfo(isInit)
	self._baseInfo = BirthdayWishesModel.instance:getBirthdayWishesBaseInfo()

	if checknumber(self._baseInfo.first) == 1 then
		self._blessTxt.text = "今日已发送祝福"

		GameUtil.SetActive(self._redpointGo, false)
	else
		self._blessTxt.text = "点击发送祝福"

		GameUtil.SetActive(self._redpointGo, true)
	end

	if isInit then
		self._curViewDatas = {} or BirthdayWishesModel.instance:getBirthdayWishesPlanCfgs(self._actCfg.giftPlan)
	end

	self._tableview:ReloadData()

	local isLimit = self._baseInfo.giveNum >= self._actCfg.dailyGiveLimitNum

	for i = 1, #self._gtItemList do
		if self._tokenProxys[i] and self._tokenProxys[i].proxy then
			local matType, matId, matNum = MaterialMgr.getMatParams(self._tokenProxys[i].reward)
			local haveNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

			if isLimit or haveNum < matNum then
				uGuiUtil.setTextGrayState(self._gtItemList[i].sendTxtGo, true)
				uGuiUtil.setImageGrayState(self._gtItemList[i].sendBtn.gameObject, true)
			else
				uGuiUtil.setTextGrayState(self._gtItemList[i].sendTxtGo, false)
				uGuiUtil.setImageGrayState(self._gtItemList[i].sendBtn.gameObject, false)
			end

			self._tokenProxys[i].proxy.binder:setNum(haveNum)
		end
	end

	self._bubbleTxt.text = string.format("每日前%s次赠送给其他玩家\n即可获得[自选信物*1]", self._actCfg.dailyRewardNum)
end

function BirthdayWishesView:_updataShowItemUsed(matType, matId, matNum)
	self:_updataShowGiftInfo()
end

function BirthdayWishesView:_onClickBlessBtn()
	if not self:_isBirthdayWishesEnd() then
		return
	end

	if checknumber(self._baseInfo.first) == 1 then
		FloatWordMgr.instance:show("今日已发送了祝福！")

		return
	end

	UIStateManager.instance:push(ViewName.SendBlessPopup, {
		planId = self._actCfg.wishesTextPlan,
		activityId = self._actCfg.activityId
	})
end

function BirthdayWishesView:_onClickSendBtn(index)
	if not self:_isBirthdayWishesEnd() then
		return
	end

	if self._baseInfo.giveNum >= self._actCfg.dailyGiveLimitNum then
		FloatWordMgr.instance:show("今日赠送已超上限！")

		return
	end

	if self._tokenProxys[index] == nil or string.nilorempty(self._tokenProxys[index].reward) then
		FloatWordMgr.instance:show("当前信物不足赠送！")

		return
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(self._tokenProxys[index].reward)

	if matNum > MaterialModel.instance:getMaterialsNumber(matType, matId) then
		FloatWordMgr.instance:show("当前信物不足赠送！")

		return
	end

	UIStateManager.instance:push(ViewName.FriendSelectPopup, self._tokenProxys, index, self._actCfg)
end

function BirthdayWishesView:_getPath()
	return {
		cellPath = "itemCell",
		viewPath = "itemListSR"
	}
end

function BirthdayWishesView:_cellSize()
	return 736, 100
end

function BirthdayWishesView:_updateCell(view, cell, data)
	local iconGo = goutil.findChild(cell, "iconGo")
	local viewContent = goutil.findChild(cell, "goodsSR/Viewport/Content").transform
	local viewLayout = goutil.findChild(cell, "goodsSR/Viewport/Content/items"):GetComponent(ComponentType.UILayoutSingleLine)
	local goodsGo = goutil.findChild(cell, "goodsGo")
	local openBtnGo = goutil.findChild(cell, "openBtn")
	local openTxt = goutil.findChildTextComponent(openBtnGo, "openTxt")
	local redpointGo = goutil.findChild(openBtnGo, "redpointGo")
	local remindTog = Framework.ToggleAdapter.GetFrom(cell.gameObject, "remindTog")
	local countTxt = goutil.findChildTextComponent(cell, "countTxt")
	local costTxt = goutil.findChild(cell, "costTxt"):GetComponent("UIGraphicTextNew")

	remindTog:RemoveOnValueChanged()
	GameUtil.asBtn(openBtnGo):RemoveClickListener()
	MaterialMgr.resetAll(iconGo)
	GameUtil.SetActive(goodsGo, false)
	GameUtil.SetActive(redpointGo, false)
	uGuiUtil.setSpriteToImage(iconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(data.giftIcon))
	costTxt:SetLuaCallBack(function(go, spriteName, size)
		local arr = string.split(spriteName, "|")

		uGuiUtil.setSpriteToImage(go.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(arr[1]))
	end, nil)

	if not self._baseInfo.giftInfos[data.giftType] then
		local info = {}
		local cfgs = BirthdayWishesConfig.instance:getBirthdayWishesLotteryPlanCfgs(data.giftType)
		local childCount = viewLayout.transform.childCount

		if cfgs then
			if not #cfgs then
				local goodsCount = 0

				while childCount < goodsCount do
					local go = UGUIToolHelper.AddChild(viewLayout.gameObject, goodsGo)

					childCount = childCount + 1
				end

				for i = 1, goodsCount do
					local go = viewLayout.transform:GetChild(i - 1).gameObject

					GameUtil.SetActive(go, true)

					local itemGo = goutil.findChild(go, "itemGo")
					local itemTxt = goutil.findChildTextComponent(go, "itemTxt")

					MaterialMgr.resetAll(itemGo)
					MaterialMgr.setCellByCfg(cfgs[i].reward, itemGo)

					itemTxt.text = ""

					if checknumber((self._baseInfo.gifeNumInfos and self._baseInfo.gifeNumInfos[cfgs[i].giftType] or nil) and checknumber(self._baseInfo.gifeNumInfos[cfgs[i].giftType][cfgs[i].insertId])) == 0 and cfgs[i].times > 0 and cfgs[i].times > checknumber(info.openTime) then
						itemTxt.text = string.format("%s次后必得", cfgs[i].times - checknumber(info.openTime))
					end
				end

				for i = goodsCount + 1, childCount do
					GameUtil.SetActive(viewLayout.transform:GetChild(i - 1), false)
				end

				viewLayout:Layout()

				local sizeDelta = viewContent.sizeDelta

				sizeDelta.x = goodsCount * 90
				viewContent.sizeDelta = sizeDelta
				remindTog.isOn = checknumber(info.redOpen) == 1
				countTxt.text = string.format("剩余：%s/%s", math.max(0, data.lotteryMaxNum - checknumber(info.openTime)), data.lotteryMaxNum)

				local itemStr, tipStr = "", ""
				local insufficient = ""
				local costList = string.split(data.cost, "#")

				for i = 1, #costList do
					if costList[i] and not string.nilorempty(costList[i]) then
						local matType, matId, matNum = MaterialMgr.getMatParams(costList[i])
						local cfg = MaterialMgr.getMatCfg(matType, matId)

						if cfg == nil or string.nilorempty(cfg.icon) then
							printError("sr---生日祝福   BirthdayWishesView:_updateCell()      未找到图标 = " .. costList[i])
						else
							itemStr = itemStr .. MaterialMgr.getContentMatStr(cfg.icon, 26, -5, true)
							tipStr = tipStr .. MaterialMgr.getContentMatStr(cfg.icon, 70, -5, true)
						end

						if matNum > MaterialModel.instance:getMaterialsNumber(matType, matId) then
							local matName = MaterialMgr.getMaterialsName(matType, matId)

							if not string.nilorempty(insufficient) then
								insufficient = insufficient .. "、"
							end

							insufficient = insufficient .. matName
						end
					end
				end

				local multiple = self:_getCurrentItemMultiple(cfgs, checknumber(info.openTime))

				costTxt.text = multiple > 1 and string.format("消耗：[%s] x%s", itemStr, multiple) or "消耗：" .. itemStr

				if string.nilorempty(insufficient) then
					uGuiUtil.setTextGrayState(openTxt.gameObject, false)
					uGuiUtil.setImageGrayState(openBtnGo, false)

					if checknumber(info.redOpen) == 1 and checknumber(info.openTime) < data.lotteryMaxNum then
						GameUtil.SetActive(redpointGo, true)
					end
				else
					uGuiUtil.setTextGrayState(openTxt.gameObject, true)
					uGuiUtil.setImageGrayState(openBtnGo, true)
				end

				remindTog:AddOnValueChanged(function(go, isOn)
					local value = isOn and 1 or 0

					BirthdayWishesController.instance:csGetBirthdayWishesUserRedPointSetReq(self._actCfg.activityId, data.giftType, value)
				end)
				GameUtil.asBtn(openBtnGo):AddClickListener(function()
					if not self:_isBirthdayWishesEnd() then
						return
					end

					if checknumber(info.openTime) >= data.lotteryMaxNum then
						FloatWordMgr.instance:show("这个礼盒已经开完啦！")

						return
					end

					if not string.nilorempty(insufficient) then
						FloatWordMgr.instance:show(string.format("当前未集齐%s，请集齐后再来开启哦！", insufficient))

						return
					end

					if checknumber(GameUtil.getUserDayData("BirthdayWishesOpenGift")) == 1 then
						BirthdayWishesController.instance:csGetBirthdayWishesGiftOpenReq(self._actCfg.activityId, data.giftType)

						return
					end

					local text = "确认消耗" .. tipStr .. "开启" .. MaterialMgr.getContentMatStr(data.giftIcon, 70, -5, true) .. "？"

					TipsFacade.instance:openPopupWithIconWindow("确认消耗", text, function()
						BirthdayWishesController.instance:csGetBirthdayWishesGiftOpenReq(self._actCfg.activityId, data.giftType)
					end, nil, "确定", "取消", function(isPopup)
						GameUtil.saveUserDayData("BirthdayWishesOpenGift", isPopup and 0 or 1)
					end)
				end, self)
			end
		end
	end
end

function BirthdayWishesView:_getCurrentItemMultiple(cfgs, count)
	if cfgs == nil then
		return 1
	end

	local mul = 0

	for _, v in pairs(cfgs) do
		if v and v.times == checknumber(count) + 1 then
			mul = mul + 1
		end
	end

	return math.max(mul, 1)
end

function BirthdayWishesView:_isBirthdayWishesEnd()
	if checknumber(self._endTime) <= ServerTime.now() then
		FloatWordMgr.instance:show(lang("text_activity_end"))

		return false
	end

	return true
end

function BirthdayWishesView:_onClickBtnTask()
	local jumpToStr = string.format("ui#passporttaskcommonview#%s#1", self._actId)

	GotoMgr.gotoByString(jumpToStr)
end

return BirthdayWishesView
