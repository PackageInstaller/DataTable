local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.model.User.gveDataMgr:getGveData()
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.const.ConstMgr.GuideConst
local var_0_4 = g.core.config.gve_ground_info
local GveCoordPop = class("GveCoordPop", require("app.fairyGUI.gve.UI_GveCoordPop"), function()
	return fgui.GComponent:create({
		resName = "GveCoordPop",
		pkgPath = "ui/gve/gve",
		pkgName = "gve"
	}, ...)
end)

function GveCoordPop:ctor(arg_2_1)
	var_0_1 = var_0_0:getGveData()
	self._cfg = arg_2_1.cfg
	self._baseCfg = arg_2_1.baseCfg
	self._operate = arg_2_1.operate
	self._valueStr = {}
	self._nameStr = {}
	self._monsters = {}
	self._allCanUpKnight = nil
	self._curSelKnight = nil

	self:showAtCenter()
	self.m_siteInfoList:setVirtual()
	self.m_siteInfoList:setItemRenderer(handler(self, self._onSiteInfoRenderer))
	self.m_mgrKnightComp:setTouchable(false)
	self.m_buffComp1:addClickListener(handler(self, self._onBuffClick1))
	self.m_buffComp2:addClickListener(handler(self, self._onBuffClick2))
	self.m_emptyHolder:addClickListener(handler(self, self._onClickSelf))
	self:updateView()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_PopUp_Task)
end

function GveCoordPop:onLoad()
	self.m_enemyFightComp:setState(2)
	g.core.network.GameNetProxy:send_C2S_GVE_WorldCellDetail({
		x = self._cfg.x,
		y = self._cfg.y
	})

	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GVE_GRID_DETAIL_ENTER) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
			tickType = 6,
			enum = var_0_3.ENUM_TICK.GVE_FIRST_ENTER_GRID_DETAIL
		})
		g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GVE_GRID_DETAIL_ENTER)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	end

	self.m_enterTransition:play(handler(self, self._onEnterEnd))
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDCELLDETAIL, handler(self, self._onGridDetailInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDSETCELLKNIGHT, handler(self, self._onSetCellKnight), self)
end

function GveCoordPop:_onBuffClick1()
	local var_4_0 = var_0_1:getGridBuff(self._cfg.x, self._cfg.y)

	if var_4_0[1] then
		self.m_emptyHolder:setVisible(true)
		self.m_tipsGroup:setVisible(true)
		self.m_tipsTxt:setText(var_0_0:getGveBagData():getCfgBySkillType(var_4_0[1].buffType).main_skill_message)
		self.m_showTipsController:setSelectedIndex(0)
	end
end

function GveCoordPop:_onBuffClick2()
	local var_5_0 = var_0_1:getGridBuff(self._cfg.x, self._cfg.y)

	if var_5_0[2] then
		self.m_emptyHolder:setVisible(true)
		self.m_tipsGroup:setVisible(true)
		self.m_tipsTxt:setText(var_0_0:getGveBagData():getCfgBySkillType(var_5_0[2].buffType).main_skill_message)
		self.m_showTipsController:setSelectedIndex(1)
	end
end

function GveCoordPop:_onClickSelf()
	self.m_tipsGroup:setVisible(false)
	self.m_emptyHolder:setVisible(false)
end

function GveCoordPop:_onGridDetailInfo(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self:updateView()
end

function GveCoordPop:_onEnterEnd()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function GveCoordPop:updateView()
	self._monsters = {}

	self.m_nameTxt:setText(self._baseCfg.base_name)
	self.m_lvTxt:setText("LV." .. self._baseCfg.base_level)

	if self._operate == "control" then
		self.m_dikuaiLoader:setURL("ui://gve/pic_pshc_dikuaibg4")
		self.m_typeController:setSelectedIndex(1)

		local var_9_0 = var_0_1:getAllCanLineUpKnight(self._cfg.x, self._cfg.y)

		self._allCanUpKnight = var_9_0

		local var_9_1 = var_0_1:getMyPointKnightId(self._cfg.x, self._cfg.y)

		self.m_mgrComp:updateAllKnight(var_9_0, var_9_1)

		if var_9_1 ~= 0 then
			self.m_mgrStateController:setSelectedIndex(1)

			local var_9_2 = g.core.model.User.knightsData:getKnightById(var_9_1)

			self.m_mgrKnightComp:updatePlaceKnight({
				knight = var_9_2
			}, true)

			self._curSelKnight = {
				knight = var_9_2
			}
		end

		if self._cfg.group == 0 then
			self.m_mgrStateController:setSelectedIndex(2)
		end
	elseif self._operate ~= "detail" then
		if self._operate == "atk" then
			self.m_dikuaiLoader:setURL("res/common/pic/gve/relic_details/" .. var_0_4.get(var_0_1:getTargetTile(cc.p(self._cfg.x, self._cfg.y))).pic .. ".png")

			local var_9_3 = var_0_1:getPosPic2(self._baseCfg.base_level)

			if var_9_3 and self._baseCfg.if_ruins == 1 then
				self.m_buildIcon:setURL(var_9_3)
			end

			self.m_typeController:setSelectedIndex(0)

			local var_9_4, var_9_5 = var_0_0:getCondIsUnlock(self._baseCfg)

			if var_9_4 then
				if self._operate == "atk" then
					self.m_enemyFightComp:setState(0)
				else
					self.m_enemyFightComp:setState(2)
				end
			else
				self.m_enemyFightComp:setState(3, var_9_5)
			end

			self.m_enemyFightComp:setOpeType(self._operate)
		end
	end

	local var_9_6 = var_0_1:getGridBuff(self._cfg.x, self._cfg.y)

	self._gridBuff = var_9_6

	self.m_buffComp1:setVisible(false)
	self.m_buffComp2:setVisible(false)

	for iter_9_0, iter_9_1 in ipairs(var_9_6 or {}) do
		self["m_buffComp" .. iter_9_0]:updateByBuff(iter_9_1)
		self["m_buffComp" .. iter_9_0]:setVisible(true)
	end

	local var_9_7

	if self._baseCfg.drop_maxlv == 0 then
		self._valueStr[1] = g.core.lang:get(309170)
	else
		self._valueStr[1] = g.core.lang:get(201534, {
			level = self._baseCfg.drop_maxlv
		})
		var_9_7 = {}
	end

	var_9_7.name = var_0_2:convert({
		type = var_0_2.TYPE_RESOURCE,
		value = var_0_2.RESOURCE.TYPE_GVE_COMMON_RESOURCE
	}).name
	self._nameStr[2] = g.core.lang:get(309171, var_9_7)
	self._nameStr[3] = g.core.lang:get(309171, {
		name = var_0_2:convert({
			type = var_0_2.TYPE_RESOURCE,
			value = var_0_2.RESOURCE.TYPE_GVE_BASE_COIN_RESOURCE
		}).name
	})

	local var_9_8 = var_0_1:getMyPointKnightId(self._cfg.x, self._cfg.y)
	local var_9_9 = math.floor(100 * (3600 / self._baseCfg.equip_mat_time) * self._baseCfg.equip_mat_rate) / 100
	local var_9_10 = var_0_0:getCurArmyAddProduct()

	if var_9_8 and var_9_8 ~= 0 or var_9_10 ~= 0 then
		local var_9_11 = 0

		if var_9_8 ~= 0 then
			var_9_11 = var_9_9 * self._baseCfg.addition_mat * 0.001
		end

		if var_9_10 ~= 0 then
			var_9_11 = var_9_11 + math.floor((var_9_11 + var_9_9) * var_9_10 * 100) / 100
		end

		var_9_9 = var_9_9 .. "[color=#24bd81](+" .. var_9_11 .. ")[/color]"
	end

	self._valueStr[2] = g.core.lang:get(309108, {
		size = var_9_9
	})
	self._valueStr[3] = g.core.lang:get(309108, {
		size = math.floor(100 * self._baseCfg.low_coin_rate * 3600 / self._baseCfg.low_coin_time) / 100
	})

	self.m_siteInfoList:setNumItems(3)

	local var_9_12 = {
		[0] = "N",
		"R",
		"SR",
		"SSR"
	}

	if self._cfg.group == 0 then
		self.m_controlAddGroup:setVisible(false)
	else
		self.m_controlAddGroup:setVisible(true)
		self.m_descTxt:setText(g.core.lang:get(309110, {
			groupName = g.core.lang:get(self._cfg.group),
			quality1 = var_9_12[self._baseCfg.knight_quality],
			quality2 = var_9_12[self._baseCfg.knight_quality],
			star = self._baseCfg.knight_star,
			addSize = self._baseCfg.addition_mat / 10
		}))
		self.m_groupIcon:setURL((g.core.common.Path:getCampURL(self._cfg.group, 4)))
	end

	for iter_9_2 = 1, 3 do
		if self._cfg["monster_" .. iter_9_2] ~= 0 then
			table.insert(self._monsters, self._cfg["monster_" .. iter_9_2])
		end
	end

	self.m_enemyFightComp:updateInfoData(self._monsters, self._baseCfg, self._cfg.x, self._cfg.y)
end

function GveCoordPop:_onSetCellKnight()
	g.core.module.ModuleManager:tip(g.core.lang:get(309124))
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function GveCoordPop:receiveCompEvent(arg_11_1, arg_11_2)
	arg_11_2 = arg_11_2 or {}

	if arg_11_1 == "gve_select_pos_ctrl_knight" then
		if not self._allCanUpKnight then
			return
		end

		local var_11_0 = self._allCanUpKnight[arg_11_2.pos]

		if self._curSelKnight and self._curSelKnight.knight:getAdvanceId() == var_11_0.knight:getAdvanceId() then
			self._curSelKnight = nil

			self.m_mgrStateController:setSelectedIndex(0)
			self.m_mgrComp:clearSelect()
		else
			self._curSelKnight = var_11_0

			self.m_mgrKnightComp:updatePlaceKnight(var_11_0, true)
			self.m_mgrStateController:setSelectedIndex(1)
		end
	elseif arg_11_1 == "gve_select_confirm_ctrl_knight" then
		local var_11_1 = self._curSelKnight and self._curSelKnight.knight
		local var_11_2 = var_0_1:getMyPointKnightId(self._cfg.x, self._cfg.y)

		if var_11_1 then
			if var_11_1:getServerId() == var_11_2 then
				g.core.module.ModuleManager:tip(g.core.lang:get(309112))
				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			else
				g.core.network.GameNetProxy:send_C2S_GVE_WorldSetCellKnight({
					x = self._cfg.x,
					y = self._cfg.y,
					knight_id = var_11_1:getServerId()
				})
			end
		elseif not self._curSelKnight and var_11_2 ~= 0 then
			g.core.network.GameNetProxy:send_C2S_GVE_WorldSetCellKnight({
				knight_id = 0,
				x = self._cfg.x,
				y = self._cfg.y
			})
		else
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		end
	elseif arg_11_1 == "Gve_close_parent_pop" then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function GveCoordPop:_onSiteInfoRenderer(arg_12_1, arg_12_2)
	arg_12_2:updateInfoData(arg_12_1, self._valueStr[arg_12_1 + 1], self._nameStr[arg_12_1 + 1])
end

return GveCoordPop
