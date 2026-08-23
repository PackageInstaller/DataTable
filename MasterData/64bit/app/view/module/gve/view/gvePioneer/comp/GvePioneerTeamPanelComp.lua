local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.gveDataMgr
local GvePioneerTeamPanelComp = class("GvePioneerTeamPanelComp", require("app.fairyGUI.gve.UI_GvePioneerTeamPanelComp"))

function GvePioneerTeamPanelComp:ctor()
	self.m_lookBtn:addClickListener(handler(self, self._onClickPioneerTeamTipsBtn))
	self.m_editBtn:addClickListener(handler(self, self._onClickEditPioneerTeamInfoBtn))
end

function GvePioneerTeamPanelComp:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateTeamPanel, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, self._updateTeamPanel, self)
	self:_updateTeamPanel()
end

function GvePioneerTeamPanelComp:_onS2CGetTeamInfo()
	self:_updateTeamPanel()
	self:dispatchCompEvent("S2C_GET_TEAMINFO_UPDATE")
end

function GvePioneerTeamPanelComp:_onS2CTeamModify()
	self:_updateTeamPanel()
end

function GvePioneerTeamPanelComp:_updateTeamPanel()
	self.m_uidTxt:setText(var_0_2:getPioneerTeamId())
	self.m_teamNameTxt:setText(var_0_2:getPioneerTeamName())
	self.m_teamIconLoader:setURL((g.core.common.Path:getAllianceFlag256(var_0_2:getPioneerTeamIconId())))

	local var_5_0 = var_0_2:getPioneerTeamLeader()

	self.m_hasLeaderController:setSelectedIndex(var_5_0 and 1 or 0)

	if not var_5_0 then
		return
	end

	local var_5_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_5_0.id)

	if var_5_1 then
		self.m_leaderNameTxt:setText(var_5_1.name)
		self.m_leaderIcon:updateAsUser(var_5_1)
		self.m_serverNameTxt:setText(var_5_1.server_name)

		local var_5_2 = var_0_2:isModifyTeamInfo()
	end
end

function GvePioneerTeamPanelComp:_onClickPioneerTeamTipsBtn()
	self:addPopup(require("app.view.module.gve.view.gvePioneer.GvePioneerTeamTipsPop").new())
end

function GvePioneerTeamPanelComp:_onClickEditPioneerTeamInfoBtn()
	self:addPopup(require("app.view.module.gve.view.gvePioneer.GvePioneerTeamEditInfoPop").new())
end

return GvePioneerTeamPanelComp
