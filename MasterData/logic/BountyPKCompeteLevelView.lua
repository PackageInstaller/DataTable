-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountyPKCompeteLevelView.lua

module("logic.extensions.bountypkcompete.view.BountyPKCompeteLevelView", package.seeall)

local BountyPKCompeteLevelView = class("BountyPKCompeteLevelView", TableViewComponent)

function BountyPKCompeteLevelView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function BountyPKCompeteLevelView:ctor()
	BountyPKCompeteLevelView.super.ctor(self)
end

function BountyPKCompeteLevelView:unbindEvents()
	BountyPKCompeteLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function BountyPKCompeteLevelView:bindEvents()
	BountyPKCompeteLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function BountyPKCompeteLevelView:buildUI()
	BountyPKCompeteLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
end

function BountyPKCompeteLevelView:onExit()
	BountyPKCompeteLevelView.super.onExit(self)
end

function BountyPKCompeteLevelView:onEnter()
	BountyPKCompeteLevelView.super.onEnter(self)

	local seasonConfig = BountyPKCompeteConfig.instance:getSeasonConfig(BountyPKCompeteModel.instance:getActivityId())

	self._gateConfigs = BountyPKCompeteConfig.instance:getGateConfigs(seasonConfig.seasonId)
	self._selectIndex = -1

	self:updateListData(self._gateConfigs)
end

function BountyPKCompeteLevelView:_cellSize(view, index)
	return 176, 270
end

function BountyPKCompeteLevelView:_updateCell(view, cell, data)
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local txtLevel = goutil.findChildTextComponent(cell, "txtLevel")
	local txtMaxGot = goutil.findChildTextComponent(cell, "txtMaxGot")
	local txtMinCost = goutil.findChildTextComponent(cell, "txtMinCost")
	local clickArea = goutil.findChild(cell, "clickArea")
	local item = goutil.findChild(cell, "item")
	local gotIcon = goutil.findChild(cell, "txtMaxGot/icon")
	local costIcon = goutil.findChild(cell, "txtMinCost/icon")
	local prizeItemId = BountyPKCompeteConfig.instance:getCommonValue("BOUNTY_ITEM_ID", true)
	local proxy = MaterialMgr.setCellByCfg(MaterialMgr.createSerName(MatType.Item_Fake, prizeItemId, 1), gotIcon)

	proxy.binder:setAutoTips(false)
	proxy.binder:setBgActive(false)
	proxy:setNumStr("")
	proxy:setCallBack(function()
		return
	end)

	proxy = MaterialMgr.setCellByCfg(MaterialMgr.createSerName(MatType.Item_Fake, prizeItemId, 1), costIcon)

	proxy.binder:setAutoTips(false)
	proxy.binder:setBgActive(false)
	proxy:setNumStr("")
	proxy:setCallBack(function()
		return
	end)
	GameUtil.setUIImageSpriteIdx(item, data.gateId - 1)
	goutil.setActive(imgSelect, self._selectIndex == data.gateId)

	txtLevel.text = data.gateName or ""
	txtMaxGot.text = tostring(data.limit or 0)
	txtMinCost.text = tostring(data.limit or 0)

	GameUtil.rmClickHandler(clickArea)
	GameUtil.addClickHandler(clickArea, function()
		self:_onClickItem(data)
	end, self)
end

function BountyPKCompeteLevelView:_onClickItem(data)
	self._selectIndex = data.gateId

	self:updateListData(self._gateConfigs)
end

function BountyPKCompeteLevelView:_clearTableview(cell)
	local clickArea = goutil.findChild(cell, "clickArea")
	local gotIcon = goutil.findChild(cell, "txtMaxGot/icon")
	local costIcon = goutil.findChild(cell, "txtMinCost/icon")

	GameUtil.rmClickHandler(clickArea)
	MaterialMgr.resetAll(gotIcon)
	MaterialMgr.resetAll(costIcon)
end

function BountyPKCompeteLevelView:_onClickSure()
	if self._selectIndex > 0 then
		local data = self._gateConfigs[self._selectIndex]
		local model = BountyPKCompeteModel.instance

		if model.pkInfo.score >= data.limit then
			local bInMatchTime, strTips = model:checkIsInMatchTime()

			if bInMatchTime then
				BountyPKCompeteController.instance:showMatchDialog(self._selectIndex)
			else
				FloatWordMgr.instance:show(strTips)
			end
		else
			FloatWordMgr.instance:show(lang("赏金不足"))
		end
	else
		FloatWordMgr.instance:show(lang("bountypk__16"))
	end
end

return BountyPKCompeteLevelView
