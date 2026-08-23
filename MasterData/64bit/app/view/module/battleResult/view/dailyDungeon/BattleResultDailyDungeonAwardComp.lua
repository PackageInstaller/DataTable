local var_0_0 = g.core.config.daily_dungeon_stage_info
local var_0_1 = g.core.config.daily_dungeon_reward_preview
local BattleResultDailyDungeonAwardComp = class("BattleResultDailyDungeonAwardComp", require("app.fairyGUI.battleResult.UI_BattleResultDailyDungeonAwardComp"))

function BattleResultDailyDungeonAwardComp:ctor()
	self._awardCells = {}
	self._dropParams = {}
	self._isPlayed = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onListAwardRenderer))
	self.m_awardList:setNumItems(0)
end

function BattleResultDailyDungeonAwardComp:update(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._dropParams = arg_2_1.dropList or {}

	local var_2_0 = arg_2_1.record

	if arg_2_1.oldRecord < arg_2_1.record then
		self.m_recordController:setSelectedIndex(1)
	else
		self.m_recordController:setSelectedIndex(0)
	end

	local var_2_1 = var_0_1.get(var_0_0.get(arg_2_1.id).reward_preview)

	self.m_descText:setText(g.core.lang:get(300503 + var_2_1.extra_reward, {
		num = var_2_0
	}))
	self.m_tipTxt:setText(g.core.lang:get(300506 + var_2_1.extra_reward, {
		num = var_2_0
	}))

	self._isWin = arg_2_1.isWin
end

function BattleResultDailyDungeonAwardComp:_onListAwardRenderer(arg_3_1, arg_3_2)
	local var_3_0

	if not arg_3_2._inAnim then
		arg_3_2._inAnim = arg_3_2.getSharedTrans(arg_3_2, "listIconUiLeftIn", "ItemBagList", arg_3_2)
		var_3_0 = {
			darkQuality = true,
			scaleIndex = 2,
			nameRow = 0,
			type = self._dropParams[arg_3_1 + 1].type,
			value = self._dropParams[arg_3_1 + 1].value,
			size = self._dropParams[arg_3_1 + 1].size
		}
	end

	var_3_0.rightTxt = self._dropParams[arg_3_1 + 1].rightTxt or ""

	arg_3_2:updateIcon(var_3_0)
end

function BattleResultDailyDungeonAwardComp:_onTransAward()
	self.m_awardList:setNumItems(#self._dropParams)
	self.m_awardList:transitionShowCells("listIconUiLeftIn", 0.03, 1)
end

function BattleResultDailyDungeonAwardComp:play()
	self:runFGAction(fgui.FSequence:create({
		fgui.FDelayTime:create(0.2),
		fgui.FCallFunc:create(handler(self, function()
			self:dispatchCompEvent("BattleResult_continue")
		end))
	}))
	self:_onTransAward()

	return true
end

return BattleResultDailyDungeonAwardComp
