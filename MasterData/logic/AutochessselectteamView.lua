-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessselectteamView.lua

module("logic.extensions.autochess.view.AutochessselectteamView", package.seeall)

local AutochessselectteamView = class("AutochessselectteamView", ViewComponent)

function AutochessselectteamView:ctor()
	AutochessselectteamView.super.ctor(self)
end

function AutochessselectteamView:unbindEvents()
	AutochessselectteamView.super.unbindEvents(self)
	self._btnGet:RemoveClickListener()
end

function AutochessselectteamView:bindEvents()
	AutochessselectteamView.super.bindEvents(self)
	self._btnGet:AddClickListener(self._onClickbtnGet, self)
end

function AutochessselectteamView:buildUI()
	AutochessselectteamView.super.buildUI(self)

	self._btnGet = self:getBtn("btnGet")
	self._txtTime = self:getTxt("txtTime")
	self._items = {}

	for i = 1, 2 do
		local cell = goutil.findChild(self.mainGO, "tablecell" .. i)

		self._items[i] = {
			gameObject = cell,
			goBuffIcon = goutil.findChild(cell.gameObject, "BuffIcon")
		}
	end
end

function AutochessselectteamView:onExit()
	AutochessselectteamView.super.onExit(self)
	removetimer(self._tick, self)

	for i, v in ipairs(self._items) do
		uGuiUtil.clearImage(v.goBuffIcon)
	end
end

function AutochessselectteamView:onEnter()
	AutochessselectteamView.super.onEnter(self)

	self._activityId = AutochessModel.instance:getActivityId()

	if self._activityId <= 0 then
		self:close()

		return
	end

	self._buffCfgs = self:_getBuffCfgs()
	self._currBuffId = self._buffCfgs[1].buffId
	self._curViewDatas = self._buffCfgs

	self:_refreshCells()

	self._tickTime = AutochessConfig.instance:getInitBuffTimeSec(self._activityId)
	self._targetTickTime = ServerTime.now() + self._tickTime - 1

	settimer(1, self._tick, self, true)
	self:_tick()
end

function AutochessselectteamView:_getBuffCfgs()
	local buffIds = self:_getBuffIds()
	local cfgs = {}
	local isUseBuffIds = {}

	for i, buffId in ipairs(buffIds) do
		if buffId > 0 and not isUseBuffIds[buffId] then
			isUseBuffIds[buffId] = true

			local cfg = self:_getBuffCfg(buffId)

			table.insert(cfgs, cfg)
		end
	end

	return cfgs
end

function AutochessselectteamView:_onClickbtnGet()
	if self._currBuffId <= 0 then
		FloatWordMgr.instance:show("先选择Buff")

		return
	end

	self:_sendMsg()
	self:close()
end

function AutochessselectteamView:_refreshCells()
	self:_updateCell(self._items[1].gameObject, self._curViewDatas[1])
	self:_updateCell(self._items[2].gameObject, self._curViewDatas[2])
end

function AutochessselectteamView:_updateCell(cell, buffCfg)
	if not buffCfg then
		return
	end

	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local goBuffIcon = goutil.findChild(cell.gameObject, "BuffIcon")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local goHasTag = goutil.findChild(cell.gameObject, "hasTag")

	goutil.setActive(goHasTag, self:_hasBuffId(buffCfg.buffId))

	txtName.text = buffCfg.name
	txtDesc.text = buffCfg.buffDesc

	local spriteName = string.format("ui/icon/%s.png", buffCfg.iconPath)

	uGuiUtil.setSpriteToImage(goBuffIcon, nil, spriteName)
	goutil.setActive(goSelect, self._currBuffId == buffCfg.buffId)
	btn:AddClickListener(function()
		if self._currBuffId == buffCfg.buffId then
			return
		end

		self._currBuffId = buffCfg.buffId

		self:_refreshCells()
	end)
end

function AutochessselectteamView:_tick()
	local leftTime = self._targetTickTime - ServerTime.now()

	self._txtTime.text = string.format("%ss", leftTime)

	if leftTime <= 0 then
		AutochessController.instance:sendPM_ACSelectInitBuffReq(self._currBuffId)
		self:close()
	end
end

function AutochessselectteamView:_getBuffIds()
	return AutochessModel.instance:getSelectBuffIds()
end

function AutochessselectteamView:_getBuffCfg(buffId)
	return AutochessConfig.instance:getInitBuffCfg(buffId)
end

function AutochessselectteamView:_sendMsg()
	AutochessController.instance:sendPM_ACSelectInitBuffReq(self._currBuffId)
end

function AutochessselectteamView:_hasBuffId()
	return false
end

return AutochessselectteamView
