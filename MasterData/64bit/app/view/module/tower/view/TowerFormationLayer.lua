local var_0_0 = g.core.config.massive_monster_team_info
local var_0_1 = g.core.config.tower_stage_info
local var_0_2 = g.core.const.ConstMgr
local var_0_4 = g.core.model.User.towerData
local var_0_5 = g.core.model.User
local var_0_6 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_7 = g.core.const.ConstMgr.TowerConst
local var_0_8 = g.core.module.ModuleManager
local BattleKnight = require("app.view.battle.BattleKnight")
local var_0_10 = 201
local TowerFormationLayer = class("TowerFormationLayer", require("app.fairyGUI.tower.UI_TowerFormationLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/tower/tower",
		resName = "TowerFormationLayer",
		pkgName = "tower",
		isFullScreen = true
	}, ...)
end)

function TowerFormationLayer:ctor(arg_2_1)
	self._stageType = arg_2_1 or var_0_7.STAGE_TYPE.JIAO_GUO
	self._knightPosIds = {}
	self._isInitKnight = false
	self._isDragKnight = false
	self._starPos = 0
	self._localPos = 0
	self._stageInfo = 0
	self._isAllowPos = {}
	self._knightData = {}
	self._formationMap = {}
	self._maxCount = 0
	self._curCount = 0
	self._rewardList = {}
	self._oldPower = 0

	self:initData()
	self:initView()
end

function TowerFormationLayer:initData()
	local var_3_0, var_3_1 = var_0_4:getCurTowerIdByType(self._stageType)
	local var_3_2 = var_0_5.knightsData:getFormation() or {}

	self._stageInfo = var_0_1.get(var_3_1)
	self._maxCount = 6

	local var_3_3 = var_0_4:getCurUserKnightIds(self._stageType, self._maxCount)

	self._knightData = var_3_2

	local var_3_4 = {}

	for iter_3_0 = 1, var_0_6.LINEUP_MAX do
		if var_3_2[iter_3_0] > 0 then
			var_3_4[var_3_2[iter_3_0]] = true
		end
	end

	self._formationMap = var_3_4
	self._knightPosIds = {}
	self._curCount = 0

	for iter_3_1, iter_3_2 in pairs({}) do
		for iter_3_3 = 1, var_0_6.LINEUP_MAX do
			if self._knightPosIds[iter_3_3] == 0 and self._isAllowPos[iter_3_3] then
				self._knightPosIds[iter_3_3] = iter_3_2

				break
			end
		end
	end
end

function TowerFormationLayer:initView()
	self:addBg("bg/formation/pic_bz_beijing.jpg")
	self.m_topBar:setHelpId(var_0_2.HelpConst.HELP_TYPE.TOWER)
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_challengeBtn:addClickListener(handler(self, self._onClickChallengeBtn))
	self.m_infoBtn:addClickListener(handler(self, self._onClickInfoBtn))
	self.m_checkBtn:addClickListener(handler(self, self._onCheckBtnClick))
	self.m_checkBtn:setSelected(var_0_4:getIsSelectPopFormation())
	self.m_recommendValue:setText(var_0_0.get((var_0_4:getSwitchMonsterTeamId(self._stageInfo.monster_team_id))).fight)
	self.m_stageOrder:setText(var_0_4:getStageStr(self._stageInfo.stage_order))
	self.m_buffGroup:getChild("buffDesc"):setText(self._stageInfo.details)
	self.m_stageTypeController:setSelectedIndex(self._stageType - 2)
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRendererRewardList))

	self._rewardList = var_0_4:getStageRewardList(self._stageInfo, true)

	self.m_rewardList:setNumItems(#self._rewardList)

	local var_4_0 = var_0_4:getTowerBuffInfo(self._stageType)

	if var_4_0 then
		self.m_buffServer:setVisible(true)
		self.m_buffServer:getChild("buffDesc"):setText(var_4_0.description)
	else
		self.m_buffServer:setVisible(false)
	end

	self.m_buffActivity:setVisible(false)
	self:_initKnightAndIcon()
	self:_initCapacityList()
end

function TowerFormationLayer:_initCapacityList()
	local var_5_0, var_5_1 = var_0_4:getCurTowerIdByType(self._stageType)
	local var_5_2 = var_0_4:getCapacityAddListDataById(var_5_0, var_5_1)

	if table.nums(var_5_2) == 0 then
		self.m_hasAddCapacityController:setSelectedIndex(0)

		return
	else
		self.m_hasAddCapacityController:setSelectedIndex(1)

		for iter_5_0 = 1, 4 do
			local var_5_3 = var_5_2[iter_5_0]
			local var_5_4 = self["m_addRes" .. iter_5_0]

			if self["m_addRes" .. iter_5_0] then
				var_5_4:update(var_5_3, true)
				var_5_4:setVisible(var_5_3 ~= nil)
			end
		end
	end
end

function TowerFormationLayer:_onRendererRewardList(arg_6_1, arg_6_2)
	self._rewardList[arg_6_1 + 1].scaleIndex = 3

	arg_6_2:updateIcon(self._rewardList[arg_6_1 + 1])
end

function TowerFormationLayer:_initKnightAndIcon()
	local var_7_0 = self._stageInfo.passive > 0

	for iter_7_0 = 1, var_0_6.LINEUP_MAX do
		local var_7_1 = self["m_knightIcon" .. iter_7_0]
		local var_7_2 = self:_checkIdIsInPos(self._knightData[iter_7_0])

		if self["m_knightIcon" .. iter_7_0] then
			var_7_1:addClickListener(function()
				self:_onClickKnightIcon(iter_7_0, var_7_1)
			end)

			local var_7_3 = var_7_1:getChild("knightIcon")

			if self._knightData[iter_7_0] > 0 then
				local var_7_4 = var_7_0 and var_0_5.knightsData:getKnight({
					id = self._knightData[iter_7_0]
				}):getGroup() == self._stageType - 1

				var_7_3:updateIcon({
					sid = self._knightData[iter_7_0]
				})
				var_7_3:setCompGray(var_7_2)
				var_7_1:getController("isUpBuff"):setSelectedIndex(var_7_4 and 1 or 0)
				var_7_1:getController("isSelect"):setSelectedIndex(var_7_2 and 1 or 0)
				var_7_1:getController("isNullKnight"):setSelectedIndex(1)
			else
				var_7_1:getController("isNullKnight"):setSelectedIndex(0)
			end
		end
	end

	self._knightComps = {}

	for iter_7_1 = 1, 6 do
		self["m_bottom" .. iter_7_1]:setPos(iter_7_1)

		self._knightComps[iter_7_1] = self["m_knight" .. iter_7_1]

		if self._isAllowPos[iter_7_1] then
			self["m_bottom" .. iter_7_1]:setState(0)
			self._knightComps[iter_7_1]:setPosIndex(iter_7_1)

			self._knightComps[iter_7_1].formation = iter_7_1
		else
			self["m_bottom" .. iter_7_1]:setState(2)
			self._knightComps[iter_7_1]:setVisible(false)
		end
	end
end

function TowerFormationLayer:_checkIdIsInPos(arg_9_1)
	if arg_9_1 == 0 then
		return false
	end

	for iter_9_0, iter_9_1 in pairs(self._knightPosIds) do
		if iter_9_1 == arg_9_1 then
			return true
		end
	end

	return false
end

function TowerFormationLayer:_onClickInfoBtn()
	var_0_8:pushPopup(require("app.view.module.tower.view.TowerBuffPop").new(self._stageType), {
		hideContinue = true,
		touchDisappear = true
	})
end

function TowerFormationLayer:_onClickChallengeBtn()
	local var_11_0 = false

	for iter_11_0, iter_11_1 in pairs(self._knightPosIds) do
		if iter_11_1 > 0 then
			var_11_0 = true

			break
		end
	end

	if not var_11_0 then
		var_0_8:tip(g.core.lang:get(308029))

		return
	end

	local var_11_1, var_11_2 = var_0_4:getSubTowerIsOpen(self._stageType)

	if var_11_1 then
		self:checkSetFromationData()

		local var_11_3, var_11_4 = var_0_4:getCurTowerIdByType(self._stageType)

		g.core.network.GameNetProxy:send_C2S_Tower_ChallengeStageBegin({
			id = var_11_4,
			formation_knight_ids = self._knightPosIds
		})
	else
		var_0_8:tip(g.core.lang:get(308019))
		self:dispatchCompEvent("TowerFormationLayer_remove_noOpen")
	end

	self:removeSelf()
end

function TowerFormationLayer:_onCheckBtnClick()
	var_0_4:setIsSelectPopFormation((self.m_checkBtn:isSelected()))
	self:dispatchCompEvent("SelectNotPopFormation_change")
end

function TowerFormationLayer:onLoad()
	fgui.DragDropManager:getInstance():getAgent():addEventListener(fgui.UIEventType.DragMove, handler(self, self._dragMoveKnight), var_0_10)

	if self.m_enterTransition then
		self.m_enterTransition:play()
	end

	self:updateView()
end

function TowerFormationLayer:updateView()
	self:_updateKnight()
	self:updateTitle()
end

function TowerFormationLayer:updateTitle()
	local var_15_0 = 0

	for iter_15_0 = 1, var_0_6.LINEUP_MAX do
		if self._knightPosIds[iter_15_0] > 0 then
			var_15_0 = var_15_0 + 1
		end
	end

	self.m_maxCount:setText(self._maxCount)
	self.m_curCount:setText(var_15_0)
end

function TowerFormationLayer:_updateKnight()
	local var_16_0 = 0

	for iter_16_0 = 1, var_0_6.LINEUP_MAX do
		local var_16_1 = self._knightComps[iter_16_0]
		local var_16_2 = self._knightPosIds[iter_16_0]

		self._knightComps[iter_16_0]:setKnightId(self._knightPosIds[iter_16_0])
		var_16_1:updateComp()

		if not self._isInitKnight then
			var_16_1:setDraggable(true)
			var_16_1:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragLineupKnight))
			self:addListen(var_16_1)
		end

		var_16_1:setTouchable(var_16_2 > 0)

		if var_16_2 > 0 then
			var_16_0 = var_16_0 + var_0_5.knightsData:getKnight({
				id = var_16_2
			}):getInfo().fight_value

			self["m_bottom" .. iter_16_0]:setState(0)
		elseif self._isAllowPos[iter_16_0] == true then
			self["m_bottom" .. iter_16_0]:setState(self._curCount == self._maxCount and 0 or 1)
		end
	end

	self.m_fightValueText:setText(var_16_0)

	if self._oldPower ~= var_16_0 then
		self.m_fightValueText:runChangeAni(self._oldPower, var_16_0, false)

		self._oldPower = var_16_0
	end

	self._isInitKnight = true
end

function TowerFormationLayer:_dragMoveKnight(arg_17_1)
	if not self._isDragKnight then
		return
	end

	local var_17_0 = arg_17_1:getInput():getTouch()

	if not var_17_0 then
		return
	end

	local var_17_1 = var_17_0:getLocation()

	var_17_1.y = var_17_1.y - 50

	local var_17_2 = false
	local var_17_3

	for iter_17_0 = 1, 6 do
		if self._isAllowPos[iter_17_0] and self._knightComps[iter_17_0].m_touchComp:hitTest(var_17_1, cc.Camera:create()) then
			var_17_2 = true

			if iter_17_0 ~= self._localPos then
				var_17_3 = iter_17_0
			end
		end
	end

	if var_17_3 then
		self._nextPos = var_17_3

		self:_updateExchangeKnight()
	elseif not var_17_2 then
		self._nextPos = self._starPos

		self:_updateExchangeKnight()
	end
end

function TowerFormationLayer:_onClickKnightIcon(arg_18_1, arg_18_2)
	if self._knightData[arg_18_1] == 0 then
		return
	end

	local var_18_0 = 0
	local var_18_1 = 0
	local var_18_2 = 0

	for iter_18_0, iter_18_1 in pairs(self._knightPosIds) do
		if iter_18_1 > 0 then
			var_18_0 = var_18_0 + 1

			if iter_18_1 == self._knightData[arg_18_1] then
				var_18_1 = iter_18_0
			end
		elseif var_18_2 == 0 and self._isAllowPos[iter_18_0] then
			var_18_2 = iter_18_0
		end
	end

	if var_18_1 == 0 then
		if var_18_0 >= self._maxCount then
			var_0_8:tip(g.core.lang:get(308016))

			return
		end

		self._knightPosIds[var_18_2] = self._knightData[arg_18_1]

		arg_18_2:getController("isSelect"):setSelectedIndex(1)
		arg_18_2:getChild("knightIcon"):setCompGray(true)
		self.m_curCount:setText(var_18_0 + 1)

		self._curCount = var_18_0 + 1
	else
		self.m_curCount:setText(var_18_0 - 1)

		self._curCount = var_18_0 - 1
		self._knightPosIds[var_18_1] = 0

		arg_18_2:getController("isSelect"):setSelectedIndex(0)
		arg_18_2:getChild("knightIcon"):setCompGray(false)
	end

	self:checkSetFromationData()
	self:_updateKnight()
end

function TowerFormationLayer:checkSetFromationData()
	if self._curCount == self._maxCount then
		var_0_4:setFormationData(self._stageType, self._maxCount, self._knightPosIds)
	end
end

function TowerFormationLayer:_dragLineupKnight(arg_20_1)
	self._isDragKnight = true

	arg_20_1:preventDefault()

	self._curComp = arg_20_1:getSender()

	self._curComp:hideKnight(true)

	self._starPos = self._curComp.formation
	self._localPos = self._starPos

	for iter_20_0 = 1, 6 do
		self._knightComps[iter_20_0]:checkTouchable(false)
	end

	if self._knightPosIds[self._starPos] > 0 then
		local var_20_0 = arg_20_1:getInput()
		local var_20_1 = fgui.DragDropManager:getInstance()

		var_20_1.startDrag(var_20_0, "common/ui_cocos/lineUp/pic_touming.png", nil, (var_20_0:getTouchId()))

		local var_20_2 = BattleKnight.new({
			base = true,
			scale = 1.2,
			breath = true,
			resId = var_0_5.knightsData:getKnight({
				id = self._knightPosIds[self._starPos]
			}):getResInfo().fight_id
		})

		var_20_2:setScale(1.2)
		var_20_2:setName("knight")
		var_20_1:getAgent():displayObject():addChild(var_20_2)
		var_20_2:setPosition(50, 0)
		self:_updateKnightOpacity(204)
	end
end

function TowerFormationLayer:_updateKnightOpacity(arg_21_1)
	for iter_21_0 = 1, 6 do
		self._knightComps[iter_21_0]:updateKnightOpacity(arg_21_1)
	end
end

function TowerFormationLayer:_updateExchangeKnight()
	local var_22_0 = false
	local var_22_1 = self._curCount == self._maxCount

	if self._localPos ~= self._starPos then
		self._knightComps[self._localPos]:updateComp(self._knightPosIds[self._localPos])

		if self._knightPosIds[self._localPos] > 0 then
			self["m_bottom" .. self._localPos]:setState(0)
		else
			self["m_bottom" .. self._localPos]:setState(var_22_1 and 0 or 1)
		end

		var_22_0 = true
	end

	self._localPos = self._nextPos

	if self._localPos ~= self._starPos then
		self._knightComps[self._starPos]:updateComp(self._knightPosIds[self._localPos])

		if self._knightPosIds[self._localPos] > 0 then
			self["m_bottom" .. self._starPos]:setState(0)
		else
			self["m_bottom" .. self._starPos]:setState(var_22_1 and 0 or 1)
		end

		var_22_0 = true
	end

	if var_22_0 then
		self._knightComps[self._localPos]:setKnightId(self._knightPosIds[self._starPos])
		self._knightComps[self._localPos]:hideKnight(true)

		if self._knightPosIds[self._starPos] > 0 then
			self["m_bottom" .. self._localPos]:setState(0)
		else
			self["m_bottom" .. self._localPos]:setState(var_22_1 and 0 or 1)
		end
	end
end

function TowerFormationLayer:_onTouchEnd(arg_23_1)
	if not self._isDragKnight then
		return
	end

	local var_23_0 = arg_23_1:getInput():getTouch()

	if not var_23_0 then
		return
	end

	self:_updateKnightOpacity(255)

	local var_23_1 = var_23_0:getLocation()

	var_23_1.y = var_23_1.y - 50

	if self._starPos ~= self._localPos then
		local var_23_2 = clone(self._knightPosIds)

		for iter_23_0 = 1, #var_23_2 do
			if iter_23_0 == self._starPos then
				var_23_2[iter_23_0] = self._knightPosIds[self._localPos]
			elseif iter_23_0 == self._localPos then
				var_23_2[iter_23_0] = self._knightPosIds[self._starPos]
			end
		end

		self._knightPosIds = var_23_2

		self:_updateKnight()
		self:checkSetFromationData()
	elseif self._curComp then
		self._curComp:updateComp(self._knightPosIds[self._starPos])
	end

	local var_23_3 = fgui.DragDropManager:getInstance():getAgent()

	if var_23_3:displayObject():getChildByName("knight") then
		var_23_3:displayObject():removeChildByName("knight", true)
	end

	for iter_23_1 = 1, 6 do
		self._knightComps[iter_23_1]:setTouchable(self._knightPosIds[iter_23_1] > 0)
	end

	self._isDragKnight = false
end

function TowerFormationLayer:onUnload()
	self._curComp = nil

	fgui.DragDropManager:getInstance():getAgent():removeEventListener(fgui.UIEventType.DragMove, var_0_10)
	var_0_4:saveFormationJsonData()
end

return TowerFormationLayer
