local var_0_0 = g.core.model.User.echoLabData
local var_0_1 = g.core.const.ConstMgr.GuideConst
local EchoLabCollectLayer = class("EchoLabCollectLayer", require("app.fairyGUI.echoLab.UI_EchoLabCollectLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgName = "echoLab",
		resName = "EchoLabCollectLayer",
		pkgPath = "ui/echoLab/echoLab"
	}, ...)
end)

function EchoLabCollectLayer:ctor(arg_2_1, arg_2_2)
	self._buildStructs = var_0_0:getCollectData():getBuildInfoList()
	self._curBuildStruct = nil
	self._cardTypeList = nil
	self._curCardList = nil
	self._isFirst = true
	self._checkPopName = nil
	arg_2_1 = arg_2_1 or 0
	self._selectIdxInfo = {
		buildIdx = arg_2_1,
		subIdxList = {
			0,
			0
		}
	}
	self._selectIdxInfo.subIdxList[arg_2_1 + 1] = arg_2_2 or 0

	self:_initView()
	self:_onCheckFirstEnter()
end

function EchoLabCollectLayer:_initView()
	self:addBg("bg/echoLab/bg_echo_tujian.jpg")
	self.m_topBarComp:setResInfoById(249)
	self.m_attrBtn:addClickListener(handler(self, self._onAttrBtnClick))
	self.m_cardList:setVirtual(self)
	self.m_cardList:doFairyBatching(false)
	self.m_cardList:setItemRenderer(handler(self, self._onCardItemRender))
	self.m_cardList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onCardItemClick))
	self.m_typeTabList:setVirtual(self)
	self.m_typeTabList:doFairyBatching(false)
	self.m_typeTabList:setItemRenderer(handler(self, self._onTypeTabItemRender))
	self.m_typeTabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTypeTabItemClick))
	self.m_buildTabList:setVirtual(self)
	self.m_buildTabList:doFairyBatching(false)
	self.m_buildTabList:setItemRenderer(handler(self, self._onBuildTabItemRender))
	self.m_buildTabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onBuildTabItemClick))
	self.m_oneKeyUpgrage:addClickListener(handler(self, self._onOneKeyUpgrageClick))
end

function EchoLabCollectLayer:_onCheckFirstEnter()
	for iter_4_0, iter_4_1 in ipairs(self._buildStructs) do
		if not iter_4_1:isReceiveNetInfo() then
			g.core.network.GameNetProxy:send_C2S_Palace_FirstEnterBuild({
				build_type = iter_4_1:getCfgByLevel(1).build_type
			})
		end
	end
end

function EchoLabCollectLayer:_addCustomListeners()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PALACE_GETINFO, handler(self, self._updateView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PALACE_FIRSTENTERBUILD, handler(self, self._updateView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PALACE_UPGRADECOMPOSE, handler(self, self._onUpgradeCardSuccess), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PALACE_ACTIVECOMPOSE, handler(self, self._onActiveCardSuccess), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PALACE_GETHANGUPAWARD, handler(self, self._onGetHangupAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PALACE_ONEKEYUPGRADECOMPOSE, handler(self, self._onOneKeyUpgradeCardSuccess), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_ECHO_LAB_COLLECT_POP_END, handler(self, self.showMask), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_ECHO_LAB_COLLECT_PRO_AMIN_END, handler(self, self.hideMask), self)
end

function EchoLabCollectLayer:onLoad()
	var_0_0:getCollectData():checkBuildPutCardList()
	self:_addCustomListeners()
	self:_updateView()
	self:_checkCollectTipsGuide()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_SELECTMENU_OPEN)
end

function EchoLabCollectLayer:_playEffect()
	self.m_enterTransition:play()
	self.m_effectNode:addEffectSpine({
		name = "eff_ui_echoLabCollect_enter",
		isLoop = false,
		remove = true
	})
	self:newScheduleOnce(handler(self, self._playCellsEffect), 0.8)
end

function EchoLabCollectLayer:_playCellsEffect()
	for iter_8_0, iter_8_1 in ipairs((self.m_cardList:getChildren())) do
		iter_8_1:onEnterEffect()
	end
end

function EchoLabCollectLayer:_onBuildTabItemRender(arg_9_1, arg_9_2)
	arg_9_2:updateView(self._buildStructs[arg_9_1 + 1])
end

function EchoLabCollectLayer:_onBuildTabItemClick()
	local var_10_0 = self.m_buildTabList:getSelectedIndex()

	self._selectIdxInfo.buildIdx = var_10_0
	self._curBuildStruct = self._buildStructs[var_10_0 + 1]

	self.m_levelCardComp:updateView(self._curBuildStruct)

	self._cardTypeList = self._curBuildStruct:getCardTypeList()

	self.m_typeTabList:setNumItems(#self._cardTypeList)
	self.m_typeTabList:setSelectedIndex(self._selectIdxInfo.subIdxList[var_10_0 + 1])
	self:_onTypeTabItemClick()

	if self._isFirst or self._selectIdxInfo.buildIdx ~= var_10_0 then
		self:_playEffect()
	end

	self._isFirst = false
end

function EchoLabCollectLayer:_onTypeTabItemRender(arg_11_1, arg_11_2)
	local var_11_0 = self._cardTypeList[arg_11_1 + 1][1]:getCardType()

	arg_11_2:setTitle(g.core.lang:get(408700 + var_11_0))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = arg_11_2:getChild("redPointComp"),
		customData = {
			cardType = var_11_0
		}
	})
end

function EchoLabCollectLayer:_onTypeTabItemClick()
	local var_12_0 = self.m_typeTabList:getSelectedIndex()

	self._selectIdxInfo.subIdxList[self._selectIdxInfo.buildIdx + 1] = var_12_0
	self._curCardList = self._cardTypeList[var_12_0 + 1]

	var_0_0:getCollectData():sortOneCardList(self._curCardList)
	self.m_cardList:setNumItems(#self._curCardList)
	self.m_cardList:scrollToView(0)
	self:_setOneKeyUpgradeBtnVisible()
	self.m_levelCardComp:updateTimesTip(self._curCardList[1]:getCardType())
end

function EchoLabCollectLayer:_onCardItemRender(arg_13_1, arg_13_2)
	arg_13_2:updateView(self._curCardList[arg_13_1 + 1], arg_13_1 + 1 <= (math.ceil(#self._curCardList / 2) - 1) * 2)
end

function EchoLabCollectLayer:_onCardItemClick()
	self:_onPopCardDetailPop(self._curCardList[self.m_cardList:getSelectedIndex() + 1])
end

function EchoLabCollectLayer:_updateView()
	self.m_buildTabList:setNumItems(#self._buildStructs)
	self.m_buildTabList:setSelectedIndex(self._selectIdxInfo.buildIdx or 0)
	self:_onBuildTabItemClick()
	self:_setOneKeyUpgradeBtnVisible()
end

function EchoLabCollectLayer:_setOneKeyUpgradeBtnVisible()
	self.m_oneKeyUpgrage:setVisible((g.core.model.User.echoLabData:getCollectData():isCardCanUpgrade({
		cardType = self._cardTypeList[self.m_typeTabList:getSelectedIndex() + 1][1]:getCardType()
	})))
end

function EchoLabCollectLayer:_onPopCardDetailPop(arg_17_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.echoLab.view.collect.pop.EchoLabCollectCardPop").new(arg_17_1), {
		touchDisappear = true
	})
end

function EchoLabCollectLayer:_onAttrBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.echoLab.view.collect.pop.EchoLabCollectAttrShowPop").new((var_0_0:getCollectData():getAllBuildAttrInfoDesList())), {
		touchDisappear = false
	})
end

function EchoLabCollectLayer:_onOneKeyUpgrageClick()
	local var_19_0 = {}

	var_19_0.ids = var_0_0:getCollectData():getCanUpgradeCardIdList((self._cardTypeList[self.m_typeTabList:getSelectedIndex() + 1][1]:getCardType()))

	g.core.network.GameNetProxy:send_C2S_Palace_OneKeyUpgradeCompose(var_19_0)
end

function EchoLabCollectLayer:_onActiveCardSuccess(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		award = {
			awards = arg_20_4.award
		}
	})

	local var_20_0 = var_0_0:getCollectData():getCardStructById(arg_20_4.id)

	self._checkPopName = "EchoLabCollectAttrUpPop"

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		frontShow = {
			{
				flag = "echoCardActive",
				func = function()
					return g.core.module.ModuleManager:pushPopup(require("app.view.module.echoLab.view.collect.pop.EchoLabCollectAttrUpPop").new(var_20_0, true), {
						touchDisappear = true
					})
				end
			}
		}
	})
	self:_updateView()
end

function EchoLabCollectLayer:_onUpgradeCardSuccess(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		award = {
			awards = arg_22_4.award
		}
	})

	local var_22_0 = var_0_0:getCollectData():getCardStructById(arg_22_4.id)

	self._checkPopName = "EchoLabCollectAttrUpPop"

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		frontShow = {
			{
				flag = "echoCardUpgrade",
				func = function()
					return g.core.module.ModuleManager:pushPopup(require("app.view.module.echoLab.view.collect.pop.EchoLabCollectAttrUpPop").new(var_22_0), {
						touchDisappear = true
					})
				end
			}
		}
	})
	self:_updateView()
end

function EchoLabCollectLayer:_onOneKeyUpgradeCardSuccess(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		award = {
			awards = arg_24_4.award
		}
	})

	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_4.ids) do
		local var_24_1 = var_0_0:getCollectData():getCardStructById(iter_24_1)

		table.insert(var_24_0, {
			flag = "echoCardUpgrade",
			func = function()
				return g.core.module.ModuleManager:pushPopup(require("app.view.module.echoLab.view.collect.pop.EchoLabCollectAttrUpPop").new(var_24_1, false, true), {
					touchDisappear = true
				})
			end
		})
	end

	self._checkPopName = "EchoLabCollectAttrUpPop"

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		frontShow = var_24_0
	})
	self:_updateView()
end

function EchoLabCollectLayer:_checkAllBuildStructLevelUpAndPop()
	for iter_26_0, iter_26_1 in ipairs(self._buildStructs) do
		self:_checkAndPopBuildUpPop(iter_26_1)
	end
end

function EchoLabCollectLayer:_checkAndPopBuildUpPop(arg_27_1)
	if arg_27_1:getLastLevel() ~= arg_27_1:getLevel() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
			showNow = true,
			frontShow = {
				{
					flag = "echoBuildUp",
					func = function()
						return require("app.view.module.show.ShowFactory"):showEchoLabCollectBuildUp(arg_27_1)
					end
				}
			}
		})
		arg_27_1:resetLastLevel()
	end
end

function EchoLabCollectLayer:_onGetHangupAward(arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		award = {
			awards = arg_29_4.awards
		}
	})
	self:_updateView()
end

function EchoLabCollectLayer:receiveCompEvent(arg_30_1, arg_30_2)
	if arg_30_1 == "echoLabCollectTipPopEnd" then
		if arg_30_2.name == self._checkPopName then
			self._checkPopName = nil
		end

		return true
	end

	return false
end

function EchoLabCollectLayer:showMask()
	if not self._checkPopName then
		self.m_mask:setVisible(true)
		self.m_levelCardComp:playProAmin()
	end
end

function EchoLabCollectLayer:hideMask()
	self.m_mask:setVisible(false)
	self:_checkAllBuildStructLevelUpAndPop()
end

function EchoLabCollectLayer:_checkCollectTipsGuide()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	if not g.core.model.User.guideData:getServerDataById(var_0_1.SAVE_SERVER_DATA_IDS.ECHOLAB_FIRST_ENTER_COLLECT) then
		g.core.model.User.guideData:setSaveServerData(var_0_1.SAVE_SERVER_DATA_IDS.ECHOLAB_FIRST_ENTER_COLLECT)
		self:newScheduleOnce(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
				key = "ECHOLAB_ENTER_COLLECT",
				objects = {
					self.m_buildTabList,
					self.m_cardList,
					self.m_levelCardComp
				}
			})
		end, 0)
	end
end

return EchoLabCollectLayer
