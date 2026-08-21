_class("UIN22MedalFilter", UIController)
UIN22MedalFilter = UIN22MedalFilter

function UIN22MedalFilter:Constructor()
end

function UIN22MedalFilter:OnShow(uiParams)
  self.listData = uiParams[1]
  self.filter = uiParams[2]
  self.clickCallback = uiParams[3]
  self.anim = self:GetUIComponent("Animation", "SafeArea")
  self.poolContent = self:GetUIComponent("UISelectObjectPath", "Content")
  self:Flush()
end

function UIN22MedalFilter:OnHide()
end

function UIN22MedalFilter:Flush()
  local filters = self.listData:GetFilterIds()
  local len = table.count(filters)
  self.poolContent:SpawnObjects("UIN22MedalFilterItem", len)
  local uis = self.poolContent:GetAllSpawnList()
  for i, filter in ipairs(filters) do
    local ui = uis[i]
    local filterData = self.listData:GetFilterInfoById(filter)
    local name = filterData.Name
    ui:Flush(filter, StringTable.Get(name), function()
      self:FlushSelect(filter)
      if self.clickCallback then
        self.clickCallback(filter)
      end
      self:AnimCloseDialog()
    end)
  end
  self:FlushSelect(self.filter)
end

function UIN22MedalFilter:FlushSelect(filter)
  local uis = self.poolContent:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    ui:FlushSelect(filter)
  end
end

function UIN22MedalFilter:BgOnClick(go)
  self:AnimCloseDialog()
end

function UIN22MedalFilter:AnimCloseDialog()
  self:PlayAnimOut(function()
    self:CloseDialog()
  end)
end

function UIN22MedalFilter:PlayAnimOut(callback)
  self:StartTask(function(TT)
    local key = "uieff_UIN22MedalFilter_out"
    self:Lock(key)
    self.anim:Play("uieff_UIN22MedalFilter_out")
    YIELD(TT, 233)
    if callback then
      callback()
    end
    self:UnLock(key)
  end, self)
end
