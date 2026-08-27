local UINHeroSkin = class("UINHeroSkin", UIBaseNode)
local base = UIBaseNode
local UINHeroSkinTag = require("Game.Skin.UI.UINHeroSkinTag")
local UINHeroSkinSpTag = require("Game.Skin.UI.UINHeroSkinSpTag")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local SkinEnum = require("Game.Skin.SkinEnum")
local CS_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder

function UINHeroSkin:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.tagItem:SetActive(false)
  self.tagPool = UIItemPool.New(UINHeroSkinTag, self.ui.tagItem)
  self.ui.tagItem:SetActive(false)
  self._tagSpPool = UIItemPool.New(UINHeroSkinSpTag, self.ui.img_SpTag)
  self.ui.img_SpTag:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_skinPreviewItem, self, self.OnClickSkinItem)
end

function UINHeroSkin:InitSkinItem(heroId, skinCfg, resLoader, clickFunc, outDataFunc, heroSkinWin)
  self.heroCfg = ConfigData.hero_data[heroId]
  self.skinCfg = skinCfg
  self.shopGoodsData = nil
  self.clickFunc = clickFunc
  self.outDataFunc = outDataFunc
  self.heroSkinWin = heroSkinWin
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  self.resModelCfg = skinCtr:GetResModel(heroId, skinCfg ~= nil and skinCfg.id or nil)
  self.ui.img_Skin.gameObject:SetActive(false)
  local picResPath = PathConsts:GetCharacterPicPath(self.resModelCfg.src_id_pic, self.heroSkinWin:GetSkinFromWhere())
  self.lastResPath = picResPath
  self:__LoadHeroSkinImg(resLoader, true)
  self.ui.tex_HeroName.text = self.skinCfg ~= nil and LanguageUtil.GetLocaleText(self.skinCfg.name) or ""
  local skinTheme = ConfigData.skinTheme[self.skinCfg ~= nil and self.skinCfg.theme or ConfigData.game_config.defaultSkinThemId]
  self.ui.tex_SkinName.text = skinTheme ~= nil and LanguageUtil.GetLocaleText(skinTheme.name) or ""
  self._tagSpPool:HideAll()
  for _, tagId in ipairs(self.skinCfg.showlabel) do
    local item = self._tagSpPool:GetOne()
    item:InitSkinSpTag(tagId)
  end
  local isShowL2DComingSoon = self.skinCfg.temp_label
  self.ui.obj_L2DComingSoon:SetActive(isShowL2DComingSoon)
  self.ui.obj_L2DComingSoon.transform:SetAsLastSibling()
  local vowCfg = ConfigData.hero_vow_reward[heroId]
  local conList = vowCfg and vowCfg.vow_story_condition or table.emptytable
  local isVowTag = 0 < #conList and self.skinCfg.id == conList[2]
  self.ui.obj_vowEffectMask:SetActive(isVowTag)
  self:RefreshHeroSkinItem()
end

function UINHeroSkin:_UpdTag()
  self.tagPool:HideAll()
  local live2dLevel, haveModel = CommonUIUtil.CreateHeroSkinTags(self.skinCfg, self.tagPool)
  self.live2dLevel = live2dLevel
  self.haveModel = haveModel
end

function UINHeroSkin:RefreshHeroSkinItem()
  self:_UpdTag()
  self:__TryUpdateShopData()
  if self.skinCfg ~= nil and not PlayerDataCenter.skinData:IsHaveSkinPermanent(self.skinCfg.id) and self.shopGoodsData ~= nil then
    self.ui.obj_Price:SetActive(true)
    local priceItem = ConfigData.item[self.shopGoodsData.currencyId]
    self.ui.img_Price.sprite = CRH:GetSprite(priceItem.small_icon)
    self.ui.tex_Price.text = tostring(self.shopGoodsData.newCurrencyNum)
  else
    self.ui.obj_Price:SetActive(false)
  end
  self:OnTimerCutDownStart()
end

function UINHeroSkin:__TryUpdateShopData()
  self.shopGoodsData = nil
  self._bpGiftId = 0
  self._bpSkinShopId = 0
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  if self.skinCfg == nil then
    return
  end
  self.shopGoodsData = skinCtr:GetGoodsBySkinCfg(self.skinCfg)
  local actData = skinCtr:GetActFrameDataBySkinCfg(self.skinCfg)
  if actData ~= nil and actData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.BattlePass then
    if self.shopGoodsData == nil then
      return
    end
    local actId = actData:GetActId()
    local passInfo = PlayerDataCenter.battlepassData.passInfos[actId]
    if passInfo == nil or passInfo:GetBpBannerSkinId() == self.skinCfg.id or passInfo:GetBPSkinShopId() == 0 then
      return
    end
    self._bpGiftId = passInfo:GetBpSkinCoinGift()
    self._bpSkinShopId = passInfo:GetBPSkinShopId()
  end
end

function UINHeroSkin:GetItemLive2dLevel()
  return self.live2dLevel
end

function UINHeroSkin:GetIsItemShowOutline(callback)
  local skinId = self.skinCfg.id
  PlayerDataCenter.skinData:IsShowSkinOutline(skinId, self.heroSkinWin:GetSkinFromWhere(), function(isShowSkinOutline)
    if isShowSkinOutline then
      local replaceSkinRes = PlayerDataCenter.skinData:GetSkinOutlineRes(skinId, SkinEnum.getOutLineResType.skinId)
      callback(true, replaceSkinRes)
      return
    end
    callback(false)
    return
  end)
end

function UINHeroSkin:GetSkinBpGiftId()
  return self._bpGiftId
end

function UINHeroSkin:GetSkinShopId()
  return self._bpSkinShopId
end

function UINHeroSkin:OnTimerCutDownStart()
  self.ui.time:SetActive(false)
  if self.cutDownTimer ~= nil then
    TimerManager:StopTimer(self.cutDownTimer)
    self.cutDownTimer = nil
  end
  if self.shopGoodsData == nil then
    return
  end
  if self.shopGoodsData.isSoldOut then
    return
  end
  local hasTime, inTime, startTime, endTime = self.shopGoodsData:GetStillTime()
  if not hasTime or endTime == -1 then
    return
  end
  self.ui.time:SetActive(true)
  self.cutDownTimer = TimerManager:StartTimer(1, self.OnTimerCutDown, self)
  self:OnTimerCutDown()
end

function UINHeroSkin:OnTimerCutDown()
  if self.shopGoodsData == nil then
    self:OnTimerCutDownFinish()
    return
  end
  local hasTime, inTime, startTime, endTime = self.shopGoodsData:GetStillTime()
  if not hasTime or not inTime then
    self:OnTimerCutDownFinish()
    return
  end
  local remaindTime = endTime - PlayerDataCenter.timestamp
  local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false, true)
  if 0 < d then
    self.ui.text_time:SetIndex(0, tostring(d), tostring(h))
    return
  end
  if 0 < h then
    self.ui.text_time:SetIndex(1, tostring(h), tostring(m))
    return
  end
  if 0 < s then
    m = m + 1
  end
  self.ui.text_time:SetIndex(2, tostring(m))
end

function UINHeroSkin:OnTimerCutDownFinish()
  self.ui.time:SetActive(false)
  if self.cutDownTimer ~= nil then
    TimerManager:StopTimer(self.cutDownTimer)
    self.cutDownTimer = nil
  end
  self.shopGoodsData = nil
  if self.outDataFunc ~= nil then
    self.outDataFunc()
  end
end

function UINHeroSkin:UpdateSkinUpgrade()
  local isInTimeRange = PlayerDataCenter.skinData:IsInSkinUpgradeTimeRange(self.skinCfg.id)
  local skinUpOpen = PlayerDataCenter.skinData:IsSkinCanUpgrade(self.skinCfg.id)
  skinUpOpen = isInTimeRange and skinUpOpen
  self.ui.img_SkinUpgrade:SetActive(skinUpOpen)
end

function UINHeroSkin:SetSelectState(flag)
  self.ui.img_Quailty.gameObject:SetActive(flag)
  self.ui.maskBlack:SetActive(not flag)
  for i, v in ipairs(self.tagPool.listItem) do
    v:SetSelectState(flag)
  end
  if flag then
    self:CheckReadUpgradeSkin()
  end
end

function UINHeroSkin:OnClickSkinItem()
  if self.clickFunc ~= nil then
    self.clickFunc(self)
  end
end

function UINHeroSkin:CheckReadUpgradeSkin()
  local skinUpOpen = PlayerDataCenter.skinData:IsSkinCanUpgrade(self.skinCfg.id)
  local hasRead = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):IsUpgradeSkinRead(self.skinCfg.id)
  if skinUpOpen and not hasRead then
    local heroId = PlayerDataCenter.skinData:GetHeroIdBySkinId(self.skinCfg.id)
    local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, heroId, RedDotStaticTypeId.HeroSkin)
    if ok then
      PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetUpgradeSkinRead(self.skinCfg.id)
      node:OffsetBlueDotCount(-1)
    end
  end
end

function UINHeroSkin:TryReloadCtify(resLoader)
  self:__LoadHeroSkinImg(resLoader)
end

function UINHeroSkin:__LoadHeroSkinImg(resLoader, isInit)
  self:GetIsItemShowOutline(function(isShowSkinOutline, replaceSkinRes)
    local picResPath
    if isShowSkinOutline then
      picResPath = PathConsts:GetCharacterPicPath(replaceSkinRes, self.heroSkinWin:GetSkinFromWhere())
    else
      picResPath = PathConsts:GetCharacterPicPath(self.resModelCfg.src_id_pic, self.heroSkinWin:GetSkinFromWhere())
    end
    if self.lastResPath ~= picResPath or isInit then
      self.lastResPath = picResPath
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
    end
  end)
end

function UINHeroSkin:OnDelete()
  if self.cutDownTimer ~= nil then
    TimerManager:StopTimer(self.cutDownTimer)
    self.cutDownTimer = nil
  end
  base.OnDelete(self)
end

function UINHeroSkin:TryGetShopGoodsId()
  if self.shopGoodsData == nil then
    return nil, nil
  end
  return self.shopGoodsData.shopId, self.shopGoodsData.shelfId
end

function UINHeroSkin:UpdateSkinLimitTime()
  if not self.ui.rect_skinLimit then
    return
  end
  if not PlayerDataCenter.skinData:IsHaveSkinLimit(self.skinCfg.id) then
    self.ui.rect_skinLimit.gameObject:SetActive(false)
    return
  end
  self.ui.rect_skinLimit.gameObject:SetActive(true)
  local remaindTime = PlayerDataCenter.skinData:GetSkinLimitTime(self.skinCfg.id) - PlayerDataCenter.timestamp
  local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false, true)
  if 0 < d then
    self.ui.text_skinLimitTime:SetIndex(0, tostring(d))
  elseif 0 < h then
    self.ui.text_skinLimitTime:SetIndex(1, tostring(h))
  else
    if 0 < s then
      m = m + 1
    end
    self.ui.text_skinLimitTime:SetIndex(2, tostring(m))
  end
  if not self.ui.rect_skinLimit.gameObject.activeSelf then
    self.ui.rect_skinLimit.gameObject:SetActive(true)
    CS_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.rect_skinLimit)
  end
end

function UINHeroSkin:HidePriceAndCutDown()
  self:OnTimerCutDownFinish()
  self.ui.obj_Price:SetActive(false)
end

return UINHeroSkin
