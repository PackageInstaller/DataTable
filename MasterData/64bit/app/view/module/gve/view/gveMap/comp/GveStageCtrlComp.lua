local var_0_1 = g.core.model.User.gveDataMgr
local var_0_2 = g.core.model.User.gveDataMgr:getGveData()
local var_0_3 = g.core.model.User.gveDataMgr:getGveBagData()
local var_0_5 = g.core.const.ConstMgr.GveConst
local GveStageCtrlComp = class("GveStageCtrlComp", require("app.fairyGUI.gve.UI_GveStageCtrlComp"))

function GveStageCtrlComp:ctor()
	var_0_3 = var_0_1:getGveBagData()
	var_0_2 = var_0_1:getGveData()

	self.m_detailBtn:addClickListener(handler(self, self.onDetailBtnClick))
	self.m_atkBtn:addClickListener(handler(self, self.onAtkClick))
	self.m_cancelBtn:addClickListener(handler(self, self.onCancelBtnClick))
	self.m_controlBtn:addClickListener(handler(self, self.onControlBtnClick))
	self.m_deleteBtn:addClickListener(handler(self, self.onDeleteBtnClick))
	self.m_shareBtn:addClickListener(handler(self, self.onShareBtnClick))
	self.m_buffComp1:addClickListener(handler(self, self.onBuff1Click))
	self.m_buffComp2:addClickListener(handler(self, self.onBuff2Click))
	self.m_teamIconLoader:addClickListener(handler(self, self.onClickPioneerTeamClick))
end

function GveStageCtrlComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GVE_MY_GRID_CHANGE, handler(self, self._onDeleteMyGrid), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDCELLDETAIL, handler(self, self._onGridDetailBack), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CLICK_FINISH, self.onClickFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateUser, self)
	self:updateView()
end

function GveStageCtrlComp:onDetailBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.gve.view.gveStage.GveCoordPop").new({
		operate = "detail",
		baseCfg = var_0_2:getBaseCfgByPos(self._pos),
		cfg = var_0_2:getBuildDataByPos(self._pos).cfg
	})))
	self:dispatchCompEvent("Stage_ctrl_ope_finish")
end

function GveStageCtrlComp:onAtkClick()
	if not var_0_1:getGveData():isCurSiteCanClick(self._pos.x, self._pos.y) then
		self:dispatchCompEvent("Stage_ctrl_ope_finish")

		return
	end

	if var_0_2:canIGetNewGrid() then
		if not var_0_2:getTargetPath(self._pos) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GVE_GRID_WARN, false, {
				points = var_0_2:getSiteAroundSites(self._pos.x, self._pos.y)
			})
			g.core.module.ModuleManager:tip(g.core.lang:get(309140))
		else
			local var_4_0 = require("app.view.module.gve.view.gveStage.GveCoordPop").new
			local var_4_1 = {
				operate = "atk",
				baseCfg = var_0_2:getBaseCfgByPos(self._pos)
			}

			var_4_1.cfg = var_0_2:getBuildDataByPos(self._pos).cfg

			g.core.module.ModuleManager:pushPopup((require("app.view.module.gve.view.gveStage.GveCoordPop").new(var_4_1)))
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(309125))
	end
end

function GveStageCtrlComp:onCancelBtnClick()
	local var_5_0 = var_0_2:getBuildDataByPos(self._pos).cfg

	g.core.network.GameNetProxy:send_C2S_GVE_WorldCancalGiveupCell({
		x = var_5_0.x,
		y = var_5_0.y
	})
	self:dispatchCompEvent("Stage_ctrl_ope_finish")
end

function GveStageCtrlComp:onControlBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.gve.view.gveStage.GveCoordPop").new({
		operate = "control",
		baseCfg = var_0_2:getBaseCfgByPos(self._pos),
		cfg = var_0_2:getBuildDataByPos(self._pos).cfg
	})))
	self:dispatchCompEvent("Stage_ctrl_ope_finish")
end

function GveStageCtrlComp:onDeleteBtnClick()
	if var_0_2:isGridCanGiveUp() then
		self:onCanCelFunc()
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(309123))
	end

	self:dispatchCompEvent("Stage_ctrl_ope_finish")
end

function GveStageCtrlComp:onShareBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(309160),
		desc = g.core.lang:get(309161),
		onConfirm = handler(self, self._shareStagePosInfo)
	}))
end

function GveStageCtrlComp:_shareStagePosInfo()
	g.core.network.GameNetProxy:send_C2S_BulletScreenSend({
		look = 0,
		content = "",
		type = g.core.model.User.chatData:toSvrChatType(g.core.const.ConstMgr.ChatConst.ALLIANCE),
		param1 = self._pos.x .. "_" .. self._pos.y,
		share = {
			share_type = 15,
			id = g.core.model.User:getId()
		}
	})
	g.core.model.User.chatData:setLastSendConnectTime(g.core.const.ConstMgr.ChatConst.ALLIANCE)
	self:dispatchCompEvent("Stage_ctrl_ope_finish")
end

function GveStageCtrlComp:updateByPos(arg_10_1)
	self._tempUserVisible = self.m_userIcon:isVisible()

	self.m_userIcon:setVisible(false)
	self.m_pioneerTeam:setVisible(false)

	self._pos = arg_10_1

	self:updateView()

	local var_10_0, var_10_1 = var_0_2:getPosNowBossCfg(arg_10_1.x, arg_10_1.y)

	if var_10_1 then
		self.m_teamIconLoader:setURL(g.core.common.Path:getAllianceFlag128(var_0_1:getPioneerTeamIconId() or 5))
		self.m_pioneerTeam:setVisible(true)
	elseif not self._pos or self._pos.x ~= self._pos.x or self._pos.y ~= self._pos.y then
		if self.m_stateController:getSelectedIndex() == 1 then
			local var_10_2 = var_0_2:getBuildDataByPos(self._pos).cfg

			g.core.network.GameNetProxy:send_C2S_GVE_WorldCellDetail({
				x = var_10_2.x,
				y = var_10_2.y
			})
		end

		self.m_enterTransition:play()
	else
		self.m_userIcon:setVisible(self._tempUserVisible)
	end
end

function GveStageCtrlComp:onClickPioneerTeamClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_PIONEER_LAYER)
end

function GveStageCtrlComp:_onDeleteMyGrid(arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3 and arg_12_3.delete then
		if not self._pos then
			return
		end

		local var_12_0 = var_0_2:getBuildDataByPos(self._pos).cfg

		if var_12_0.x == arg_12_3.delete.x and var_12_0.y == arg_12_3.delete.y then
			self:setVisible(false)
		end
	end
end

function GveStageCtrlComp:onCanCelFunc()
	local var_13_0 = var_0_2:getBuildDataByPos(self._pos).cfg

	if not var_0_2:checkIsGiveUpTipPop() then
		g.core.network.GameNetProxy:send_C2S_GVE_WorldGiveupCell({
			x = var_13_0.x,
			y = var_13_0.y
		})

		return
	end

	local var_13_1 = fgui.UIPackage:createObject("gve", "GveGiveUpConfirmComp")

	var_13_1:update({
		cfg = var_0_2:getBaseCfgByPos(self._pos)
	})

	local var_13_2 = false

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(309137),
		childComp = var_13_1,
		tip = {
			isChecked = false,
			txt = g.core.lang:get(408110)
		},
		onConfirm = function(arg_14_0)
			if var_13_2 then
				var_0_2:setGiveUpTipTime(g.core.common.ServerTime:getTime())
			end

			g.core.network.GameNetProxy:send_C2S_GVE_WorldGiveupCell({
				x = var_13_0.x,
				y = var_13_0.y
			})
		end,
		onCheck = function(arg_15_0)
			var_13_2 = arg_15_0
		end
	}), {
		touchDisappear = true
	})
end

function GveStageCtrlComp:_onGridDetailBack(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	if not self._pos then
		return
	end

	local var_16_0 = var_0_2:getBuildDataByPos(self._pos).cfg

	if arg_16_4.x == var_16_0.x and arg_16_4.y == var_16_0.y then
		self:_updateUser()
	end
end

function GveStageCtrlComp:_updateUser()
	if not self._pos then
		return
	end

	local var_17_0 = var_0_2:getCellUid(self._pos)

	if var_17_0 and var_17_0 >= 10000 then
		local var_17_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_17_0)

		if var_17_1 then
			self.m_userIcon:updateAsUser(var_17_1)
			self.m_userIcon:setVisible(true)
			self.m_userIcon:setTouchCallFunc(function()
				g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
					uid = var_17_1.id
				})
				g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_MenuOpen_LargeB)
			end)
		end
	end
end

function GveStageCtrlComp:updateView()
	local var_19_0

	if not self._pos then
		do return end

		var_19_0 = var_0_2:getBaseCfgByPos(self._pos)
	end

	local var_19_1 = var_0_2:getBuildDataByPos(self._pos).cfg

	if var_19_0 then
		self.m_nameTxt:setText(var_19_0.base_name .. "(Lv" .. var_19_0.base_level .. ")")
	end

	self.m_posTxt:setText("W" .. var_19_1.x .. ",E" .. var_19_1.y)

	local var_19_2 = var_0_2:getGridColorEnum(var_19_1.x, var_19_1.y)

	if var_19_2 then
		if var_19_2 == var_0_5.COLOR_TYPE.MINE then
			self.m_stateController:setSelectedIndex(2)
		elseif var_19_2 == var_0_5.COLOR_TYPE.OTHER_NO_PASS or var_19_2 == var_0_5.COLOR_TYPE.OTHER_PASS then
			self.m_stateController:setSelectedIndex(1)
		end
	else
		self.m_stateController:setSelectedIndex(0)
	end

	if var_0_2:getGiveUpTime(var_19_1.x, var_19_1.y) then
		self.m_stateController:setSelectedIndex(3)
	end

	local var_19_3, var_19_4 = var_0_2:getPosNowBossCfg(self._pos.x, self._pos.y)

	if var_19_4 then
		self.m_buildStateController:setSelectedIndex(var_19_4.range - 1)
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_buildStateController:setSelectedIndex(var_19_0.base_type - 1)
	end

	local var_19_5 = var_0_2:getGridBuff(var_19_1.x, var_19_1.y)

	self._gridBuff = var_19_5

	self.m_buffComp1:setVisible(false)
	self.m_buffComp2:setVisible(false)

	for iter_19_0, iter_19_1 in ipairs(var_19_5 or {}) do
		if self["m_buffComp" .. iter_19_0] then
			self["m_buffComp" .. iter_19_0]:updateByBuff(iter_19_1)
			self["m_buffComp" .. iter_19_0]:setVisible(true)
		end
	end

	local var_19_6 = var_0_2:getMyPointKnightId(var_19_1.x, var_19_1.y)

	if var_19_6 and var_19_6 == 0 then
		self.m_controlBtn:setSpeIconPic("ui://base_new/icon_add_4")
	else
		self.m_controlBtn:setSpeIconPic((g.core.common.Path:getCampURL(g.core.model.User.knightsData:getKnightById(var_19_6):getGroup(), 4)))
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_CardError)
end

function GveStageCtrlComp:onBuff1Click()
	if self._gridBuff and self._gridBuff[1] then
		self:showBuffTips(1)
		self.m_tipsPosController:setSelectedIndex(0)
	end
end

function GveStageCtrlComp:onBuff2Click()
	if self._gridBuff and self._gridBuff[2] then
		self:showBuffTips(2)
		self.m_tipsPosController:setSelectedIndex(1)
	end
end

function GveStageCtrlComp:showBuffTips(arg_22_1)
	local var_22_0 = var_0_3:getCfgBySkillType(self._gridBuff[arg_22_1].buffType)
	local var_22_1 = 0

	if self._gridBuff[arg_22_1].buffType == 8 then
		var_22_1 = self._gridBuff[arg_22_1].buffNum * var_22_0.main_skill_param_2 < var_22_0.main_skill_param_3 and self._gridBuff[arg_22_1].buffNum * var_22_0.main_skill_param_2 or var_22_0.main_skill_param_3
	elseif self._gridBuff[arg_22_1].buffType == 9 then
		var_22_1 = math.min(self._gridBuff[arg_22_1].buffNum, var_22_0.main_skill_param_3) * var_22_0.main_skill_param_2 / 10
	end

	self.m_buffTips:setTitle(g.core.lang:getByString(var_22_0.main_skill_message, {
		num1 = var_22_1
	}))
	self.m_buffTips:setVisible(true)
end

function GveStageCtrlComp:onClickFinish()
	self.m_buffTips:setVisible(false)
end

return GveStageCtrlComp
