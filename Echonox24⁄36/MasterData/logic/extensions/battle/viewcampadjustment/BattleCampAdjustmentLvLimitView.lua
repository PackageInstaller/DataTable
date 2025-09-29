-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcampadjustment/BattleCampAdjustmentLvLimitView.lua

module("logic.extensions.battle.viewcampadjustment.BattleCampAdjustmentLvLimitView", package.seeall)

local M = class("BattleCampAdjustmentLvLimitView", ViewComponent)
local LvLimitedKey = WordEnum.LvLimit

function M:buildUI()
	self._goHint = self:getGo("prewar_prepare_view_811380344")
	self._textTitle = self:getText("prewar_prepare_view_2134184565")
	self._textLv = self:getText("prewar_prepare_view_369042405")
	self._btnClick = self:getBtn("prewar_prepare_view_1409508561")
	self._btnBg = self:getBtn("prewar_prepare_view_-847714801")
	self._goTips = self:getGo("prewar_prepare_view_521432888")
	self._textTipsTitle = self:getText("prewar_prepare_view_897087524")
	self._textTipsDesc = self:getText("prewar_prepare_view_565509590")

	goutil.setActive(self._goHint, false)
	goutil.setActive(self._goTips, false)

	self._wordCo = WordConfig.instance:getWordCO(LvLimitedKey)
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickItem, self)
	self._btnBg:AddClickListener(self._onClickBg, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
	self._btnBg:RemoveClickListener()
end

function M:onEnter()
	self:_refresh()
	self:_setEvent(true)
end

function M:onExit()
	self:_setEvent(false)
end

function M:destroyUI()
	self._wordCo = nil
end

function M:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.Adjustment_OnAvailableHeroListUpdate, self._onAvailableHeroListUpdate, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.Adjustment_OnAvailableHeroListUpdate, self._onAvailableHeroListUpdate, self)
	end
end

function M:_onAvailableHeroListUpdate()
	self:_refresh()
end

function M:_refresh()
	local dungeonId = BattleEnterUtil.getCurrentDungeonCode()

	if dungeonId == nil then
		return
	end

	local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonId, false)

	if dungeonMO and DungeonUtil.isControlAction(dungeonMO:getType()) then
		local limitCo = ControlActionConfig.instance:getMonitorDungeonLimitCfg(dungeonId)

		if limitCo.heroLvLimit > 0 then
			local isLimited = self:_isCurrentTeamHeroLimited(limitCo.heroLvLimit)

			if isLimited then
				self._textTitle.text = self._wordCo.name
				self._textLv.text = string.format("LV.%s", limitCo.heroLvLimit)
				self._textTipsTitle.text = self._wordCo.name
				self._textTipsDesc.text = string.format(self._wordCo.desc, limitCo.heroLvLimit)
			end

			goutil.setActive(self._goHint, isLimited)
		end
	end
end

function M:_isCurrentTeamHeroLimited(lvLimit)
	local heroIdList = BattleCampAdjustmentModel.instance:getCurrentTeamCharacterCodeList()

	for _, heroId in ipairs(heroIdList) do
		local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)
		local level = heroMO:getLevel()

		if lvLimit < level then
			return true
		end
	end

	return false
end

function M:_onClickItem()
	goutil.setActive(self._goTips, not self._goTips.activeSelf)
end

function M:_onClickBg()
	goutil.setActive(self._goTips, false)
end

return M
