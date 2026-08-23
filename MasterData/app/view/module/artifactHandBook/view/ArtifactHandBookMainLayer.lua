local var_0_0 = g.core.model.User.artifactHandBookData
local var_0_1 = {
	[0] = g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.JIAO_GUO,
	g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.LIN_DONG,
	g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.DONG_XI,
	g.core.const.ConstMgr.KNIGHT_CONST.GROUP_TYPE.LI_JIN
}
local ArtifactHandBookMainLayer = class("ArtifactHandBookMainLayer", require("app.fairyGUI.artifactHandbook.UI_ArtifactHandBookMainLayer"), function()
	return fgui.GComponent:create({
		resName = "ArtifactHandBookMainLayer",
		pkgPath = "ui/artifactHandbook/artifactHandbook",
		isFullScreen = true,
		pkgName = "artifactHandbook"
	}, ...)
end)

function ArtifactHandBookMainLayer:ctor(arg_2_1)
	self:addBg("bg/artifactHandbook/bg_gongmingtujian.jpg")

	self._selectIndex = 3
	self._curSelectData = nil
	self._selectQuality = 0
	self._selQualityState = false

	if arg_2_1 and arg_2_1.quality and (arg_2_1 and arg_2_1.quality) >= 4 then
		self.m_qualityController:setSelectedIndex(1)
	else
		self.m_qualityController:setSelectedIndex(0)
	end

	self._curUnlockId = nil
	self._firstIgnoreListAnim = true

	self.m_typeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSelectGroup))
	self.m_groupList:setVirtual()
	self.m_groupList:setItemRenderer(handler(self, self._onGroupListRenderer))
	self.m_bookList:setVirtual()
	self.m_bookList:setItemRenderer(handler(self, self._onURBookListRenderer))
	self.m_bookList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onListItemClick))

	self._URHandBookData = {}
	self._URHandBookOpenIndex = -1

	self.m_typeController:setSelectedIndex(self._selectIndex)
	self.m_qualityController:addEventListener(fgui.UIEventType.Changed, handler(self, self.updateShowView))
	self.m_touchPnl:setVisible(false)
	self.m_selectBtn:addClickListener(handler(self, self._onSelectQualityClick))
	self.m_touchPnl:addClickListener(handler(self, self._onTouchPnlClick))
	self.m_processBg:addClickListener(handler(self, self._onAdditionBtnClick))
	self.m_progressComp:addClickListener(handler(self, self._onClickProgressComp))
	self.m_oneKeyBtn:addClickListener(handler(self, self._onOneKeyBtnClick))
	self.m_topBarComp:setResInfoById(94)
	self.m_listTransition:setHook("change", handler(self, self._onListRefresh))
	self.m_enterTransition:setHook("enter", handler(self, self._onTabEnterTrans))
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_HANDBOOK)
	self.m_changeComp2:setVisible(var_0_0:hasURArtifactPut())
end

function ArtifactHandBookMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ARTIFACT_HANDBOOKACTIVATE, self._onActiveNetBack, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ARTIFACT_HANDBOOKUPGRADE, self._oLvUpNetBack, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ARTIFACT_URHANDBOOK_ACTIVE, self._onURActiveNetBack, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ARTIFACT_URHANDBOOK_UPGRADE, self._onURLvUpNetBack, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_HANDBOOK_ONEKEYUPGRADE, self._onRcvOneKeyUpgrade, self)
	self.m_enterTransition:play()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_changeComp2
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_changeComp
	})
end

function ArtifactHandBookMainLayer:_onTabEnterTrans()
	for iter_4_0 = 1, 4 do
		self["m_tab" .. iter_4_0]:playEnterAnim()
	end
end

function ArtifactHandBookMainLayer:_onActiveNetBack(arg_5_1, arg_5_2, arg_5_3)
	self._curUnlockId = arg_5_3.id

	local var_5_0 = g.core.config.artifact_compose_info.get(arg_5_3.id)

	if var_5_0.type == 2 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
			data = {
				info = var_5_0,
				closeCallback = handler(self, self._onItemFinish)
			},
			title = g.core.lang:get(205519),
			showComp = fgui.UIPackage:createObject("artifactHandbook", "ArtifactHandBookActiveFettersComp")
		}), {
			touchDisappear = true
		})
	elseif var_5_0.type == 1 then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.artifactHandBook.view.ArtifactHandBookActivePop").new({
			id = var_5_0.id,
			closeCallback = handler(self, self._onItemFinish)
		})))
	end

	self:updateShowView(true)
end

function ArtifactHandBookMainLayer:_oLvUpNetBack(arg_6_1, arg_6_2, arg_6_3)
	self._curUnlockId = arg_6_3.id

	local var_6_0 = g.core.config.artifact_compose_info.get(arg_6_3.id)

	if var_6_0.type == 2 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
			data = {
				info = var_6_0,
				lv = arg_6_3.level
			},
			title = g.core.lang:get(205519),
			showComp = fgui.UIPackage:createObject("artifactHandbook", "ArtifactHandBookActiveFettersComp")
		}), {
			touchDisappear = true
		})
	elseif var_6_0.type == 1 then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.artifactHandBook.view.ArtifactHandBookActivePop").new({
			id = var_6_0.id,
			lv = arg_6_3.level,
			cfg = var_6_0
		})))
	end

	self:updateShowView(true)
end

function ArtifactHandBookMainLayer:_onItemFinish()
	if not self._curUnlockId then
		return
	end

	for iter_7_0, iter_7_1 in ipairs((self.m_groupList:getChildren())) do
		iter_7_1:checkAndPlayUnlockAnim(self._curUnlockId)
	end

	self._curUnlockId = nil
end

function ArtifactHandBookMainLayer:receiveCompEvent(arg_8_1)
	local var_8_0 = {
		...
	}

	if arg_8_1 == "HandBookConfirm_Click" then
		self:_onTouchPnlClick()

		if self._selectQuality == var_8_0[1].quality then
			return
		end

		self._selectQuality = var_8_0[1].quality

		self:updateShowView()
	end
end

function ArtifactHandBookMainLayer:_onSelectGroup()
	self._selectIndex = self.m_typeController:getSelectedIndex()

	self:onSelectGroup(self._selectIndex)
end

function ArtifactHandBookMainLayer:onSelectGroup(arg_10_1)
	self._selectIndex = arg_10_1 or self._selectIndex

	self:updateShowView()
end

function ArtifactHandBookMainLayer:_onGroupListRenderer(arg_11_1, arg_11_2)
	arg_11_2:updateCompView(self._curSelectData[arg_11_1 + 1])
end

function ArtifactHandBookMainLayer:updateShowView(arg_12_1)
	if self.m_qualityController:getSelectedIndex() == 0 then
		local var_12_0, var_12_1, var_12_2 = g.core.model.User.artifactHandBookData:getAllBaseAdditions()

		self.m_curNumTxt:setText(var_12_1)
		self.m_allCountTxt:setText("/" .. var_12_2)

		self._curSelectData = g.core.model.User.artifactHandBookData:getHandBookByGroup(var_0_1[self._selectIndex], self._selectQuality)

		self:_updateOneKeyGroup()

		if self._firstIgnoreListAnim or arg_12_1 then
			self._firstIgnoreListAnim = false

			self:_onListRefresh()

			return
		end

		self:setTabTouchAble(false)
		self.m_listTransition:play(handler(self, self._onListTransPlayFinish))
	else
		g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_UR_HANDBOOK)
		self:updateURHandBookView()
		self:_updateOneKeyGroup()
	end
end

function ArtifactHandBookMainLayer:_updateOneKeyGroup()
	local var_13_0 = self.m_qualityController:getSelectedIndex()
	local var_13_1 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HANDBOOK_ONEKEY_ARTIFACT)

	if var_13_0 == 1 then
		var_13_1 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HANDBOOK_ONEKEY_ARTIFACT_UR)
	end

	local var_13_2, var_13_3, var_13_4 = var_0_0:getAllCanActiveOrUpgradeHandBookList(var_13_0 == 1)
	local var_13_5 = #var_13_2 > 0

	self.m_oneKeyController:setSelectedIndex((var_13_1 and var_13_5 and #var_13_3 <= 0 or nil) and 1)

	if not self._oneKeyEffSpine then
		local var_13_7 = self.m_oneKeyBtn:getSize()

		self._oneKeyEffSpine = self.m_oneKeyBtn:addEffectSpine({
			isLoop = true,
			name = "eff_ui_handbook_activatebtn",
			scale = 1,
			x = var_13_7.width / 2,
			y = var_13_7.height / 2
		})
	end

	self._oneKeyEffSpine:setVisible(var_13_5)
	self.m_oneKeyCostBg:setVisible(false)
	self.m_oneKeyCostComp:setVisible(false)
end

function ArtifactHandBookMainLayer:setTabTouchAble(arg_14_1)
	for iter_14_0 = 1, 4 do
		self["m_tab" .. iter_14_0]:setTouchable(arg_14_1)
	end
end

function ArtifactHandBookMainLayer:_onListTransPlayFinish()
	self:setTabTouchAble(true)
end

function ArtifactHandBookMainLayer:_onListRefresh()
	self.m_groupList:setNumItems(#self._curSelectData)
end

function ArtifactHandBookMainLayer:_onSelectQualityClick()
	if self._selQualityState then
		return
	end

	self.m_touchPnl:setVisible(true)

	self._selQualityState = true

	self.m_pnlEnterTransition:play()
end

function ArtifactHandBookMainLayer:_onTouchPnlClick()
	if self._selQualityState then
		self.m_touchPnl:setVisible(false)

		self._selQualityState = false

		self.m_pnlEnterTransition:playReverse()
	end
end

function ArtifactHandBookMainLayer:_onAdditionBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.artifactHandBook.view.ArtifactHandBookAdditionPop").new(), {
		touchDisappear = true,
		hideContinue = true
	})
end

function ArtifactHandBookMainLayer:updateURHandBookView()
	self._URHandBookData = var_0_0:getURHandBook()

	self.m_bookList:setNumItems(#self._URHandBookData)

	self._oldScore = var_0_0:getURHandBookScore()
	self._oldLevel = var_0_0:getURHandBookLv()

	self.m_progressComp:updateView()

	if self._URHandBookOpenIndex ~= -1 then
		local var_20_0 = g.core.model.User.knightsData:getKnightByAdvanceId((self._URHandBookData[self._URHandBookOpenIndex + 1].struct:getBelongToKnightAvdIdIncludingMainRole()))

		self.m_knightBelongComp:setIcon(g.core.common.Path:getMiddleKnightPicById(var_20_0:getResInfo().painted_id))

		local var_20_1 = var_20_0:getResInfo().quality + 1

		self.m_belongdownLoader:setURL("ui://artifactHandbook/pic_tujian_" .. var_20_1 .. "_title_2")
		self.m_belongupLoader:setURL("ui://artifactHandbook/pic_tujian_" .. var_20_1 .. "_title_1")
	end
end

function ArtifactHandBookMainLayer:_onURBookListRenderer(arg_21_1, arg_21_2)
	arg_21_2:updateURArtifactHandBook(self._URHandBookData[arg_21_1 + 1], self._URHandBookOpenIndex == arg_21_1)
end

function ArtifactHandBookMainLayer:_onListItemClick(arg_22_1)
	local var_22_0 = arg_22_1:getDataValue()

	if self._URHandBookOpenIndex == var_22_0 then
		self._URHandBookOpenIndex = -1

		self.m_knightBelongComp:setIcon("")
	else
		self._URHandBookOpenIndex = var_22_0

		local var_22_1 = g.core.model.User.knightsData:getKnightByAdvanceId((self._URHandBookData[self._URHandBookOpenIndex + 1].struct:getBelongToKnightAvdIdIncludingMainRole()))

		self.m_knightBelongComp:setIcon(g.core.common.Path:getMiddleKnightPicById(var_22_1:getResInfo().painted_id))
		self.m_belongdownLoader:setURL("ui://artifactHandbook/pic_tujian_" .. var_22_1:getResInfo().quality + 1 .. "_title_2")
		self.m_belongupLoader:setURL("ui://artifactHandbook/pic_tujian_" .. var_22_1:getResInfo().quality + 1 .. "_title_1")
	end

	self.m_bookList:setNumItems(#self._URHandBookData)
end

function ArtifactHandBookMainLayer:_onClickProgressComp()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.artifactHandBook.view.ArtifactHandBookAchievementPop").new(), {
		touchDisappear = true,
		hideContinue = true
	})
end

function ArtifactHandBookMainLayer:_onOneKeyBtnClick()
	local var_24_0 = self.m_qualityController:getSelectedIndex()
	local var_24_1 = g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.HANDBOOK_ONEKEY_ARTIFACT)

	if not ((var_24_0 == 1 or nil) and g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.HANDBOOK_ONEKEY_ARTIFACT_UR)) then
		return
	end

	local var_24_2 = var_0_0:getAllCanActiveOrUpgradeHandBookCostData()

	if var_24_0 == 0 and var_24_2.minSize and var_24_2.minSize > 0 and g.core.model.User.bagData:getOwnNum(var_24_2.type, var_24_2.value) < var_24_2.minSize then
		g.core.module.ModuleManager:tip(g.core.lang:get(205576))

		return
	end

	local var_24_3, var_24_4, var_24_5 = var_0_0:getAllCanActiveOrUpgradeHandBookList(var_24_0 == 1)

	if #var_24_5 == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(205575))
	elseif var_24_0 == 0 then
		g.core.network.GameNetProxy:send_C2S_Handbook_OneKeyUpgrade({
			tp = g.core.network.proto.ARTIFACT_HB,
			ids = var_24_5
		})
	elseif var_24_0 == 1 then
		g.core.network.GameNetProxy:send_C2S_Handbook_OneKeyUpgrade({
			tp = g.core.network.proto.UR_ARTIFACT_HB,
			ids = var_24_5
		})
	end
end

function ArtifactHandBookMainLayer:_onURActiveNetBack(arg_25_1, arg_25_2, arg_25_3)
	self._curUnlockId = arg_25_3.id

	local var_25_0 = var_0_0:getURHandBookLv()
	local var_25_1

	if var_25_0 ~= self._oldLevel then
		local var_25_2 = self._oldScore

		function var_25_1()
			g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
				data = {
					oldScore = var_25_2
				},
				title = g.core.lang:get(205570),
				showComp = fgui.UIPackage:createObject("artifactHandbook", "ArtifactHandBookLvUpComp")
			}), {
				touchDisappear = true,
				hideContinue = false
			})
		end
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.module.artifactHandBook.view.ArtifactHandBookActivePop").new({
		isUR = true,
		id = arg_25_3.id,
		closeCallback = var_25_1
	})))
	self:updateShowView()

	self._oldScore = var_0_0:getURHandBookScore()
	self._oldLevel = var_25_0
end

function ArtifactHandBookMainLayer:_onURLvUpNetBack(arg_27_1, arg_27_2, arg_27_3)
	self._curUnlockId = arg_27_3.id

	local var_27_0 = var_0_0:getURHandBookLv()
	local var_27_1

	if var_27_0 ~= self._oldLevel then
		local var_27_2 = self._oldScore

		function var_27_1()
			g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
				data = {
					oldScore = var_27_2
				},
				title = g.core.lang:get(205570),
				showComp = fgui.UIPackage:createObject("artifactHandbook", "ArtifactHandBookLvUpComp")
			}), {
				touchDisappear = true,
				hideContinue = false
			})
		end
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.module.artifactHandBook.view.ArtifactHandBookActivePop").new({
		isUR = true,
		id = arg_27_3.id,
		new_id = arg_27_3.new_id,
		closeCallback = var_27_1
	})))
	self:updateShowView()

	self._oldScore = var_0_0:getURHandBookScore()
	self._oldLevel = var_27_0
end

function ArtifactHandBookMainLayer:_onRcvOneKeyUpgrade(arg_29_1, arg_29_2, arg_29_3)
	if arg_29_3.tp == g.core.network.proto.ARTIFACT_HB then
		if arg_29_3.ids and #arg_29_3.ids > 0 then
			self._curUnlockId = arg_29_3.ids[#arg_29_3.ids]

			local var_29_0 = 0
			local var_29_1 = g.core.config.artifact_compose_info.get(arg_29_3.ids[#arg_29_3.ids])

			for iter_29_0, iter_29_1 in ipairs(arg_29_3.hb or {}) do
				if var_29_1.advance_code == g.core.config.artifact_compose_info.get(iter_29_1.id).advance_code then
					var_29_0 = iter_29_1.level
				end
			end

			if var_29_1.type == 2 then
				local var_29_2 = {
					info = var_29_1,
					lv = var_29_0
				}
				local var_29_3

				if var_29_0 == 0 then
					var_29_2 = {
						info = var_29_1,
						closeCallback = handler(self, self._onItemFinish)
					}
					var_29_3 = require("app.view.base.show.BaseFeedBackPopNew").new
				end

				g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
					data = var_29_2,
					title = g.core.lang:get(205519),
					showComp = fgui.UIPackage:createObject("artifactHandbook", "ArtifactHandBookActiveFettersComp")
				}), {
					touchDisappear = true
				})
			elseif var_29_1.type == 1 then
				g.core.module.ModuleManager:pushPopup((require("app.view.module.artifactHandBook.view.ArtifactHandBookActivePop").new((var_29_0 == 0 or nil) and {
					id = var_29_1.id,
					closeCallback = handler(self, self._onItemFinish)
				})))
			end
		end

		self:updateShowView(true)
	elseif arg_29_3.tp == g.core.network.proto.UR_ARTIFACT_HB then
		if arg_29_3.ids and #arg_29_3.ids > 0 then
			self._curUnlockId = arg_29_3.ids[#arg_29_3.ids]

			local var_29_5 = g.core.config.artifact_compose_advanced_info.get(arg_29_3.ids[#arg_29_3.ids])
			local var_29_6

			for iter_29_2, iter_29_3 in ipairs(arg_29_3.hb or {}) do
				if var_29_5.advance_code == g.core.config.artifact_compose_advanced_info.get(iter_29_3.id).advance_code and iter_29_3.id ~= arg_29_3.ids[#arg_29_3.ids] then
					var_29_6 = var_29_6 and math.max(var_29_6, iter_29_3.id) or iter_29_3.id
				end
			end

			local var_29_7 = var_0_0:getURHandBookLv()
			local var_29_8

			if var_29_7 ~= self._oldLevel then
				local var_29_9 = self._oldScore

				function var_29_8()
					g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
						data = {
							oldScore = var_29_9
						},
						title = g.core.lang:get(205570),
						showComp = fgui.UIPackage:createObject("artifactHandbook", "ArtifactHandBookLvUpComp")
					}), {
						touchDisappear = true,
						hideContinue = false
					})
				end
			end

			g.core.module.ModuleManager:pushPopup((require("app.view.module.artifactHandBook.view.ArtifactHandBookActivePop").new({
				isUR = true,
				id = arg_29_3.ids[#arg_29_3.ids],
				new_id = var_29_6,
				closeCallback = var_29_8
			})))
			self:updateShowView()

			self._oldScore = var_0_0:getURHandBookScore()
			self._oldLevel = var_29_7
		else
			self:updateShowView()
		end
	end
end

return ArtifactHandBookMainLayer
