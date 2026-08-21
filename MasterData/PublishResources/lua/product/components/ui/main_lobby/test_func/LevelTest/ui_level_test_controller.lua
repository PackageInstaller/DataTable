_class("UILevelTestController", UIController)
UILevelTestController = UILevelTestController

function UILevelTestController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UILevelTestController:OnShow(uiParams)
  self.levelBack = uiParams[1]
  self:InitWidget()
  self:InitData()
end

function UILevelTestController:InitWidget()
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
end

function UILevelTestController:InitData(go)
  local group = Cfg.cfg_mission({})
  local groupList = {}
  local items = {}
  for k, v in pairs(group) do
    local id = v.LevelTestGroup
    if id and not groupList[id] then
      local data = {
        id,
        v.LevelTestGroupName
      }
      groupList[id] = data
      table.insert(items, data)
    end
  end
  local count = table.count(groupList)
  self.content:SpawnObjects("UILevelTestGroupItem", count)
  local itemList = self.content:GetAllSpawnList()
  for key, item in ipairs(itemList) do
    item:SetData(items[key])
  end
end

function UILevelTestController:ReturnBtnOnClick(go)
  if self.levelBack then
    self:SwitchState(UIStateType.UIMain)
  else
    self:CloseDialog()
  end
end
