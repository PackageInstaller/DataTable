local UINAdjEditorSkinItem = class("UINAdjEditorSkinItem", UIBaseNode)
local base = UIBaseNode
local UINHeroSkinTag = require("Game.Skin.UI.UINHeroSkinTag")
local UINHeroSkinSpTag = require("Game.Skin.UI.UINHeroSkinSpTag")
local SkinEnum = require("Game.Skin.SkinEnum")
local ALPHA_MASK_UNLOCK = 0.2980392156862745
local ALPHA_MASK_LOCKED = 0.7843137254901961

function UINAdjEditorSkinItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.tagItem:SetActive(false)
  self.tagPool = UIItemPool.New(UINHeroSkinTag, self.ui.tagItem)
  self._tagSpPool = UIItemPool.New(UINHeroSkinSpTag, self.ui.img_SpTag)
  self.ui.img_SpTag:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_skinPreviewItem, self, self.OnClickSkinItem)
end

function UINAdjEditorSkinItem:InitAdjSkinItem(heroId, skinCfg, resLoader, clickFunc)
  self._heroId = heroId
  self._skinCfg = skinCfg
  self._clickFunc = clickFunc
  self._unlock = false
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local resModelCfg = skinCtr:GetResModel(heroId, skinCfg ~= nil and skinCfg.id or nil)
  self.tagPool:HideAll()
  CommonUIUtil.CreateHeroSkinTags(skinCfg, self.tagPool)
  local skinId = self._skinCfg.id
  local picResPath
  PlayerDataCenter.skinData:IsShowSkinOutline(skinId, SkinEnum.fromWhere.adjutant, function(isShowSkinOutline)
    if isShowSkinOutline then
      local replaceSkinRes = PlayerDataCenter.skinData:GetSkinOutlineRes(skinId, SkinEnum.getOutLineResType.skinId)
      picResPath = PathConsts:GetCharacterPicPath(replaceSkinRes)
    else
      picResPath = PathConsts:GetCharacterPicPath(resModelCfg.src_id_pic, SkinEnum.fromWhere.adjutant)
    end
    self.ui.img_Skin.gameObject:SetActive(false)
    resLoader:LoadABAssetAsync(picResPath, function(texture)
      if not IsNull(self.ui.img_Skin) then
        self.ui.img_Skin.gameObject:SetActive(true)
        self.ui.img_Skin.texture = texture
        if isShowSkinOutline then
          self.ui.img_Skin.color = PlayerDataCenter.skinData.outlineColor
        else
          self.ui.img_Skin.color = Color.white
        end
      end
    end)
  end)
  local themId = skinCfg ~= nil and skinCfg.theme or ConfigData.game_config.defaultSkinThemId
  local skinTheme = ConfigData.skinTheme[themId]
  self.ui.tex_HeroName.text = self._skinCfg ~= nil and LanguageUtil.GetLocaleText(self._skinCfg.name) or ConfigData:GetHeroNameById(self._heroId)
  self.ui.tex_SkinName.text = skinTheme ~= nil and LanguageUtil.GetLocaleText(skinTheme.name) or ""
  self._tagSpPool:HideAll()
  for _, tagId in ipairs(self._skinCfg.showlabel) do
    local item = self._tagSpPool:GetOne()
    item:InitSkinSpTag(tagId)
  end
  self:SetAdjSkinItemSelect(false)
  self:RefreshAdjSkinLockState()
end

function UINAdjEditorSkinItem:SetAdjSkinItemSelect(flag)
  self.ui.img_Quailty.gameObject:SetActive(flag)
  if self._unlock then
    self.ui.maskBlack.gameObject:SetActive(not flag)
  else
    self.ui.maskBlack.gameObject:SetActive(true)
  end
  for i, v in ipairs(self.tagPool.listItem) do
    v:SetSelectState(flag)
  end
end

function UINAdjEditorSkinItem:RefreshAdjSkinLockState()
  if self._unlock then
    return
  end
  self._unlock = PlayerDataCenter.skinData:IsHaveSkin(self._skinCfg.id)
  if self._unlock then
    local color = self.ui.maskBlack.color
    color.a = ALPHA_MASK_UNLOCK
    self.ui.maskBlack.color = color
    self.ui.lock:SetActive(false)
  else
    local color = self.ui.maskBlack.color
    color.a = ALPHA_MASK_LOCKED
    self.ui.maskBlack.color = color
    self.ui.lock:SetActive(true)
  end
end

function UINAdjEditorSkinItem:OnClickSkinItem()
  if self._clickFunc ~= nil then
    self._clickFunc(self)
  end
end

function UINAdjEditorSkinItem:GetAdjSkinItemSkin()
  return self._skinCfg
end

return UINAdjEditorSkinItem
