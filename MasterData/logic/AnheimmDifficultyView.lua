-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/anheimm/AnheimmDifficultyView.lua

module("logic.extensions.timelimitedchallenge.view.anheimm.AnheimmDifficultyView", package.seeall)

local AnheimmDifficultyView = class("AnheimmDifficultyView", ViewComponent)

function AnheimmDifficultyView:ctor()
	AnheimmDifficultyView.super.ctor(self)
end

function AnheimmDifficultyView:buildUI()
	AnheimmDifficultyView.super.buildUI(self)

	self._coms = {}

	for i = 1, 5 do
		local mode = {}

		mode.cfg = AnheimmConfig.instance:getModeCfgById(i)
		mode.go = self:getGo("com" .. i)
		mode.goChallenge = goutil.findChild(mode.go, "btnChallenge")
		mode.btn = GameUtil.asBtn(mode.goChallenge)
		mode.zdl = goutil.findChild(mode.go, "zdl")
		mode.zdlTxt = goutil.findChild(mode.go, "zdl/imgRecZdl"):GetComponent("UIImgNumeralText")

		local txtBtn = goutil.findChildTextComponent(mode.goChallenge, "txt")

		txtBtn.text = mode.cfg.desc
		mode.goOpenTime = goutil.findChild(mode.go, "txtOpentime")
		mode.txtTime = mode.goOpenTime:GetComponent(goutil.Type_UIText)
		mode.reward = {}
		mode.rewardPerfect = {}

		local rewardPath = "rewardTip"
		local rewardPerfectPath = "rewardPerfectTip"

		for k = 1, 2 do
			mode.reward[k] = self:buildCom(mode.go, rewardPath, k)
			mode.rewardPerfect[k] = self:buildCom(mode.go, rewardPerfectPath, k)
		end

		self._coms[i] = mode
	end

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
end

function AnheimmDifficultyView:bindEvents()
	AnheimmDifficultyView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickBtnTip, self)

	for i = 1, 5 do
		self._coms[i].btn:AddClickListener(function()
			self:_onClickModeBtn(i)
		end, self)
	end
end

function AnheimmDifficultyView:unbindEvents()
	AnheimmDifficultyView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()

	for i = 1, 5 do
		self._coms[i].btn:RemoveClickListener()
	end
end

function AnheimmDifficultyView:destroyUI()
	AnheimmDifficultyView.super.destroyUI(self)
end

function AnheimmDifficultyView:onEnter()
	AnheimmDifficultyView.super.onEnter(self)
	self:_updateUI()
	GlobalDispatcher:addListener(GlobalNotify.RefreshAnheiMMChallenge, self._refreshDaily, self)
end

function AnheimmDifficultyView:onEnterFinished()
	AnheimmDifficultyView.super.onEnterFinished(self)
end

function AnheimmDifficultyView:onExit()
	AnheimmDifficultyView.super.onExit(self)

	for i = 1, 5 do
		for k = 1, 2 do
			self:_resetIcon(self._coms[i].reward[k])
			self:_resetIcon(self._coms[i].rewardPerfect[k])
		end
	end

	GlobalDispatcher:removeListener(GlobalNotify.RefreshAnheiMMChallenge, self._refreshDaily, self)
end

function AnheimmDifficultyView:onExitFinished()
	AnheimmDifficultyView.super.onExitFinished(self)
end

function AnheimmDifficultyView:buildCom(comGo, parentPath, id)
	if goutil.isNil(comGo) then
		printError("nil Go Error")
	else
		local buildT = {}

		buildT.go = goutil.findChild(comGo, parentPath .. "/list/txtReward" .. id)
		buildT.txt = buildT.go:GetComponent(goutil.Type_UIText)
		buildT.icon = goutil.findChild(buildT.go, "icon")

		return buildT
	end
end

function AnheimmDifficultyView:_updateUI()
	for i = 1, 5 do
		local rewardStrs = MaterialMgr.changeItemStrArr(self._coms[i].cfg.normalPassPrize)
		local rewardPerfectStrs = MaterialMgr.changeItemStrArr(self._coms[i].cfg.perfectPassPrize)

		for k = 1, 2 do
			self:_resetIcon(self._coms[i].reward[k], rewardStrs[k])
			self:_resetIcon(self._coms[i].rewardPerfect[k], rewardPerfectStrs[k])
		end
	end

	self:_refreshDaily()
end

function AnheimmDifficultyView:_refreshDaily()
	for i = 1, 5 do
		local isOpen, openTime = AnheimmModel.instance:getModeIsOpen(i)

		if isOpen then
			goutil.setActive(self._coms[i].zdl, true)
			goutil.setActive(self._coms[i].goOpenTime, false)
			self._coms[i].zdlTxt:SetText(AnheimmModel.instance:getShowZDL(i))
		else
			goutil.setActive(self._coms[i].zdl, false)
			goutil.setActive(self._coms[i].goOpenTime, true)

			self._coms[i].txtTime.text = GameUtil.formatTimeStamp("%m月%d日开启", openTime)
		end
	end
end

function AnheimmDifficultyView:_resetIcon(com, matstr)
	if goutil.isNil(com.go) then
		printError("nil Go Error")
	else
		MaterialMgr.clearIcon(com.icon)

		if matstr then
			goutil.setActive(com.go, true)

			local matType, matId, matNum = MaterialMgr.getMatParams(matstr)

			com.txt.text = matNum <= 1 and "" or "x" .. matNum

			MaterialMgr.updateItemByStr(com.icon, matstr)
		else
			goutil.setActive(com.go, false)
		end
	end
end

function AnheimmDifficultyView:_onClickModeBtn(modeId)
	local content = langPara("确定选择<color=red>%s</color>难度吗？\n本次挑战将不可更改难度哦！", self._coms[modeId].cfg.desc)

	TipsFacade.instance:openPopupWindow("提示", content, function()
		AnHeiMMChallengeAgent.instance:sendPM_AnHeiMMChallengeChooseModeReq(modeId, function(msg)
			AnheimmModel.instance:updateModeInfo(msg)
			self:close()
			UIStateManager.instance:push(ViewName.AnheimmRuleView)
		end)
	end)
end

function AnheimmDifficultyView:_onClickBtnTip()
	UIStateManager.instance:push(ViewName.AnheimmsperuleView)
end

return AnheimmDifficultyView
