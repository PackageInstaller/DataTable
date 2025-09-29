-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/cell/ClimbingTowerSideTabCell.lua

module("logic.extensions.climbingtower.cell.ClimbingTowerSideTabCell", package.seeall)

local M = class("ClimbingTowerSideTabCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
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

	self._canvasGroup = mainGO:GetComponent(ComponentType.CanvasGroup)
	self._normalGo = goutil.findChild(mainGO, "imgDi1")
	self._speciallGo = goutil.findChild(mainGO, "imgDi2")
	self._txtNumber = goutil.findChildTextComponent(mainGO, "txtNumber")
	self._txtDo = goutil.findChild(mainGO, "txtDone")
	self._objInvestigatable = goutil.findChild(mainGO, "objInvestigatable")
	self._lock = goutil.findChild(mainGO, "lock")
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "click"))
	self._itemCellGo = goutil.findChild(mainGO, "backpack_item")
	self._selectGo = goutil.findChild(mainGO, "select")
end

function M:destroyUI()
	self._normalGo = nil
	self._speciallGo = nil
	self._txtNumber = nil
	self._txtDo = nil
	self._objInvestigatable = nil
	self._lock = nil
	self._btnClick = nil
	self._itemCellGo = nil
	self._selectGo = nil
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickSelf, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	self:setSelected(false)
end

function M:onExit()
	self._handler = nil
	self._dungeonId = nil
	self._towerCfgId = nil
	self._entryTyp = nil

	self.mainGO:DOKill(false)
end

function M:getMainGo()
	return self.mainGO
end

function M:setHandler(handler)
	self._handler = handler
end

function M:setEntryTyp(entryTyp)
	self._entryTyp = entryTyp

	goutil.setActive(self._objInvestigatable.gameObject, entryTyp == ClimbingTowerEnum.EntryTyp.Normal)
	goutil.setActive(self._txtDo.gameObject, entryTyp == ClimbingTowerEnum.EntryTyp.Finish)
	goutil.setActive(self._lock.gameObject, entryTyp == ClimbingTowerEnum.EntryTyp.Lock)
end

function M:getEntryTyp()
	return self._entryTyp
end

function M:getIsLock()
	return self:getEntryTyp() == ClimbingTowerEnum.EntryTyp.Lock
end

function M:getDungeonId()
	return self._dungeonId
end

function M:getTowerCfgId()
	return self._towerCfgId
end

function M:setSelected(selected)
	goutil.setActive(self._selectGo.gameObject, selected)
end

function M:setData(dungeonData, isDark)
	self._dungeonId = dungeonData:getDungeonId()
	self._towerCfgId = dungeonData:getTowerCfgId()

	local entryTyp

	self._canvasGroup.alpha = 1

	if dungeonData:getIsLock() then
		entryTyp = ClimbingTowerEnum.EntryTyp.Lock
		self._canvasGroup.alpha = 0.4
	else
		entryTyp = dungeonData:getIsClear() and ClimbingTowerEnum.EntryTyp.Finish or ClimbingTowerEnum.EntryTyp.Normal
	end

	self:setEntryTyp(entryTyp)

	self._txtNumber.text = dungeonData:getIndex()

	self:setSpecialBossAndRewardFinish(dungeonData, isDark)
end

function M:setSpecialBossAndRewardFinish(dungeonData, isDark)
	local id = dungeonData:getTowerCfgId()
	local cfgBrightSideLst = {}
	local info = {}

	if isDark then
		cfgBrightSideLst = ClimbingTowerConfig.instance:getDarkList()
		info = cfgBrightSideLst[id]
	else
		cfgBrightSideLst = ClimbingTowerConfig.instance:getConfigList(ConfigName.LightMoonTower)
		info = cfgBrightSideLst[id]
	end

	goutil.setActive(self._speciallGo.gameObject, info.isBoss == 1)
	goutil.setActive(self._normalGo.gameObject, info.isBoss == 0)
	goutil.setActive(self._itemCellGo.gameObject, info.isRewardShow == 1)

	if info.isRewardShow == 1 then
		local _tmpTable = dungeonData:getAllFirstPassReward()
		local itemCell = Astral.LuaComponentContainer.Add(self._itemCellGo.gameObject, RewardCell)
		local _rewardStatus = dungeonData:hasPassed() and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot
		local rewardData = RewardData.New({
			code = _tmpTable[1].code,
			count = _tmpTable[1].num,
			rewardStatus = _rewardStatus
		})

		itemCell:updateData(rewardData)
		itemCell:getComponent("reward"):setRewardStatus(_rewardStatus)
	end
end

function M:_onClickSelf()
	if self._handler then
		self._handler:onEntryBrightTabClick(self)
	end
end

return M
