local UINAthListSuitItem = class("UINAthListSuitItem", UIBaseNode)
local base = UIBaseNode
local UINAthSuitColleItem = require("Game.Arithmetic.AthMain.UINAthSuitColleItem")
local cs_Edge = CS.UnityEngine.RectTransform.Edge

function UINAthListSuitItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self.__OnClickRoot)
  UIUtil.AddButtonListener(self.ui.btn_ShowIntro, self, self.__OnClickShowIntro)
  self.ui.colleItem:SetActive(false)
  self.colleItemPool = UIItemPool.New(UINAthSuitColleItem, self.ui.colleItem)
end

function UINAthListSuitItem:InitAthListSuitItem(suitId, isRecommend, clickFunc, resLoader, curCount)
  self.suitId = suitId
  self.clickFunc = clickFunc
  local suitList = ConfigData.ath_suit[suitId]
  if suitList == nil then
    error("Cant find ath suitList, suitId = " .. tostring(suitId))
    return
  end
  local suitParamCfg = ConfigData.ath_suit.suitParamDic[suitId]
  self._suitParamCfg = suitParamCfg
  local iconName = suitParamCfg.icon
  self.ui.btn_ShowIntro.gameObject:SetActive(suitParamCfg.suit_lable_id ~= 0)
  self.ui.img_Icon.enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, iconName)
    self.ui.img_Icon.enabled = true
  end)
  self.ui.tex_Own:SetIndex(0, tostring(curCount))
  local own = 0 < curCount
  self.ui.tex_Own.text.color = own and self.ui.ownColor_Tex or self.ui.notOwnColor_Tex
  self.ui.img_OwnBg.color = own and self.ui.ownColor_Bg or self.ui.notOwnColor_Bg
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(suitParamCfg.name)
  self.ui.img_Recommend:SetActive(isRecommend)
  self.colleItemPool:HideAll()
  local intro
  for k, suitCfg in ipairs(suitList) do
    local colleItem = self.colleItemPool:GetOne()
    colleItem:InitAthSuitColleItem(suitCfg.num)
    if intro == nil then
      intro = LanguageUtil.GetLocaleText(suitCfg.describe)
    else
      intro = intro .. "\n" .. LanguageUtil.GetLocaleText(suitCfg.describe)
    end
  end
  self.ui.tex_Intro.text = intro
  self.ui.obj_RateBg:SetActive(false)
end

function UINAthListSuitItem:ShowAthListSuitItemUsingRate(usingRate)
  self.ui.obj_RateBg:SetActive(true)
  self.ui.tex_Rate:SetIndex(0, GetPreciseDecimalStr(usingRate // 100, 2))
end

function UINAthListSuitItem:__OnClickRoot()
  if self.clickFunc ~= nil then
    self.clickFunc(self.suitId)
  end
end

function UINAthListSuitItem:__OnClickShowIntro()
  UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
    if win ~= nil then
      win:ShowIntroLabelList(self.ui.suitIntroHolder, {
        self._suitParamCfg.suit_lable_id
      })
      win:SetIntroListPosition(cs_Edge.Left, cs_Edge.Top)
    end
  end)
end

function UINAthListSuitItem:OnDelete()
  self.colleItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINAthListSuitItem
