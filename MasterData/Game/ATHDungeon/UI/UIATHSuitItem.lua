local UIATHSuitItem = class("UIATHSuitItem", UIBaseNode)
local base = UIBaseNode

function UIATHSuitItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_SuitNode, self, self.__onClick)
end

function UIATHSuitItem:InitATHSuitItem(athSuitId, resLoader)
  self.athSuitId = athSuitId
  self.resLoader = resLoader
  local suitCfg
  local suitParamCfg = ConfigData.ath_suit.suitParamDic[athSuitId]
  if suitParamCfg ~= nil then
    self.resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
      if spriteAtlas == nil then
        return
      end
      self.ui.img_SuitIcon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, suitParamCfg.icon)
    end)
    self.ui.tex_SuitName:SetIndex(0, LanguageUtil.GetLocaleText(suitParamCfg.name))
  end
end

function UIATHSuitItem:__onClick()
  if self.clickEvent ~= nil then
    self.clickEvent(self)
  end
end

function UIATHSuitItem:OnHide()
  self.clickEvent = nil
  self.athSuitId = nil
end

function UIATHSuitItem:OnDelete()
  base.OnDelete(self)
end

return UIATHSuitItem
