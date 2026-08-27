local UINHBSkinSingle = class("UINHBSkinSingle", UIBaseNode)
local base = UIBaseNode
local UINHeroSkinTag = require("Game.Skin.UI.UINHeroSkinTag")
local UINHandBookSkinTag = require("Game.HandBook.UI.Skin.UINHandBookSkinTag")
local UINHeroSkinSpTag = require("Game.Skin.UI.UINHeroSkinSpTag")
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local cs_DoTweenLoopType = CS.DG.Tweening.LoopType
local SkinEnum = require("Game.Skin.SkinEnum")

function UINHBSkinSingle:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.skinItem, self, self.OnClickHBSingleItem)
  self._bookTagPool = UIItemPool.New(UINHandBookSkinTag, self.ui.img_Tag.gameObject)
  self.ui.img_Tag.gameObject:SetActive(false)
  self._tagPool = UIItemPool.New(UINHeroSkinTag, self.ui.tagItem)
  self.ui.tagItem:SetActive(false)
  self._tagSpPool = UIItemPool.New(UINHeroSkinSpTag, self.ui.img_SpTag)
  self.ui.img_SpTag:SetActive(false)
end

function UINHBSkinSingle:InitHBSkinSingle(skinCfg, resloader, clickFunc)
  self._skinCfg = skinCfg
  self._clickFunc = clickFunc
  local heroId = self._skinCfg.heroId
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local resModelCfg = skinCtr:GetResModel(heroId, skinCfg ~= nil and skinCfg.id or nil)
  self.ui.heroFrame.gameObject:SetActive(false)
  local skinId = skinCfg.id
  local picResPath
  PlayerDataCenter.skinData:IsShowSkinOutline(skinId, SkinEnum.fromWhere.heroInfoAndHandbook, function(isShowSkinOutline)
    if isShowSkinOutline then
      local replaceSkinRes = PlayerDataCenter.skinData:GetSkinOutlineRes(skinId, SkinEnum.getOutLineResType.skinId)
      picResPath = PathConsts:GetCharacterPicPath(replaceSkinRes)
    else
      picResPath = PathConsts:GetCharacterPicPath(resModelCfg.src_id_pic, skinId, SkinEnum.fromWhere.heroInfoAndHandbook)
    end
    resloader:LoadABAssetAsync(picResPath, function(texture)
      if not IsNull(self.ui.heroFrame) then
        self.ui.heroFrame.gameObject:SetActive(true)
        self.ui.heroFrame.texture = texture
        if isShowSkinOutline then
          self.ui.heroFrame.color = PlayerDataCenter.skinData.outlineColor
        else
          self.ui.heroFrame.color = Color.white
        end
      end
    end)
  end)
  self.ui.tex_SkinName.text = LanguageUtil.GetLocaleText(self._skinCfg.name)
  self.ui.tex_HeroName.text = ConfigData:GetHeroNameById(heroId)
  local hasSkin = PlayerDataCenter.skinData:IsHaveSkin(self._skinCfg.id)
  self.ui.lock:SetActive(not hasSkin)
  self._bookTagPool:HideAll()
  local shopGoods = skinCtr:GetGoodsBySkinCfg(self._skinCfg)
  if skinCtr:GetGoodsBySkinCfg(self._skinCfg) ~= nil or skinCtr:GetGiftBySkinCfg(self._skinCfg) ~= nil then
    local bookTag = self._bookTagPool:GetOne()
    bookTag:InitBookSkinTag(1)
    bookTag.transform:SetAsLastSibling()
  end
  if skinCtr:GetActFrameDataBySkinCfg(self._skinCfg) then
    local bookTag = self._bookTagPool:GetOne()
    bookTag:InitBookSkinTag(2)
    bookTag.transform:SetAsLastSibling()
  end
  self._tagSpPool:HideAll()
  for _, tagId in ipairs(self._skinCfg.showlabel) do
    local item = self._tagSpPool:GetOne()
    item:InitSkinSpTag(tagId)
    item.transform:SetAsLastSibling()
  end
  local isShowL2DComingSoon = self._skinCfg.temp_label
  self.ui.obj_L2DComingSoon:SetActive(isShowL2DComingSoon)
  self.ui.obj_L2DComingSoon.transform:SetAsLastSibling()
  self:UpdHBSkinSingle()
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.tagGroup)
end

function UINHBSkinSingle:UpdHBSkinSingle()
  self._tagPool:HideAll()
  CommonUIUtil.CreateHeroSkinTags(self._skinCfg, self._tagPool)
  self:UpdateSkinUpgrade()
  self:UpdateSkinLimitTime()
end

function UINHBSkinSingle:UpdateSkinUpgrade()
  local isInTimeRange = PlayerDataCenter.skinData:IsInSkinUpgradeTimeRange(self._skinCfg.id)
  local skinUpOpen = PlayerDataCenter.skinData:IsSkinCanUpgrade(self._skinCfg.id)
  skinUpOpen = isInTimeRange and skinUpOpen
  self.ui.img_SkinUpgrade:SetActive(skinUpOpen)
  local day, hour, minute = PlayerDataCenter.skinData:GetSkinUpgradeLimitTime(self._skinCfg.id)
  if minute < 0 then
    self.ui.img_SkinUpgrade:SetActive(false)
    return
  end
  if 0 < day then
    self.ui.text_skinUpTime:SetIndex(0, tostring(day))
  elseif 0 < hour then
    self.ui.text_skinUpTime:SetIndex(1, tostring(hour))
  elseif 0 <= minute then
    self.ui.text_skinUpTime:SetIndex(2, tostring(minute))
  end
end

function UINHBSkinSingle:UpdateSkinLimitTime()
  if not self.ui.obj_skinLimit then
    return
  end
  if not PlayerDataCenter.skinData:IsHaveSkinLimit(self._skinCfg.id) then
    self.ui.obj_skinLimit:SetActive(false)
    return
  end
  self.ui.obj_skinLimit:SetActive(true)
  local remaindTime = PlayerDataCenter.skinData:GetSkinLimitTime(self._skinCfg.id) - PlayerDataCenter.timestamp
  local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false, true)
  if 0 < d then
    self.ui.text_skinLimitTime:SetIndex(0, tostring(d))
    return
  end
  if 0 < h then
    self.ui.text_skinLimitTime:SetIndex(1, tostring(h))
    return
  end
  if 0 < s then
    m = m + 1
  end
  self.ui.text_skinLimitTime:SetIndex(2, tostring(m))
end

function UINHBSkinSingle:OnClickHBSingleItem()
  if self._clickFunc ~= nil then
    self._clickFunc(self._skinCfg.id)
  end
end

function UINHBSkinSingle:PlayHBSkinSingleAni(delayTime)
  self:__StopTween()
  self.ui.bottom:DOLocalMoveX(20, 0.3):From():SetDelay(delayTime)
  self.ui.canvasGroup:DOFade(0, 0.3):From():SetDelay(delayTime)
  self.ui.tex_SkinName:DOFade(0, 0.2):From():SetDelay(delayTime)
  self.ui.tex_SkinName.transform:DOLocalMoveY(-10, 0.2):From(true):SetRelative(true):SetDelay(delayTime)
  self.ui.tex_HeroName:DOFade(0, 0.2):From():SetDelay(delayTime + 0.1)
  self.ui.tex_HeroName.transform:DOLocalMoveY(-10, 0.2):From(true):SetRelative(true):SetDelay(delayTime + 0.1)
  self.ui.skinTag:DOFade(0.4, 0.1):From():SetLoops(3, cs_DoTweenLoopType.Yoyo):SetDelay(delayTime)
end

function UINHBSkinSingle:__StopTween()
  self.ui.bottom:DOComplete()
  self.ui.canvasGroup:DOComplete()
  self.ui.tex_SkinName:DOComplete()
  self.ui.tex_SkinName.transform:DOComplete()
  self.ui.tex_HeroName:DOComplete()
  self.ui.tex_HeroName.transform:DOComplete()
  self.ui.skinTag:DOComplete()
end

function UINHBSkinSingle:OnDelete()
  self:__StopTween()
  base.OnDelete(self)
end

return UINHBSkinSingle
