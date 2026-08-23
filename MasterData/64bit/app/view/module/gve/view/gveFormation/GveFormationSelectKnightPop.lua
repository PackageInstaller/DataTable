local var_0_0 = g.core.module.ModuleManager
local var_0_1 = g.core.model.User.gveDataMgr
local GveFormationSelectKnightPop = class("GveFormationSelectKnightPop", require("app.fairyGUI.gve.UI_GveFormationSelectKnightPop"), function()
	return fgui.GComponent:create({
		pkgName = "gve",
		isFullScreen = true,
		pkgPath = "ui/gve/gve",
		resName = "GveFormationSelectKnightPop"
	}, ...)
end)

function GveFormationSelectKnightPop:ctor()
	self._formationData = var_0_1:getGveFormationData()
	self._hasData = false
	self._isInit = false
	self._curSelectPos = 0
	self._curSelectIndexList = {}
	self._maxCount = 0
	self._curEquipKnightList = {}
	self._curPoolKnightList = {}

	self:initView()
end

function GveFormationSelectKnightPop:initView()
	self.m_touchClose:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClickClose))
	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirmBtn))
	self.m_curList:setVirtual()
	self.m_curList:setItemRenderer(handler(self, self._onRendererCurList))
	self.m_poolList:setVirtual()
	self.m_poolList:setItemRenderer(handler(self, self._onRendererPoolList))
	self.m_rateText:setText(var_0_1:getGveBaseCfg().action_rate .. "/" .. math.floor(var_0_1:getGveBaseCfg().action_time / 60))

	local var_3_0 = self:getView():getSharedTrans("enter", "CommonRightPanelAnim", self.m_content)

	if var_3_0 then
		self._isPlaying = true

		var_3_0:setHook("listEnter", handler(self, self.transPlayEnd))
		var_3_0:play()
	end
end

function GveFormationSelectKnightPop:transPlayEnd()
	self._isPlaying = false

	if self._hasData then
		self:updateView(false)
	end
end

function GveFormationSelectKnightPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDSELECTKNIGHT, self._onSelectSuccess, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDUSERDATAFLUSH, self._onGetPosData, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDACTIONNOTIFY, self.transPlayEnd, self)
	g.core.network.GameNetProxy:send_C2S_GVE_WorldUserDataFlush({})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function GveFormationSelectKnightPop:_onGetPosData()
	self._hasData = true

	if not self._isPlaying then
		self:updateView(false)
	end
end

function GveFormationSelectKnightPop:_onRendererCurList(arg_7_1, arg_7_2)
	arg_7_2:updateEquipCell(self._curEquipKnightList[arg_7_1 + 1], arg_7_1 + 1, self._curSelectPos, handler(self, self._cellCall))
end

function GveFormationSelectKnightPop:_onRendererPoolList(arg_8_1, arg_8_2)
	arg_8_2:updatePoolCell(self._curPoolKnightList[arg_8_1 + 1], arg_8_1 + 1, self._curSelectIndexList, handler(self, self._cellCall))
end

function GveFormationSelectKnightPop:_cellCall(arg_9_1, arg_9_2)
	if arg_9_1 == "cell_equip_pos" then
		self._curSelectPos = arg_9_2.pos

		self.m_curList:setNumItems(var_0_1:getGveBaseCfg().position_max)
		self.m_isShowPoolController:setSelectedIndex(1)
	elseif arg_9_1 == "cell_select_pos" then
		if self._curSelectIndexList[arg_9_2.pos] then
			self._curSelectIndexList[arg_9_2.pos] = nil
		elseif table.nums(self._curSelectIndexList) >= self._maxCount then
			var_0_0:tip(g.core.lang:get(309027))
		else
			self._curSelectIndexList[arg_9_2.pos] = true
		end

		self.m_poolList:setNumItems(#self._curPoolKnightList)
	end
end

function GveFormationSelectKnightPop:_onSelectSuccess()
	self._curSelectPos = 0

	self:updateView(true)
end

function GveFormationSelectKnightPop:updateView(arg_11_1)
	self._curEquipKnightList = self._formationData:getEquipKnightList()

	local var_11_0 = 0

	for iter_11_0, iter_11_1 in pairs(self._curEquipKnightList) do
		if not iter_11_1.knight then
			var_11_0 = var_11_0 + 1
		end
	end

	self._maxCount = var_11_0

	self.m_curList:setNumItems(var_0_1:getGveBaseCfg().position_max)

	if not arg_11_1 then
		self.m_curList:transitionShowCells("listIconUiScaleIn", 0.03)
	end

	self._curPoolKnightList = self._formationData:getPoolKnightList()

	self.m_poolList:setNumItems(#self._curPoolKnightList)
end

function GveFormationSelectKnightPop:_onClickConfirmBtn()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Page_Open_02)

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(self._curSelectIndexList) do
		if self._curPoolKnightList[iter_12_0] then
			table.insert(var_12_0, self._curPoolKnightList[iter_12_0]:getServerId())
		end
	end

	local var_12_1 = {}
	local var_12_2 = 0

	for iter_12_2, iter_12_3 in pairs(self._curEquipKnightList) do
		if not iter_12_3.knight then
			var_12_2 = var_12_2 + 1

			if not var_12_0[var_12_2] then
				break
			end

			table.insert(var_12_1, {
				id = iter_12_3.pos,
				num = var_12_0[var_12_2]
			})
		end
	end

	if #var_12_1 > 0 then
		local function var_12_3()
			g.core.network.GameNetProxy:send_C2S_GVE_WorldSelectKnight({
				datas = var_12_1
			})
			self.m_isShowPoolController:setSelectedIndex(0)

			self._curSelectIndexList = {}
			self._curSelectPos = 0
		end

		if self._formationData:checkIsTipPop() then
			var_0_0:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(1257),
				desc = g.core.lang:get(309104),
				tip = {
					txt = g.core.lang:get(201569)
				},
				onConfirm = function()
					var_12_3()
				end,
				onCheck = function(arg_15_0)
					if arg_15_0 then
						self._formationData:setLastTipTime(g.core.common.ServerTime:getTime())
					else
						self._formationData:setLastTipTime(0)
					end
				end,
				onCancel = function()
					self._curSelectIndexList = {}

					self.m_poolList:setNumItems(#self._curPoolKnightList)
				end
			}))
		else
			var_12_3()
		end
	else
		var_0_0:tip(g.core.lang:get(309103))
	end
end

function GveFormationSelectKnightPop:_onClickClose(arg_17_1)
	if self._isOnClose then
		return
	end

	if true then
		self.m_isShowPoolController:setSelectedIndex(0)
		self.m_curList:setTouchable(false)

		self._isOnClose = true

		local var_17_0 = self:getView():getSharedTrans("back", "CommonRightPanelAnim", self.m_content)

		if var_17_0 then
			var_17_0:play(function()
				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			end)
		else
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		end
	end
end

return GveFormationSelectKnightPop
