local var_0_0 = g.core.config.talent_skill_info
local var_0_1 = g.core.model.User.gveDataMgr
local var_0_2 = g.core.model.User.gveDataMgr:getGveBagData()
local var_0_3 = g.core.const.ConstMgr.GveConst
local GveStageBuffComp = class("GveStageBuffComp", require("app.fairyGUI.gve.UI_GveStageBuffComp"))

function GveStageBuffComp:ctor()
	var_0_2 = var_0_1:getGveBagData()

	self:addClickListener(handler(self, self._onClickDetail))
	self.m_stageBuffList:setVirtual()
	self.m_stageBuffList:setItemRenderer(handler(self, self._onBuffRenderer))
	self.m_stageBuffList:setItemProvider(handler(self, self._onBuffListProvider))
end

function GveStageBuffComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CLICK_FINISH, self._onRootClickStart, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH, self.updateBuff, self)
end

function GveStageBuffComp:updateBuff()
	self:updateListData()
end

function GveStageBuffComp:getMySelfBuff()
	local var_4_0 = {}
	local var_4_1 = var_0_2:getCoreHalidomBranch()

	if var_4_1 == var_0_3.GVE_HALIDOM_BRANCH.DEFAULT_BRANCH or var_4_1 == var_0_3.GVE_HALIDOM_BRANCH.ARMY_BRANCH then
		return var_4_0
	end

	local var_4_2 = var_0_2:getCoreHalidomLevel()

	for iter_4_0, iter_4_1 in ipairs((var_0_2:getAllTargetJobSkillCfg(var_4_1))) do
		if var_4_2 >= iter_4_1.needLv then
			table.insert(var_4_0, {
				cfg = iter_4_1.cfg,
				param = (iter_4_1.cfg.main_skill_type == var_0_3.GVE_SKILL_BUFF.CARRY_2 or nil) and math.min(math.floor(var_0_1:getGveData():getMyAtkNums() / iter_4_1.cfg.main_skill_param_1), iter_4_1.cfg.main_skill_param_3) * var_0_0.get(iter_4_1.cfg.main_skill_param_2).affect_value_1 / 10
			})
		end
	end

	return var_4_0
end

function GveStageBuffComp:_onBuffRenderer(arg_5_1, arg_5_2)
	arg_5_2:setTitle(((self._buffDataList[arg_5_1 + 1].index or nil) and (self._buffDataList[arg_5_1 + 1].index .. "." or "")) .. (self._buffDataList[arg_5_1 + 1].title or self._buffDataList[arg_5_1 + 1].str))
end

function GveStageBuffComp:updateListData()
	self._buffDataList = {}

	local var_6_0 = self:getMySelfBuff()
	local var_6_1 = var_0_2:getCoreHalidomBranch()
	local var_6_2 = var_0_1:getAllArmyBuff(var_6_1 == var_0_3.GVE_HALIDOM_BRANCH.ARMY_BRANCH)

	self._iconList = {}

	if next(var_6_0) then
		local var_6_3 = var_0_2:getTargetResourceCfg(var_6_1)

		table.insert(self._iconList, var_6_3.buff_icon)
		table.insert(self._buffDataList, {
			title = var_6_3.name
		})

		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			self:parseData(iter_6_1)
			table.insert(self._buffDataList, {
				index = iter_6_0,
				str = self:parseData(iter_6_1)
			})
		end
	end

	if next(var_6_2) then
		local var_6_4 = var_0_2:getTargetResourceCfg(var_0_3.GVE_HALIDOM_BRANCH.ARMY_BRANCH)

		table.insert(self._iconList, var_6_4.buff_icon)
		table.insert(self._buffDataList, {
			title = var_6_4.name
		})

		for iter_6_2, iter_6_3 in ipairs(var_6_2) do
			self:parseData(iter_6_3)
			table.insert(self._buffDataList, {
				index = iter_6_2,
				str = self:parseData(iter_6_3)
			})
		end
	end

	self.m_numController:setSelectedIndex(#self._iconList)

	for iter_6_4, iter_6_5 in ipairs(self._iconList) do
		self["m_buffIcon" .. iter_6_4]:setURL("res/common/icon/halidom_resource/" .. iter_6_5 .. ".png")
	end
end

function GveStageBuffComp:parseData(arg_7_1)
	return arg_7_1.isMine and g.core.lang:getByString(arg_7_1.cfg.main_skill_txt_2, {
		num1 = arg_7_1.param
	}) or g.core.lang:getByString(arg_7_1.cfg.main_skill_txt, {
		num1 = arg_7_1.param
	})
end

function GveStageBuffComp:_onBuffListProvider(arg_8_1)
	if self._buffDataList[arg_8_1 + 1].title then
		return "ui://gve/GveStageBuffTitleTxt"
	else
		return "ui://gve/GveStageBuffDescTxt"
	end
end

function GveStageBuffComp:_onClickDetail()
	self.m_showDetailController:setSelectedIndex(1)
	self.m_stageBuffList:setNumItems(#self._buffDataList)
end

function GveStageBuffComp:_onRootClickStart()
	self.m_showDetailController:setSelectedIndex(0)
end

return GveStageBuffComp
