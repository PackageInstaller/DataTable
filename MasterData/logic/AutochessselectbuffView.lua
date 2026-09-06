-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessselectbuffView.lua

module("logic.extensions.autochess.view.AutochessselectbuffView", package.seeall)

local AutochessselectbuffView = class("AutochessselectbuffView", ViewComponent)

function AutochessselectbuffView:ctor()
	AutochessselectbuffView.super.ctor(self)
end

function AutochessselectbuffView:unbindEvents()
	AutochessselectbuffView.super.unbindEvents(self)
	self._btnGet:RemoveClickListener()
end

function AutochessselectbuffView:bindEvents()
	AutochessselectbuffView.super.bindEvents(self)
	self._btnGet:AddClickListener(self._onClickbtnGet, self)
end

function AutochessselectbuffView:buildUI()
	AutochessselectbuffView.super.buildUI(self)

	self._singleLinePlayer = self:getGo("playercon"):GetComponent(ComponentType.UILayoutSingleLine)
	self._tablecellGo = self:getGo("tablecell")
	self._playerconGo = self:getGo("playercon")
	self._playercellGo = self:getGo("playercell")
	self._buffcellGo = self:getGo("buffcell")
	self._buffconGo = self:getGo("buffcon")
	self._btnGet = self:getBtn("btnGet")
	self._txtSelectDesc = self:getTxt("txtSelectDesc")
	self._playerItemGroup = ItemGroup.New(self._playerconGo, self._playercellGo, nil, nil, true, self._clearPlayerCell, self)
	self._buffItemGroup = ItemGroup.New(self._buffconGo, self._buffcellGo, nil, nil, true, self._clearBuffCell, self)

	goutil.setActive(self._playercellGo, false)
	goutil.setActive(self._buffcellGo, false)
end

function AutochessselectbuffView:onExit()
	AutochessselectbuffView.super.onExit(self)
	self._playerItemGroup:dispose()
	self._buffItemGroup:dispose()
	removetimer(self._tick, self)
end

function AutochessselectbuffView:onEnter()
	AutochessselectbuffView.super.onEnter(self)

	self._myUserId = tostring(RoleModel.instance:getUserId())

	local isBuffRound = AutochessModel.instance:getIsBuffRound()

	if not isBuffRound then
		self:close()

		return
	end

	local msg = AutochessController.instance:hasGameEndMsg()

	if msg then
		self:close()

		return
	end

	self.addGEvent(self, AutoChessAgent.ACNotifyNextRoundRes, self._onACNotifyNextRoundRes, self)

	self._activityId = AutochessModel.instance:getActivityId()

	self:_updateUI()
end

function AutochessselectbuffView:_onACNotifyNextRoundRes()
	self:_updateUI()
end

function AutochessselectbuffView:_updateUI()
	local isBuffRound = AutochessModel.instance:getIsBuffRound()

	if not isBuffRound then
		self:close()

		return
	end

	local info = AutochessModel.instance:getBuffRoundInfo()

	self._currBuffId = 0
	self._id = info.id
	self._selectUserId = info.userId
	self._isMyRound = self._selectUserId == self._myUserId
	self._selectBuffIds = {}
	self._buffIds = info.buffIds

	for i, v in ipairs(info.selectedBuffIds) do
		self._selectBuffIds[v] = true
	end

	goutil.setActive(self._btnGet.gameObject, self._isMyRound)
	self:_updateBuffs()
	self:_updatePlayers()

	local time = AutochessConfig.instance:getSelectEquipTimeSec(self._activityId)

	self._targetTickTime = ServerTime.now() + time

	settimer(1, self._tick, self, true)
	self:_tick()
end

function AutochessselectbuffView:_onClickbtnGet()
	if self._currBuffId <= 0 then
		FloatWordMgr.instance:show("请先选择buff")

		return
	end

	AutochessController.instance:sendPM_ACSelectBuffReq(self._currBuffId)
end

function AutochessselectbuffView:_updatePlayers()
	local servPlayers = AutochessModel.instance:getPlayers()

	self._players = {}

	for i = 1, #servPlayers do
		local v = servPlayers[i]

		if v.hp > 0 then
			table.insert(self._players, v)
		end
	end

	self._playerItemGroup:updateWithMoArray(self._players, function(item, player)
		self:_updatePlayerCell(item, player)
	end)
	self._singleLinePlayer:Layout()
end

function AutochessselectbuffView:_updatePlayerCell(item, player)
	local goHead = goutil.findChild(item.mainGO, "head")
	local goMyTag = goutil.findChild(item.mainGO, "myTag")
	local goSelect = goutil.findChild(item.mainGO, "select")
	local txtHp = goutil.findChildTextComponent(item.mainGO, "hpbg/txtHp")
	local txtRank = goutil.findChildTextComponent(item.mainGO, "rank")
	local txtSelect = goutil.findChildTextComponent(item.mainGO, "select/txtSelect")
	local goEffect = goutil.findChild(item.mainGO, "select/effect")

	HeadItemController.instance:resetHeadCell(goHead)

	local proxy = HeadItemController.instance:setHeadCell(goHead, player.headInfo.headIconId, 0, 0)

	proxy.binder:setAutoTips(false)
	proxy.binder:setCallBack(function()
		return
	end)

	txtHp.text = player.hp
	txtRank.text = item.index

	goutil.setActive(goSelect, self._selectUserId == player.headInfo.userId)

	txtSelect.text = string.format("第%s顺位", self._id)

	goutil.setActive(goMyTag, self._myUserId == player.headInfo.userId)
end

function AutochessselectbuffView:_clearPlayerCell(item)
	local goHead = goutil.findChild(item.mainGO, "head")

	HeadItemController.instance:resetHeadCell(goHead)
end

function AutochessselectbuffView:_updateBuffs()
	local cfgs = self:_getBuffCfgs()

	self._buffItemGroup:updateWithMoArray(cfgs, function(item, buffCfg)
		self:_updateBuffCell(item, buffCfg)
	end)
end

function AutochessselectbuffView:_getBuffCfgs()
	local cfgs = {}

	for i, buffId in ipairs(self._buffIds) do
		if buffId > 0 then
			local cfg = self:_getBuffCfg(buffId)

			table.insert(cfgs, cfg)
		end
	end

	return cfgs
end

function AutochessselectbuffView:_getBuffCfg(buffId)
	return AutochessConfig.instance:getEquipBuffCfg(buffId)
end

function AutochessselectbuffView:_updateBuffCell(item, buffCfg)
	local cell = item.mainGO
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local goBuffIcon = goutil.findChild(cell.gameObject, "BuffIcon")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local goSelectLock = goutil.findChild(cell.gameObject, "selectLock")
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")

	txtRank.text = GameEnum.RomanNumber[item.index]
	txtName.text = buffCfg.name
	txtDesc.text = buffCfg.buffDesc

	local spriteName = string.format("ui/icon/%s.png", buffCfg.iconPath)

	uGuiUtil.setSpriteToImage(goBuffIcon, nil, spriteName)
	goutil.setActive(goSelect, self._currBuffId == buffCfg.buffId)
	goutil.setActive(goSelectLock, self._selectBuffIds[buffCfg.buffId])
	btn:AddClickListener(function()
		if not self._isMyRound then
			FloatWordMgr.instance:show("不是你的回合")

			return
		end

		if self._selectBuffIds[buffCfg.buffId] then
			FloatWordMgr.instance:show("该buff已被选择")

			return
		end

		if self._currBuffId == buffCfg.buffId then
			return
		end

		self._currBuffId = buffCfg.buffId

		self:_updateBuffs()
	end)
end

function AutochessselectbuffView:_clearBuffCell(item)
	local goBuffIcon = goutil.findChild(item.mainGO, "BuffIcon")

	uGuiUtil.clearImage(goBuffIcon)
end

function AutochessselectbuffView:_tick()
	self._txtSelectDesc.text = string.format("第%s顺位选择中", GameUtil.getChineseNumber(self._id))
end

function AutochessselectbuffView:_tick()
	local leftTime = self._targetTickTime - ServerTime.now()

	self._txtSelectDesc.text = string.format("第%s顺位选择中..%ss", GameUtil.getChineseNumber(self._id), leftTime)

	if leftTime <= 0 then
		self._txtSelectDesc.text = "请等待"

		removetimer(self._tick, self)
	end
end

return AutochessselectbuffView
