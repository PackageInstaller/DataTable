_class("UIEachTestController", UIController)
UIEachTestController = UIEachTestController

function UIEachTestController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIEachTestController:OnShow(uiParams)
  self._module = self:GetModule(MissionModule)
  self:InitWidget()
  self:InitData(uiParams[1])
end

function UIEachTestController:InitWidget()
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
  self.groupName = self:GetUIComponent("UILocalizationText", "GroupName")
end

function UIEachTestController:InitData(data)
  local group = Cfg.cfg_mission({})
  local LevelList = {}
  for _, v in pairs(group) do
    if v.LevelTestGroup == data[1] then
      table.insert(LevelList, v)
    end
  end
  local count = #LevelList
  local GroupName = data[2]
  table.sort(LevelList, function(a, b)
    return a[1] < b[1]
  end)
  self.groupName:SetText(GroupName)
  self.content:SpawnObjects("UIEachTestLevel", count)
  local itemList = self.content:GetAllSpawnList()
  for k, item in ipairs(itemList) do
    item:SetData(LevelList[k], function(LevelId)
      self:LevelOnClick(LevelId)
    end)
  end
end

function UIEachTestController:LevelOnClick(LevelId)
  GameGlobal.UAReportForceGuideEvent("UIStageClick", {
    "btnFightOnClick"
  }, true)
  local ctx = self._module:TeamCtx()
  ctx:Init(TeamOpenerType.Stage, LevelId)
  ctx:ShowDialogUITeams(false)
end

function UIEachTestController:ReturnBtnOnClick(go)
  self:CloseDialog()
end
