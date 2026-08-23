local var_0_0 = g.core.const.ConstMgr.BaseShowTypeConst
local var_0_1 = g.core.model.User.treeData
local var_0_2 = g.core.const.ConstMgr.TreeConst
local var_0_3 = 30
local TreeMainLayer = class("TreeMainLayer", require("app.fairyGUI.tree.UI_TreeMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "tree",
		isFullScreen = true,
		pkgPath = "ui/tree/tree",
		resName = "TreeMainLayer"
	}, ...)
end)

function TreeMainLayer:ctor()
	self._curSelectNode = nil
	self._touchBeginNode = nil

	self:initView()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.TREE)
end

function TreeMainLayer:initView()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.TREE, nil, {
		{
			value = 124,
			type = 3
		}
	})
	self.m_attrBtn:addClickListener(handler(self, self._onClickAttrButton))
	self.m_headBtn:addClickListener(handler(self, self._onClickHeadButton))
	self.m_isShowInfoController:addEventListener(fgui.UIEventType.Changed, function()
		if self.m_isShowInfoController:getSelectedIndex() == 1 then
			self.m_infoComp:setVisible(true)
		else
			self.m_infoComp:setVisible(false)
		end
	end)
end

function TreeMainLayer:_onTouchBegin(arg_5_1)
	local var_5_0 = arg_5_1:getInput():getTouch()

	if not var_5_0 then
		return
	end

	local var_5_1 = var_5_0:getLocation()

	if self.m_infoComp:containPoint(var_5_1) then
		return
	end

	self._prevTouchPos = var_5_1
	self._isTouched = true

	if not self._touchBeginNode then
		self.m_isShowInfoController:setSelectedIndex(0)
		self.m_mapComp:setSelectNode(self._curSelectNode, false)
	end

	arg_5_1:captureTouch()
end

function TreeMainLayer:_onTouchMove(arg_6_1)
	if not self._isTouched then
		return
	end

	if not self._isScroll then
		if math.abs(self._prevTouchPos.x - arg_6_1:getInput():getTouch():getLocation().x) >= var_0_3 then
			self._isScroll = true

			self.m_isShowInfoController:setSelectedIndex(0)
			self.m_mapComp:setSelectNode(self._curSelectNode, false)
		else
			return
		end
	end
end

function TreeMainLayer:_onTouchEnd(arg_7_1)
	self._touchBeginNode = nil
	self._isScroll = false
end

function TreeMainLayer:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == var_0_2.EVENT.NODE_CLICK then
		self:gotoNodeInfo(arg_8_2.pos, arg_8_2.nodeStruct)
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallClick)
	elseif arg_8_1 == var_0_2.EVENT.NODE_TOUCH_BEGIN then
		self._touchBeginNode = arg_8_2.nodeStruct
	elseif arg_8_1 == var_0_2.EVENT.NODE_GOTO then
		self:gotoNodeInfo(self.m_mapComp:getNodePos(arg_8_2.nodeStruct:getAdvanceId()), arg_8_2.nodeStruct)
	end
end

function TreeMainLayer:gotoNodeInfo(arg_9_1, arg_9_2)
	arg_9_1.x = arg_9_1.x + 200

	self.m_mapComp:jumpToPos(arg_9_1)
	self.m_mapComp:setSelectNode(self._curSelectNode, false)

	self._curSelectNode = arg_9_2

	self.m_mapComp:setSelectNode(self._curSelectNode, true)
	self.m_isShowInfoController:setSelectedIndex(1)
	self.m_infoComp:updateNode(self._curSelectNode)
	self.m_switchTransition:play()
end

function TreeMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TREE_NODE_UPSTAGE, handler(self, self._onUpgradeStage), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TREE_NODE_LEVELUP, handler(self, self._onUpgradeLevel), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.TREE_GOTO_NODE, handler(self, self._gotoNode), self)
	self.m_mapComp:updateView()
end

function TreeMainLayer:_gotoNode(arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3.nodeStruct then
		self:gotoNodeInfo(self.m_mapComp:getNodePos(arg_11_3.nodeStruct:getAdvanceId()), arg_11_3.nodeStruct)
	end
end

function TreeMainLayer:_onUpgradeStage(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = var_0_1:getNodeByAdvanceId(arg_12_4.advance_id)

	self.m_infoComp:setTouchable(false)
	self.m_mapComp:updateStageUpNode(var_12_0)

	if var_12_0:getNodeType() == var_0_2.NODE_TYPE.BIG then
		for iter_12_0, iter_12_1 in pairs(var_0_2.CENTER_ID) do
			if math.abs(arg_12_4.advance_id - iter_12_1) <= var_0_2.CENTER_LENGTH then
				self.m_mapComp:updateBigNodeUpCenterNode(iter_12_0, var_12_0)

				break
			end
		end
	end

	self:newScheduleOnce(function()
		if arg_12_4.tree_node.node_stage == 1 then
			self:popUpgradePop(var_12_0, true)
		else
			self:popUpgradePop(var_12_0, false)
		end

		self.m_switchTransition:play()
		self.m_infoComp:updateNode()
		self.m_infoComp:setTouchable(true)
	end, 1)
end

function TreeMainLayer:popUpgradePop(arg_14_1, arg_14_2)
	local var_14_0 = ""
	local var_14_1 = ""

	if arg_14_2 then
		var_14_0 = g.core.lang:get(426515)

		if arg_14_1:getNodeType() == var_0_2.NODE_TYPE.SMALL then
			var_14_1 = "TreeSmallLightComp"
		elseif arg_14_1:getNodeType() == var_0_2.NODE_TYPE.BIG then
			var_14_1 = "TreeBigLightComp"
		elseif arg_14_1:getNodeType() == var_0_2.NODE_TYPE.CENTER then
			var_14_1 = "TreeCenterLightComp"
		end
	else
		var_14_1 = "TreeSmallUpgradeComp"

		if arg_14_1:getQuality() > arg_14_1:getBeforeStageInfo().node_quality then
			var_14_0 = g.core.lang:get(426516)

			if arg_14_1:getNodeType() == var_0_2.NODE_TYPE.BIG then
				var_14_1 = "TreeBigQualityUpComp"
			elseif arg_14_1:getNodeType() == var_0_2.NODE_TYPE.CENTER then
				var_14_1 = "TreeCenterQualityUpComp"
			end
		else
			var_14_0 = g.core.lang:get(426517)

			if arg_14_1:getNodeType() == var_0_2.NODE_TYPE.BIG then
				var_14_1 = "TreeBigStageUpComp"
			end
		end
	end

	if var_14_1 == "" then
		return
	end

	local var_14_2 = {}

	var_14_2.touchDisappear = true
	var_14_2.hideContinue = true
	var_14_2.blackOpacity = 0.7
	var_14_2.withoutAni = true
	var_14_2.ignoreTouch = true

	g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
		autoDisappear = false,
		title = var_14_0,
		showComp = fgui.UIPackage:createObject("tree", var_14_1),
		nodeStruct = arg_14_1
	}), var_14_2)
end

function TreeMainLayer:_onUpgradeLevel(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	self.m_infoComp:updateNode()
	self.m_mapComp:updateLevelUpNode((var_0_1:getNodeByAdvanceId(arg_15_4.advance_id)))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = var_0_0.TREE_UPGRADE
		}
	})
end

function TreeMainLayer:_onClickAttrButton()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.tree.view.TreeBoostOverViewPop").new())
end

function TreeMainLayer:_onClickHeadButton()
	self.m_mapComp:jumpToCenter()
end

function TreeMainLayer:onRemoved()
	self.m_mapComp:onRemoved()
end

return TreeMainLayer
