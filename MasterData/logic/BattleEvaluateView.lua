-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/BattleEvaluateView.lua

module("logic.extensions.materialchallenge.view.BattleEvaluateView", package.seeall)

local BattleEvaluateView = class("BattleEvaluateView", ViewComponent)

BattleEvaluateView.ScoreFormat = "<color=#%s>%s</color>"

function BattleEvaluateView:ctor()
	BattleEvaluateView.super.ctor(self)
end

function BattleEvaluateView:buildUI()
	self._bg = self:getGo("bg")
	self._txtScore = self:getGo("bg/txtScore"):GetComponent(goutil.Type_UIText)
	self._txtNumber = self:getGo("bg/txtDesc"):GetComponent(goutil.Type_UIText)
	self._rectNumber = self:getGo("bg/txtDesc"):GetComponent(goutil.Type_RectTransform)
	self._txtCount = self:getGo("bg/txtCount"):GetComponent(goutil.Type_UIText)
	self._btnClick = self:getBtn("bg/btnClick")
	self._iconSprite = self:getGo("bg/reward/icon"):GetComponent("UIImageSpriteChange")
	self._txtNum = self:getTxt("bg/reward/txtNum")
	self._tableview = self:getGo("bg/rewardList"):GetComponent("UITableview")
	self._tableCell = self:getGo("bg/rewardList/item")
end

function BattleEvaluateView:bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function BattleEvaluateView:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function BattleEvaluateView:onEnter()
	local settlementType = BattleSettlementModel.instance:getType()

	self._isShow = settlementType == BattleSettlementModel.Enum.ResCopy

	if not self._isShow then
		return
	end

	GlobalDispatcher:addListener(GlobalNotify.OnBattleUnitsCreated, self._updateTarget, self)
	GlobalDispatcher:addListener(GlobalNotify.BattleUnitDead, self._onBattleUnitDead, self)
	GlobalDispatcher:addListener(GlobalNotify.BattleHurtData, self._onBattleHurtData, self)
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._bg:SetActive(false)

	local params = BattleSettlementModel.instance:getParams()
	local chapterId = params.chapterId
	local progress = params.progress
	local winId = params.winId
	local rewardScore = params.rewardScore

	self._chapterId = chapterId

	local cfgs = MaterialChallengeConfig.instance:getProcessorSectionCfgs(chapterId, progress)

	self._taskDes = cfgs[1].taskDes
	self._taskDetailDes = cfgs[1].taskDetailDes

	local cfg = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(winId)

	self._targetType = cfg.type
	self._cfgEvaluates = MaterialChallengeConfig.instance:getEvaluateCfgs(rewardScore)
	self._tipViewParams = {
		desc3 = "",
		desc2 = "",
		rewardStr = "",
		desc1 = ""
	}

	DropManager.instance:setResCopyType(chapterId)
end

function BattleEvaluateView:onExit()
	if not self._isShow then
		return
	end

	GlobalDispatcher:removeListener(GlobalNotify.OnBattleUnitsCreated, self._updateTarget, self)
	GlobalDispatcher:removeListener(GlobalNotify.BattleUnitDead, self._onBattleUnitDead, self)
	GlobalDispatcher:removeListener(GlobalNotify.BattleHurtData, self._onBattleHurtData, self)

	self._curViewDatas = nil

	self._tableview:Travel(self._clearTableview, self)
	self._tableview:UnRegisterAllCallbacks()

	self._cfgEvaluates = nil
	self._oldRewardStr = nil
	self._tipViewParams = nil

	if ViewMgr.instance:isOpen(ViewName.BattleEvaluateTipView) then
		UIStateManager.instance:popByName(ViewName.BattleEvaluateTipView)
	end
end

function BattleEvaluateView:_onClick()
	UIStateManager.instance:push(ViewName.BattleEvaluateTipView, self._tipViewParams)
end

function BattleEvaluateView:_numInView()
	return #self._curViewDatas
end

function BattleEvaluateView:_cellSize(view, idx)
	if idx + 1 == #self._curViewDatas then
		return 90, 70
	end

	return 70, 70
end

function BattleEvaluateView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function BattleEvaluateView:_updateCell(view, cell, data)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	Framework.TransformUtil.SetLocalScale(parentGo.transform, 0.6, 0.6, 0.6)

	local proxy = MaterialMgr.setCellByCfg(data.rewardStr, parentGo)
end

function BattleEvaluateView:_clearTableview(cell)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	MaterialMgr.resetAll(parentGo)
end

function BattleEvaluateView:_getEnemyDeathCount()
	local count = 0
	local enemys = BattleModel.instance:getEnemyUnits()

	for k, v in pairs(enemys) do
		if v.attrs:getCurHp() <= 0 then
			count = count + 1
		end
	end

	return count
end

function BattleEvaluateView:_getEnemyHurtedValue()
	local blood = 0
	local totalBlood = 0
	local enemys = BattleModel.instance:getEnemyUnits()

	for k1, v1 in pairs(enemys) do
		if not v1.isSourceMon then
			blood = blood + v1.attrs:getCurTempHp()
			totalBlood = totalBlood + v1.attrs:getMaxHp()
		end
	end

	return totalBlood - blood
end

function BattleEvaluateView:_updateTipViewParams(desc1, desc2, desc3, rewardStr)
	self._tipViewParams.desc1 = desc1
	self._tipViewParams.desc2 = desc2
	self._tipViewParams.desc3 = desc3
	self._tipViewParams.rewardStr = rewardStr
end

function BattleEvaluateView:_updateTarget()
	if not self._bg.activeSelf then
		self._bg:SetActive(true)
	end

	self:_updateKillNum()
	self:_updateDamageTotal()
end

function BattleEvaluateView:_updateKillNum()
	if self._targetType == GameEnum.Evaluate.KillNum then
		local killNum = self:_getEnemyDeathCount()
		local cfg, nextProcessorSection = self:_getEvaluateCfg(killNum)

		if cfg then
			local num = nextProcessorSection
			local desc = string.format("%d/%d", killNum, num)
			local txtDesc1 = string.format(self.ScoreFormat, self:_getColor(cfg.evaluate), cfg.evaluate)
			local txtDesc2 = string.format(self._taskDes, desc)
			local txtDesc3 = self._taskDetailDes
			local rewardStr = cfg.reward

			self._txtScore.text = txtDesc1
			self._txtCount.text = desc

			self:_bgAdaptation("")
			self:_updateReward(rewardStr)
			self:_updateTipViewParams(txtDesc1, txtDesc2, txtDesc3, rewardStr)
		else
			self._txtNumber.text = string.format(self._taskDes, "")
			self._txtScore.text = string.format(self.ScoreFormat, self:_getColor(""), "nil")
			self._txtCount.text = tostring(killNum)

			self:_updateTipViewParams("", "", "", "")
		end
	end
end

function BattleEvaluateView:_updateDamageTotal()
	if self._targetType == GameEnum.Evaluate.DamageTotal then
		local damageTotal = self:_getEnemyHurtedValue()
		local cfg, nextProcessorSection = self:_getEvaluateCfg(damageTotal)

		if cfg then
			local num = nextProcessorSection
			local desc = string.format("%d/%d", damageTotal, num)
			local txtDesc1 = string.format(self.ScoreFormat, self:_getColor(cfg.evaluate), cfg.evaluate)
			local txtDesc2 = string.format(self._taskDes, desc)
			local txtDesc3 = self._taskDetailDes
			local rewardStr = cfg.reward

			self._txtScore.text = txtDesc1
			self._txtCount.text = desc

			self:_bgAdaptation("")
			self:_updateReward(rewardStr)
			self:_updateTipViewParams(txtDesc1, txtDesc2, txtDesc3, rewardStr)
		else
			self._txtNumber.text = string.format(self._taskDes, "")
			self._txtScore.text = string.format(self.ScoreFormat, self:_getColor(""), "nil")
			self._txtCount.text = tostring(damageTotal)

			self:_updateTipViewParams("", "", "", "")
		end
	end
end

function BattleEvaluateView:_bgAdaptation(desc)
	self._txtNumber.text = string.format(self._taskDes, desc)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._rectNumber)

	local rectBg = self._bg:GetComponent(goutil.Type_RectTransform)

	goutil.setWidth(rectBg, goutil.getWidth(self._rectNumber) + self._rectNumber.anchoredPosition.x + 10)
end

function BattleEvaluateView:_onBattleUnitDead(unit)
	self:_updateKillNum()
	self:_drop(unit)
end

function BattleEvaluateView:_onBattleHurtData(hurtData)
	self:_updateDamageTotal()

	if hurtData.attacker and hurtData.attacker.teamId == BattleModel.instance.myTeamId then
		self:_drop(hurtData.target)
	end
end

function BattleEvaluateView:_drop(unit)
	local enemyTeamId = BattleModel.instance:getEnemyPlayerTeam()

	if unit.teamId == enemyTeamId then
		local num = checknumber(self._txtNum.text)

		DropManager.instance:drop(unit, num)
	end
end

function BattleEvaluateView:_getEvaluateCfg(score)
	if self._cfgEvaluates and #self._cfgEvaluates > 0 then
		local count = #self._cfgEvaluates

		for i = count, 1, -1 do
			if score >= self._cfgEvaluates[i].processorSection then
				return self._cfgEvaluates[i], i == count and self._cfgEvaluates[i].processorSection or self._cfgEvaluates[i + 1].processorSection
			end
		end
	end

	return nil
end

function BattleEvaluateView:_updateReward(newRewardStr)
	local rewardItems = string.split(newRewardStr, "#")

	if not rewardItems[1] then
		return
	end

	self._iconSprite:ChangeStateNow(self:_getIndex())

	local strs = string.split(rewardItems[1], ":")

	if strs[3] then
		self._txtNum.text = strs[3]
	end
end

function BattleEvaluateView:_getIndex()
	if self._chapterId == 2 then
		return 0
	elseif self._chapterId == 1 then
		return 1
	elseif self._chapterId == 3 then
		return 2
	elseif self._chapterId == 4 then
		return 3
	else
		return 0
	end
end

function BattleEvaluateView:_getColor(score)
	if score == "S" then
		return "EBAD32"
	elseif score == "A" then
		return "DF4DFF"
	elseif score == "B" then
		return "1CC2FF"
	elseif score == "C" then
		return "60EE85"
	else
		return "C2E2FC"
	end
end

return BattleEvaluateView
