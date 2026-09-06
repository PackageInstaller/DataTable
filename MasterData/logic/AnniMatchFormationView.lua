-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/mission/AnniMatchFormationView.lua

module("logic.extensions.annimatch.view.mission.AnniMatchFormationView", package.seeall)

local AnniMatchFormationView = class("AnniMatchFormationView", FormationView)

function AnniMatchFormationView:onEnter()
	AnniMatchFormationView.super.onEnter(self)
end

function AnniMatchFormationView:buildUI()
	AnniMatchFormationView.super.buildUI(self)
	goutil.setActive(self._btnShare.gameObject, false)
	goutil.setActive(self._btnRecFormation.gameObject, false)

	self._fmt = self:getGo("fmtBuff/fmt")

	self._btnSingleLine:Layout()
end

function AnniMatchFormationView:onExit()
	AnniMatchFormationView.super.onExit(self)
end

function AnniMatchFormationView:onEnter()
	AnniMatchFormationView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 508001
	end

	self._formId = checknumber(params[2])
	self._formCfg = AnnimatchConfig.instance:getFormCfg(self._activityId, self._formId)

	self:_updateFmtUI()
end

function AnniMatchFormationView:_onClickSave()
	local activityId = self._viewPresentor:getFirstParam()
	local fmo = AnnimatchModel.instance:getFormationMo(activityId)

	AnnimatchController.instance:sendSetForm(activityId, fmo)
	self:close()
end

function AnniMatchFormationView:_onClickClose()
	local activityId = self._viewPresentor:getFirstParam()

	AnnimatchModel.instance:resetFormation(activityId)
	self:close()
end

function AnniMatchFormationView:_updateFmtUI()
	local activityId = AnnimatchController.instance:getCurrActId()
	local info = AnnimatchModel.instance:getInfo(activityId)

	if info then
		if not info.formId then
			local formId = 1
			local formCfg = AnnimatchConfig.instance:getFormCfg(activityId, formId) or {}
			local posList = formCfg.posList

			for i = 1, 9 do
				local img = goutil.findChild(self._fmt, "img_" .. i)
				local isInPos = table.indexof(posList, i)

				GameUtil.SetActive(img, isInPos)
			end
		end
	end
end

return AnniMatchFormationView
