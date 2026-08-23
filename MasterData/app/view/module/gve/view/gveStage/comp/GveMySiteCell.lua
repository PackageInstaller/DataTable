local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.model.User.gveDataMgr:getGveData()
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.config.gve_ground_info
local GveMySiteCell = class("GveMySiteCell", require("app.fairyGUI.gve.UI_GveMySiteCell"))

function GveMySiteCell:ctor()
	var_0_1 = var_0_0:getGveData()
	self._data = nil

	self.m_operateBtn:addClickListener(handler(self, self._onClickOperate))
	self.m_giveUpBtn:addClickListener(handler(self, self._onClickGiveUp))
	self.m_detailBtn:addClickListener(handler(self, self._onClickDetail))
	self.m_cancelGiveUpBtn:addClickListener(handler(self, self._onClickCancelGiveUp))
end

function GveMySiteCell:_onClickOperate()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.gve.view.gveStage.GveCoordPop").new({
		operate = "control",
		baseCfg = var_0_1:getBaseCfgByPos(self._pos),
		cfg = var_0_1:getBuildDataByPos(self._pos).cfg
	})))
end

function GveMySiteCell:_onClickGiveUp()
	self:dispatchCompEvent("GveGiveUpClick", {
		confirmTitle = g.core.lang:get(309117),
		comp = self.m_giveUpBtn,
		confirmFunc = function()
			if var_0_1:isGridCanGiveUp() then
				self:onCanCelFunc()
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(309123))
			end
		end
	})
end

function GveMySiteCell:_onClickDetail()
	local var_5_0 = self._pos

	self:dispatchCompEvent("GveDetailClick", {
		confirmTitle = g.core.lang:get(309118),
		comp = self.m_detailBtn,
		confirmFunc = function()
			g.core.module.ModuleManager:popComponent()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GVE_GOTO_TARGET_POS, false, var_5_0)
		end
	})
end

function GveMySiteCell:_onClickCancelGiveUp()
	g.core.network.GameNetProxy:send_C2S_GVE_WorldCancalGiveupCell({
		x = self._pos.x,
		y = self._pos.y
	})
end

function GveMySiteCell:updateGveSiteCell(arg_8_1)
	self.m_productNameTxt:setText("")
	self.m_productTxt:setText("")

	if arg_8_1.empty then
		self.m_showStateController:setSelectedIndex(1)
	else
		self.m_showStateController:setSelectedIndex(0)

		if arg_8_1.gridData then
			local var_8_0 = arg_8_1.gridData.baseCfg
			local var_8_1 = arg_8_1.gridData.knight

			self.m_siteNameTxt:setText(arg_8_1.gridData.baseCfg.base_name)
			self.m_posTxt:setText(arg_8_1.gridData.cfg.x .. "," .. arg_8_1.gridData.cfg.y)

			if var_8_1 and var_8_1 == 0 then
				self.m_operateBtn:setSpeIconPic("ui://base_new/icon_add_4")
				self.m_hasControlController:setSelectedIndex(0)
			else
				local var_8_2 = g.core.model.User.knightsData:getKnightById(var_8_1)

				self.m_operateBtn:setSpeIconPic((g.core.common.Path:getCampURL(var_8_2:getGroup(), 4)))
				self.m_hasControlController:setSelectedIndex(1)
				self.m_knightIcon:setURL((g.core.common.Path:getKnightIconById(g.core.config.knight_base_info.get(var_8_2:getBaseInfo().res_id).icon_id)))
			end

			self._data = arg_8_1.gridData
			self._pos = {
				x = self._data.cfg.x,
				y = self._data.cfg.y
			}

			local var_8_3 = var_0_3.get(var_0_1:getTargetTile(self._pos))
			local var_8_4

			if var_8_0.if_ruins == 1 then
				self.m_siteIcon:setURL(var_0_1:getPosPic2(var_8_0.base_level))
				self.m_siteBgIcon:setURL("res/common/pic/gve/relic_details/" .. var_8_3.pic .. "_1_1.png")
			else
				self.m_siteBgIcon:setURL("res/common/pic/gve/relic_details/" .. var_8_3.pic .. "_1.png")
				self.m_siteIcon:setURL("")

				var_8_4 = {}
			end

			var_8_4.name = var_0_2:convert({
				type = var_0_2.TYPE_RESOURCE,
				value = var_0_2.RESOURCE.TYPE_GVE_COMMON_RESOURCE
			}).name

			local var_8_5 = g.core.lang:get(309171, var_8_4)
			local var_8_6 = math.floor(3600 / var_8_0.equip_mat_time * var_8_0.equip_mat_rate * 100) / 100
			local var_8_7 = var_0_0:getCurArmyAddProduct()

			if var_8_1 and var_8_1 ~= 0 or var_8_7 ~= 1 then
				local var_8_8 = 0

				if var_8_1 ~= 0 then
					var_8_8 = var_8_6 * var_8_0.addition_mat * 0.001
				end

				if var_8_7 ~= 0 then
					var_8_8 = var_8_8 + math.floor((var_8_8 + var_8_6) * var_8_7 * 100) / 100
				end

				var_8_6 = var_8_6 .. "[color=#24bd81](+" .. var_8_8 .. ")[/color]"
			end

			self.m_productNameTxt:setText(var_8_5)
			self.m_productTxt:setText(g.core.lang:get(309108, {
				size = var_8_6
			}))
		end

		local var_8_9 = var_0_1:getGiveUpTime(self._data.cfg.x, self._data.cfg.y)

		if var_8_9 then
			self.m_stateController:setSelectedIndex(1)
		else
			self.m_stateController:setSelectedIndex(0)
		end

		self._giveUpTs = var_8_9

		self:updateGiveUpTsShow()

		if var_0_1:isSiteCanUpKnight(self._pos) then
			self.m_redPointComp:setShow(true)
		else
			self.m_redPointComp:setShow(false)
		end
	end
end

function GveMySiteCell:updateGiveUpTsShow()
	if self._giveUpTs then
		self.m_giveupTxt:setText(g.core.lang:get(309130, {
			sec = math.max(self._giveUpTs - g.core.common.ServerTime:getTime(), 0)
		}))
	end
end

function GveMySiteCell:onCanCelFunc()
	local var_10_0 = var_0_1:getBuildDataByPos(self._pos).cfg

	if not var_0_1:checkIsGiveUpTipPop() then
		g.core.network.GameNetProxy:send_C2S_GVE_WorldGiveupCell({
			x = var_10_0.x,
			y = var_10_0.y
		})

		return
	end

	local var_10_1 = fgui.UIPackage:createObject("gve", "GveGiveUpConfirmComp")

	var_10_1:update({
		cfg = var_0_1:getBaseCfgByPos(self._pos)
	})

	local var_10_2 = false

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(309137),
		childComp = var_10_1,
		tip = {
			isChecked = false,
			txt = g.core.lang:get(408110)
		},
		onConfirm = function(arg_11_0)
			if var_10_2 then
				var_0_1:setGiveUpTipTime(g.core.common.ServerTime:getTime())
			end

			g.core.network.GameNetProxy:send_C2S_GVE_WorldGiveupCell({
				x = var_10_0.x,
				y = var_10_0.y
			})
		end,
		onCheck = function(arg_12_0)
			var_10_2 = arg_12_0
		end
	}), {
		touchDisappear = true
	})
end

return GveMySiteCell
