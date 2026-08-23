local SuccubaChatHandbookCell = class("SuccubaChatHandbookCell", require("app.fairyGUI.succuba.UI_SuccubaChatHandbookCell"))

function SuccubaChatHandbookCell:ctor()
	self._cfg = nil
	self._pos = 0

	self.m_stateTxt:enableRich()
	self.m_playBtn:addClickListener(handler(self, self._playChat))
	self.m_maskLoader:addClickListener(handler(self, self._onClickMask))
end

function SuccubaChatHandbookCell:updateHandbookCell(arg_2_1, arg_2_2)
	self.m_qualityLoader:setURL(g.core.common.Path:getKnightKnightTextByQuality(arg_2_1.quality + 1))
	self.m_nameTxt:setText(arg_2_1.act_name)
	self.m_desTxt:setText(arg_2_1.act_des)

	local var_2_0 = 1
	local var_2_1 = {
		"type"
	}

	var_2_1[2] = 1

	local var_2_2 = table.concat(var_2_1, "_")
	local var_2_3 = {
		""
	}
	local var_2_7

	::label_2_0::

	if g.core.config.succuba_interaction_info.hasKey(var_2_2) then
		repeat
			if arg_2_1[var_2_2] ~= 0 then
				local var_2_4, var_2_5 = g.core.lang:getAttr(arg_2_1[var_2_2], arg_2_1[table.concat({
					"value",
					var_2_0
				}, "_")])
				local var_2_6 = {}

				var_2_6[#var_2_6 + 1] = var_2_4
				var_2_6[#var_2_6 + 1] = var_2_5
				var_2_3[#var_2_3 + 1] = table.concat({
					var_2_4,
					var_2_5
				})
			end

			var_2_0 = var_2_0 + 1
			var_2_2 = table.concat({
				"type",
				var_2_0
			}, "_")

			goto label_2_0
		until true

		var_2_7 = {}
	end

	var_2_7.attr = table.concat(var_2_3, "\t")

	self.m_attrTxt:setText(g.core.lang:get(431035, var_2_7))

	if arg_2_2:isActiveEvent(arg_2_1.id) then
		self.m_isActiveController:setSelectedIndex(1)
	else
		self.m_isActiveController:setSelectedIndex(0)

		if arg_2_2:getStar() < arg_2_1.unlock_star then
			self.m_stateTxt:setText(g.core.lang:get(431021, {
				star = arg_2_1.unlock_star
			}))
		else
			self.m_stateTxt:setText(g.core.lang:get(431028))
		end
	end

	self._cfg = arg_2_1
end

function SuccubaChatHandbookCell:_playChat()
	self:dispatchCompEvent("showInteraction", {
		cfg = self._cfg
	})
end

function SuccubaChatHandbookCell:_onClickMask()
	g.core.module.ModuleManager:tip(g.core.lang:get(431042))
end

return SuccubaChatHandbookCell
