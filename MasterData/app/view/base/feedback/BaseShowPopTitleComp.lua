local BaseShowPopTitleComp = class("BaseShowPopTitleComp", require("app.fairyGUI.base_new.UI_BaseShowPopTitleComp"))

function BaseShowPopTitleComp:ctor()
	self._titleAttrs = nil

	self.m_enterTransition:play()
	self:_createActiveSpine()
end

function BaseShowPopTitleComp:update(arg_2_1)
	self._params = arg_2_1.data or {}

	if not self._params.id then
		return
	end

	local var_2_0 = g.core.model.User.UserTitleData:getTitleCfgInfoById(self._params.id)
	local var_2_1 = g.core.model.User.UserTitleData:getTitleAttrsById(self._params.id)

	self.m_titleNameComp:setText(var_2_0.name)
	self.m_titleIcon:setURL(g.core.common.Path:getTitleIcon(var_2_0.seen_icon))

	self._titleAttrs = var_2_1

	self.m_desLabelComp:setTitle(var_2_0.title_desc)

	if not next(var_2_1) then
		self.m_attrTxt:setVisible(false)
	else
		self.m_attrTxt:setVisible(true)

		local var_2_2 = ""

		for iter_2_0, iter_2_1 in ipairs(var_2_1) do
			var_2_2 = var_2_2 .. iter_2_1.name .. " " .. iter_2_1.value

			if iter_2_0 ~= #var_2_1 then
				var_2_2 = var_2_2 .. "  "
			end
		end

		self.m_attrTxt:enableRich()
		self.m_attrTxt:setText(g.core.lang:get(105507) .. "：" .. "[color=#24bd81]" .. var_2_2 .. "[/color]")
	end
end

function BaseShowPopTitleComp:_onAttrsItemRenderer(arg_3_1, arg_3_2)
	if self._titleAttrs[arg_3_1 + 1] then
		arg_3_2:updateAttr({
			name = self._titleAttrs[arg_3_1 + 1].name,
			value = self._titleAttrs[arg_3_1 + 1].value
		})
	end
end

function BaseShowPopTitleComp:_createActiveSpine()
	self.m_eff:addEffectSpine({
		anim = "play",
		name = "eff_ui_common_activate",
		y = 0,
		isLoop = false,
		remove = true,
		x = 0
	})
end

return BaseShowPopTitleComp
