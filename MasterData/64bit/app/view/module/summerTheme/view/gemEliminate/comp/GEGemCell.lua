local var_0_0 = g.core.config.game_eliminate_res_info
local GemEliminateConst = require("app.view.module.summerTheme.const.GemEliminateConst")
local var_0_2 = GemEliminateConst.GEM_ICON_FULL_PATH_FORMAT
local GEGemCell = class("GEGemCell", require("app.fairyGUI.summerThemeGame.UI_GEGemCell"))

function GEGemCell:ctor()
	self._gemColor = GemEliminateConst.INVALID_GEM_COLOR
	self._selectedEffNode = nil
	self._selected = false
end

function GEGemCell:updateCell(arg_2_1)
	self:setGemColor(arg_2_1.color)
	self:setSelected(arg_2_1.selected)
end

function GEGemCell:setGemColor(arg_3_1)
	self._gemColor = arg_3_1

	self.m_gemLoader:setURL((string.format(var_0_2, var_0_0.get(arg_3_1).res)))
end

function GEGemCell:getGemColor()
	return self._gemColor
end

function GEGemCell:setSelected(arg_5_1)
	arg_5_1 = checkbool(arg_5_1)

	if arg_5_1 == self._selected then
		return
	end

	self._selected = arg_5_1

	if arg_5_1 then
		if self._selectedEffNode then
			self._selectedEffNode:resume()
			self._selectedEffNode:setVisible(true)
		else
			self._selectedEffNode = self.m_selectedEffDad:addEffectSpine({
				name = "eff_ui_gemEliminate_checkbox",
				isLoop = true,
				remove = false
			})
		end
	elseif self._selectedEffNode then
		self._selectedEffNode:pause()
		self._selectedEffNode:setVisible(false)
	end
end

return GEGemCell
