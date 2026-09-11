local IdolTraineeCampDeployCharacterView = class("IdolTraineeCampDeployCharacterView", ReduxView)

function IdolTraineeCampDeployCharacterView:UIName()
	return "Widget/BackHouseUI/IdolTrainee/IdolTraineeCampDeployCharaView"
end

function IdolTraineeCampDeployCharacterView:UIParent()
	return manager.ui.uiMain.transform
end

function IdolTraineeCampDeployCharacterView:OnCtor()
	self.selHeroID = nil
	self.dataList = nil
end

function IdolTraineeCampDeployCharacterView:Init()
	self:BindCfgUI()

	self.characterScroll = LuaList.New(handler(self, self.IndexItem), self.heroList_, IdolTraineeCampCharacterItem)
	self.targets = {}

	for iter_4_0 = 1, self.targets_.childCount do
		local var_4_0 = self.targets_:GetChild(iter_4_0 - 1)
		local var_4_1 = {}

		self:BindCfgUI(var_4_0.gameObject, var_4_1)

		var_4_1.stateController = var_4_1.controllers_:GetController("state")

		table.insert(self.targets, {
			trs = var_4_0,
			com = var_4_1
		})
	end

	self:RegisterEvents()
	self:UpdateCurHeroNum()

	function self.selectCharaFunc(arg_5_0)
		self.selHeroID = IdolTraineeCampCharacterItem.curGrabbing and IdolTraineeCampBridge.GetCharacterHeroID(IdolTraineeCampCharacterItem.curGrabbing) or arg_5_0

		self.characterScroll:Refresh()
	end

	self.recallHeroFunc = handler(self, self.RecallHero)

	self:AddBtnListenerScale(self.backBtn_, nil, function()
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in pairs(IdolTraineeCampBridge.charaAtPos) do
			table.insert(var_6_0, {
				hero_id = IdolTraineeCampBridge.GetCharacterHeroID(iter_6_1),
				pos = iter_6_0
			})
		end

		IdolTraineeAction.RequestSetHeroPos(var_6_0, function()
			JumpTools.Back()
		end)
	end)
	self:AddBtnListenerScale(self.quickRecall_, nil, function()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs(IdolTraineeCampBridge.charaAtPos) do
			local var_8_1 = IdolTraineeCampBridge.GetCharacterHeroID(iter_8_1)

			if DormData:GetHeroFatigue(var_8_1) < GameSetting.canteen_hero_fatigue_max.value[1] then
				table.insert(var_8_0, {
					hero_id = var_8_1,
					pos = iter_8_0
				})
			end
		end

		IdolTraineeAction.RequestSetHeroPos(var_8_0, function()
			IdolTraineeCampBridge.RefreshCharacterAtPos(false)
			self:UpdateCurHeroNum()
			self.characterScroll:Refresh()
		end)
	end)
end

function IdolTraineeCampDeployCharacterView:RecallHero(arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(IdolTraineeCampBridge.charaAtPos) do
		local var_10_1 = IdolTraineeCampBridge.GetCharacterHeroID(iter_10_1)

		if arg_10_1 ~= var_10_1 then
			table.insert(var_10_0, {
				hero_id = var_10_1,
				pos = iter_10_0
			})
		end
	end

	IdolTraineeAction.RequestSetHeroPos(var_10_0, function()
		IdolTraineeCampBridge.RefreshCharacterAtPos(false)
		self:UpdateCurHeroNum()
		self.characterScroll:Refresh()
	end)
end

function IdolTraineeCampDeployCharacterView:IndexItem(arg_12_1, arg_12_2)
	arg_12_2:RefreshUI(self, self.dataList[arg_12_1])
	arg_12_2:SetOnPointerDown(self.selectCharaFunc)
	arg_12_2:RecallHero(self.recallHeroFunc)
end

function IdolTraineeCampDeployCharacterView:IndexOf(arg_13_1)
	return table.indexof(self.dataList, self.heroID)
end

function IdolTraineeCampDeployCharacterView:RefreshDormHeroList()
	self.dataList = IdolTraineeData:GetIdolHeroList()

	self:SortHeroList()
	self.characterScroll:StartScroll(#self.dataList)
end

function IdolTraineeCampDeployCharacterView:SortHeroList()
	local var_15_0 = {
		[DormEnum.DormHeroState.InCanteenJob] = "canteen",
		[DormEnum.DormHeroState.InCanteenEntrust] = "task",
		[DormEnum.DormHeroState.InPublicDorm] = "lobby",
		[DormEnum.DormHeroState.InIdolTraineeCamp] = "idolCamp"
	}
	local var_15_1 = {
		[DormEnum.DormHeroState.InCanteenJob] = true,
		[DormEnum.DormHeroState.InCanteenEntrust] = true,
		[DormEnum.DormHeroState.InPublicDorm] = true,
		[DormEnum.DormHeroState.InPrivateDorm] = true,
		[DormEnum.DormHeroState.InIdolTraineeCamp] = true
	}

	CommonTools.UniversalSortEx(self.dataList, {
		map = function(arg_16_0)
			local var_16_1 = DormData:GetHeroTemplateInfo(arg_16_0):GetHeroState()
			local var_16_2 = nullable(var_15_0, var_16_1) or "dorm"

			if not nullable(var_15_1, var_16_1) then
				return 1
			end

			if var_16_2 == "idolCamp" then
				return 2
			end

			return 0
		end
	}, {
		map = function(arg_17_0)
			return (DormData:GetHeroArchiveID(arg_17_0))
		end
	}, {
		map = function(arg_18_0)
			return -arg_18_0
		end
	})
end

function IdolTraineeCampDeployCharacterView:OnEnter()
	self:RefreshDormHeroList()
	self:UpdateCurHeroNum()
end

function IdolTraineeCampDeployCharacterView:OnExit()
	self.selHeroID = nil
end

function IdolTraineeCampDeployCharacterView:OnTop()
	manager.windowBar:HideBar()
end

function IdolTraineeCampDeployCharacterView:Dispose()
	IdolTraineeCampCharacterItem.curDragging = nil

	self.characterScroll:Dispose()
	IdolTraineeCampDeployCharacterView.super.Dispose(self)
end

function IdolTraineeCampDeployCharacterView:RegisterEvents()
	self:RegistEventListener(DORM_REFRESH_HERO_DEPLOY_LIST, function()
		self.characterScroll:Refresh()
		self:UpdateCurHeroNum()
	end)
	self:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, function()
		self.characterScroll:Refresh()
	end)
end

function IdolTraineeCampDeployCharacterView:UpdateCurHeroNum()
	self.curnumText_.text = IdolTraineeCampBridge.entityManager:EntityNum()
end

function IdolTraineeCampDeployCharacterView:SetCharacterAtPos(arg_27_1, arg_27_2)
	IdolTraineeCampBridge.SetPosOfCharacter(arg_27_1, arg_27_2, true)
end

function IdolTraineeCampDeployCharacterView:SnapCharacterOnTarget(arg_28_1, arg_28_2)
	local var_28_0 = nullable(Dorm.storage:PickData("idol.camp.pos." .. arg_28_2), "transform")

	if var_28_0 then
		Dorm.DormEntityManager.PutEntityAt(arg_28_1, var_28_0)

		return true
	end
end

function IdolTraineeCampDeployCharacterView:NotDragOutYet(arg_29_1)
	return UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(self.dragOutRect_, arg_29_1.position, manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera)
end

function IdolTraineeCampDeployCharacterView:BeginDragHeroList(arg_30_1, arg_30_2)
	self.heroList_:OnBeginDrag(arg_30_1)

	self.isDraggingHeroList = true

	if arg_30_2 and arg_30_2:IsDragBlocked() then
		return
	end

	for iter_30_0, iter_30_1 in pairs(self.targets) do
		iter_30_1.com.stateController:SetSelectedState("show")
	end
end

function IdolTraineeCampDeployCharacterView:DragHeroList(arg_31_1, arg_31_2)
	self.heroList_:OnDrag(arg_31_1)
end

function IdolTraineeCampDeployCharacterView:EndDragHeroList(arg_32_1, arg_32_2)
	if self.isDraggingHeroList then
		self.heroList_:OnEndDrag(arg_32_1)

		for iter_32_0, iter_32_1 in pairs(self.targets) do
			iter_32_1.com.stateController:SetSelectedState("hide")
		end
	end
end

function IdolTraineeCampDeployCharacterView:HoverHightDragOnTarget(arg_33_1, arg_33_2)
	for iter_33_0 = 1, #self.targets do
		self.targets[iter_33_0].com.stateController:SetSelectedState(iter_33_0 == arg_33_2 and "highlight" or "show")
	end
end

return IdolTraineeCampDeployCharacterView
