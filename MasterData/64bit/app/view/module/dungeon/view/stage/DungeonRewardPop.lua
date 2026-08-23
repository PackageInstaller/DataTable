local var_0_0 = g.core.event.EventManager
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.model.User.dungeonData
local var_0_3 = g.core.config.dungeon_chest_info
local var_0_4 = g.core.config.dungeon_stage_info
local var_0_5 = g.core.const.ConstMgr.DungeonConst
local var_0_6 = g.core.lang
local var_0_7 = g.core.module.ModuleManager
local var_0_8 = g.core.network.GameNetProxy
local DungeonRewardPop = class("DungeonRewardPop", require("app.fairyGUI.dungeon.UI_DungeonRewardPop"), function()
	return fgui.GComponent:create({
		pkgName = "dungeon",
		resName = "DungeonRewardPop"
	})
end)

function DungeonRewardPop:ctor(arg_2_1)
	self:showAtCenter()

	self._chapterId = arg_2_1.chapterId
	self._chestId = arg_2_1.chestId
	self._index = arg_2_1.index
	self._rewardData = {}

	self:_initView()
	self:_initListener()
	self:_initRewardList()
end

function DungeonRewardPop:_initListener()
	self.m_rewardBtn:addClickListener(handler(self, self.onRewardClick))
	self.m_rewardList:setVirtual()
	self.m_rewardList:setScrollLimit(true)
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderReward))
end

function DungeonRewardPop:_onRenderReward(arg_4_1, arg_4_2)
	arg_4_2:updateIcon({
		nameRow = 2,
		type = self._rewardData[arg_4_1 + 1].type,
		value = self._rewardData[arg_4_1 + 1].value,
		size = self._rewardData[arg_4_1 + 1].size
	})
end

function DungeonRewardPop:onLoad()
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_DUNGEON_GETCHAPTERCHESTAWARD, self._onGetChapterChestAward, self)
end

function DungeonRewardPop:_initRewardList()
	self._rewardData = var_0_2:getStarAwardsData(self._chestId)

	self.m_rewardList:setNumItems(#self._rewardData)
end

function DungeonRewardPop:_initView()
	local var_7_0 = var_0_3.get(self._chestId)

	self._type = var_7_0.chest_type

	local var_7_1 = false
	local var_7_2 = 0
	local var_7_3 = var_0_2:getChapter(self._chapterId)

	if var_7_3 then
		if var_7_0.chest_type == var_0_5.CHEST_TYPE_STAR then
			if var_7_3 then
				self:_setPopTitle()

				var_7_1 = var_7_3:canOpenStarChest(self._index)
				var_7_2 = var_7_1 and 1 or 0

				if var_7_1 then
					var_7_2 = var_7_3:isStarChestOpened(self._index) and 2 or 1
				end
			end
		elseif var_7_0.chest_type == var_0_5.CHEST_TYPE_STAGE then
			var_7_1 = var_0_2:canOpenStageChest(self._chapterId, self._index)
			var_7_2 = var_7_1 and 1 or 0

			if var_7_1 then
				var_7_2 = var_7_3:isStageChestOpen(self._index) and 2 or 1
			end

			self.m_popPanel:setTitle(var_0_6:get(300042))
		end

		if not var_7_1 then
			if var_7_0.chest_type == var_0_5.CHEST_TYPE_STAR then
				self.m_rewardTipTxt:setText(var_0_6:get(300017, {
					num = var_7_0.unlock
				}))
			elseif var_7_0.chest_type == var_0_5.CHEST_TYPE_STAGE then
				self.m_rewardTipTxt:setText(var_0_6:get(300018, {
					stage_name = var_0_4.get(var_7_0.unlock).name
				}))
			else
				var_0_7:tip(var_0_6:get(300019))
			end
		end
	else
		self.m_rewardTipTxt:setText(var_0_6:get(300017, {
			num = var_7_0.unlock
		}))
	end

	self.m_rewardStateController:setSelectedIndex(var_7_2)
end

function DungeonRewardPop:_setPopTitle()
	self.m_popPanel:setTitle(var_0_6:get(300024, {
		num = g.core.utils.Number.toChineseNumber(self._index)
	}))
end

function DungeonRewardPop:onRewardClick()
	var_0_8:send_C2S_Dungeon_GetChapterChestAward({
		id = self._chapterId,
		tp = self._type,
		pos = self._index
	})
end

function DungeonRewardPop:_onGetChapterChestAward(arg_10_1, arg_10_2, arg_10_3)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return DungeonRewardPop
