local NewSlgFarmConfirmPop = class("NewSlgFarmConfirmPop", function()
	return fgui.GComponent:create({
		resName = "NewSlgFarmConfirmPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgFarmConfirmPop:ctor(arg_2_1)
	self:getView():center(true)

	arg_2_1 = arg_2_1 or {}
	self._id = arg_2_1.id
	self._tp = arg_2_1.tp
	self._handlerParam = arg_2_1.handlerParam
	self._compQuick = self:getChild("Comp_quick")
	self._compAchieve = self:getChild("Comp_achieve")
	self._btnOk = self:getChild("Btn_ok")

	self._btnOk:addClickListener(handler(self, self._onClickBtnOk))

	self._btnCancel = self:getChild("Btn_cancel")

	self._btnCancel:addClickListener(handler(self, self._onClickBtnCancel))

	local var_2_0 = g.core.model.User.newSlgData:getMaxFarmCount(self._id)

	self:_updateView(1)
end

function NewSlgFarmConfirmPop:receiveCompEvent(arg_3_1, arg_3_2)
	if arg_3_1 == "ComQuickCount_change" then
		self:_updateView(arg_3_2.num)
	end
end

function NewSlgFarmConfirmPop:_updateView(arg_4_1)
	local var_4_0 = g.core.model.User.newSlgData:getFarmInfoById(self._id)

	self._compAchieve:updateView({
		title = "",
		onlySize = true,
		colorIndex = 1,
		type = var_4_0.reward_type,
		value = var_4_0.reward_value,
		size = var_4_0.reward_size * arg_4_1
	})
end

function NewSlgFarmConfirmPop:_onClickBtnOk()
	self:dispatchCompEvent("NewSlgFarmConfirmPop_ok", {
		tp = self._tp,
		content = self._handlerParam
	})

	if not tolua.isnull(self) then
		self:removeSelf()
	end
end

function NewSlgFarmConfirmPop:_onClickBtnCancel()
	self:removeSelf()
end

return NewSlgFarmConfirmPop
