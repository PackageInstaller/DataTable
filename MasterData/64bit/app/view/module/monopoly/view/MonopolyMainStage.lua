local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.model.User.shopData
local var_0_4 = g.core.const.ConstMgr
local var_0_5 = g.core.model.User.bagData
local var_0_6 = g.core.model.User.cultivateDataMgr
local var_0_7 = g.core.model.User.monopolyDataMgr
local MonopolyConst = require("app.view.module.monopoly.const.MonopolyConst")
local var_0_9 = g.core.common.Path
local MonopolyMainStage = class("MonopolyMainStage", require("app.fairyGUI.monopoly.UI_MonopolyMainStage"), function()
	return fgui.GComponent:create({
		pkgName = "monopoly",
		isFullScreen = true,
		pkgPath = "ui/monopoly/monopoly",
		resName = "MonopolyMainStage"
	})
end)

function MonopolyMainStage:ctor(arg_2_1)
	self.m_diceBtn:addClickListener(handler(self, self._onRiceBtnClick))
	self.m_diceTenBtn:addClickListener(handler(self, self._onRiceTenBtnClick))
	self.m_diceFiftyBtn:addClickListener(handler(self, self._onRiceFiftyBtnClick))
	self.m_selDiceNumBtn:addClickListener(handler(self, self._onSelDiceNumBtnClick))
	self.m_giftBtn:addClickListener(handler(self, self._onGiftBtnClick))
	self.m_skipBtn:addClickListener(handler(self, self._onSkipAnimClick))
	self.m_clickIgnoreMask:addClickListener(handler(self, self._onIgnoreMaskClick))

	self._isCrossDay = false

	self.m_clickIgnoreMask:setVisible(false)

	self._monopolyData = var_0_7:getMonopolyData(self._activityId)
	self._activityId = self._monopolyData:getActivityId()
	self._showLvUpList = {}
	self._isSkip = false

	local var_2_0 = self._monopolyData:getActData():getActivityCfg()

	self.m_giftBtn:setTitle(g.core.config.cultivate_activity_display_info.get(var_2_0.id).gift_name)
	self.m_selDiceNumBtn:setNum(var_0_5:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.MONOPOLY_DICE))
	self.m_selDiceNumBtn:setVisible(var_0_5:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.MONOPOLY_DICE) > 0)
	self.m_topBar:setResInfoById(20001)
	self.m_giftBtn:setBtnIcon(var_0_9:getCultivateImage("pic_mnzj_libao", var_0_6:getResDirId(var_2_0.id)))
	self.m_titleBg:setURL(var_0_9:getCultivateImage("pic_mnzj_dfw_wf_title_di", var_0_6:getResDirId(var_2_0.id)))
	self.m_titleTextIcon:setURL(var_0_9:getCultivateMulLangImage("txt_mnzj_dfw_wf", var_0_6:getResDirId(var_2_0.id)))
	self.m_giftBtn:setSelfRedPointId(768, self._activityId)
	self.m_isShowFiftyController:setSelectedIndex(self._monopolyData:isShowFiftyBtn() and 1 or 0)
	self.m_enterTransition:play()
end

function MonopolyMainStage:onLoad()
	self._inShowLvUp = false

	self.m_tipsComp:removeAllEffect()
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_MONOPOLY_GETINFO, self.onMonopolyGetInfo, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_MONOPOLY_ROLLDICE, self.onMonopolyRollDice, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_MONOPOLY_USEFIXEDDICE, self.onMonopolySelDice, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_MONOPOLY_NODEAWARD, self.onRewardNode, self)
	var_0_1:addEventListener(var_0_2.EVENT_GAME_RESUME_FINISH, self.onGameResumeFinish, self)
	var_0_1:addEventListener(var_0_2.EVENT_CROSS_DAY_NOTIFY, self.onCrossDayNotify, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_OP_OBJECT, self.updateOp, self)
	var_0_1:addEventListener(var_0_2.MONOPOLY_UPDATE_LEVEL, self.onGridLvUp, self)
	self:updateMainView()
	self.m_enterTransition:play()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_FantasyMonopoly)
	self:updateDiceBtnColor()
	self:updateNextPoint()
end

function MonopolyMainStage:onCrossDayNotify()
	if not self._monopolyData:getActData():isInActivityShowTime() then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	g.core.network.GameNetProxy:send_C2S_Monopoly_GetInfo({})

	self._isCrossDay = true
end

function MonopolyMainStage:_onIgnoreMaskClick()
	g.core.module.ModuleManager:tip(g.core.lang:get(426022))
end

function MonopolyMainStage:_onRiceFiftyBtnClick()
	if not self._initStartPos then
		self._initStartPos = true

		self.m_mapComp:initStartPos(self.m_diceShowHolder:localToGlobal(cc.p(0, 0)))
	end

	if self._monopolyData:isInDiceAnim() then
		g.core.module.ModuleManager:tip(g.core.lang:get(426001))

		return
	end

	if var_0_3:getLeftCount(var_0_4.ShopConst.PLAY_TYPE.MONOPOLY_ITEM_COUNT) + var_0_5:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.MONOPOLY_RUN_DICE) >= 50 then
		g.core.network.GameNetProxy:send_C2S_Monopoly_RollDice({
			roll_count = 50,
			activityId = self._activityId
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(426002))
	end
end

function MonopolyMainStage:updateNextPoint()
	if self._monopolyData:getNextDice() == 0 then
		self.m_nextPointTxt:setVisible(false)

		return
	end

	self.m_nextPointTxt:setVisible(true)
	self.m_nextPointTxt:setText(g.core.lang:get(431110, {
		num = self._monopolyData:getNextDice()
	}))
end

function MonopolyMainStage:_onRiceTenBtnClick()
	if not self._initStartPos then
		self._initStartPos = true

		self.m_mapComp:initStartPos(self.m_diceShowHolder:localToGlobal(cc.p(0, 0)))
	end

	if self._monopolyData:isInDiceAnim() then
		g.core.module.ModuleManager:tip(g.core.lang:get(426001))

		return
	end

	if var_0_3:getLeftCount(var_0_4.ShopConst.PLAY_TYPE.MONOPOLY_ITEM_COUNT) + var_0_5:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.MONOPOLY_RUN_DICE) >= 10 then
		g.core.network.GameNetProxy:send_C2S_Monopoly_RollDice({
			roll_count = 10,
			activityId = self._activityId
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(426002))
	end
end

function MonopolyMainStage:_onRiceBtnClick()
	if not self._initStartPos then
		self._initStartPos = true

		self.m_mapComp:initStartPos(self.m_diceShowHolder:localToGlobal(cc.p(0, 0)))
	end

	if self._monopolyData:isInDiceAnim() then
		g.core.module.ModuleManager:tip(g.core.lang:get(426001))

		return
	end

	if var_0_3:getLeftCount(var_0_4.ShopConst.PLAY_TYPE.MONOPOLY_ITEM_COUNT) + var_0_5:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.MONOPOLY_RUN_DICE) > 0 then
		g.core.network.GameNetProxy:send_C2S_Monopoly_RollDice({
			roll_count = 1,
			activityId = self._activityId
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(426002))
	end
end

function MonopolyMainStage:onGameResumeFinish()
	self:updateMainView()
end

function MonopolyMainStage:updateMainView()
	self.m_selDiceNumBtn:setNum(var_0_5:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.MONOPOLY_DICE))
	self.m_selDiceNumBtn:setVisible(var_0_5:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.MONOPOLY_DICE) > 0)
	self.m_mapComp:updateMapState()
	self:updateActivityTime()
	self.m_giftBtn:updateRedPoint()
end

function MonopolyMainStage:updateActivityTime()
	local var_12_0, var_12_1, var_12_2, var_12_3 = g.core.common.ServerTime:getLeftTimeParts((self._monopolyData:getActData():getEndTime()))

	self.m_timeTxt:setText(g.core.lang:get(421407, {
		day = var_12_0,
		hour = var_12_1
	}))
end

function MonopolyMainStage:_onSelDiceNumBtnClick()
	if g.core.model.User.bagData:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.MONOPOLY_DICE) > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.monopoly.view.MonopolySelNumPop").new(), {
			hideContinue = true,
			touchDisappear = true
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(426003))
	end
end

function MonopolyMainStage:_onGiftBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.shop.view.ShopCultivatePop.ShopCultivateGiftPop").new(self._activityId)))
end

function MonopolyMainStage:_onSkipAnimClick()
	self.m_skipBtn:setVisible(false)
	self.m_giftBtn:setVisible(true)

	self._isSkip = true

	self.m_mapComp:setAnimSkip()
end

function MonopolyMainStage:onMonopolyGetInfo(arg_16_1, arg_16_2, arg_16_3)
	self:updateMainView()

	if self._isCrossDay then
		self._isCrossDay = false
	end
end

function MonopolyMainStage:onMonopolyRollDice(arg_17_1, arg_17_2, arg_17_3)
	self._monopolyData:setInDiceAnim(true)
	self.m_clickIgnoreMask:setVisible(true)
	self:checkAndPlayDiceEff()

	self._monopolyDiceContent = arg_17_3

	self.m_mapComp:startRich(arg_17_3.results, handler(self, self.onRollDiceFinish))

	if #arg_17_3.results >= 10 then
		self.m_skipBtn:setVisible(self._monopolyData:isShowFiftyBtn())
		self.m_giftBtn:setVisible(false)
	end

	self._animedAnimNum = {}

	self._monopolyData:setNextDice(0)
	self:updateNextPoint()
	self:updateDiceBtnColor()
	self.m_hideTransition:play()
end

function MonopolyMainStage:updateOp()
	self:updateDiceBtnColor()
	self.m_selDiceNumBtn:setNum(var_0_5:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.MONOPOLY_DICE))
	self.m_selDiceNumBtn:setVisible(var_0_5:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.MONOPOLY_DICE) > 0)
end

function MonopolyMainStage:updateDiceBtnColor()
	local var_19_0 = var_0_3:getLeftCount(var_0_4.ShopConst.PLAY_TYPE.MONOPOLY_ITEM_COUNT) + g.core.model.User.bagData:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.MONOPOLY_RUN_DICE)

	self.m_diceBtn:setTitle(g.core.lang:get(var_19_0 >= 1 and 431108 or 431109, {
		num = 1
	}))
	self.m_diceTenBtn:setTitle(g.core.lang:get(var_19_0 >= 10 and 431108 or 431109, {
		num = 10
	}))
	self.m_diceFiftyBtn:setTitle(g.core.lang:get(var_19_0 >= 50 and 431108 or 431109, {
		num = 50
	}))
end

function MonopolyMainStage:onRollDiceFinish()
	if self._monopolyDiceContent then
		if self._monopolyDiceContent then
			local var_20_0 = {}

			for iter_20_0, iter_20_1 in ipairs(self._monopolyDiceContent.results) do
				for iter_20_2, iter_20_3 in ipairs(iter_20_1.events) do
					if iter_20_3.awards then
						table.insertto(var_20_0, iter_20_3.awards)
					end
				end
			end

			g.core.module.ModuleManager:awardSummary(var_20_0)
		end

		self.m_pointRewardComp:onUpdateRewardComp()
	end

	self.m_clickIgnoreMask:setVisible(false)
	self:updateMainView()
end

function MonopolyMainStage:receiveCompEvent(arg_21_1, arg_21_2)
	if arg_21_1 == "MONOPOLY_RUN_DICE" then
		self.m_progressComp:updateProgress(arg_21_2)
	elseif arg_21_1 == "MONOPOLY_RUN_DICE_FINISH" then
		self.m_progressComp:playHideAnim(handler(self, self.onHideProgressComp))
		self.m_isShowFiftyController:setSelectedIndex(self._monopolyData:isShowFiftyBtn() and 1 or 0)
		self.m_skipBtn:setVisible(false)
		self.m_giftBtn:setVisible(true)
		self.m_enterTransition:play()
	end
end

function MonopolyMainStage:onHideProgressComp()
	self.m_progressComp:setVisible(false)
end

function MonopolyMainStage:onRewardNode(arg_23_1, arg_23_2, arg_23_3)
	self.m_pointRewardComp:onUpdateRewardComp()
	g.core.module.ModuleManager:awardSummary(arg_23_3.awards or {})
end

function MonopolyMainStage:onMonopolySelDice(arg_24_1, arg_24_2, arg_24_3)
	self.m_selDiceNumBtn:setNum(var_0_5:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.MONOPOLY_DICE))
	self.m_selDiceNumBtn:setVisible(var_0_5:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.MONOPOLY_DICE) > 0)
	self:updateNextPoint()
end

function MonopolyMainStage:checkAndPlayDiceEff()
	local var_25_0 = var_0_3:getLeftCount(var_0_4.ShopConst.PLAY_TYPE.MONOPOLY_ITEM_COUNT) + g.core.model.User.bagData:getOwnNum(var_0_0.TYPE_ITEM, var_0_0.ITEM.MONOPOLY_RUN_DICE)
end

function MonopolyMainStage:_onEventItemRenderer(arg_26_1, arg_26_2)
	arg_26_2:updateEventShow(self._eventList[arg_26_1 + 1])
end

function MonopolyMainStage:onUnload()
	self._monopolyData:setInDiceAnim(false)
end

function MonopolyMainStage:onGridLvUp(arg_28_1, arg_28_2)
	if arg_28_2.gridCfg.type == MonopolyConst.EVENT_TYPE.BEHIND_GRIDS or arg_28_2.gridCfg.type == MonopolyConst.EVENT_TYPE.FRONT_GRIDS then
		return
	end

	local var_28_0 = self._monopolyData:getGridLvCfg(arg_28_2.gridCfg.type, arg_28_2.oldLv)
	local var_28_1 = fgui.UIPackage:createObject("monopoly", "MonopolyGridLvUpComp")

	var_28_1:updateLevelShow({
		good = g.core.common.Goods:convert({
			type = var_28_0.reward_type_1,
			value = var_28_0.reward_value_1
		}),
		oldSize = var_28_0.reward_size_1,
		newSize = self._monopolyData:getGridLvCfg(arg_28_2.gridCfg.type, arg_28_2.newLv).reward_size_1
	})
	self.m_tipsComp:addChild(var_28_1)
end

return MonopolyMainStage
