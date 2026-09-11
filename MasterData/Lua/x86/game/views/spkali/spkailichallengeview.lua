local SPKailiChallengeView = class("SPKailiChallengeView", ReduxView)

function SPKailiChallengeView:Init()
	self:BindCfgUI()

	self.nodeList = {}

	self:AddListeners()

	self.stageList_ = LuaList.New(handler(self, self.IndexItem), self.uilistUilist_, SpKaliStageItem)
end

function SPKailiChallengeView:IndexItem(arg_2_1, arg_2_2)
	arg_2_2:SetData(self.pointlist[arg_2_1], arg_2_1, #self.pointlist, self)
	arg_2_2:SetRcommond(self.effectID)
end

function SPKailiChallengeView:UIParent()
	return manager.ui.uiMain.transform
end

function SPKailiChallengeView:OnCtor()
	return
end

function SPKailiChallengeView:UIName()
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_kaliFistLevelUI"
end

function SPKailiChallengeView:AddListeners()
	self:AddBtnListener(self.btnlookBtn_, nil, function()
		saveData("SPKALI", "COLLECT_AFFIX", 0)
		manager.redPoint:setTip(RedPointConst.ACTIVITY_KALI_AFFIX, 0)
		self:Go("SPKailiChallengeIllustratedView", {
			activityID = self.activityID
		})
	end)
	self:AddBtnListener(self.ndaffixBtn_, nil, function()
		JumpTools.OpenPageByJump("SPKailiChallengeRollView", {
			activityID_ = self.acitvityID
		})
	end)
end

function SPKailiChallengeView:UpdateData(arg_9_1)
	self.pointlist = SpKaliTool.GetChanllengeStageData(arg_9_1) or {}
end

function SPKailiChallengeView:RefreshStageList()
	self.stageList_:StartScrollByPosition(#self.pointlist, (SPKaliChallengeData.pos1 or nil) and Vector2.New(SPKaliChallengeData.pos1, 0))
end

function SPKailiChallengeView:OnEnter()
	if self.params_ then
		self.activityID = self.params_.activityID_ or ActivityConst.ACTIVITY_3_6_KALI_FIGHT
	end

	self:RegistEventListener(ACTIVITY_KALI_INFO, function()
		self.effectID = nil

		self:RefreshAffixDes()
		self:UpdateData(self.activityID)
		self:RefreshStageList()
	end)
	SPKailiChallengeView.super.OnEnter(self)
	self:UpdateData(self.activityID)

	local var_11_0 = SPKaliChallengeData:GetSPChallengeData(self.activityID)

	self:RefreshAffixDes()
	self:RefreshStageList()

	if not SpKaliTool.IsHaveRolled(self.activityID) and not self.isPop then
		self.isPop = true

		JumpTools.OpenPageByJump("SPKailiChallengeRollView", {
			activityID_ = fightActivityID
		})
	end

	manager.redPoint:bindUIandKey(self.btnlookBtn_.transform, RedPointConst.ACTIVITY_KALI_AFFIX)
	manager.redPoint:bindUIandKey(self.ndaffixBtn_.transform, RedPointConst.ACTIVITY_KALI_FREE_ROLL)
end

function SPKailiChallengeView:OnTop()
	self.uilistSr_.enabled = true

	if self.selectIndex then
		local var_13_0 = self.stageList_:GetItemByIndex(self.selectIndex)

		if var_13_0 then
			var_13_0:SetSelect(false)
		end

		self:RefreshStageList()
	end

	self.isStopAni = false

	self:ChangeBar()
	self.imgbubbleAni_:Update(0)
	SetActive(self.imgbubbleGo_, self.isShowEffect and true or false)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.labelTrs_)
end

function SPKailiChallengeView:OnBehind()
	SetActive(self.imgbubbleGo_, false)
end

function SPKailiChallengeView:OnExit()
	SPKailiChallengeView.super.OnExit(self)

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.timer1 then
		self.timer1:Stop()

		self.timer1 = nil
	end

	manager.redPoint:unbindUIandKey(self.btnlookBtn_.transform)
	manager.redPoint:unbindUIandKey(self.ndaffixBtn_.transform)
end

function SPKailiChallengeView:ChangeBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function SPKailiChallengeView:RefreshAffixDes()
	local var_17_0 = SPKaliChallengeData:GetKaliAffix(self.activityID)

	for iter_17_0 = 1, 3 do
		if ActivityAffixPoolCfg[var_17_0[iter_17_0]] then
			local var_17_1 = SpKaliTool.GetAffixID(var_17_0[iter_17_0])

			self["iconaffix" .. iter_17_0 .. "Img_"].sprite = getAffixSprite(ActivityAffixPoolCfg[var_17_0[iter_17_0]].affix)
		end
	end

	local var_17_2 = SPKaliChallengeData:GetNowAffixEffect(self.activityID)

	self.isShowEffect = var_17_2

	if var_17_2 then
		local var_17_3 = ActivitykaliaffixCfg[var_17_2].affix_id

		if ActivityAffixPoolCfg[ActivitykaliaffixCfg[var_17_2].affix_id] then
			self.effectID = var_17_3
			self.textaffixeffectText_.text = getAffixDesc(ActivityAffixPoolCfg[var_17_3].affix)
			self.textaffixnameText_.text = ActivityAffixPoolCfg[var_17_3].name
			self.iconaffixImg_.sprite = getAffixSprite(ActivityAffixPoolCfg[var_17_3].affix)

			local var_17_4 = {}

			for iter_17_1, iter_17_2 in ipairs(ActivityKaliStageCfg.all) do
				if ActivityKaliStageCfg[iter_17_2] then
					if table.indexof(ActivityKaliStageCfg[iter_17_2].recommend or {}, var_17_3) and not table.indexof(var_17_4, iter_17_2) then
						table.insert(var_17_4, iter_17_2)
					end
				end
			end

			for iter_17_3 = 1, 2 do
				if self[string.format("label%sGo_", iter_17_3)] then
					SetActive(self[string.format("label%sGo_", iter_17_3)], var_17_4[iter_17_3] and true or false)

					if var_17_4[iter_17_3] then
						self[string.format("textaffixname%sText_", iter_17_3)].text = string.format(GetTips("ACTIVITY_KALI_DESC_3"), GetTips("NUM_" .. var_17_4[iter_17_3]))
					end
				end
			end
		end
	end
end

function SPKailiChallengeView:StopLeanTween()
	if self.moveLeanTween_ then
		self.moveLeanTween_:setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.moveLeanTween_.id)

		self.moveLeanTween_ = nil
	end
end

function SPKailiChallengeView:SetSelect(arg_19_1)
	if self.selectIndex then
		local var_19_0 = self.stageList_:GetItemByIndex(self.selectIndex)

		if var_19_0 then
			var_19_0:SetSelect(false)
		end
	end

	self.selectIndex = arg_19_1

	local var_19_1 = self.stageList_:GetItemByIndex(self.selectIndex)

	if var_19_1 then
		var_19_1:SetSelect(true)
	end

	local var_19_2 = self.viewport2Trs_.rect.width
	local var_19_3 = self.selectIndex * 500 - self.viewport2Trs_.rect.width / 2

	if self.isStopAni then
		var_19_3 = math.min(math.max(self.selectIndex * 500 - var_19_2 / 2, 0), #self.pointlist * 500 - var_19_2 / 2)
		self.isStopAni = false
	end

	self.moveLeanTween_ = LeanTween.moveLocalX(self.contentTrs_.gameObject, -var_19_3, 0.3):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		self:StopLeanTween()
	end))

	SPKaliChallengeData:SaveChanlengePointPos(Mathf.Clamp(((self.selectIndex - 1) * 500 - 250) / (self.contentTrs_.sizeDelta.x - var_19_2), 0, 1))
end

function SPKailiChallengeView:Dispose()
	SPKailiChallengeView.super.Dispose(self)
	self.stageList_:Dispose()
	SPKailiChallengeView.super.Dispose(self)
end

return SPKailiChallengeView
