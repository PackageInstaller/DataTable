local ShowRepeatAwardComp = class("ShowRepeatAwardComp", require("app.fairyGUI.infoPop.UI_ShowRepeatAwardComp"))
local var_0_1 = g.core.const.ConstMgr.ShowConst
local var_0_2 = g.core.config
local var_0_3 = g.core.common.Goods
local var_0_4 = g.core.lang

function ShowRepeatAwardComp:update(arg_1_1)
	local var_1_0 = arg_1_1.data.good or {}
	local var_1_1 = arg_1_1.data.num or 1
	local var_1_2 = var_1_0.type

	if not var_1_0.repeatGood.size then
		-- block empty
	end

	local var_1_4 = var_0_1.SHOW_REPEAT_TYPE[var_1_2]
	local var_1_5 = var_0_2[var_0_1.SHOW_REPEAT_TYPE[var_1_2]].get(var_1_0.value)

	self._pType = var_1_2

	local var_1_6 = {
		type = var_1_5.repeat_type,
		value = var_1_5.repeat_value
	}

	if var_0_2[var_0_1.SHOW_REPEAT_TYPE[var_1_2]].hasKey("repeat_number") then
		var_1_6.size = var_1_5.repeat_number * var_1_1
	elseif var_0_2[var_0_1.SHOW_REPEAT_TYPE[var_1_2]].hasKey("repeat_size") then
		var_1_6.size = var_1_5.repeat_size * var_1_1
	else
		assert(false, "pls check repeat num key, tab name is: " .. var_1_4)
	end

	local var_1_7 = var_0_3:convert(var_1_6)
	local var_1_8
	local var_1_9 = true

	self.m_childComp:setVisible(false)

	if var_1_2 == var_0_3.TYPE_AVATAR_FRAME then
		var_1_8 = 103008
	elseif var_1_2 == var_0_3.TYPE_AVATAR then
		var_1_8 = 103009
	elseif var_1_2 == var_0_3.TYPE_TITLE then
		var_1_8 = 103010
	elseif var_1_2 == var_0_3.TYPE_SKIN then
		var_1_8 = 103011
	elseif var_1_2 == var_0_3.TYPE_SCENE_SKIN then
		var_1_9 = false

		self.m_childComp:setVisible(true)
		self:_showSceneItemComp(var_1_5)

		var_1_8 = 103017
	elseif var_1_2 == var_0_3.TYPE_FACE_GROUP then
		var_1_8 = 103018
	elseif var_1_2 == var_0_3.TYPE_SUCCUBA then
		var_1_8 = 431043
	end

	self.m_descText:setText(var_0_4:get(var_1_8, {
		name = var_1_7.name
	}))

	var_1_0.hideNum = true

	self.m_icon1:setVisible(var_1_9)

	if var_1_9 then
		self.m_icon1:updateIcon(var_1_0)
	end

	self.m_icon2:updateIcon(var_1_7)
end

function ShowRepeatAwardComp:_showSceneItemComp(arg_2_1)
	self._sceneComp = fgui.UIPackage:createObject("infoPop", "SceneSkinItemComp")

	self._sceneComp:setTitle(arg_2_1.name or "")
	self._sceneComp:setIcon(g.core.common.Path:getMainSceneIcon(arg_2_1.id) or "")
	self.m_childComp:addChild(self._sceneComp)
end

return ShowRepeatAwardComp
