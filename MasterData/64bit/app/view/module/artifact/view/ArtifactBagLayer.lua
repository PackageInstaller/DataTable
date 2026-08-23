local var_0_0 = g.core.model.User
local var_0_1 = g.core.module.ModuleManager
local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local ArtifactBagLayer = class("ArtifactBagLayer", require("app.fairyGUI.artifact.UI_ArtifactBagLayer"), function()
	return fgui.GComponent:create({
		resName = "ArtifactBagLayer",
		pkgName = "artifact",
		isFullScreen = true,
		pkgPath = "ui/artifact/artifact"
	}, ...)
end)

function ArtifactBagLayer:ctor(arg_2_1)
	self._constColumnNum = self.m_bagList:getColumnCount()
	self._ownAndComposeArtifactData = {}
	self.emptyListItemEndIndex = 0
	self._notOwnLineItemEndIndex = 0
	self._notOwnArtifactData = {}
	self._totalItemNum = 0
	self._clearNewList = {}

	self:_initView()
end

function ArtifactBagLayer:_initView()
	self:addBg("bg/knightbag/pic_yht_beibao.jpg")
	self.m_topBarComp:setResInfoById(93)
	self.m_rebornBtn:addClickListener(handler(self, self._onRebornClick))
	self.m_handBookBtn:addClickListener(handler(self, self._onHandBookClick))
	self.m_formationBtn:addClickListener(handler(self, self._onFormationClick))
	self.m_recycleBtn:addClickListener(handler(self, self._onRecycleClick))
	self.m_guideBtn:addClickListener(handler(self, self._onClickGuideBtn))
	self.m_guideBtn:setVisible(g.core.common.ModuleUnlock:isFunctionUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.UR_PROPERTY, nil, true))
	self.m_bagList:setVirtual()
	self.m_bagList:doFairyBatching(false)
	self.m_bagList:setItemProvider(handler(self, self._setListItemProvider))
	self.m_bagList:setItemRenderer(handler(self, self._onItemRenderer))
end

function ArtifactBagLayer:onLoad(arg_4_1)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRAGMENT_COMPOSE, handler(self, self._onRcvArtifactFragmentCompose), self)
	self:_divisionListData()
	self:_updateView()
end

function ArtifactBagLayer:_updateView()
	self.m_numTxt:setText(self._ownNum)
	self.m_maxNumTxt:setText("/" .. self._ownNum + self._notOwnNum)
	self.m_bagList:setNumItems(self._totalItemNum)
	self.m_bagList:transitionShowCells("listCardAUiScaleIn", 0.1)
	self.m_bagList:scrollToView(0)
end

function ArtifactBagLayer:_divisionListData()
	self._ownAndComposeArtifactData = var_0_0.artifactData:getBagList()
	self._notOwnArtifactData = var_0_0.artifactData:getHasNotEnoughFragList()

	local var_6_0 = #self._ownAndComposeArtifactData

	self._ownNum = #self._ownAndComposeArtifactData

	local var_6_1 = 0

	if var_6_0 >= self._constColumnNum then
		var_6_1 = var_6_0 % self._constColumnNum

		if var_6_0 % self._constColumnNum > 0 then
			var_6_1 = self._constColumnNum - var_6_1
		end
	elseif var_6_0 > 0 then
		var_6_1 = self._constColumnNum - var_6_0
	end

	self.emptyListItemEndIndex = var_6_0 + var_6_1
	self._totalItemNum = self.emptyListItemEndIndex
	self._notOwnNum = #self._notOwnArtifactData

	if #self._notOwnArtifactData > 0 then
		self._notOwnLineItemEndIndex = self.emptyListItemEndIndex + self._constColumnNum
		self._totalItemNum = self._notOwnLineItemEndIndex + #self._notOwnArtifactData
	end
end

function ArtifactBagLayer:_onRebornClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.REBORN) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.REBORN, {
			index = require("app.view.module.reborn.const.RebornConst").SELECT_INDEX_MAP.ARTIFACT,
			title = g.core.lang:get(205518)
		})
	end
end

function ArtifactBagLayer:_onHandBookClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_HANDBOOK) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ARTIFACT_HANDBOOK)
	end
end

function ArtifactBagLayer:_onFormationClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.LINE_UP)
end

function ArtifactBagLayer:_onRecycleClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.FragSellPop").new(g.core.model.User.artifactData:getAllCanSellFrag(), {
		fragNameId = 205536,
		qualityArr = g.core.const.ConstMgr.QUALITY_TYPE.SELL_POP_QUALITY_ARRAY[g.core.const.ConstMgr.QUALITY_TYPE.NEW_QUALITY_CTRL.ARTIFACT],
		title = g.core.lang:get(205535),
		emptyTitle = g.core.lang:get(205537)
	})))
end

function ArtifactBagLayer:_onClickGuideBtn()
	var_0_1:pushPopup(require("app.view.module.guide.view.GuideCommonPopup").new({
		group = 1
	}), {
		touchDisappear = true
	})
end

function ArtifactBagLayer:_setListItemProvider(arg_12_1)
	local var_12_1 = arg_12_1 + 1

	return (arg_12_1 + 1 <= self._ownNum or var_12_1 > self._notOwnLineItemEndIndex) and "ui://artifact/ArtifactBagItemCell" or var_12_1 > self._ownNum and var_12_1 <= self.emptyListItemEndIndex and "ui://artifact/ArtifactBagItemEmptyCell" or var_12_1 == self.emptyListItemEndIndex + 1 and "ui://artifact/ArtifactBagLineCell" or "ui://artifact/ArtifactBagEmptyLineCell"
end

function ArtifactBagLayer:_onItemRenderer(arg_13_1, arg_13_2)
	local var_13_0

	if arg_13_1 + 1 <= self._ownNum or arg_13_1 + 1 > self._notOwnLineItemEndIndex then
		if arg_13_1 + 1 <= self._ownNum then
			var_13_0 = self._ownAndComposeArtifactData[arg_13_1 + 1]
			self._clearNewList[self._ownAndComposeArtifactData[arg_13_1 + 1]:getAdvanceId()] = true
		else
			var_13_0 = self._notOwnArtifactData[arg_13_1 + 1 - self._notOwnLineItemEndIndex]
		end
	end

	if var_13_0 then
		arg_13_2:updateItem(var_13_0)
	end
end

function ArtifactBagLayer:_onRcvArtifactFragmentCompose(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	self:_divisionListData()
	self:_updateView()

	local var_14_0 = g.core.config.fragment_info.get(arg_14_4.id)

	if var_14_0 then
		g.core.module.ModuleManager:awardSummary({
			{
				type = var_14_0.fragment_type,
				value = var_14_0.fragment_value,
				size = arg_14_4.num
			}
		})

		if arg_14_4.awards and next(arg_14_4.awards) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
				award = {
					autoDisappear = false,
					awards = arg_14_4.awards
				},
				removeFlag = {
					[1] = "award"
				}
			})
		end
	end
end

function ArtifactBagLayer:onUnload()
	if next(self._clearNewList) then
		for iter_15_0, iter_15_1 in pairs(self._clearNewList) do
			g.core.model.User.bagData:clearNewData(g.core.const.ConstMgr.BAG_TYPE.ARTIFACT, iter_15_0)
		end

		self._clearNewList = {}
	end
end

return ArtifactBagLayer
