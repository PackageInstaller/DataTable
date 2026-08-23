local FogNightmareKeepsakeSelectPop = class("FogNightmareKeepsakeSelectPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareKeepsakeSelectPop"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareKeepsakeSelectPop",
		pkgPath = "ui/fogNightmare/fogNightmare",
		isFullScreen = true,
		pkgName = "fogNightmare"
	}, ...)
end)
local var_0_1 = g.core.model.User.fogNightmareData
local GuideConst = require("app.view.module.guide.const.GuideConst")

function FogNightmareKeepsakeSelectPop:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._params = arg_2_1
	self._selectDataFunc = arg_2_1.selectDataFunc
	self._keepsakeSelectIdx = 0
	self._chooseActionCount = 0

	self:addBg("bg/fogNightmare/bg_wjmy_xw_xz_role.png", false, nil, 1)

	self._confirmFunc = arg_2_1.confirm
	self._skipFunc = arg_2_1.skip
	self._resetFunc = arg_2_1.reset

	self.m_tipTxt:enableRich()
	self.m_tipTxt:setText(g.core.lang:get(500274), true)

	if arg_2_1.isExtra then
		self.m_returnBtn:addClickListener(handler(self, self._onClickReturnBtn))
		self.m_topBarComp:setResInfoById(152)

		local var_2_0

		if arg_2_1.extraTipFunc then
			var_2_0 = arg_2_1.extraTipFunc()
		else
			local var_2_1 = {}

			var_2_1.cur = var_0_1:getTowerData():getPassedExtraNum()
			var_2_1.max = var_0_1:getTowerData():getTotalExtraNum()
			var_2_0 = g.core.lang:get(500236, var_2_1)
		end

		self.m_suitTipText:setText(var_2_0)
		self.m_isExtraController:setSelectedIndex(1)
	end

	self._bgLoader = nil

	self.m_keepsakeList:setVirtual(self)
	self.m_keepsakeList:setItemRenderer(handler(self, self._onInfoListItemRender))
	self.m_keepsakeList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onKeepsakeSelect))
	self.m_keepsakeList:doFairyBatching(false)
	self.m_randSealBtn:addEventListener(fgui.UIEventType.Click, handler(self, self._onRandSeal))
	self.m_skipBtn:addEventListener(fgui.UIEventType.Click, handler(self, self._onSkip))
	self.m_tipsBtn:addEventListener(fgui.UIEventType.Click, handler(self, self._onShowTips))
	self.m_stopBtn:addClickListener(handler(self, self._onClickStopBtn))
	self:addClickListener(handler(self, self._onClickMyself))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
		tickType = 6,
		enum = GuideConst.ENUM_TICK.FOG_FIRST_ENTER_SELECT_KEEP
	})
	self.m_enterTransition:play(handler(self, self._onCheckGuideTick))

	if arg_2_1.isSweep then
		self.m_isSweepController:setSelectedIndex(1)
	end
end

function FogNightmareKeepsakeSelectPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_RANDSEALS, handler(self, self._initView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_CHOOSESEAL, handler(self, self._onFinishSelectAction), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_GIVEUPSEAL, handler(self, self._onFinishSelectAction), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_RESETSEALS, handler(self, self._resetKeepsakeInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_RESETEXTRASEALS, handler(self, self._resetKeepsakeInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_CHOOSEEXTRASEAL, handler(self, self._onFinishSelectAction), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_GIVEUPEXTRASEAL, handler(self, self._onFinishSelectAction), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_ONEKEYCHOOSESEAL, handler(self, self._onFinishSelectAction), self)
	self:_initView()

	if g.core.model.User.fogNightmareData:getAutoPlay():isAutoPlay() then
		self:_onShowAutoSelectBtn()
	end

	if self.m_isSweepController:getSelectedIndex() == 1 then
		self:_checkSweepMaskIsHide()
	end
end

function FogNightmareKeepsakeSelectPop:_onCheckGuideTick()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function FogNightmareKeepsakeSelectPop:onUnload()
	if var_0_1:getAwardsPopIsShowOver() then
		var_0_1:onForbidAwardPop()
		g.core.common.Scheduler:newScheduleOnce(function()
			var_0_1:onEnableAwardPop()
		end, 1)
	end

	if self._isNormal then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHECK_FLOOR_STATE, false)
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_FORBID_CHECK_FLOOR, false)
	end

	if g.core.model.User.fogNightmareData:getAutoPlay():isAutoPlay() then
		self:_onHideAutoSelectBtn()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHECK_KEEPSAKE_NET, false)
	end
end

function FogNightmareKeepsakeSelectPop:_initView()
	self._keepsakeList = {}
	self._selectData = self._selectDataFunc and self._selectDataFunc() or var_0_1:getTalentData():getRandSealData()

	for iter_7_0, iter_7_1 in ipairs(self._selectData) do
		local var_7_0 = var_0_1:getKeepsakeData()

		table.insert(self._keepsakeList, {
			struct = var_7_0:getKeepsakeStructById(iter_7_1.seal_level_id),
			knightSid = iter_7_1.knight_id
		})
	end

	self.m_keepsakeList:setNumItems(#self._keepsakeList)

	self._useCount = var_0_1:getSealResetTimes()
	self._leftCount = var_0_1:getTalentData():getExtraRandTimes() + g.core.config.parameter_info.get(20051).parameter - self._useCount

	self.m_txt_num:setText(self._leftCount)
	self.m_txtInfo:setText(g.core.lang:get(500162, {
		num = var_0_1:getFogSealLevel()
	}))
	self.m_tipBubbleTxt:setText((g.core.lang:get(500210, {
		num = var_0_1:getFogLevel(),
		num2 = var_0_1:getFogSealLevel()
	})))
	self.m_suitListComp:updateComp()
	self.m_suitListComp:showAllSuitListComp()
end

function FogNightmareKeepsakeSelectPop:_onInfoListItemRender(arg_8_1, arg_8_2)
	arg_8_2:updateViewByStruct(self._keepsakeList[arg_8_1 + 1].struct)
	arg_8_2:updateKnightBySid(self._keepsakeList[arg_8_1 + 1].knightSid)
end

function FogNightmareKeepsakeSelectPop:_onRandSeal()
	if self._leftCount > 0 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, {
			title = g.core.lang:get(500190),
			desc = g.core.lang:get(500189, {
				num = self._leftCount
			}),
			onConfirm = handler(self, function()
				if self._resetFunc then
					self._resetFunc(self._selectData)
				else
					g.core.network.GameNetProxy:send_C2S_Fog_ResetSeals({})
				end

				var_0_1:setSealResetTimes(self._useCount + 1)
			end)
		})
	else
		g.core.module.ModuleManager:tip((g.core.lang:get(500199)))
	end
end

function FogNightmareKeepsakeSelectPop:_onSkip()
	if var_0_1:getNotPopParam("notPopKeepsakeSkip") then
		self:_onConfirmSkip()
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, {
			title = g.core.lang:get(1257),
			desc = g.core.lang:get(500163),
			onConfirm = handler(self, self._onConfirmSkip),
			onCheck = function(arg_12_0)
				var_0_1:setNotPopParam("notPopKeepsakeSkip", arg_12_0)
			end,
			tip = {
				txt = g.core.lang:get(500195)
			}
		})
	end
end

function FogNightmareKeepsakeSelectPop:_onConfirmSkip()
	if self._skipFunc then
		self._skipFunc(self._selectData)
	else
		g.core.network.GameNetProxy:send_C2S_Fog_GiveUpSeal({})
	end
end

function FogNightmareKeepsakeSelectPop:onCancelCallback()
	return
end

function FogNightmareKeepsakeSelectPop:_chooseKeepsake()
	if self._confirmFunc then
		self._confirmFunc({
			knight_id = self._selectData[self._keepsakeSelectIdx + 1].knight_id,
			seal_level_id = self._selectData[self._keepsakeSelectIdx + 1].seal_level_id
		}, self._selectData)
	else
		g.core.network.GameNetProxy:send_C2S_Fog_ChooseSeal({
			knight_id = self._selectData[self._keepsakeSelectIdx + 1].knight_id,
			seal_level_id = self._selectData[self._keepsakeSelectIdx + 1].seal_level_id
		})
	end
end

function FogNightmareKeepsakeSelectPop:_onFinishSelectAction()
	self._isNormal = true

	if self._needAutoChose then
		g.core.module.ModuleManager:tip(g.core.lang:get(500273))
	end

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function FogNightmareKeepsakeSelectPop:_onKeepsakeSelect(arg_17_1)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_KEEPSAKE_SELECT)
	self:_doSelectCard((arg_17_1:getDataValue()))
end

function FogNightmareKeepsakeSelectPop:_doSelectCard(arg_18_1)
	local var_18_0 = self.m_keepsakeList:itemIndexToChildIndex(arg_18_1)

	if var_18_0 == self._keepsakeSelectIdx then
		-- block empty
	end

	self._keepsakeSelectIdx = var_18_0

	for iter_18_0, iter_18_1 in ipairs((self.m_keepsakeList:getChildren())) do
		iter_18_1:getController("isSelect"):setSelectedIndex(2)
	end

	local var_18_1 = self.m_keepsakeList:getChildAt(self._keepsakeSelectIdx)

	var_18_1:getController("isSelect"):setSelectedIndex(1)
	self:_updateSelectInfo(self._keepsakeSelectIdx + 1, self:localToGlobal((var_18_1:getPosition())), self._keepsakeList[var_18_0 + 1])
	self.m_suitListComp:playSuitEffectAnim(self._keepsakeList[arg_18_1 + 1].struct:getBaseInfo().suit_id, "play", true)
	self:_onHideAutoSelectBtn()
end

function FogNightmareKeepsakeSelectPop:_resetKeepsakeInfo()
	self.m_enterTransition:play()
	self:_initView()

	for iter_19_0, iter_19_1 in ipairs((self.m_keepsakeList:getChildren())) do
		iter_19_1:getController("isSelect"):setSelectedIndex(0)
	end

	self.m_showTipController:setSelectedIndex(0)

	if self._bgLoader then
		self._bgLoader:setVisible(false)
	end
end

function FogNightmareKeepsakeSelectPop:_updateSelectInfo(arg_20_1, arg_20_2, arg_20_3)
	if not self._bgLoader then
		self._bgLoader = self:addBg("bg/fogNightmare/pic_wjmy_xw_xz_wite.png", false, nil, 1)

		self:setChildIndex(self._bgLoader, 1)
	end

	self._bgLoader:setVisible(true)
	self.m_showTipController:setSelectedIndex(1)
	self.m_switchComp:updateView({
		knightId = self._selectData[arg_20_1].knight_id,
		sealId = self._selectData[arg_20_1].seal_level_id,
		worldPos = arg_20_2,
		struct = arg_20_3.struct
	})
end

function FogNightmareKeepsakeSelectPop:_onShowTips(arg_21_1)
	arg_21_1:stopPropagation()
	self.m_tipBubbleController:setSelectedIndex(1)
end

function FogNightmareKeepsakeSelectPop:_onClickMyself()
	if self.m_tipBubbleController:getSelectedIndex() == 1 then
		self.m_tipBubbleController:setSelectedIndex(0)
	end
end

function FogNightmareKeepsakeSelectPop:_onClickReturnBtn()
	g.core.module.ModuleManager:popAllPopup()
	g.core.module.ModuleManager:popModule()
end

function FogNightmareKeepsakeSelectPop:receiveCompEvent(arg_24_1, arg_24_2)
	if arg_24_1 == "selectKeepsake" then
		self.m_mask:setVisible(true)

		self._confirmParam = arg_24_2

		local var_24_0 = var_0_1:getFormationData():getKnightByServerId(self._keepsakeList[self._keepsakeSelectIdx + 1].knightSid):getDevelopStruct("keepsake")
		local var_24_1 = self._keepsakeList[self._keepsakeSelectIdx + 1].struct:getBaseInfo().suit_id

		if var_24_1 > 0 then
			local var_24_2 = var_0_1:getKeepsakeData():getSuitInfo(var_24_1)

			if var_24_2:getEffectInfoByIndex(var_24_2:getActiveNum() + 1).targetNum <= var_24_2:getActiveKeepsakeNum() + ((var_24_0 and var_24_0:getBaseInfo().suit_id == var_24_1 or nil) and 0) then
				g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_KEEPSAKE_SUIT_ACTIVE)
				self.m_suitListComp:playSuitEffectAnim(var_24_1, "play2", false)
				self.m_suitListComp:switchSuitByKeepsake(var_24_0, self._keepsakeList[self._keepsakeSelectIdx + 1].struct)
			else
				self:_playSelectCardAnim()
			end
		else
			self:_playSelectCardAnim()
		end
	elseif arg_24_1 == "suitActiveEnd" then
		self:_playSelectCardAnim()
	end
end

function FogNightmareKeepsakeSelectPop:_playSelectCardAnim()
	self:_chooseKeepsake()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_FORMATION_KEEPSAKE_SELECT, false, self._confirmParam)
end

function FogNightmareKeepsakeSelectPop:_checkSweepMaskIsHide()
	self._needAutoChose = true

	local var_26_0 = true
	local var_26_1 = {
		choseIdx = 0,
		disFightValue = 0
	}

	for iter_26_0, iter_26_1 in ipairs(self._selectData) do
		local var_26_2 = var_0_1:getKeepsakeData():getKeepsakeStructById(iter_26_1.seal_level_id)

		if var_26_2:getBaseInfo().type > 1 then
			var_26_0 = false
			self._needAutoChose = false

			break
		else
			local var_26_3 = var_0_1:getCurKeepsakePowerDelta(iter_26_1.knight_id, var_26_2:getCfg().id)

			if var_26_3 > var_26_1.disFightValue then
				var_26_1.choseIdx = iter_26_0
				var_26_1.disFightValue = var_26_3
			end
		end
	end

	if var_26_0 then
		if var_26_1.choseIdx > 0 then
			self:_doSelectCard(var_26_1.choseIdx - 1)
			self:newScheduleOnce(handler(self, function(arg_27_0)
				arg_27_0:_chooseKeepsake()
			end), 1)
		else
			self:newScheduleOnce(handler(self, function(arg_28_0)
				arg_28_0:_onConfirmSkip()
			end), 1)
		end

		self.m_sweepMask:setVisible(true)
	else
		self.m_sweepMask:setVisible(false)
	end
end

function FogNightmareKeepsakeSelectPop:_onShowAutoSelectBtn()
	self.m_autoSelectShowController:setSelectedIndex(1)
end

function FogNightmareKeepsakeSelectPop:_onHideAutoSelectBtn()
	self.m_autoSelectShowController:setSelectedIndex(0)
end

function FogNightmareKeepsakeSelectPop:_onClickStopBtn()
	g.core.model.User.fogNightmareData:getAutoPlay():stopAutoPlay("")
	self:_onHideAutoSelectBtn()
end

return FogNightmareKeepsakeSelectPop
