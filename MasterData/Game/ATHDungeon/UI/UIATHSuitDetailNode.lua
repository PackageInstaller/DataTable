local UIATHSuitDetailNode = class("UIATHSuitDetailNode", UIBaseNode)
local base = UIBaseNode
local UINAthSuitColleItem = require("Game.Arithmetic.AthMain.UINAthSuitColleItem")

function UIATHSuitDetailNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.SuitItemPool = UIItemPool.New(UINAthSuitColleItem, self.ui.colleItem, false)
  UIUtil.AddButtonListener(self.ui.obj_SuitEffectBg, self, self.OnClicKClose)
end

function UIATHSuitDetailNode:InitSuitDetailNode(suitId, resLoader)
  self.suitId = suitId
  self.resLoader = resLoader
  local suitParamCfg = ConfigData.ath_suit.suitParamDic[self.suitId]
  if suitParamCfg ~= nil then
    self.ui.tex_SuitName.text = LanguageUtil.GetLocaleText(suitParamCfg.name)
    self.resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
      if spriteAtlas == nil then
        return
      end
      self.ui.img_SuitIcon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, suitParamCfg.icon)
    end)
  end
  self.SuitItemPool:HideAll()
  local intro
  for _, cfg in pairs(ConfigData.ath_suit[self.suitId]) do
    local item = self.SuitItemPool:GetOne()
    item:InitAthSuitColleItem(cfg.num)
    if intro == nil then
      intro = LanguageUtil.GetLocaleText(cfg.describe)
    else
      intro = intro .. "\n" .. LanguageUtil.GetLocaleText(cfg.describe)
    end
  end
  self.ui.tex_Intro.text = intro
end

function UIATHSuitDetailNode:SetCoulClickThroughGos(list)
  local goList = {}
  for key, value in pairs(list) do
    table.insert(goList, value.gameObject)
  end
  self.ui.obj_SuitEffectBg.m_throughTargets = goList
end

function UIATHSuitDetailNode:OnClicKClose()
  self:Hide()
end

function UIATHSuitDetailNode:OnDelete()
  self.SuitItemPool:DeleteAll()
  base.OnDelete(self)
end

return UIATHSuitDetailNode
