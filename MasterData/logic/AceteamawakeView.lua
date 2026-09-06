-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/petshow/AceteamawakeView.lua

module("logic.extensions.aceteam.view.petshow.AceteamawakeView", package.seeall)

local AceteamawakeView = class("AceteamawakeView", ViewComponent)
local TriggerTime = 0.5

function AceteamawakeView:unbindEvents()
	AceteamawakeView.super.unbindEvents(self)
	self._btnTips:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
	self._btnContainer:RemoveClickListener()
	self._btnOneStarUp:RemoveClickListener()
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnAwake)
	GameUtil.rmClickHandler(self.cellL)
	GameUtil.rmClickHandler(self.cellR)
	self._btnLongPressHelper:dispose()
	GameUtil.rmClickHandler(self._btnOneKey)
	self._customInput:RemoveListener()
end

function AceteamawakeView:bindEvents()
	AceteamawakeView.super.bindEvents(self)
	self._btnTips:AddClickListener(self._onClickDetail, self)
	self._btnContainer:AddClickListener(self._onClickDetail, self)
	self._btnOneStarUp:AddClickListener(self._onClickOneStartUp, self)
	self._btnDetail:AddClickListener(self._onClickDetail, self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.cellL, self._onClickCoin, self)
	GameUtil.addClickHandler(self.cellR, self._onClickPetSource, self)
	self._btnLongPressHelper:addClickHandler(GameUtil.handler(self._onClickUpgrade, self))
	self._btnLongPressHelper:addPressHandler(GameUtil.handler(self._onBtnPressStartInTakeOff, self), GameUtil.handler(self._onBtnPressEndInTakeOff, self), GameUtil.handler(self._onBtnPressUpdateInTakeOff, self))
	self._btnLongPressHelper:onPressTimeHandler(TriggerTime, GameUtil.handler(self._onBtnPressUpdateTimeOverOnce, self))
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function AceteamawakeView:onExit()
	AceteamawakeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ACETEAM_PETAWAKEN, self.onGetMsg, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ACETEAM_GETINFO, self.onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ACETEAM_PETCHANGE, self.onRefreshUI, self)
	removetimer(self._openLvupView, self)

	for _, v in ipairs(self._starEffs) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._starEffs = nil

	for _, v in ipairs(self._ringEffs) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._ringEffs = nil

	if self._loopEff then
		UIEffectManager.instance:stopEffect(self._loopEff)
	end

	self._loopEff = nil

	if self._tweener then
		self._tweener:Kill(false)
	end

	self._tweener = nil
	self._hasShowRingEff = false

	GameUtil.clickEnabled(true, self)
	self:_clearNextEffs()
end

function AceteamawakeView:_clearEff()
	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)
	end

	self._eff = nil
end

function AceteamawakeView:_onPetSelected()
	print("pet selected updateUI")
	self:_updateUINew()
end

function AceteamawakeView:buildUI()
	AceteamawakeView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "tips/Text")
	self._starsContainer = self:getGo("container/stars").transform
	self._stars = GameUtil.getChildren(self._starsContainer)
	self._ringsContainer = self:getGo("container/rings").transform
	self._rings = {}

	self._ringsContainer:GetChild(0).gameObject:SetActive(false)

	self._btnTips = self:getBtn("tips")
	self._btnContainer = self:getBtn("container")
	self._btnDetail = self:getBtn("btn_detail")
	self._max = self:getGo("max")
	self._imgProgress = goutil.findChildComponent(self.mainGO, "container/imgProgress", goutil.Type_UIImage)
	self._imgChangeProgress = self._imgProgress.gameObject:GetComponent("UIImageSpriteChange")
	self._btnOneStarUp = self:getBtn("btnOneStarUp")
	self._oneName = self:getTxt("btnOneStarUp/txtName")
	self.materialGo = self:getGo("material")
	self.txtDesc = self:getTxt("material/cost/txtTip")
	self.txtDescGo = self:getGo("material/cost/txtTip")
	self.txtDescIcon = self:getGo("material/cost/txtTip/icon")
	self.cellL = self:getGo("material/cost/cellL")
	self.txtCountL = self:getTxt("material/cost/cellL/txtCount")
	self.itemL = self:getGo("material/cost/cellL/item")
	self.txtCountR = self:getTxt("material/cost/cellR/txtCount")
	self.cellR = self:getGo("material/cost/cellR")
	self.itemR = self:getGo("material/cost/cellR/item")
	self.btnAwake = self:getGo("material/cost/btnAwake")
	self.txtAwake = self:getTxt("material/cost/btnAwake/Text")
	self._redPoint = self:getGo("material/cost/btnAwake/red_point")
	self._progress = self:getImg("material/cost/btnAwake/progress")
	self._btnLongPressHelper = BtnLongPressHelper.create(self.btnAwake)

	GameUtil.SetActive(self._progress, false)

	self._btnOneKey = self:getGo("material/onekey/btnOneKey")
	self._txtBtnOneKey = self:getTxt("material/onekey/btnOneKey/txtBtnOneKey")
	self._txtOneKeyCost = self:getTxt("material/onekey/txtOneKeyCost")
	self._onekey = self:getGo("material/onekey")

	GameUtil.SetActive(self._onekey, false)

	self._customInput = UICustomInput.Get(self._onekey)
end

function AceteamawakeView:_updateCell(view, cell, data, tag)
	return
end

function AceteamawakeView:_clearCell(cell)
	return
end

function AceteamawakeView:onCellClick(data, canMerge, matType, cfgId)
	return
end

function AceteamawakeView:checkCanUseMat(data)
	return true
end

function AceteamawakeView:onLessClick(data)
	return
end

function AceteamawakeView:onEnter()
	AceteamawakeView.super.onEnter(self)

	self._costCoinCfg = MaterialMgr.getMatCfg(MatType.Coin, MatType.Coin_Dust)
	self._starEffs = {}
	self._ringEffs = {}

	self:_updateUINew()
	GlobalDispatcher:addListener(GlobalNotify.PM_ACETEAM_PETAWAKEN, self.onGetMsg, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ACETEAM_GETINFO, self.onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ACETEAM_PETCHANGE, self.onRefreshUI, self)
end

function AceteamawakeView:onRefreshUI()
	self:_updateUINew()
end

function AceteamawakeView:onGetMsg(status, msg)
	GameUtil.clickEnabled(true, self)
end

function AceteamawakeView:updateList(mo)
	local list = {}

	self.petList = {}
	self.raceList = {}
	self.baseList = {}

	local awakeLevel = mo.awakeLevel
	local petCfg = CharacterConfig.instance:getPetCo(mo.raceId)
	local costCfg = CharacterConfig.instance:getPetAwakenCostCfg(checknumber(petCfg.awakenCostStrategyId), awakeLevel + 1)

	if costCfg then
		local raceList, baseList = ItemConfig.instance:getReplaceItemCfgList(mo)

		self.raceList = raceList
		self.baseList = baseList

		for i, v in ipairs(baseList) do
			table.insert(list, v)
		end

		for i, v in ipairs(raceList) do
			table.insert(list, v)
		end

		local upType = costCfg.petCostType
		local pets = BagModel.instance:getBagPets()

		for i, v in ipairs(pets) do
			if v.petId ~= mo.petId and v.awakeLevel == costCfg.needPetAwakenLv then
				local cfg = CharacterConfig.instance:getPetCo(v.raceId)

				if upType == GameEnum.PetStarUpStrategy.RaceId then
					if v.raceId == mo.raceId then
						table.insert(list, v)
						table.insert(self.petList, v)
					end
				elseif upType == GameEnum.PetStarUpStrategy.Attr then
					if PetSkinConfig.instance:checkIsSameFirstEleAttr(v.curFaceId, mo.curFaceId) then
						table.insert(list, v)
						table.insert(self.petList, v)
					end
				elseif upType == GameEnum.PetStarUpStrategy.Job then
					local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(v.curFaceId)

					if PetSkinConfig.instance:checkHasJob(mo.curFaceId, firstJobIdx) then
						table.insert(list, v)
						table.insert(self.petList, v)
					end
				end
			end
		end

		if #self.petList == 0 then
			local tempMo = mo:GetClone()

			tempMo.curFaceId = checknumber(mo.raceId)

			table.insert(list, tempMo)
		end
	end

	GameUtil.SetActive(self.emptyGo, #list == 0)
end

function AceteamawakeView:_updateUINew()
	self.petMo = AceTeamModel.instance:getCurrPetMo()
	self.selectItems = {}
	self.selectPets = {}

	local awakeLevel = self.petMo.awakeLevel

	self._curRareCfg = CharacterConfig.instance:getAwakenRareCfg(awakeLevel)
	self._petCfg = CharacterConfig.instance:getPetCo(self.petMo.raceId)

	self:_updateCostCoin()
	self:_clearNextEffs()
	self:_updateStars()
	self:_updateRings()
	self:_updateTips()
	goutil.setActive(self._redPoint, false)
	self._btnOneStarUp.gameObject:SetActive(false)

	local num = -1
	local list = AceTeamConfig.instance:getAwakenCfgList()
	local lv = self.petMo.awakeLevel

	for i, v in ipairs(list) do
		if lv < v.level then
			num = v.point

			break
		end
	end

	GameUtil.SetActive(self.txtDescGo, num > 0)

	self.txtDesc.text = langPara("aceteamawakeview__10", num)

	MaterialMgr.setIcon(self.txtDescIcon, MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT)
end

function AceteamawakeView:_updateCostCoin()
	local awakeLevel = self.petMo.awakeLevel

	self._costCfg = AceTeamConfig.instance:getPetAwakenCostCfg(awakeLevel + 1)
	self._isMaxAwaken = self._costCfg == nil

	goutil.setActive(self._max, self._isMaxAwaken)
	GameUtil.SetActive(self.materialGo, not self._isMaxAwaken)
end

function AceteamawakeView:_updateTips()
	self.txtAwake.text = self._curRareCfg.upBtnText
end

function AceteamawakeView:_updateStars()
	for i = 1, #self._stars do
		local star = self._stars[i]
		local isActive = i <= self._curRareCfg.starNum
		local imgStar = goutil.findChild(star, "Image")

		goutil.setActive(imgStar, isActive)
	end

	local url = "fx_ui_shengxing/fx_ui_shengxing_baoshi.prefab"

	self:_updateEffList(url, self._stars, self._starEffs, self._curRareCfg.starNum)

	local nextRareCfg = CharacterConfig.instance:getAwakenRareCfg(self.petMo.awakeLevel + 1)

	if nextRareCfg and nextRareCfg.starNum ~= self._curRareCfg.starNum then
		print("curStarNum = " .. self._curRareCfg.starNum .. "nextStarNum = " .. nextRareCfg.starNum)

		local star = self._stars[nextRareCfg.starNum]

		self._nextStarEff = self:_checkAndGetEff("fx_ui_shengxing/fx_ui_shengxing_huxi_shuijing.prefab", star)
	end
end

function AceteamawakeView:_clearNextEffs()
	if self._nextStarEff then
		UIEffectManager.instance:stopEffect(self._nextStarEff)
	end

	self._nextStarEff = nil

	if self._nextRingEff then
		UIEffectManager.instance:stopEffect(self._nextRingEff)
	end

	self._nextRingEff = nil
end

function AceteamawakeView:_updateRings()
	local maxRingNum = self._curRareCfg.totalRingNum
	local activeRingNum = self._curRareCfg.ringNum
	local radius = 165
	local i = 1

	if self._loopEff then
		UIEffectManager.instance:stopEffect(self._loopEff)

		self._loopEff = nil
	end

	if maxRingNum == 0 then
		self._imgProgress.fillAmount = 0
	elseif self._isMaxAwaken then
		local url = "fx_ui_shengxing/fx_ui_shengxing_zuizhong_loop.prefab"

		self._loopEff = self:_playEffect(url, nil, self._starsContainer)
		self._imgProgress.fillAmount = 1
	else
		self._imgProgress.fillAmount = (activeRingNum - 1) / maxRingNum
	end

	if maxRingNum == 1 then
		self._imgChangeProgress:SetState(0)
	elseif maxRingNum == 3 then
		self._imgChangeProgress:SetState(1)
	elseif maxRingNum == 4 then
		self._imgChangeProgress:SetState(2)
	end

	while i <= maxRingNum do
		local ring = self._rings[i]

		if ring == nil then
			local cloneGo = self._ringsContainer.transform:GetChild(0).gameObject

			ring = goutil.cloneAndSetParent(cloneGo, self._ringsContainer.transform, "ring")

			Framework.TransformUtil.SetLocalScale(ring.transform, 1, 1, 1)
			Framework.TransformUtil.SetLocalRotation(ring.transform, 0, 0, 0)

			ring = ring:GetComponent("UIImageSpriteChange")

			table.insert(self._rings, ring)
		end

		local isActive = i <= activeRingNum
		local x, y, z = Framework.TransformUtil.GetLocalPos(ring.transform, 0, 0, 0)
		local rad = (i - 1) / maxRingNum * 2 * math.pi

		Framework.TransformUtil.SetLocalPos(ring.transform, math.sin(rad) * radius, math.cos(rad) * radius, z)

		local imgSpriteChange = ring:GetComponent("UIImageSpriteChange")

		imgSpriteChange:SetState(isActive and 1 or 0)

		i = i + 1

		goutil.setActive(ring.gameObject, true)
	end

	while i <= #self._rings do
		goutil.setActive(self._rings[i].gameObject, false)

		i = i + 1
	end

	local url = "fx_ui_shengxing/fx_ui_shengxing_qiu.prefab"

	self:_updateEffList(url, self._rings, self._ringEffs, activeRingNum)

	if activeRingNum < maxRingNum then
		local ring = self._rings[activeRingNum + 1]

		if ring then
			self._nextRingEff = self:_checkAndGetEff("fx_ui_shengxing/fx_ui_shengxing_huxi_qiu.prefab", ring)
		end
	end
end

function AceteamawakeView:_checkAndGetEff(url, parent, effect, effList)
	local eff = effect
	local isCreate = false

	if eff == nil then
		eff = UIEffectManager.instance:playEffect(self, url, parent, 0, 0, true)

		if effList ~= nil then
			table.insert(effList, eff)
		end
	end

	eff:setParent(parent.transform)
	eff:setLocalPos(0, 0, 0)
	eff:setScale(1)
	eff:setLocalEulerAngle(0, 0, 0)

	return eff, isCreate
end

function AceteamawakeView:_updateEffList(url, parentList, effList, activeCount)
	for k, v in ipairs(parentList) do
		local eff

		if k <= activeCount then
			local eff, isCreate = self:_checkAndGetEff(url, v, effList[k], effList)
		end
	end

	activeCount = math.max(0, activeCount)

	while activeCount < #effList do
		local tail = #effList
		local eff = effList[tail]

		UIEffectManager.instance:stopEffect(eff)
		table.remove(effList, tail)
	end
end

function AceteamawakeView:_onBtnPressStartInTakeOff()
	self._progress.fillAmount = 0

	GameUtil.SetActive(self._progress, true)
end

function AceteamawakeView:_onBtnPressEndInTakeOff(pressTime)
	GameUtil.SetActive(self._progress, false)
end

function AceteamawakeView:_onBtnPressUpdateInTakeOff(deltaTime, pressTime)
	self._progress.fillAmount = Mathf.Min(pressTime / TriggerTime, 1)
end

function AceteamawakeView:_onBtnPressUpdateTimeOverOnce(pressTime)
	self._progress.fillAmount = 0

	GameUtil.SetActive(self._progress, false)

	if self._isMaxAwaken then
		TipsFacade.instance:openCommonTips(lang("aceteamawakeview__3"))
	else
		local list = AceTeamConfig.instance:getAwakenCfgList()
		local lv = self.petMo.awakeLevel
		local totalPoint = MaterialModel.instance:getMaterialsNumber(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT)
		local costPoint = 0
		local lastV

		for i, v in ipairs(list) do
			if lv < v.level then
				if totalPoint >= costPoint + v.point then
					costPoint = costPoint + v.point
					lastV = v
				else
					break
				end
			end
		end

		if lastV then
			self._costPoint = costPoint
			self._lastV = lastV

			GameUtil.SetActive(self._onekey, true)

			self._txtOneKeyCost.text = langPara("消耗：%s/%s积分", costPoint, totalPoint)
			self._txtBtnOneKey.text = langPara("觉醒到%s级", lastV.level)
		else
			TipsFacade.instance:openCommonTips(lang("aceteamawakeview__6"))
		end
	end
end

function AceteamawakeView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._onekey, false)
	end
end

function AceteamawakeView:_onClickOneKey()
	GameUtil.SetActive(self._onekey, false)

	local lv = self.petMo.awakeLevel
	local costPoint = self._costPoint
	local lastV = self._lastV
	local content = langPara("aceteamawakeview__4", costPoint, lv, lastV.level)

	TipsFacade.instance:openPopupCostMatViewNew(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT, costPoint, content, function()
		GameUtil.clickEnabled(false, self)
		AceTeamController.instance:sendAwakeLvlup(self.petMo.petId, lastV.level)
	end)
end

function AceteamawakeView:_onClickUpgrade()
	if self._isMaxAwaken then
		TipsFacade.instance:openCommonTips(lang("aceteamawakeview__3"))
	else
		local list = AceTeamConfig.instance:getAwakenCfgList()
		local lv = self.petMo.awakeLevel

		for i, v in ipairs(list) do
			if lv < v.level then
				local content = langPara("aceteamawakeview__4", v.point, lv, v.level)

				if list[i + 1] ~= nil then
					local obj = list[i + 1]

					content = content .. langPara("aceteamawakeview__5", v.level, obj.level, obj.point)
				end

				TipsFacade.instance:openPopupCostMatViewNew(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT, v.point, content, function()
					GameUtil.clickEnabled(false, self)
					AceTeamController.instance:sendAwakeLvlup(self.petMo.petId)
				end)

				return
			end
		end

		TipsFacade.instance:openCommonTips(lang("aceteamawakeview__6"))
	end
end

function AceteamawakeView:_awakeFail(msg)
	GameUtil.clickEnabled(true, self)
end

function AceteamawakeView:_onAwakeSuccess(msg)
	TipsFacade.instance:openCommonTips(lang("aceteamawakeview__11"))

	local preRareCfg = CharacterConfig.instance:getAwakenRareCfg(self._preMo.awakeLevel)
	local curRareCfg = CharacterConfig.instance:getAwakenRareCfg(self.petMo.awakeLevel)

	self._isOpenAwakeLvup = preRareCfg.starNum ~= curRareCfg.starNum

	if preRareCfg.ringNum >= 0 then
		local startVal = self._imgProgress.fillAmount
		local endVal = startVal + 1 / preRareCfg.totalRingNum

		self._showRingEffVal = endVal - 0.01
		self._hasShowRingEff = false

		if preRareCfg.ringNum + 1 >= preRareCfg.totalRingNum then
			endVal = 1
		end

		local duration = 1.5 * (endVal - startVal)

		self._tweener = TweenUtil.ValueTo(startVal, endVal, duration, function(val)
			self:_onTweenUpdate(val)
		end, function()
			self:_tryPlayStarEff()

			self._tweener = nil
		end, self)
	else
		self:_tryPlayStarEff()
	end
end

function AceteamawakeView:_onTweenUpdate(val)
	self._imgProgress.fillAmount = val

	if self._curRareCfg.ringNum >= 0 and val >= self._showRingEffVal and not self._hasShowRingEff then
		self._hasShowRingEff = true

		local url = "fx_ui_shengxing/fx_ui_shengxing_qiu.prefab"
		local ringIdx = self._curRareCfg.ringNum + 1
		local ring = self._rings[ringIdx]

		ring:GetComponent("UIImageSpriteChange"):SetState(1)
		self:_updateEffList(url, self._rings, self._ringEffs, ringIdx)
	end
end

function AceteamawakeView:_tryPlayStarEff()
	settimer(0.38, self._openLvupView, self, false)

	if self._isOpenAwakeLvup then
		local starIdx = self._curRareCfg.starNum
		local star = self._stars[self._curRareCfg.starNum]

		if star then
			self._flashEff = UIEffectManager.instance:playEffect(self, "fx_ui_shengxing/fx_ui_shengxing_baoshi_shan.prefab", star, 0, 0)

			self._flashEff:setParent(star.transform)
			self._flashEff:setLocalPos(0, 0, 0)
			self._flashEff:setScale(1)
			self._flashEff:setLocalEulerAngle(0, 0, 0)

			local url = "fx_ui_shengxing/fx_ui_shengxing_baoshi.prefab"

			self:_updateEffList(url, self._stars, self._starEffs, starIdx)

			local imgStar = goutil.findChild(star, "Image")

			goutil.setActive(imgStar, true)
		end
	end

	if self._curRareCfg.ringNum >= 0 then
		local url = "fx_ui_shengxing/fx_ui_shengxing_qiu.prefab"
		local ringIdx = self._curRareCfg.ringNum + 1
		local ring = self._rings[ringIdx]

		if ring then
			ring:GetComponent("UIImageSpriteChange"):SetState(1)
			self:_updateEffList(url, self._rings, self._ringEffs, ringIdx)
		end
	end
end

function AceteamawakeView:_openLvupView()
	GameUtil.clickEnabled(true, self)
	removetimer(self._openLvupView, self)
	self:_updateUINew()

	if self._isOpenAwakeLvup then
		-- block empty
	end
end

function AceteamawakeView:_playEffect(url, effs, parent, i)
	local eff

	if effs then
		eff = effs[i]
	end

	if eff == nil then
		eff = UIEffectManager.instance:playEffect(self, url, parent, 0, 0, true)

		eff:setParent(parent.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)
		eff:setLocalEulerAngle(0, 0, 0)

		if effs then
			table.insert(effs, eff)
		end
	end

	return eff
end

function AceteamawakeView:_onClickClose()
	self:close()
end

function AceteamawakeView:_onClickDetail()
	UIStateManager.instance:push(ViewName.PetAwakeListView, self.petMo)
end

function AceteamawakeView:_onClickJump()
	return
end

function AceteamawakeView:_updateOneStartUp()
	return
end

function AceteamawakeView:_onClickOneStartUp()
	return
end

function AceteamawakeView:_onClickCoin()
	return
end

function AceteamawakeView:_onClickPetSource()
	return
end

return AceteamawakeView
