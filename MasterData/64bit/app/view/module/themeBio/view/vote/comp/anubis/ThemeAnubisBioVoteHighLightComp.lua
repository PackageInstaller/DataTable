local ThemeAnubisBioVoteHighLightComp = class("ThemeAnubisBioVoteHighLightComp", require("app.fairyGUI.themeBio.UI_ThemeAnubisBioVoteHighLightComp"))

function ThemeAnubisBioVoteHighLightComp:ctor()
	return
end

function ThemeAnubisBioVoteHighLightComp:playSelectAnim(arg_2_1, arg_2_2)
	self.m_highLight:setPosition(arg_2_1)
	self.m_voteTransition:play(function()
		self.m_normalTransition:play(function()
			if arg_2_2 then
				arg_2_2()
			end
		end)
	end)
end

return ThemeAnubisBioVoteHighLightComp
