local FogNightmareCmdUI = class("FogNightmareCmdUI", (require("app.view.module.fogNightmare.model.struct.execute.FogNightmareCmdBase")))

function FogNightmareCmdUI:ctor(arg_1_1)
	FogNightmareCmdUI.super.ctor(self, arg_1_1)

	self._UIName = nil
	self._UIChildren = {}
	self._rootNode = arg_1_1.rootNode
	self._visible = arg_1_1.visible or true
	self._UIName, self._UIChildren = self:_getUIInfo(arg_1_1.UIPath)
	self._showUIName = self._UIName
	self._showUIChildren = self._UIChildren
	self._showRootNode = arg_1_1.showRootNode or self._rootNode

	if arg_1_1.showUIPath then
		self._showUIName, self._showUIChildren = self:_getUIInfo(arg_1_1.showUIPath)
	end

	self._comp = nil
	self._compParam = arg_1_1.UIParam
end

function FogNightmareCmdUI:_getUIInfo(arg_2_1)
	local var_2_0 = arg_2_1:split(":")

	return var_2_0[1], (var_2_0[2] or nil) and (var_2_0[2]:split("/") or {})
end

function FogNightmareCmdUI:_isTrigger()
	return self:_isUIVisibleMatch() and FogNightmareCmdUI.super._isTrigger(self, self._comp)
end

function FogNightmareCmdUI:_isUIVisibleMatch()
	local var_4_1 = self._showRootNode

	if not self._showRootNode then
		local var_4_2 = g.core.module.ModuleManager:getCurModule()

		if var_4_2.display:getName() == self._showUIName then
			var_4_1 = var_4_2.display
		end
	elseif type(self._showRootNode) == "function" then
		var_4_1 = self._showRootNode()
	end

	local var_4_3 = self:_getComp(var_4_1, self._showUIChildren)
	local var_4_4 = var_4_3 ~= nil and var_4_3:isVisible() == self._visible

	if var_4_4 then
		local var_4_5 = self._rootNode

		if not self._rootNode then
			var_4_5 = g.core.module.ModuleManager:getCurModule().display
		elseif type(self._rootNode) == "function" then
			var_4_5 = self._rootNode()
		end

		local var_4_6 = var_4_5:getName()

		self._comp = self:_getComp(var_4_5, self._UIChildren)

		assert(self._comp, string.format("FogNightmareCmdUI can not find comp in path : %s:%s", var_4_6, table.concat(self._UIChildren, "/")))
	end

	return var_4_4
end

function FogNightmareCmdUI:_getComp(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1

	while var_5_0 and 1 <= #arg_5_2 do
		var_5_0 = var_5_0:getChild(arg_5_2[1])

		if not var_5_0 then
			break
		end
	end

	return var_5_0
end

function FogNightmareCmdUI:_onExecuteSelf()
	if self._compParam.type == "list" then
		self._comp:getChildAt((self._comp:itemIndexToChildIndex(self._compParam.selectIdx))):dispatchEvent(fgui.UIEventType.Click)
	else
		self._comp:dispatchEvent(fgui.UIEventType.Click)
	end
end

return FogNightmareCmdUI
