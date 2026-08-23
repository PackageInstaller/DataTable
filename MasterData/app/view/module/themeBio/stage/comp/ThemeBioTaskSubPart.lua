local var_0_0 = g.core.common.Drops
local var_0_1 = g.core.model.User.themeData
local ThemeBioTaskSubPart = class("ThemeBioTaskSubPart", require("app.fairyGUI.themeBio.UI_ThemeBioTaskSubPart"))

function ThemeBioTaskSubPart:ctor()
	self._ownerStage = nil
	self._tmpAwardArr = nil
	self._tmpRefMission = nil
	self.m_stateController = self:getController("state")
	self.m_infoTxt = self:getChild("infoTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_goBtn = self:getChild("goBtn")

	self:_initRegisterUI()
end

function ThemeBioTaskSubPart:onLoad()
	return
end

function ThemeBioTaskSubPart:onUnload()
	self._ownerStage = nil
	self._tmpAwardArr = nil
	self._tmpRefMission = nil
end

function ThemeBioTaskSubPart:startUp(arg_4_1)
	self._ownerStage = arg_4_1
end

function ThemeBioTaskSubPart:refreshTask(arg_5_1, arg_5_2, arg_5_3)
	self._activeThemeValue = arg_5_3
	self._themeBioData = var_0_1:getThemeData(self._activeThemeValue):getThemeBioData()

	if arg_5_1.branch_type == 1 then
		local var_5_0 = self._themeBioData:getMission(arg_5_1.missions[arg_5_1.current])
		local var_5_1 = self._themeBioData:getMission(arg_5_1.missions[#arg_5_1.missions])

		self.m_infoTxt:setText(var_5_0.description)

		self._tmpAwardArr = {}

		if var_5_1.reward_first > 0 then
			self._tmpAwardArr = var_0_0:getGoodsArray(var_5_1.reward_first)
		end

		if var_5_0.type == 2 and var_5_0.sub_id > 0 then
			local var_5_3 = g.core.config.theme_biography_event_info.get(var_5_0.sub_id)

			if var_5_3.event_type == 3 then
				self._tmpAwardArr = var_0_0:getGoodsArray(var_5_3.event_value_1)

				if var_5_3.event_value_2 > 0 then
					for iter_5_0, iter_5_1 in ipairs((var_0_0:getGoodsArray(var_5_3.event_value_2))) do
						table.insert(self._tmpAwardArr, iter_5_1)
					end
				end
			end
		end

		self.m_awardList:setNumItems(#self._tmpAwardArr)

		self._tmpRefMission = var_5_0

		self.m_stateController:setSelectedIndex(arg_5_2)
	elseif arg_5_1.branch_type ~= 3 then
		if arg_5_1.branch_type == 5 then
			local var_5_5

			for iter_5_2, iter_5_3 in pairs(arg_5_1.missions) do
				local var_5_6 = self._themeBioData:getMission(iter_5_3)

				if var_5_6.isFirst and not var_5_6.finish then
					var_5_5 = var_5_6

					break
				end

				if var_5_6.isLast then
					var_5_5 = var_5_6
				end
			end

			if var_5_5 then
				self.m_infoTxt:setText(var_5_5.description)

				if arg_5_1.branch_type == 5 then
					self.m_stateController:setSelectedIndex(3)
				else
					self.m_stateController:setSelectedIndex(var_5_5.finish and 1 or 0)
				end

				self._tmpAwardArr = var_5_5.reward_first > 0 and var_0_0:getGoodsArray(var_5_5.reward_first) or {}

				self.m_awardList:setNumItems(#self._tmpAwardArr)

				self._tmpRefMission = var_5_5
			end
		end
	end
end

function ThemeBioTaskSubPart:_initRegisterUI()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))

	if self.m_goBtn then
		self.m_goBtn:addClickListener(handler(self, self._onTaskGotoClick))
	end
end

function ThemeBioTaskSubPart:_onRenderAwardList(arg_7_1, arg_7_2)
	self._tmpAwardArr[arg_7_1 + 1].hideNum = false

	arg_7_2:updateIcon(self._tmpAwardArr[arg_7_1 + 1])
end

function ThemeBioTaskSubPart:_onTaskGotoClick()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_BIO_SEARCH_PATH_TARGET, false, {
		type = 2,
		mission = self._tmpRefMission
	})
	g.core.module.ModuleManager:popComponent()
end

return ThemeBioTaskSubPart
