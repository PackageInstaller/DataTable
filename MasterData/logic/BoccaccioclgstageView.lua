-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccaccioclg/view/BoccaccioclgstageView.lua

module("logic.extensions.boccaccioclg.view.BoccaccioclgstageView", package.seeall)

local BoccaccioclgstageView = class("BoccaccioclgstageView", ViewComponent)

function BoccaccioclgstageView:ctor()
	BoccaccioclgstageView.super.ctor(self)
end

function BoccaccioclgstageView:unbindEvents()
	BoccaccioclgstageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function BoccaccioclgstageView:bindEvents()
	BoccaccioclgstageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function BoccaccioclgstageView:buildUI()
	BoccaccioclgstageView.super.buildUI(self)

	self._itemconGo = self:getGo("itemcon")
	self._itemcellGo = self:getGo("itemcell")
	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")

	goutil.setActive(self._itemcellGo, false)

	self._stageGos = {}
	self._txtContent1 = self:getTxt("tableview1/viewport/content")
	self._txtBlood = self:getTxt("scoreDetail/txtBlood")
	self._txtFight = self:getTxt("scoreDetail/txtFight")
	self._txtDefense = self:getTxt("scoreDetail/txtDefense")
	self._txtTotal = self:getTxt("scoreDetail/txtTotal")
	self._txtScoreList = {
		self._txtBlood,
		self._txtFight,
		self._txtDefense
	}
end

function BoccaccioclgstageView:onExit()
	BoccaccioclgstageView.super.onExit(self)
	self:_clearAllStageCell()
end

function BoccaccioclgstageView:onEnter()
	BoccaccioclgstageView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self:_updateUI()
end

function BoccaccioclgstageView:_updateUI()
	self._stageCfgs = BoccaccioclgConfig.instance:getStageCfgs(self._activityId)

	for i, v in ipairs(self._stageCfgs) do
		local go = self._stageGos[i]

		if go then
			goutil.setActive(go, true)
		else
			go = goutil.cloneAndSetParent(self._itemcellGo, self._itemconGo.transform)

			goutil.setActive(go, true)
			table.insert(self._stageGos, go)
		end

		self:_updateStageCell(go, v)
	end

	self:_setDesc()
	self:_setScoreDesc()
end

function BoccaccioclgstageView:_setDesc()
	local list = {}
	local buffCfgs = BoccaccioclgConfig.instance:getSignBuffCfgs(self._activityId)

	for i, v in ipairs(buffCfgs) do
		table.insert(list, string.format("%s:%s", v.name, v.desc))
	end

	self._txtContent1.text = table.concat(list, "\n")
end

function BoccaccioclgstageView:_setScoreDesc()
	local buffTypeToValues = {}
	local buffTypeToScore = {}
	local info = BoccaccioclgModel.instance:getInfo(self._activityId)

	for i, v2 in ipairs(info.stageList) do
		for i, v in ipairs(v2.valueList or {}) do
			buffTypeToValues[v.buffType] = buffTypeToValues[v.buffType] or {}

			table.insert(buffTypeToValues[v.buffType], checknumber(v.value))

			local singleScore = BoccaccioclgController.instance:value2Score(self._activityId, v.buffType, v.value)

			buffTypeToScore[v.buffType] = (buffTypeToScore[v.buffType] or 0) + singleScore
		end
	end

	local buffCfgs = BoccaccioclgConfig.instance:getSignBuffCfgs(self._activityId)
	local totalScore = 0

	for i, v in ipairs(buffCfgs) do
		if not buffTypeToValues[v.buffType] then
			if not buffTypeToScore[v.buffType] then
				local score = 0
				local curTxt = self._txtScoreList[i]

				if curTxt then
					curTxt.text = string.format("<color=#5cdbff>%s</color>", score)
				end

				totalScore = totalScore + score
			end
		end
	end

	self._txtTotal.text = string.format("%s", totalScore)
end

function BoccaccioclgstageView:_updateStageCell(go, stageCfg)
	local btn = Framework.ButtonAdapter.GetFrom(go, "btn")
	local imgHead = goutil.findChild(go, "head/imgHead")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")

	btn:AddClickListener(function()
		self:_onClickBtnStage(stageCfg)
	end)

	local stageInfo = BoccaccioclgModel.instance:getStageInfo(self._activityId, stageCfg.stageId)
	local list = {}

	if stageInfo then
		if not stageInfo.valueList then
			local valueList = {}
			local buffTypeToValue = {}
			local skinId = stageCfg.skinId

			for i, v in ipairs(valueList) do
				buffTypeToValue[v.buffType] = v.value
			end

			local buffCfgs = BoccaccioclgConfig.instance:getSignBuffCfgs(self._activityId)
			local totalScore = 0

			for i, v in ipairs(buffCfgs) do
				if not buffTypeToValue[v.buffType] then
					local value = 0
					local score = BoccaccioclgController.instance:value2Score(self._activityId, v.buffType, value)

					table.insert(list, string.format("%s积分：<color=#5cdbff>%s</color>", v.name, score))

					totalScore = totalScore + score
				end
			end

			table.insert(list, string.format("本关总积分：<color=#3aaa52>%s</color>", totalScore))

			txtDesc.text = table.concat(list, "\n")

			MaterialMgr.setIcon(imgHead, MatType.Pet, skinId, nil, nil)
			Framework.TransformUtil.SetAnchoredPos(go.transform, stageCfg.pos[1], stageCfg.pos[2])
		end
	end
end

function BoccaccioclgstageView:_clearStageCell(go, stageCfg)
	local btn = Framework.ButtonAdapter.GetFrom(go, "btn")
	local imgHead = goutil.findChild(go, "head/imgHead")

	GameUtil.rmClickHandler(btn)
	MaterialMgr.clearIcon(imgHead)
end

function BoccaccioclgstageView:_clearAllStageCell()
	for i, v in ipairs(self._stageCfgs) do
		local go = self._stageGos[i]

		if go then
			self:_clearStageCell(go, v)
		end
	end
end

function BoccaccioclgstageView:_onClickBtnStage(stageCfg)
	local fmtMo = BoccaccioclgModel.instance:getFmtMo()

	fmtMo:initParams(self._activityId, stageCfg.stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function BoccaccioclgstageView:_onClickBtnTip()
	local challengeCfg = BoccaccioclgController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

return BoccaccioclgstageView
