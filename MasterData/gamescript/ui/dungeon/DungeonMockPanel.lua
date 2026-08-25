local DungeonMockPanel, Super = NewClass("DungeonMockPanel", BaseView)
DungeonMockPanel.uiResCls = UI_Dungeons_Panel_MaterialResource

function DungeonMockPanel:ctor()
  Super.ctor(self)
end

function DungeonMockPanel:OnEnterView()
  local binder = self.binder
  CopyDataUtils.ReqFeatureCopyDataIfNeeded(CommonDefine.FeatureId.MockBattle, function()
    self:_BindView(binder)
  end)
end

function DungeonMockPanel:_BindView(binder)
  self:Init(binder)
  local model = self.model
  binder:BindToVisible(self.ui.Text_Award, function()
    return false
  end)
  binder:BindToVisible(self.ui.ScrollView_Award, function()
    return false
  end)
  binder:BindToVisible(self.ui.UI_Awaker_Button_Addition, function()
    return false
  end)
  binder:BindToText(self.ui.Text_Name, function()
    return model.curStageGroupCfg.Name
  end)
  binder:BindToText(self.ui.Text_Desc, function()
    return model.curStageGroupCfg.Desc
  end)
  binder:BindToImage(self.ui.Image_Main_Bg, function()
    return model.curStageGroupCfg.Backgrand
  end)
  binder:BindToCircularListView(self.ui.ScrollView_List, function()
    return model.stageGroupList
  end, function(itemBinder, item, index)
    local stageGroupId = model.stageGroupList[index]
    local itemData = {
      stageGroupId = stageGroupId,
      clickFunc = function()
        model:SetCurStageGroupId(stageGroupId)
      end,
      isSelectFunc = function()
        return model.curStageGroupId == stageGroupId
      end
    }
    itemBinder:BindComponent(DungeonMockCopyItem(item, itemData))
  end)
  binder:BindZ1Button(self.ui.Btn_Enter, function()
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(model.featureId, model.curStageGroupId)
    if not unlocked then
      PlayerDataUtils.AlertLockedTips(model.featureId, model.curStageGroupId)
      return
    end
    RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.MockCopy, RedPointDataUtils.RedAttrType.IsNew, model.curStageGroupId)
    self:OpenMockDetailPanel()
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "DailyCopy_Start"
  end, nil, nil, nil)
end

function DungeonMockPanel:Init(binder)
  self.binder = binder
  self.model = binder:createModel(DungeonMockCopyModel)
end

function DungeonMockPanel:OpenMockDetailPanel()
  UIManager.Instance:Reopen(Urls.DungeonMockSubPanel, self.model)
end

return DungeonMockPanel
