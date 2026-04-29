_class("UIN20AVGIntro", UIController)
UIN20AVGIntro = UIN20AVGIntro

function UIN20AVGIntro:OnShow(uiParams)
  self.Content = self:GetUIComponent("UISelectObjectPath", "Content")
  self:Flush()
end

function UIN20AVGIntro:OnHide()
end

function UIN20AVGIntro:Flush()
  local n = 0
  while true do
    n = n + 1
    local keyHead = StringTable.Has("str_avg_n20_activity_intro_head_" .. n)
    if not keyHead then
      n = n - 1
      break
    end
  end
  if n <= 0 then
    Log.fatal("### no [str_avg_n20_activity_intro_head_n] in str_avg")
    return
  end
  self.Content:SpawnObjects("UIN20AVGIntroItem", n)
  local uis = self.Content:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local head = StringTable.Get("str_avg_n20_activity_intro_head_" .. i)
    local body = StringTable.Get("str_avg_n20_activity_intro_body_" .. i)
    ui:Flush(head, body)
  end
end

function UIN20AVGIntro:btnCloseOnClick(go)
  self:CloseDialog()
end
