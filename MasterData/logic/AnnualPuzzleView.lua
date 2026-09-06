-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualactivity/view/AnnualPuzzleView.lua

module("logic.extensions.annualactivity.view.AnnualPuzzleView", package.seeall)

local AnnualPuzzleView = class("AnnualPuzzleView", ViewComponent)

function AnnualPuzzleView:ctor()
	AnnualPuzzleView.super.ctor(self)

	self._gridItemList = nil
	self._titleBtnList = nil
	self._chosIndex = nil
	self._cacheData = nil
end

function AnnualPuzzleView:bindEvents()
	AnnualPuzzleView.super.bindEvents(self)
	GameUtil.asBtn(self._bigClickGo):AddClickListener(function()
		if self._posterInfos == nil or self._posterInfos[self._chosIndex] == nil then
			return
		end

		local data = self._posterInfos[self._chosIndex]

		if data.isReceive then
			FloatWordMgr.instance:show(lang("text_goddess_desc_18"))

			return
		end

		for id, boo in pairs(data.activationIds or {}) do
			if id and not boo then
				FloatWordMgr.instance:show(lang("text_annual_desc_1"))

				return
			end
		end

		AnnualActivityController.instance:csRequestPJGainBigPrizeReq(self._paramCfg.activityId, self._chosIndex)
	end, self)
	GameUtil.asBtn(self._lotteryClickGo):AddClickListener(self._onLotteryClickBtn, self)
end

function AnnualPuzzleView:unbindEvents()
	AnnualPuzzleView.super.unbindEvents(self)
	GameUtil.asBtn(self._bigClickGo):RemoveClickListener()
	GameUtil.asBtn(self._lotteryClickGo):RemoveClickListener()

	for _, item in pairs(self._gridItemList or {}) do
		if item then
			GameUtil.asBtn(item):RemoveClickListener()
		end
	end

	for _, item in pairs(self._titleBtnList or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end

	MaterialMgr.resetAll(self._bigGoodsGo)
	MaterialMgr.resetAll(self._preGoodsGo)
end

function AnnualPuzzleView:onExit()
	AnnualPuzzleView.super.onExit(self)
	removetimer(self._onClaimthePrize, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataAnnualActivityPoster, self._updataViewShow, self)

	if self._bigEff then
		UIEffectManager.instance:stopEffect(self._bigEff)
	end

	self._bigEff = nil

	if self._rewEff then
		UIEffectManager.instance:stopEffect(self._rewEff)
	end

	self._rewEff = nil
	self._chosIndex = nil
	self._cacheData = nil
end

function AnnualPuzzleView:destroyUI()
	AnnualPuzzleView.super.destroyUI(self)

	local bgBig = self._gridsTranGo:GetComponent("ImageBigBG")

	if bgBig then
		bgBig:ClearImage()
	end

	self._gridItemList = nil
	self._titleBtnList = nil

	uGuiUtil.clearImage(self._iconGo)
end

function AnnualPuzzleView:buildUI()
	AnnualPuzzleView.super.buildUI(self)

	local btnsTranGo = self:getGo("allBtnsShowGo/btnsTranGo")

	self._titleBtnList = {}

	for i = 1, 5 do
		self._titleBtnList[i] = {}

		local go = goutil.findChild(btnsTranGo, "btnGo_" .. i)

		self._titleBtnList[i].itemGo = go
		self._titleBtnList[i].itemIma = go:GetComponent("UIChangeGroup")
		self._titleBtnList[i].btnTxt = goutil.findChildTextComponent(go, "btnTxt")
		self._titleBtnList[i].btnRedGo = goutil.findChild(go, "btnRedGo")
	end

	self._puzzleInfoGo = self:getGo("puzzleInfoGo")
	self._gridsTranGo = goutil.findChild(self._puzzleInfoGo, "gridsTranGo")
	self._gridItemList = {}

	for i = 1, 12 do
		self._gridItemList[i] = goutil.findChild(self._gridsTranGo, "gridGo_" .. i)
	end

	self._lockGo = goutil.findChild(self._puzzleInfoGo, "lockGo")
	self._lockTxt = goutil.findChildTextComponent(self._lockGo, "lockTxt")

	local rewardGo = goutil.findChild(self._puzzleInfoGo, "rewardGo")

	self._bigGoodsGo = goutil.findChild(rewardGo, "bigGoodsGo")
	self._effectTran = goutil.findChild(rewardGo, "effectTran"):GetComponent(goutil.Type_RectTransform)
	self._bigRecGo = goutil.findChild(rewardGo, "bigRecGo")
	self._bigTagGo = goutil.findChild(rewardGo, "bigTagGo")
	self._bigClickGo = goutil.findChild(rewardGo, "bigClickGo")
	self._descTxt = goutil.findChildTextComponent(self._puzzleInfoGo, "descTxt")
	self._preGoodsGo = goutil.findChild(self._puzzleInfoGo, "previewGo/preGoodsGo")
	self._preNameTxt = goutil.findChild(self._puzzleInfoGo, "previewGo/preNameTxt"):GetComponent("Text")
	self._rewardInfoGo = self:getGo("rewardInfoGo")
	self._lotteryClickGo = goutil.findChild(self._rewardInfoGo, "lotteryClickGo")
	self._lotteryImaGo = goutil.findChild(self._lotteryClickGo, "lotteryImaGo")
	self._iconGo = goutil.findChild(self._rewardInfoGo, "iconGo")
	self._countTxt = goutil.findChildTextComponent(self._rewardInfoGo, "countTxt")
	self._rewardDescTxt = goutil.findChildTextComponent(self._rewardInfoGo, "rewardDescTxt")
	self._lockTxt.text = ""
	self._descTxt.text = ""
	self._preNameTxt.text = ""
	self._countTxt.text = ""
	self._rewardDescTxt.text = ""
end

function AnnualPuzzleView:onEnter()
	AnnualPuzzleView.super.onEnter(self)

	self._paramCfg = self:getFirstParam()

	if self._paramCfg == nil then
		printError("sr----  AnnualPuzzleView:onEnter() y运营-周年拼图    未传入参数！！")

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.UpdataAnnualActivityPoster, self._updataViewShow, self)

	self._titleInfoList = AnnualActivityModel.instance:getPuzzleAllCfgs(self._paramCfg.posterPlanId)

	self:_initTitleBtnsShow()

	self._chosIndex = 1

	if checknumber(AnnualActivityModel.instance.puzzleOpenIndex) > 0 then
		self._chosIndex = AnnualActivityModel.instance.puzzleOpenIndex
	end

	self:_updataViewShow()

	self._ableToLClick = true

	AnnualActivityController.instance:csRequestPJGetPosterInfoReq(self._paramCfg.activityId)
end

function AnnualPuzzleView:_initTitleBtnsShow()
	for i = 1, #self._titleBtnList do
		if self._titleBtnList[i] and self._titleBtnList[i].itemGo then
			GameUtil.asBtn(self._titleBtnList[i].itemGo):RemoveClickListener()

			if self._titleInfoList[i] then
				local index = i

				GameUtil.SetActive(self._titleBtnList[i].itemGo, true)

				self._titleBtnList[i].btnTxt.text = self._titleInfoList[i].puzzleName

				GameUtil.SetActive(self._titleBtnList[i].btnRedGo, false)
				GameUtil.asBtn(self._titleBtnList[i].itemGo):AddClickListener(function()
					self:_onClickTitleBtn(index)
				end, self)
			else
				GameUtil.SetActive(self._titleBtnList[i].itemGo, false)
			end
		end
	end
end

function AnnualPuzzleView:_updataViewShow(data)
	self._cacheData = nil
	self._posterInfos = AnnualActivityModel.instance:getPosterInfos()

	if data and checknumber(data.posterId) == self._chosIndex then
		self._cacheData = data
	end

	self:_onClickTitleBtn()
end

function AnnualPuzzleView:_onClickTitleBtn(index)
	if index and self._chosIndex == index then
		return
	end

	if self._bigEff then
		UIEffectManager.instance:stopEffect(self._bigEff)

		self._bigEff = nil
	end

	if self._rewEff then
		UIEffectManager.instance:stopEffect(self._rewEff)

		self._rewEff = nil
	end

	if checknumber(index) > 0 then
		self._chosIndex = index
	end

	MaterialMgr.resetAll(self._bigGoodsGo)
	MaterialMgr.resetAll(self._preGoodsGo)

	for i = 1, #self._titleInfoList do
		if self._titleBtnList[i] and self._titleBtnList[i].itemGo then
			if i == self._chosIndex then
				self._titleBtnList[i].itemIma:SetState(1)
			else
				self._titleBtnList[i].itemIma:SetState(0)
			end

			GameUtil.SetActive(self._titleBtnList[i].btnRedGo, self:_updataViewRedpointShow(i))
		end
	end

	local info = self._titleInfoList[self._chosIndex]

	if self._chosIndex >= #self._titleInfoList then
		self._cacheData = nil
		self._descTxt.text = ""

		GameUtil.SetActive(self._puzzleInfoGo, false)
		GameUtil.SetActive(self._rewardInfoGo, true)
		GameUtil.SetActive(self._lotteryImaGo, true)

		local isFull = AnnualActivityModel.instance:isAllPuzzleFinish()
		local have = MaterialMgr.getMatCount(self._paramCfg.perLotteryCostItemType)

		if isFull and have >= self._paramCfg.perLotteryCostNum then
			self._bigEff = UIEffectManager.instance:playEffect(self, "fx_ui_tongxingzheng/fx_ui_tongxingzheng_baoxiang1.prefab", self._lotteryClickGo, 0, 0, true, false, nil, function(target, eff)
				GameUtil.SetActive(self._lotteryImaGo, false)
				eff.effGo.transform:SetParent(self._lotteryClickGo.transform)
				GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
				GameUtil.setLocalScale(eff.effGo.transform, 1.3, 1.3, 1.3)
				eff:setClipping(self._lotteryClickGo:GetComponent(goutil.Type_RectTransform))
			end)
		end

		self._countTxt.text = have .. "/" .. self._paramCfg.perLotteryCostNum
		self._rewardDescTxt.text = lang("text_annual_desc_4")

		MaterialMgr.updateItemByStr(self._iconGo, self._paramCfg.perLotteryCostItemType)
	else
		self._rewardDescTxt.text = ""
		self._descTxt.text = lang("text_annual_desc_3")

		local data = self._posterInfos[self._chosIndex]

		GameUtil.SetActive(self._rewardInfoGo, false)
		GameUtil.SetActive(self._puzzleInfoGo, true)
		MaterialMgr.setCellByCfg(info.bigPrize, self._bigGoodsGo)
		MaterialMgr.setCellByCfg(info.perActivatePrize, self._preGoodsGo)

		self._preNameTxt.text = MaterialMgr.getMaterialsNameByCfg(info.perActivatePrize)

		GameUtil.SetActive(self._bigRecGo, data.isReceive)

		local isOpen, descStr = AnnualActivityModel.instance:getPuzzleIsOpen(self._paramCfg.activityId, info.relativeOpenDays)

		if not isOpen then
			for i = 1, #self._gridItemList do
				GameUtil.asBtn(self._gridItemList[i]):RemoveClickListener()
			end

			GameUtil.SetActive(self._gridsTranGo, false)
			GameUtil.SetActive(self._lockGo, true)

			self._lockTxt.text = descStr
			self._cacheData = nil

			return
		end

		GameUtil.SetActive(self._lockGo, false)
		GameUtil.SetActive(self._gridsTranGo, true)
		uGuiUtil.setSpriteToImage(self._gridsTranGo, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/picturepuzzle/%s.png", info.iconPath))

		local isFull = true
		local matType, matId, matNum = MaterialMgr.getMatParams(info.perActivateCost)

		for i = 1, #self._gridItemList do
			GameUtil.asBtn(self._gridItemList[i]):RemoveClickListener()

			if data.activationIds[i] then
				GameUtil.SetActive(self._gridItemList[i], false)
			else
				isFull = false

				GameUtil.SetActive(self._gridItemList[i], true)
				GameUtil.asBtn(self._gridItemList[i]):AddClickListener(function()
					local matCount = MaterialModel.instance:getMaterialsNumber(matType, matId)

					if matCount < matNum then
						FloatWordMgr.instance:show(lang("text_annual_desc_5"))

						return
					end

					AnnualActivityController.instance:csRequestPJActivateJigsawReq(self._paramCfg.activityId, self._chosIndex, i)
				end, self)
			end
		end

		if isFull and not data.isReceive then
			GameUtil.SetActive(self._bigClickGo, true)

			self._rewEff = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", self._effectTran.gameObject, 0, 0, true, nil, nil, function(view, uiEff)
				uiEff:setClipping(self._effectTran)
			end)

			self._rewEff:setParent(self._effectTran)
			self._rewEff:setLocalPos(0, 0, 0)
			self._rewEff:setScale(1)
		else
			GameUtil.SetActive(self._bigClickGo, false)
		end

		if isFull then
			if self._cacheData and checknumber(self._cacheData.jigsawId) > 0 then
				local bigEff = UIEffectManager.instance:playEffect(self, "20220401/zhounianpintu/fx_ui_dapintu_zhounianpintu.prefab", self._gridsTranGo, 0, 0, false, nil, function()
					if self._cacheData and checknumber(self._cacheData.changeSetId) > 0 then
						MaterialController.instance:showChangeSetInTemp(self._cacheData.changeSetId)

						self._cacheData = nil
					end
				end, nil)

				bigEff:setParent(self._gridsTranGo.transform)
				bigEff:setLocalPos(0, 0, 0)
				bigEff:setScale(1)
			end
		elseif self._cacheData and checknumber(self._cacheData.jigsawId) > 0 then
			local smallEff = UIEffectManager.instance:playEffect(self, "20220401/zhounianpintu/fx_ui_xiaopintu_zhounianpintu.prefab", self._gridsTranGo, 0, 0, false, nil, function()
				if self._cacheData and checknumber(self._cacheData.changeSetId) > 0 then
					MaterialController.instance:showChangeSetInTemp(self._cacheData.changeSetId)

					self._cacheData = nil
				end
			end, nil)

			smallEff:setParent(self._gridsTranGo.transform)

			local x, y, z = Framework.TransformUtil.GetLocalPos(self._gridItemList[self._cacheData.jigsawId].transform, 0, 0, 0)

			smallEff:setLocalPos(x, y, 0)
			smallEff:setScale(1)
		end
	end
end

function AnnualPuzzleView:_updataViewRedpointShow(index)
	if self._titleInfoList == nil or #self._titleInfoList == 0 then
		return false
	end

	if index == #self._titleInfoList then
		local isFull = AnnualActivityModel.instance:isAllPuzzleFinish()

		if isFull and self._paramCfg then
			local have = MaterialMgr.getMatCount(self._paramCfg.perLotteryCostItemType)

			return have >= self._paramCfg.perLotteryCostNum
		end

		return false
	end

	if self._posterInfos == nil or self._posterInfos[index] == nil then
		return false
	end

	local info = self._posterInfos[index]

	if info.isReceive then
		return false
	end

	if info.activationIds == nil then
		return false
	end

	for i = 1, #info.activationIds do
		if not info.activationIds[i] then
			return false
		end
	end

	return true
end

function AnnualPuzzleView:_onLotteryClickBtn()
	if not self._ableToLClick then
		return
	end

	local isFull = AnnualActivityModel.instance:isAllPuzzleFinish()

	if not isFull then
		local matType, matId = MaterialMgr.getMatParams(self._paramCfg.perLotteryPrize)

		CommonTipsMgr.instance:openMaterialTips(self._lotteryClickGo, matType, matId, 0)

		return
	end

	local have = MaterialMgr.getMatCount(self._paramCfg.perLotteryCostItemType)

	if have < self._paramCfg.perLotteryCostNum then
		FloatWordMgr.instance:show(lang("text_annual_desc_2"))

		return
	end

	if self._bigEff then
		UIEffectManager.instance:stopEffect(self._bigEff)

		self._bigEff = nil
	end

	GameUtil.SetActive(self._lotteryImaGo, true)

	self._bigEff = UIEffectManager.instance:playEffect(self, "fx_ui_tongxingzheng/fx_ui_tongxingzheng_baoxiangbaokai.prefab", self._lotteryClickGo, 0, 0, false, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(self._lotteryClickGo.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1.2, 1.2, 1.2)
		eff:setClipping(self._lotteryClickGo:GetComponent(goutil.Type_RectTransform))
	end)
	self._ableToLClick = false

	removetimer(self._onClaimthePrize, self)
	settimer(0.6, self._onClaimthePrize, self, false)
end

function AnnualPuzzleView:_onClaimthePrize()
	AnnualActivityController.instance:csRequestPJLotteryReq(self._paramCfg.activityId)

	self._ableToLClick = true
end

return AnnualPuzzleView
