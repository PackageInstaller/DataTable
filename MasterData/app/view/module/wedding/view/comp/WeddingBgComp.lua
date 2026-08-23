local var_0_0 = g.core.config.wedding_vow_info
local WeddingBgComp = class("WeddingBgComp", require("app.fairyGUI.wedding.UI_WeddingBgComp"))

function WeddingBgComp:updateMaskKnight(arg_1_1)
	local var_1_0 = var_0_0.get(arg_1_1:getAdvanceId())

	if var_1_0.skin > 0 then
		if g.core.utils.Rule.matchChannelAndLv() and ({
			[60003002] = true
		})[var_1_0.skin] then
			self.m_knightMask:getChild("knightPicComp"):updateKnight({
				resId = arg_1_1:getResInfo().painted_id
			})
		else
			self.m_knightMask:getChild("knightPicComp"):updateKnight({
				skinId = var_1_0.skin
			})
		end
	else
		self.m_knightMask:getChild("knightPicComp"):updateKnight({
			resId = arg_1_1:getResInfo().painted_id
		})
	end
end

return WeddingBgComp
