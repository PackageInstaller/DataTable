-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushGainPrizeView.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushGainPrizeView", package.seeall)

local AbyssGoldRushGainPrizeView = class("AbyssGoldRushGainPrizeView", ViewComponent)
local STAGE_OPENBOX = 1
local STAGE_GAINHOLYSTRIPE = 2
local STAGE_GAINPET = 3

function AbyssGoldRushGainPrizeView:ctor()
	AbyssGoldRushGainPrizeView.super.ctor(self)
end

function AbyssGoldRushGainPrizeView:unbindEvents()
	AbyssGoldRushGainPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBoxGain)
	GameUtil.rmClickHandler(self._btnPrizeGain)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnAutoWear)
end

function AbyssGoldRushGainPrizeView:bindEvents()
	AbyssGoldRushGainPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBoxGain, self._onClickGain, self)
	GameUtil.addClickHandler(self._btnPrizeGain, self._onClickGain, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnAutoWear, self._onClickAutoWear, self)
end

function AbyssGoldRushGainPrizeView:buildUI()
	AbyssGoldRushGainPrizeView.super.buildUI(self)

	self._boxPrize = self:getGo("boxPrize")
	self._prizeCoin = self:getGo("boxPrize/prizeCoin")
	self._txtPrizeCoin = self:getTxt("boxPrize/prizeCoin/txtPrize")
	self._prizeIcon = self:getGo("boxPrize/prizeCoin/icon")
	self._openTips = self:getGo("boxPrize/openTips")
	self._holystripeContain = self:getGo("boxPrize/holystripeContain")
	self._holystripeCell = self:getGo("boxPrize/holystripeContain/holystripeCell")
	self._posRecord = self._holystripeContain:GetComponent(ComponentType.TestRecordPos)
	self._boxOpen = self:getGo("boxPrize/boxOpen")
	self._boxClose = self:getGo("boxPrize/boxClose")
	self._btnBoxGain = self:getGo("boxPrize/btnGain")
	self._btnPrizeGain = self:getGo("petPrize/btnGain")
	self._txtGain = self:getTxt("boxPrize/btnGain/txtGain")
	self._txtTitle = self:getTxt("boxPrize/imgTitle/txtTitle")
	self._petPrize = self:getGo("petPrize")
	self._selectTableview = self:getGo("petPrize/selectTableview")
	self._selectTablecell = self:getGo("petPrize/selectTableview/selectTablecell")
	self._selectTabelList = ScrollerList.create(self._selectTableview, self._selectTablecell, GameUtil.handler(self._updateTeamPetCell, self), GameUtil.handler(self._clearTeamPetCell, self))
	self._gainTableview = self:getGo("petPrize/gainTableview")
	self._gainTablecell = self:getGo("petPrize/gainTableview/gainTablecell")
	self._gainTabelList = ScrollerList.create(self._gainTableview, self._gainTablecell, GameUtil.handler(self._updateNewPetCell, self), GameUtil.handler(self._clearNewPetCell, self))
	self._btnReset = self:getGo("petPrize/btnReset")
	self._txtSelcetCount = self:getTxt("petPrize/txtSelcetCount")
	self._boxCon = self:getGo("boxPrize/boxCon")
	self._tagAutoWear = self:getGo("boxPrize/btnAutoWear/tagAutoWear")
	self._btnAutoWear = self:getGo("boxPrize/btnAutoWear")
end

function AbyssGoldRushGainPrizeView:onExit()
	AbyssGoldRushGainPrizeView.super.onExit(self)
	GameUtil.clearCells(self._holystripeContain, self._clearHolyStripeCell, self, false)

	if self._boxObj then
		RoleObjectPool.instance:removeRole(self._boxObj)
	end
end

function AbyssGoldRushGainPrizeView:onEnter()
	AbyssGoldRushGainPrizeView.super.onEnter(self)

	self._spineCtrl = SimpleSpineCtrl.New()

	self.addGEvent(self, GlobalNotify.PM_AbyssGoldRushPushStepRes, self._PM_AbyssGoldRushPushStepRes, self)

	self._activityId = checknumber(self:getFirstParam())

	local gameInfo = AbyssGoldRushGameModel.instance:getGameInfo()
	local nextStepId = AbyssGoldRushGameController.instance:getNextStepId(self._activityId)
	local nextStepCfg = AbyssGoldRushConfig.instance:getStepCfg(self._activityId, nextStepId)

	self._selectMaxCount = 0

	local actCfg = AbyssGoldRushConfig.instance:getActivityCfg(self._activityId)
	local matType, matId, _ = MaterialMgr.getMatParams(actCfg.fakeItem)

	MaterialMgr.setIcon(self._prizeIcon, matType, matId)

	local isAutoWear = AbyssGoldRushGameModel.instance:isAutoWearHolyStripe()

	GameUtil.SetActive(self._tagAutoWear, isAutoWear)

	if nextStepCfg.handleType == "holyStripeDrop" then
		self:_waitOpen()
	elseif nextStepCfg.handleType == "openPetBox" then
		self:_waitComfirm()
	elseif nextStepCfg.handleType == "petSelect" then
		self:_waitSelectPet()
	end
end

function AbyssGoldRushGainPrizeView:_waitOpen()
	self._stage = STAGE_OPENBOX

	GameUtil.SetActive(self._boxPrize, true)
	GameUtil.SetActive(self._petPrize, false)
	GameUtil.SetActive(self._boxOpen, false)
	GameUtil.SetActive(self._boxClose, true)
	GameUtil.SetActive(self._prizeCoin, false)
	GameUtil.SetActive(self._openTips, true)
	GameUtil.SetActive(self._holystripeContain, false)

	self._clockTime = 3
	self._txtGain.text = langPara("打开 %s秒", self._clockTime)
	self._txtTitle.text = lang("获得宝箱")

	settimer(1, self._onClock, self, true)
end

function AbyssGoldRushGainPrizeView:_openBox()
	self._isOpening = true

	local function completeCallBack()
		local nextStepId = AbyssGoldRushGameController.instance:getNextStepId(self._activityId)

		AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushPushStepReq(self._activityId, nextStepId)
	end

	GameUtil.SetActive(self._boxCon, true)
	GameUtil.SetActive(self._boxOpen, false)

	local path = "character/shenyuantaojin_baoxiang/shenyuantaojin_baoxiang-ui_p.prefab"

	RoleObjectPool.instance:addSpineToParent(self._boxObj, path, self._boxCon, 1, function(go)
		self._spineCtrl:onInit(go)
		GameUtil.SetActive(self._boxClose, false)

		local params = {
			isLastFrameHold = true,
			animName = "idle",
			completeCallBack = completeCallBack
		}

		self._spineCtrl:playAnimation(params)
	end, 0, 0)
end

function AbyssGoldRushGainPrizeView:_waitComfirm()
	self._isOpening = false

	if self._boxObj then
		RoleObjectPool.instance:removeRole(self._boxObj)
	end

	GameUtil.SetActive(self._boxCon, false)

	self._stage = STAGE_GAINHOLYSTRIPE

	GameUtil.SetActive(self._boxPrize, true)
	GameUtil.SetActive(self._petPrize, false)
	GameUtil.SetActive(self._boxOpen, true)
	GameUtil.SetActive(self._boxClose, false)
	GameUtil.SetActive(self._prizeCoin, true)
	GameUtil.SetActive(self._openTips, false)
	GameUtil.SetActive(self._holystripeContain, true)

	local gameInfo = AbyssGoldRushGameModel.instance:getGameInfo()
	local gainCoin = math.max(checknumber(gameInfo.baseInfo.curRoundAbyssCoin), 0)

	if gainCoin > 0 then
		self._txtPrizeCoin.text = langPara("本局获得 %s", gainCoin)
		self._txtTitle.text = lang("获得灵纹、游园币")
	else
		GameUtil.SetActive(self._prizeCoin, false)

		self._txtTitle.text = lang("获得灵纹")
	end

	GameUtil.updateCellsList(self._holystripeContain, self._holystripeCell, gameInfo.baseInfo.dropHolyStripeIds, self._updateHolyStrpeCell, self)
	self._posRecord:LoadPlan(0)

	self._clockTime = 3
	self._txtGain.text = langPara("知道了 %s秒", self._clockTime)

	local isAutoWear = AbyssGoldRushGameModel.instance:isAutoWearHolyStripe()

	GameUtil.SetActive(self._tagAutoWear, isAutoWear)
	settimer(1, self._onClock, self, true)
end

function AbyssGoldRushGainPrizeView:_comfirmPrize()
	local nextStepId = AbyssGoldRushGameController.instance:getNextStepId(self._activityId)
	local nextStepCfg = AbyssGoldRushConfig.instance:getStepCfg(self._activityId, nextStepId)

	if not nextStepCfg then
		UIStateManager.instance:push(ViewName.AbyssGoldRushExitView, self._activityId)
		UIStateManager.instance:popByName(self._viewPresentor.viewName)
	elseif nextStepCfg.handleType == "openPetBox" then
		AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushPushStepReq(self._activityId, nextStepId)
	elseif nextStepCfg.handleType == "battle" then
		AbyssGoldRushGameController.instance:openMissionView(self._activityId)
		UIStateManager.instance:popByName(self._viewPresentor.viewName)
	end
end

function AbyssGoldRushGainPrizeView:_waitSelectPet()
	self._stage = STAGE_GAINPET

	GameUtil.SetActive(self._boxPrize, false)
	GameUtil.SetActive(self._petPrize, true)

	self._txtTitle.text = lang("恭喜你开到超绝宝箱")

	local gameInfo = AbyssGoldRushGameModel.instance:getGameInfo()

	self._selectMaxCount = 0

	local stepCfg = AbyssGoldRushConfig.instance:getStepCfg(self._activityId, gameInfo.baseInfo.curStepId)
	local roundCfg = AbyssGoldRushConfig.instance:getRoundCfg(self._activityId, stepCfg.petBoxRound)

	self._selectMaxCount = roundCfg.selectPetCount
	self._selectPetMap = {}
	self._teamPetList = {}

	for i, v in ipairs(gameInfo.petList) do
		table.insert(self._teamPetList, v)
	end

	self._newPetList = {}

	for i, v in ipairs(gameInfo.petsCanSelect) do
		table.insert(self._newPetList, v)
	end

	local newPetIndexMap = {}

	for i, v in ipairs(self._newPetList) do
		newPetIndexMap[v.creepsId] = i
	end

	table.sort(self._newPetList, function(a, b)
		local petCfgA = AbyssGoldRushConfig.instance:getSupportPet(a.creepsId)
		local petCfgB = AbyssGoldRushConfig.instance:getSupportPet(b.creepsId)
		local specialA = petCfgA and petCfgA.specialPet == true
		local specialB = petCfgB and petCfgB.specialPet == true

		if specialA ~= specialB then
			return specialA
		end

		return newPetIndexMap[a.creepsId] < newPetIndexMap[b.creepsId]
	end)

	self._teamSelect = nil
	self._newSelect = nil

	self:_refreshSelectPet()

	self._txtGain.text = lang("确认")
end

function AbyssGoldRushGainPrizeView:_refreshSelectPet()
	self._selectTabelList:reloadData(self._teamPetList)
	self._gainTabelList:reloadData(self._newPetList)

	local repacePet, newPet = self:clacChangePet()

	self._txtSelcetCount.text = langPara("选择：<color=#fef2bd>%s</color>/%s", #newPet, self._selectMaxCount)
end

function AbyssGoldRushGainPrizeView:_selectPet()
	local repacePet, newPet = self:clacChangePet()
	local extParam = {}

	if #newPet > 0 then
		extParam.selectCreepsIds = {}

		for i, v in ipairs(newPet) do
			table.insert(extParam.selectCreepsIds, v)
		end
	end

	if #repacePet > 0 then
		extParam.replaceCreepsIds = {}

		for i, v in ipairs(repacePet) do
			table.insert(extParam.replaceCreepsIds, v)
		end
	end

	local jsonExtPram = GameUtil.jsonToString(extParam)
	local nextStepId = AbyssGoldRushGameController.instance:getNextStepId(self._activityId)

	AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushPushStepReq(self._activityId, nextStepId, (#repacePet <= 0 and #newPet <= 0 or nil) and nil)
end

function AbyssGoldRushGainPrizeView:clacChangePet()
	local newPet = {}
	local repacePet = {}

	for i, v in pairs(self._selectPetMap) do
		if v == true then
			table.insert(newPet, i)
		end
	end

	return repacePet, newPet
end

function AbyssGoldRushGainPrizeView:_onClock()
	self._clockTime = self._clockTime - 1

	if self._clockTime <= 0 then
		if self._stage == STAGE_OPENBOX then
			removetimer(self._onClock, self)
			self:_openBox()
		elseif self._stage == STAGE_GAINHOLYSTRIPE then
			removetimer(self._onClock, self)
			self:_comfirmPrize()
		else
			removetimer(self._onClock, self)
		end
	else
		self._txtGain.text = self._stage == STAGE_OPENBOX and langPara("打开 %s秒", self._clockTime) or self._stage == STAGE_GAINHOLYSTRIPE and langPara("知道了 %s秒", self._clockTime) or langPara("%s秒", self._clockTime)
	end
end

function AbyssGoldRushGainPrizeView:_updateHolyStrpeCell(cell, data, index)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local neamText = goutil.findChildTextComponent(go, "nameText")
	local btn = goutil.findChild(go, "btn")
	local holyStripeCfg = AbyssGoldRushConfig.instance:getHolyStripeCfg(data)
	local targetCfg = HolyStripeConfig.instance:getHolyStripeCfg(holyStripeCfg.holyStripeTarget)

	MaterialMgr.setIcon(icon, MatType.HolyStripe, targetCfg.id)

	local matType, matId, _ = MaterialMgr.getMatParams(holyStripeCfg.fakeItem)

	GameUtil.addClickHandler(btn, function()
		CommonTipsMgr.instance:openMaterialTips(btn, matType, matId)
	end)

	local _, color
	local var_19_0, var_19_1 = PetEquipController:GetQualityStrByNum(targetCfg.quality)

	_ = var_19_0
	neamText.text = langPara("<color=%s>%s</color>", var_19_1, targetCfg.name)
end

function AbyssGoldRushGainPrizeView:_clearHolyStripeCell(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	MaterialMgr.resetAll(icon)
end

function AbyssGoldRushGainPrizeView:_updateNewPetCell(view, cell, data, tag)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "mask/con")
	local tagSelect = goutil.findChild(go, "tagSelect")
	local cover = goutil.findChild(go, "cover")
	local goAttr = goutil.findChild(cover, "layout/Nego_Attr/Img_attr")
	local attrIcon = goAttr:GetComponent("UIImageSpriteChange")
	local goJob = goutil.findChild(cover, "layout/Nego_Job/ImgC_Job")
	local ImgC_Job = goJob:GetComponent("UIImageSpriteChange")
	local Nego_Job1 = goutil.findChild(cover, "layout/Nego_Job1")
	local goJob1ImgC = goutil.findChild(cover, "layout/Nego_Job1/ImgC_Job")
	local ImgC_Job1 = goJob1ImgC:GetComponent("UIImageSpriteChange")
	local txtLv = goutil.findChildTextComponent(cover, "txtLvl")
	local tagRecommend = goutil.findChild(go, "tagRecommend")
	local buff = goutil.findChild(go, "buff")
	local btnPetInfo = goutil.findChild(go, "btnInfo")
	local petCfg = AbyssGoldRushConfig.instance:getSupportPet(data.creepsId)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCfg.raceId))

	uGuiUtil.setSpriteToImage(petCon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	txtLv.text = petCfg.lv

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(petCfg.raceId)

	race = race % 10

	local targetValue = race - 1

	if attrIcon then
		attrIcon:SetState(targetValue)
	end

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petCfg.raceId)
	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(petCfg.raceId)

	if ImgC_Job then
		ImgC_Job:SetState(firstJobIdx - 1)
		GameUtil.SetActive(Nego_Job1, false)

		if secondJobIdx > 20 then
			GameUtil.SetActive(Nego_Job1, true)
			ImgC_Job1:SetState(secondJobIdx - 1 - 20)
		end
	end

	GameUtil.SetActive(tagSelect, self._selectPetMap[data.creepsId] == true)
	GameUtil.rmClickHandler(petCon)
	GameUtil.addClickHandler(petCon, function()
		self:_onClickSelectPet(data.creepsId)
	end)
	uGuiUtil.clearImage(buff)

	if data.withBuff == true then
		GameUtil.SetActive(buff, true)
		uGuiUtil.setSpriteToImage(buff, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(petCfg.buffRes))
	else
		GameUtil.SetActive(buff, false)
	end

	GameUtil.SetActive(tagRecommend, petCfg.specialPet == true)
	GameUtil.addClickHandler(btnPetInfo, function()
		local co = MaterialMgr.getMatCfg(MatType.Pet, petCfg.raceId)
		local petMo = {
			_curZdl = 0,
			raceId = petCfg.raceId,
			level = co.maxLv,
			name = co.name,
			curFaceId = petCfg.raceId
		}

		petMo.awakenLv = CharacterConfig.instance:getMaxAwaken(petCfg.raceId)

		CommonTipsMgr.instance:showPetTips(petMo, true)
	end)
end

function AbyssGoldRushGainPrizeView:_clearNewPetCell(cell)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "mask/con")
	local btnPetInfo = goutil.findChild(go, "btnInfo")

	uGuiUtil.clearImage(petCon)
	GameUtil.rmClickHandler(petCon)
	GameUtil.rmClickHandler(btnPetInfo)
end

function AbyssGoldRushGainPrizeView:_updateTeamPetCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local tagSelect = goutil.findChild(go, "tagSelect")
	local btn = goutil.findChild(go, "btn")
	local buff = goutil.findChild(go, "buff")
	local petCfg = AbyssGoldRushConfig.instance:getSupportPet(data.creepsId)
	local proxy = MaterialMgr.setCell(MatType.Pet, petCfg.raceId, con)

	if proxy then
		proxy.binder:setAutoTips(false)
	end

	GameUtil.SetActive(tagSelect, self._selectPetMap[data.creepsId] == true)
	uGuiUtil.clearImage(buff)

	if data.withBuff == true then
		GameUtil.SetActive(buff, true)
		uGuiUtil.setSpriteToImage(buff, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(petCfg.buffRes))
	else
		GameUtil.SetActive(buff, false)
	end
end

function AbyssGoldRushGainPrizeView:_clearTeamPetCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local btn = goutil.findChild(go, "btn")

	MaterialMgr.resetAll(con)
	GameUtil.rmClickHandler(btn)
end

function AbyssGoldRushGainPrizeView:_onClickSelectPet(creepsId)
	if self._selectPetMap[creepsId] == true then
		self._selectPetMap[creepsId] = nil
	elseif table.nums(self._selectPetMap) >= self._selectMaxCount then
		FloatWordMgr.instance:show(lang("已达可选上限"))
	else
		self._selectPetMap[creepsId] = true
	end

	self:_refreshSelectPet()
end

function AbyssGoldRushGainPrizeView:_onClickGain()
	if self._isOpening == true then
		return
	end

	if self._stage == STAGE_OPENBOX then
		removetimer(self._onClock, self)
		self:_openBox()
	elseif self._stage == STAGE_GAINHOLYSTRIPE then
		removetimer(self._onClock, self)
		self:_comfirmPrize()
	elseif self._stage == STAGE_GAINPET then
		self:_selectPet()
	else
		removetimer(self._onClock, self)
	end
end

function AbyssGoldRushGainPrizeView:_onClickReset()
	local gameInfo = AbyssGoldRushGameModel.instance:getGameInfo()

	self._teamPetList = {}

	for i, v in ipairs(gameInfo.petList) do
		table.insert(self._teamPetList, v)
	end

	self._newPetList = {}

	for i, v in ipairs(gameInfo.petsCanSelect) do
		table.insert(self._newPetList, v)
	end

	self._teamSelect = nil
	self._newSelect = nil

	self:_refreshSelectPet()
end

function AbyssGoldRushGainPrizeView:_onClickAutoWear()
	local isAutoWear = AbyssGoldRushGameModel.instance:isAutoWearHolyStripe()

	AbyssGoldRushGameModel.instance:setAutoWearHolyStripe(not isAutoWear)
	GameUtil.SetActive(self._tagAutoWear, not isAutoWear)
end

function AbyssGoldRushGainPrizeView:_PM_AbyssGoldRushPushStepRes()
	if self._stage == STAGE_OPENBOX then
		self:_waitComfirm()
	elseif self._stage == STAGE_GAINHOLYSTRIPE then
		local nextStepId = AbyssGoldRushGameController.instance:getNextStepId(self._activityId)
		local nextStepCfg = AbyssGoldRushConfig.instance:getStepCfg(self._activityId, nextStepId)

		if nextStepCfg.handleType == "nextRound" then
			UIStateManager.instance:push(ViewName.AbyssGoldRushRoundEndView, self._activityId)
			self:close()
		elseif nextStepCfg.handleType == "battle" then
			AbyssGoldRushGameController.instance:openMissionView(self._activityId)
			self:close()
		elseif nextStepCfg.handleType == "petSelect" then
			self:_waitSelectPet()
		else
			self:close()
		end
	elseif self._stage == STAGE_GAINPET then
		local nextStepId = AbyssGoldRushGameController.instance:getNextStepId(self._activityId)
		local nextStepCfg = AbyssGoldRushConfig.instance:getStepCfg(self._activityId, nextStepId)

		if nextStepCfg.handleType == "nextRound" then
			UIStateManager.instance:push(ViewName.AbyssGoldRushRoundEndView, self._activityId)
			self:close()
		elseif nextStepCfg.handleType == "battle" then
			AbyssGoldRushGameController.instance:openMissionView(self._activityId)
			self:close()
		elseif nextStepCfg.handleType == "holyStripeDrop" then
			self:_waitOpen()
		else
			self:close()
		end
	end
end

return AbyssGoldRushGainPrizeView
