-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualactivity/view/AnnualActivityView.lua

module("logic.extensions.annualactivity.view.AnnualActivityView", package.seeall)

local AnnualActivityView = class("AnnualActivityView", ViewComponent)

function AnnualActivityView:ctor()
	AnnualActivityView.super.ctor(self)

	self._leftBtnsList = nil
	self._viewIndex = nil
	self._currencyList = nil
end

function AnnualActivityView:bindEvents()
	AnnualActivityView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		AnnualActivityModel.instance.viewOpenIndex = self._viewIndex

		self:close()
	end, self)
	self._tipsBtn:AddClickListener(function()
		for i = 1, #self._curViewDatas do
			if self._curViewDatas[i].viewIndex == self._viewIndex then
				UIStateManager.instance:push(ViewName.RulesView, self._curViewDatas[i].tipsName)

				return
			end
		end

		UIStateManager.instance:push(ViewName.RulesView, "annualactivity")
	end, self)
end

function AnnualActivityView:unbindEvents()
	AnnualActivityView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()

	for _, item in pairs(self._leftBtnsList or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end

	for _, item in pairs(self._currencyList or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end
end

function AnnualActivityView:onExit()
	AnnualActivityView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataAnnualActivityPoster, self._updataCurrencyAndRed, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataAnnualActivityTask, self._updataCurrencyAndRed, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataAnnualActivityAward, self._updataCurrencyAndRed, self)

	self._viewIndex = nil
end

function AnnualActivityView:destroyUI()
	AnnualActivityView.super.destroyUI(self)

	for _, item in pairs(self._leftBtnsList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self._leftBtnsList = nil

	for _, item in pairs(self._currencyList or {}) do
		if item and item.iconGo then
			uGuiUtil.clearImage(item.iconGo)
		end
	end

	self._currencyList = nil
end

function AnnualActivityView:buildUI()
	AnnualActivityView.super.buildUI(self)

	self._subParentGo = self:getGo("subParentGo")
	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._leftBtnsTran = self:getGo("leftBtnsTran").transform
	self._leftItem = self:getGo("leftItem")
	self._timeTxt = self:getGo("timeGo/timeTxt"):GetComponent("Text")
	self._timeTxt.text = ""
	self._currencyList = {}

	local daibiItem = self:getGo("daibiItem")

	self._currencyList[1] = {
		itemGo = daibiItem,
		iconGo = goutil.findChild(daibiItem, "daibiIconIma"),
		countTxt = goutil.findChildTextComponent(daibiItem, "daibiCountTxt"),
		addGo = goutil.findChild(daibiItem, "daibiAddGo")
	}

	local diamondItem = self:getGo("diamondItem")

	self._currencyList[2] = {
		itemGo = diamondItem,
		iconGo = goutil.findChild(diamondItem, "diamondIma"),
		countTxt = goutil.findChildTextComponent(diamondItem, "diamondTxt"),
		addGo = goutil.findChild(daibiItem, "diamondAddGo")
	}

	GameUtil.SetActive(self._leftItem, false)
end

function AnnualActivityView:onEnter()
	AnnualActivityView.super.onEnter(self)

	local actId = AnnualActivityConfig.instance:getOpenActivityId()

	if checknumber(actId) <= 0 then
		error("sr----  AnnualActivityView:onEnter() y运营-周年拼图    活动时间过了，还能打开？请配置功能开启id！！")

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.UpdataAnnualActivityPoster, self._updataCurrencyAndRed, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataAnnualActivityTask, self._updataCurrencyAndRed, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataAnnualActivityAward, self._updataCurrencyAndRed, self)

	self._viewIndex = 1

	local param = self:getOpenParam()

	if checknumber(param) > 0 then
		self._viewIndex = param
	end

	if checknumber(AnnualActivityModel.instance.viewOpenIndex) > 0 then
		self._viewIndex = AnnualActivityModel.instance.viewOpenIndex
	end

	self._actCfg = AnnualActivityConfig.instance:getAnnualActivityCfg(actId)

	if self._actCfg and not string.nilorempty(self._actCfg.timeShow) then
		self._timeTxt.text = self._actCfg.timeShow
	end

	self._curViewDatas = AnnualActivityModel.instance:getMainAllSubView()

	self:_initLeftAllBtns()
	self:_onClickLeftBtn()

	local value = GameUtil.getUserDayData("AnnualActivityRed")

	if checknumber(value) ~= 1 then
		GameUtil.saveUserDayData("AnnualActivityRed", 1)
	end
end

function AnnualActivityView:_initLeftAllBtns()
	self._leftBtnsList = self._leftBtnsList or {}

	local count = #self._curViewDatas

	for i = 1, count do
		if self._leftBtnsList[i] == nil or self._leftBtnsList[i].itemGo == nil then
			self._leftBtnsList[i] = {}

			local go = UnityEngine.GameObject.Instantiate(self._leftItem, self._leftBtnsTran)

			go:SetActive(true)

			self._leftBtnsList[i].itemGo = go
			self._leftBtnsList[i].itemTxt = goutil.findChild(go, "itemTxt"):GetComponent("Text")
			self._leftBtnsList[i].selectedGo = goutil.findChild(go, "selectedGo")
			self._leftBtnsList[i].selectedTxt = goutil.findChild(go, "selectedGo/selectedTxt"):GetComponent("Text")
			self._leftBtnsList[i].leftRedGo = goutil.findChild(go, "leftRedGo")
		else
			GameUtil.SetActive(self._leftBtnsList[i].itemGo, true)
			GameUtil.asBtn(self._leftBtnsList[i].itemGo):RemoveClickListener()
		end

		local info = self._curViewDatas[i]

		self._leftBtnsList[i].itemTxt.text = info.btnName
		self._leftBtnsList[i].selectedTxt.text = info.btnName

		GameUtil.SetActive(self._leftBtnsList[i].leftRedGo, false)
		GameUtil.asBtn(self._leftBtnsList[i].itemGo):AddClickListener(function()
			if info.viewIndex == self._viewIndex then
				return
			end

			self._viewIndex = info.viewIndex

			self:_onClickLeftBtn()
		end, self)
	end

	if count < #self._leftBtnsList then
		for i = count + 1, #self._leftBtnsList do
			if self._leftBtnsList[i] and self._leftBtnsList[i].itemGo then
				GameUtil.asBtn(self._leftBtnsList[i].itemGo):RemoveClickListener()
				GameUtil.SetActive(self._leftBtnsList[i].itemGo, false)
			end
		end
	end
end

function AnnualActivityView:_onClickLeftBtn()
	local info = self._curViewDatas[1]

	for i = 1, #self._curViewDatas do
		if self._curViewDatas[i] and self._curViewDatas[i].viewIndex == self._viewIndex then
			info = self._curViewDatas[i]

			break
		end
	end

	self._viewIndex = info.viewIndex

	for i = 1, #self._curViewDatas do
		if self._leftBtnsList[i] and self._leftBtnsList[i].itemGo then
			GameUtil.SetActive(self._leftBtnsList[i].selectedGo, self._curViewDatas[i].viewIndex == self._viewIndex)
			GameUtil.SetActive(self._leftBtnsList[i].leftRedGo, self:_updataViewRedpointShow(i))
		end
	end

	if string.nilorempty(info.tipsName) then
		GameUtil.SetActive(self._tipsBtn, false)
	else
		GameUtil.SetActive(self._tipsBtn, true)
	end

	self:showTabAt(self._subParentGo, info.viewName, self._actCfg)

	AnnualActivityModel.instance.viewOpenIndex = self._viewIndex

	self:_showCurrencyInfo()
end

function AnnualActivityView:_showCurrencyInfo()
	self._barItemlist = {}

	if self._actCfg and not string.nilorempty(self._actCfg.perLotteryCostItemType) then
		table.insert(self._barItemlist, self._actCfg.perLotteryCostItemType)
	end

	if self._curViewDatas[self._viewIndex] and not string.nilorempty(self._curViewDatas[self._viewIndex].barItem) then
		table.insert(self._barItemlist, self._curViewDatas[self._viewIndex].barItem)
	end

	for i = 1, #self._currencyList do
		GameUtil.asBtn(self._currencyList[i].itemGo):RemoveClickListener()
		uGuiUtil.clearImage(self._currencyList[i].iconGo)

		if self._barItemlist[i] and not string.nilorempty(self._barItemlist[i]) then
			GameUtil.SetActive(self._currencyList[i].itemGo, true)

			local have = MaterialMgr.getMatCount(self._barItemlist[i])

			self._currencyList[i].countTxt.text = tostring(have)

			MaterialMgr.updateItemByStr(self._currencyList[i].iconGo, self._barItemlist[i])

			if self._currencyList[i].addGo.activeSelf then
				GameUtil.asBtn(self._currencyList[i].itemGo):AddClickListener(function()
					MaterialMgr.openGetSourceByStr(self._barItemlist[i])
				end, self)
			end
		else
			GameUtil.SetActive(self._currencyList[i].itemGo, false)
		end
	end
end

function AnnualActivityView:_updataCurrencyAndRed()
	for i = 1, #self._curViewDatas do
		if self._leftBtnsList[i] and self._leftBtnsList[i].leftRedGo then
			GameUtil.SetActive(self._leftBtnsList[i].leftRedGo, self:_updataViewRedpointShow(i))
		end
	end

	if self._barItemlist == nil or #self._barItemlist == 0 then
		return
	end

	for i = 1, #self._currencyList do
		if self._barItemlist[i] and not string.nilorempty(self._barItemlist[i]) then
			local have = MaterialMgr.getMatCount(self._barItemlist[i])

			self._currencyList[i].countTxt.text = tostring(have)
		end
	end
end

function AnnualActivityView:_updataViewRedpointShow(index)
	if index == 1 then
		return AnnualActivityModel.instance:getAnnualPuzzleRedpoint()
	elseif index == 2 then
		return AnnualActivityModel.instance:getAnnualTaskRedpoint()
	end

	return false
end

return AnnualActivityView
