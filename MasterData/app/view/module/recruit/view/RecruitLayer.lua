local DebugCommon = require("app.view.module.debug.common.DebugCommon")
local var_0_1 = g.core.const.ConstMgr.RecruitConst
local var_0_2 = g.core.service.ServiceManager:getServiceByName("BioTeamInviteFloatService")
local var_0_3 = g.core.const.ConstMgr.QUALITY_TYPE
local AutoBuyComp = require("app.view.module.recruit.view.comp.AutoBuyComp")
local RecruitLayer = class("RecruitLayer", require("app.fairyGUI.recruit.UI_RecruitLayer"), function()
	return fgui.GComponent:create({
		resName = "RecruitLayer",
		pkgPath = "ui/recruit/recruit",
		isFullScreen = true,
		pkgName = "recruit"
	}, ...)
end)
local var_0_6 = g.core.event.EventManager
local var_0_7 = g.core.common.Goods
local RecruitFuncCfg = require("app.view.module.recruit.const.RecruitFuncCfg")
local var_0_9 = g.core.const.ConstMgr.SpineConst
local var_0_10 = g.core.const.ConstMgr.SoundConst

function RecruitLayer:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._compTab = {}
	self._currentComp = nil
	self._criMoves = {}
	self._tagType = nil
	self._selectTag = nil
	self._tabCfgs = nil
	self._curTabCfg = nil

	local var_2_0 = self.m_childComp:getPosition()
	local var_2_1 = self.m_childComp1:getPosition()

	self._childSize = cc.size(var_2_1.x - var_2_0.x, var_2_1.y - var_2_0.y)
	self._autoBuyList = {}
	self.m_enterTransition = self:getView():getTransition("enter")
	self._packageMap = {}
	self._isShowReward = false
	self._curCellData = nil
	self._lastCellData = nil
	self._animWaitCount = 0

	self.m_treeList:setIniter()
	self.m_treeList:setItemRenderer(handler(self, self._onFCellRenderer))
	self:_getTreeListCfgs()
	self:initGotoTag(arg_2_1.route1 or 0, arg_2_1.route2)
	self:_init()
	self:setSelectTag()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.2)
end

function RecruitLayer:initGotoTag(arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		return
	elseif arg_4_1 == var_0_1.RECRUIT_ROUTE_TYPE.ROUTE_TYPE_LOW then
		self._tagType = var_0_1.RECRUIT_TYPE.PREMIUM

		g.core.module.ModuleManager:tip("can not jump low recruit!")
	elseif arg_4_1 == var_0_1.RECRUIT_ROUTE_TYPE.ROUTE_TYPE_PREMIUM then
		self._tagType = var_0_1.RECRUIT_TYPE.PREMIUM
	elseif arg_4_1 == var_0_1.RECRUIT_ROUTE_TYPE.ROUTE_TYPE_UNITE_TOKEN_NORMAL then
		self._tagType = var_0_1.RECRUIT_TYPE.UNITE_TOKEN_NORMAL
	elseif arg_4_1 == var_0_1.RECRUIT_ROUTE_TYPE.ROUTE_TYPE_RECRUIT_ID then
		self:_getSelectTagById(arg_4_2)
	elseif arg_4_1 == var_0_1.RECRUIT_ROUTE_TYPE.ROUTE_TYPE_ARTIFACT_BASE then
		self._tagType = var_0_1.RECRUIT_TYPE.ARTIFACT_BASE
	elseif arg_4_1 == var_0_1.RECRUIT_ROUTE_TYPE.ROUTE_TYPE_RECRUIT_TYPE then
		self:_getSelectTagByType(arg_4_2)
	end
end

function RecruitLayer:_checkAndFixTag()
	if not self._selectTag then
		return
	end

	local var_5_0 = string.split(self._selectTag, "_")
	local var_5_1 = math.min(tonumber(var_5_0[1]), #self._tabCfgs)

	self._selectTag = var_5_1 .. "_" .. math.min(tonumber(var_5_0[2]), #self._tabCfgs[var_5_1].subTree)
end

function RecruitLayer:_initBuyComp()
	local var_6_0 = g.core.model.User.recruitData:getBuyHelper()

	AutoBuyComp.setDefaultConfirmTxtInfo(var_6_0:getTextInfo())
	AutoBuyComp.setDefaultHandler("checkFlagHandler", handler(var_6_0, var_6_0._checkTipPop))
	AutoBuyComp.setDefaultHandler("setFlagHandler", handler(var_6_0, var_6_0._setCheckTipFlag))
	AutoBuyComp.setDefaultHandler("checkExFlagHandler", handler(g.core.model.User.recruitData, g.core.model.User.recruitData.getRecruitAutoChangeTipFlag))
	AutoBuyComp.setDefaultHandler("setExFlagHandler", handler(var_6_0, var_6_0._setCheckTipFlagEx))
end

function RecruitLayer:_updateTreeRedPoint()
	self:setSelectTag()
end

function RecruitLayer:setSelectTag(arg_8_1, arg_8_2)
	if arg_8_2 then
		if self._selectTag then
			self:_checkAndFixTag()

			local var_8_0 = string.split(self._selectTag, "_")

			self._selectTag = nil

			self.m_treeList:getChildAt(tonumber(var_8_0[1]) - 1):setSelectTag(tonumber(var_8_0[2]) - 1)
		else
			local var_8_1 = {
				0,
				0
			}

			self.m_treeList:setSelectedIndex(var_8_1[1])
			self.m_treeList:getChildAt(var_8_1[1]):setSelectTag(var_8_1[2])
		end

		return
	end

	if not arg_8_1 then
		arg_8_1 = self._selectTag

		self:_checkAndFixTag()
	end

	if arg_8_1 then
		local var_8_2 = {}

		for iter_8_0, iter_8_1 in ipairs((string.split(arg_8_1, "_"))) do
			if tonumber(iter_8_1) > 0 then
				var_8_2[iter_8_0] = tonumber(iter_8_1) - 1
			end
		end

		if var_8_2[1] then
			self.m_treeList:getChildAt(var_8_2[1]):setSelectTag(var_8_2[2])
			self:newScheduleOnce(handler(self, function(arg_9_0)
				arg_9_0.m_treeList:scrollToView(var_8_2[1], false, true)
			end), 0.2)
			self.m_treeList:setSelectedIndex(var_8_2[1])
		end
	else
		local var_8_3 = {
			0,
			0
		}

		self.m_treeList:getChildAt(var_8_3[1]):setSelectTag(var_8_3[2])
		self.m_treeList:scrollToView(var_8_3[1])
		self.m_treeList:setSelectedIndex(var_8_3[1])
	end
end

function RecruitLayer:_onFCellRenderer(arg_10_1, arg_10_2)
	if not self._tabCfgs then
		return
	end

	arg_10_2:updateView(self._tabCfgs[arg_10_1 + 1], arg_10_1)
	arg_10_2:setSubClickEvent(handler(self, self._onTreeNodeClickItem), handler(self, self._onCheckTreeNodeClick))
end

function RecruitLayer:_init()
	self.m_touchLuck:addClickListener(handler(self, self._onClickedLuck))
	self.m_topBarComp:setResInfoById(20)
	self.m_touchLuckLimit:addClickListener(handler(self, self._onClickedLimitLuck))
	self.m_touchLuckLimitPet:addClickListener(handler(self, self._onClickedLuck))
	self.m_recruitShopBtn:addClickListener(handler(self, self._onRecruitShopClick))
	self.m_artifactShopBtn:addClickListener(handler(self, self._onArtifactShopClick))
	self.m_treeList:setNumItems(#self._tabCfgs)
	self.m_maskLoader:setURL("bg/recruit/bg_zm_mask1.png")

	local var_11_0 = self.m_maskLoader:getSize()

	self.m_maskLoader:setScale(math.max(display.height / var_11_0.height, display.width / var_11_0.width))

	if not self._selectTag then
		if not self._tagType then
			self:_getDefaultTag()
		else
			self:_getSelectTagByType(self._tagType)
		end
	end

	self:_initBuyComp()
	g.core.resource.ResourceManager:addSpineCache(var_0_9.TYPE.RES_EFFECT, var_0_9.RECRUIT_RES_EFFECT_CACHE)
end

function RecruitLayer:_getDefaultTag()
	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = {}
	local var_12_3 = {}

	for iter_12_0, iter_12_1 in ipairs(self._tabCfgs) do
		if iter_12_1.tabType == "knight" then
			for iter_12_2, iter_12_3 in ipairs(iter_12_1.subTree) do
				local var_12_4 = g.core.model.User.recruitData:getDisplayInfoById(iter_12_3.id)

				if var_12_4.cfg.type_label == 1 then
					table.insert(var_12_0, iter_12_0 .. "_" .. iter_12_2)
				elseif var_12_4.cfg.type_label == 2 then
					table.insert(var_12_1, iter_12_0 .. "_" .. iter_12_2)
				elseif var_12_4.cfg.type_label == 5 then
					table.insert(var_12_3, iter_12_0 .. "_" .. iter_12_2)
				else
					table.insert(var_12_2, iter_12_0 .. "_" .. iter_12_2)
				end
			end
		end
	end

	local var_12_5 = g.core.model.User.recruitData:isGetAdvanceRecruitFirstSSR()

	if #var_12_3 > 0 then
		self._selectTag = var_12_3[1]
	elseif g.core.model.User.recruitData:getAdvanceTotalNum() == 0 then
		self:_getSelectTagByType(var_0_1.RECRUIT_TYPE.PREMIUM)
	else
		self._selectTag = #var_12_0 > 0 and var_12_5 and var_12_0[1] or #var_12_1 > 0 and var_12_5 and var_12_1[1] or var_12_2[1]
	end
end

function RecruitLayer:_getTreeListCfgs()
	self._tabCfgs = RecruitFuncCfg.getTabListCfgs()

	self.m_treeList:setVisible(true)
end

function RecruitLayer:_onRecruitShopClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.UNITE_TOKEN_NORMAL,
		subId = self._curCellData.uniteTokenShopId
	})
end

function RecruitLayer:_onArtifactShopClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.FLUSH_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_FLUSH_TYPE.ARTIFACT
	})
end

function RecruitLayer:_checkOpenRecruit()
	local var_16_0 = RecruitFuncCfg.getTabListCfgs()

	if var_16_0[1] and var_16_0[1].subTree then
		if self._tabCfgs and self._tabCfgs[1] and #self._tabCfgs[1].subTree ~= #var_16_0[1].subTree then
			self:_refreshTreeUI()
		end
	end
end

function RecruitLayer:_refreshTreeUI()
	for iter_17_0, iter_17_1 in pairs(self._compTab) do
		local var_17_0 = g.core.model.User.recruitData:getRecruitTypeById(iter_17_0)

		if var_17_0 ~= var_0_1.RECRUIT_TYPE.Base and var_17_0 ~= var_0_1.RECRUIT_TYPE.PREMIUM and var_17_0 ~= var_0_1.RECRUIT_TYPE.UNITE_TOKEN_NORMAL then
			if self._curCellData and self._curCellData.id == iter_17_0 then
				self._currentComp = nil
				self._curCellData = nil
			end

			iter_17_1:removeFromParent()

			self._compTab[iter_17_0] = nil
		end
	end

	self:_getTreeListCfgs()
	self.m_treeList:setNumItems(#self._tabCfgs)
	self:setSelectTag(nil, true)
end

function RecruitLayer:_getMovieList()
	local var_18_0 = {}
	local var_18_1 = g.core.model.User.recruitData:isNewPlayer()

	if (self._content.recruit_type == var_0_1.RECRUIT_TYPE.Base and "daily" or "night") == "night" then
		if self._actionsParams.numStr == "Ten" then
			local var_18_2 = {
				sound = var_0_10.Sound.RECRUIT_RAINY
			}

			var_18_2.moduleName = "recruit"
			var_18_2.movieName = "nightRecruitEnter_1334x870_2300"
			var_18_2.id = "enter"
			var_18_2.canJump = not var_18_1
			var_18_2.fullScreenState = 2

			table.insert(var_18_0, var_18_2)

			local var_18_3 = {}

			var_18_3.moduleName = "recruit"
			var_18_3.movieName = "nightPush_1334x870_834"
			var_18_3.id = "push"
			var_18_3.canJump = not var_18_1
			var_18_3.fullScreenState = 2

			table.insert(var_18_0, var_18_3)
		else
			local var_18_4 = {
				sound = var_0_10.Sound.RECRUIT_SUNNY
			}

			var_18_4.moduleName = "recruit"
			var_18_4.movieName = "dailyRecruitEnter_1334x870_2300"
			var_18_4.id = "enter"
			var_18_4.canJump = not var_18_1
			var_18_4.fullScreenState = 2

			table.insert(var_18_0, var_18_4)

			local var_18_5 = {}

			var_18_5.moduleName = "recruit"
			var_18_5.movieName = "dailyPush_1334x870_834"
			var_18_5.id = "push"
			var_18_5.canJump = not var_18_1
			var_18_5.fullScreenState = 2

			table.insert(var_18_0, var_18_5)
		end
	end

	local var_18_6 = "Blue"
	local var_18_7 = var_0_10.Sound.RECRUIT_TUIJING_BLUE

	if self._highQuality == var_0_3.SR then
		var_18_6 = "Violet"
		var_18_7 = var_0_10.Sound.RECRUIT_TUIJING_PURPLE
	elseif self._highQuality == var_0_3.SSR then
		var_18_6 = "Golden"
		var_18_7 = var_0_10.Sound.RECRUIT_TUIJING_ORANGE
	elseif self._highQuality == var_0_3.UR then
		var_18_6 = "Phantomcolor"
	elseif self._highQuality == var_0_3.MR then
		var_18_6 = "Mythic"
	end

	local var_18_8 = {
		sound = var_18_7
	}

	var_18_8.moduleName = "recruit"
	var_18_8.movieName = "recruit" .. self._actionsParams.numStr .. var_18_6 .. self._actionsParams.sizeStrs[self._highQuality]
	var_18_8.id = "show"
	var_18_8.canJump = not var_18_1
	var_18_8.autoRemove = false
	var_18_8.fullScreenState = 2
	var_18_8.events = {
		shadowShow = {
			handler = handler(self, self._onShowShadow)
		},
		playEffect = {
			handler = handler(self, self._onPlayPassEffect)
		}
	}

	table.insert(var_18_0, var_18_8)

	return var_18_0
end

function RecruitLayer:_getTreeNodeTag(arg_19_1)
	local var_19_0

	for iter_19_0 = 2, #arg_19_1 do
		local var_19_1 = arg_19_1[iter_19_0 - 1]:getChildIndex(arg_19_1[iter_19_0])

		var_19_0 = not var_19_0 and var_19_1 or "_" .. var_19_1
	end

	return var_19_0
end

function RecruitLayer:_onCheckTreeNodeClick(arg_20_1)
	if arg_20_1.isUnlock and arg_20_1.isUnlock() then
		return true
	else
		return g.core.common.ModuleUnlock:checkModuleUnlockStatus(arg_20_1.funcId)
	end
end

function RecruitLayer:_onTreeNodeClickItem(arg_21_1, arg_21_2)
	if not arg_21_1 then
		return
	end

	if not arg_21_1.compName then
		return
	end

	if self._selectTag and self._selectTag == arg_21_2 and self._currentComp then
		return
	end

	self:updateTopRes(arg_21_1)

	self._selectTag = arg_21_2
	self._curTabCfg = self._tabCfgs[tonumber(self._selectTag:split("_")[1])]

	if self._curTabCfg.packageName then
		self:_addPackage(self._curTabCfg.packageName)
	end

	self._curCellData = clone(arg_21_1)

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._animWaitCount = self._animWaitCount + 1

	if self._currentComp and self._currentComp.playHide then
		self._currentComp:playHide(handler(self, self._onChangeComp))
	else
		self:_onChangeComp()
	end
end

function RecruitLayer:_addPackage(arg_22_1)
	if g.core.module.ModuleManager:checkPackageEnable() then
		if not self._packageMap[arg_22_1] then
			g.core.module.ModuleManager:checkPackage(arg_22_1, 1)
		end

		self._packageMap[arg_22_1] = true
	else
		fgui.UIPackage:addPackage((table.concat({
			"ui",
			arg_22_1,
			arg_22_1
		}, "/")))
	end
end

function RecruitLayer:_removePackage()
	if g.core.module.ModuleManager:checkPackageEnable() then
		for iter_23_0, iter_23_1 in pairs(self._packageMap) do
			g.core.module.ModuleManager:checkPackage(iter_23_0, -1)
		end

		self._packageMap = {}
	end
end

function RecruitLayer:_onChangeComp()
	if self._animWaitCount and self._animWaitCount > 0 then
		for iter_24_0 = 1, self._animWaitCount do
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		end

		self._animWaitCount = 0
	end

	if self._lastCellData == self._curCellData then
		return
	end

	self:_onChangeBg(self._curCellData.bgUrl, true)
	self:_updateRightCompView(self._curCellData)

	self._lastCellData = self._curCellData
end

function RecruitLayer:_onTreeResetData(arg_25_1)
	if not arg_25_1 then
		return
	end

	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		if self._gtree:getCellData(iter_25_1).funcId == g.core.const.ConstMgr.FUNCTION_TYPE.GROUP_RECRUIT then
			local var_25_0 = iter_25_1:getCell():getChild("uniqueLine")

			if iter_25_1:isExpanded() then
				var_25_0:setVisible(true)
			else
				var_25_0:setVisible(false)
			end
		else
			local var_25_1 = iter_25_1:getCell():getChild("uniqueLine")

			if var_25_1 then
				var_25_1:setVisible(false)
			end
		end
	end
end

function RecruitLayer:_onUserClick(arg_26_1)
	if not arg_26_1 then
		return
	end

	if arg_26_1[1].id == "loop" then
		self.m_moveComp:jump()
	end
end

function RecruitLayer:_addCustomListener()
	var_0_6:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO, self._updateDetailCompView, self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_RECRUIT, self._doRecruit, self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_NOVICETENRECRUIT, self._doRecruit, self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_NET_S2C_ACTIVITY_COMMON_GETINFOSERVER, self._onLimitRecruitChanged, self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_NET_S2C_CUSTOM_ACTIVITY_UPDATEINFO, self._onLimitRecruitChanged, self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_CUSTOM_ACTIVITY_START_PREVIEW, self._onLimitRecruitChanged, self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_QUARTER_MINUTE_NOTIFY, handler(self, self._checkOpenRecruit), self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_GUIDE_UNIT_RECRUIT, handler(self, self._goToUnitTokenRecruit), self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_GUIDE_ARTIFACT_RECRUIT, handler(self, self._goToArtifactRecruit), self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_GUIDE_PET_RECRUIT, handler(self, self._goToPetRecruit), self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_GUIDE_DAILY_RECRUIT, handler(self, self._goToDailyRecruit), self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_GUIDE_PRIMARY_RECRUIT, handler(self, self._goToPrimaryRecruit), self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_GUIDE_KNIGHT_SOUL_RECRUIT, handler(self, self._goToKnightSoulRecruit), self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_GUIDE_PRECIOUS_RECRUIT, handler(self, self._goToPreciousRecruit), self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_NOTIFYSUCCESS, handler(self, self._updateCostView), self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD, self._updateTreeRedPoint, self)
	var_0_6:addEventListener(g.core.event.enum.EVENT_RECRUIT_REWARD_REMOVED, handler(self, self._onRewardLayerOnRemoved), self)
end

function RecruitLayer:onLoad()
	if var_0_2 and var_0_2.judgeIsRefuseBioInviteIfEnterModule then
		var_0_2:judgeIsRefuseBioInviteIfEnterModule()
	end

	self:_addCustomListener()
	self:_isRequestNetWork()
	self:checkPlayShowComp()

	if self._luckVisible ~= nil then
		self.m_groupLuck:setVisible(self._luckVisible)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function RecruitLayer:checkPlayShowComp()
	if self._currentComp then
		-- block empty
	end
end

function RecruitLayer:_isRequestNetWork()
	if not g.core.model.User.recruitData:hasData() then
		g.core.network.GameNetProxy:send_C2S_NewRecruit_Info({})
		g.core.network.GameNetProxy:send_C2S_NewRecruit_Info({})
	elseif g.core.model.User.recruitData:isExpired() then
		g.core.model.User.recruitData:resetExpired()
		g.core.network.GameNetProxy:send_C2S_NewRecruit_Info({})
	else
		self:_updateView()

		if self._selectTag then
			local var_30_0 = {}

			for iter_30_0, iter_30_1 in ipairs((string.split(self._selectTag, "_"))) do
				if tonumber(iter_30_1) > 0 then
					var_30_0[iter_30_0] = tonumber(iter_30_1) - 1
				end
			end

			self._gtree:setSelectedIndex(var_30_0)
		end
	end
end

function RecruitLayer:_doRecruit(arg_31_1, arg_31_2, arg_31_3)
	if self._actionsParams then
		return
	end

	if arg_31_3.awards == nil then
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))

		return
	end

	local var_31_0 = g.core.model.User.recruitData:getBuyHelper()

	if arg_31_3.recruitTypeNet then
		var_31_0:setRecruitType(g.core.model.User.recruitData:getRecruitCfgByIdOrActId(arg_31_3.recruitTypeNet).type)
		var_31_0:setRecruitId(arg_31_3.recruitTypeNet)
		var_31_0:setRecruitNum(#arg_31_3.awards)
	else
		var_31_0:setRecruitType(nil)
		var_31_0:setRecruitId(nil)
		var_31_0:setRecruitNum(0)
	end

	if DebugCommon.getDebugGlobalValueByKey("recruit_jump_effect") and not self._isShowReward then
		local var_31_1 = 0

		for iter_31_0 = 1, #arg_31_3.awards do
			local var_31_2 = var_0_7:convert(arg_31_3.awards[iter_31_0])

			if not var_31_2.is_frag then
				var_31_1 = math.max(var_31_1, var_31_2.quality)
			end
		end

		if var_31_1 < g.core.const.ConstMgr.QUALITY_TYPE.SSR then
			if self._currentComp then
				self._currentComp:playShow()
			end

			g.core.module.ModuleManager:tip("recruit_end")

			return
		end
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_WAIT)

	self._luckVisible = self.m_groupLuck:isVisible()

	self:newScheduleOnce(handler(self, self._updateCostView), 0.5)

	if self._currentComp and self._currentComp.playRecruitAction then
		self._currentComp:playRecruitAction(arg_31_3, self.m_moveComp, self.m_otherRecruitEffectComp, self.m_groupLuck, self._isShowReward)

		return
	end

	if self._isShowReward then
		return
	end

	self.m_topBarComp:playHideAction()

	if arg_31_3.recruit_type == g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.UNITE_TOKEN_NORMAL or arg_31_3.recruit_type == g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.UNITE_TOKEN_LIMIT or arg_31_3.recruit_type == g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.UNITE_TOKEN_OPEN_SERVER then
		self:_onUniteTokenRecruitResult(arg_31_3)
		self.m_topBarComp:playShowAction()

		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_START)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._content = arg_31_3
	self._highQuality = 0

	for iter_31_1 = 1, #arg_31_3.awards do
		self._highQuality = math.max(self._highQuality, var_0_7:convert(arg_31_3.awards[iter_31_1]).quality)
		arg_31_3.awards[iter_31_1].isNew = g.core.model.User.recruitData:checkIsNew(arg_31_3.awards[iter_31_1].value)
		arg_31_3.awards[iter_31_1].id = iter_31_1
	end

	self:_preLoadNextLayer()

	self._actionsParams = RecruitFuncCfg:getRecruitActionParams(arg_31_3.recruit_type, arg_31_3.num)

	self.m_moveComp:setMovieList(self:_getMovieList(), handler(self, self._moviePlayEnd), handler(self, self._onUserClick))
	self.m_moveComp:setPreLoadEnable(true)
	self.m_moveComp:playShow()
	self.m_treeList:setNumItems(#self._tabCfgs)
end

function RecruitLayer:_onShowShadow()
	return
end

function RecruitLayer:_onPlayPassEffect()
	self:_moviePlayEnd()
end

function RecruitLayer:_moviePlayEnd()
	local var_34_0 = self.m_moveComp:isJump()

	if self._actionsParams then
		self._actionsParams = nil

		self.m_moveComp:setPlayEndNormal(true)

		if (self._content.recruitTypeNet and g.core.model.User.recruitData:getRecruitCfgByIdOrActId(self._content.recruitTypeNet) or g.core.model.User.recruitData:getRecruitKnightCfg(self._content.recruit_type)).gacha_display_quality <= self._highQuality then
			self.m_knightIcon:setVisible(false)
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

function RecruitLayer:_clearMoiveComp()
	self.m_moveComp:clearKeepCriSpites()
end

function RecruitLayer:_goToRewardLayer()
	self:_onActionEnd()
	self._rewardComp:playShow()
	self.m_topBarComp:playShowAction()
	self.m_enterTransition:play()
end

function RecruitLayer:_onActionEnd()
	self.m_moveComp:playHide()
	self:_clearMoiveComp()
	self.m_knightIcon:setVisible(false)

	self._playEffect = false
end

function RecruitLayer:_updateView()
	self:_updateTreeView()
end

function RecruitLayer:_updateTreeView()
	local var_39_0 = self:_getTreeListCfgs()
	local var_39_1 = true
	local var_39_2 = self._gtree:getSelectedNode()

	if var_39_2 then
		local var_39_3 = self._gtree:getCellData(var_39_2)

		if var_39_3.groupType or var_39_3.funcId and var_39_3.funcId == g.core.const.ConstMgr.FUNCTION_TYPE.GROUP_RECRUIT then
			var_39_1 = false
		end
	end

	if var_39_0 and var_39_1 then
		self._gtree:resetData(var_39_0)
	end
end

function RecruitLayer:_updateRightCompView(arg_40_1)
	if not arg_40_1 or not arg_40_1.type then
		return
	end

	if self._currentComp ~= nil then
		self._currentComp:setVisible(false)
	end

	self._currentComp = self._compTab[arg_40_1.id]
	self._cellData = arg_40_1

	self.m_leftGroupIcon:setVisible(false)

	local var_40_0 = arg_40_1.type == var_0_1.RECRUIT_TYPE.UNITE_TOKEN_NORMAL or arg_40_1.type == var_0_1.RECRUIT_TYPE.UNITE_TOKEN_LIMIT

	if self._currentComp == nil then
		self._currentComp = fgui.UIPackage:createObject(self._curTabCfg.packageName or "recruit", arg_40_1.compName)
		self._compTab[arg_40_1.id] = self._currentComp

		local var_40_2
		local var_40_3 = self._currentComp:getSize()

		if var_40_3.width == 1334 and var_40_3.height == 750 then
			self._currentComp:setSize(display.width - cc.Director:getInstance():getSafeAreaRect().x * 2, display.height)

			var_40_2 = self.m_childComp2
		else
			if self._currentComp.changeSize then
				self._currentComp:changeSize(self._childSize.width, self._childSize.height)
			else
				self._currentComp:setSize(self._childSize.width, self._childSize.height)
			end

			var_40_2 = self.m_childComp
		end

		var_40_2:addChildWithListen(self._currentComp)

		if arg_40_1.groupType then
			self._currentComp:init({
				groupType = arg_40_1.groupType
			})
		end

		if arg_40_1.compData then
			self._currentComp:init(arg_40_1.compData)
		end

		if arg_40_1.useLuck then
			self._currentComp:setLuckTimeText(self.m_curLucyTxt, self.m_maxLuckTxt)
		end

		if arg_40_1.useLimitLuck or var_40_0 then
			self._currentComp:setLimitLuckTimeText(self.m_curLimitTxt, self.m_maxLimitTxt, self.m_extLimitText, self.m_extLimitLoader, self.m_effLoop, self.m_limitProg)
		end

		if arg_40_1.usePetLimitLuck then
			self._currentComp:setLimitLuckTimeText(self.m_curLimitPetTxt, self.m_maxLimitPetTxt, self.m_extLimitPetText, self.m_extLimitPetLoader)
		end

		if self._currentComp.updateByCfg then
			self._currentComp:updateByCfg(arg_40_1)
		end
	else
		self:_updateDetailCompView()
	end

	self._currentComp:playShow()

	if arg_40_1.useLuck then
		self.m_groupLuck:setVisible(true)

		if arg_40_1.type == var_0_1.RECRUIT_TYPE.ARTIFACT_LIMIT then
			self.m_actTxt:setText(g.core.lang:get(108427))
		elseif arg_40_1.type == var_0_1.RECRUIT_TYPE.PET_BASE then
			self.m_actTxt:setText(g.core.lang:get(108433))
		elseif arg_40_1.type == var_0_1.RECRUIT_TYPE.KNIGHT_SOUL_RECRUIT then
			self.m_actTxt:setText(g.core.lang:get(108470))
		elseif arg_40_1.type == var_0_1.RECRUIT_TYPE.PRECIOUS then
			self.m_actTxt:setText(g.core.lang:get(108477))
		elseif arg_40_1.type == var_0_1.RECRUIT_TYPE.RECRUIT_RETURN_ARTIFACT then
			self.m_actTxt:setText(g.core.lang:get(108610))
		elseif arg_40_1.type == var_0_1.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT then
			self.m_actTxt:setText(g.core.lang:get(108611))
		else
			self.m_actTxt:setText(g.core.lang:get(108426))
		end
	else
		self.m_groupLuck:setVisible(false)
	end

	self._luckVisible = self.m_groupLuck:isVisible()

	self.m_groupLimitLuck:setVisible(arg_40_1.useLimitLuck or var_40_0)
	self.m_groupPrimary:setVisible(arg_40_1.useTip)
	self.m_groupPetLimitLuck:setVisible(arg_40_1.usePetLimitLuck)
	self.m_recruitShopBtn:setVisible(checkbool(arg_40_1.uniteTokenShopId))
	self.m_artifactShopBtn:setVisible(arg_40_1.type == var_0_1.RECRUIT_TYPE.ARTIFACT_BASE)
	self.m_titleImg:setURL(arg_40_1.titleUrl)
	self.m_tipText:setText((self._currentComp:getTitleTip()))
end

function RecruitLayer:_updateCostView()
	self:_updateRightCompView(self._curCellData)
end

function RecruitLayer:_updateDetailCompView()
	if self._currentComp and self._currentComp.updateView then
		self._currentComp:updateView()
	end
end

function RecruitLayer:_onChangeBg(arg_43_1, arg_43_2)
	if not arg_43_1 then
		return
	end

	if not self._bg then
		self._bg = self:addBg(arg_43_1, arg_43_2, nil, 1)
	else
		self._bg:setURL(arg_43_1)

		local var_43_0 = self._bg:getSize()

		if var_43_0.width < display.width and var_43_0.height < display.height then
			self._bg:setSize(display.width, display.height)
		end
	end

	if var_0_1.RECRUIT_TYPE.ARTIFACT_LIMIT == self._curCellData.type then
		local var_43_1 = self._bg:getContentSize()

		if math.max(display.width / var_43_1.width, display.height / var_43_1.height) < 1 then
			self._bg:setSize(var_43_1.width, var_43_1.height)
		end
	end
end

function RecruitLayer:_onCriOnePlay(arg_44_1)
	local var_44_0 = {}

	var_44_0.x = 25
	var_44_0.y = 25
	var_44_0.moduleName = "recruit"
	var_44_0.movieName = "recruit" .. self._actionsParams.typeStr .. "Base_1648x1000_5770"
	var_44_0.listener = handler(self, self._onCriOnePlayCpl)

	table.insert(self._criMoves, (self.m_moveComp:addCriSprite(var_44_0)))
end

function RecruitLayer:_onCriTwoPlayCpl(arg_45_1)
	if arg_45_1 == "complete" then
		self._criMoves = {}

		g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT_REWARD, self._content)
		self.m_topBarComp:playShowAction()
		self.m_enterTransition:play()

		self._actionsParams = nil
	end
end

function RecruitLayer:onUnload()
	if self._animWaitCount and self._animWaitCount > 0 then
		for iter_46_0 = 1, self._animWaitCount do
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		end

		self._animWaitCount = 0
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_READY)
end

function RecruitLayer:onRemoved()
	g.core.resource.ResourceManager:removeSpineCache(var_0_9.TYPE.RES_EFFECT, var_0_9.RECRUIT_RES_EFFECT_CACHE)
	self:_removePackage()

	self._currentComp = nil
end

function RecruitLayer:receiveCompEvent(arg_48_1, arg_48_2)
	if arg_48_1 == "txt_pop_ok" then
		if arg_48_2 and arg_48_2 == "RECRUIT_LAYER_GOTO_TEAM_TAB" then
			self._gtree:setSelectedIndex({
				2,
				0
			})
		end

		return true
	elseif arg_48_1 == "limitTimeEnd" then
		self:_onLimitRecruitChanged()
		g.core.network.GameNetProxy:send_C2S_NewRecruit_Info({})

		return true
	elseif arg_48_1 == "update_topBar_res" then
		self.m_topBarComp:updateResource(true)

		return true
	elseif arg_48_1 == "doRecruitContinue" then
		self:_onContinueRecruit()

		return true
	elseif self._currentComp.receiveParentCompEvent then
		self._currentComp:receiveParentCompEvent(arg_48_1, arg_48_2)
	end
end

function RecruitLayer:_onClickedLuck()
	local var_49_0 = 103

	if self._cellData and self._cellData.type == var_0_1.RECRUIT_TYPE.ARTIFACT_LIMIT then
		var_49_0 = 163
	elseif self._cellData and self._cellData.type == var_0_1.RECRUIT_TYPE.PET_BASE then
		var_49_0 = 215
	elseif self._cellData and self._cellData.type == var_0_1.RECRUIT_TYPE.PET_LIMIT then
		var_49_0 = 215
	elseif self._cellData and self._cellData.type == var_0_1.RECRUIT_TYPE.PRECIOUS then
		var_49_0 = g.core.const.ConstMgr.HelpConst.HELP_TYPE.PRECIOUS_LUCKY_HELP
	elseif self._cellData and self._cellData.type == var_0_1.RECRUIT_TYPE.RECRUIT_RETURN_ARTIFACT then
		var_49_0 = 20003
	elseif self._cellData and self._cellData.type == var_0_1.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT then
		var_49_0 = 500
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
		id = var_49_0
	}), {
		touchDisappear = true
	})
end

function RecruitLayer:_onClickedLimitLuck()
	local var_50_0 = self._curCellData.luckHelpId or 156

	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
		id = var_50_0
	}), {
		touchDisappear = true
	})
end

function RecruitLayer:_onLimitRecruitChanged()
	self:_refreshTreeUI()
end

function RecruitLayer:updateTopRes(arg_52_1)
	if not arg_52_1.type then
		return
	end

	local var_52_0 = 20

	if arg_52_1.type == var_0_1.RECRUIT_TYPE.UNITE_TOKEN_NORMAL then
		var_52_0 = 22
	elseif arg_52_1.type == var_0_1.RECRUIT_TYPE.UNITE_TOKEN_LIMIT then
		var_52_0 = 23
	elseif arg_52_1.type == var_0_1.RECRUIT_TYPE.UNITE_TOKEN_OPEN_SERVER then
		var_52_0 = 22
	elseif arg_52_1.type == var_0_1.RECRUIT_TYPE.ARTIFACT_BASE then
		var_52_0 = 101
	elseif arg_52_1.type == var_0_1.RECRUIT_TYPE.ARTIFACT_LIMIT then
		var_52_0 = 135
	elseif arg_52_1.type == var_0_1.RECRUIT_TYPE.PRIMARY then
		var_52_0 = 0
	elseif arg_52_1.type == var_0_1.RECRUIT_TYPE.PET_BASE then
		var_52_0 = 195
	elseif arg_52_1.type == var_0_1.RECRUIT_TYPE.PET_LIMIT then
		var_52_0 = 195
	elseif arg_52_1.type == var_0_1.RECRUIT_TYPE.DAILY_RECRUIT then
		var_52_0 = g.core.const.ConstMgr.HelpConst.HELP_TYPE.DAILY_RECRUIT
	elseif arg_52_1.type == var_0_1.RECRUIT_TYPE.KNIGHT_SOUL_RECRUIT or arg_52_1.type == var_0_1.RECRUIT_TYPE.LIMIT_KNIGHT_SOUL_RECRUIT then
		var_52_0 = g.core.const.ConstMgr.HelpConst.HELP_TYPE.KNIGHT_SOUL_RECRUIT
	elseif arg_52_1.type == var_0_1.RECRUIT_TYPE.PRECIOUS then
		var_52_0 = 326
	elseif arg_52_1.type == var_0_1.RECRUIT_TYPE.RECRUIT_RETURN_KNIGHT then
		var_52_0 = 335
	elseif arg_52_1.type == var_0_1.RECRUIT_TYPE.RECRUIT_RETURN_ARTIFACT then
		var_52_0 = 362
	elseif arg_52_1.type == var_0_1.RECRUIT_TYPE.NEW_LIMIT_KNIGHT_RECRUIT then
		var_52_0 = 364
	elseif arg_52_1.type == var_0_1.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT then
		var_52_0 = 365
	elseif arg_52_1.type == var_0_1.RECRUIT_TYPE.RECRUIT_SUCCUBA then
		var_52_0 = 367
	elseif arg_52_1.type == var_0_1.RECRUIT_TYPE.RECRUIT_RESONATOR_CAPTAIN then
		var_52_0 = 76001
	elseif arg_52_1.useLimitLuck == true then
		var_52_0 = 21
	end

	if var_52_0 > 0 then
		self.m_topBarComp:setResInfoById(var_52_0)
	else
		self.m_topBarComp:updateTopRes({})
	end
end

function RecruitLayer:_preLoadNextLayer()
	local var_53_0 = self._content.recruitTypeNet and g.core.model.User.recruitData:getRecruitCfgByIdOrActId(self._content.recruitTypeNet) or g.core.model.User.recruitData:getRecruitKnightCfg(self._content.recruit_type)
	local var_53_1 = var_53_0.gacha_display_quality

	if var_53_0.gacha_display_quality <= self._highQuality then
		self._content.isHideRecruitBtn = self._cellData.type == var_0_1.RECRUIT_TYPE.PRIMARY
		self._content.cfg = var_53_0
		self._content.justShowResult = false
		self._content.callBack = handler(self, self.onLoad)

		self.m_ssrComp:updateComp(self._content, nil, var_53_1)
		self.m_ssrComp:pause()

		self._rewardComp = nil
	else
		local var_53_2 = clone(self._content)

		var_53_2.isPreLoad = true
		var_53_2.callBack = handler(self, self.onLoad)
		var_53_2.cfg = var_53_0
		var_53_2.matchQuality = var_53_1
		self._rewardComp = require("app.view.module.recruit.view.RecruitRewardLayer").new(var_53_2)

		self:addChild(self._rewardComp)
		self._rewardComp:setVisible(false)
	end
end

function RecruitLayer:_onUniteTokenRecruitResult(arg_54_1)
	if self._isShowReward then
		return
	end

	arg_54_1.cfg = g.core.model.User.recruitData:getRecruitKnightCfgById(self._curCellData.id)

	g.core.module.ModuleManager:pushPopup(require("app.view.module.recruit.view.uniteToken.RecruitUniteTokenShowPop").new(arg_54_1))

	if self._currentComp and self._currentComp.updateView then
		self._currentComp:updateView()
	end
end

function RecruitLayer:_getSelectTagById(arg_55_1)
	for iter_55_0, iter_55_1 in ipairs(self._tabCfgs) do
		for iter_55_2, iter_55_3 in ipairs(iter_55_1.subTree) do
			if iter_55_3.id == arg_55_1 then
				self._selectTag = iter_55_0 .. "_" .. iter_55_2

				break
			end
		end
	end
end

function RecruitLayer:_getSelectTagByType(arg_56_1)
	for iter_56_0, iter_56_1 in ipairs(self._tabCfgs) do
		for iter_56_2, iter_56_3 in ipairs(iter_56_1.subTree) do
			if iter_56_3.type == arg_56_1 then
				self._selectTag = iter_56_0 .. "_" .. iter_56_2

				break
			end
		end
	end
end

function RecruitLayer:_goToUnitTokenRecruit()
	self:_getSelectTagByType(var_0_1.RECRUIT_TYPE.UNITE_TOKEN_NORMAL)

	self._selectTag = nil

	self:setSelectTag(self._selectTag)
end

function RecruitLayer:_goToArtifactRecruit()
	self:_getSelectTagByType(var_0_1.RECRUIT_TYPE.ARTIFACT_BASE)

	self._selectTag = nil

	self:setSelectTag(self._selectTag)
end

function RecruitLayer:_goToPetRecruit()
	self:_getSelectTagByType(var_0_1.RECRUIT_TYPE.PET_BASE)

	self._selectTag = nil

	self:setSelectTag(self._selectTag)
end

function RecruitLayer:_goToDailyRecruit()
	self:_getSelectTagByType(var_0_1.RECRUIT_TYPE.DAILY_RECRUIT)

	self._selectTag = nil

	self:setSelectTag(self._selectTag)
end

function RecruitLayer:_goToPrimaryRecruit()
	self:_getSelectTagByType(var_0_1.RECRUIT_TYPE.PRIMARY)

	if self._selectTag == self._selectTag then
		return
	end

	self._selectTag = nil

	self:setSelectTag(self._selectTag)
end

function RecruitLayer:_goToKnightSoulRecruit()
	self:_getSelectTagByType(var_0_1.RECRUIT_TYPE.KNIGHT_SOUL_RECRUIT)

	if self._selectTag == self._selectTag then
		return
	end

	self._selectTag = nil

	self:setSelectTag(self._selectTag)
end

function RecruitLayer:_goToPreciousRecruit()
	self:_getSelectTagById(100018)

	if self._selectTag == self._selectTag then
		return
	end

	self._selectTag = nil

	self:setSelectTag(self._selectTag)
end

function RecruitLayer:_onContinueRecruit(arg_64_1)
	self._isShowReward = true
end

function RecruitLayer:_onRewardLayerOnRemoved()
	self._isShowReward = false
end

return RecruitLayer
