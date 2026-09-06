-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/anheimm/AnheimmRuleView.lua

module("logic.extensions.timelimitedchallenge.view.anheimm.AnheimmRuleView", package.seeall)

local AnheimmRuleView = class("AnheimmRuleView", ViewComponent)

function AnheimmRuleView:ctor()
	AnheimmRuleView.super.ctor(self)
end

function AnheimmRuleView:buildUI()
	AnheimmRuleView.super.buildUI(self)

	self._btnRule = self:getBtn("btnRule")
	self._btnCancle = self:getBtn("btnCancle")
	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("modeDesc/btnSure")
	self._ruleDesc1 = self:getTxt("rule/rule1/txtDesc")
	self._ruleDesc2 = self:getTxt("rule/rule2/txtDesc")
	self._modeIcon = self:getGo("modeDesc/modeIcon"):GetComponent("UIImageSpriteChange")
	self._txtMode = self:getTxt("modeDesc/txtMode")
	self._zdlTxt = self:getGo("modeDesc/zdl/imgRecZdl"):GetComponent("UIImgNumeralText")
	self._reward = {}
	self._rewardPerfect = {}

	local rewardPath = "rewards"
	local rewardPerfectPath = "rewardsPerfect"

	for i = 1, 2 do
		self._reward[i] = self:buildCom(rewardPath, i)
		self._rewardPerfect[i] = self:buildCom(rewardPerfectPath, i)
	end

	self._btnTip = self:getBtn("btnTip")
end

function AnheimmRuleView:bindEvents()
	AnheimmRuleView.super.bindEvents(self)
	self._btnRule:AddClickListener(self._onClickBtnRule, self)
	self._btnCancle:AddClickListener(self._onClickBtnCancle, self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnSure:AddClickListener(self._onClickBtnSure, self)
	self._btnTip:AddClickListener(self._onClickBtnTip, self)
end

function AnheimmRuleView:unbindEvents()
	AnheimmRuleView.super.unbindEvents(self)
	self._btnRule:RemoveClickListener()
	self._btnCancle:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function AnheimmRuleView:destroyUI()
	AnheimmRuleView.super.destroyUI(self)
end

function AnheimmRuleView:onEnter()
	AnheimmRuleView.super.onEnter(self)

	self._eff = {}

	self:_updateUI()
	GlobalDispatcher:addListener(GlobalNotify.RefreshAnheiMMChallenge, self._updateUI, self)
end

function AnheimmRuleView:onEnterFinished()
	AnheimmRuleView.super.onEnterFinished(self)
end

function AnheimmRuleView:onExit()
	AnheimmRuleView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.RefreshAnheiMMChallenge, self._updateUI, self)

	for i = 1, 2 do
		self:_resetIcon(self._reward[i])
		self:_resetIcon(self._rewardPerfect[i])
	end

	for _, eff in ipairs(self._eff) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self._eff = nil
end

function AnheimmRuleView:onExitFinished()
	AnheimmRuleView.super.onExitFinished(self)
end

function AnheimmRuleView:buildCom(parentPath, id)
	local buildT = {}

	buildT.go = self:getGo("modeDesc/" .. parentPath .. "/txtReward" .. id)
	buildT.txt = buildT.go:GetComponent(goutil.Type_UIText)
	buildT.icon = goutil.findChild(buildT.go, "icon")

	return buildT
end

function AnheimmRuleView:_resetIcon(com, matstr)
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

function AnheimmRuleView:_onClickBtnRule()
	local curCost = AnheimmConfig.instance:getParamValueByKey("RE_RANDOM_RULE_COST")
	local curCostType, curCostId, curCostNum = MaterialMgr.getMatParams(curCost)
	local curIcon = MaterialMgr.getContentMatCfg(curCostType, curCostId, 30, -5, MaterialMgr.ICON_TYPE_ICON)
	local content = langPara("你确定花费<color=#ebad32>%s</color>%s重抽特殊规则吗？重抽不会改变难度，但必定抽到与当前不一样的规则。", curCostNum, curIcon)

	TipsFacade.instance:openPopupCostMatViewNew(curCostType, curCostId, curCostNum, content, function()
		AnHeiMMChallengeAgent.instance:sendPM_AnHeiMMChallengeReChooseRuleReq(function(msg)
			AnheimmModel.instance:updateModeInfo(msg)

			local path = "fx_ui_anheitiaozhan/prefabs/fx_ui_tiaozhan_anheimengmeng_tanchuang.prefab"

			self._eff = {}

			for i = 1, 2 do
				local parent = self:getGo("rule/rule" .. i .. "/eff")

				self._eff[i] = UIEffectManager.instance:playEffect(self, path, parent, 0, 0, false)

				self._eff[i]:setParent(parent.transform)
				self._eff[i]:setLocalPos(0, 0, 0)
				self._eff[i]:setScale(1)
				self._eff[i]:setLocalEulerAngle(0, 0, 0)

				self._eff[i].hideEffWhileNotOnTop = false
			end

			self:_updateUI()
		end)
	end)
end

function AnheimmRuleView:_onClickBtnCancle()
	local content = langPara("确定放弃当前挑战？\n放弃将扣除1次挑战次数！")

	TipsFacade.instance:openTipWindow("提示", content, function()
		AnHeiMMChallengeAgent.instance:sendPM_AnHeiMMChallengeGiveUpReq(function(msg)
			AnheimmModel.instance:updateGiveUp(msg)
			self:close()
			GlobalDispatcher:dispatch(GlobalNotify.RefreshAnheiMMRefreshTime)
		end)
	end)
end

function AnheimmRuleView:_onClickBtnSure()
	self:close()
	UIStateManager.instance:push(ViewName.AnheimmMissionView)
end

function AnheimmRuleView:_updateUI()
	local modeId = AnheimmModel.instance:getCurModeId()

	if not modeId or modeId == 0 then
		FloatWordMgr.instance:show("挑战已刷新")
		self:close()

		return
	end

	self._modeIcon:SetState(modeId - 1)
	self._zdlTxt:SetText(AnheimmModel.instance:getShowZDL(modeId))

	local cfg = AnheimmConfig.instance:getModeCfgById(modeId)

	self._txtMode.text = cfg.desc .. "难度"

	local rewardStrs = MaterialMgr.changeItemStrArr(cfg.normalPassPrize)
	local rewardPerfectStrs = MaterialMgr.changeItemStrArr(cfg.perfectPassPrize)

	for i = 1, 2 do
		self:_resetIcon(self._reward[i], rewardStrs[i])
		self:_resetIcon(self._rewardPerfect[i], rewardPerfectStrs[i])
	end

	local ruleId = AnheimmModel.instance:getCurRuleId()
	local ruleCfg = AnheimmConfig.instance:getRuleCfgById(ruleId)

	self._ruleDesc1.text = ruleCfg.buffDes

	local str = "普通通关：击败敌阵\n完美通关：击败敌阵且"

	self._ruleDesc2.text = str .. ruleCfg.perfectDes
end

function AnheimmRuleView:_onClickBtnTip()
	UIStateManager.instance:push(ViewName.AnheimmsperuleView)
end

return AnheimmRuleView
