local var_0_0 = g.core.model.User.explorationData
local var_0_1 = g.core.model.User.snapShotCacheData
local var_0_2 = g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER
local ExplorationFormationRentKnightCell = class("ExplorationFormationRentKnightCell", require("app.fairyGUI.exploration.UI_ExplorationFormationRentKnightCell"))

function ExplorationFormationRentKnightCell:ctor()
	self._params = nil
	self._formationData = var_0_0:getFormationData()

	self.m_touchArea:addClickListener(handler(self, self._onClickIcon))
end

function ExplorationFormationRentKnightCell:updateKnightCell(arg_2_1)
	self._params = arg_2_1

	self.m_headIcon:updateIcon({
		changeControllers = true,
		struct = arg_2_1.struct,
		icon = self:_getKnightIconUrl()
	})
	self.m_headIcon:setAdvanceLevel(0)
	self.m_headIcon:setStar(arg_2_1.struct:getStarLv())

	local var_2_0 = arg_2_1.svrHelperData.id

	self.m_isSelectController:setSelectedIndex(self._formationData:getNewSidByOriginSid(arg_2_1.svrHelperData.id) > 0 and 1 or 0)

	local var_2_1, var_2_2 = self._formationData:getTempHelper()

	if var_2_1 > 0 and var_2_2 > 0 then
		if var_2_0 == var_2_2 and arg_2_1.svrHelperData.uid == var_2_1 then
			self.m_isSelectController:setSelectedIndex(1)
		else
			self.m_isSelectController:setSelectedIndex(0)
		end
	end

	local var_2_3 = var_0_1:getSnapShot(var_0_2, arg_2_1.ownerId)

	if var_2_3 then
		self.m_nameTxt:setText(var_2_3.name or "")
	end
end

function ExplorationFormationRentKnightCell:isSelect()
	return self:isSelected()
end

function ExplorationFormationRentKnightCell:getSvrHelperData()
	return self._params.svrHelperData
end

function ExplorationFormationRentKnightCell:_onClickIcon()
	if self.m_isSelectController:getSelectedIndex() == 1 then
		return
	end

	if self._params then
		if self._formationData:isOtherUserKnightUsing() then
			g.core.module.ModuleManager:tip(g.core.lang:get(420675))

			return
		else
			g.core.network.GameNetProxy:send_C2S_FriendHelper_UseKnights({
				play_type = 1,
				use = {
					{
						uid = self._params.svrHelperData.uid,
						id = self._params.svrHelperData.id
					}
				}
			})
			self._formationData:saveTempHelper(self._params.svrHelperData.uid, self._params.svrHelperData.id)
			self:dispatchCompEvent("Select_Helper", {
				uid = self._params.svrHelperData.uid,
				sid = self._params.svrHelperData.id
			})
		end
	end
end

function ExplorationFormationRentKnightCell:getKnightSid()
	return self._params.svrHelperData.id
end

function ExplorationFormationRentKnightCell:_getKnightIconUrl()
	if self._params.svrHelperData and self._params.svrHelperData.skin and self._params.svrHelperData.skin > 0 then
		local var_7_0 = g.core.config.knight_base_info.fetch(self._params.svrHelperData.skin)

		if var_7_0 then
			return (g.core.common.Path:getKnightIconById(var_7_0.icon_id))
		end
	end
end

return ExplorationFormationRentKnightCell
