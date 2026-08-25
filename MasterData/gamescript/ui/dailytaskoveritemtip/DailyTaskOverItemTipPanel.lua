local DailyTaskOverItemTipPanel, Super = System.NewClass("DailyTaskOverItemTipPanel", AlertConfirm2Panel)

function DailyTaskOverItemTipPanel:ctor(params)
  DailyTaskOverItemTipPanel.uiResCls = UI_Main_Daily_OverItemTipResource
  self.params = params
  self.data = self:_CreateTipData()
  Super.ctor(self, self.data)
end

function DailyTaskOverItemTipPanel:OnBind(binder)
  Super.OnBind(self, binder)
  self:_ShowItems(binder)
end

function DailyTaskOverItemTipPanel:_CreateTipData()
  local tipTid = self.params.tipTid
  local tipConfig = DT.TipsType[tipTid]
  return {
    tipTid = tipTid,
    title = LT.Text(tipConfig.Title) or nil,
    desc = LT.Textf(DT.TipsType[tipTid].Desc, ItemDataUtils.GetStageGroupUnlockItemName()),
    bottomDesc = tipConfig.BottomDesc and LT.Text(tipConfig.BottomDesc),
    btnLeftDesc = LT.Text(tipConfig.LeftBtnDesc),
    btnRightDesc = LT.Text(tipConfig.RightBtnDesc),
    icon = tipConfig.Icon,
    dontRemind = tipConfig.DonotRemind,
    funcs = {
      leftBtnFunc = nil,
      rightBtnFunc = function()
        if self.params.onConfirmFunc then
          self.params.onConfirmFunc()
        else
          TaskDataUtils.TaskComplete(self.params.taskUid, nil, nil, true)
        end
      end
    }
  }
end

function DailyTaskOverItemTipPanel:_ShowItems(binder)
  local itemData = {
    itemTid = self.params.tid
  }
  binder:BindComponent(CommonIconItemType2(self.ui.UI_Common_Item_WuPin_Type2, itemData))
end

return DailyTaskOverItemTipPanel
