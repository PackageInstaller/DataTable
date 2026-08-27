local DormDetailDataUtil = {}

function DormDetailDataUtil:SetDataIsTheme(bool, fntData)
  self.isTheme = bool
  self.fntData = fntData
end

function DormDetailDataUtil:GetFntTag()
  if not self.isTheme then
    return false
  end
  local fntThemeCfg = self.fntData.dmFntThemeCfg
  if self.fntData:IsDmFntThemeInSell() then
    return true, 0
  elseif fntThemeCfg.is_activity then
    return true, 1
  else
    return false
  end
end

function DormDetailDataUtil:GetIsBigRoom()
  if not self.isTheme then
    return self.fntData.fntCfg.only_big
  end
  local fntThemeCfg = self.fntData.dmFntThemeCfg
  return fntThemeCfg.only_big
end

function DormDetailDataUtil:GetFntIconPath()
  if self.isTheme then
    local fntThemeCfg = self.fntData.dmFntThemeCfg
    return PathConsts:GetShopFurnitureThemePath(fntThemeCfg.theme_pic3)
  end
  if self.fntData.isDefaultDmFnt then
    return self.fntData.icon
  else
    return self.fntData.itemCfg.icon
  end
end

function DormDetailDataUtil:GetFntComfort()
  if self.isTheme then
    return self.fntData:GetDmFntThemeComformt()
  end
  if self.fntData.isDefaultDmFnt then
    return 0
  else
    return self.fntData.fntCfg.comfort
  end
end

function DormDetailDataUtil:GetFntName()
  if self.isTheme then
    local fntThemeCfg = self.fntData.dmFntThemeCfg
    return LanguageUtil.GetLocaleText(fntThemeCfg.theme_name)
  end
  if self.fntData.isDefaultDmFnt then
    local itemCfg = ConfigData.item[self.fntData.itemId]
    return LanguageUtil.GetLocaleText(itemCfg.name)
  else
    return LanguageUtil.GetLocaleText(self.fntData.itemCfg.name)
  end
end

function DormDetailDataUtil:GetFntDes()
  if self.isTheme then
    local fntThemeCfg = self.fntData.dmFntThemeCfg
    return LanguageUtil.GetLocaleText(fntThemeCfg.theme_info)
  end
  if self.fntData.isDefaultDmFnt then
    local itemCfg = ConfigData.item[self.fntData.itemId]
    return LanguageUtil.GetLocaleText(itemCfg.describe)
  end
  return LanguageUtil.GetLocaleText(self.fntData.itemCfg.describe)
end

function DormDetailDataUtil:GetThemeName()
  if self.isTheme then
    return 0, ""
  end
  local tagId = self.fntData.fntCfg.category
  local cfg = ConfigData.dorm_fnt_category[tagId]
  return 1, LanguageUtil.GetLocaleText(cfg.name)
end

return DormDetailDataUtil
