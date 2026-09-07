local NewEducateAssessPanel = class("NewEducateAssessPanel", import("view.base.BaseSubView"))

NewEducateAssessPanel.CRIT_PERCENT = 200
NewEducateAssessPanel.SPEED = 3

function NewEducateAssessPanel:getUIName()
	return "NewEducateAssessPanel"
end

function NewEducateAssessPanel:OnLoaded()
	self.rootTF = self._tf:Find("root")
	self.assessTF = self.rootTF:Find("assess")
	self.bgTF = self.assessTF:Find("bg")
	self.endlessTF = self.assessTF:Find("endless")
	self.damageBlood = self.assessTF:Find("content/blood/red")
	self.bloodText = self.assessTF:Find("content/blood/Text"):GetComponent(typeof(Text))
	self.bossTF = self.assessTF:Find("content/boss")
	self.roleTF = self.assessTF:Find("content/role")
	self.damageTF = self.assessTF:Find("content/damage")
	self.damageCritTF = self.assessTF:Find("content/damage_crit")

	local var_2_0 = self.assessTF:Find("content/attrs")

	self.attrUIList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))
	self.resultTF = self.assessTF:Find("content/result")
	self.rankTF = self.resultTF:Find("rank")
	self.tipTF = self.rootTF:Find("tip")
	self.assessTextTF = self.tipTF:Find("content/assess/Text")

	setText(self.assessTextTF, i18n("child2_assess_start_tip"))

	self.targetTextTF = self.tipTF:Find("content/target/Text")

	return
end

function NewEducateAssessPanel:OnInit()
	onButton(self, self._tf, function()
		self:AdjustSpeed()

		return
	end, SFX_PANEL)
	self.attrUIList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventInit then
			arg_5_2.name = self.attrIds[arg_5_1 + 1]

			LoadImageSpriteAtlasAsync("ui/neweducateassesspanel_atlas", pg.child2_attr[self.attrIds[arg_5_1 + 1]].icon, arg_5_2)
			LoadImageSpriteAtlasAsync("ui/neweducateassesspanel_atlas", pg.child2_attr[self.attrIds[arg_5_1 + 1]].icon .. "_l", arg_5_2:Find("selected"))
		elseif arg_5_0 == UIItemList.EventUpdate then
			local var_5_0 = self.attrIds[arg_5_1 + 1]

			setActive(arg_5_2:Find("selected"), self.curAttrIdx == arg_5_1 + 1)
			setText(arg_5_2:Find("value"), self.contextData.char:GetAttr(var_5_0))
			setTextColor(arg_5_2:Find("value"), Color.NewHex(self.curAttrIdx == arg_5_1 + 1 and "47b9f4" or "6f6f82"))
		end

		return
	end)

	return
end

function NewEducateAssessPanel:Show(arg_6_1)
	NewEducateAssessPanel.super.Show(self)

	self.callback = arg_6_1

	self:OverlayPanel(self._tf, {
		groupDelta = 1
	})
	self:InitData()
	self:InitStaticUI()
	self:PlayAnim()

	return
end

function NewEducateAssessPanel:InitData()
	self.speed = 1

	local var_7_0 = self.contextData.char:GetRoundData()

	self.isEndless = var_7_0:IsEndless()

	local var_7_1 = pg.child2_target[var_7_0:getConfig("target_id")]

	self.rank = var_7_1.display[self.contextData.char:GetAssessRankIdx()]
	self.totolHP = var_7_1.attr_sum * var_7_0:GetExtraFactor()
	self.isFail = self.contextData.char:GetAttrSum() < self.totolHP
	self.damageHP = 0
	self.attrIds = self.contextData.char:GetAttrIds()
	self.curAttrIdx = 1
	self.tag = self.contextData.char:GetPersonalityTag()
	self.charConfig = self.contextData.char:getConfig("spine_char")
	self.standardValue = self.totolHP / #self.attrIds
	self.actionConfig = {}

	underscore.each(self.contextData.char:getConfig("exam_action")[self.tag], function(arg_8_0)
		table.insert(self.actionConfig, {
			value = self.standardValue * arg_8_0[1] / 100,
			name = arg_8_0[2]
		})

		return
	end)
	table.sort(self.actionConfig, CompareFuncs({
		function(arg_9_0)
			return -arg_9_0.value
		end
	}))

	if self.isEndless then
		local var_7_2, var_7_3, var_7_4 = var_7_0:GetEndlessProgressInfos()

		setText(self.targetTextTF, i18n("child2_assess_tip_target", var_7_4))
	else
		local var_7_5, var_7_6, var_7_7 = var_7_0:GetProgressInfo()

		setText(self.targetTextTF, i18n("child2_assess_tip_target", var_7_7))
	end

	return
end

function NewEducateAssessPanel:GetAtkActionName(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(self.actionConfig) do
		if arg_10_1 > iter_10_1.value then
			return iter_10_1.name
		end
	end

	return self.actionConfig[#self.actionConfig].name
end

function NewEducateAssessPanel:InitStaticUI()
	local var_11_0 = self.contextData.char:GetRoundData()
	local var_11_1 = var_11_0:IsEndless()

	setActive(self.endlessTF, var_11_1)

	if var_11_1 then
		local var_11_2 = var_11_0:GetWave()
		local var_11_3 = var_11_0:GetHeighestWave()

		setText(self.endlessTF:Find("Text"), i18n("child2_endless_assest_wave", var_11_2))
		setActive(self.endlessTF:Find("new"), var_11_3 < var_11_2)
	end

	LoadImageSpriteAtlasAsync("ui/neweducateassesspanel_atlas", "bg_" .. self.tag, self.bgTF)
	removeAllChildren(self.bossTF)
	removeAllChildren(self.roleTF)
	setActive(self.resultTF, false)
	setActive(self.damageTF, false)
	setActive(self.damageCritTF, false)
	setActive(self.resultTF:Find("title_gold"), self.rank == "S")
	setActive(self.resultTF:Find("title_red"), self.rank ~= "S")
	LoadImageSpriteAtlasAsync("ui/neweducateassesspanel_atlas", self.rank, self.rankTF)
	setFillAmount(self.damageBlood, 0)

	self.bloodText.text = self.totolHP - self.damageHP .. "/" .. self.totolHP

	table.sort(self.attrIds)
	self.attrUIList:align(#self.attrIds)

	return
end

function NewEducateAssessPanel:ShowResult()
	setActive(self.resultTF, true)
	self:emit(NewEducateMainMediator.ON_SET_ASSESS_RANK, self.contextData.char:GetAssessRankIdx(), self.isEndless and self.isFail, function()
		existCall(self.callback)

		return
	end)

	return
end

function NewEducateAssessPanel:PlayAnim()
	seriesAsync({
		function(arg_15_0)
			self:ShowTip(arg_15_0)

			return
		end,
		function(arg_16_0)
			self:LoadChar(arg_16_0)

			return
		end,
		function(arg_17_0)
			self:CheckGuide(arg_17_0)

			return
		end,
		function(arg_18_0)
			self:PlayOneATK(arg_18_0)

			return
		end
	}, function()
		self:ShowResult()

		return
	end)

	return
end

function NewEducateAssessPanel:ShowTip(arg_20_1)
	setActive(self.assessTF, false)
	setActive(self.tipTF, true)
	onDelayTick(function()
		setActive(self.tipTF, false)
		setActive(self.assessTF, true)
		arg_20_1()

		return
	end, 1)

	return
end

function NewEducateAssessPanel:CheckGuide(arg_22_1)
	if pg.NewStoryMgr.GetInstance():IsPlayed("tb2_12") then
		arg_22_1()
	else
		pg.m02:sendNotification(GAME.STORY_UPDATE, {
			storyId = "tb2_12"
		})
		pg.NewGuideMgr.GetInstance():Play("tb2_12", {
			self.contextData.char.id
		}, arg_22_1, arg_22_1)
	end

	return
end

function NewEducateAssessPanel:LoadChar(arg_23_1)
	pg.UIMgr.GetInstance():LoadingOn()
	seriesAsync({
		function(arg_24_0)
			local var_24_0

			if self.isEndless then
				var_24_0 = self.charConfig.endless_boss or self.charConfig.boss
			end

			PoolMgr.GetInstance():GetSpineChar(var_24_0, true, function(arg_25_0)
				self.bossName = var_24_0
				self.bossModel = arg_25_0
				tf(arg_25_0).localScale = Vector3(1, 1, 1)

				arg_25_0:GetComponent("SpineAnimUI"):SetAction("child2_boss_normal", 0)
				setParent(arg_25_0, self.bossTF)
				arg_24_0()

				return
			end)

			return
		end,
		function(arg_26_0)
			PoolMgr.GetInstance():GetSpineChar(self.charConfig[self.tag], true, function(arg_27_0)
				self.roleName = self.charConfig[self.tag]
				self.roleModel = arg_27_0
				tf(arg_27_0).localScale = Vector3(1, 1, 1)

				arg_27_0:GetComponent("SpineAnimUI"):SetAction(self.roleName .. "_normal", 0)
				setParent(arg_27_0, self.roleTF)
				arg_26_0()

				return
			end)

			return
		end
	}, function()
		pg.UIMgr.GetInstance():LoadingOff()
		existCall(arg_23_1)

		return
	end)

	return
end

function NewEducateAssessPanel:PlayOneATK(arg_29_1)
	local var_29_0 = self.attrIds[self.curAttrIdx]
	local var_29_1 = self.contextData.char:GetAttr(self.attrIds[self.curAttrIdx])

	self.damageHP = self.damageHP + var_29_1

	local var_29_2 = self:GetAtkActionName(var_29_1)
	local var_29_3

	if var_29_1 >= self.standardValue * NewEducateAssessPanel.CRIT_PERCENT / 100 then
		var_29_3 = self.damageCritTF or self.damageTF
	end

	setText(var_29_3, "-" .. var_29_1)

	local var_29_4 = self.bossModel:GetComponent(typeof(SpineAnimUI))

	var_29_4:SetAction("child2_boss_normal", 0)

	local var_29_5 = self.roleModel:GetComponent(typeof(SpineAnimUI))

	var_29_5:SetAction(self.roleName .. "_normal", 0)
	seriesAsync({
		function(arg_30_0)
			self.attrUIList:align(#self.attrIds)
			blinkAni(self.attrUIList.container:Find(tostring(var_29_0)), 0.2 / self.speed, 3)
			self:managedTween(LeanTween.delayedCall, function()
				arg_30_0()

				return
			end, 1 / self.speed, nil)

			return
		end,
		function(arg_32_0)
			var_29_5:SetActionCallBack(function(arg_33_0)
				if arg_33_0 == "finish" then
					arg_32_0()
					var_29_5:SetActionCallBack(nil)
					var_29_5:SetAction(self.roleName .. "_normal", 0)
				end

				return
			end)
			var_29_5:SetAction(var_29_2, 0)

			return
		end,
		function(arg_34_0)
			setActive(var_29_3, true)
			setFillAmount(self.damageBlood, math.min(self.damageHP / self.totolHP, 1))

			self.bloodText.text = math.max(0, self.totolHP - self.damageHP) .. "/" .. self.totolHP

			if self.damageHP < self.totolHP then
				var_29_4:SetActionCallBack(function(arg_35_0)
					if arg_35_0 == "finish" then
						setActive(var_29_3, false)
						arg_34_0()
						var_29_4:SetActionCallBack(nil)
						var_29_4:SetAction("child2_boss_normal", 0)
					end

					return
				end)
				var_29_4:SetAction("child2_boss_shouji", 0)
			else
				var_29_4:SetActionCallBack(function(arg_36_0)
					if arg_36_0 == "finish" then
						setActive(var_29_3, false)
						arg_34_0()
						var_29_4:SetActionCallBack(nil)
						var_29_4:Pause()
					end

					return
				end)
				var_29_4:SetAction("child2_boss_jidao", 0)
			end

			return
		end
	}, function()
		if self.damageHP >= self.totolHP or self.curAttrIdx == #self.attrIds then
			arg_29_1()
		else
			self.curAttrIdx = self.curAttrIdx + 1

			self:managedTween(LeanTween.delayedCall, function()
				self:PlayOneATK(arg_29_1)

				return
			end, 0.5 / self.speed, nil)
		end

		return
	end)

	return
end

function NewEducateAssessPanel:AdjustSpeed()
	self.speed = NewEducateAssessPanel.SPEED

	if self.bossModel then
		self:GetAnimationState(self.bossModel).TimeScale = self.speed
	end

	if self.roleModel then
		self:GetAnimationState(self.roleModel).TimeScale = self.speed
	end

	return
end

function NewEducateAssessPanel:GetAnimationState(arg_40_1)
	return arg_40_1:GetComponent("Spine.Unity.SkeletonGraphic").AnimationState
end

function NewEducateAssessPanel:Hide()
	self:UnOverlayPanel(self._tf)

	if self.bossName and self.bossModel then
		self:GetAnimationState(self.bossModel).TimeScale = 1

		PoolMgr.GetInstance():ReturnSpineChar(self.bossName, self.bossModel)

		self.bossName = nil
		self.bossModel = nil
	end

	if self.roleName and self.roleModel then
		self:GetAnimationState(self.roleModel).TimeScale = 1

		PoolMgr.GetInstance():ReturnSpineChar(self.roleName, self.roleModel)

		self.roleName = nil
		self.roleModel = nil
	end

	NewEducateAssessPanel.super.Hide(self)

	return
end

function NewEducateAssessPanel:OnDestroy()
	self:Hide()

	return
end

return NewEducateAssessPanel
