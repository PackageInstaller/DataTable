local UINAthSuitMainItem = class("UINAthSuitMainItem", UIBaseNode)
local base = UIBaseNode
local UINAthSuitColleItem = require("Game.Arithmetic.AthMain.UINAthSuitColleItem")

function UINAthSuitMainItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self.__OnClickRoot)
  self.ui.colleItem:SetActive(false)
  self.colleItemPool = UIItemPool.New(UINAthSuitColleItem, self.ui.colleItem)
end

function UINAthSuitMainItem:InitAthSuitMainItem(suitData, resLoader, clickFunc)
  self.suitData = suitData
  self.clickFunc = clickFunc
  local suitParamCfg = ConfigData.ath_suit.suitParamDic[suitData.cfg.id]
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(suitParamCfg.name)
  self.ui.img_Icon.enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, suitParamCfg.icon)
    self.ui.img_Icon.enabled = true
  end)
  local suitCfg = ConfigData.ath_suit[suitData.cfg.id]
  self.colleItemPool:HideAll()
  for k, suitDetailCfg in ipairs(suitCfg) do
    local colleItem = self.colleItemPool:GetOne()
    local valid = self.suitData.curCount >= suitDetailCfg.num
    colleItem:InitAthSuitColleItemValid(suitDetailCfg.num, valid)
  end
end

function UINAthSuitMainItem:__OnClickRoot()
  if self.clickFunc ~= nil then
    self.clickFunc(self.suitData.cfg.id)
  end
end

function UINAthSuitMainItem:OnDelete()
  base.OnDelete(self)
end

return UINAthSuitMainItem
