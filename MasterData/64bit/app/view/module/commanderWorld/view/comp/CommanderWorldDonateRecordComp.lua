local var_0_0 = g.core.model.User.commanderWorldData
local var_0_1 = g.core.const.ConstMgr.CommanderWorldConst
local CommanderWorldDonateRecordComp = class("CommanderWorldDonateRecordComp", require("app.fairyGUI.commanderWorld.UI_CommanderWorldDonateRecordComp"))

function CommanderWorldDonateRecordComp:ctor()
	self._serverType = var_0_1.SERVER_TYPE.LOCAL

	self.m_expandBtn:addClickListener(handler(self, self._onClickExpandBtn))

	self._recordList = {}

	self.m_recordList:setVirtual()
	self.m_recordList:setItemRenderer(handler(self, self._onRenderRecordList))
	self.m_recordList:setScrollEnabled(false)
	self.m_isEmptyController:setSelectedIndex(1)
end

function CommanderWorldDonateRecordComp:_onRenderRecordList(arg_2_1, arg_2_2)
	if self._recordList[arg_2_1 + 1] then
		local var_2_0 = var_0_0:getBarrageStyle({
			guild = self._recordList[arg_2_1 + 1].guild_name,
			name = self._recordList[arg_2_1 + 1].user_name,
			num = self._recordList[arg_2_1 + 1].item_num * var_0_0:getItemAddScoreByItemId(self._recordList[arg_2_1 + 1].item_id).guildScore
		})

		if self._serverType == var_0_1.SERVER_TYPE.CROSS then
			local var_2_1 = var_0_0:getServerNameBySid(self._recordList[arg_2_1 + 1].sid)

			if var_2_1 then
				var_2_0 = g.core.lang:get(410312, {
					server = var_2_1
				}) .. var_2_0
			end
		end

		arg_2_2:setTitle(var_2_0)
	end
end

function CommanderWorldDonateRecordComp:updateRecord(arg_3_1)
	arg_3_1 = arg_3_1 or var_0_1.SERVER_TYPE.LOCAL
	self._serverType = arg_3_1
	self._recordList = var_0_0:getDonateRecordByServerType(arg_3_1)

	self.m_isEmptyController:setSelectedIndex(#self._recordList > 0 and 0 or 1)
	self.m_recordList:setNumItems(#self._recordList)
	self.m_recordList:scrollToView(#self._recordList - 1)
end

function CommanderWorldDonateRecordComp:_onClickExpandBtn()
	local var_4_0 = self.m_expandBtn:isSelected()

	self.m_recordList:setScrollEnabled(var_4_0)

	if var_4_0 then
		self.m_recordList:resizeToFit(var_0_1.RECORD_FIT_NUM)
	else
		self.m_recordList:resizeToFit(1)
	end

	self.m_recordList:scrollToView(#self._recordList - 1)
end

return CommanderWorldDonateRecordComp
