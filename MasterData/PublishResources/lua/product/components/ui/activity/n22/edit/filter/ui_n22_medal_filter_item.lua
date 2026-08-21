_class("UIN22MedalFilterItem", UICustomWidget)
UIN22MedalFilterItem = UIN22MedalFilterItem

function UIN22MedalFilterItem:OnShow()
  self.bg = self:GetGameObject("Bg")
  self.select = self:GetGameObject("select")
  self.imgSelect = self:GetUIComponent("Image", "imgSelect")
  self.txtFilter = self:GetUIComponent("UILocalizationText", "txtFilter")
  local etl = UICustomUIEventListener.Get(self.bg)
  self:AddUICustomEventListener(etl, UIEvent.BeginDrag, function(eventData)
    if self:IsSelect() then
    else
      self:PlayAnimBg()
    end
  end)
  self:AddUICustomEventListener(etl, UIEvent.Drag, function(eventData)
  end)
  self:AddUICustomEventListener(etl, UIEvent.EndDrag, function(eventData)
  end)
  self:AddUICustomEventListener(etl, UIEvent.Click, function(go)
    self:PlayAnimBg(function()
      if self.clickCallback then
        self.clickCallback()
      end
    end)
  end)
end

function UIN22MedalFilterItem:OnHide()
  if self.taskId and self.taskId > 0 then
    GameGlobal.TaskManager():KillTask(self.taskId)
  end
end

function UIN22MedalFilterItem:Flush(filter, name, clickCallback)
  self.filter = filter
  self.bg.name = "Bg" .. filter
  self.clickCallback = clickCallback
  self.txtFilter:SetText(name)
end

function UIN22MedalFilterItem:FlushSelect(filter)
  self.select:SetActive(filter == self.filter)
end

function UIN22MedalFilterItem:IsSelect()
  return self.select.activeInHierarchy
end

function UIN22MedalFilterItem:PlayAnimBg(callback)
  self.taskId = self:StartTask(function(TT)
    local key = "UIN22MedalFilterItemPlayAnimBg"
    self:Lock(key)
    self.select:SetActive(true)
    self.imgSelect:CrossFadeAlpha(0, 0, false)
    local duration1 = 0.1
    self.imgSelect:CrossFadeAlpha(1, duration1, false)
    YIELD(TT, duration1 * 1000)
    self.imgSelect:CrossFadeAlpha(0, duration1, false)
    YIELD(TT, duration1 * 1000)
    self.select:SetActive(false)
    self.taskId = 0
    if callback then
      callback()
    end
    self:UnLock(key)
  end, self)
end
