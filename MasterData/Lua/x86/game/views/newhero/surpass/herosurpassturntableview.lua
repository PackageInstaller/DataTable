local HeroSurpassTurntableView = class("HeroSurpassTurntableView", ReduxView)
local var_0_1 = math.sqrt
local var_0_2 = math.cos
local var_0_4 = math.pi / 180
local var_0_5 = math.min
local var_0_6 = math.max
local var_0_7 = 30
local var_0_8 = 612
local var_0_9 = 30
local var_0_10 = 4

function HeroSurpassTurntableView:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function HeroSurpassTurntableView:Init()
	self:BindCfgUI()
	self:AddUIListener()
	self:InitSurpassList()
end

function HeroSurpassTurntableView:AddUIListener()
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.BeginDragFun)))
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(self, self.OnDragFun)))
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.EndDragFun)))
end

function HeroSurpassTurntableView:BeginDragFun(arg_4_1, arg_4_2)
	if self.isCantMove then
		return
	end

	self.beginMousePos = Input.mousePosition
end

function HeroSurpassTurntableView:OnDragFun(arg_5_1, arg_5_2)
	if self.isCantMove then
		return
	end

	local var_5_0 = 0

	if self.beginMousePos.y - Input.mousePosition.y > var_0_9 then
		var_5_0 = -1
	elseif self.beginMousePos.y - Input.mousePosition.y < -var_0_9 then
		var_5_0 = 1
	end

	if var_5_0 ~= 0 and self.moveIndex ~= var_5_0 then
		self:DragMove(var_5_0)
	end
end

function HeroSurpassTurntableView:EndDragFun(arg_6_1, arg_6_2)
	self.moveIndex = nil
end

function HeroSurpassTurntableView:DragMove(arg_7_1)
	self.moveIndex = arg_7_1

	self:AddMoveTween(self.selectStarStage + arg_7_1)
end

function HeroSurpassTurntableView:DelMoveTween()
	if self.moveTween then
		self.moveTween:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.moveTween.id)

		self.moveTween = nil
	end
end

function HeroSurpassTurntableView:UpdateSurpassListShow(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	for iter_9_0, iter_9_1 in pairs(self.surpassList) do
		iter_9_1:GetTransform().localRotation = Quaternion.Euler(0, 0, -arg_9_1.z)

		local var_9_1 = var_0_5(6, (var_0_6(1, iter_9_0 + (var_0_10 - arg_9_2))))

		iter_9_1:ChangeAlpha((Mathf.Lerp(arg_9_4[iter_9_0].alpha, self.surpassList[var_9_1] and self.surpassList[var_9_1]:GetBeginAlpha() or 1, arg_9_3)))

		if arg_9_2 ~= iter_9_0 then
			iter_9_1:SetScale((Mathf.Lerp(arg_9_4[iter_9_0].scale, self.surpassList[var_9_1] and self.surpassList[var_9_1]:GetBeginScale() or 1, arg_9_3)))
		end
	end
end

function HeroSurpassTurntableView:AddMoveTween(arg_10_1, arg_10_2)
	if arg_10_1 > 6 or arg_10_1 < self.beginStar then
		return
	end

	local var_10_0 = Quaternion.Euler(self.surpassnodeTrs_.localEulerAngles)
	local var_10_1 = Quaternion.Euler(0, 0, var_0_7 * arg_10_1 - var_0_10 * var_0_9)
	local var_10_2 = false
	local var_10_3 = false
	local var_10_4 = false

	self:DelMoveTween()

	if arg_10_1 ~= self.selectStarStage then
		self.planNodeView:ShowView(false)
	elseif not arg_10_2 then
		self.surpassList[arg_10_1]:PlaySelectAni(true)
		self:SelectSurpassItem(arg_10_1, arg_10_2)

		var_10_3 = true
	end

	local var_10_5 = {}

	for iter_10_0, iter_10_1 in pairs(self.surpassList) do
		var_10_5[iter_10_0] = {}
		var_10_5[iter_10_0].alpha = iter_10_1:GetAlpha()

		local var_10_6 = iter_10_1:GetScale()

		if var_10_6 and var_10_6.x > 1 then
			var_10_6 = Vector3.one
		end

		var_10_5[iter_10_0].scale = var_10_6
	end

	self.moveTween = LeanTween.value(0, 1, 0.6):setOnUpdate(LuaHelper.FloatAction(function(arg_11_0)
		self.isCantMove = arg_11_0 < 0.95

		if arg_11_0 > 0.45 and not var_10_2 then
			for iter_11_0, iter_11_1 in pairs(self.surpassList) do
				if iter_11_0 ~= arg_10_1 then
					iter_11_1:PlayScaleAni(false)
				end
			end

			var_10_2 = true
		end

		if arg_11_0 > 0.7 and not var_10_3 then
			self:SelectSurpassItem(arg_10_1, arg_10_2)

			var_10_3 = true
		end

		if arg_11_0 > 0.85 and not var_10_4 then
			self.surpassList[arg_10_1]:PlayScaleAni(true)

			var_10_4 = true
		end

		self.surpassnodeTrs_.localRotation = Quaternion.Lerp(var_10_0, var_10_1, arg_11_0)

		self:UpdateSurpassListShow(self.surpassnodeTrs_.localEulerAngles, arg_10_1, arg_11_0, var_10_5)

		self.selectStarStage = arg_10_1
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self.isCantMove = false

		if self.moveTween then
			self.moveTween:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

			self.moveTween = nil
		end

		if not arg_10_2 and not self.planNodeView:GetSelectIndex() then
			self.surpassList[arg_10_1]:PlaySelectAni(true)
		end

		self.surpassnodeTrs_.localRotation = var_10_1

		self:UpdateSurpassListShow(self.surpassnodeTrs_.localEulerAngles, arg_10_1, 1, var_10_5)
	end)):setEase(LeanTweenType.easeOutQuad)
end

function HeroSurpassTurntableView:SelectTargetStarStage(arg_13_1, arg_13_2)
	self:AddMoveTween(arg_13_1, arg_13_2)
end

function HeroSurpassTurntableView:AgainPalyNowAni()
	if self.selectStarStage then
		self:AddMoveTween(self.selectStarStage, self.planNodeView:GetSelectStar())
	end
end

function HeroSurpassTurntableView:GetOtherPos(arg_15_1)
	return var_0_1(self.radius * self.radius - arg_15_1 * arg_15_1)
end

function HeroSurpassTurntableView:GetTargetAnglePos(arg_16_1)
	arg_16_1 = arg_16_1 * var_0_4

	local var_16_0 = self.radius * var_0_2(arg_16_1)

	return self:GetOtherPos(var_16_0), var_16_0
end

function HeroSurpassTurntableView:InitSurpassList()
	self.radius = var_0_8
	self.surpassList = {}

	for iter_17_0 = 1, 6 do
		local var_17_0 = NewHeroSurpassItem.New(self, self["btnbigitem" .. iter_17_0 .. "Go_"])

		var_17_0:SetClickCallBack(function()
			if self.selectStarStage ~= iter_17_0 or self.planNodeView:GetSelectIndex() then
				self:SelectTargetStarStage(iter_17_0)
			end
		end)

		self.surpassList[iter_17_0] = var_17_0
	end

	self.planNodeView = HeroSurpassPlanNode.New(self, self.plannodeGo_)

	self.planNodeView:SetClickCallBack(function(arg_19_0)
		self.surpassList[self.selectStarStage]:PlaySelectAni(false)
		self:RefreshInfoView(arg_19_0)
	end)
end

function HeroSurpassTurntableView:GetTargetSelectPlanStarID()
	return (HeroStarCfg.get_id_list_by_star[self.beginStar] or nil) and (HeroStarCfg.get_id_list_by_star[self.beginStar][2] or nil)
end

function HeroSurpassTurntableView:SelectSurpassItem(arg_21_1, arg_21_2)
	local var_21_0 = self.surpassList[arg_21_1]

	self.planNodeView:RefreshUi(self.surpassList[arg_21_1]:GetStarStage(), self.heroInfo)

	if arg_21_1 == self.beginStar and not arg_21_2 then
		self.planNodeView:ShowAndNotCancelSelect()

		if self.selectStarStage == arg_21_1 then
			arg_21_2 = self.planNodeView:GetSelectStar()
		end

		arg_21_2 = arg_21_2 or self:GetTargetSelectPlanStarID()
	else
		self.planNodeView:ShowView(true)
	end

	if arg_21_2 then
		self.planNodeView:ClickPlanItemByStarID(arg_21_2)
		self:RefreshInfoView(arg_21_2)
		self.surpassList[arg_21_1]:PlaySelectAni(false)
	else
		local var_21_1 = var_21_0:GetStarIdList()

		self:RefreshInfoView((var_21_1 or nil) and (var_21_1[1] or nil))
	end

	self.selectStarStage = arg_21_1
end

function HeroSurpassTurntableView:RefreshInfoView(arg_22_1)
	if arg_22_1 and self.infoViewRefreshCallback then
		self.infoViewRefreshCallback(arg_22_1)
	end
end

function HeroSurpassTurntableView:SetInfoShowCallBack(arg_23_1)
	self.infoViewRefreshCallback = arg_23_1
end

function HeroSurpassTurntableView:SetHeroId(arg_24_1)
	self.isCantMove = false
	self.heroID = arg_24_1
	self.heroCfg = HeroCfg[arg_24_1]

	self:InitSurpassListShow(HeroStarCfg[self.heroCfg.unlock_star].star)
	self:RefreshSurpassData()
end

function HeroSurpassTurntableView:InitSurpassListShow(arg_25_1)
	local var_25_0 = 0

	for iter_25_0, iter_25_1 in pairs(self.surpassList) do
		if iter_25_0 < arg_25_1 then
			iter_25_1:SetActive(false)
		else
			iter_25_1:SetActive(true)
			iter_25_1:SetStarStage(iter_25_0)

			var_25_0 = var_25_0 + 1
		end
	end

	self.showNum = var_25_0
	self.beginStar = arg_25_1
end

function HeroSurpassTurntableView:RefreshSurpassData()
	self.heroInfo = self.dataProxy:GetHeroData(self.heroID)

	for iter_26_0, iter_26_1 in pairs(self.surpassList) do
		iter_26_1:RefreshUI(self.heroInfo)
	end

	local var_26_0 = HeroStarCfg[SurpassTools.GetNextSurpassStarID(self.heroInfo.star)] or HeroStarCfg[self.heroInfo.star]

	if var_26_0.phase == 0 then
		self:SelectTargetStarStage(var_26_0.star)
	else
		self:SelectTargetStarStage(var_26_0.star, var_26_0.id)
	end
end

function HeroSurpassTurntableView:SetDataProxy(arg_27_1)
	self.dataProxy = arg_27_1
end

function HeroSurpassTurntableView:OnGoldChange()
	if self.surpassList and self.surpassList[self.selectStarStage] and self.heroInfo then
		self.planNodeView:RefreshUi(self.surpassList[self.selectStarStage]:GetStarStage(), self.heroInfo)
	end

	if self.heroInfo then
		for iter_28_0, iter_28_1 in pairs(self.surpassList or {}) do
			iter_28_1:RefreshUI(self.heroInfo)
		end
	end
end

function HeroSurpassTurntableView:Dispose()
	for iter_29_0, iter_29_1 in pairs(self.surpassList or {}) do
		if iter_29_1 then
			iter_29_1:Dispose()
		end
	end

	self.planNodeView:Dispose()
	self:DelMoveTween()
	HeroSurpassTurntableView.super.Dispose(self)
end

return HeroSurpassTurntableView
