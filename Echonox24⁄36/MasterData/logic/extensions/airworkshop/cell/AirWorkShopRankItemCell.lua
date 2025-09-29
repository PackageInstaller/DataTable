-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/cell/AirWorkShopRankItemCell.lua

module("logic.extensions.airworkshop.cell.AirWorkShopRankItemCell", package.seeall)

local M = class("AirWorkShopRankItemCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
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
	local mainGO = self:getMainGo()
	local registry = self:getRegistry()

	self._goDiNormal = registry:findUIElement("challenge_schema_rank_item_-269908492")
	self._goDiPlayer = registry:findUIElement("challenge_schema_rank_item_-963288694")
	self._imgRankBg = registry:findUIElement("challenge_schema_rank_item_-254507198", UIComponentType.Image)

	goutil.setActive(self._imgRankBg.gameObject, true)

	self._txtRank = registry:findUIElement("challenge_schema_rank_item_-2064346593", UIComponentType.Text)
	self._goNotListed = registry:findUIElement("challenge_schema_rank_item_1558120156")
	self._txtPlayerName = registry:findUIElement("challenge_schema_rank_item_1324384720", UIComponentType.Text)
	self._txtWinNum = registry:findUIElement("challenge_schema_rank_item_-1151264344", UIComponentType.Text)
	self._imgHeroIcon = registry:findUIElement("challenge_schema_rank_item_911844797", UIComponentType.Image)
	self._btnPlayer = UIComponentType.ButtonAdapter(registry:findUIElement("challenge_schema_rank_item_-1927861931"))
end

function M:destroyUI()
	self:setHandler(nil)

	self.mainGO = nil
	self._txtRank = nil
	self._txtPlayerName = nil
	self._txtWinNum = nil
	self._imgHeroIcon = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = false
	end
end

function M:bindEvents()
	self._btnPlayer:AddClickListener(self._onClickPlayer, self)
end

function M:unbindEvents()
	self._btnPlayer:RemoveClickListener()
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:_onClickPlayer()
	if not self._data then
		return
	end

	if self._data:getUserId() == PlayerModel.instance:getId() then
		printWarn("自己点自己")

		return
	end

	local bindGo = self._btnPlayer.gameObject
	local uid = self._data:getUserId()
	local playerLv = self._data:getPlayerLv()
	local portrait = self._data:getPortrait()
	local nickName = self._data:getNickName()

	ToolTipsMgr.showPlayerInfoTips(bindGo, uid, playerLv, portrait, nickName)
end

function M:updateData(data)
	self._data = data

	local rank = 0
	local name = ""
	local winCount = 0
	local isSelf = false

	if data then
		isSelf = data:getUserId() == PlayerModel.instance:getId()
		rank = data:getRank()
		name = data:getNickname()
		winCount = data:getWinNum()
	end

	self._txtRank.text = rank
	self._txtPlayerName.text = name
	self._txtWinNum.text = winCount
	self._imgRankBg.color = rank <= 3 and parsecolor("#FFFFFF") or parsecolor("#FFFFFF00")

	if data then
		local portraitCO = BackpackConfig.instance:getItemInfoByItemId(data:getPortrait())

		if portraitCO then
			IconLoader.setSprite(self._imgHeroIcon, IconType.PlayerInfoMask, portraitCO.icon)
		end
	end

	goutil.setActive(self._goDiNormal, not isSelf)
	goutil.setActive(self._goDiPlayer, isSelf)
	goutil.setActive(self._goNotListed, rank == 0)
end

return M
