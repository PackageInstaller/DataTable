_class("UIActivityEveSinsaIntrController", UIController)
UIActivityEveSinsaIntrController = UIActivityEveSinsaIntrController

function UIActivityEveSinsaIntrController:OnShow(uiParams)
  self.Content = self:GetUIComponent("UISelectObjectPath", "Content")
  self:Flush()
end

function UIActivityEveSinsaIntrController:Flush()
  local n = 0
  while true do
    n = n + 1
    local keyHead = StringTable.Has("str_activity_evesinsa_intro_head_" .. n)
    if not keyHead then
      n = n - 1
      break
    end
  end
  if n <= 0 then
    Log.fatal("### no [str_activity_evesinsa_intro_head_n] in str_summer")
    return
  end
  self.Content:SpawnObjects("UIActivityEveSinsaIntrItem", n)
  local uis = self.Content:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local head = StringTable.Get("str_activity_evesinsa_intro_head_" .. i)
    local body = StringTable.Get("str_activity_evesinsa_intro_body_" .. i)
    ui:Flush(head, body)
  end
end

function UIActivityEveSinsaIntrController:btnCloseOnClick(go)
  self:CloseDialog()
end

function UIActivityEveSinsaIntrController:bgOnClick(go)
  self:CloseDialog()
end
