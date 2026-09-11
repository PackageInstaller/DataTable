local DanceDIYMainView = class("DanceDIYMainView", ReduxView)

function DanceDIYMainView:UIName()
	return "Widget/BackHouseUI/IdolDance/IdolDanceMainUI"
end

function DanceDIYMainView:UIParent()
	return manager.ui.uiMain.transform
end

local var_0_1 = class("DanceDIYMainView.SubView", BaseView)

function var_0_1:Ctor(arg_3_1, arg_3_2)
	self.gameObject_ = arg_3_1
	self.transform_ = arg_3_1.transform
	self.parentView = arg_3_2

	self:BindCfgUI()

	self.showListController = self.controllers_:GetController("change")

	self:InitUI()
end

function var_0_1:InitUI()
	return
end

function var_0_1:SetVisible(arg_5_1)
	self.showListController:SetSelectedState(arg_5_1 and "on" or "off")
end

function var_0_1:Visible()
	return self.showListController:GetSelectedState() ~= "off"
end

function var_0_1:CanHide()
	return true
end

local var_0_2 = class("DanceDIYMainView.SelectDIYDataSubView", var_0_1)
local var_0_3 = class("DanceDIYMainView.SelectDIYDataSubView.DataItem", DanceDIYDataItem)

function var_0_3:InitUI()
	var_0_3.super.InitUI(self)

	self.playStateController = self.controllers_:GetController("btnPlay")
end

function var_0_3:SetOnEditFunc(arg_9_1)
	self.onClickEditBtn = arg_9_1
end

function var_0_3:SetOnDelFunc(arg_10_1)
	self.onClickDelBtn = arg_10_1
end

function var_0_3:AddUIListeners()
	var_0_3.super.AddUIListeners(self)
	self:AddBtnListener(self.editBtn_, nil, function()
		self:OnEditBtnClick()
	end)
	self:AddBtnListener(self.delBtn_, nil, function()
		self:OnDelBtnClick()
	end)
end

function var_0_3:OnDelBtnClick()
	if self.onClickDelBtn then
		self.onClickDelBtn(self.loadData)
	end
end

function var_0_3:OnEditBtnClick()
	if self.onClickEditBtn then
		self.onClickEditBtn(self.loadData)
	end
end

function var_0_2:InitUI()
	self.select = nil
	self.diyDataUIList = LuaList.New(handler(self, self.IndexItem), self.uiList_.gameObject, var_0_3)
	self.categoryController = self.controllers_:GetController("category")

	function self.clickItemFunc(arg_17_0)
		self.select = arg_17_0

		self:Refresh()

		if self.OnClickItem then
			self.OnClickItem(arg_17_0)
		end
	end

	self:AddBtnListener(self.myDataTabBtn_, nil, function()
		self:SwitchList("myData")
	end)
	self:AddBtnListener(self.sharedDataTabBtn_, nil, function()
		self:SwitchList("sharedData")
	end)
end

function var_0_2:OnEnter()
	self:SwitchList("myData")
end

function var_0_2:Dispose()
	self.dataIdxList = nil

	self.diyDataUIList:Dispose()
	var_0_2.super.Dispose(self)
end

function var_0_2:SwitchList(arg_22_1)
	self.categoryController:SetSelectedState(arg_22_1)

	self.select = nil

	DIYBridge:StopAllPreviewTasks()
	self:ResetDataList()
end

function var_0_2:IndexItem(arg_23_1, arg_23_2)
	local var_23_0 = self.dataIdxList[arg_23_1]
	local var_23_1 = self.categoryController:GetSelectedState() == "sharedData"
	local var_23_2 = {
		id = self.dataIdxList[arg_23_1]
	}

	if var_23_1 then
		var_23_2.source = IdolTraineeConst.DataSource.MySharedData

		local var_23_3 = PlayerData:GetPlayerInfo().nick

		var_23_2.name = IdolTraineeTools.GetSharedDIYDanceDataName(var_23_3)
		var_23_2.authorInfo = {
			uid = PlayerData:GetPlayerInfo().userID,
			name = var_23_3,
			headId = PlayerData:GetCurPortrait(),
			frameId = PlayerData:GetCurFrame()
		}

		arg_23_2:SetDisplayName(var_23_2.name)
	else
		var_23_2.source = IdolTraineeConst.DataSource.MyData
		var_23_2.name = IdolTraineeTools.GetDIYDanceDataName(var_23_0)

		arg_23_2:SetDisplayName(var_23_2.name)
	end

	arg_23_2:SetData(var_23_2, var_23_1)
	arg_23_2:SetSelected(nullable(self.select, "id") == self.dataIdxList[arg_23_1])
	arg_23_2:SetOnClick(self.clickItemFunc)
	arg_23_2:SetOnEditFunc(self.OnEditItem)
	arg_23_2:SetOnDelFunc(self.OnDelItem)
	arg_23_2.playStateController:SetSelectedState(nullable(self.parentView, "preview", "id") == var_23_0 and "play" or "pause")
end

function var_0_2:ResetDataList()
	self.dataIdxList = {}

	if self.categoryController:GetSelectedState() == "myData" then
		for iter_24_0 = 1, IdolTraineeData.DanceDIYSlotLimit() do
			table.insert(self.dataIdxList, iter_24_0)
		end
	elseif IdolTraineeData.mySharedDIY then
		for iter_24_1, iter_24_2 in pairs(IdolTraineeData.mySharedDIY) do
			table.insert(self.dataIdxList, iter_24_1)
		end
	end

	self.diyDataUIList:StartScrollByPosition(#self.dataIdxList, self.diyDataUIList:GetScrolledPosition())
end

function var_0_2:Refresh()
	self.diyDataUIList:Refresh()
end

function var_0_2:SetVisible()
	return
end

function var_0_2:Visible()
	return true
end

function var_0_2:CanHide()
	return false
end

function var_0_2:GetSelectingDataLoadInfo()
	return self.select
end

local var_0_4 = class("DanceDIYMainView.SelectSceneSubView", var_0_1)
local DanceDIYSceneItem = import("game.views.dormIdolTrainee.dance.DanceDIYSceneItem")

function var_0_4:InitUI()
	self.sceneUIList = LuaList.New(handler(self, self.IndexItem), self.uiList_.gameObject, DanceDIYSceneItem)
	self.expandItem = {}

	self:BindCfgUI(self.changeCharaGo_, self.expandItem)
	self:AddBtnListenerScale(self.expandItem.btn_, nil, function()
		self:SetVisible(true)
	end)

	function self.clickItemFunc(arg_32_0)
		DIYBridge:SetScene(arg_32_0)
	end
end

function var_0_4:Dispose()
	self.sceneUIList:Dispose()
	var_0_4.super.Dispose(self)
end

function var_0_4:OnEnter(arg_34_1)
	self.sceneUIList:StartScroll(#IdolStageSceneCfg.all)
	self:Refresh()
end

function var_0_4:IndexItem(arg_35_1, arg_35_2)
	arg_35_2:SetData(IdolStageSceneCfg.all[arg_35_1])
	arg_35_2:SetSelected(DIYBridge.scene == arg_35_2.scene)
	arg_35_2:SetOnClick(self.clickItemFunc)
end

function var_0_4:Refresh()
	self.expandItem.icon_.sprite = getSpriteViaConfig("IdolStageIcon", IdolStageSceneCfg[DIYBridge.scene].stage_picture)

	self.sceneUIList:Refresh()
end

local var_0_6 = class("DanceDIYMainView.SelectCharaSubView", var_0_1)

function var_0_6:InitUI()
	self.heroList = {}
	self.curHeroID = nil
	self.curHeroIndex = nil
	self.heroUIList = LuaList.New(handler(self, self.IndexItem), self.uiList_.gameObject, IdolTraineeHeadItem)
	self.showListController = self.controllers_:GetController("change")
	self.charaItem = {}

	self:BindCfgUI(self.changeCharaGo_, self.charaItem)
	self:AddBtnListenerScale(self.charaItem.btn_, nil, function()
		self:SetVisible(true)
	end)
end

function var_0_6:Dispose()
	self.heroUIList:Dispose()
	var_0_6.super.Dispose(self)
end

function var_0_6:OnEnter(arg_40_1)
	self.heroList = IdolTraineeData:GetIdolHeroList(true)

	CommonTools.UniversalSortEx(self.heroList, {
		map = function(arg_41_0)
			return HeroTools.GetHeroIsUnlock(arg_41_0) and 1 or 0
		end
	})

	local var_40_0

	if not arg_40_1 then
		::label_40_0::

		var_40_0 = self.curHeroID or self.heroList[1]
	end

	self.curHeroID = var_40_0
	self.curHeroIndex = table.keyof(self.heroList, self.curHeroID)

	self.heroUIList:StartScroll(#self.heroList)
	self.heroUIList:ScrollToIndex(self.curHeroIndex)

	self.charaItem.icon_.sprite = DormHeroTools.GetBackHomeHeadSprite(self.curHeroID)
end

local var_0_7 = {
	ignoreDefender = true,
	ignoreAttacker = true
}

function var_0_6:IndexItem(arg_42_1, arg_42_2)
	arg_42_2:SetData(self.heroList[arg_42_1], self.curHeroID, function(arg_43_0)
		if HeroTools.GetHeroIsUnlock(arg_43_0.heroID_) then
			self:UpdateSelectCharacter(arg_43_0.heroID_)
			self:Refresh()
		end
	end, var_0_7)
end

function var_0_6:Refresh()
	self.charaItem.icon_.sprite = DormHeroTools.GetBackHomeHeadSprite(self.curHeroID)

	self.heroUIList:Refresh()
end

function var_0_6:UpdateSelectCharacter(arg_45_1)
	self.curHeroID = arg_45_1

	DIYBridge:SetCharacter(arg_45_1)
end

function DanceDIYMainView:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddUIListener()
end

function DanceDIYMainView:InitUI()
	self.subViews = {}
	self.selCharaSubView = var_0_6.New(self.selChara_, self)
	self.selSceneSubView = var_0_4.New(self.selScene_, self)
	self.selDataSubView = var_0_2.New(self.selData_, self)

	function self.selDataSubView.OnEditItem(arg_48_0)
		self:OnClickDataItem(arg_48_0)
	end

	function self.selDataSubView.OnClickItem(arg_49_0)
		local var_49_0 = IdolTraineeTools.GetDIYDataFromLoadInfo(arg_49_0)

		if var_49_0 then
			if self:UseSceneFromData() and nullable(IdolStageSceneCfg, var_49_0.scene) then
				DIYBridge:SetScene(var_49_0.scene)
			end

			self:PreviewSequence(arg_49_0, var_49_0)
		else
			self:OnClickDataItem(arg_49_0)
		end
	end

	function self.selDataSubView:OnDelItem()
		if self.id then
			local var_50_0 = self.id
			local var_50_1
			local var_50_2

			if self.source == IdolTraineeConst.DataSource.MyData then
				var_50_1 = "IDOL_DANCE_CONFIRM_DEL"
				var_50_2 = IdolTraineeAction.DeleteDanceDIYSequence
			else
				var_50_1 = "IDOL_DANCE_CONFIRM_STOP_SHARE"
				var_50_2 = IdolTraineeAction.StopShareDanceDIYSeqence
			end

			ShowMessageBox({
				content = GetTips(var_50_1),
				OkCallback = function()
					var_50_2(var_50_0)

					if nullable(self.preview, "id") == var_50_0 then
						self.preview = nil

						DIYBridge:StopAllPreviewTasks()
					end
				end
			})
		end
	end

	table.insert(self.subViews, self.selCharaSubView)
	table.insert(self.subViews, self.selSceneSubView)
	table.insert(self.subViews, self.selDataSubView)
end

function DanceDIYMainView:OnEnter()
	manager.ui:SetMainCamera("dance")

	self.preview = nil

	self:RegisterEvents()

	self.music = self.params_.music or DIYBridge.music
	self.musicName_.text = IdolStageMusicCfg[self.music].music_name

	self.selCharaSubView:OnEnter(self.params_.heroID)

	self.params_.heroID = nil

	self.selSceneSubView:OnEnter(DIYBridge.scene)
	self.selDataSubView:OnEnter()
end

function DanceDIYMainView:OnExit()
	self:RemoveAllEventListener()

	self.preview = nil

	for iter_53_0, iter_53_1 in ipairs(self.subViews) do
		iter_53_1:SetVisible(false)
	end
end

function DanceDIYMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if not self:HideSubView() then
			DormMinigame.Exit()
		end
	end)
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			isPrefab = true,
			pages = {
				"Widget/BackHouseUI/IdolDance/IdolDanceDescription_01",
				"Widget/BackHouseUI/IdolDance/IdolDanceDescription_02"
			}
		}
	})
end

function DanceDIYMainView:OnBehind()
	manager.windowBar:HideBar()
end

function DanceDIYMainView:Dispose()
	for iter_57_0, iter_57_1 in ipairs(self.subViews) do
		iter_57_1:Dispose()
	end

	DanceDIYMainView.super.Dispose(self)
end

function DanceDIYMainView:OnDanceDIYUpdate()
	self.selDataSubView:ResetDataList()
end

function DanceDIYMainView:OnSharedDanceDIYUpdate()
	self.selDataSubView:ResetDataList()
end

function DanceDIYMainView:UseSceneFromData()
	return true
end

function DanceDIYMainView:AddUIListener()
	self:AddBtnListenerScale(self.createDataBtn_, nil, function()
		local var_62_0 = IdolTraineeData:GetDanceDIYAvailableSlotIdx()

		if var_62_0 then
			self:GoToEdit({
				source = IdolTraineeConst.DataSource.MyData,
				id = var_62_0
			})
		else
			ShowTips("IDOL_DANCE_EDIT_NO_DIY_DATA_SLOT")
		end
	end)
	self:AddBtnListenerScale(self.editDataBtn_, nil, function()
		self:GoToEdit(self:GetCurSelectDIYData(), self:UseSceneFromData())
	end)
	self:AddBtnListenerScale(self.delDataBtn_, nil, function()
		local var_64_0 = self:GetCurSelectDIYData()

		if var_64_0.id then
			if var_64_0.source == IdolTraineeConst.DataSource.MyData then
				IdolTraineeAction.DeleteDanceDIYSequence(var_64_0.id)
			else
				IdolTraineeAction.StopShareDanceDIYSeqence(var_64_0.id)
			end
		end
	end)
	self:AddBtnListener(self.selMusic_, nil, function()
		JumpTools.OpenPageByJump("idolDanceSelMusic", {
			music = self.music,
			onSelectMusic = function(arg_66_0)
				self.music = arg_66_0
				self.musicName_.text = IdolStageMusicCfg[self.music].music_name
			end
		})
	end)
	self:AddBtnListener(self.emptyAreaBtn_, nil, function()
		self:HideSubView()
	end)
end

function DanceDIYMainView:RegisterEvents()
	self:RegistEventListener("ON_PREVIEW_STATE_UPDATE", function()
		self.selDataSubView:Refresh()
	end)
	self:RegistEventListener("IDOL_DANCE_CHANGE_MUSIC", function(arg_70_0)
		self.music = arg_70_0
		self.musicName_.text = IdolStageMusicCfg[self.music].music_name
	end)
	self:RegistEventListener("IDOL_DANCE_DIY_CHANGE_SCENE", function(arg_71_0)
		self.selSceneSubView:Refresh()
	end)
end

function DanceDIYMainView:GetCurSelectDIYData()
	return self.selDataSubView:GetSelectingDataLoadInfo()
end

function DanceDIYMainView:HideSubView()
	local var_73_0 = false

	for iter_73_0, iter_73_1 in ipairs(self.subViews) do
		if iter_73_1:CanHide() then
			if not var_73_0 and iter_73_1:Visible() then
				var_73_0 = true
			end

			iter_73_1:SetVisible(false)
		end
	end

	return var_73_0
end

function DanceDIYMainView:GoToEdit(arg_74_1, arg_74_2, arg_74_3)
	DIYBridge:StopAllPreviewTasks()
	JumpTools.OpenPageByJump("/idolDanceEdit", {
		load = arg_74_1,
		loadSceneFromSaveData = arg_74_2,
		readOnly = arg_74_3
	})
end

function DanceDIYMainView:OnClickDataItem(arg_75_1)
	if IdolTraineeTools.GetDIYDataFromLoadInfo(arg_75_1) then
		self:GoToEdit(arg_75_1, true, true)
	elseif IdolTraineeData:GetDanceDIYAvailableSlotIdx() then
		self:GoToEdit(arg_75_1, false, false)
	else
		ShowTips("IDOL_DANCE_EDIT_NO_DIY_DATA_SLOT")
	end
end

local var_0_8 = 2

local function var_0_9(arg_76_0)
	local var_76_0 = require("cjson").decode((AssetEx.LoadText(IdolStageMusicCfg[arg_76_0].music_json)))
	local var_76_1 = IdolStageMusicCfg[arg_76_0].music_duration
	local var_76_2 = 0
	local var_76_3 = {}

	for iter_76_0 = 1, var_0_8 do
		for iter_76_1, iter_76_2 in pairs(var_76_0["track" .. iter_76_0]) do
			local var_76_4 = math.max(unpack(iter_76_2))

			if var_76_2 < var_76_4 then
				var_76_2 = var_76_4
			end

			table.insert(var_76_3, {
				type = iter_76_0,
				segment = iter_76_2
			})
		end
	end

	CommonTools.UniversalSortEx(var_76_3, {
		ascend = true,
		map = function(self)
			return self.segment[1]
		end
	})

	var_76_1 = var_76_1 or var_76_2 / 1000

	return var_76_3, var_76_1
end

function DanceDIYMainView:PreviewSequence(arg_78_1, arg_78_2)
	if nullable(self.preview, "id") == arg_78_1.id then
		self.preview = nil

		DIYBridge:StopAllPreviewTasks()

		return
	else
		DIYBridge:StopAllPreviewTasks()
	end

	local var_78_0 = arg_78_2.music
	local var_78_1, var_78_2 = var_0_9(arg_78_2.music)
	local var_78_3 = {}

	for iter_78_0, iter_78_1 in ipairs(arg_78_2.actionList) do
		table.insert(var_78_3, {
			startTime = var_78_1[iter_78_0].segment[1] / 1000,
			endTime = var_78_1[iter_78_0].segment[2] / 1000,
			actionID = iter_78_1,
			action = nullable(IdolDanceDIYActionCfg, iter_78_1, "anime_action")
		})
	end

	DIYBridge.music = var_78_0
	self.preview = arg_78_1

	local function var_78_4()
		self.preview = nil

		manager.notify:Invoke("ON_PREVIEW_STATE_UPDATE")
	end

	DIYBridge:PreviewSequenceAction(var_78_3, 0, var_78_4, var_78_4)
	manager.notify:Invoke("ON_PREVIEW_STATE_UPDATE")
end

return DanceDIYMainView
