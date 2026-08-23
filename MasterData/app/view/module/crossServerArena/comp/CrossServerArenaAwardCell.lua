local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.const.ConstMgr.CrossServerArenaConst
local CrossServerArenaAwardCell = class("CrossServerArenaAwardCell", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaAwardCell"))

function CrossServerArenaAwardCell:ctor()
	self._awardList = {}

	self:_initListView()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function CrossServerArenaAwardCell:_initListView()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
end

function CrossServerArenaAwardCell:_onRenderAwardList(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awardList[arg_3_1 + 1])
end

function CrossServerArenaAwardCell:updateCell(arg_4_1, arg_4_2)
	if not arg_4_2 then
		return
	end

	self.m_isShowBgController:setSelectedIndex((arg_4_1 % 2 == 0 or nil) and (var_0_1.CTRL_SHOW_BG or var_0_1.CTRL_HIDE_BG))

	local var_4_0 = arg_4_2.min_rank
	local var_4_1 = arg_4_2.max_rank
	local var_4_2 = arg_4_2.min_rank == arg_4_2.max_rank
	local var_4_3 = arg_4_2.min_rank == arg_4_2.max_rank and var_4_0 <= var_0_1.TOP_3

	if arg_4_2.min_rank == arg_4_2.max_rank and var_4_0 <= var_0_1.TOP_3 then
		self.m_rankIndexComp:updateRankIndex({
			rank = var_4_0
		})
	else
		self.m_rankText:setText((var_4_2 or nil) and (g.core.lang:get(302509, {
			rank = var_4_0
		}) or g.core.lang:get(302510, {
			rank1 = var_4_0,
			rank2 = var_4_1
		})))
	end

	self.m_isTopThreeController:setSelectedIndex((var_4_3 or nil) and (var_0_1.CTRL_TOP3 or var_0_1.CTRL_UN_TOP3))
	self:_packageAwardList(arg_4_2)
	self.m_awardList:setNumItems(#self._awardList)
	self.m_awardList:resizeToFit(#self._awardList)
end

function CrossServerArenaAwardCell:_packageAwardList(arg_5_1)
	self._awardList = {}

	local var_5_0 = 1

	while arg_5_1["reward_type" .. 1] and arg_5_1["reward_type" .. 1] > 0 do
		local var_5_1 = var_0_0:convert({
			type = arg_5_1["reward_type" .. var_5_0],
			value = arg_5_1["reward_value" .. var_5_0],
			size = arg_5_1["reward_size" .. var_5_0]
		})

		var_5_1.scaleIndex = 4

		table.insert(self._awardList, var_5_1)

		var_5_0 = var_5_0 + 1
	end
end

return CrossServerArenaAwardCell
