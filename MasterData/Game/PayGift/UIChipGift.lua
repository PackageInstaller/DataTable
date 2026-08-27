local UIChipGift = class("UIChipGift", UIBaseWindow)
local base = UIBaseWindow
local UINChipGiftRewardItem = require("Game.PayGift.UINChipGiftRewardItem")
local CS_Resloader = CS.ResLoader
local CS_UnityEngine_GameObject = CS.UnityEngine.GameObject
local CS_MessageCommon = CS.MessageCommon

function UIChipGift:OnInit()
  UIUtil.SetTopStatus(self, self.OnBackChipGift, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickCloseBtn)
  UIUtil.AddButtonListener(self.ui.background, self, self.OnClickCloseBtn)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnClickBuy)
  UIUtil.AddValueChangedListener(self.ui.tog_Popup, self, self.OnTogIgnore)
  self.ui.rewardListNode.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.rewardListNode.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self._rewardGoDic = {}
end

function UIChipGift:InitChipGift(giftInfo, callback)
  if not IsNull(self._heroPrefab) then
    DestroyUnityObject(self._heroPrefab)
    self._heroPrefab = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.ui.tog_Popup.isOn = false
  self.resloader = CS_Resloader.Create()
  self._giftInfo = giftInfo
  self._callbakc = callback
  local flag, heroId = self._giftInfo:IsHeroConditionInGift()
  if flag then
    self:__LoadHero(heroId)
  end
  local flag, _, times = self._giftInfo:GetLimitBuyCount()
  self.ui.limit:SetActive(flag)
  if flag then
    self.ui.tex_limit:SetIndex(0, tostring(times))
  end
  self.ui.tex_giftName.text = LanguageUtil.GetLocaleText(self._giftInfo.groupCfg.name)
  self.ui.tex_des.text = LanguageUtil.GetLocaleText(self._giftInfo.groupCfg.des)
  self.rewardIds = self._giftInfo.defaultCfg.awardIds
  self.rewardCounts = self._giftInfo.defaultCfg.awardCounts
  self.ui.rewardListNode.totalCount = #self.rewardIds
  self.ui.rewardListNode:RefillCells()
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  local flag, _, endTime = self._giftInfo:IsUnlockTimeCondition()
  if flag and 0 < endTime then
    self.ui.time:SetActive(true)
    self.timerId = TimerManager:StartTimer(1, function()
      self:__RefreshTime()
    end, self)
    self:__RefreshTime()
  else
    self.ui.time:SetActive(false)
  end
  if self._giftInfo:IsUseItemPay() then
    self.ui.img_icon.gameObject:SetActive(true)
    CRH:GetSpriteByItemId(self._giftInfo.defaultCfg.costId)
    self.ui.tex_price.text = tostring(self._giftInfo.defaultCfg.costCount)
  else
    self.ui.img_icon.gameObject:SetActive(false)
    local payId = self._giftInfo.defaultCfg.payId
    local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay)
    local priceStr, priceNum = payCtrl:GetPayPriceShow(payId)
    self.ui.tex_price.text = priceStr
  end
  local path = self._giftInfo.groupCfg.pop_bg_res
  if not string.IsNullOrEmpty(path) then
    self.ui.bg.gameObject:SetActive(false)
    self.resloader:LoadABAssetAsync(PathConsts:GetGiftPopBg(path), function(texture)
      if not IsNull(self.transform) then
        self.ui.bg.texture = texture
        self.ui.bg.gameObject:SetActive(true)
      end
    end)
  end
end

function UIChipGift:__LoadHero(heroId)
  local heroCfg = ConfigData.hero_data[heroId]
  local rscCfg = ConfigData.resource_model[heroCfg.src_id]
  local path = PathConsts:GetCharacterBigImgPrefabPath(rscCfg.res_Name)
  self.resloader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) or IsNull(self.transform) then
      return
    end
    self._heroPrefab = prefab:Instantiate(self.ui.heroHolder.transform)
    local commonPicCtrl = self._heroPrefab:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("ChipGift")
  end)
end

function UIChipGift:__RefreshTime()
  local _, _, endTime = self._giftInfo:IsUnlockTimeCondition()
  local diff = endTime - PlayerDataCenter.timestamp
  if diff <= 0 then
    if self.timerId ~= nil then
      TimerManager:StopTimer(self.timerId)
      self.timerId = nil
    end
    self.ui.tex_Time:SetIndex(3, "0")
    return
  end
  local d = math.floor(diff / 86400)
  diff = diff % 86400
  local h = math.floor(diff / 3600)
  diff = diff % 3600
  local m = math.floor(diff / 60)
  local s = math.floor(diff % 60)
  if 0 < d then
    self.ui.tex_Time:SetIndex(0, tostring(d), tostring(h), tostring(m))
  elseif 0 < h then
    self.ui.tex_Time:SetIndex(1, tostring(h), tostring(m))
  elseif 0 < m then
    self.ui.tex_Time:SetIndex(2, tostring(m), tostring(s))
  else
    self.ui.tex_Time:SetIndex(3, tostring(s))
  end
end

function UIChipGift:__OnInstantiateItem(go)
  local rewardItem = UINChipGiftRewardItem.New()
  rewardItem:Init(go)
  self._rewardGoDic[go] = rewardItem
end

function UIChipGift:__OnChangeItem(go, index)
  local rewardItem = self._rewardGoDic[go]
  rewardItem:InitChipGiftReward(self.rewardIds[index + 1], self.rewardCounts[index + 1])
end

function UIChipGift:OnTogIgnore(value)
  self.ui.img_Select:SetActive(value)
end

function UIChipGift:OnClickBuy()
  if not self._giftInfo:IsUnlock() then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(7208))
    return
  end
  local giftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
  giftCtrl:SendBuyGifit(self._giftInfo.defaultCfg, nil, function()
    self:OnClickCloseBtn()
  end)
end

function UIChipGift:OnClickCloseBtn()
  UIUtil.OnClickBackByUiTab(self)
end

function UIChipGift:OnBackChipGift()
  if self.ui.tog_Popup.isOn then
    local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    userData:SetChipGiftPopIgnore(self._giftInfo.groupCfg.id, PlayerDataCenter.timestamp)
  end
  self:Delete()
  if self._callbakc ~= nil then
    self._callbakc()
  end
end

function UIChipGift:OnDelete()
  base.OnDelete(self)
  if not IsNull(self._heroPrefab) then
    DestroyUnityObject(self._heroPrefab)
    self._heroPrefab = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
end

return UIChipGift
