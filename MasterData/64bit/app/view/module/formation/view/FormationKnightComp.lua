local var_0_0 = g.core.model.User.weddingData
local BattleKnight = require("app.view.battle.BattleKnight")
local var_0_2 = g.core.model.User.knightsData
local BattleConst = require("app.view.battle.const.BattleConst")
local FormationKnightComp = class("FormationKnightComp", require("app.fairyGUI.formation.UI_FormationKnightComp"))

function FormationKnightComp:ctor()
	self:addEventListener(fgui.UIEventType.Drop, handler(self, self._onDropEnd))
end

function FormationKnightComp:_onDropEnd(arg_2_1)
	local var_2_0 = arg_2_1:getDataValue()

	if var_2_0 and var_2_0 > 0 then
		self:dispatchCompEvent("FormationKnightComp_GuildDropEnd", {
			index = self._index
		})
	elseif var_2_0 and var_2_0 == 0 then
		self:dispatchCompEvent("FormationKnightComp_GuildDropCancel")
	end
end

function FormationKnightComp:setPosIndex(arg_3_1)
	self._index = arg_3_1
end

function FormationKnightComp:setKnightId(arg_4_1)
	self._knightId = arg_4_1
end

function FormationKnightComp:getDragParam()
	return self._index or 0
end

function FormationKnightComp:updateComp(arg_6_1)
	self:hideKnight(false)

	if not arg_6_1 and self._knightId then
		arg_6_1 = self._knightId
	end

	if arg_6_1 and arg_6_1 > 0 then
		self:updateCompByStruct((var_0_2:getKnight({
			id = arg_6_1
		})))
	else
		self:hideKnight(true)
	end
end

function FormationKnightComp:updateCompByStruct(arg_7_1)
	if not arg_7_1 then
		self:hideKnight(true)

		return
	end

	local var_7_0 = arg_7_1:getResInfo()

	self:hideKnight(false)

	self._knight = arg_7_1

	local var_7_1 = arg_7_1:getBaseInfo()
	local var_7_2, var_7_3 = arg_7_1:getAdvStageAndLevel()

	self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(var_7_1.classical))
	self.m_leaderLoader:setVisible(arg_7_1:isElementLeader())
	self.m_nameText:setText((arg_7_1:getName()))
	self.m_qualityLoader:setURL((g.core.common.Path:getFormationKnightNameBg(var_7_1.quality)))
	self.m_groupLoader:setURL((g.core.common.Path:getCampURL(var_7_1.group, 4)))

	self._localResId = var_7_0.fight_id

	if self._lastResId ~= self._localResId and self._knightPic then
		self._knightPic:removeFromParent()

		self._knightPic = nil
	end

	if not self._knightPic then
		self._knightPic = BattleKnight.new({
			base = true,
			breath = true,
			resId = self._localResId,
			listener = handler(self, self._knightAnimEvent)
		})
		self._lastResId = self._localResId

		self.m_knightPic:addNode(self._knightPic)
		self._knightPic:setScale(1.2)
	end

	local var_7_4 = arg_7_1:getAdvanceId()

	if arg_7_1:isOwn() and var_0_0:isWeddingVowByKnightId(var_7_4) then
		self.m_weddingLoader:setURL(g.core.common.Path:getWeddingVowFormationIcon(var_0_0:getWeddingVowInfo(var_7_4).scene))
		self.m_isWeddingController:setSelectedIndex(1)
	else
		self.m_isWeddingController:setSelectedIndex(0)
	end
end

function FormationKnightComp:playInAnim()
	if self._knightPic then
		self._knightPic:setAnimation(0, BattleConst.SPINE_ACTION_TYPE.IN, false)
	end
end

function FormationKnightComp:_knightAnimEvent(arg_9_1, arg_9_2)
	if arg_9_1 and arg_9_1.animation == BattleConst.SPINE_ACTION_TYPE.IN and arg_9_1.type == BattleConst.SPINE_EVENT.COMPLETE then
		self._knightPic:setAnimation(0, BattleConst.SPINE_ACTION_TYPE.IDLE, true)
	end
end

function FormationKnightComp:updateKnightOpacity(arg_10_1)
	self.m_knightPic:setOpacity(arg_10_1)
end

function FormationKnightComp:hideKnight(arg_11_1)
	self.m_isEmptyController:setSelectedIndex(arg_11_1 and 1 or 0)
end

function FormationKnightComp:checkTouchable(arg_12_1)
	self:setTouchable(self._knight and arg_12_1)
end

function FormationKnightComp:showPosHpBar(arg_13_1)
	self.m_isExploreController:setSelectedIndex(1)

	if arg_13_1 == 0 then
		self.m_hpBarComp:setCtrlState("dead", {
			index = 1
		})
	else
		self.m_hpBarComp:setCtrlState("dead", {
			index = 0
		})
		self.m_hpBarComp:setMax(1000)
		self.m_hpBarComp:setValue(arg_13_1)
	end
end

function FormationKnightComp:updateBottomShowState(arg_14_1)
	if not self._knightId or self._knightId == 0 then
		self.m_bottomImageStateController:setSelectedIndex(1)
		self.m_isAddController:setSelectedIndex(arg_14_1 and 1 or 0)
	else
		self.m_bottomImageStateController:setSelectedIndex(0)
		self.m_isAddController:setSelectedIndex(0)
	end
end

function FormationKnightComp:updateLevelAndRank(arg_15_1, arg_15_2, arg_15_3)
	if arg_15_1 then
		self.m_levelComp:updateLevelAndRank(arg_15_2, arg_15_3)
		self.m_levelComp1:updateLevelAndRank(arg_15_2, arg_15_3)
		self.m_isShowLevelAndRankController:setSelectedIndex(1)
	else
		self.m_isShowLevelAndRankController:setSelectedIndex(0)
	end
end

return FormationKnightComp
