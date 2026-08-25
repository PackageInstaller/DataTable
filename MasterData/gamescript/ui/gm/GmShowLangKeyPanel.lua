local typeof = _ENV.typeof
local Text = typeof(CS.UnityEngine.UI.Text)
local Dropdown = typeof(CS.UnityEngine.UI.Dropdown)
local InputField = typeof(CS.UnityEngine.UI.InputField)
local GmParamEquipPanel, Super = System.NewClass("GmParamEquipPanel", UIBasePanel)
GmParamEquipPanel.uiResCls = GmParamEquipPanelResource

function GmParamEquipPanel:ctor(gmConfig)
  Super.ctor(self)
end

function GmParamEquipPanel:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back3, System.fn(self, self.Close))
  self:CreateTableView()
end

function GmParamEquipPanel:CreateTaskTableView()
  local baseGameObj = self.ui.UI_Events_Item_GamePassport
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.taskTableView = self:CreateTableview(self.ui.ScrollView, function()
    return #self.taskList
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local taskInfo = self.taskList[idx]
    local isBoughtPlus = self:IsBuyPassport()
    itemComps[gameObj] = self.binder:BindComponent(ActivityGamePassportItem(gameObj, self.currActivityTid.value, taskInfo, isBoughtPlus))
    return cell
  end, function(view, index)
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

return GmParamEquipPanel
