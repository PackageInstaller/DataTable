local DailyTaskOverItemTipView, Super = NewClass("DailyTaskOverItemTipView", AlertConfirm2View)
DailyTaskOverItemTipView.uiResCls = UI_Main_Daily_OverItemTipResource

function DailyTaskOverItemTipView:ctor(params)
  self.params = params
  self.data = self:_CreateTipData()
  Super.ctor(self, self.data)
end

function DailyTaskOverItemTipView:OnEnterView()
  Super.OnEnterView(self)
  self:_ShowItems()
end

function DailyTaskOverItemTipView:_CreateTipData()
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

function DailyTaskOverItemTipView:_ShowItems()
  local itemData = {
    itemTid = self.params.tid
  }
  self:AddViewComponent(self.ui.UI_Common_Item_WuPin_Type2, CompPublicIconItemType2, itemData)
end

return DailyTaskOverItemTipView
