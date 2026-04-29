_class("UIN28AVGIntro", UIController)
UIN28AVGIntro = UIN28AVGIntro

function UIN28AVGIntro:OnShow(uiParams)
  self.Content = self:GetUIComponent("UISelectObjectPath", "Content")
  self:Flush()
end

function UIN28AVGIntro:OnHide()
end

function UIN28AVGIntro:Flush()
  local n = 0
  while true do
    n = n + 1
    local keyHead = StringTable.Has("str_avg_n28_activity_intro_head_" .. n)
    if not keyHead then
      n = n - 1
      break
    end
  end
  if n <= 0 then
    Log.fatal("### no [str_avg_n28_activity_intro_head_n] in str_avg")
    return
  end
  self.Content:SpawnObjects("UIN28AVGIntroItem", n)
  local uis = self.Content:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local head = StringTable.Get("str_avg_n28_activity_intro_head_" .. i)
    local body = StringTable.Get("str_avg_n28_activity_intro_body_" .. i)
    ui:Flush(head, body)
  end
end

function UIN28AVGIntro:BtnCloseOnClick(go)
  self:CloseDialog()
end
