local ActTechRowData = class("ActTechRowData")

function ActTechRowData.CreateTechRowData(line_id, techDataDic)
  local data = ActTechRowData.New()
  data.rowIndex = line_id
  local cfg = ConfigData.activity_tech_line[line_id]
  if cfg == nil then
    error("can't get activity_tech_line cfg with line id:" .. tostring(line_id))
    return
  end
  data.techDataDic = techDataDic
  data.techLineCfg = cfg
  data.techAvgId = cfg.story_id
  data.techAvgCfg = ConfigData.story_avg[data.techAvgId]
  data:RefreshTechAvgState()
  return data
end

function ActTechRowData:ctor()
  self.rowIndex = nil
  self.techLineCfg = nil
  self.techDataDic = {}
end

function ActTechRowData:GetIsUnlock()
  local cfg = self.techLineCfg
  return CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2)
end

function ActTechRowData:GetRowOrder()
  return self.techLineCfg.num
end

function ActTechRowData:GetTechDataDic()
  return self.techDataDic
end

function ActTechRowData:GetRowName()
  return LanguageUtil.GetLocaleText(self.techLineCfg.name)
end

function ActTechRowData:GetRowEnName()
  return self.techLineCfg.name
end

function ActTechRowData:GetRowIntro()
  return LanguageUtil.GetLocaleText(self.techLineCfg.intro)
end

function ActTechRowData:GetRowBgImage()
  return self.techLineCfg.bg
end

function ActTechRowData:GetTechAvgId()
  return self.techAvgId
end

function ActTechRowData:GetIsTechAvgCfg()
  return self.techAvgCfg
end

function ActTechRowData:RefreshTechAvgState()
  if not self:GetIsHaveTechAvg() then
    return
  end
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  self.isAvgClear = avgPlayCtrl:IsAvgPlayed(self.techAvgId)
  self.isAvgUnlock = avgPlayCtrl:IsAvgUnlock(self.techAvgId)
end

function ActTechRowData:GetIsHaveTechAvg()
  return self.techAvgId ~= nil and self.techAvgId ~= 0
end

function ActTechRowData:GetIsTechAvgUnlock()
  return self.isAvgUnlock
end

function ActTechRowData:GetIsTechAvgCompleted()
  return self.isAvgClear
end

function ActTechRowData:GetIsTechAvgName()
  return LanguageUtil.GetLocaleText(self.techAvgCfg.name)
end

function ActTechRowData:GetTechAvgUnlockInfo()
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local unlockInfo = avgPlayCtrl:GetAvgUnlockInfo(self.techAvgId)
  return unlockInfo
end

return ActTechRowData
