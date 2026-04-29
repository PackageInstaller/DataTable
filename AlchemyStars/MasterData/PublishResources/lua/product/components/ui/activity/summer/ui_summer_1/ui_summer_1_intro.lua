_class("UISummer1Intro", UIController)
UISummer1Intro = UISummer1Intro

function UISummer1Intro:OnShow(uiParams)
  self.anim = self:GetGameObject():GetComponent("Animation")
  self.Content = self:GetUIComponent("UISelectObjectPath", "Content")
  self:Flush()
  self:PlayAnim(true)
end

function UISummer1Intro:OnHide()
end

function UISummer1Intro:Flush()
  local n = 0
  while true do
    n = n + 1
    local keyHead = StringTable.Has("str_summer_i_activity_intro_head_" .. n)
    if not keyHead then
      n = n - 1
      break
    end
  end
  if n <= 0 then
    Log.fatal("### no [str_summer_i_activity_intro_head_n] in str_summer")
    return
  end
  self.Content:SpawnObjects("UISummer1IntroItem", n)
  local uis = self.Content:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local head = StringTable.Get("str_summer_i_activity_intro_head_" .. i)
    local body = StringTable.Get("str_summer_i_activity_intro_body_" .. i)
    ui:Flush(head, body)
  end
end

function UISummer1Intro:btnCloseOnClick(go)
  self:PlayAnim(false, function()
    self:CloseDialog()
  end)
end

function UISummer1Intro:PlayAnim(isIn, callback)
  self:StartTask(function(TT)
    self:Lock("UISummer1IntroPlayAnim")
    if isIn then
      self.anim:Play("uieff_Activity_UISummer1Intro_In")
      YIELD(TT, 500)
    else
      self.anim:Play("uieff_Activity_UISummer1Intro_Out")
      YIELD(TT, 500)
    end
    self:UnLock("UISummer1IntroPlayAnim")
    if callback then
      callback()
    end
  end, self)
end
