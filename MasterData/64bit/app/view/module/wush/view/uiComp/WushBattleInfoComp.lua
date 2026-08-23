local WushBattleInfoComp = class("WushBattleInfoComp", require("app.fairyGUI.wush.UI_WushBattleInfoComp"))
local var_0_1 = g.core.config.dead_battle_checkpoint_info
local var_0_2 = g.core.config.dead_battle_floor_info
local var_0_3 = g.core.config.knight_base_info
local var_0_4 = g.core.model.User.wushData

function WushBattleInfoComp:ctor()
	self._stageId = 1
	self._floorId = 1

	self.m_diffLvController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onDiffLvControllerChanged))
end

function WushBattleInfoComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_CHALLENGEBEGIN, handler(self, self._onRcvBattleBegin), self)
end

function WushBattleInfoComp:_onDiffLvControllerChanged()
	self["m_diffComp" .. self.m_diffLvController:getSelectedIndex() + 1]:playEnterAni()
end

function WushBattleInfoComp:updateBattleInfo(arg_4_1)
	if arg_4_1 then
		self._stageId = arg_4_1.stageId or 1
	end

	if arg_4_1 then
		self._floorId = arg_4_1.floorId or 1
	end

	if arg_4_1 then
		self._stageIndex = arg_4_1.stageIndex or 0
	end

	self._isBoss = var_0_2.get(self._floorId).type == 2

	local var_4_0 = var_0_1.get(self._stageId)

	if self._stageIndex >= 0 and self._stageIndex < 3 then
		self.m_stageIndexController:setSelectedIndex(self._stageIndex)
	end

	self:setDiffcultyLevel()

	local var_4_1 = var_0_4:getDisplayVersion()
	local var_4_2, var_4_3

	if var_4_1 == 1 then
		var_4_2 = var_4_0.monster_name or var_4_0["monster_name_" .. var_4_1]

		if var_4_1 == 1 then
			var_4_3 = var_4_0.monster_res or var_4_0["monster_res_" .. var_4_1]
		end
	end

	self.m_nameLabel:setText(var_4_2)
	self.m_fightTxt:setText(g.core.model.User:getFightValue())
	self.m_picComp:setIcon((g.core.common.Path:getMiddleKnightPicById(var_0_3.get(var_4_3).icon_id)))
	self.m_picComp:setCtrlState("isBoss", {
		index = self._isBoss and 1 or 0
	})
	self:initDiffComp()
end

function WushBattleInfoComp:setDiffcultyLevel()
	local var_5_0 = 0

	if self._stageId == 1 then
		local var_5_1 = var_0_1.get(self._stageId)
		local var_5_2 = g.core.model.User:getFightValue()

		for iter_5_0 = 1, 3 do
			if var_5_2 >= var_5_1["monster_fight_" .. iter_5_0] then
				var_5_0 = iter_5_0 - 1
			end
		end

		self.m_diffLvController:setSelectedIndex(var_5_0)
	else
		local var_5_3 = var_0_4:getFloorIdByStage(self._stageId - 1)
		local var_5_4 = g.core.model.User.wushData:getHistoryStar(self._stageId - 1)

		var_5_0 = var_0_2.get(var_5_3).type == 2 and (var_5_4 == 9 and 2 or var_5_4 == 6 and 1 or 0) or var_5_4 - 1
	end

	self.m_diffLvController:setSelectedIndex(math.min(math.max(var_5_0, 0), 2))
end

function WushBattleInfoComp:_onRcvBattleBegin(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local BattleConst = require("app.view.battle.const.BattleConst")
	local var_6_1 = self._stageId
	local var_6_2 = var_0_1.get(self._stageId)
	local var_6_3
	local var_6_4, var_6_5

	if var_6_2.quality == 5 then
		var_6_3 = 5
		var_6_4 = var_6_2.battle_stage
		var_6_5 = {
			cloudLoading = true
		}
	end

	var_6_5.canSkip = g.core.model.User.wushData:getHistoryStar(var_6_1) > arg_6_4.index
	var_6_5.soundType = var_6_3
	var_6_5.type = BattleConst.TYPE_WUSH
	var_6_5.typeQuality = var_6_2.quality
	var_6_5.battle_id = arg_6_4.battle_id
	var_6_5.battleType = BattleConst.BATTLE_TYPE.PVE
	var_6_5.bgId = var_6_4
	var_6_5.bgm = g.core.const.ConstMgr.SoundConst.BGM.MUSIC_ABYSS_BATTLE

	g.core.battle.BattleProxy:enterBattle(var_6_5)
	self:dispatchCompEvent("WUSHMAINLAYER_HIDE_BATTLEINFO")
end

function WushBattleInfoComp:initDiffComp()
	for iter_7_0 = 1, 3 do
		if self["m_diffComp" .. iter_7_0] then
			self["m_diffComp" .. iter_7_0]:updateComp({
				index = iter_7_0,
				stageId = self._stageId,
				floorId = self._floorId
			})
		end
	end
end

function WushBattleInfoComp:checkSpeWeakGuide()
	if self.m_diffLvController:getSelectedIndex() ~= 1 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "WUSH_FIRST_FAIL",
			targetBtn = self:getChild("n102")
		})
	end
end

function WushBattleInfoComp:doAutoAction()
	print("self.m_diffLvController:getSelectedIndex()", self.m_diffLvController:getSelectedIndex())

	if self.m_diffLvController:getSelectedIndex() == 2 then
		return self.m_diffComp3:doAutoAction()
	else
		self.m_diffLvController:setSelectedIndex(2)
	end
end

function WushBattleInfoComp:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

return WushBattleInfoComp
