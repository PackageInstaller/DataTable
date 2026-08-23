local var_0_0 = g.core.config.dungeon_stage_info
local var_0_1 = g.core.config.source_route_info
local var_0_2 = g.core.common.Goods
local KnightShortcutBlitzCell = class("KnightShortcutBlitzCell", require("app.fairyGUI.knight.UI_KnightShortcutBlitzCell"))

function KnightShortcutBlitzCell:ctor()
	self._routeData = {}
	self._acqData = {}
	self._matId = 0
	self._needNum = 0
	self._numLeft = 0
	self._stageId = 0

	self.m_acqBtn:addClickListener(handler(self, self._onClickAcquire))
	self.m_blitzBtn:addClickListener(handler(self, self._onClickBlitz))
	self.m_awardList:setVirtual()
	self.m_awardList:doFairyBatching(false)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRenderer))
end

function KnightShortcutBlitzCell:_onAwardItemRenderer(arg_2_1, arg_2_2)
	self._awardData[arg_2_1 + 1].showInfo = true

	arg_2_2:updateIcon(self._awardData[arg_2_1 + 1])
end

function KnightShortcutBlitzCell:updateCell(arg_3_1)
	if arg_3_1 then
		self._routeData = arg_3_1.data or {}
	end

	if arg_3_1 then
		self._matId = arg_3_1.matId or 0
	end

	if arg_3_1 then
		self._needNum = arg_3_1.needNum or 0
	end

	self._acqData = {
		type = var_0_2.TYPE_KNIGHT_ADVANCE,
		value = self._matId,
		needNum = self._needNum
	}

	self.m_desLabel:setText(self._routeData.route.description)

	local var_3_0 = var_0_1.get(self._routeData.route.route_id)
	local var_3_1 = var_3_0.route_value_1

	self._stageId = var_3_0.route_value_1

	if var_3_0.route_type == 102 then
		if var_3_1 == 0 then
			var_3_1 = g.core.model.User.dungeonData:getLastUnlockStageId()
		end

		self._awardData = g.core.common.Drops:getGoodsArray(var_0_0.get(var_3_1).stage_drop)

		self.m_awardList:setNumItems(table.nums(self._awardData))

		if g.core.model.User.dungeonData:isStagePassed(var_3_1) then
			self.m_stageStateController:setSelectedIndex(0)
		else
			self.m_stageStateController:setSelectedIndex(1)
		end
	end
end

function KnightShortcutBlitzCell:_onClickAcquire()
	g.view.entrance.ModuleGotoProxy:gotoModule(self._routeData.route.route_id, false, false, self._acqData)
end

function KnightShortcutBlitzCell:_onClickBlitz()
	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.DUNGEON_SWEEPING_10) then
		return
	end

	if g.core.model.User.resourceData:getVit() < 5 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
			type = var_0_2.TYPE_ITEM,
			value = var_0_2.ITEM.TYPE_STAMINA_PILL,
			shopId = g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.STAMINA_PILL
		}), {
			touchDisappear = true
		})
	else
		local var_5_0 = g.core.model.User.dungeonData:getStage(self._stageId)

		if var_5_0 and var_5_0:isPassed() then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BeginSweepPop").new({
				data = clone(self._awardData),
				stageId = self._stageId,
				acqData = self._acqData
			}))
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(1081))
		end
	end
end

return KnightShortcutBlitzCell
