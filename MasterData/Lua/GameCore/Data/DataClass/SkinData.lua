local SkinData = class("SkinData")

function SkinData:ctor(skinId, handbookId, unlock)
  self.nId = skinId
  self.nHandbookId = handbookId
  self.tbCfgData = ConfigTable.GetData_CharacterSkin(skinId)
  if nil == self.tbCfgData then
    printError("Get skinData fail!!! skinId = " .. skinId)
    return
  end
  self.nCharId = self.tbCfgData.CharId
  self.nUnlock = unlock
  self.tbSkinExtraTag = self.tbCfgData.SkinExtraTag
end

function SkinData:UpdateUnlockState(nUnlock)
  self.nUnlock = nUnlock
end

function SkinData:GetId()
  return self.nId
end

function SkinData:GetCharId()
  return self.nCharId
end

function SkinData:GetHandbookId()
  return self.nHandbookId
end

function SkinData:GetSkinExtraTags()
  return self.tbSkinExtraTag
end

function SkinData:GetCfgData()
  return self.tbCfgData
end

function SkinData:CheckSkinShow()
  return self.tbCfgData.IsShow
end

function SkinData:CheckUnlock()
  return self.nUnlock == 1
end

function SkinData:CheckFavorCG()
  local nCGId = self.tbCfgData.CharacterCG
  local cfgCG = ConfigTable.GetData("CharacterCG", nCGId)
  if cfgCG == nil then
    printError(string.format("读取CharacterCG配置失败！！！id = [%s]", nCGId))
  elseif cfgCG.UnlockPlot > 0 then
    return PlayerData.Char:IsCharPlotFinish(self.nCharId, cfgCG.UnlockPlot)
  end
  return true
end

function SkinData:GetUnlockPlot()
  local nCGId = self.tbCfgData.CharacterCG
  local cfgCG = ConfigTable.GetData("CharacterCG", nCGId)
  if cfgCG == nil then
    printError(string.format("读取CharacterCG配置失败！！！id = [%s]", nCGId))
    return 0
  end
  return cfgCG.UnlockPlot
end

return SkinData
