-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brothergroup/view/BrotherGroupPrizeView.lua

module("logic.extensions.brothergroup.view.BrotherGroupPrizeView", package.seeall)

local BrotherGroupPrizeView = class("BrotherGroupPrizeView", ViewComponent)

function BrotherGroupPrizeView:buildUI()
	BrotherGroupPrizeView.super.buildUI(self)

	self._goCell = self:getGo("cell")
	self._goTableview = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtProgress = self:getTxt("txtProgress")
	self._txtScore = self:getTxt("txtScore")
	self._btnOneKey = self:getGo("btnOneKey")
	self._showcell = self:getGo("showcell")
	self._showTxtNum = goutil.findChildTextComponent(self._showcell, "txtNum")
	self._showItemcon = goutil.findChild(self._showcell, "itemcon")
	self._btnTip = self:getGo("btnTip")
	self._scrollRect = self._goTableview:GetComponent(ComponentType.ScrollRect)
	self._sldProgress = self:getSlider("slider")
end

function BrotherGroupPrizeView:bindEvents()
	BrotherGroupPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
end

function BrotherGroupPrizeView:unbindEvents()
	BrotherGroupPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnOneKey)
end

function BrotherGroupPrizeView:onEnter()
	BrotherGroupPrizeView.super.onEnter(self)

	local actId = BrotherGroupModel.instance:getCurActId()
	local actCfg = BrotherGroupConfig.instance:getActCfg(actId)
	local matType, id, matNum = MaterialMgr.getMatParams(actCfg.itemKey)

	self._personScore = MaterialModel.instance:getMaterialsNumber(matType, id)
	self._prizeCfgs = BrotherGroupConfig.instance:getPersonPrizeCfgs(actCfg.personPrizePlan)

	self:_refreshPrizeList()
	GlobalDispatcher:addListener(GlobalNotify.BrotherGroupUpdatePrizeList, self._refreshPrizeList, self)

	self._showId = nil

	self._sldProgress:SetValue(0)

	self._txtScore.text = langPara("当前积分\n<size=20><color=#7afb80>%s</color></size>", self._personScore)

	for k, v in ipairs(self._prizeCfgs) do
		if self._personScore < v.progress then
			self._txtProgress.text = langPara("%s/%s", self._personScore, v.progress)

			self._sldProgress:SetValue(checknumber(self._personScore) / checknumber(v.progress))
			BrotherGroupModel.instance:setLastPrizeId(v.id - 1)

			return
		end
	end

	self._sldProgress:SetValue(1)

	self._txtProgress.text = langPara("%s/%s", self._personScore, self._prizeCfgs[#self._prizeCfgs].progress)
end

function BrotherGroupPrizeView:onExit()
	BrotherGroupPrizeView.super.onExit(self)
	self._tableview:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.BrotherGroupUpdatePrizeList, self._refreshPrizeList, self)
	MaterialMgr.resetAll(self._showItemcon)
end

function BrotherGroupPrizeView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.txtNum.text = data.progress

	local prizeStrs = string.split(data.prize, "#")
	local hasGained = BrotherGroupModel.instance:getIsHasGainPrize(data.id)
	local ableToGain = self._personScore >= data.progress and not hasGained

	for k, v in ipairs(prizeStrs) do
		if not string.nilorempty(v) then
			goutil.setActive(cell.itemList[k], true)

			local proxy = MaterialMgr.setCellByCfg(v, cell.itemList[k])

			if ableToGain then
				proxy:setAutoTips(false)
				self:_playCellEff(cell.itemList[k])
				proxy:setCallBack(function()
					BrotherGroupController.instance:gainPersonalPrize(data.id)
				end)
			end
		end
	end

	goutil.setActive(cell.showEff, ableToGain)
	goutil.setActive(cell.markGained, hasGained)
	self:_refreshShowCell(self._tableview._tableview:GetCurrentIndex() + 1)
end

function BrotherGroupPrizeView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.showEff = goutil.findChild(cell.go, "showEff")
	cell.markGained = goutil.findChild(cell.go, "markGained")
	cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
	cell.itemList = {}

	for i = 1, 3 do
		cell.itemList[i] = goutil.findChild(cell.go, "itemList/item_" .. i)

		MaterialMgr.resetAll(cell.itemList[i])
		goutil.setActive(cell.itemList[i], false)
		self:_removeCellEff(cell.itemList[i])
	end

	goutil.setActive(cell.showEff, false)
	goutil.setActive(cell.markGained, false)

	return cell
end

function BrotherGroupPrizeView:_playCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	self:_removeCellEff(go)

	local resPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	local function loadCallBack()
		self._effs[go]:setScrollRectClipping(self._scrollRect)
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, resPath, nil, nil, nil, true, nil, nil, loadCallBack)

	self._effs[go]:setParent(go.transform)
	self._effs[go]:setScale(1)
	self._effs[go]:setLocalPos(0, 0, 0)

	self._effs[go].hideEffWhileNotOnTop = true
end

function BrotherGroupPrizeView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function BrotherGroupPrizeView:_onClickTip()
	ViewMgr.instance:open(ViewName.RulesView, "brothergroupprizeview")
end

function BrotherGroupPrizeView:_refreshPrizeList()
	self._tableview:reloadData(self._prizeCfgs)

	local moveId = 1

	for k, v in ipairs(self._prizeCfgs) do
		if self._personScore >= v.progress then
			moveId = v.id

			if not BrotherGroupModel.instance:getIsHasGainPrize(v.id) then
				break
			end
		else
			break
		end
	end

	self._tableview:MoveCellToCenter(moveId)
end

function BrotherGroupPrizeView:_refreshShowCell(dataId)
	if self._prizeCfgs[dataId] then
		if self._showId ~= self._prizeCfgs[dataId] then
			self._showId = self._prizeCfgs[dataId]

			local data = self._prizeCfgs[self._showId]

			if data then
				MaterialMgr.resetAll(self._showItemcon)
				MaterialMgr.setCellListByCfg(data.prize, self._showItemcon)

				self._showTxtNum.text = data.progress
			end
		end
	end
end

function BrotherGroupPrizeView:_onClickOneKey()
	local isAbleToPrize = false

	for k, v in ipairs(self._prizeCfgs) do
		if self._personScore >= v.progress and not BrotherGroupModel.instance:getIsHasGainPrize(v.id) then
			isAbleToPrize = true

			break
		end
	end

	if isAbleToPrize then
		BrotherGroupController.instance:gainPersonalPrize(-1)
	else
		FloatWordMgr.instance:show(lang("当前无可领取奖励"))
	end
end

return BrotherGroupPrizeView
