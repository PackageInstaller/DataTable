local FogNightmareKeepsakeSuitListComp = class("FogNightmareKeepsakeSuitListComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareKeepsakeSuitListComp"))

function FogNightmareKeepsakeSuitListComp:ctor()
	self._suitDataList = {}

	self:_initComp()
end

function FogNightmareKeepsakeSuitListComp:_initComp()
	self.m_list:setVirtual(self)
	self.m_list:setItemRenderer(handler(self, self._onRenderListItem))
end

function FogNightmareKeepsakeSuitListComp:_onRenderListItem(arg_3_1, arg_3_2)
	arg_3_2:updateComp(self._suitDataList[arg_3_1 + 1])
end

function FogNightmareKeepsakeSuitListComp:updateComp()
	self._suitDataList = {}

	for iter_4_0, iter_4_1 in pairs((g.core.model.User.fogNightmareData:getKeepsakeData():getSuitInfo())) do
		self._suitDataList[iter_4_0] = iter_4_1
	end

	table.sort(self._suitDataList, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_0:getActiveNum()
		local var_5_1 = arg_5_1:getActiveNum()

		if var_5_0 ~= var_5_1 then
			return var_5_1 < var_5_0
		end

		local var_5_2 = arg_5_0:getActiveKeepsakeNum() / arg_5_0:getEffectInfoByIndex(var_5_0 + 1).targetNum
		local var_5_3 = arg_5_1:getActiveKeepsakeNum() / arg_5_1:getEffectInfoByIndex(var_5_0 + 1).targetNum

		if var_5_2 ~= var_5_3 then
			return var_5_3 < var_5_2
		end

		return arg_5_0:getCfg().id < arg_5_1:getCfg().id
	end)
	self.m_list:setNumItems(#self._suitDataList)
end

function FogNightmareKeepsakeSuitListComp:showAllSuitListComp()
	if self.m_hideIconController:getSelectedIndex() == 0 then
		self.m_list:resizeToFit(math.min(4, #self._suitDataList))
	else
		self.m_list:resizeToFit(#self._suitDataList)
	end
end

function FogNightmareKeepsakeSuitListComp:switchSuitByKeepsake(arg_7_1, arg_7_2)
	local var_7_0 = 0
	local var_7_1 = 0

	if arg_7_1 and arg_7_1:getBaseInfo().suit_id > 0 then
		var_7_0 = arg_7_1:getBaseInfo().suit_id
	end

	if arg_7_2 and arg_7_2:getBaseInfo().suit_id > 0 then
		var_7_1 = arg_7_2:getBaseInfo().suit_id
	end

	if var_7_0 > 0 or var_7_1 > 0 then
		for iter_7_0, iter_7_1 in ipairs(self._suitDataList) do
			if iter_7_1:getCfg().id == var_7_0 then
				self.m_list:getChildAt((self.m_list:itemIndexToChildIndex(iter_7_0 - 1))):updateActiveUI(-1)

				var_7_0 = 0
			elseif iter_7_1:getCfg().id == var_7_1 then
				self.m_list:getChildAt((self.m_list:itemIndexToChildIndex(iter_7_0 - 1))):updateActiveUI(1)

				var_7_1 = 0
			end

			if var_7_0 == 0 and var_7_1 == 0 then
				break
			end
		end
	end
end

function FogNightmareKeepsakeSuitListComp:playSuitEffectAnim(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs((self.m_list:getChildren())) do
		iter_8_1:hideEffect()
	end

	if arg_8_1 == 0 then
		return
	end

	for iter_8_2, iter_8_3 in ipairs(self._suitDataList) do
		if iter_8_3:getCfg().id == arg_8_1 then
			var_8_0 = iter_8_2 - 1

			break
		end
	end

	self.m_list:getChildAt((self.m_list:itemIndexToChildIndex(var_8_0))):playAnim(arg_8_2, arg_8_3)
end

return FogNightmareKeepsakeSuitListComp
