-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessmissionView.lua

module("logic.extensions.autochess.view.AutochessmissionView", package.seeall)

local AutochessmissionView = class("AutochessmissionView", MissionView)

function AutochessmissionView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._petButton:AddClickListener(self._onClickPet, self)
	self._startBtn:AddClickListener(self._onClickStart, self)
	self._btnOneKey:AddClickListener(self._onClickOneKey, self)
	self._btnClean:AddClickListener(self._onClickClean, self)
	self._videoButton:AddClickListener(self._onClickVideo, self)
	self._btnGuide:AddClickListener(self._onClickGuide, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnEvaluate:AddClickListener(self._onClickEvaluate, self)
	self._btnSetting:AddClickListener(self._onClickSetting, self)
end

function AutochessmissionView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._petButton:RemoveClickListener()
	self._btnOneKey:RemoveClickListener()
	self._btnClean:RemoveClickListener()
	self._videoButton:RemoveClickListener()
	self._startBtn:RemoveClickListener()
	self._btnGuide:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnEvaluate:RemoveClickListener()
	self._btnSetting:RemoveClickListener()
end

function AutochessmissionView:buildUI()
	self._maskBlock = self:getGo("MaskBlock")
	self._closeButton = self:getBtn("lefttop/btn_back")
	self._petButton = self:getBtn("Nego_Right/BtnPet")
	self._startBtn = self:getBtn("BtnStart")
	self._txtStartBtn = goutil.findChildTextComponent(self._startBtn.gameObject, "TxtC_Title")
	self._txtCd = goutil.findChildTextComponent(self._startBtn.gameObject, "txtCd")
	self._btnRule = self:getBtn("btnRule")
	self._redPoint = self:getGo("btnRule/redPoint")
	self._topDesc = self:getGo("topDesc")
	self._txtValidatorDesc = self:getTxt("topDesc/txtValidatorDesc")
	self._imgYes = self:getGo("topDesc/txtValidatorDesc/imgYes")
	self._imgNo = self:getGo("topDesc/txtValidatorDesc/imgNo")
	self._txtDesc = self:getTxt("topDesc/txtDesc")
	self._Titlebg = self:getGo("Titlebg")
	self._effectBase = self:getGo("Titlebg/EffectBase")
	self._descTxt = self:getGo("Middle/Desc"):GetComponent("Text")
	self._lImgIsFirst = self:getGo("Nego_Left/Nego_TeamInfo/Nego_TeamSpeed/imgIsFirst"):GetComponent("UIImageSpriteChange")
	self._titleTxt = self:getGo("Titlebg/TxtTitle"):GetComponent("Text")
	self._levelTxt = self:getGo("Titlebg/TxtLevel"):GetComponent("Text")

	self._maskBlock:SetActive(false)

	self._btnOneKey = self:getBtn("btnOneKey")
	self._btnClean = self:getBtn("btnClean")
	self._videoGo = self:getGo("Video")
	self._videoButton = self:getBtn("Video/VideoButton")
	self._btnGuide = self:getBtn("lefttop/btnGuide")

	self._videoButton.gameObject:SetActive(false)

	self._Nego_RightRectTrans = self:getGo("Nego_Right"):GetComponent(goutil.Type_RectTransform)
	self._leftTeamInfoRectTrans = self:getGo("Nego_Left/Nego_TeamInfo"):GetComponent(goutil.Type_RectTransform)
	self._effectParent = self:getGo("effect")
	self._ImgC_Bg = self:getGo("ImgC_Bg")
	self._btnTip = self:getBtn("btnTip")

	self:_initPowerCostNode()

	self._btnEvaluate = self:getBtn("Nego_Left/SelectView/Viewport/Content/Nego_Select/btnEvaluate")
	self._btnSetting = self:getBtn("btnSetting")
	self._btnEvaluate = self._btnEvaluate or self:getBtn("btnEvaluate")
	self._evaluateSprite = goutil.findChild(self._btnEvaluate.gameObject, "icon"):GetComponent("UIImageSpriteChange")
	self._descTxt.text = lang("击败敌阵所有精灵即可过关")
	self._noCost = self:getGo("NodePower/Power/noCost")
	self._extension = self:getGo("extension")
	self._extRoot = self:getResInstance(AutochessmissionViewPresentor.Aotuchessmissionextview)

	self._extRoot.transform:SetParent(self.mainGO.transform)
	Framework.TransformUtil.SetLocalScale(self._extRoot.transform, 1, 1, 1)
	Framework.TransformUtil.SetLocalPos(self._extRoot.transform, 0, 0, 0)
	GameUtil.expandRectTransform(self._extRoot.transform)

	self._autochessmissionextView = GameUtil.AddLuaOnce(self._extRoot, AutochessmissionextView)
end

function AutochessmissionView:_playTeamInfoEnterAnim()
	return
end

function AutochessmissionView:_procLRTxt()
	return
end

function AutochessmissionView:_setBtnOneKeyActive()
	return false
end

function AutochessmissionView:onEnter()
	self.addGEvent(self, GlobalNotify.FormationPosChanged, self._onFormationPosChanged, self)

	self._activityId = AutochessModel.instance:getActivityId()

	self:onEnterInherit()
	FastFormation.instance:setCurFormFunc(function()
		return AutochessModel.instance:getCurrFormation()
	end)
	FastFormation.instance:setGetCurPetList(function()
		return AutochessModel.instance:getPetList()
	end)
	self._maskBlock:SetActive(false)
	goutil.setActive(self._startBtn.gameObject, false)
	goutil.setActive(self._btnRule.gameObject, false)
	goutil.setActive(self._closeButton.gameObject, false)
	self._autochessmissionextView:onEnter(self, self._viewPresentor)
	self:_setTopTxtDesc()
end

function AutochessmissionView:onExit()
	AutochessmissionView.super.onExit(self)
	self._autochessmissionextView:onExit()
end

function AutochessmissionView:_enterBattle()
	self._maskBlock:SetActive(false)

	local fmt = self:_getCurFormation()

	if not fmt:isEmpty() then
		local form = fmt:createFormPb()

		AutoChessAgent.instance:sendPM_ACSetFormationReq(form)
	end
end

function AutochessmissionView:_saveFormationEx()
	return false
end

function AutochessmissionView:needCheckNumLimit()
	return false
end

function AutochessmissionView:_isCurFormationEmpty()
	return false
end

function AutochessmissionView:_getCurFormation()
	return AutochessModel.instance:getCurrFormation()
end

function AutochessmissionView:_loadVsEffect()
	return
end

function AutochessmissionView:_setTopTxtDesc()
	local fmt = AutochessModel.instance:getCurrFormation()
	local num = fmt:getCurExistPetNumber()
	local roundId = AutochessModel.instance:getRoundId()
	local maxNum = AutochessConfig.instance:getRoundFormationNum(roundId)
	local str = string.format("上阵：%s/%s", num, maxNum)

	self:_setTxtDesc(str)
end

function AutochessmissionView:_onFormationPosChanged()
	self:_setTopTxtDesc()
end

return AutochessmissionView
