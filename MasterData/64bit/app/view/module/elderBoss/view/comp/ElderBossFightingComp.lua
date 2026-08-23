local var_0_0 = g.core.model.User.elderBossData
local ElderBossFightingComp = class("ElderBossFightingComp", require("app.fairyGUI.elderBoss.UI_ElderBossFightingComp"))

function ElderBossFightingComp:updateFightingComp()
	self.m_fightComp:updateFight()
end

function ElderBossFightingComp:updateHitInfo()
	local var_2_0 = var_0_0:getFrontAttackRecord()

	if var_2_0 then
		local var_2_1 = fgui.UIPackage:createObject("elderBoss", "ElderBossHitComp")

		var_2_1:runFGAction((fgui.FSpawn:create({
			fgui.FFadeIn:create(1.8),
			fgui.FSequence:create({
				fgui.FMoveBy:create(1.8, cc.p(0, -100)),
				fgui.FCallFunc:create(function()
					var_2_1:removeFromParent()
				end)
			})
		})))
		var_2_1:updateHit(var_2_0)
		var_2_1:setPosition((self.m_hitPos:getPosition()))
		self:addChild(var_2_1)
	end
end

return ElderBossFightingComp
