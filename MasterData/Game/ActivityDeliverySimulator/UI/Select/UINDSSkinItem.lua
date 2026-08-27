local base = UIBaseNode
local UINDSSkinItem = class("UINDSSkinItem", base)
local SkinEnum = require("Game.Skin.SkinEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")

function UINDSSkinItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_item, self, self.OnClickItem)
end

function UINDSSkinItem:InitDSSkinItem(heroId, skinId, isNeedOwn, resLoader, selectCallback)
  self.heroId = heroId
  self.skinId = skinId
  self.skinCfg = ConfigData.skin[self.skinId]
  self.isNeedOwn = isNeedOwn
  self.selectCallback = selectCallback
  self.resLoader = resLoader
  self:RefreshSkinShow()
  self:__TryUpdateShopData()
end

function UINDSSkinItem:__TryUpdateShopData()
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

function UINDSSkinItem:RefreshSkinShow()
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  self.resModelCfg = skinCtr:GetResModel(self.heroId, self.skinId or nil)
  local skinCfg = ConfigData.skin[self.skinId]
  self.ui.tex_SkinName.text = LanguageUtil.GetLocaleText(skinCfg.name)
  local heroCfg = ConfigData.hero_data[self.heroId]
  self.ui.tex_HeroName.text = LanguageUtil.GetLocaleText(heroCfg.name)
  self.ui.img_HeroPic.gameObject:SetActive(false)
  local picResPath = PathConsts:GetCharacterPicPath(self.resModelCfg.src_id_pic, SkinEnum.fromWhere.heroInfoAndHandbook)
  self.lastResPath = picResPath
  self:__LoadHeroSkinImg(self.resLoader, true)
  local isHave = PlayerDataCenter.skinData:IsHaveSkin(self.skinId)
  self.ui.obj_NotOwn:SetActive(not isHave)
  if not isHave then
    self.ui.tex_own:SetIndex(self.isNeedOwn and 0 or 1)
  end
end

function UINDSSkinItem:__LoadHeroSkinImg(resLoader, isInit)
  self:GetIsItemShowOutline(function(isShowSkinOutline, replaceSkinRes)
    local picResPath
    if isShowSkinOutline and self.isNeedOwn then
      picResPath = PathConsts:GetCharacterPicPath(replaceSkinRes, SkinEnum.fromWhere.heroInfoAndHandbook)
    else
      picResPath = PathConsts:GetCharacterPicPath(self.resModelCfg.src_id_pic, SkinEnum.fromWhere.heroInfoAndHandbook)
    end
    if self.lastResPath ~= picResPath or isInit then
      self.lastResPath = picResPath
      resLoader:LoadABAssetAsync(picResPath, function(texture)
        if not IsNull(self.ui.img_HeroPic) then
          self.ui.img_HeroPic.gameObject:SetActive(true)
          self.ui.img_HeroPic.texture = texture
          if isShowSkinOutline and self.isNeedOwn then
            self.ui.img_HeroPic.color = PlayerDataCenter.skinData.outlineColor
          else
            self.ui.img_HeroPic.color = Color.white
          end
        end
      end)
    end
  end)
end

function UINDSSkinItem:GetIsItemShowOutline(callback)
  PlayerDataCenter.skinData:IsShowSkinOutline(self.skinId, SkinEnum.fromWhere.heroInfoAndHandbook, function(isShowSkinOutline)
    if isShowSkinOutline then
      local replaceSkinRes = PlayerDataCenter.skinData:GetSkinOutlineRes(self.skinId, SkinEnum.getOutLineResType.skinId)
      callback(true, replaceSkinRes)
      return
    end
    callback(false)
    return
  end)
end

function UINDSSkinItem:OnClickItem()
  if self.selectCallback ~= nil then
    self.selectCallback(self)
  end
end

function UINDSSkinItem:SetSkinItemSelect(bool)
  self.ui.obj_Select:SetActive(bool)
end

function UINDSSkinItem:OnDelete()
end

return UINDSSkinItem
