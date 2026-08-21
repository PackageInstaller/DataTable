_class("UIAircraftPreconditionController", UIController)
UIAircraftPreconditionController = UIAircraftPreconditionController

function UIAircraftPreconditionController:OnShow(uiParams)
  self:InitWidget()
  self.roomData = uiParams[1]
  self.conditions = uiParams[2]
  self.onClose = uiParams[3]
  self.airData = GameGlobal.GameLogic():GetModule(AircraftModule)
  self:CheckPrecondition()
end

function UIAircraftPreconditionController:InitWidget()
  self.conditionLayout = self:GetUIComponent("UISelectObjectPath", "ConditionLayout")
end

function UIAircraftPreconditionController:CheckPrecondition()
  local numFormat = "<color=#ff4242>%s</color>/%s"
  local conds = self.conditions
  local count = #conds
  if 0 < count then
    self.conditionLayout:SpawnObjects("UIAircraftPreconditionItem", count)
    local items = self.conditionLayout:GetAllSpawnList()
    for i = 1, count do
      local cond = conds[i]
      local type = cond.Type
      local level = cond.Level
      local need = cond.Need
      local had = cond.Had
      local name
      if type == 0 then
        name = StringTable.Get("str_aircraft_tip_any_room")
      else
        name = StringTable.Get(self.airData:GetRoomNameByType(type))
      end
      local level_need = StringTable.Get("str_aircraft_tip_level_count", level, need)
      items[i]:SetData(level_need, name, string.format(numFormat, had, need))
    end
  end
end

function UIAircraftPreconditionController:ButtonConditionConfirmOnClick(go)
  if self.onClose then
    self.onClose()
  end
  self:CloseDialog()
end

function UIAircraftPreconditionController:ButtonConditionCancelOnClick(go)
  if self.onClose then
    self.onClose()
  end
  self:CloseDialog()
end
