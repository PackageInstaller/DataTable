-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteampetView.lua

module("logic.extensions.aceteam.view.AceteampetView", package.seeall)

local AceteampetView = class("AceteampetView", ViewComponent)

function AceteampetView:ctor()
	AceteampetView.super.ctor(self)
end

function AceteampetView:unbindEvents()
	AceteampetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnOk)
	GameUtil.rmClickHandler(self.btnInfo)
end

function AceteampetView:bindEvents()
	AceteampetView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnOk, self.onOkClick, self)
	GameUtil.addClickHandler(self.btnInfo, self.onClickInfo, self)
end

function AceteampetView:buildUI()
	AceteampetView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnOk = self:getGo("btnOk")
	self.btnInfo = self:getGo("btnInfo")
	self.poster = self:getGo("teamInfo/poster")
	self.cell = self:getGo("teamInfo/cell")
	self.txtDesc = self:getTxt("teamInfo/desc/txtDesc")

	GameUtil.SetActive(self.cell, false)
end

function AceteampetView:onExit()
	AceteampetView.super.onExit(self)
	goutil.clearChildren(self.poster)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ACETEAM_GETINFO, self.onRefreshUI, self)
	UIEffectManager.instance:stopEffect(self._pmEff2)
end

function AceteampetView:onEnter()
	AceteampetView.super.onEnter(self)

	local params = self:getOpenParam()
	local activityId = checknumber(params[1])
	local groupId = checknumber(params[2])

	if groupId == 0 then
		groupId = 1
	end

	self.rcdTeamId = checknumber(AceTeamModel.instance.teamId)

	local cfg = AceTeamConfig.instance:getSeasonCfg(activityId)
	local teamCfg = AceTeamConfig.instance:getTeamCfgById(cfg.seasonId, groupId)

	self:showGroupPets(teamCfg, groupId)
	GlobalDispatcher:addListener(GlobalNotify.PM_ACETEAM_GETINFO, self.onRefreshUI, self)

	local effPath = "fx_ui_2021930/fx_ui_zhengbasai/fx_ui_xuanzezhandui_zhandui.prefab"

	self._pmEff2 = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 493.4, -283, true, nil, nil, nil, self)

	self._pmEff2:setParent(self.mainGO.transform)
	self._pmEff2:setScale(1)
end

function AceteampetView:onRefreshUI()
	if self.rcdTeamId ~= checknumber(AceTeamModel.instance.teamId) then
		UIStateManager.instance:popByName(ViewName.AceteamgroupView)
		self:close()
	end
end

function AceteampetView:showGroupPets(teamCfg, groupId)
	self.curSelectGroupId = groupId

	local list = AceTeamConfig.instance:getPetListByGroupId(groupId)

	self.txtDesc.text = teamCfg.desc

	local imgName = teamCfg.posterUrl

	uGuiUtil.setSpriteToImage(self.poster.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("aceteam", imgName))
	goutil.clearChildren(self.poster)

	for i, v in ipairs(list) do
		if checknumber(v.isShowAtPoster) == 1 then
			local cell = goutil.clone(self.cell)

			GameUtil.SetActive(cell, true)
			goutil.addChildToParent(cell, self.poster)

			if not v.pos then
				GameUtil.setAnchoredPos(cell, checknumber(v.pos[1]), checknumber(v.pos[2]))
				GameUtil.addClickHandler(cell, GameUtil.handler(self.onClickPet, self, v))

				local txtName = goutil.findChildTextComponent(cell, "name/txtName")
				local txtPower = goutil.findChildTextComponent(cell, "txtPower")
				local petMo = AceTeamModel.instance:getPetMoByCfgId(v.creepsMasterId, v.creepsId)

				txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, petMo.curFaceId)
				txtPower.text = petMo:getFightingPower()
			end
		end
	end
end

function AceteampetView:onClickPet(cfg)
	local petMo = AceTeamModel.instance:getPetMoByCfgId(cfg.creepsMasterId, cfg.creepsId)

	CommonTipsMgr.instance:showPetTips(petMo)
end

function AceteampetView:onOkClick()
	AceTeamController.instance:sendSelectTeam(self.curSelectGroupId)
end

function AceteampetView:onClickInfo()
	UIStateManager.instance:push(ViewName.AceteammemberView, self.curSelectGroupId)
end

return AceteampetView
