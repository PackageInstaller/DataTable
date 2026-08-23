local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local var_0_1 = g.core.common.ModuleUnlock
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local FavoComp = class("FavoComp", require("app.fairyGUI.knightFavorability.UI_FavoComp"), function()
	return fgui.GComponent:create({
		resName = "FavoComp",
		pkgPath = "ui/knightFavorability/knightFavorability",
		isFullScreen = true,
		pkgName = "knightFavorability"
	}, ...)
end)

function FavoComp:ctor()
	self._knightInfo = nil
	self._favoLevel = 0
	self._isInAdvance = 0
	self._addExpNum = 0
	self._items = nil
	self._selectData = {
		index = -1,
		num = 0
	}
	self._selectDataList = {}
	self._selectItem = nil
	self._canLevelUp = true
	self._isMaxLevel = false
	self._selectCell = nil
	self._isShowMaxTip = false
	self._isFavoItem = false
	self.m_addExpTxt = self.m_expComp:getChild("addExpTxt")
	self.m_curExpTxt = self.m_expComp:getChild("curExpTxt")
	self.m_maxExpTxt = self.m_expComp:getChild("maxExpTxt")

	self:_initView()
end

function FavoComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OP_OBJECT, handler(self, self._onReceiveOpObject), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_FAVORABILITYUPGRADE, handler(self, self._onFavoUpdate), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_FAVORABILITYONEKEYUPGRADE, handler(self, self._onFavoUpdate), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_FAVORABILITYBREAK, handler(self, self._onFavoBreak), self)
end

function FavoComp:receiveCompEvent(arg_4_1, arg_4_2)
	arg_4_2 = arg_4_2 or {}

	if arg_4_1 == "FavoMaterialItem_sub" and arg_4_2.index then
		self:_changeSelectedItemNum(arg_4_2.index, -1)
	elseif arg_4_1 == "FavoMaterialItem_add" and arg_4_2.index then
		self:_changeSelectedItemNum(arg_4_2.index, 1)
	end
end

function FavoComp:updateView(arg_5_1)
	self._knightInfo = arg_5_1 and arg_5_1 or self._knightInfo
	self._favoLevel = self._knightInfo:getBaseKnightInfo():getFavoLevel()
	self._items = self._knightInfo:getFavoItemList()
	self._selectData = {
		index = -1,
		num = 0
	}
	self._selectDataList = {}
	self._selectItem = nil
	self._addExpNum = 0
	self._knightLevel = 0
	self._levelLimit = 0
	self._curLimit = 0

	self:_updateProgress()
	self:_updateAttrs()
	self:_updateFavoItems()
	self:_updateButton()
end

function FavoComp:_onReceiveOpObject(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self._items = self._knightInfo:getPreFavoItemList()

	self.m_materialList:setNumItems(#self._items)
end

function FavoComp:_initView()
	self.m_materialList:setVirtual()
	self.m_materialList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_donateBtn:addClickListener(handler(self, self._onClickDonateBtn))
	self.m_donateBtn2:addClickListener(handler(self, self._onClickDonateBtn))
	self.m_quickGiveBtn:addClickListener(handler(self, self._onClickQuickGiveBtn))
	self:addListen(self.m_materialList)
	self.m_upgradeTransition:setHook("updateView", handler(self, function()
		self:_updateProgress()
		self:_updateFavoItems(true)
		self:_updateButton()
	end))
end

function FavoComp:_updateButton()
	local var_9_0 = self._knightInfo:getProgressData()
	local var_9_1 = self._knightInfo:getBaseKnightInfo():getLevel()

	var_9_1 = var_9_1 or 0
	self._knightLevel = var_9_1

	local var_9_2 = self._knightInfo:getBaseKnightInfo():getFavoStage()

	var_9_2 = var_9_2 or 1
	self._knightFavoStage = var_9_2
	self._levelLimit = var_9_0.knightLevelLimit or 0

	self.m_isMaxController:setSelectedIndex(0)

	if var_9_0.maxFavoLevel then
		self.m_tipText:setText(g.core.lang:get(112208))
		self.m_donateLimitController:setSelectedIndex(1)
		self.m_isMaxController:setSelectedIndex(1)

		return nil
	end

	if self._knightLevel >= self._levelLimit or self._knightInfo:isInAdvance() then
		self.m_donateLimitController:setSelectedIndex(0)
	else
		self.m_tipText:setText(g.core.lang:get(112207, {
			level = self._levelLimit
		}))
		self.m_donateLimitController:setSelectedIndex(1)
	end

	self.m_isQuickGiveController:setSelectedIndex(var_0_1:isModuleUnlock(var_0_2.FAVO_QUICK_GIVEAWAY) and 1 or 0)
end

function FavoComp:_onFavoUpdate()
	if tolua.isnull(self) then
		return
	end

	self:updateView()

	local var_10_0 = self._knightInfo:getBaseKnightInfo():getFavoLevel()

	if var_10_0 > self._favoLevel then
		self.m_effectHolder:addEffectSpine({
			name = "eff_ui_favo_upgrade",
			scale = 1,
			isLoop = false
		})
		self.m_upgradeTransition:play()

		self._favoLevel = var_10_0
	else
		self:_updateProgress()
		self:_updateFavoItems(true)
		self:_updateButton()
	end

	local var_10_1 = self._knightInfo:getBaseKnightInfo():getVoiceResInfo()
	local var_10_2 = var_10_1.gift1_sound
	local var_10_3 = var_10_1.gift1_lines

	if self._isFavoItem then
		var_10_2 = var_10_1.gift2_sound
		var_10_3 = var_10_1.gift2_lines
	end

	KnightVoiceCommon.playVoice({
		voiceName = var_10_2,
		func = handler(self, self._onSoundEnd)
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_FAVO_PLAY_LINES, false, {
		tip = var_10_3
	})
end

function FavoComp:_onFavoBreak()
	self:_updateFavoItems()

	local var_11_0 = self._knightInfo:getBaseKnightInfo():getFavoLevel()

	if var_11_0 > self._favoLevel then
		self.m_effectHolder:addEffectSpine({
			name = "eff_ui_favo_upgrade",
			scale = 1,
			isLoop = false
		})
		self.m_upgradeTransition:play()

		self._favoLevel = var_11_0
	else
		self:_updateButton()
	end
end

function FavoComp:_updateProgress()
	local var_12_0 = self._knightInfo:getUpLevelDataByExp(self._addExpNum)

	self._curLimit = var_12_0.limitLevel
	self._canLevelUp = var_12_0.canLevelUp
	self._isMaxLevel = var_12_0.isMaxLevel
	self._isInAdvance = var_12_0.isInAdvance

	self.m_levelTxt:setText(var_12_0.level)
	self.m_progBar1:setPercent({
		cur = var_12_0.curExp,
		max = var_12_0.maxExp
	})
	self.m_progBar2:setPercent({
		cur = var_12_0.curExp,
		max = var_12_0.maxExp
	})
	self.m_curExpTxt:setText(var_12_0.curExp)
	self.m_maxExpTxt:setText("/" .. var_12_0.maxExp)

	if self._addExpNum > 0 then
		if var_12_0.level >= self._favoLevel then
			self:_updateAttrs(var_12_0.level)
		end

		self.m_addExpTxt:setText("+" .. self._addExpNum)
	else
		self.m_addExpTxt:setText("")
		self:_updateAttrs()
	end
end

function FavoComp:_updateAttrs(arg_13_1)
	local var_13_0 = self._knightInfo:getLevelInfo(arg_13_1)

	self.m_levelNameTxt:setText(g.core.lang:get(112215, {
		name = var_13_0.relationship
	}))
	self.m_rareLoader:setURL("ui://knightFavorability/pic_hgd_light" .. var_13_0.rare)

	if arg_13_1 then
		local var_13_1 = self._knightInfo:getFavoSortAttrsBuyLevel(arg_13_1) or self._knightInfo:getFavoSortAttrs()

		if var_13_1 then
			for iter_13_0 = 1, #var_13_1 do
				var_13_1[iter_13_0].withoutPlus1 = false

				self["m_attrComp" .. iter_13_0]:updateAttr(var_13_1[iter_13_0])
			end
		end
	end
end

function FavoComp:_updateFavoItems(arg_14_1)
	self.m_isItemEnoughController:setSelectedIndex(1)

	if self._knightInfo:isInAdvance() then
		self.m_stateController:setSelectedIndex(1)

		local var_14_0 = self._knightInfo:getLevelInfo()

		if var_14_0.cost_type ~= 0 then
			local var_14_1 = g.core.model.User.bagData:getCountById(var_14_0.cost_type, var_14_0.cost_value)

			self.m_advanceItem:updateIcon({
				type = var_14_0.cost_type,
				value = var_14_0.cost_value,
				size = var_14_1,
				numCost = var_14_0.cost_num
			})

			if var_14_1 < var_14_0.cost_num then
				self.m_isItemEnoughController:setSelectedIndex(0)
			end
		end
	elseif not arg_14_1 then
		self.m_stateController:setSelectedIndex(0)
		self.m_materialList:setNumItems(#self._items)
		self.m_materialList:transitionShowCells("listIconUiScaleIn", 0.03, 1)
	end
end

function FavoComp:_onItemRenderer(arg_15_1, arg_15_2)
	arg_15_2:updateView({
		data = self._items[arg_15_1 + 1],
		index = arg_15_1,
		selectDataList = self._selectDataList,
		knightLevel = self._knightLevel,
		levelLimit = self._levelLimit
	})
end

function FavoComp:_changeSelectedItemNum(arg_16_1, arg_16_2, arg_16_3)
	if self._items[arg_16_1 + 1] and self._items[arg_16_1 + 1].size <= 0 then
		return
	end

	local var_16_0 = false
	local var_16_1

	if self._selectDataList[arg_16_1] then
		var_16_1 = self._selectDataList[arg_16_1].num or 0

		if arg_16_1 < 0 then
			var_16_0 = true
			self._selectDataList = {}
			self._selectData.num = 0
			self._curLimit = 0
			self._addExpNum = 0
			self._isShowMaxTip = false
		elseif self._selectData.index == arg_16_1 then
			self._selectData.num = self._selectData.num + arg_16_2
		end
	end

	self._isShowMaxTip = false
	self._selectDataList[arg_16_1] = self._selectDataList[arg_16_1] or {
		num = 0,
		index = arg_16_1
	}
	self._selectData = self._selectDataList[arg_16_1]
	self._selectData.num = self._selectData.num + arg_16_2

	if self._levelLimit > self._curLimit then
		local var_16_2 = self._levelLimit or self._curLimit

		if self._isInAdvance and arg_16_2 > 0 then
			self._selectData.num = self._selectData.num - arg_16_2

			if not self._isShowMaxTip then
				g.core.module.ModuleManager:tip((g.core.lang:get(112216)))

				self._isShowMaxTip = true
			end
		elseif var_16_2 > self._knightLevel and arg_16_2 > 0 then
			self._selectData.num = self._selectData.num - arg_16_2

			if not self._isShowMaxTip then
				g.core.module.ModuleManager:tip((g.core.lang:get(112207, {
					level = var_16_2
				})))

				self._isShowMaxTip = true
			end
		elseif self._isMaxLevel and arg_16_2 > 0 then
			self._selectData.num = self._selectData.num - arg_16_2

			if not self._isShowMaxTip then
				g.core.module.ModuleManager:tip((g.core.lang:get(112208)))

				self._isShowMaxTip = true
			end
		elseif self._selectData.num <= 0 and arg_16_2 < 0 then
			self._selectData.num = 0
		end

		if var_16_2 <= self._knightLevel and not self._isMaxLevel or arg_16_2 < 0 or self._selectData.num == 1 then
			self._isShowMaxTip = false

			if self._selectData.index < 0 then
				return nil
			end

			self._selectItem = self._items[self._selectData.index + 1]

			if self._selectData.num > self._selectItem.size then
				self._selectData.num = self._selectItem.size or self._selectData.num
			end

			local var_16_3 = 0

			if self._selectItem.weight >= 2 then
				self._isFavoItem = true
				var_16_3 = self._selectItem.expAdd
			else
				self._isFavoItem = false
				var_16_3 = self._selectItem.exp
			end

			self._addExpNum = self._addExpNum + var_16_3 * (self._selectData.num - var_16_1)

			if self._addExpNum > 0 then
				self._addExpNum = self._addExpNum or 0
			end

			if not arg_16_3 then
				self:_updateProgress()
			end

			if self._selectData.num <= 0 then
				self._selectDataList[self._selectData.index] = nil
				self._selectData = {
					index = -1,
					num = 0
				}
				self._selectItem = nil
				var_16_0 = true
			end

			if true then
				self.m_materialList:setNumItems(#self._items)

				if self._selectData.index >= 0 then
					self._selectCell = self.m_materialList:getChildAt((self.m_materialList:itemIndexToChildIndex(arg_16_1)))

					g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.KEEP_CHOOSE_GIFT)
				else
					self._selectCell = nil
				end
			elseif self._selectCell then
				self._selectCell:changeNum(self._selectData.num)

				if arg_16_2 > 0 then
					g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.KEEP_CHOOSE_GIFT)
				end
			end
		end
	end
end

function FavoComp:_onClickDonateBtn()
	if self._knightInfo:isInAdvance() then
		local var_17_0 = self._knightInfo:getLevelInfo()

		if g.core.model.User.bagData:getCountById(var_17_0.cost_type, var_17_0.cost_value) >= var_17_0.cost_num then
			local var_17_1 = {}

			var_17_1.id = self._knightInfo:getBaseKnightInfo():getServerId()

			g.core.network.GameNetProxy:send_C2S_Knight_FavorabilityBreak(var_17_1)
			self:_changeSelectedItemNum(-1, 0, true)

			self._isInAdvance = false
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(112217))
		end
	else
		local var_17_2 = {}

		for iter_17_0, iter_17_1 in pairs(self._selectDataList) do
			if iter_17_1.num > 0 then
				table.insert(var_17_2, {
					item_id = self._items[iter_17_1.index + 1].value,
					item_num = iter_17_1.num
				})
			end
		end

		if table.nums(var_17_2) <= 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(112209))

			return
		end

		local var_17_3 = {}

		var_17_3.id = self._knightInfo:getBaseKnightInfo():getServerId()
		var_17_3.use_items = var_17_2

		g.core.network.GameNetProxy:send_C2S_Knight_FavorabilityUpgrade(var_17_3)
		self:_changeSelectedItemNum(-1, 0, true)
	end
end

function FavoComp:_onClickQuickGiveBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.knightFavorability.view.FavoQuickGiveAwayPop").new({
		knightInfo = self._knightInfo
	}), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

function FavoComp:_onSoundEnd()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_FAVO_PLAY_LINES_END)
end

return FavoComp
