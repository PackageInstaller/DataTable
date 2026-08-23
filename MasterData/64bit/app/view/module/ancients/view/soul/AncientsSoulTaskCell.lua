local AncientsSoulTaskCell = class("AncientsSoulTaskCell", require("app.fairyGUI.ancients.UI_AncientsSoulTaskCell"))

function var_0_0:ctor()
	self._taskGetEffect = nil

	self.getSharedTrans(self, "enter_up", "CommonShortCellList", self)
	self.m_List_award:setVirtual(self)
	self.m_List_award:setItemRenderer(handler(self, self._onRenderListAwardCell))
	self.m_Btn_get:addClickListener(handler(self, self._onClickBtnGet))
	self.m_Btn_get:setDelayClickEnable(true)
	self.m_Btn_go:setDelayClickEnable(true)
	self.m_Btn_go:addClickListener(handler(self, self._onClickBtnGo))
end

function var_0_0:updateCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._taskCfg = arg_2_1

	self.m_Txt_desc:setText(g.core.lang:getByString(arg_2_1.task_describe, {
		num = arg_2_1.goal
	}))

	self._awardArray = {}

	for iter_2_0, iter_2_1, iter_2_2 in arg_2_1.gmatch({
		"reward_type_%d+",
		"reward_value_%d+",
		"reward_size_%d+"
	}) do
		if iter_2_2[1] ~= 0 then
			table.insert(self._awardArray, {
				scaleIndex = 4,
				type = iter_2_2[1],
				value = iter_2_2[2],
				size = iter_2_2[3]
			})
		end
	end

	self.m_List_award:setNumItems(#self._awardArray)
	self.m_Txt_prog:setText(g.core.lang:get(202022, {
		num1 = g.core.model.User.ancientsData:getTaskSerData(arg_2_1.id).value,
		num2 = arg_2_1.goal
	}))

	local var_2_0 = g.core.model.User.ancientsData:getTaskState(arg_2_1)
	local var_2_1 = {
		[0] = 1,
		0,
		2
	}

	self.m_stateController:setSelectedIndex(var_2_1[var_2_0])

	if var_2_1[var_2_0] == 1 then
		if not self._taskGetEffect then
			self._taskGetEffect = self.m_taskGetEffect:addEffectSpine({
				name = "eff_ui_ancients_petbtnlight",
				anim = "play",
				isLoop = true
			})
		else
			self._taskGetEffect:setVisible(true)
		end
	elseif self._taskGetEffect then
		self._taskGetEffect:setVisible(false)
	end
end

function var_0_0:_onRenderListAwardCell(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awardArray[arg_3_1 + 1])
end

function var_0_0:_onClickBtnGet()
	g.core.network.GameNetProxy:send_C2S_Ancient_TaskAward({
		ids = {
			self._taskCfg.id
		}
	})
end

function var_0_0:_onClickBtnGo()
	if self._taskCfg.source_id ~= 0 then
		g.view.entrance.ModuleGotoProxy:gotoModule(self._taskCfg.source_id)
	end
end

return var_0_0
