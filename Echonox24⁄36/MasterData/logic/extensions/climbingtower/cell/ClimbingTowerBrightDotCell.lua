-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/cell/ClimbingTowerBrightDotCell.lua

module("logic.extensions.climbingtower.cell.ClimbingTowerBrightDotCell", package.seeall)

local M = class("ClimbingTowerBrightDotCell")
local Padding = 500
local BrightPadding = 22
local DarkPadding = 108
local cellHalfWidth = 60

function M:ctor(compContainer)
	self.mainGO = compContainer
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local mainGO = self.mainGO

	self._topGo = goutil.findChild(mainGO, "top")
	self._topCanvasGroup = self._topGo.gameObject:GetComponent(ComponentType.CanvasGroup)
	self._downGo = goutil.findChild(mainGO, "down")
	self._txtNumber1 = goutil.findChildTextComponent(mainGO, "top/state1/txt1")
	self._txtNumber2 = goutil.findChildTextComponent(mainGO, "top/state2/txt1")
	self._txtNumber3 = goutil.findChildTextComponent(mainGO, "top/state3/txtNumber")
	self._line = goutil.findChild(mainGO, "top/line")
	self._lineCanvasGroup = self._line.gameObject:GetComponent(ComponentType.CanvasGroup)
	self._normalLeft = goutil.findChild(mainGO, "top/normalLeft")
	self._normalRight = goutil.findChild(mainGO, "top/normalRight")
	self._selectLeft = goutil.findChild(mainGO, "top/selectLeft")
	self._selectRight = goutil.findChild(mainGO, "top/selectRight")
	self._noramalRightX = 24
	self._selectRigtX = 65
	self._state1 = goutil.findChild(mainGO, "top/state1")
	self._state2 = goutil.findChild(mainGO, "top/state2")
	self._state3 = goutil.findChild(mainGO, "top/state3")
	self._done = goutil.findChild(mainGO, "top/state1/imgDone")
	self._doneSp = goutil.findChild(mainGO, "top/state2/imgDone")
	self._lock = goutil.findChild(mainGO, "top/state1/imgLock")
	self._lockSp = goutil.findChild(mainGO, "top/state2/imgLock")
	self._txtNumber = goutil.findChildTextComponent(mainGO, "down/txtNumber")
	self._imageSp = goutil.findChild(mainGO, "down/imgSpecial")
	self._txtNumberSp = goutil.findChildTextComponent(mainGO, "down/imgSpecial/txtNumber")
	self._rewardListGo = goutil.findChild(mainGO, "down/rewardGroup")
	self._rewardPrefab = goutil.findChild(mainGO, "down/rewardGroup/backpack_item")

	goutil.setActive(self._rewardPrefab.gameObject, false)

	self._btnClickOpen = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "down/rewardGroup/btnOpen"))
	self._btnOpen = goutil.findChild(mainGO, "down/rewardGroup/btnOpen/img1")
	self._btnClose = goutil.findChild(mainGO, "down/rewardGroup/btnOpen/img2")
end

function M:destroyUI()
	self._topGo = nil
	self._topCanvasGroup = nil
	self._downGo = nil
	self._line = nil
	self._normalLeft = nil
	self._normalRight = nil
	self._selectLeft = nil
	self._selectRight = nil
	self._state1 = nil
	self._state2 = nil
	self._state3 = nil
	self._done = nil
	self._doneSp = nil
	self._txtNumber = nil
	self._imageSp = nil
	self._txtNumberSp = nil
	self._rewardListGo = nil
	self._rewardPrefab = nil
end

function M:setHandler(handler)
	self._handler = handler
end

function M:bindEvents()
	self._btnClickOpen:AddClickListener(self._onClickReward, self)
end

function M:unbindEvents()
	self._btnClickOpen:RemoveClickListener()
end

function M:onEnter()
	self:setDown(false)
end

function M:onExit()
	self._handler = nil
	self._dugeonData = nil
	self._dungeonId = nil
	self._towerCfgId = nil
	self._entryTyp = nil
	self._towerinfo = nil
	self._dotPos = nil
end

function M:getMainGo()
	return self.mainGO
end

function M:updateData(motable, isDark)
	self._dugeonData = motable.dungeonData
	self._dungeonId = motable.dungeonData:getDungeonId()
	self._towerCfgId = motable.dungeonData:getTowerCfgId()
	self._islastone = motable.lastone
	self._dotPos = motable.dotPos
	self._isrewardView = motable.isrewardView
	self._isOpen = false

	local entryTyp

	if motable.dungeonData:getIsLock() then
		entryTyp = ClimbingTowerEnum.EntryTyp.Lock
	else
		entryTyp = motable.dungeonData:getIsClear() and ClimbingTowerEnum.EntryTyp.Finish or ClimbingTowerEnum.EntryTyp.Normal
	end

	self:setEntryTyp(entryTyp)

	self._txtNumber1.text = motable.dungeonData:getIndex()
	self._txtNumber2.text = motable.dungeonData:getIndex()
	self._txtNumber3.text = motable.dungeonData:getIndex()
	self._txtNumber.text = motable.dungeonData:getIndex()
	self._txtNumberSp.text = motable.dungeonData:getIndex()

	self:setSpecialBossAndHight(motable.dungeonData, isDark)

	if isDark then
		Padding = DarkPadding
	else
		Padding = BrightPadding
	end

	if self._isrewardView then
		self:_refreshRewardList(motable.dungeonData)
		self:_setCanOpenInit()

		self._selectRigtX = 65
		self._noramalRightX = 24

		Astral.TransformUtil.SetLocalScale(self._state1.transform, 1, 1, 1)
		Astral.TransformUtil.SetLocalScale(self._state3.transform, 1, 1, 1)
		Astral.TransformUtil.SetLocalScale(self._state2.transform, 1, 1, 1)
	else
		Astral.TransformUtil.SetLocalScale(self._state1.transform, 0.5, 0.5, 1)
		Astral.TransformUtil.SetLocalScale(self._state3.transform, 0.5, 0.5, 1)
		Astral.TransformUtil.SetLocalScale(self._state2.transform, 0.5, 0.5, 1)

		self._selectRigtX = 32.5
		self._noramalRightX = 12
	end

	goutil.setActive(self._topGo.gameObject, true)
	goutil.setActive(self._downGo.gameObject, self._isrewardView)
end

function M:setEntryTyp(entryTyp)
	goutil.setActive(self._done.gameObject, false)
	goutil.setActive(self._doneSp.gameObject, false)
	goutil.setActive(self._lock.gameObject, false)
	goutil.setActive(self._lockSp.gameObject, false)

	self._topCanvasGroup.alpha = 1
	self._lineCanvasGroup.alpha = 1

	if entryTyp == ClimbingTowerEnum.EntryTyp.Finish then
		self._topCanvasGroup.alpha = 0.4

		goutil.setActive(self._done.gameObject, true)
		goutil.setActive(self._doneSp.gameObject, true)
	elseif entryTyp == ClimbingTowerEnum.EntryTyp.Normal then
		-- block empty
	elseif ClimbingTowerEnum.EntryTyp.Lock then
		self._topCanvasGroup.alpha = 0.5
		self._lineCanvasGroup.alpha = 0.2

		goutil.setActive(self._lock.gameObject, true)
		goutil.setActive(self._lockSp.gameObject, true)
	end
end

function M:setFalse()
	goutil.setActive(self._downGo.gameObject, false)
	goutil.setActive(self._topGo.gameObject, false)
end

function M:setDown(isShow)
	if isShow then
		goutil.setActive(self._downGo.gameObject, true)
	else
		goutil.setActive(self._downGo.gameObject, false)
	end
end

function M:setSpecialBossAndHight(dungeonData, isDark)
	local cfgBrightSideLst = {}

	if isDark then
		cfgBrightSideLst = ClimbingTowerConfig.instance:getDarkList()
		self._towerinfo = cfgBrightSideLst[self._towerCfgId]
	else
		cfgBrightSideLst = ClimbingTowerConfig.instance:getConfigList(ConfigName.LightMoonTower)
		self._towerinfo = cfgBrightSideLst[self._towerCfgId]
	end

	goutil.setActive(self._state1.gameObject, self._towerinfo.isBoss == 0)
	goutil.setActive(self._state2.gameObject, self._towerinfo.isBoss == 1)
	goutil.setActive(self._txtNumber.gameObject, self._towerinfo.isBoss == 0)
	goutil.setActive(self._imageSp.gameObject, self._towerinfo.isBoss == 1)
	goutil.setActive(self._state3.gameObject, false)
	Astral.TransformUtil.SetLocalPos(self._topGo.transform, self._topGo.transform.localPosition.x, self._dotPos, 0)
end

function M:_clearRewardLstPrefab()
	return
end

function M:getTowerInfo()
	return self._towerinfo
end

function M:getDotPos()
	return self._dotPos
end

function M:getNormalLeftLine()
	return self._normalLeft
end

function M:getNoramlRightLine()
	return self._normalRight
end

function M:getSelectLeftLine()
	return self._selectLeft
end

function M:getSelectRightLine()
	return self._selectRight
end

function M:_refreshRewardList(dungeonMo)
	self._tmpTable = {}

	for i, reward in ipairs(dungeonMo:getAllFirstPassReward()) do
		table.insert(self._tmpTable, ItemUtil.createItemData({
			itemId = reward.code,
			count = reward.num
		}))
	end

	if #self._tmpTable > 0 then
		table.sort(self._tmpTable, ItemUtil.commonSortFunc)

		while self._rewardListGo.transform.childCount - 2 < #self._tmpTable do
			goutil.cloneAndSetParent(self._rewardPrefab, self._rewardListGo.transform)
		end

		for i = 2, self._rewardListGo.transform.childCount - 1 do
			local obj = self._rewardListGo.gameObject.transform:GetChild(i).gameObject
			local show = i - 2 < #self._tmpTable

			goutil.setActive(obj, show)

			if show then
				local _itemData = self._tmpTable[i - 1]
				local objBeh = Astral.LuaComponentContainer.Add(obj, RewardCell)
				local _rewardStatus = dungeonMo:hasPassed() and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot
				local rewardData = RewardData.New({
					code = _itemData:getItemId(),
					count = _itemData:getCount(),
					rewardStatus = _rewardStatus,
					itemSign = CommEnum.BackPackItemSignTyp.First
				})

				objBeh:updateData(rewardData)
				objBeh:getComponent("reward"):setRewardStatus(_rewardStatus)
			end
		end
	end
end

function M:_setCanOpenInit()
	local childCount = #self._tmpTable

	if childCount > 1 then
		for i = 3, self._rewardListGo.transform.childCount - 1 do
			goutil.setActive(self._rewardListGo.transform:GetChild(i).gameObject, false)
		end

		goutil.setActive(self._btnClickOpen.gameObject, true)
	else
		goutil.setActive(self._btnClickOpen.gameObject, false)
	end

	goutil.setActive(self._btnOpen.gameObject, not self._isOpen)
	goutil.setActive(self._btnClose.gameObject, self._isOpen)
end

function M:_onClickReward()
	self._isOpen = not self._isOpen

	if self._isOpen then
		local childCount = #self._tmpTable

		for i = 1, childCount + 1 do
			goutil.setActive(self._rewardListGo.transform:GetChild(i).gameObject, true)
		end
	else
		self:_setCanOpenInit()
	end

	goutil.setActive(self._btnOpen.gameObject, not self._isOpen)
	goutil.setActive(self._btnClose.gameObject, self._isOpen)
end

function M:setSelected(isSelect)
	self._isSelect = isSelect
end

function M:getSelected()
	return self._isSelect
end

function M:setSelectedState(ptable)
	if self._isSelect then
		self:setLineSelcet(ptable)
		goutil.setActive(self._state1.gameObject, false)
		goutil.setActive(self._state2.gameObject, false)
		goutil.setActive(self._state3.gameObject, true)

		self._topCanvasGroup.alpha = 1
	else
		self:setLineNoraml(ptable)
		goutil.setActive(self._state1.gameObject, self._towerinfo.isBoss == 0)
		goutil.setActive(self._state2.gameObject, self._towerinfo.isBoss == 1)
		goutil.setActive(self._state3.gameObject, false)
	end
end

function M:setLineNoraml(ptable)
	if not self._islastone and ptable then
		local length = 0
		local angel = 0
		local xPos = self._noramalRightX
		local xSelcetPos = self._selectRigtX
		local pos1 = {
			x = xPos,
			y = self._dotPos
		}
		local pos2 = {}

		if ptable.isnextSelect then
			pos2 = {
				x = xPos + Padding + (cellHalfWidth - xPos) + (cellHalfWidth - xSelcetPos),
				y = ptable.pos
			}
		else
			pos2 = {
				x = xPos + Padding + (cellHalfWidth - xPos) * 2,
				y = ptable.pos
			}
		end

		length, angel = self:getLineWidthAndRotation(pos1, pos2)

		Astral.TransformUtil.SetLocalPos(self._line.transform, xPos, 0, 0)
		Astral.TransformUtil.SetLocalRotation(self._line.transform, 0, 0, angel)
		RectTransformUtils.SetWidth(self._line.transform, length)
		goutil.setActive(self._line.gameObject, true)
	else
		goutil.setActive(self._line.gameObject, false)
	end
end

function M:setLineSelcet(ptable)
	if not self._islastone and ptable then
		local length = 0
		local angel = 0
		local xPos = self._selectRigtX
		local xNoramlPos = self._noramalRightX
		local pos1 = {
			x = xPos,
			y = self._dotPos
		}
		local pos2 = {
			x = xPos + Padding + (cellHalfWidth - xNoramlPos) + (cellHalfWidth - xPos),
			y = ptable.pos
		}

		length, angel = self:getLineWidthAndRotation(pos1, pos2)

		Astral.TransformUtil.SetLocalPos(self._line.transform, xPos, 0, 0)
		Astral.TransformUtil.SetLocalRotation(self._line.transform, 0, 0, angel)
		RectTransformUtils.SetWidth(self._line.transform, length)
		goutil.setActive(self._line.gameObject, true)
	else
		goutil.setActive(self._line.gameObject, false)
	end
end

function M:getLineWidthAndRotation(pos1, pos2)
	local position1 = pos1
	local position2 = pos2
	local xValue = 0
	local yValue = 0

	if position1.x > 0 and position2.x > 0 or position1.x < 0 and position2.x < 0 then
		xValue = Mathf.Abs(position1.x - position2.x)
	else
		xValue = Mathf.Abs(position1.x) + Mathf.Abs(position2.x)
	end

	if position1.y > 0 and position2.y > 0 or position1.y < 0 and position2.y < 0 then
		yValue = Mathf.Abs(position1.y - position2.y)
	else
		yValue = Mathf.Abs(position1.y) + Mathf.Abs(position2.y)
	end

	local length = Mathf.Sqrt(xValue * xValue + yValue * yValue)
	local angel = 0

	if position1.x <= position2.x and position1.y <= position2.y then
		angel = Mathf.Atan(yValue / xValue) / Mathf.PI * 180
	elseif position1.x >= position2.x and position1.y <= position2.y then
		angel = 180 - Mathf.Atan(yValue / xValue) / Mathf.PI * 180
	elseif position1.x >= position2.x and position1.y >= position2.y then
		angel = -180 + Mathf.Atan(yValue / xValue) / Mathf.PI * 180
	else
		angel = 0 - Mathf.Atan(yValue / xValue) / Mathf.PI * 180
	end

	return length, angel
end

return M
