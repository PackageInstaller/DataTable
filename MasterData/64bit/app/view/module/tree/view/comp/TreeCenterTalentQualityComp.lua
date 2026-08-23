local TreeTalentComp = class("TreeTalentComp", require("app.fairyGUI.tree.UI_TreeCenterTalentQualityComp"))

function TreeTalentComp:updateComp(arg_1_1, arg_1_2)
	if arg_1_2 then
		self.m_eff:addEffectSpine({
			isLoop = false,
			name = "eff_ui_tree_starUp",
			anim = "play",
			remove = true
		})
		self.m_upTransition:play()
		self.m_upTransition:setHook("cut", function()
			self.m_qualityController:setSelectedIndex(arg_1_1)
		end)
	else
		self.m_qualityController:setSelectedIndex(arg_1_1)
	end
end

return TreeTalentComp
