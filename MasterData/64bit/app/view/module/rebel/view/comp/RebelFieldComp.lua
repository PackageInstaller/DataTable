local var_0_0 = 3
local var_0_1 = "vortex_2300x800_2700"
local var_0_2 = 1
local var_0_3 = g.core.model.User.rebelData
local RebelFieldComp = class("RebelFieldComp", require("app.fairyGUI.rebel.UI_RebelFieldComp"))

function RebelFieldComp:ctor(arg_1_1)
	self._movieBgNode = nil

	self:_initView()
end

function RebelFieldComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_FINISH, handler(self, self._onForceGuideEnd), self)
	self:_addBgMovie()
end

function RebelFieldComp:_addBgMovie()
	if not self._movieBgNode then
		self._movieBgNode = self.m_movieDad:addCriSprite({
			isLoop = true,
			moduleName = "common",
			y = 0,
			x = 0,
			anchorY = 0.5,
			anchorX = 0,
			movieName = var_0_1,
			fullScreenState = var_0_2
		})

		self:setWidth(self._movieBgNode:getContentSize().width)
	end
end

function RebelFieldComp:refreshRebelField()
	local var_4_0, var_4_1 = var_0_3:getRebelDefault()

	self.m_monsterComp1:refreshRebelMonster(var_4_0)
	self.m_monsterComp2:refreshRebelMonster(var_4_1)
	self:_refreshTriggerBoss()
	self:checkSpeWeakGuide()
end

function RebelFieldComp:_onForceGuideEnd()
	self:checkSpeWeakGuide()
end

function RebelFieldComp:checkSpeWeakGuide()
	local var_6_0, var_6_1 = var_0_3:getRebelDefault()

	if var_6_0._realLevel == 1 and var_6_1._realLevel == 1 then
		if var_6_0:isInValidTime() then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
				key = "REBEL_WEAK_FINGER",
				targetBtn = self.m_monsterComp1
			})
		elseif var_6_1:isInValidTime() then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
				key = "REBEL_WEAK_FINGER",
				targetBtn = self.m_monsterComp2
			})
		end
	end
end

function RebelFieldComp:_initView()
	self.m_cloundDadComp:addEffectSpineAsync({
		scale = 1,
		isLoop = true,
		name = "eff_ui_rebel_cloud"
	})
end

function RebelFieldComp:_refreshTriggerBoss()
	local var_8_0 = var_0_3:getRebelArr()

	for iter_8_0 = 1, var_0_0 do
		if var_8_0[iter_8_0] then
			self["m_bossComp" .. iter_8_0]:setVisible(true)
			self["m_bossComp" .. iter_8_0]:refreshRebelBoss(var_8_0[iter_8_0])
		else
			self["m_bossComp" .. iter_8_0]:setVisible(false)
		end
	end
end

function RebelFieldComp:getCenterScreenX()
	return (self.m_monsterComp1:getX() + self.m_monsterComp2:getX()) / 2
end

function RebelFieldComp:onUnload()
	self.m_movieDad:removeAllCriSprite()

	self._movieBgNode = nil

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

return RebelFieldComp
