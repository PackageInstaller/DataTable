-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/cell/AirWorkShopRodeoRankItemCell.lua

module("logic.extensions.airworkshop.cell.AirWorkShopRodeoRankItemCell", package.seeall)

local M = class("AirWorkShopRodeoRankItemCell")

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
	local mainGO = self:getMainGo()

	self._goDiNormal = goutil.findChild(mainGO, "imgPlayerDi").gameObject
	self.goRankMark = {
		goutil.findChild(mainGO, "normal/first").gameObject,
		goutil.findChild(mainGO, "normal/second").gameObject,
		goutil.findChild(mainGO, "normal/third").gameObject
	}
	self._txtRank = goutil.findChildComponent(mainGO, "normal/txtRankNum", UIComponentType.Text)
	self._goNotListed = goutil.findChild(mainGO, "normal/txtNotListed").gameObject
	self._txtPlayerName = goutil.findChildComponent(mainGO, "normal/txtPlayerName", UIComponentType.Text)
	self._imgHeroIcon = goutil.findChildComponent(mainGO, "normal/head_item/headIcon", UIComponentType.Image)
	self._btnPlayer = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "normal/head_item/click").gameObject)
	self._imgLv1 = goutil.findChildComponent(mainGO, "normal/objLevel/imgLevel1", UIComponentType.Image)
	self._imgLv2 = goutil.findChildComponent(mainGO, "normal/objLevel/imgLevel1/imgLevel2", UIComponentType.Image)
	self._imgLv2Bg = goutil.findChildComponent(mainGO, "normal/objLevel/imgLevel1/imgQuality", UIComponentType.Image)
	self._txtLvName = goutil.findChildComponent(mainGO, "normal/objLevel/txtLevel", UIComponentType.Text)
	self._txtScore = goutil.findChildComponent(mainGO, "normal/objLevel/txtScore", UIComponentType.Text)
end

function M:destroyUI()
	self:setHandler(nil)
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

function M:_onClickPlayer()
	if not self._data then
		return
	end

	if self._data:getUserId() == PlayerModel.instance:getId() then
		if enableLog then
			printWarn("自己点自己")
		end

		return
	end

	local bindGo = self._btnPlayer.gameObject
	local week = self._data:getWeek()
	local part = self._data:getPart()
	local rank = self._data:getRank()
	local uid = self._data:getUserId()
	local playerLv = self._data:getPlayerLv()
	local portrait = self._data:getPortrait()
	local nickName = self._data:getNickName()

	if enableLog then
		printWarn(string.format("week[%s]part[%s]rank[%s]uid[%s] %s", week, part, rank, uid, nickName))
	end

	ToolTipsMgr.showPlayerInfoTips(bindGo, uid, playerLv, portrait, nickName)
end

function M:updateData(data)
	self._data = data

	local rank = 0
	local name = ""
	local lvName
	local score = 0
	local isSelf = false
	local lv = 1

	if data then
		isSelf = data:getUserId() == PlayerModel.instance:getId()
		rank = data:getRank()
		name = data:getNickName()
		score = data:getAirScore()
		lv = data:getAirLv()
	end

	self._txtRank.text = rank
	self._txtPlayerName.text = name
	self._txtLvName.text = lvName
	self._txtScore.text = score

	AirWorkShopUtil.rodeoLvImgChange(lv, self._imgLv1, self._imgLv2, nil, self._imgLv2Bg)

	if data then
		local portraitCO = BackpackConfig.instance:getItemInfoByItemId(data:getPortrait())

		if portraitCO then
			IconLoader.setSprite(self._imgHeroIcon, IconType.PlayerInfoMask, portraitCO.icon)
		end
	end

	goutil.setActive(self._goDiNormal, isSelf)
	goutil.setActive(self._goNotListed, rank <= 0)
	goutil.setActive(self._txtRank.gameObject, self.goRankMark[rank] == nil and rank > 0)

	for _rank, _go in pairs(self.goRankMark) do
		goutil.setActive(_go, _rank == rank)
	end
end

return M
