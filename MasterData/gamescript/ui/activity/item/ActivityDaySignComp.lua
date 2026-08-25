local T_UITableview = typeof(CS.UITableview)
local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local ActivityDaySignComp, Super = System.NewClass("ActivityDaySignComp", ActivityBaseComp)
local Vector2 = CS.UnityEngine.Vector2

function ActivityDaySignComp:ctor(uiNode, activityTid, model)
  Super.ctor(self)
  self.ui = UI_Events_SignDiamondResource(uiNode)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
  self.itemDatas = self.activityConfig.ActivityPara1
  self.itemIconComps = {}
end

function ActivityDaySignComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(T_UIAnimationController)
  self:_BindActivityTimer()
  self.iconItemModel = binder:createModel(CommonIconItemModel)
  local activityName = ActivityDataUtils.GetActivityName(self.activityTid)
  local activityPlotInfo = ActivityDataUtils.GetActivityPlot(self.activityTid)
  binder:SetText(self.ui.Text_Title, activityName)
  local bgCfg = ActivityDataUtils.GetBgImage(self.activityTid)
  if "CG/C09/Static/CG_C09_009.png" == bgCfg then
    self.ui.Image_Map.transform.anchoredPosition = Vector2(-224, 0)
  else
    self.ui.Image_Map.transform.anchoredPosition = Vector2(0, 0)
  end
  binder:SetImageSync(self.ui.Image_Map, ActivityDataUtils.GetBgImage(self.activityTid))
  binder:SetText(self.ui.Text_Desc, activityPlotInfo)
  StrUtils.SetPreferredHeight(self.ui.Text_Desc, 60)
  self:_CreateSignListView()
  self.signListView:ReloadData()
end

function ActivityDaySignComp:_CreateSignListView()
  local tableview = self.ui.ScrollView_Sign:GetComponent(T_UITableview)
  local itemCount = math.floor(#self.itemDatas / 2)
  
  function tableview.numberCellsInTableview()
    return itemCount
  end
  
  function tableview.tableCellAtIndex(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Events_Item_SignDiamond)
    self:_RefreshSignData(cell, index + 1)
    return cell
  end
  
  self.signListView = tableview
  
  function self.signListView.reloadFinishCallback()
    tableview:MoveCellToCenter(self:_JumpToIndex())
  end
end

function ActivityDaySignComp:_RefreshSignData(cell, index)
  local oldComp = self.itemIconComps[cell.gameObject]
  if oldComp and oldComp.binder then
    oldComp.binder:teardown()
  end
  local itemCount = math.floor(#self.itemDatas / 2)
  local isLast = index == itemCount
  
  local function _RefrshFunc()
    if self.signListView then
      self.signListView:ReloadData()
    end
  end
  
  local comp = self.binder:BindComponent(UISignDiamondItem(cell.gameObject, index, isLast, self.activityConfig, self.activityData, _RefrshFunc))
  self.itemIconComps[cell.gameObject] = comp
end

function ActivityDaySignComp:_JumpToIndex()
  local index
  if self.activityData and self.activityData.prize then
    for id, state in ipairs(self.activityData.prize) do
      if state == CommonDefine.CommonState.GainPrize then
        index = id - 1
      end
    end
    if not index then
      index = math.min(#self.activityData.prize, #self.itemDatas / 2 - 1)
    end
  else
    index = 0
  end
  return index
end

function ActivityDaySignComp:OnUnbind()
end

function ActivityDaySignComp:OnOpenAnim()
  self.uiAnimController:PlayState("UI_Events_Activity_SignDiamond_Open")
end

function ActivityDaySignComp:OnCloseAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Activity_Diamond_Close", callback)
end

return ActivityDaySignComp
