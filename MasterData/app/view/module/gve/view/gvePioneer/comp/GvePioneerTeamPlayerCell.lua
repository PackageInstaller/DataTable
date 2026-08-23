local var_0_0 = g.core.model.User
local var_0_1 = g.core.config.gve_equipment_info
local var_0_2 = g.core.config.gve_task_group_info
local var_0_4 = g.core.model.User.gveDataMgr
local GvePioneerTeamPlayerCell = class("GvePioneerTeamPlayerCell", require("app.fairyGUI.gve.UI_GvePioneerTeamPlayerCell"))

function GvePioneerTeamPlayerCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function GvePioneerTeamPlayerCell:updateMatchPlayerCell(arg_2_1)
	self.m_isSelfController:setSelectedIndex(0)

	local var_2_0 = var_0_1.fetch(arg_2_1.halidom_id)

	if var_2_0 then
		local var_2_1 = var_0_4:getGveBagData():getBranchCfgByBranchId(var_2_0.job)

		if var_2_1 then
			self.m_halidomIconLoader:setURL((g.core.common.Path:getHalidomResourceById(var_2_1.small_grey_icon)))
			self.m_halidomIconBg:setVisible(true)
		else
			self.m_halidomIconLoader:setURL("")
			self.m_halidomIconBg:setVisible(false)
		end

		self.m_lvTxt:setText(g.core.lang:get(120) .. var_2_0.level)
	end

	local var_2_2 = var_0_2.fetch((arg_2_1.task_group_id > 0 or nil) and (arg_2_1.task_group_id or 1))

	if var_2_2 then
		self.m_titleNameTxt:setText(var_2_2.title_name)
	else
		self.m_titleNameTxt:setText("")
	end

	local var_2_3 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.user_id)

	if var_2_3 then
		self.m_playerNameTxt:setText(var_2_3.name)
		self.m_serverNameTxt:setText(var_2_3.server_name)

		if var_2_3.id == var_0_0:getId() then
			var_2_3.avata_id = var_0_0:getAvataId()
			var_2_3.frame_id = var_0_0:getFrameId()

			self.m_isSelfController:setSelectedIndex(1)
		end

		self.m_userIcon:updateAsUser(var_2_3)
	end
end

return GvePioneerTeamPlayerCell
