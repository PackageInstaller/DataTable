-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/model/BreachFormMasterDefenseFmtMo.lua

module("logic.extensions.breachformmaster.model.BreachFormMasterDefenseFmtMo", package.seeall)

local BreachFormMasterDefenseFmtMo = class("BreachFormMasterDefenseFmtMo", BaseCustomFmtMo)

function BreachFormMasterDefenseFmtMo:initParams(activityId)
	self.activityId = activityId
	self.isShowBtnSave = true

	local formationInfo = BreachFormMasterModel.instance:getOpponentInfo()
	local curForm = self:getCurFormation()
	local searchCutePetRaceId = formationInfo.playerView.curForm.extParams.cutePetRaceId
	local searchCutePetQuality = formationInfo.playerView.curForm.extParams.cutePetQuality

	if searchCutePetRaceId and searchCutePetQuality then
		local searchMo = CutePetModel.instance:searchCutePet(searchCutePetRaceId, searchCutePetQuality)

		if searchMo then
			formationInfo.playerView.curForm.extParams.cutePetId = searchMo.id
		end
	end

	curForm:SetData(formationInfo.playerView.curForm)

	local summonId, masterId = 0, 0

	for _, basePetView in ipairs((formationInfo or nil) and (formationInfo.playerView.petSimpleView or {})) do
		if checknumber(basePetView.summonMasterId) > 0 then
			masterId = checknumber(basePetView.summonMasterId)
		end

		if checknumber(basePetView.summonedPetId) > 0 then
			summonId = checknumber(basePetView.summonedPetId)
		end
	end

	if masterId > 0 and summonId > 0 then
		curForm:trySetSummonPetByMasterId(masterId, summonId)
	end

	self.startZdl = self:getCurFormation():getPowerAndSpeed()
	self._actCfg = BreachFormMasterConfig.instance:getActivityCfg(self.activityId)
end

function BreachFormMasterDefenseFmtMo:initSaveHandler()
	local function handler(fmtMo, fromBtnSave)
		if fromBtnSave == true then
			local isEmpty = self:getCurFormation():isEmpty()

			if isEmpty then
				local tip = langPara("守阵不能为空")

				TipsFacade.instance:openTipWindowNoX("提示", tip, function()
					return
				end)

				return
			end

			local saveTime = BreachFormMasterModel.instance:getTodaySetDefenseFormTimes(self.activityId)
			local haveTime = self._actCfg.dailySetDefenseFormTimes - saveTime

			if haveTime <= 0 then
				TipsFacade.instance:openCommonTips(lang("无调整次数"))

				return
			end

			local limitDown = self._actCfg.defenseFormZdlWanPercent[1]
			local limitUp = self._actCfg.defenseFormZdlWanPercent[2]
			local curZdl = self:getCurFormation():getPowerAndSpeed()

			if curZdl < limitDown or limitUp < curZdl then
				TipsFacade.instance:openCommonTips(lang("不符合战斗力要求"))

				return
			end

			local content = langPara("是否以此阵型作为防守阵容，修改后今日剩余%s次修改", haveTime - 1)

			TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
				local simpleForm = self:getCurSimpleForm()

				BreachFormMasterAgent.instance:sendPM_BreachFormMasterSetDefenseFormReq(self.activityId, simpleForm)
				FloatWordMgr.instance:show("保存成功")
				UIStateManager.instance:popByName(ViewName.CustomFormationView)
			end)

			return
		end
	end

	self.setSaveHandler(self, handler, self)
end

function BreachFormMasterDefenseFmtMo:getFormationExtendViewName()
	return ViewName.BreachFormMasterDeFmtView
end

function BreachFormMasterDefenseFmtMo:isClickCanCloseInFomation()
	local isEmpty = self:getCurFormation():isEmpty()

	if isEmpty then
		local tip = langPara("守阵不能为空")

		TipsFacade.instance:openPopupWindowWithX("提示", tip, function()
			self:setSaveHandler(nil, nil)
			UIStateManager.instance:popByName(ViewName.CustomFormationView)
		end)

		return false
	end

	return true
end

return BreachFormMasterDefenseFmtMo
