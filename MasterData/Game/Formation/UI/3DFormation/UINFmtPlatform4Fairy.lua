local base = require("Game.Formation.UI.3DFormation.UINFmtPlatform")
local UINFmtPlatform4Fairy = class("UINFmtPlatform4Fairy", base)
local FmtEnum = require("Game.Formation.FmtEnum")

function UINFmtPlatform4Fairy:ctor(fmtCtrl, enterFmtData)
  self.fmtCtrl = fmtCtrl
  self.enterFmtData = enterFmtData
end

function UINFmtPlatform4Fairy:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self:_ReFmtPlatformUIState()
end

function UINFmtPlatform4Fairy:RefreshUIFmtPlatform4Fairy(fairyData)
  self:_ReFmtPlatformUIState()
  if fairyData == nil then
    return
  else
    local campSprite = CRH:GetSprite("spirit_camp", CommonAtlasType.CareerCamp)
    self.ui.img_Camp.sprite = campSprite
    self:_SetHaveHeroActive(true)
  end
  local bannedFairyDic = self.enterFmtData:GetCardSetTempBannedFairyDic()
  if bannedFairyDic then
    local isCardSetUsed = bannedFairyDic[fairyData:GetFairyUID()]
    if self.enterFmtData:GetFmtCtrlFromModule() == FmtEnum.eFmtFromModule.CardSet then
      self:_SetCardSetUsedActive(isCardSetUsed, 0)
    else
      self:_SetCardSetUsedActive(isCardSetUsed, 1)
    end
  end
end

function UINFmtPlatform4Fairy:_ReFmtPlatformUIState()
  self:_SetHaveHeroActive(false)
  self:_SelectHeroActive(false)
  self:_SetBenchHeroActive(false)
  self:_LockActive(false)
  self:_PowerActive(false)
  self:_QuickLevelActive(false)
  self.ui.cantUse:SetActive(false)
  self:_SetFixedLockActive(false)
  self:_SetCardSetUsedActive(false)
end

function UINFmtPlatform4Fairy:OnDelete()
  base.OnDelete(self)
end

return UINFmtPlatform4Fairy
