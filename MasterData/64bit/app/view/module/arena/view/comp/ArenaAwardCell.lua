local var_0_0 = g.core.const.ConstMgr.ArenaConst
local ArenaAwardCell = class("ArenaAwardCell", require("app.fairyGUI.arena.UI_ArenaAwardCell"))

function ArenaAwardCell:ctor()
	self._awardList = {}

	self:_initListView()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function ArenaAwardCell:_initListView()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardList))
end

function ArenaAwardCell:_onAwardList(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awardList[arg_3_1 + 1])
end

function ArenaAwardCell:updateCell(arg_4_1, arg_4_2)
	if not arg_4_2 then
		return
	end

	self.m_isShowBgController:setSelectedIndex((arg_4_1 % 2 == 0 or nil) and (var_0_0.CTRL_SHOW_BG or var_0_0.CTRL_HIDE_BG))

	local var_4_0 = arg_4_2.min_rank
	local var_4_1 = arg_4_2.max_rank
	local var_4_2 = arg_4_2.min_rank == arg_4_2.max_rank
	local var_4_3 = arg_4_2.min_rank == arg_4_2.max_rank and var_4_0 <= var_0_0.TOP_3

	if arg_4_2.min_rank == arg_4_2.max_rank and var_4_0 <= var_0_0.TOP_3 then
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

	self.m_isTopThreeController:setSelectedIndex((var_4_3 or nil) and (var_0_0.CTRL_TOP3 or var_0_0.CTRL_UN_TOP3))

	self._awardList = {}

	for iter_4_0 = 1, var_0_0.MAX_AWARD_NUM do
		if arg_4_2["reward_type" .. iter_4_0] ~= 0 then
			table.insert(self._awardList, {
				hideNum = false,
				type = arg_4_2["reward_type" .. iter_4_0],
				value = arg_4_2["reward_value" .. iter_4_0],
				size = arg_4_2["reward_size" .. iter_4_0]
			})
		end
	end

	self.m_awardList:setNumItems(#self._awardList)
end

return ArenaAwardCell
