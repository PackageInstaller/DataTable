local var_0_1 = g.core.service.ServiceManager:getServiceByName("BioTeamInviteFloatService")
local RecruitPrimaryLayer = class("RecruitPrimaryLayer", require("app.fairyGUI.recruitKnight.UI_RecruitPrimaryLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/recruitKnight/recruitKnight",
		resName = "RecruitPrimaryLayer",
		pkgName = "recruitKnight",
		isFullScreen = true
	}, ...)
end)
local var_0_3 = g.core.event.EventManager
local RecruitFuncCfg = require("app.view.module.recruit.const.RecruitFuncCfg")
local GTree = require("app.core.utils.tree.GTree")
local var_0_7 = g.core.const.ConstMgr.SpineConst
local var_0_8 = g.core.const.ConstMgr.SoundConst

function RecruitPrimaryLayer:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._compTab = {}
	self._firstEnter = true
	self._autoBuyList = {}
	self.m_enterTransition = self:getView():getTransition("enter")
	self._animWaitCount = 0

	self:_init()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.2)
end

function RecruitPrimaryLayer:_init()
	self.m_topBarComp:setResInfoById(20)
	self.m_topBarComp:setHelpId(g.core.const.ConstMgr.HelpConst.HELP_TYPE.PRIMARY_RECRUIT)

	local var_4_0 = RecruitFuncCfg.getPrimaryList()

	self.m_primaryComp:init(var_4_0[1])
	self:addBg(var_4_0[1].subTree[1].bgUrl, true)
	g.core.resource.ResourceManager:addSpineCache(var_0_7.TYPE.RES_EFFECT, var_0_7.RECRUIT_RES_EFFECT_CACHE)
end

function RecruitPrimaryLayer:_refreshTreeUI()
	if #RecruitFuncCfg.getPrimaryList() < 1 then
		self.m_primaryComp:setVisible(false)
		g.core.module.ModuleManager:popComponent()
	else
		self:_updateDetailCompView()
	end
end

function RecruitPrimaryLayer:_getMovieList()
	local var_6_0 = {}
	local var_6_1 = g.core.model.User.recruitData:isNewPlayer()

	if (self._content.recruit_type == g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.Base and "daily" or "night") == "night" then
		if self._actionsParams.numStr == "Ten" then
			local var_6_2 = {
				sound = var_0_8.Sound.RECRUIT_RAINY
			}

			var_6_2.moduleName = "recruit"
			var_6_2.movieName = "nightRecruitEnter_1334x870_2300"
			var_6_2.id = "enter"
			var_6_2.fullScreenState = 2
			var_6_2.canJump = not var_6_1

			table.insert(var_6_0, var_6_2)

			local var_6_3 = {
				canJump = not var_6_1
			}

			var_6_3.moduleName = "recruit"
			var_6_3.movieName = "nightPush_1334x870_834"
			var_6_3.id = "push"
			var_6_3.fullScreenState = 2

			table.insert(var_6_0, var_6_3)
		else
			local var_6_4 = {
				sound = var_0_8.Sound.RECRUIT_SUNNY
			}

			var_6_4.moduleName = "recruit"
			var_6_4.movieName = "dailyRecruitEnter_1334x870_2300"
			var_6_4.id = "enter"
			var_6_4.canJump = not var_6_1
			var_6_4.fullScreenState = 2

			table.insert(var_6_0, var_6_4)

			local var_6_5 = {}

			var_6_5.moduleName = "recruit"
			var_6_5.canJump = not var_6_1
			var_6_5.movieName = "dailyPush_1334x870_834"
			var_6_5.id = "push"
			var_6_5.fullScreenState = 2

			table.insert(var_6_0, var_6_5)
		end
	end

	local var_6_6 = "Blue"
	local var_6_7 = var_0_8.Sound.RECRUIT_TUIJING_BLUE

	if self._highQuality == 2 then
		var_6_6 = "Violet"
		var_6_7 = var_0_8.Sound.RECRUIT_TUIJING_PURPLE
	elseif self._highQuality == 3 then
		var_6_6 = "Golden"
		var_6_7 = var_0_8.Sound.RECRUIT_TUIJING_ORANGE
	elseif self._highQuality == 4 then
		var_6_6 = "Colour"
	end

	local var_6_8 = {
		sound = var_6_7
	}

	var_6_8.moduleName = "recruit"
	var_6_8.movieName = "recruit" .. self._actionsParams.numStr .. var_6_6 .. self._actionsParams.sizeStrs[self._highQuality]
	var_6_8.id = "show"
	var_6_8.canJump = not var_6_1
	var_6_8.autoRemove = false
	var_6_8.fullScreenState = 2
	var_6_8.events = {
		playEffect = {
			handler = handler(self, self._onPlayPassEffect)
		}
	}

	table.insert(var_6_0, var_6_8)

	return var_6_0
end

function RecruitPrimaryLayer:_onUserClick(arg_7_1)
	if not arg_7_1 then
		return
	end

	if arg_7_1[1].id == "loop" then
		self.m_moveComp:jump()
	end
end

function RecruitPrimaryLayer:onLoad()
	if var_0_1 and var_0_1.judgeIsRefuseBioInviteIfEnterModule then
		var_0_1:judgeIsRefuseBioInviteIfEnterModule()
	end

	local var_8_0 = g.core.event.enum

	var_0_3:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO, self._updateView, self)
	var_0_3:addEventListener(var_8_0.EVENT_NET_S2C_RECRUIT_RECRUIT, self._doRecruit, self)
	var_0_3:addEventListener(var_8_0.EVENT_NET_S2C_NEW_RECRUIT_NOVICETENRECRUIT, self._doRecruit, self)
	var_0_3:addEventListener(var_8_0.EVENT_NET_S2C_SHOP_SHOPPING, self._onBuyItemSuc, self)
	self:_isRequestNetWork()
end

function RecruitPrimaryLayer:_isRequestNetWork()
	if not (self._firstEnter or g.core.model.User.recruitData:hasData()) then
		g.core.network.GameNetProxy:send_C2S_NewRecruit_Info({})
	elseif g.core.model.User.recruitData:isExpired() then
		g.core.model.User.recruitData:resetExpired()
		g.core.network.GameNetProxy:send_C2S_NewRecruit_Info({})
	else
		self:_updateView()
		self:_updateDetailCompView()
	end

	self._firstEnter = false
end

function RecruitPrimaryLayer:_doRecruit(arg_10_1, arg_10_2, arg_10_3)
	if self._actionsParams then
		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_WAIT)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_START)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	self.m_topBarComp:playHideAction()

	self._content = arg_10_3
	self._highQuality = 0

	for iter_10_0 = 1, #arg_10_3.awards do
		self._highQuality = math.max(self._highQuality, g.core.common.Goods:convert(arg_10_3.awards[iter_10_0]).quality)
		arg_10_3.awards[iter_10_0].isNew = g.core.model.User.recruitData:checkIsNew(arg_10_3.awards[iter_10_0].value)
		arg_10_3.awards[iter_10_0].id = iter_10_0
	end

	self:_preLoadNextLayer()

	self._actionsParams = RecruitFuncCfg:getRecruitActionParams(arg_10_3.recruit_type, arg_10_3.num)

	self.m_moveComp:setMovieList(self:_getMovieList(), handler(self, self._moviePlayEnd), handler(self, self._onUserClick))
	self.m_moveComp:setPreLoadEnable(true)
	self.m_moveComp:playShow()
end

function RecruitPrimaryLayer:_onPlayPassEffect()
	self:_moviePlayEnd()
end

function RecruitPrimaryLayer:_moviePlayEnd()
	if self._actionsParams then
		self._actionsParams = nil

		self.m_moveComp:setPlayEndNormal(true)

		if self._highQuality > 2 then
			self.m_topBarComp:playShowAction()
			self.m_moveComp:playHide()
			self.m_ssrComp:resume()
			self:newScheduleOnce(handler(self, self._clearMoiveComp), 0.4)
		else
			self:_clearMoiveComp()
			self:_goToRewardLayer()
		end
	end
end

function RecruitPrimaryLayer:_clearMoiveComp()
	self.m_moveComp:clearKeepCriSpites()
end

function RecruitPrimaryLayer:_goToRewardLayer()
	self.m_moveComp:playHide()
	self:_clearMoiveComp()

	self._playEffect = false

	self._rewardComp:playShow()
	self.m_topBarComp:playShowAction()
	self.m_enterTransition:play()

	self._rewardComp = nil
end

function RecruitPrimaryLayer:_updateView()
	self:_updateDetailCompView()
	self.m_primaryComp:playShow()
end

function RecruitPrimaryLayer:_updateDetailCompView()
	self.m_primaryComp:updateView()
end

function RecruitPrimaryLayer:onUnload()
	self._curCellData = nil

	if self._animWaitCount and self._animWaitCount > 0 then
		for iter_17_0 = 1, self._animWaitCount do
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		end

		self._animWaitCount = 0
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_READY)
end

function RecruitPrimaryLayer:onRemoved()
	g.core.resource.ResourceManager:removeSpineCache(var_0_7.TYPE.RES_EFFECT, var_0_7.RECRUIT_RES_EFFECT_CACHE)
end

function RecruitPrimaryLayer:receiveCompEvent(arg_19_1, arg_19_2)
	if arg_19_1 == "txt_pop_ok" then
		if arg_19_2 and arg_19_2 == "RECRUIT_LAYER_GOTO_TEAM_TAB" then
			self._gtree:setSelectedIndex({
				2,
				0
			})
		end
	elseif arg_19_1 == "doTipRecruit" then
		self:_onTipBuyPop(arg_19_2.type, arg_19_2.num, arg_19_2.id)
	elseif arg_19_1 == "limitTimeEnd" then
		self:_onLimitRecruitChanged()
		g.core.network.GameNetProxy:send_C2S_NewRecruit_Info({})
	elseif arg_19_1 == "checkNeedOpen" then
		self:_onCheckNeedClose()
	end
end

function RecruitPrimaryLayer:_onCheckNeedClose()
	local var_20_0 = self

	self:newScheduleOnce(function()
		if not g.core.model.User.recruitData:checkPrimaryIsOpen() then
			g.core.module.ModuleManager:onlyPopSelfByDisplay(var_20_0)
		end
	end, 0.5)
end

function RecruitPrimaryLayer:_onClickedLuck()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
		id = 103
	}), {
		touchDisappear = true
	})
end

function RecruitPrimaryLayer:_onTipBuyPop(arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = g.core.model.User.recruitData:getFuncNeedInfoByRecruitInfo(arg_23_1, arg_23_2)
	local var_23_1, var_23_2

	if g.core.model.User.recruitData:getRecruitBuyTipFlag() then
		self:_doBuyItemAndRecruit(arg_23_1, arg_23_2, var_23_0, arg_23_3)

		do return end

		var_23_1 = false
		var_23_2 = {
			title = g.core.lang:get(100039)
		}
	end

	var_23_2.desc = g.core.lang:get(108027, {
		itemNum = var_23_0.num,
		itemName = var_23_0.consumeInfo.name,
		coinNum = var_23_0.priceInfo.size,
		coinName = var_23_0.priceInfo.name
	})
	var_23_2.tip = {
		txt = g.core.lang:get(108045)
	}

	function var_23_2.onCheck(arg_24_0)
		var_23_1 = arg_24_0
	end

	function var_23_2.onConfirm()
		handler(self, self._doBuyItemAndRecruit)(arg_23_1, arg_23_2, var_23_0, arg_23_3)
		g.core.model.User.recruitData:setRecruitBuyTipFlag(var_23_1)
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new(var_23_2), {
		touchDisappear = true
	})
end

function RecruitPrimaryLayer:_doBuyItemAndRecruit(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	arg_26_3 = arg_26_3 or g.core.model.User.recruitData:getFuncNeedInfoByRecruitInfo(arg_26_1, arg_26_2)

	local var_26_0 = g.core.model.User.bagData:getCountById(arg_26_3.priceInfo.type, arg_26_3.priceInfo.value)

	if ((arg_26_3.priceInfo.type == 999 and arg_26_3.priceInfo.value == 0 or nil) and g.core.model.User:getFreeGold()) < arg_26_3.priceInfo.size then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = arg_26_3.priceInfo.type,
			value = arg_26_3.priceInfo.value
		})

		return
	end

	table.insert(self._autoBuyList, {
		recruitType = arg_26_1,
		recruitNum = arg_26_2,
		itemInfo = arg_26_3,
		recruitId = arg_26_4
	})
	g.core.network.GameNetProxy:send_C2S_Shop_Shopping({
		shop_id = 1,
		cost_idx = 0,
		info = {
			id = arg_26_3.id,
			num = arg_26_3.num
		}
	})
end

function RecruitPrimaryLayer:_onBuyItemSuc(arg_27_1, arg_27_2, arg_27_3)
	local var_27_0

	for iter_27_0, iter_27_1 in ipairs(self._autoBuyList) do
		if iter_27_1.itemInfo.id == arg_27_3.info.id then
			var_27_0 = table.remove(self._autoBuyList, iter_27_0)

			break
		end
	end

	g.core.network.GameNetProxy:send_C2S_NewRecruit_Recruit({
		consume_type = 1,
		recruit_type = var_27_0.recruitId,
		num = var_27_0.recruitNum
	})
end

function RecruitPrimaryLayer:_onLimitRecruitChanged()
	self:_refreshTreeUI()
end

function RecruitPrimaryLayer:updateTopRes()
	self.m_topBarComp:updateTopRes({})
	self.m_topBarComp:setHelpId(g.core.const.ConstMgr.HelpConst.HELP_TYPE.PRIMARY_RECRUIT)
end

function RecruitPrimaryLayer:_preLoadNextLayer()
	if self._highQuality > 2 then
		local var_30_0 = clone(self._content)

		var_30_0.isHideRecruitBtn = true

		self.m_ssrComp:updateComp(var_30_0, true)
		self.m_ssrComp:pause()
	else
		local var_30_1 = clone(self._content)

		var_30_1.isPreLoad = true
		var_30_1.callBack = handler(self, self.onLoad)
		self._rewardComp = require("app.view.module.recruit.view.RecruitRewardLayer").new(var_30_1)

		self:addChild(self._rewardComp)
		self._rewardComp:setVisible(false)
	end
end

return RecruitPrimaryLayer
