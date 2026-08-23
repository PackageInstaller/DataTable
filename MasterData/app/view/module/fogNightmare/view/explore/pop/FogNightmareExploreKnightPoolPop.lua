local var_0_0 = g.core.model.User.fogNightmareData
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.SoundConst
local FogNightmareExploreKnightPoolPop = class("FogNightmareExploreKnightPoolPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreKnightPoolPop"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareExploreKnightPoolPop",
		pkgPath = "ui/fogNightmare/fogNightmare",
		isFullScreen = true,
		pkgName = "fogNightmare"
	}, ...)
end)

function FogNightmareExploreKnightPoolPop:ctor(arg_2_1)
	self._lineUpMembers = arg_2_1.lineUpMembers or {}
	self._poolInfos = arg_2_1.lastPoolDatas or {}
	self._listAllNum = var_0_0:getMaxKnightNum()
	self._restKnights = var_0_0:getFormationData():getSelectInfos("knights")
	self._jumpFloor = arg_2_1.floor or 1
	self._curKnightCnt = 0
	self._curKeepsakeCnt = 0
	self._initTrans = false

	self:_initView()

	if #self._lineUpMembers ~= self._listAllNum then
		self.m_showBtnController:setSelectedIndex(1)
	end

	self.m_topBarComp:setResInfoById(var_0_1.HelpConst.HELP_TYPE.FOG_NIGHTMARE)

	self._targetPos = nil

	self:checkLocalSavePoolInfo()
	self:_updatePopGroupKnights()
	self:showAtCenter()
	self.m_enterTransition:play(handler(self, self._onEnterTransFinish))
	g.core.sound.SoundManager:playSound(var_0_2.Sound.FOG_NIGHTMARE_EXPLORE_OPEN)
end

function FogNightmareExploreKnightPoolPop:_onEnterTransFinish()
	if not var_0_0:getFormationData():hasPoolMember() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	end
end

function FogNightmareExploreKnightPoolPop:_initView()
	self.m_poolList:setVirtual(self)
	self.m_poolList:doFairyBatching(false)
	self.m_poolList:setItemRenderer(handler(self, self._onRendererPoolItem))
	self.m_poolList:setNumItems(#self._poolInfos)
	self.m_startBtn:addClickListener(handler(self, self._onStartBtnClicked))
	self.m_autoBtn:addClickListener(handler(self, self._onAutoBtnClicked))

	self._noLineUp = #self._lineUpMembers == 0

	self.m_autoBtn:setVisible(self._noLineUp)
	self.m_startBtn:setVisible(self._noLineUp)

	self._isHideFilter = self._noLineUp
end

function FogNightmareExploreKnightPoolPop:_onRendererPoolItem(arg_5_1, arg_5_2)
	arg_5_2:updateComp(self._poolInfos[arg_5_1 + 1] or {}, arg_5_1 + 1, self._jumpFloor > 1)
end

function FogNightmareExploreKnightPoolPop:updateTitleUI()
	self._curKnightCnt = 0
	self._curKeepsakeCnt = 0

	for iter_6_0, iter_6_1 in pairs(self._poolInfos) do
		if iter_6_1.knight then
			self._curKnightCnt = self._curKnightCnt + 1
		end

		if iter_6_1.keepsake then
			self._curKeepsakeCnt = self._curKeepsakeCnt + 1
		end
	end

	self.m_knightNumText:setText(g.core.lang:get(500135, {
		cur = self._curKnightCnt,
		max = self._listAllNum
	}))
	self.m_keepsakeNumText:setText(g.core.lang:get(500135, {
		cur = self._curKeepsakeCnt,
		max = self._listAllNum
	}))
end

function FogNightmareExploreKnightPoolPop:_addCustomEvent()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_KNIGHTUP, self._onLineUpSucc, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_FAST, self._onFastSucc, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_ADDKNIGHT, self._onLineUpSucc, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_FRIEND_ASSISTANT_ERROR, self._onLineUpAssistantError, self)
end

function FogNightmareExploreKnightPoolPop:onLoad()
	self:_addCustomEvent()
	self:updateView()
	self:updateTitleUI()
end

function FogNightmareExploreKnightPoolPop:updateView()
	self.m_poolList:setNumItems(self._listAllNum)

	if not self._initTrans then
		self._initTrans = true

		self.m_poolList:transitionShowCells("listIconUiScaleIn", 0.06)
	end
end

function FogNightmareExploreKnightPoolPop:receiveCompEvent(arg_10_1, arg_10_2)
	if arg_10_1 == "clickAddKnight" then
		self._targetPos = arg_10_2.pos

		if self._lineUpMembers[self._targetPos] then
			self._targetPos = nil

			g.core.module.ModuleManager:tip(g.core.lang:get(500170))

			return
		end

		if self._targetPos == 1 then
			self:_showFriendAssitantPop()
		else
			if self._noLineUp then
				self:updatePopGroupKnightsExceptPos()
			end

			arg_10_2 = {
				providerPath = "ui://fogNightmare/FogNightmareExploreLineUpKnightComp",
				infos = self._groupKnights,
				tabTexts = {
					g.core.lang:get(5),
					g.core.lang:get(1),
					g.core.lang:get(2),
					g.core.lang:get(3),
					g.core.lang:get(4)
				},
				selectCheckFunc = handler(self, self.checkKnihtCanSelected),
				selectSameFunc = handler(self, self.checkSameKnightSelected),
				sortFunc = function(self, arg_11_1)
					if self._noLineUp then
						local var_11_0 = self:getTempFormationPos()
						local var_11_1 = arg_11_1:getTempFormationPos()

						if var_11_0 ~= var_11_1 then
							return var_11_1 < var_11_0
						end
					end

					local var_11_2 = self:getQuality()
					local var_11_3 = arg_11_1:getQuality()

					if var_11_2 ~= var_11_3 then
						return var_11_3 < var_11_2
					end

					local var_11_4 = self:getStarLv()
					local var_11_5 = arg_11_1:getStarLv()

					if var_11_4 ~= var_11_5 then
						return var_11_5 < var_11_4
					end

					return self:getAdvanceId() > arg_11_1:getAdvanceId()
				end,
				isFilter = self._noLineUp == false
			}

			self:_showLineUpPop(arg_10_2)
		end

		return true
	elseif arg_10_1 == "clickAddKeepsake" then
		if self._jumpFloor <= 1 then
			if self._poolInfos[arg_10_2.pos] and self._poolInfos[arg_10_2.pos].keepsake then
				g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareKnightKeepsakeInfoPop").new(self._poolInfos[arg_10_2.pos].knight), {
					ignoreTouch = false,
					hideContinue = false,
					touchDisappear = true
				})
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(500172))
			end

			return
		end

		local var_10_0 = g.core.model.User.fogNightmareData:getTowerData():getFloorStruct(self._jumpFloor)

		self._targetPos = arg_10_2.pos
		arg_10_2 = {
			providerPath = "ui://fogNightmare/FogNightmareExploreLineUpKeepsakeComp",
			topTip = g.core.lang:get(500209, {
				num = self._jumpFloor,
				level = var_10_0:getKeepsakeLevel(true)
			}),
			infos = {
				(var_0_0:getKeepsakeData():getNormalKeepsakeStructsByKnightIdAndLv(arg_10_2.knightStruct:getAdvanceId(), math.min(var_10_0:getKeepsakeLevel(true), var_0_0:getFogSealLevel()), arg_10_2.knightStruct:getProfession()))
			},
			selectCheckFunc = handler(self, self.checkKeepsakeCanSelected),
			sortFunc = function(self, arg_12_1)
				local var_12_0 = g.core.model.User.fogNightmareData:getTempSelectSakeId()
				local var_12_1 = var_12_0 > 0 and var_12_0 == self:getCfg().id and 0 or 1
				local var_12_2 = var_12_0 > 0 and var_12_0 == arg_12_1:getCfg().id and 0 or 1

				if var_12_1 ~= var_12_2 then
					return var_12_2 < var_12_1
				end

				return false
			end
		}

		self:_showLineUpPop(arg_10_2)

		return true
	elseif arg_10_1 == "LineListItemSelected" then
		if arg_10_2.struct.__cname == "SpecialKnightStruct" then
			local var_10_1 = self._poolInfos[self._targetPos]

			if not self._poolInfos[self._targetPos] then
				var_10_1 = {}
				self._poolInfos[self._targetPos] = var_10_1
			end

			if var_10_1.knight then
				var_10_1.knight:updateTempFormationPos(0)
			end

			var_10_1.knight = arg_10_2.struct
			var_10_1.keepsake = nil

			arg_10_2.struct:updateTempFormationPos(self._targetPos)
			self.m_poolList:setNumItems(self._listAllNum)
		else
			local var_10_2 = self._poolInfos[self._targetPos]

			if not self._poolInfos[self._targetPos] then
				var_10_2 = {}
				self._poolInfos[self._targetPos] = var_10_2
			end

			var_10_2.keepsake = arg_10_2.struct

			self.m_poolList:setNumItems(self._listAllNum)

			self._targetPos = nil

			g.core.module.ModuleManager:tip(g.core.lang:get(500200))
		end

		if not self._noLineUp then
			if self._poolInfos[self._targetPos] and self._poolInfos[self._targetPos].knight then
				self:_onAddKnightReqWhenPlayBegin(self._poolInfos[self._targetPos].knight)
			end
		end

		self:changeOneKeyBtnState()
	elseif arg_10_1 == "LineListSameItemSelected" then
		if arg_10_2.struct.__cname == "SpecialKnightStruct" then
			if self._poolInfos[self._targetPos] and self._poolInfos[self._targetPos].knight then
				self._poolInfos[self._targetPos].knight:updateTempFormationPos(0)
			end

			self._poolInfos[self._targetPos] = nil

			self.m_poolList:setNumItems(self._listAllNum)
			self:changeOneKeyBtnState()
		end
	elseif arg_10_1 == "FogNightAssistantSelected" then
		local var_10_3 = self._poolInfos[1] == nil
		local var_10_4 = self._poolInfos
		local var_10_5 = {}

		var_10_5.knight = g.core.model.User.fogNightmareData:getAssistantData():getCurSelAssistantKnight()[1]
		var_10_4[1] = var_10_5

		self.m_poolList:setNumItems(self._listAllNum)

		if not self._noLineUp and var_10_3 then
			self:_onAddKnightReqWhenPlayBegin(self._poolInfos[1].knight)
		end

		self:updateTitleUI()

		return true
	end

	return false
end

function FogNightmareExploreKnightPoolPop:_onLineUpAssistantError()
	g.core.model.User.fogNightmareData:getAssistantData():setAssistantEmpty()

	self._poolInfos[1] = nil

	self.m_poolList:setNumItems(self._listAllNum)

	if not self._noLineUp then
		self:_onAddKnightReq()
	end

	self:updateTitleUI()
end

function FogNightmareExploreKnightPoolPop:_onStartBtnClicked()
	local var_14_0 = g.core.config.parameter_info.get(20054).parameter
	local var_14_1 = table.nums(self._poolInfos)

	if var_14_1 < var_14_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(500149, {
			num = var_14_0
		}))

		return
	end

	if var_14_1 > self._listAllNum then
		g.core.module.ModuleManager:tip(g.core.lang:get(500158, {
			num = self._listAllNum
		}))

		return
	end

	if self._jumpFloor > 1 then
		local var_14_2 = {}

		for iter_14_0, iter_14_1 in pairs(self._poolInfos) do
			if iter_14_1.knight then
				local var_14_3 = #var_14_2 + 1
				local var_14_4 = {
					id = iter_14_1.knight:getServerId(),
					user_id = iter_14_1.knight:getOwner().id
				}

				var_14_4.seal_level_id = iter_14_1.keepsake and iter_14_1.keepsake:getCfg().id or 0
				var_14_2[var_14_3] = var_14_4
			end
		end

		g.core.network.GameNetProxy:send_C2S_Fog_Fast({
			floor = self._jumpFloor,
			fast_knights = var_14_2
		})
	elseif #self._lineUpMembers > 0 then
		self:_onAddKnightReq()
	else
		local var_14_5 = {}

		for iter_14_2, iter_14_3 in pairs(self._poolInfos) do
			if iter_14_3.knight then
				var_14_5[#var_14_5 + 1] = {
					id = iter_14_3.knight:getServerId(),
					num = iter_14_3.knight:getOwner().id
				}
			end
		end

		g.core.network.GameNetProxy:send_C2S_Fog_KnightUp({
			knights = var_14_5
		})
	end
end

function FogNightmareExploreKnightPoolPop:_onAddKnightReq()
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(self._poolInfos) do
		if iter_15_1.knight and not self._lineUpMembers[iter_15_0] then
			var_15_0[#var_15_0 + 1] = {
				id = iter_15_1.knight:getServerId(),
				num = iter_15_1.knight:getOwner().id
			}
		end
	end

	if #var_15_0 > 0 then
		g.core.network.GameNetProxy:send_C2S_Fog_AddKnight({
			knights = var_15_0
		})
	end
end

function FogNightmareExploreKnightPoolPop:_onAddKnightReqWhenPlayBegin(arg_16_1)
	if not arg_16_1 then
		return
	end

	local var_16_0 = {}

	table.insert(var_16_0, {
		id = arg_16_1:getServerId(),
		num = arg_16_1:getOwner().id
	})
	g.core.network.GameNetProxy:send_C2S_Fog_AddKnight({
		knights = var_16_0
	})
end

function FogNightmareExploreKnightPoolPop:_onAutoBtnClicked()
	if self:checkOneKeySelect() then
		for iter_17_0 = 1, self._listAllNum do
			if self._poolInfos[iter_17_0] then
				self._poolInfos[iter_17_0].knight:updateTempFormationPos(0)

				self._poolInfos[iter_17_0] = nil

				if iter_17_0 == 1 then
					g.core.model.User.fogNightmareData:getAssistantData():setAssistantEmpty()
				end
			end
		end

		self:changeOneKeyBtnState()
		self.m_poolList:setNumItems(self._listAllNum)

		return
	end

	for iter_17_1, iter_17_2 in ipairs((var_0_0:getFormationData():autoPoolMember(self._listAllNum - 1, self._poolInfos))) do
		for iter_17_3 = 2, self._listAllNum do
			if not self._poolInfos[iter_17_3] then
				local var_17_0 = {}

				self._poolInfos[iter_17_3] = var_17_0
				var_17_0.knight = iter_17_2

				iter_17_2:updateTempFormationPos(iter_17_3)

				break
			end
		end
	end

	if self._jumpFloor > 1 then
		local var_17_1 = math.min(g.core.model.User.fogNightmareData:getTowerData():getFloorStruct(self._jumpFloor):getKeepsakeLevel(true), var_0_0:getFogSealLevel())

		for iter_17_4, iter_17_5 in pairs(self._poolInfos) do
			if iter_17_4 ~= 1 and iter_17_5.knight then
				iter_17_5.keepsake = self:getMaxPowerKeepsake((var_0_0:getKeepsakeData():getNormalKeepsakeStructsByKnightIdAndLv(iter_17_5.knight:getAdvanceId(), var_17_1, iter_17_5.knight:getProfession())))
			end
		end
	end

	self:changeOneKeyBtnState()
	self.m_poolList:setNumItems(self._listAllNum)
	g.core.sound.SoundManager:playSound(var_0_2.Sound.FOG_NIGHTMARE_AUTO_SET)
end

function FogNightmareExploreKnightPoolPop:changeOneKeyBtnState()
	if self:checkOneKeySelect() then
		self.m_autoBtn:setTitle(g.core.lang:get(500173))
		self.m_autoBtn:setCtrlState("state", {
			index = 1
		})
	else
		self.m_autoBtn:setTitle(g.core.lang:get(500174))
		self.m_autoBtn:setCtrlState("state", {
			index = 0
		})
	end

	self:updateTitleUI()
end

function FogNightmareExploreKnightPoolPop:checkOneKeySelect()
	local var_19_0 = self._jumpFloor > 1
	local var_19_1 = #self._restKnights
	local var_19_2 = table.nums(self._poolInfos)

	if self._poolInfos[1] then
		var_19_2 = var_19_2 - 1

		for iter_19_0, iter_19_1 in ipairs(self._restKnights) do
			if self._poolInfos[1].knight:getAdvanceId() == iter_19_1:getAdvanceId() then
				var_19_2 = var_19_2 + 1

				break
			end
		end
	end

	if var_19_2 < (var_19_1 < self._listAllNum - 1 and var_19_1 or self._listAllNum - 1) then
		return false
	end

	if var_19_0 then
		for iter_19_2 = 2, self._listAllNum do
			if self._poolInfos[iter_19_2] and not self._poolInfos[iter_19_2].keepsake then
				return false
			end
		end
	end

	return true
end

function FogNightmareExploreKnightPoolPop:getMaxPowerKeepsake(arg_20_1)
	local var_20_0

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		if not var_20_0 then
			var_20_0 = iter_20_1
		elseif iter_20_1:getPower() > var_20_0:getPower() then
			var_20_0 = iter_20_1
		end
	end

	return var_20_0
end

function FogNightmareExploreKnightPoolPop:_showLineUpPop(arg_21_1)
	arg_21_1.type = "KNIGHT"
	arg_21_1.hideFilter = self._isHideFilter

	g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareExploreLineUpPop").new(arg_21_1), {
		blackOpacity = 0.7,
		ignoreTouch = false,
		touchDisappear = false
	})
end

function FogNightmareExploreKnightPoolPop:_showFriendAssitantPop(arg_22_1)
	arg_22_1 = arg_22_1 or {}
	arg_22_1.lineUpInfo = self._poolInfos

	local var_22_0 = require("app.view.module.fogNightmare.view.assistant.FogNightAssistantFriendPop").new(arg_22_1)

	self:addListen(var_22_0)
	g.core.module.ModuleManager:pushPopup(var_22_0, {
		blackOpacity = 0.7,
		ignoreTouch = false,
		touchDisappear = false
	})
end

function FogNightmareExploreKnightPoolPop:checkKnihtCanSelected(arg_23_1)
	if self._poolInfos[1] and self._poolInfos[1].knight:getAdvanceId() == arg_23_1:getAdvanceId() then
		g.core.module.ModuleManager:tip(g.core.lang:get(500169))

		return false
	end

	local var_23_0 = true

	for iter_23_0, iter_23_1 in pairs(self._poolInfos) do
		if iter_23_1.knight and iter_23_1.knight:getAdvanceId() == arg_23_1:getAdvanceId() then
			if not self._noLineUp then
				g.core.module.ModuleManager:tip(g.core.lang:get(500169))
			end

			var_23_0 = false

			break
		end
	end

	return var_23_0
end

function FogNightmareExploreKnightPoolPop:checkSameKnightSelected(arg_24_1)
	if self._targetPos == 1 or not self._noLineUp then
		return false
	end

	if self._poolInfos then
		local var_24_0 = false

		for iter_24_0, iter_24_1 in pairs(self._poolInfos) do
			if iter_24_1.knight and iter_24_1.knight:getAdvanceId() == arg_24_1:getAdvanceId() then
				var_24_0 = true

				break
			end
		end

		return var_24_0
	else
		return false
	end
end

function FogNightmareExploreKnightPoolPop:checkKeepsakeCanSelected(arg_25_1)
	local var_25_0 = g.core.model.User.fogNightmareData:getTempSelectSakeId()

	if var_25_0 > 0 and arg_25_1:getCfg().id == var_25_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(500201))

		return false
	end

	return true
end

function FogNightmareExploreKnightPoolPop:_updatePopGroupKnights(arg_26_1)
	self._groupKnights = {
		arg_26_1 or self._restKnights,
		{},
		{},
		{},
		{}
	}

	for iter_26_0, iter_26_1 in ipairs(arg_26_1 or self._restKnights) do
		local var_26_0 = iter_26_1:getGroup()

		if var_26_0 ~= 0 then
			self._groupKnights[var_26_0 + 1][#self._groupKnights[var_26_0 + 1] + 1] = iter_26_1
		end
	end
end

function FogNightmareExploreKnightPoolPop:updatePopGroupKnightsExceptPos()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(self._restKnights) do
		local var_27_1 = iter_27_1:getTempFormationPos()

		if var_27_1 <= 0 or var_27_1 == self._targetPos then
			table.insert(var_27_0, iter_27_1)
		end
	end

	self:_updatePopGroupKnights(var_27_0)
end

function FogNightmareExploreKnightPoolPop:_onLineUpSucc()
	if not self._noLineUp then
		return
	end

	g.core.module.ModuleManager:popByDisplay(self)
	g.core.module.ModuleManager:pushModule(g.view.entrance.FOG_NIGHTMARE_EXPLORE)
end

function FogNightmareExploreKnightPoolPop:_onFastSucc()
	if not self._noLineUp then
		return
	end

	g.core.module.ModuleManager:popByDisplay(self)
	g.core.module.ModuleManager:pushModule(g.view.entrance.FOG_NIGHTMARE_EXPLORE, true)
end

function FogNightmareExploreKnightPoolPop:checkLocalSavePoolInfo()
	local var_30_0 = g.core.model.User.fogNightmareData:getSavedKnightPoolInfo()

	if #var_30_0 == 0 or not self._noLineUp then
		return
	end

	local var_30_1 = {}

	for iter_30_0, iter_30_1 in ipairs(var_30_0) do
		for iter_30_2, iter_30_3 in ipairs(self._restKnights) do
			if iter_30_3:getAdvanceId() == iter_30_1.knightAdvId then
				local var_30_2 = {
					knight = iter_30_3
				}

				if self._jumpFloor > 1 and iter_30_1.keepsakeSealId > 0 then
					for iter_30_4, iter_30_5 in ipairs((var_0_0:getKeepsakeData():getNormalKeepsakeStructsByKnightIdAndLv(iter_30_3:getAdvanceId(), math.min(g.core.model.User.fogNightmareData:getTowerData():getFloorStruct(self._jumpFloor):getKeepsakeLevel(true), var_0_0:getFogSealLevel()), iter_30_3:getProfession()))) do
						if iter_30_5:getBaseInfo().seal_id == iter_30_1.keepsakeSealId then
							var_30_2.keepsake = iter_30_5

							break
						end
					end
				end

				var_30_1[iter_30_1.pos] = var_30_2
			end
		end
	end

	var_0_0:getFormationData():updateKnightTempPoss(var_30_1)

	self._lineUpMembers = {}
	self._poolInfos = var_30_1

	self.m_poolList:setNumItems(#self._poolInfos)
	self:changeOneKeyBtnState()
end

return FogNightmareExploreKnightPoolPop
