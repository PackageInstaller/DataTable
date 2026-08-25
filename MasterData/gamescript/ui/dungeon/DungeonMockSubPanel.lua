local MAX_STAR_NUM = 3
local DungeonMockSubPanel, Super = System.NewClass("DungeonMockSubPanel", UIBasePanel)
DungeonMockSubPanel.uiResCls = UI_Dungeous_Panel_RealmsResource

function DungeonMockSubPanel:ctor(model)
  Super.ctor(self)
  self.model = model
end

function DungeonMockSubPanel:OnBind(binder)
  self.binder = binder
  local model = self.model
  self:InitUIState()
  binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back2, function()
    self:Close()
  end))
  binder:BindComponent(StageStarComponent(self.ui.Group_Star, CopyDataUtils.GetStageData(model.curStageGroupId, model.curStageId)))
  binder:BindButtonClick(self.ui.Btn_Relics, function()
    UIManager.Instance:Reopen(Urls.MainCopyRelicGroupPanel, model.curStageId)
  end)
  binder:BindToText(self.ui.Text_Title, function()
    return model.curStageGroupCfg.Name
  end)
  binder:BindZ1Button(self.ui.Btn_Challenge, function()
    local cost = model.curStageCfg.Cost
    if cost > PlayerDataUtils.GetEnergy() then
      PlayerDataUtils.ShowEnergyRestorePanel()
      return
    end
    WorldStageManager.Instance:CheckOpen(model.curStageId, function()
      StageExitPanelManager.Instance:PushWhenMockCopyExit(model.curStageId)
    end, {})
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "DailyCopy_Start"
  end, nil, nil, nil)
  binder:BindToCircularListView(self.ui.ScrollView_Difficulty, function()
    return self.model.curStageList
  end, function(childBinder, item, index)
    local stageId = self.model.curStageList[index]
    local stageCfg = DT.Stage[stageId]
    local itemUI = UI_Dungeons_Item_Common_TierResource(item)
    childBinder:BindToText(itemUI.Text_Title, function()
      do return LT.Text end
      return LT.Text, stageCfg.Name
    end)
    childBinder:BindButtonClick(itemUI.Btn_Click, function()
      model:SetCurStageId(stageId)
    end)
    childBinder:BindToVisible(itemUI.Image_Select, function()
      return stageId == model.curStageId
    end)
    for i = 1, MAX_STAR_NUM do
      childBinder:BindToVisible(itemUI["Image_Star" .. i], function()
        local stageData = CopyDataUtils.GetStageData(model.curStageGroupId, stageId)
        return i <= stageData.star
      end)
    end
    childBinder:SetActive(itemUI.Image_Mask, false)
    childBinder:SetActive(itemUI.Text_Tip, false)
  end)
  binder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView_Difficulty)
  binder:BindToRaw(function(childBinder, nVal, _)
    childBinder:BindToText(self.ui.Text_Name, function()
      return model.curStageCfg.Name
    end)
    childBinder:BindToText(self.ui.Text_Introduce, function()
      return model.curStageCfg.Desc
    end)
    local initRelics = CopyDataUtils.GetStageInitRelic(self.model.curStageId)
    local haveRelics = table.next(initRelics)
    if haveRelics then
      childBinder:BindToCircularListView(self.ui.ScrollView_Initial, function()
        return initRelics
      end, function(itemBinder, item, index)
        local data = initRelics
        itemBinder:BindComponent(RelicIconComponent(item, data[index]))
      end)
    end
    childBinder:SetActive(self.ui.Text_C_Special, haveRelics)
  end, function()
    return model.curStageId
  end)
end

function DungeonMockSubPanel:InitUIState()
  local binder = self.binder
  binder:SetActive(self.ui.Group_Icon, false)
  binder:SetActive(self.ui.Text_C_Award, false)
  binder:SetActive(self.ui.RootRecommendSchool, false)
  binder:SetActive(self.ui.Text_C_Reward, false)
  binder:SetActive(self.ui.Group_Progress, false)
  binder:SetActive(self.ui.Image_Contingent, false)
end

return DungeonMockSubPanel
