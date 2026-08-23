local CommonAnimateConst = require("app.view.common.const.CommonAnimateConst")
local BasePanelCloseBtn = class("BasePanelCloseBtn", require("app.fairyGUI.base_new.UI_BaseCloseBtn"))

function BasePanelCloseBtn:ctor()
	self._callBack = nil
	self._func = nil
	self._closeTransition = nil
	self._hookName = nil
	self._inClose = false

	self:addClickListener(handler(self, self._onClose))
end

function BasePanelCloseBtn:_onClose()
	if self._inClose then
		return
	end

	if self._callBack then
		self._callBack()

		return
	end

	self._inClose = true

	if not self:_isHasCommonExitAnim() then
		self:_closeFunc()
	end
end

function BasePanelCloseBtn:setClickCallBack(arg_3_1)
	self._callBack = arg_3_1
end

function BasePanelCloseBtn:_isHasCommonExitAnim()
	local var_4_0 = g.core.module.ModuleManager:getCurModule()
	local var_4_1 = var_4_0 and var_4_0.display

	if var_4_0 and var_4_0.display then
		for iter_4_0, iter_4_1 in pairs(CommonAnimateConst) do
			if var_4_1:getChild(iter_4_0) then
				local var_4_2 = var_4_1:getChild(iter_4_0)
				local var_4_3 = false

				if var_4_2:getTransition("close") then
					var_4_2:getTransition("close"):play((handler(self, self._closeFunc)))

					var_4_3 = true
				end

				local var_4_4 = var_4_1:getView():getSharedTrans(iter_4_1.exitName, iter_4_1.compName)

				if var_4_3 then
					var_4_4:play()
				else
					var_4_4:play(handler(self, self._closeFunc))
				end

				return true
			end
		end
	end

	return false
end

function BasePanelCloseBtn:_closeFunc()
	if self._func then
		self._func()

		return
	end

	self:dispatchCompEvent("BasePanelCloseBtn:onClose")
	g.core.module.ModuleManager:popComponent()
end

function BasePanelCloseBtn:setClickFunc(arg_6_1)
	self._func = arg_6_1
end

function BasePanelCloseBtn:setCloseAnimAndCallBack(arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_1 then
		return
	end

	self._closeTransition = arg_7_1
	self._hookName = arg_7_2
	self._func = arg_7_3 or self._func
end

return BasePanelCloseBtn
