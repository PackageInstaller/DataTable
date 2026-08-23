local KnightSkinSpineComp = class("KnightSkinSpineComp", require("app.fairyGUI.knight.UI_KnightSkinSpineComp"))
local BattleKnight = require("app.view.battle.BattleKnight")

function KnightSkinSpineComp:ctor()
	self._knightPic = nil
	self._knightPos = cc.p(self.m_picComp:getWidth() / 2, 0)
end

function KnightSkinSpineComp:updateComp(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	local var_2_0 = g.core.common.Path:getKnightSkinSpineCompBg(arg_2_2)

	self.m_bg1:setURL(var_2_0 .. "_1")
	self.m_bg2:setURL(var_2_0)

	if self._knightPic then
		self._knightPic:removeFromParent()

		self._knightPic = nil
	end

	self._knightPic = BattleKnight.new({
		breath = true,
		base = false,
		resId = arg_2_1.fight_id
	})

	self._knightPic:setScale(0.9)
	self._knightPic:setPosition(self._knightPos)
	self.m_picComp:removeChildren()
	self.m_picComp:addNode(self._knightPic)
end

return KnightSkinSpineComp
