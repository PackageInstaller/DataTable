local var_0_0 = g.core.module.ModuleManager
local var_0_1 = g.core.model.User.gveDataMgr
local GveFormationSelectKnightLayer = class("GveFormationSelectKnightLayer", require("app.fairyGUI.gve.UI_GveFormationSelectKnightLayer"), function()
	return fgui.GComponent:create({
		resName = "GveFormationSelectKnightLayer",
		pkgPath = "ui/gve/gve",
		isFullScreen = true,
		pkgName = "gve"
	}, ...)
end)

function GveFormationSelectKnightLayer:ctor()
	self._formationData = var_0_1:getGveFormationData()
	self._curSelectPos = 0
	self._curEquipKnightList = {}
	self._curPoolKnightList = {}
	self._isInit = false
	self._popView = nil

	self:initView()
	self.m_enterTransition:play()
end

function GveFormationSelectKnightLayer:initView()
	self:addBg("bg/knightbag/pic_yht_beibao.jpg")
	self.m_topBar:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.GVE_PIONEER_LAYER)
	self.m_actionSpeedText:setText(var_0_1:getGveBaseCfg().action_rate .. "/" .. math.floor(var_0_1:getGveBaseCfg().action_time / 60))
	self.m_actionMaxText:setText(var_0_1:getGveBaseCfg().action_max)
	self.m_cardList:setVirtual()
	self.m_cardList:doFairyBatching(false)
	self.m_cardList:setItemRenderer(handler(self, self._onRendererKnightList))
	self.m_cardList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickCell))
	self.m_presetLoader:addClickListener(handler(self, self._onClickPresetBtn))
end

function GveFormationSelectKnightLayer:_onClickCell(arg_4_1)
	local var_4_0 = arg_4_1:getDataValue() + 1

	if var_4_0 > self._formationData:getPosCurNum() then
		g.core.module.ModuleManager:tip(g.core.lang:get(309023))

		return
	end

	local var_4_1 = self._curEquipKnightList[var_4_0] or {}
	local var_4_2 = var_4_1.knight

	if var_4_1.knight then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
			knightAdvId = var_4_2:getAdvanceId()
		}), {
			withoutAni = true
		})

		return
	end

	self._curSelectPos = var_4_0

	local var_4_3 = require("app.view.base.infoPop.lineup.CommonLineUpKnightPop").new({
		itemUrl = "ui://gve/GveLineUpKnightCell",
		allList = self._formationData:getPoolKnightList(),
		clickCheckFunc = handler(self, self._clickLineup)
	})

	self._popView = var_4_3

	var_0_0:pushPopup(var_4_3, {
		blackOpacity = 0.5,
		ignoreTouch = false,
		touchDisappear = false
	})
end

function GveFormationSelectKnightLayer:_clickLineup(arg_5_1)
	if self._curSelectPos > 0 then
		local function var_5_0()
			g.core.network.GameNetProxy:send_C2S_GVE_WorldSelectKnight({
				datas = {
					{
						id = self._curSelectPos,
						num = arg_5_1:getServerId()
					}
				}
			})
		end

		if self._formationData:checkIsTipPop() then
			var_0_0:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(1257),
				desc = g.core.lang:get(309104),
				tip = {
					txt = g.core.lang:get(201569)
				},
				onConfirm = function()
					var_5_0()

					if self._popView then
						g.core.module.ModuleManager:onlyPopSelfByDisplay(self._popView)

						self._popView = nil
					end
				end,
				onCheck = function(arg_8_0)
					if arg_8_0 then
						self._formationData:setLastTipTime(g.core.common.ServerTime:getTime())
					else
						self._formationData:setLastTipTime(0)
					end
				end
			}))

			return false
		else
			var_5_0()

			self._popView = nil

			return true
		end
	end
end

function GveFormationSelectKnightLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDSELECTKNIGHT, handler(self, self._onSelectSuccess), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDUSERDATAFLUSH, handler(self, self.updateView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDACTIONNOTIFY, handler(self, self.updateView), self)
	g.core.network.GameNetProxy:send_C2S_GVE_WorldUserDataFlush({})
	self:newSchedule(handler(self, self._onScheduleActionTip), 1)
end

function GveFormationSelectKnightLayer:_onScheduleActionTip()
	for iter_10_0, iter_10_1 in ipairs((self.m_cardList:getChildren())) do
		iter_10_1:updateActionTip()
	end
end

function GveFormationSelectKnightLayer:_onSelectSuccess()
	self._curSelectPos = 0

	self:updateView()
end

function GveFormationSelectKnightLayer:updateView()
	self._curEquipKnightList = self._formationData:getEquipKnightList()

	self.m_cardList:setNumItems(var_0_1:getGveBaseCfg().position_max)

	if not self._isInit then
		self._isInit = true

		self.m_cardList:transitionShowCells("enter_scaleIn", 0.03)
	end

	self.m_numText:setText(table.nums((self._formationData:getAllEquipKnightStruct())))
	self.m_maxNumText:setText(g.core.lang:get(201028, {
		num = self._formationData:getPosCurNum()
	}))
end

function GveFormationSelectKnightLayer:_onRendererKnightList(arg_13_1, arg_13_2)
	arg_13_2:updateKnightCardComp(self._curEquipKnightList[arg_13_1 + 1], arg_13_1 + 1)
end

function GveFormationSelectKnightLayer:_onClickPresetBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_FORMATION_PRESET_LAYER)
end

return GveFormationSelectKnightLayer
