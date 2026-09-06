-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/settlement/AoqiHeroSettlementTeam.lua

module("logic.extensions.aoqihero.view.settlement.AoqiHeroSettlementTeam", package.seeall)

local AoqiHeroSettlementTeam = class("AoqiHeroSettlementTeam", BSAnimPlay)

function AoqiHeroSettlementTeam:buildUI(parent)
	AoqiHeroSettlementTeam.super.buildUI(self, parent)

	self._imgBgTarget = goutil.findChild(parent, "imgBgTarget"):GetComponent(goutil.Type_RectTransform)
	self._teamList = goutil.findChild(parent, "teamList"):GetComponent(goutil.Type_RectTransform)
	self._tableview = goutil.findChild(parent, "teamList"):GetComponent("UITableview")
	self._tableCell = goutil.findChild(parent, "teamList/itemPet")

	self._tableCell:SetActive(false)

	self._btnStatics = goutil.findChild(parent, "btnStatics")
end

function AoqiHeroSettlementTeam:onEnter(totalHeight, curPosY, delayTime, view, activityId)
	AoqiHeroSettlementTeam.super.onEnter(self, totalHeight, curPosY, delayTime)

	if self._isEntered then
		return self:_getDefault()
	end

	self._isEntered = true
	self._view = view
	self._activityId = activityId

	goutil.setActive(self._parent, true)
	self._tableview:SetOffsetWithoutRefresh(0)
	self:_addUnitToList()

	return self:getNextData()
end

function AoqiHeroSettlementTeam:onExit()
	self._isEntered = false
	self._view = nil

	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = {}

	self._tableview:UnRegisterAllCallbacks()

	if self._uiEffects then
		for k, v in pairs(self._uiEffects) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._uiEffects = nil
	end

	self:doKillTween()
	goutil.setActive(self._parent, false)
end

function AoqiHeroSettlementTeam:_addUnitToList()
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	self._curViewDatas = {}
	self._isPlayExpAnimation = false
	self._unitTime = 0.3
	self._tweens = {}
	self._uiEffects = {}
	self._expAnimTime = 0

	local attackTeamMo = AoQiHeroEntityMgr.instance:getTeamMo(AoQiHeroConst.AttackTeam)
	local isShowHp = false
	local units = attackTeamMo.pos

	self._curViewDatas = {}

	for i, v in ipairs(units) do
		local petMo = AoQiHeroEntityMgr.instance:getPet(v)
		local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, petMo.configId)
		local valueData = {}

		valueData.isDead = false
		valueData.isHaveExpUp = false
		valueData.raceId = petCfg.faceIds
		valueData.skinId = petCfg.faceIds
		valueData.isExpedition = false
		valueData.isShowHp = isShowHp
		valueData.level = petMo.level

		table.insert(self._curViewDatas, valueData)
	end

	for k, v in pairs(self._uiEffects) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._uiEffects = {}

	self._tableview:ReloadData()
end

function AoqiHeroSettlementTeam:_setHeight()
	self.height = self._parentRectTrans.rect.height

	Framework.TransformUtil.SetAnchoredPos(self._parentRectTrans, 0, self:_getCurPosY())
end

function AoqiHeroSettlementTeam:getMaxHeight()
	return self._parentRectTrans.rect.height
end

function AoqiHeroSettlementTeam:_setAnimCostTime()
	self.animCostTime = self._delayTime1 * 2 + self:getPlayExpNeedTime()
end

function AoqiHeroSettlementTeam:doTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 1500, -5)
	Framework.TransformUtil.SetAnchoredPos(self._teamList, 1500, self._teamList.anchoredPosition.y)

	if self._btnStatics then
		Framework.TransformUtil.SetAnchoredPos(self._btnStatics.transform, 1680, 54)
	end

	local curTime = self._time1
	local curDelay = self._delayTime1 + self:_getCurTimePoint()

	self._imgBgTarget:DOAnchorPosX(0, curTime):SetDelay(curDelay)

	if self._btnStatics then
		self._btnStatics.transform:DOAnchorPosX(160, curTime):SetDelay(curDelay)
	end

	curDelay = curDelay + self._delayTime1

	self._teamList:DOAnchorPosX(0, curTime):SetDelay(curDelay)

	curDelay = curDelay + self._delayTime1

	self:_playExpAnimation(curDelay + curTime)
end

function AoqiHeroSettlementTeam:doKillTween()
	AoqiHeroSettlementTeam.super.doKillTween(self)
	self._imgBgTarget:DOKill(true)
	self._teamList:DOKill(true)

	if self._btnStatics then
		self._btnStatics.transform:DOKill(true)
	end

	if self._tweens then
		for k, v in pairs(self._tweens) do
			v:Kill(true)
		end
	end

	if self._playOverTweener then
		self._playOverTweener:Kill(true)
	end
end

function AoqiHeroSettlementTeam:doCompleteTween()
	self:doKillTween()

	if self:isPlayingExpAnimation() then
		self:offExpAnimation()
	end

	if self._btnStatics then
		Framework.TransformUtil.SetAnchoredPos(self._btnStatics.transform, 160, 54)
	end

	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 0, -5)
	Framework.TransformUtil.SetAnchoredPos(self._teamList, 0, self._teamList.anchoredPosition.y)
end

function AoqiHeroSettlementTeam:_playExpAnimation(curDelay)
	self._playOverTweener = TweenUtil.DoDelay(curDelay, function()
		self._isPlayExpAnimation = true

		if self._uiEffects then
			for k, v in pairs(self._uiEffects) do
				UIEffectManager.instance:stopEffect(v)
			end
		end

		self._uiEffects = {}

		self._tableview:ReloadData()
	end)
end

function AoqiHeroSettlementTeam:isPlayingExpAnimation()
	return self._isPlayExpAnimation
end

function AoqiHeroSettlementTeam:offExpAnimation()
	self._isPlayExpAnimation = false
end

function AoqiHeroSettlementTeam:getPlayExpNeedTime()
	if self._expAnimTime > 0 then
		return self._expAnimTime + self._unitTime
	else
		return self._expAnimTime
	end
end

function AoqiHeroSettlementTeam:_numInView()
	return #self._curViewDatas
end

function AoqiHeroSettlementTeam:_cellSize()
	return 80, 80
end

function AoqiHeroSettlementTeam:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function AoqiHeroSettlementTeam:_updateCell(view, cell, data)
	local imgHead = goutil.findChild(cell, "imgHead")
	local txtLv = goutil.findChild(cell, "txtLv"):GetComponent(goutil.Type_UIText)
	local progressBar = goutil.findChild(cell, "progressBar"):GetComponent(typeof(ProgressBar))
	local imgTop = goutil.findChild(cell, "progressBar/Mask/imgTop"):GetComponent(typeof(UIImageSpriteChange))
	local effect = goutil.findChild(cell, "progressBar/Mask/imgTop/effect")
	local effectMaxLv = goutil.findChild(cell, "progressBar/Mask/effectMaxLv")
	local maskRect = goutil.findChild(progressBar, "Mask"):GetComponent(goutil.Type_RectTransform)
	local imgDead = goutil.findChild(cell, "imgDead")
	local hpBar = Framework.SliderAdapter.GetFrom(cell.gameObject, "hpBar")
	local vigourBar = Framework.SliderAdapter.GetFrom(cell.gameObject, "vigourBar")

	imgDead:SetActive(data.isDead)
	effect:SetActive(true)
	effectMaxLv:SetActive(false)
	imgTop:ChangeStateNow(0)
	progressBar.gameObject:SetActive(false)

	txtLv.text = data.level .. " 级"

	MaterialMgr.setIcon(imgHead, MatType.Pet, checknumber(data.skinId))
	hpBar.gameObject:SetActive(false)
	vigourBar.gameObject:SetActive(false)
end

function AoqiHeroSettlementTeam:_clearTableview(cell)
	local imgHead = goutil.findChild(cell, "imgHead")
	local img = Framework.ImageBigBG.Get(imgHead)

	img:ClearImage()

	img = nil
end

return AoqiHeroSettlementTeam
