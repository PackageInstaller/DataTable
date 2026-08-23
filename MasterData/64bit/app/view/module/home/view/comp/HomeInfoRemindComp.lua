local var_0_0 = g.core.model.User.homeInfoRemindData
local var_0_1 = g.core.model.User.homeInfoRemindRewardData
local HomeConst = require("app.view.module.home.const.HomeConst")
local HomeInfoRemindOneKeyCfgData = require("app.view.module.home.model.HomeInfoRemindOneKeyCfgData")
local HomeInfoRemindComp = class("HomeInfoRemindComp", require("app.fairyGUI.home.UI_HomeInfoRemindComp"))

function HomeInfoRemindComp:ctor()
	self._isFirstEnter = true
	self._curInfoData = {}

	self.m_setBtn:addClickListener(handler(self, self._onSetBtnClicked))
	self.m_infoList:setVirtual(self)
	self.m_infoList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_infoList:doFairyBatching(false)
	self.m_oneKeyBtn:addClickListener(handler(self, self._onOneKeyBtnClick))
	self.m_tabComp:setSelectedIndex(0)
end

function HomeInfoRemindComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_HOME_REMIND_TIP_SETTING_CHANGED, self.updateContent, self)
	self:updateContent()
end

function HomeInfoRemindComp:onUnload()
	return
end

function HomeInfoRemindComp:_onRecOneKeyAward(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	var_0_1:onRecOneKeyAward(arg_4_4, arg_4_3)
end

function HomeInfoRemindComp:updateContent()
	self._curInfoData = {}

	local var_5_0 = var_0_0:getTipSelectData()

	for iter_5_0, iter_5_1 in pairs((var_0_0:getTipMap())) do
		if not var_5_0[tostring(iter_5_0)] then
			local var_5_1 = {}

			for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
				if not iter_5_3:isHide() then
					var_5_1[#var_5_1 + 1] = iter_5_3
				end
			end

			if #var_5_1 > 0 then
				self._curInfoData[#self._curInfoData + 1] = {
					functionId = iter_5_0,
					list = var_5_1
				}
			end
		end
	end

	table.sort(self._curInfoData, function(arg_6_0, arg_6_1)
		return arg_6_0.functionId < arg_6_1.functionId
	end)
	self.m_isEmptyController:setSelectedIndex(0)

	if #self._curInfoData < 1 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self:_updateInfoList()
	end
end

function HomeInfoRemindComp:_updateInfoList()
	self.m_infoList:setNumItems(#self._curInfoData)

	if #self._curInfoData > 0 then
		self.m_infoList:setSelectedIndex(0)
	end
end

function HomeInfoRemindComp:_onItemRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateItem(self._curInfoData[arg_8_1 + 1])
end

function HomeInfoRemindComp:_onOneKeyBtnClick()
	var_0_1:setNetInfoQueenData()
end

function HomeInfoRemindComp:receiveCompEvent(arg_10_1, arg_10_2)
	if arg_10_1 == "clickTip" then
		var_0_0:delTipData(arg_10_2.data)
		self:_doJump(arg_10_2.data)

		return true
	elseif arg_10_1 == "refreshComp" then
		self:updateContent()

		return true
	end
end

function HomeInfoRemindComp:_doJump(arg_11_1)
	local var_11_0 = arg_11_1:getJumpFunc()

	if var_11_0 then
		var_11_0()
	end
end

function HomeInfoRemindComp:_onSetBtnClicked()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.home.view.HomeInfoRemindSettingPop").new()))
end

return HomeInfoRemindComp
