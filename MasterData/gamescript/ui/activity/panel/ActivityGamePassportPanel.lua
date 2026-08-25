local ActivityGamePassportPanel, Super = System.NewClass("ActivityGamePassportPanel", ActivityBasePanel)
ActivityGamePassportPanel.uiResCls = UI_Events_Panel_GamePassportAllResource
local UIAnimationController = CS.Z1Client.UIAnimationController

function ActivityGamePassportPanel:ctor(activityList, jumpToActivityTid)
  Super.ctor(self)
  self.activityList = activityList
  if not activityList then
    self.activityList = ActivityManager.Instance.model:GetGamePassports()
  end
  self.showIndex = Vue.ref(0)
  self.taskList = {}
  self.currActivityTid = Vue.ref(nil)
  self.jumpToActivityTid = jumpToActivityTid
  self.actCfg = nil
  self.activityData = nil
  self.subPanelComps = {}
  self:RegisterSubPanel()
end

function ActivityGamePassportPanel:RegisterSubPanel()
  self.subPanelCfg = {
    [ActivityDefine.ActivityType.PreOrder] = {
      cls = ActivityPreOrderPanel
    },
    [ActivityDefine.ActivityType.NewPreOrder] = {
      cls = ActivityPreOrderPanel
    },
    [ActivityDefine.ActivityType.TaskList] = {
      [ActivityDefine.ActivitySystemType.BattlePassActivity] = {
        cls = ActivityGamePassportComp
      }
    }
  }
end

function ActivityGamePassportPanel:OnBind(binder)
  self.binder = binder
  self.animController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  binder:BindComponent(BtnCloseItem(self.ui.Btn_Close, System.fn(self, self.Close)))
  self:CreateToggleTableView()
  self.toggleTableView:ReloadData()
  for i, v in ipairs(self.activityList) do
    if not self.jumpToActivityTid or v.activityTid == self.jumpToActivityTid then
      self:OnToggleIndex(i)
      self:PlayOpenAnim()
      break
    end
  end
end

function ActivityGamePassportPanel:OnToggleIndex(index)
  if self.showIndex.value == index then
    return
  end
  self:HideSubPanel(self.currActivityTid.value)
  self.showIndex.value = index
  local activityTid = self.activityList[index].activityTid
  local actCfg = ActivityDataUtils.GetConfig(activityTid)
  self.currActivityTid.value = activityTid
  self.actCfg = actCfg
  self.activityData = self.activityList[index]
  self.binder:SetImageSync(self.ui.Image_Map, self.actCfg.ActivityPicture)
  self.binder:SetText(self.ui.Text_Title, LT.Text("GamePassportTitle"))
  if ActivityRedUtils.IsActivityNew({activityTid}) then
    RedPointDataUtils.ReqRemoveData(RedTypeDefine.RedType.ActivityServer, RedPointDataUtils.RedAttrType.IsNew, activityTid)
  end
  self:CheckSubPanel()
end

function ActivityGamePassportPanel:PlayOpenAnim()
  self.animController:StopPlayableGraph()
  self.animController:PlayState("UI_Events_Panel_GamePassport_Open")
end

function ActivityGamePassportPanel:CheckSubPanel()
  self:ShowSubPanel()
end

function ActivityGamePassportPanel:ShowSubPanel()
  local comp = self.subPanelComps[self.currActivityTid.value]
  if not comp then
    local activityType = self.actCfg.ActivityType
    local actSysType = self.actCfg.ActivitySystemType
    local subPanelCfg = self.subPanelCfg[activityType] or {}
    local subPanelCls = subPanelCfg.cls
    if subPanelCfg[actSysType] then
      subPanelCls = subPanelCfg[actSysType].cls
    end
    if subPanelCls then
      comp = self.binder:BindNewComponent(self.ui.Group_SubPanel, subPanelCls, subPanelCls.uiResCls, self.currActivityTid.value, self.activityData)
      self.subPanelComps[self.currActivityTid.value] = comp
    end
  end
  if comp then
    self.binder:SetActive(comp.ui.uiNode, true)
    comp:Show()
    UIBasePanel.PlayUIExportAnimation(self, comp.ui.uiNode, true)
  end
end

function ActivityGamePassportPanel:HideSubPanel(activityTid)
  local comp = self.subPanelComps[activityTid]
  if comp then
    self.binder:SetActive(comp.ui.uiNode, false)
    comp:Hide()
  end
end

function ActivityGamePassportPanel:CreateToggleTableView()
  local baseGameObj = self.ui.UI_Events_Item_Tab
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.toggleTableView = self:CreateTableview(self.ui.ScrollView_Toggle, function()
    return #self.activityList
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local activityTid = self.activityList[idx].activityTid
    
    local function _OnTabClick()
      self:OnToggleIndex(idx)
    end
    
    local function _OnSelectTab()
      return self.showIndex.value == idx
    end
    
    local function _OnFinished()
      return false
    end
    
    itemComps[gameObj] = self.binder:BindComponent(ActivityTabListItem(gameObj, activityTid, _OnTabClick, _OnSelectTab, self.currActivityTid, _OnFinished, ActivityManager.Instance.model))
    return cell
  end, function(view, index)
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

return ActivityGamePassportPanel
