local BaseInputPop = class("BaseInputPop", require("app.fairyGUI.base_new.UI_BaseInputPop"), function()
	return fgui.GComponent:create({
		pkgName = "base_new",
		resName = "BaseInputPop",
		pkgPath = "ui/base_new/base_new"
	})
end)

function BaseInputPop:ctor(arg_2_1)
	self:showAtCenter()

	self._params = arg_2_1

	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirm))
	self.m_popPanel:setTitle(arg_2_1.title)

	local var_2_0 = {}

	var_2_0.maxLength = arg_2_1.length or 20
	var_2_0.placeHolder = arg_2_1.placeHolder or ""
	var_2_0.text = arg_2_1.initText or ""

	self:setProperties("Label_prompt", var_2_0)
	self.m_confirmBtn:setText(arg_2_1.btnTitle)
	self.m_Label_prompt:disableAutoChange()

	if arg_2_1.isMulti then
		self.m_Label_prompt:setKeyboardType(0)
	end

	local var_2_1 = self.m_Txt_Count

	self.m_Txt_Count:setVisible(false)

	if arg_2_1.showCnt then
		var_2_1:setVisible(true)
		var_2_1:setText(g.core.lang:get(201607, {
			num = 0,
			max = arg_2_1.length
		}))
	end

	g.core.utils.Black:filterBlackOnInput(self.m_Label_prompt)
	self.m_Label_prompt:addEventListener(fgui.UIEventType.Changed, handler(self, self._onClickSubmit))
end

function BaseInputPop:_onClickSubmit()
	if self._params.showCnt then
		self.m_Txt_Count:setText(g.core.lang:get(201607, {
			num = g.core.lang:getStringLength(self.m_Label_prompt:getText()),
			max = self._params.length
		}))
	end
end

function BaseInputPop:_onClickConfirm()
	self:dispatchCompEvent("input_pop_confirm", {
		bindInfo = self._params.bindInfo,
		text = g.core.utils.Black:filterBlack(self.m_Label_prompt:getText())
	})
end

return BaseInputPop
