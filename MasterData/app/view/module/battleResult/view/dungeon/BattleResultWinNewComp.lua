local BattleResultWinNewComp = class("BattleResultWinNewComp", require("app.fairyGUI.battleResult.UI_BattleResultWinNewComp"))

function BattleResultWinNewComp:ctor()
	self._startPos = {
		x = self.m_redImg:getX(),
		y = self.m_redImg:getY()
	}

	self.m_enterTransition:setHook("playImgEnter", handler(self, self._onPlayImgEnter))
end

function BattleResultWinNewComp:_onPlayImgEnter()
	local var_2_0 = (display.width - 1334) / 2

	if (display.width - 1334) / 2 > 0 then
		if self._startPos.x + var_2_0 > 0 then
			var_2_0 = -self._startPos.x

			self.m_redImg:setWidth(self.m_redImg:getWidth() + (self._startPos.x + var_2_0))
		end

		self.m_redImgEnterTransition:changeParams({
			changePos = {
				self._startPos.x + var_2_0,
				self._startPos.y
			}
		}):play()
	else
		self.m_redImgEnterTransition:play()
	end
end

function BattleResultWinNewComp:update(arg_3_1)
	if self.init then
		return
	end

	self._knightId = arg_3_1.knight_id

	self.m_descTxt:setText(arg_3_1.winText)
	self.m_starNumTxt:setText(g.core.lang:get(110401, {
		star = arg_3_1.star
	}))
	self:updateStar(arg_3_1.star)
	self:updateFrontView()

	self.init = true

	self.m_mission:addEffectSpine({
		remove = true,
		name = "eff_ui_dungeon_mission",
		isLoop = false
	})
	self.m_missionBg:addEffectSpine({
		remove = true,
		name = "eff_ui_dungeon_missionBg",
		isLoop = false
	})
	self.m_enterTransition:setHook("starLine", handler(self, self._onStarLineAnim))
	self.m_enterTransition:setHook("starEnter1", handler(self, self._onStarEnter1))
	self.m_enterTransition:setHook("starEnter2", handler(self, self._onStarEnter2))
	self.m_enterTransition:setHook("starEnter3", handler(self, self._onStarEnter3))
	self.m_enterTransition:setHook("comTitle", handler(self, self._onComTitleEffPlay))
	self.m_enterTransition:setHook("txtgap", handler(self, self._onSetTextGap))
end

function BattleResultWinNewComp:_onSetTextGap()
	self.m_animNewTxt:setAdditionalKerning(0)
end

function BattleResultWinNewComp:_onComTitleEffPlay()
	self.m_comTitle:addEffectSpine({
		remove = true,
		name = "eff_ui_battleResult_comTitle",
		isLoop = false
	})
end

function BattleResultWinNewComp:_onStarEnter1()
	self.m_star1:playSpineAnim()
end

function BattleResultWinNewComp:_onStarEnter2()
	self.m_star2:playSpineAnim()
end

function BattleResultWinNewComp:_onStarEnter3()
	self.m_star3:playSpineAnim()
	self:dispatchCompEvent("BattleResult_continue")
end

function BattleResultWinNewComp:_onStarLineAnim()
	self.m_starLine:addEffectSpine({
		remove = true,
		name = "eff_ui_dungeon_starLine",
		isLoop = false
	})
end

function BattleResultWinNewComp:updateStar(arg_10_1)
	for iter_10_0 = 1, 3 do
		self["m_star" .. iter_10_0]:setActive(iter_10_0 <= arg_10_1, iter_10_0 == 3, 0.3 * (iter_10_0 - 1))
	end
end

function BattleResultWinNewComp:updateFrontView()
	local var_11_0 = self._knightId

	if not self._knightId or var_11_0 == 0 then
		var_11_0 = g.core.model.User.knightsData:getMainKnight():getBaseInfo().advance_id
	end

	local var_11_1 = g.core.model.User.knightsData:getKnight({
		advance_id = var_11_0
	})

	self.m_knightPicComp:updateKnight({
		resId = var_11_1:getResInfo().painted_id
	})
	self.m_knightPicComp:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-250, 0, 500, 0), 250)
end

function BattleResultWinNewComp:play(arg_12_1)
	if arg_12_1 == 0 then
		return true
	end
end

return BattleResultWinNewComp
