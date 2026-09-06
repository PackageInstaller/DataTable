-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessrankresultView.lua

module("logic.extensions.autochess.view.AutochessrankresultView", package.seeall)

local AutochessrankresultView = class("AutochessrankresultView", ViewComponent)

function AutochessrankresultView:ctor()
	AutochessrankresultView.super.ctor(self)
end

function AutochessrankresultView:unbindEvents()
	AutochessrankresultView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnShare:RemoveClickListener()
end

function AutochessrankresultView:bindEvents()
	AutochessrankresultView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnShare:AddClickListener(self._onClickbtnShare, self)
end

function AutochessrankresultView:buildUI()
	AutochessrankresultView.super.buildUI(self)

	self._txtScore = self:getTxt("txtScore")
	self._pettableviewGo = self:getGo("pettableview")
	self._bufftablecellGo = self:getGo("bufftablecell")
	self._bufftableviewGo = self:getGo("bufftableview")
	self._pettablecellGo = self:getGo("pettablecell")
	self._btnClose = self:getBtn("btnClose")
	self._btnShare = self:getBtn("btnShare")
	self._fettertableviewGo = self:getGo("fettertableview")
	self._fettertablecellGo = self:getGo("fettertablecell")
	self._rankNum = self:getGo("rank/rankNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._imgNum = self:getGo("rank/imgNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._buffscrollerList = ScrollerList.create(self._bufftableviewGo, self._bufftablecellGo, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._petscrollerList = ScrollerList.create(self._pettableviewGo, self._pettablecellGo, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._fetterScrollerList = ScrollerList.create(self._fettertableviewGo, self._fettertablecellGo, GameUtil.handler(self._updateFetterCell, self), GameUtil.handler(self._clearFeeterCell, self))
	self._headGo = self:getGo("player/head")
	self._txtArea = self:getTxt("player/txtArea")
	self._txtName = self:getTxt("player/name/txtName")
	self._btnGotoGo = self:getGo("btnGoto")
	self._effectGo = self:getGo("effect")
	self._imgTitleChange = self:getGo("imgTitle"):GetComponent(ComponentType.UIImageSpriteChange)

	goutil.setActive(self._btnGotoGo, false)
	goutil.setActive(self._btnShare.gameObject, false)

	self._prizeBgGo = self:getGo("prizeBg")
	self._pirzeBg_txt = self:getTxt("prizeBg/txt")
	self._txtPrize = self:getTxt("prizeBg/txtPrize")
end

function AutochessrankresultView:onExit()
	AutochessrankresultView.super.onExit(self)
	self._petscrollerList:dispose()
	self._buffscrollerList:dispose()
	self._fetterScrollerList:dispose()

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end

	HeadItemController.instance:resetHeadCell(self._headGo)
end

function AutochessrankresultView:onEnter()
	AutochessrankresultView.super.onEnter(self)

	self._activityId = AutochessModel.instance:getActivityId()

	self:_updateUI()
	self:_setEffect()
end

function AutochessrankresultView:_onClickbtnClose()
	if not SceneMgr.instance.isGogingToEnterBattleScene then
		self:close()
	else
		UIJumper.instance:pushOneStack(ViewName.AutochessmainView)
		BattleFacade.instance:endBattle()
	end
end

function AutochessrankresultView:_realClose()
	return
end

function AutochessrankresultView:_onClickbtnShare()
	return
end

function AutochessrankresultView:_updateUI()
	self:_setBuff()
	self:_setPets()
	self:_setRank()
	self:_setMyHead()
	self:_setEndPrize()
end

function AutochessrankresultView:_setBuff()
	local buffCfgs = {}
	local msg = AutochessModel.instance:getGameEndMsg()

	if msg.initBuffId > 0 then
		local cfg = AutochessConfig.instance:getInitBuffCfg(msg.initBuffId)

		table.insert(buffCfgs, cfg)
	end

	local buffIds = msg.equipBuffId

	for i, buffId in ipairs(buffIds) do
		local buffCfg = AutochessConfig.instance:getEquipBuffCfg(buffId)

		table.insert(buffCfgs, buffCfg)
	end

	self._buffscrollerList:reloadData(buffCfgs)
end

function AutochessrankresultView:_setPets()
	local msg = AutochessModel.instance:getGameEndMsg()
	local creepIds = msg.creepIds
	local creepsCfgs = self:_getCreepsCfgs(creepIds)

	self._petscrollerList:reloadData(creepsCfgs)
	self:_setFetter(creepIds)
end

function AutochessrankresultView:_updateBuffCell(view, cell, buffCfg, tag)
	local btnIcon = Framework.ButtonAdapter.Get(cell.gameObject)
	local spriteName = string.format("ui/icon/%s.png", buffCfg.iconPath)

	uGuiUtil.setSpriteToImage(cell.gameObject, nil, spriteName)
	btnIcon:AddClickListener(function()
		local data = BufftipsView.getBuffTipSimpleData(buffCfg.name, buffCfg.buffDesc, buffCfg.iconPath)

		CommonTipsMgr.instance:openBuffTipView(data, cell.gameObject)
	end)
end

function AutochessrankresultView:_clearBuffCell(cell)
	uGuiUtil.clearImage(cell.gameObject)
end

function AutochessrankresultView:_updatePetCell(view, cell, creepsCfg, tag)
	local petMo = AutochessModel.instance:getPet(creepsCfg.creepsId)
	local proxy = MaterialMgr.setCellByMo(petMo, cell.gameObject)

	proxy.binder:setCallBack(function()
		CommonTipsMgr.instance:showPetTips(petMo)
	end)
end

function AutochessrankresultView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function AutochessrankresultView:_setRank()
	local msg = AutochessModel.instance:getGameEndMsg()
	local rank = msg.rank
	local score = msg.score
	local playerNum = AutochessConfig.instance:getPlayerNum(self._activityId)

	self._txtScore.text = string.format("积分：%s<color=#30f5ff>(+%s)</color>", msg.totalScore, score)

	self._rankNum:SetNum(rank)
	self._imgNum:SetNum(playerNum)
end

function AutochessrankresultView:_getCreepsCfgs(creepsIds)
	local list = {}

	for i, creepsId in ipairs(creepsIds) do
		local cfg = AutochessConfig.instance:getCreepsCfg(creepsId)

		table.insert(list, cfg)
	end

	return list
end

function AutochessrankresultView:_setMyHead()
	HeadItemController.instance:setMyHeadCell(self._headGo)

	self._txtName.text = RoleModel.instance:getUserName()
	self._txtArea.text = RoleModel.instance:getAreaName()
end

function AutochessrankresultView:_setEffect()
	local effName = "20230728/zizouqi/fx_ui_zizouqi_ziti_fenwei.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

function AutochessrankresultView:_setFetter(creepIds)
	local datas = AutochessController.instance:getFetterDatas(creepIds)

	self._fetterScrollerList:reloadData(datas)
end

function AutochessrankresultView:_updateFetterCell(view, cell, fetter, tag)
	local goIcon = goutil.findChild(cell.gameObject, "icon")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local iconChange = goutil.findChild(cell.gameObject, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
	local fettersBuffCfg = AutochessConfig.instance:getFettersBuffCfg(fetter.fettersId, fetter.num)

	txtNum.text = fetter.num
	fettersBuffCfg = fettersBuffCfg or AutochessConfig.instance:getFettersCfg(fetter.fettersId)

	iconChange:ChangeSprite(fettersBuffCfg.iconPath)
	btn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.AutochessfettertipsView, fetter.fettersId, btn.gameObject)
	end)
end

function AutochessrankresultView:_clearFeeterCell(cell)
	return
end

function AutochessrankresultView:_setEndPrize()
	local changeSetId = AutochessController.instance:getGameEndChangesetId()
	local hasPrize = changeSetId and changeSetId > 0

	goutil.setActive(self._prizeBgGo, hasPrize)

	if hasPrize then
		local items = MaterialController.instance:getTempItemsByChangeSetId(changeSetId)
		local mo = items and items[1]

		if mo then
			local matType, matId, matNum = mo:getMatType(), mo:getId(), mo:GetCount()
			local matName = MaterialMgr.getMaterialsName(matType, matId)

			self._pirzeBg_txt.text = ":" .. matName
			self._txtPrize.text = "+" .. mo:GetCount()
		else
			goutil.setActive(self._prizeBgGo, false)
		end
	end
end

return AutochessrankresultView
