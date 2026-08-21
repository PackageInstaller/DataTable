local var_0_0 = class("DanceDIYMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolDance/IdolDanceMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

local var_0_1 = class("DanceDIYMainView.SubView", BaseView)

function var_0_1.Ctor(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.gameObject_ = arg_3_1
	arg_3_0.transform_ = arg_3_1.transform
	arg_3_0.parentView = arg_3_2

	arg_3_0:BindCfgUI()

	arg_3_0.showListController = arg_3_0.controllers_:GetController("change")

	arg_3_0:InitUI()
end

function var_0_1.InitUI(arg_4_0)
	return
end

function var_0_1.SetVisible(arg_5_0, arg_5_1)
	arg_5_0.showListController:SetSelectedState(arg_5_1 and "on" or "off")
end

function var_0_1.Visible(arg_6_0)
	return arg_6_0.showListController:GetSelectedState() ~= "off"
end

function var_0_1.CanHide(arg_7_0)
	return true
end

local var_0_2 = class("DanceDIYMainView.SelectDIYDataSubView", var_0_1)
local var_0_3 = class("DanceDIYMainView.SelectDIYDataSubView.DataItem", DanceDIYDataItem)

function var_0_3.InitUI(arg_8_0)
	var_0_3.super.InitUI(arg_8_0)

	arg_8_0.playStateController = arg_8_0.controllers_:GetController("btnPlay")
end

function var_0_3.SetOnEditFunc(arg_9_0, arg_9_1)
	arg_9_0.onClickEditBtn = arg_9_1
end

function var_0_3.SetOnDelFunc(arg_10_0, arg_10_1)
	arg_10_0.onClickDelBtn = arg_10_1
end

function var_0_3.AddUIListeners(arg_11_0)
	var_0_3.super.AddUIListeners(arg_11_0)
	arg_11_0:AddBtnListener(arg_11_0.editBtn_, nil, function()
		arg_11_0:OnEditBtnClick()
	end)
	arg_11_0:AddBtnListener(arg_11_0.delBtn_, nil, function()
		arg_11_0:OnDelBtnClick()
	end)
end

function var_0_3.OnDelBtnClick(arg_14_0)
	if arg_14_0.onClickDelBtn then
		arg_14_0.onClickDelBtn(arg_14_0.loadData)
	end
end

function var_0_3.OnEditBtnClick(arg_15_0)
	if arg_15_0.onClickEditBtn then
		arg_15_0.onClickEditBtn(arg_15_0.loadData)
	end
end

function var_0_2.InitUI(arg_16_0)
	arg_16_0.select = nil
	arg_16_0.diyDataUIList = LuaList.New(handler(arg_16_0, arg_16_0.IndexItem), arg_16_0.uiList_.gameObject, var_0_3)
	arg_16_0.categoryController = arg_16_0.controllers_:GetController("category")

	function arg_16_0.clickItemFunc(arg_17_0)
		arg_16_0.select = arg_17_0

		arg_16_0:Refresh()

		if arg_16_0.OnClickItem then
			arg_16_0.OnClickItem(arg_17_0)
		end
	end

	arg_16_0:AddBtnListener(arg_16_0.myDataTabBtn_, nil, function()
		arg_16_0:SwitchList("myData")
	end)
	arg_16_0:AddBtnListener(arg_16_0.sharedDataTabBtn_, nil, function()
		arg_16_0:SwitchList("sharedData")
	end)
end

function var_0_2.OnEnter(arg_20_0)
	arg_20_0:SwitchList("myData")
end

function var_0_2.Dispose(arg_21_0)
	arg_21_0.dataIdxList = nil

	arg_21_0.diyDataUIList:Dispose()
	var_0_2.super.Dispose(arg_21_0)
end

function var_0_2.SwitchList(arg_22_0, arg_22_1)
	arg_22_0.categoryController:SetSelectedState(arg_22_1)

	arg_22_0.select = nil

	DIYBridge:StopAllPreviewTasks()
	arg_22_0:ResetDataList()
end

function var_0_2.IndexItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.dataIdxList[arg_23_1]
	local var_23_1 = arg_23_0.categoryController:GetSelectedState() == "sharedData"
	local var_23_2 = {
		id = var_23_0
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
	arg_23_2:SetSelected(nullable(arg_23_0.select, "id") == arg_23_0.dataIdxList[arg_23_1])
	arg_23_2:SetOnClick(arg_23_0.clickItemFunc)
	arg_23_2:SetOnEditFunc(arg_23_0.OnEditItem)
	arg_23_2:SetOnDelFunc(arg_23_0.OnDelItem)

	local var_23_4 = nullable(arg_23_0.parentView, "preview", "id")

	arg_23_2.playStateController:SetSelectedState(var_23_4 == var_23_0 and "play" or "pause")
end

function var_0_2.ResetDataList(arg_24_0)
	arg_24_0.dataIdxList = {}

	if arg_24_0.categoryController:GetSelectedState() == "myData" then
		for iter_24_0 = 1, IdolTraineeData.DanceDIYSlotLimit() do
			table.insert(arg_24_0.dataIdxList, iter_24_0)
		end
	elseif IdolTraineeData.mySharedDIY then
		for iter_24_1, iter_24_2 in pairs(IdolTraineeData.mySharedDIY) do
			table.insert(arg_24_0.dataIdxList, iter_24_1)
		end
	end

	arg_24_0.diyDataUIList:StartScrollByPosition(#arg_24_0.dataIdxList, arg_24_0.diyDataUIList:GetScrolledPosition())
end

function var_0_2.Refresh(arg_25_0)
	arg_25_0.diyDataUIList:Refresh()
end

function var_0_2.SetVisible(arg_26_0)
	return
end

function var_0_2.Visible(arg_27_0)
	return true
end

function var_0_2.CanHide(arg_28_0)
	return false
end

function var_0_2.GetSelectingDataLoadInfo(arg_29_0)
	return arg_29_0.select
end

local var_0_4 = class("DanceDIYMainView.SelectSceneSubView", var_0_1)
local var_0_5 = import("game.views.dormIdolTrainee.dance.DanceDIYSceneItem")

function var_0_4.InitUI(arg_30_0)
	arg_30_0.sceneUIList = LuaList.New(handler(arg_30_0, arg_30_0.IndexItem), arg_30_0.uiList_.gameObject, var_0_5)
	arg_30_0.expandItem = {}

	arg_30_0:BindCfgUI(arg_30_0.changeCharaGo_, arg_30_0.expandItem)
	arg_30_0:AddBtnListenerScale(arg_30_0.expandItem.btn_, nil, function()
		arg_30_0:SetVisible(true)
	end)

	function arg_30_0.clickItemFunc(arg_32_0)
		DIYBridge:SetScene(arg_32_0)
	end
end

function var_0_4.Dispose(arg_33_0)
	arg_33_0.sceneUIList:Dispose()
	var_0_4.super.Dispose(arg_33_0)
end

function var_0_4.OnEnter(arg_34_0, arg_34_1)
	arg_34_0.sceneUIList:StartScroll(#IdolStageSceneCfg.all)
	arg_34_0:Refresh()
end

function var_0_4.IndexItem(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = IdolStageSceneCfg.all[arg_35_1]

	arg_35_2:SetData(var_35_0)
	arg_35_2:SetSelected(DIYBridge.scene == arg_35_2.scene)
	arg_35_2:SetOnClick(arg_35_0.clickItemFunc)
end

function var_0_4.Refresh(arg_36_0)
	local var_36_0 = IdolStageSceneCfg[DIYBridge.scene]

	arg_36_0.expandItem.icon_.sprite = getSpriteViaConfig("IdolStageIcon", var_36_0.stage_picture)

	arg_36_0.sceneUIList:Refresh()
end

local var_0_6 = class("DanceDIYMainView.SelectCharaSubView", var_0_1)

function var_0_6.InitUI(arg_37_0)
	arg_37_0.heroList = {}
	arg_37_0.curHeroID = nil
	arg_37_0.curHeroIndex = nil
	arg_37_0.heroUIList = LuaList.New(handler(arg_37_0, arg_37_0.IndexItem), arg_37_0.uiList_.gameObject, IdolTraineeHeadItem)
	arg_37_0.showListController = arg_37_0.controllers_:GetController("change")
	arg_37_0.charaItem = {}

	arg_37_0:BindCfgUI(arg_37_0.changeCharaGo_, arg_37_0.charaItem)
	arg_37_0:AddBtnListenerScale(arg_37_0.charaItem.btn_, nil, function()
		arg_37_0:SetVisible(true)
	end)
end

function var_0_6.Dispose(arg_39_0)
	arg_39_0.heroUIList:Dispose()
	var_0_6.super.Dispose(arg_39_0)
end

function var_0_6.OnEnter(arg_40_0, arg_40_1)
	arg_40_0.heroList = IdolTraineeData:GetIdolHeroList(true)

	CommonTools.UniversalSortEx(arg_40_0.heroList, {
		map = function(arg_41_0)
			return HeroTools.GetHeroIsUnlock(arg_41_0) and 1 or 0
		end
	})

	arg_40_0.curHeroID = arg_40_1 or arg_40_0.curHeroID or arg_40_0.heroList[1]
	arg_40_0.curHeroIndex = table.keyof(arg_40_0.heroList, arg_40_0.curHeroID)

	arg_40_0.heroUIList:StartScroll(#arg_40_0.heroList)
	arg_40_0.heroUIList:ScrollToIndex(arg_40_0.curHeroIndex)

	arg_40_0.charaItem.icon_.sprite = DormHeroTools.GetBackHomeHeadSprite(arg_40_0.curHeroID)
end

local var_0_7 = {
	ignoreDefender = true,
	ignoreAttacker = true
}

function var_0_6.IndexItem(arg_42_0, arg_42_1, arg_42_2)
	arg_42_2:SetData(arg_42_0.heroList[arg_42_1], arg_42_0.curHeroID, function(arg_43_0)
		if HeroTools.GetHeroIsUnlock(arg_43_0.heroID_) then
			arg_42_0:UpdateSelectCharacter(arg_43_0.heroID_)
			arg_42_0:Refresh()
		end
	end, var_0_7)
end

function var_0_6.Refresh(arg_44_0)
	arg_44_0.charaItem.icon_.sprite = DormHeroTools.GetBackHomeHeadSprite(arg_44_0.curHeroID)

	arg_44_0.heroUIList:Refresh()
end

function var_0_6.UpdateSelectCharacter(arg_45_0, arg_45_1)
	arg_45_0.curHeroID = arg_45_1

	DIYBridge:SetCharacter(arg_45_1)
end

function var_0_0.Init(arg_46_0)
	arg_46_0:BindCfgUI()
	arg_46_0:InitUI()
	arg_46_0:AddUIListener()
end

function var_0_0.InitUI(arg_47_0)
	arg_47_0.subViews = {}
	arg_47_0.selCharaSubView = var_0_6.New(arg_47_0.selChara_, arg_47_0)
	arg_47_0.selSceneSubView = var_0_4.New(arg_47_0.selScene_, arg_47_0)
	arg_47_0.selDataSubView = var_0_2.New(arg_47_0.selData_, arg_47_0)

	function arg_47_0.selDataSubView.OnEditItem(arg_48_0)
		arg_47_0:OnClickDataItem(arg_48_0)
	end

	function arg_47_0.selDataSubView.OnClickItem(arg_49_0)
		local var_49_0 = IdolTraineeTools.GetDIYDataFromLoadInfo(arg_49_0)

		if var_49_0 then
			if arg_47_0:UseSceneFromData() and nullable(IdolStageSceneCfg, var_49_0.scene) then
				DIYBridge:SetScene(var_49_0.scene)
			end

			arg_47_0:PreviewSequence(arg_49_0, var_49_0)
		else
			arg_47_0:OnClickDataItem(arg_49_0)
		end
	end

	function arg_47_0.selDataSubView.OnDelItem(arg_50_0)
		local var_50_0 = arg_50_0

		if var_50_0.id then
			local var_50_1 = var_50_0.id
			local var_50_2
			local var_50_3

			if var_50_0.source == IdolTraineeConst.DataSource.MyData then
				var_50_2 = "IDOL_DANCE_CONFIRM_DEL"
				var_50_3 = IdolTraineeAction.DeleteDanceDIYSequence
			else
				var_50_2 = "IDOL_DANCE_CONFIRM_STOP_SHARE"
				var_50_3 = IdolTraineeAction.StopShareDanceDIYSeqence
			end

			ShowMessageBox({
				content = GetTips(var_50_2),
				OkCallback = function()
					var_50_3(var_50_1)

					if nullable(arg_47_0.preview, "id") == var_50_1 then
						arg_47_0.preview = nil

						DIYBridge:StopAllPreviewTasks()
					end
				end
			})
		end
	end

	table.insert(arg_47_0.subViews, arg_47_0.selCharaSubView)
	table.insert(arg_47_0.subViews, arg_47_0.selSceneSubView)
	table.insert(arg_47_0.subViews, arg_47_0.selDataSubView)
end

function var_0_0.OnEnter(arg_52_0)
	manager.ui:SetMainCamera("dance")

	arg_52_0.preview = nil

	arg_52_0:RegisterEvents()

	arg_52_0.music = arg_52_0.params_.music or DIYBridge.music
	arg_52_0.musicName_.text = IdolStageMusicCfg[arg_52_0.music].music_name

	arg_52_0.selCharaSubView:OnEnter(arg_52_0.params_.heroID)

	arg_52_0.params_.heroID = nil

	arg_52_0.selSceneSubView:OnEnter(DIYBridge.scene)
	arg_52_0.selDataSubView:OnEnter()
end

function var_0_0.OnExit(arg_53_0)
	arg_53_0:RemoveAllEventListener()

	arg_53_0.preview = nil

	for iter_53_0, iter_53_1 in ipairs(arg_53_0.subViews) do
		iter_53_1:SetVisible(false)
	end
end

function var_0_0.OnTop(arg_54_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if not arg_54_0:HideSubView() then
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

function var_0_0.OnBehind(arg_56_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_57_0)
	for iter_57_0, iter_57_1 in ipairs(arg_57_0.subViews) do
		iter_57_1:Dispose()
	end

	var_0_0.super.Dispose(arg_57_0)
end

function var_0_0.OnDanceDIYUpdate(arg_58_0)
	arg_58_0.selDataSubView:ResetDataList()
end

function var_0_0.OnSharedDanceDIYUpdate(arg_59_0)
	arg_59_0.selDataSubView:ResetDataList()
end

function var_0_0.UseSceneFromData(arg_60_0)
	return true
end

function var_0_0.AddUIListener(arg_61_0)
	arg_61_0:AddBtnListenerScale(arg_61_0.createDataBtn_, nil, function()
		local var_62_0 = IdolTraineeData:GetDanceDIYAvailableSlotIdx()

		if var_62_0 then
			arg_61_0:GoToEdit({
				source = IdolTraineeConst.DataSource.MyData,
				id = var_62_0
			})
		else
			ShowTips("IDOL_DANCE_EDIT_NO_DIY_DATA_SLOT")
		end
	end)
	arg_61_0:AddBtnListenerScale(arg_61_0.editDataBtn_, nil, function()
		local var_63_0 = arg_61_0:GetCurSelectDIYData()

		arg_61_0:GoToEdit(var_63_0, arg_61_0:UseSceneFromData())
	end)
	arg_61_0:AddBtnListenerScale(arg_61_0.delDataBtn_, nil, function()
		local var_64_0 = arg_61_0:GetCurSelectDIYData()

		if var_64_0.id then
			if var_64_0.source == IdolTraineeConst.DataSource.MyData then
				IdolTraineeAction.DeleteDanceDIYSequence(var_64_0.id)
			else
				IdolTraineeAction.StopShareDanceDIYSeqence(var_64_0.id)
			end
		end
	end)
	arg_61_0:AddBtnListener(arg_61_0.selMusic_, nil, function()
		JumpTools.OpenPageByJump("idolDanceSelMusic", {
			music = arg_61_0.music,
			onSelectMusic = function(arg_66_0)
				arg_61_0.music = arg_66_0
				arg_61_0.musicName_.text = IdolStageMusicCfg[arg_61_0.music].music_name
			end
		})
	end)
	arg_61_0:AddBtnListener(arg_61_0.emptyAreaBtn_, nil, function()
		arg_61_0:HideSubView()
	end)
end

function var_0_0.RegisterEvents(arg_68_0)
	arg_68_0:RegistEventListener("ON_PREVIEW_STATE_UPDATE", function()
		arg_68_0.selDataSubView:Refresh()
	end)
	arg_68_0:RegistEventListener("IDOL_DANCE_CHANGE_MUSIC", function(arg_70_0)
		arg_68_0.music = arg_70_0
		arg_68_0.musicName_.text = IdolStageMusicCfg[arg_68_0.music].music_name
	end)
	arg_68_0:RegistEventListener("IDOL_DANCE_DIY_CHANGE_SCENE", function(arg_71_0)
		arg_68_0.selSceneSubView:Refresh()
	end)
end

function var_0_0.GetCurSelectDIYData(arg_72_0)
	return arg_72_0.selDataSubView:GetSelectingDataLoadInfo()
end

function var_0_0.HideSubView(arg_73_0)
	local var_73_0 = false

	for iter_73_0, iter_73_1 in ipairs(arg_73_0.subViews) do
		if iter_73_1:CanHide() then
			if not var_73_0 and iter_73_1:Visible() then
				var_73_0 = true
			end

			iter_73_1:SetVisible(false)
		end
	end

	return var_73_0
end

function var_0_0.GoToEdit(arg_74_0, arg_74_1, arg_74_2, arg_74_3)
	DIYBridge:StopAllPreviewTasks()
	JumpTools.OpenPageByJump("/idolDanceEdit", {
		load = arg_74_1,
		loadSceneFromSaveData = arg_74_2,
		readOnly = arg_74_3
	})
end

function var_0_0.OnClickDataItem(arg_75_0, arg_75_1)
	if IdolTraineeTools.GetDIYDataFromLoadInfo(arg_75_1) then
		arg_75_0:GoToEdit(arg_75_1, true, true)
	elseif IdolTraineeData:GetDanceDIYAvailableSlotIdx() then
		arg_75_0:GoToEdit(arg_75_1, false, false)
	else
		ShowTips("IDOL_DANCE_EDIT_NO_DIY_DATA_SLOT")
	end
end

local var_0_8 = 2

local function var_0_9(arg_76_0)
	local var_76_0 = IdolStageMusicCfg[arg_76_0]
	local var_76_1 = var_76_0.music_json
	local var_76_2 = AssetEx.LoadText(var_76_1)
	local var_76_3 = require("cjson").decode(var_76_2)
	local var_76_4 = var_76_0.music_duration
	local var_76_5 = 0
	local var_76_6 = {}

	for iter_76_0 = 1, var_0_8 do
		local var_76_7 = var_76_3["track" .. iter_76_0]

		for iter_76_1, iter_76_2 in pairs(var_76_7) do
			local var_76_8 = math.max(unpack(iter_76_2))

			if var_76_5 < var_76_8 then
				var_76_5 = var_76_8
			end

			table.insert(var_76_6, {
				type = iter_76_0,
				segment = iter_76_2
			})
		end
	end

	CommonTools.UniversalSortEx(var_76_6, {
		ascend = true,
		map = function(arg_77_0)
			return arg_77_0.segment[1]
		end
	})

	var_76_4 = var_76_4 or var_76_5 / 1000

	return var_76_6, var_76_4
end

function var_0_0.PreviewSequence(arg_78_0, arg_78_1, arg_78_2)
	if nullable(arg_78_0.preview, "id") == arg_78_1.id then
		arg_78_0.preview = nil

		DIYBridge:StopAllPreviewTasks()

		return
	else
		DIYBridge:StopAllPreviewTasks()
	end

	local var_78_0 = arg_78_2.music
	local var_78_1, var_78_2 = var_0_9(var_78_0)
	local var_78_3 = {}

	for iter_78_0, iter_78_1 in ipairs(arg_78_2.actionList) do
		local var_78_4 = var_78_1[iter_78_0].segment

		table.insert(var_78_3, {
			startTime = var_78_4[1] / 1000,
			endTime = var_78_4[2] / 1000,
			actionID = iter_78_1,
			action = nullable(IdolDanceDIYActionCfg, iter_78_1, "anime_action")
		})
	end

	DIYBridge.music = var_78_0
	arg_78_0.preview = arg_78_1

	local function var_78_5()
		arg_78_0.preview = nil

		manager.notify:Invoke("ON_PREVIEW_STATE_UPDATE")
	end

	DIYBridge:PreviewSequenceAction(var_78_3, 0, var_78_5, var_78_5)
	manager.notify:Invoke("ON_PREVIEW_STATE_UPDATE")
end

return var_0_0
