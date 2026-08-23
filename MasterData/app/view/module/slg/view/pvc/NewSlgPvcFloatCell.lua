local NewSlgPvcFloatCell = class("NewSlgPvcFloatCell")

function NewSlgPvcFloatCell:ctor()
	self._txtDesc = self:getChild("Txt_desc")
	self._txtCountDown = self:getChild("Txt_countDown")
	self._compProg = self:getChild("Comp_prog")
	self._btnGather = self:getChild("Btn_gather")

	self._btnGather:addClickListener(handler(self, self._onClickBtnGather))

	self._countDownCtrl = self:getController("count_down")
end

function NewSlgPvcFloatCell:updateCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._compId = arg_2_1.compId
	self._cellData = arg_2_1

	self._txtDesc:setText(arg_2_1.desc)

	if arg_2_1.startTime or arg_2_1.progress then
		self._countDownCtrl:setSelectedIndex(1)

		if arg_2_1.startTime then
			self._compProg:setMax(arg_2_1.totalTime)

			local var_2_0 = arg_2_1.startTime + arg_2_1.totalTime - g.core.common.ServerTime:getTime()

			self._compProg:setValue(var_2_0)
			self._txtCountDown:setText((g.core.common.ServerTime:secondToHMSString(var_2_0)))
		else
			self._compProg:setMax(arg_2_1.goal)
			self._compProg:setValue(arg_2_1.progress)
			self._txtCountDown:setText(g.core.lang:get(428977, {
				num1 = arg_2_1.progress,
				num2 = arg_2_1.goal
			}))
		end
	else
		self._countDownCtrl:setSelectedIndex(0)
	end
end

function NewSlgPvcFloatCell:_onClickBtnGather()
	if not g.core.model.User.newSlgData:isPlaying() then
		return
	end

	if not self._compId then
		g.core.module.ModuleManager:popComponent()
		g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_MAIN)
	else
		local var_3_0 = g.core.model.User.newSlgData:getComponentCfg(self._compId)

		g.core.module.ModuleManager:popComponent()
		g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_MAIN, {
			route1 = cc.p(var_3_0.anchor_x, var_3_0.anchor_y)
		})
	end
end

return NewSlgPvcFloatCell
