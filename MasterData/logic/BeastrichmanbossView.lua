-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastrichmanbossView.lua

module("logic.extensions.beastrichman.view.BeastrichmanbossView", package.seeall)

local BeastrichmanbossView = class("BeastrichmanbossView", ViewComponent)

function BeastrichmanbossView:ctor()
	BeastrichmanbossView.super.ctor(self)
end

function BeastrichmanbossView:unbindEvents()
	BeastrichmanbossView.super.unbindEvents(self)
	self._btnClg:RemoveClickListener()
	self._btnBook:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function BeastrichmanbossView:bindEvents()
	BeastrichmanbossView.super.bindEvents(self)
	self._btnClg:AddClickListener(self._onClickbtnClg, self)
	self._btnBook:AddClickListener(self._onClickbtnBook, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnRank:AddClickListener(self._onClickbtnRank, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
end

function BeastrichmanbossView:buildUI()
	BeastrichmanbossView.super.buildUI(self)

	self._btnClg = self:getBtn("btnClg")
	self._btnBook = self:getBtn("btnBook")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnRank = self:getBtn("btnRank")
	self._txtHistoryDamage = self:getTxt("txtHistoryDamage")
	self._tablecellGo = self:getGo("tablecell")
	self._conGo = self:getGo("con")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTitle = self:getTxt("btnBook/txtTitle")
	self._txtDesc = self:getTxt("btnBook/txtDesc")
end

function BeastrichmanbossView:onExit()
	BeastrichmanbossView.super.onExit(self)
	self._scrollerList:dispose()
	RoleObjectPool.instance:removeRole(self._role)
end

function BeastrichmanbossView:onEnter()
	BeastrichmanbossView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._zoneId = params[2]
	self._beastType = params[3]
	self._beastId = params[4]
	self._playerGridId = BeastRichmanModel.instance:getCurManGridId(self._activityId, self._zoneId)
	self._gridCfg = BeastRichmanConfig.instance:getGridCfg(self._activityId, self._zoneId, self._playerGridId)
	self._bossCfg = BeastRichmanConfig.instance:getBossGridCfg(self._activityId, self._zoneId, self._beastType, self._beastId)

	local skinId = self._bossCfg.skinId
	local posAndSize = self._bossCfg.posAndSize

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._conGo, nil, nil, true, nil, nil)

	GameUtil.setLocalPos(self._conGo, posAndSize[1], posAndSize[2], 0)
	GameUtil.setLocalScale(self._conGo, posAndSize[3], posAndSize[3], posAndSize[3])
	self:_updateUI()
end

function BeastrichmanbossView:_onClickbtnClg()
	local gridCfg = BeastRichmanConfig.instance:getGridCfg(self._activityId, self._zoneId, self._playerGridId)

	if gridCfg.beastType ~= self._beastType or self._beastId ~= gridCfg.beastId then
		FloatWordMgr.instance:show("当前距离瑞兽过远，请站到指定的格子上再来挑战吧！")

		return
	end

	local fmtMo = BeastRichmanModel.instance:getBossFmtMo()

	fmtMo:initParams(self._activityId, self._zoneId, self._beastId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function BeastrichmanbossView:_onClickbtnBook()
	local bookShopAddDataList = BeastRichmanModel.instance:getBookShopAddDataList(self._activityId, self._zoneId)

	if #bookShopAddDataList == 0 then
		FloatWordMgr.instance:show("暂无加成")

		return
	end

	UIStateManager.instance:push(ViewName.BeastrichmanbookshopaddView, self._activityId, self._zoneId)
end

function BeastrichmanbossView:_onClickbtnClose()
	self:close()
end

function BeastrichmanbossView:_onClickbtnRank()
	UIStateManager.instance:push(ViewName.BeastrichmanrankView, self._activityId)
end

function BeastrichmanbossView:_updateUI()
	local damageCfgs = BeastRichmanConfig.instance:getBossDamagePrizeCfgs(self._activityId, self._beastId)
	local bossInfo = BeastRichmanModel.instance:getBossInfo(self._activityId, self._beastId)

	if bossInfo then
		if not bossInfo.historyDamage then
			local historyDamage = 0

			self._txtHistoryDamage.text = historyDamage
			self._prizeId = BeastRichmanConfig.instance:getBossDamagePrizeIdByDamage(self._activityId, self._beastId, historyDamage)

			local curIdx = math.max(self._prizeId - 1, 0)

			self._scrollerList:reloadData(damageCfgs)
			self._scrollerList:MoveCellToCenter(curIdx)

			local zoneCfg = BeastRichmanConfig.instance:getZoneCfgById(self._activityId, self._zoneId)

			self._txtTitle.text = string.format("[%s]", zoneCfg.name)

			local bookShopAddDataList = BeastRichmanModel.instance:getBookShopAddDataList(self._activityId, self._zoneId)

			self._txtDesc.text = #bookShopAddDataList > 0 and "书店加成" or "暂无加成"
		end
	end
end

function BeastrichmanbossView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtTitle = goutil.findChildTextComponent(cell.gameObject, "txtTitle")
	local goSelect = goutil.findChild(cell.gameObject, "select")

	txtTitle.text = string.format("单次最高伤害\n达到%s", data.damage)
	txtDesc.text = string.format("每分钟可获得%s银票的收益\n达到本档位后累计获得%s排名积分", data.hanging, data.rankScore)

	goutil.setActive(goSelect, data.prizeId == self._prizeId)
end

function BeastrichmanbossView:_clearCell(cell)
	return
end

function BeastrichmanbossView:_onClickbtnTip()
	local actCfg = BeastRichmanConfig.instance:getActCfg(self._activityId)
	local key = actCfg.bossRuleKey

	TipsFacade.instance:openRulesView(key)
end

return BeastrichmanbossView
