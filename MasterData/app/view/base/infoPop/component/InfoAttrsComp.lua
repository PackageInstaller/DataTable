local InfoAttrsComp = class("InfoAttrsComp", require("app.fairyGUI.infoPop.UI_InfoAttrsComp"))

function InfoAttrsComp:ctor(arg_1_1)
	self.m_attsList:setVirtual()
	self.m_attsList:setItemRenderer(handler(self, self._onAttrsItemRenderer))
	self.m_infoBtn:addClickListener(handler(self, self._onClickInfoBtn))
end

function InfoAttrsComp:updateAttrs(arg_2_1)
	local var_2_0 = arg_2_1.isResonance

	self._isResonance = arg_2_1.isResonance
	self._attrs = arg_2_1.attrs

	self.m_descTypeController:setSelectedIndex(0)

	if arg_2_1.isGlyph then
		if arg_2_1.levelDesc then
			self.m_attrsLevelDescTxt:setText(arg_2_1.levelDesc)
		elseif arg_2_1.glyphInfo.level then
			self.m_descTypeController:setSelectedIndex(1)
			self.m_glyIcon:setGrayed(false)

			if arg_2_1.glyphInfo.level < 1 then
				self.m_glyIcon:setGrayed(true)
			end

			self.m_glyIcon:setURL((g.core.common.Path:getGlyphIcon(arg_2_1.glyphInfo.icon)))
		end
	else
		self.m_attrsLevelDescTxt:setText(arg_2_1.levelDesc or "")
	end

	self.m_isResonanceController:setSelectedIndex(var_2_0 and 1 or 0)
	self.m_isHasAttrController:setSelectedIndex(#self._attrs > 0 and 0 or 1)

	if #self._attrs > 0 then
		self.m_attsList:setNumItems(#self._attrs)
		self.m_attsList:resizeToFit(#self._attrs)
	else
		self.m_emptyText:setText(arg_2_1.emptyText or g.core.lang:get(201615))
	end
end

function InfoAttrsComp:_onAttrsItemRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateAttr(self._attrs[arg_3_1 + 1])
	arg_3_2:setIsShowBg(true)
end

function InfoAttrsComp:_onClickInfoBtn()
	self:dispatchCompEvent("Click_InfoBtn", {
		isResonance = self._isResonance
	})
end

return InfoAttrsComp
