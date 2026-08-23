local RobTreasureMainLayer = class("RobTreasureMainLayer", require("app.fairyGUI.robTreasure.UI_RobTreasureMainLayer"), function()
	return fgui.GComponent:create({
		resName = "RobTreasureMainLayer",
		pkgPath = "ui/robTreasure/robTreasure",
		isFullScreen = true,
		pkgName = "robTreasure"
	}, ...)
end)
local var_0_1 = g.core.config.treasure_info
local var_0_2 = g.core.config.explore_treasure_info
local var_0_3 = g.core.const.ConstMgr.RobTreasureConst

function RobTreasureMainLayer:ctor(arg_2_1)
	if arg_2_1 then
		self._curSelectTreasureId = arg_2_1.id or 0
	end

	if arg_2_1 and arg_2_1.goods then
		self._curSelectTreasureId = arg_2_1.goods.value or 0
	end

	self._treasureData = {}
	self._curSelectTreasIndex = 0
	self._treasureCompNum = 1
	self._selectedCompIndex = 0
	self._composeNum = 0
	self._battleResult = nil
	self._isFirstEnter = true

	self:_initView()
	self:_addListener()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._waitState = true

	g.core.common.Scheduler:newScheduleOnce(function()
		self._waitState = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	end, 0.5)
end

function RobTreasureMainLayer:_initView()
	self.m_topBar:setHelpId(g.core.const.ConstMgr.HelpConst.HELP_TYPE.ROB_TREASURE)
end

function RobTreasureMainLayer:_addListener()
	self:addListen(self.m_treasureComp)
	self.m_taskBtn:addClickListener(handler(self, self._onClickTask))
	self.m_shopBtn:addClickListener(handler(self, self._onClickShop))
	self.m_lastBtn:addClickListener(handler(self, self._onClickLast))
	self.m_nextBtn:addClickListener(handler(self, self._onClickNext))
end

function RobTreasureMainLayer:_onClickTask()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.robTreasure.view.RobTreasureTaskPop").new()))
end

function RobTreasureMainLayer:_onClickShop()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.BW
	})
end

function RobTreasureMainLayer:_onClickLast()
	self._selectedCompIndex = math.floor(self._selectedCompIndex - 1, 0)

	self.m_treasureComp:updateIndex(self._selectedCompIndex)
	self:_refreshChangePageBtn()
end

function RobTreasureMainLayer:_onClickNext()
	self._selectedCompIndex = math.ceil(self._selectedCompIndex + 1, self._treasureCompNum)

	self.m_treasureComp:updateIndex(self._selectedCompIndex)
	self:_refreshChangePageBtn()
end

function RobTreasureMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD, self._onArenaGetTaskAward, self)
	g.core.network.GameNetProxy:send_C2S_GetModuleTaskInfo({
		module_id = g.core.const.ConstMgr.TaskConst.MODULE_ID.ROB
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
	self:_initData()
end

function RobTreasureMainLayer:_initData(arg_11_1)
	self._treasureData = {}

	for iter_11_0 = 1, var_0_1.getLength() do
		local var_11_0 = var_0_1.indexOf(iter_11_0)

		if var_11_0.mapp_id == 0 then
			local var_11_1, var_11_2 = self:_createTreasureData(var_11_0)

			if var_11_2 then
				table.insert(self._treasureData, var_11_1)
			end
		end
	end

	if not arg_11_1 then
		table.sort(self._treasureData, function(arg_12_0, arg_12_1)
			if arg_12_0.compose ~= arg_12_1.compose then
				return arg_12_0.compose > arg_12_1.compose
			end

			if arg_12_0.quality ~= arg_12_1.quality then
				return arg_12_0.quality > arg_12_1.quality
			end

			if arg_12_0.id ~= arg_12_1.id then
				return arg_12_0.id < arg_12_1.id
			end
		end)
	else
		table.sort(self._treasureData, function(arg_13_0, arg_13_1)
			if arg_13_0.quality ~= arg_13_1.quality then
				return arg_13_0.quality > arg_13_1.quality
			end

			if arg_13_0.id ~= arg_13_1.id then
				return arg_13_0.id < arg_13_1.id
			end
		end)
	end

	self._curSelectTreasIndex = self:_getCurSelectIndex()
	self._treasureCompNum = math.ceil(#self._treasureData / var_0_3.MAX_SHOW_TREASURE_NUM)
	self._selectedCompIndex = math.floor((self._curSelectTreasIndex - 1) / var_0_3.MAX_SHOW_TREASURE_NUM)

	self.m_treasureComp:updateComp({
		treasureList = self._treasureData,
		index = self._selectedCompIndex,
		selectTreasIndex = self._curSelectTreasIndex
	})
	self:_refreshChangePageBtn()
	self.m_numComp:updateNum()
end

function RobTreasureMainLayer:_refreshChangePageBtn()
	if self._selectedCompIndex <= 0 or self._treasureCompNum <= 1 then
		self.m_lastBtn:setVisible(false)
	else
		self.m_lastBtn:setVisible(true)
	end

	if self._selectedCompIndex >= self._treasureCompNum - 1 or self._treasureCompNum <= 1 then
		self.m_nextBtn:setVisible(false)
	else
		self.m_nextBtn:setVisible(true)
	end
end

function RobTreasureMainLayer:_createTreasureData(arg_15_1)
	local var_15_0 = false
	local var_15_1 = 0
	local var_15_2 = 0
	local var_15_3 = {}
	local var_15_4 = true

	for iter_15_0 = 1, 8 do
		local var_15_5 = arg_15_1["fragment_" .. iter_15_0]

		if arg_15_1["fragment_" .. iter_15_0] ~= 0 then
			var_15_2 = var_15_2 + 1

			local var_15_6 = g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_FRAGMENT, var_15_5)

			if var_15_6 > 0 then
				var_15_0 = true
				var_15_1 = var_15_1 + 1
			else
				var_15_4 = false
			end

			table.insert(var_15_3, {
				id = var_15_5,
				num = var_15_6
			})
		end
	end

	local var_15_7

	if arg_15_1.contend_type == 2 then
		var_15_0 = true
	elseif not var_15_0 then
		do return nil, false end

		var_15_7 = {
			id = arg_15_1.id,
			name = arg_15_1.name,
			quality = arg_15_1.quality,
			contendType = arg_15_1.contend_type
		}
	end

	var_15_7.map = var_0_2.get(arg_15_1.id).map
	var_15_7.fragment = var_15_3
	var_15_7.fragHasNum = var_15_1
	var_15_7.fragNum = var_15_2
	var_15_7.isHave = var_15_0
	var_15_7.compose = var_15_4 and 1 or 0

	return var_15_7, var_15_0
end

function RobTreasureMainLayer:_onArenaGetTaskAward()
	self:_initData()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

function RobTreasureMainLayer:_getCurSelectIndex()
	for iter_17_0, iter_17_1 in ipairs(self._treasureData) do
		if iter_17_1.id == self._curSelectTreasureId then
			return iter_17_0
		end
	end

	return 1
end

function RobTreasureMainLayer:receiveCompEvent(arg_18_1)
	if arg_18_1 == "RobTreasure_selectedTreasure" then
		self._curSelectTreasIndex = ({
			...
		})[1]
		self._curSelectTreasureId = self._treasureData[self._curSelectTreasIndex].id

		g.core.module.ModuleManager:pushFullComp(require("app.view.module.robTreasure.view.RobTreasureFragMainLayer").new(self._treasureData[self._curSelectTreasIndex]), self._treasureData[self._curSelectTreasIndex])
	end
end

return RobTreasureMainLayer
