_class("UIHauteCoutureDrawPrizeItem", UICustomWidget)
UIHauteCoutureDrawPrizeItem = UIHauteCoutureDrawPrizeItem

function UIHauteCoutureDrawPrizeItem:Constructor()
  self._guangPoNum = 0
  self._itemId = 0
  self._assetList = {}
end

function UIHauteCoutureDrawPrizeItem:OnShow()
  self:_GetComponents()
end

function UIHauteCoutureDrawPrizeItem:_GetComponents()
  self._atlas = self:GetAsset("UIHauteCoutureKL.spriteatlas", LoadType.SpriteAtlas)
  self._icon = self:GetUIComponent("RawImageLoader", "Image")
  self._guangPoObj = self:GetGameObject("Guangpo")
  self._receiveImg = self:GetGameObject("receiveImg")
  self._bg = self:GetUIComponent("Image", "bg")
  self._addImgObj = self:GetGameObject("add")
  self._gray = self:GetGameObject("gray")
  self._guangPoNumTxt = self:GetUIComponent("UILocalizationText", "guangPoNum")
  self._itemNumTxt = self:GetUIComponent("UILocalizationText", "ItemNum")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._tedianTextObj = self:GetGameObject("tedianText")
  self._klIcon = self:GetUIComponent("Image", "klIcon")
  self._selectBg2 = self:GetUIComponent("Image", "selectBg2")
end

function UIHauteCoutureDrawPrizeItem:SetData(prizeSortOrder, componentId, specail, replace, callback)
  self._callback = callback
  self._data = Cfg.cfg_component_senior_skin_weight({ComponentID = componentId, RewardSortOrder = prizeSortOrder})[1]
  self._orderIndex = prizeSortOrder
  self._itemId = self._data.RewardID
  if replace then
    self._itemId = self._data.ReplaceRewardID
  end
  self._guangPoNum = self._data.AppendGlow
  if self._guangPoNumTxt then
    self._guangPoNumTxt:SetText("x" .. self._guangPoNum)
    self._itemNumTxt:SetText("x" .. self._data.RewardCount)
  end
  self._specail = specail
  if self._specail then
    local cfg = Cfg.cfg_senior_skin_draw({ComponentId = componentId})[1]
    if replace then
      self._tedianTextObj:SetActive(false)
      self._klIcon.sprite = self._atlas:GetSprite("kalian_senior_zjm_di32")
      self._selectBg2.sprite = self._atlas:GetSprite("kalian_senior_zjm_di31")
    else
      self._tedianTextObj:SetActive(true)
      self._klIcon.sprite = self._atlas:GetSprite("kalian_senior_zjm_di20")
      self._selectBg2.sprite = self._atlas:GetSprite("kalian_senior_zjm_di19")
    end
  else
    self:StartTask(function(TT)
      local yieldTime = math.floor((9 - self._orderIndex) / 3) * 70
      YIELD(TT, yieldTime)
      self._anim:Play("UIHauteCoutureDrawPrizeItem_in")
    end, self)
  end
  self._replace = replace
  self:_OnValue()
end

function UIHauteCoutureDrawPrizeItem:HideAddImg()
  self._addImgObj:SetActive(false)
end

function UIHauteCoutureDrawPrizeItem:Flush(state)
  self._receiveImg:SetActive(state)
  if self._specail then
  elseif self._data.UIType == 2 then
    self._bg.sprite = self._atlas:GetSprite("kalian_senior_zjm_di06")
  elseif self._data.UIType == 3 then
    self._bg.sprite = self._atlas:GetSprite("kalian_senior_zjm_di07")
  elseif self._data.UIType == 4 then
    self._bg.sprite = self._atlas:GetSprite("kalian_senior_zjm_di08")
  end
end

function UIHauteCoutureDrawPrizeItem:GetPrizeId()
  return self._itemId
end

function UIHauteCoutureDrawPrizeItem:GetCfgID()
  return self._data.ID
end

function UIHauteCoutureDrawPrizeItem:IsSpecailAward()
  return self._specail
end

function UIHauteCoutureDrawPrizeItem:SetGray(gray)
  if gray then
    self._gray:SetActive(true)
  else
    self._gray:SetActive(false)
  end
end

function UIHauteCoutureDrawPrizeItem:_OnValue()
  self._receiveImg:SetActive(false)
  if self._specail then
    self._guangPoObj:SetActive(false)
    self:HideAddImg()
  elseif self._guangPoNum > 0 then
    self._guangPoObj:SetActive(true)
  else
    self._guangPoObj:SetActive(false)
  end
  local cfg = Cfg.cfg_item[self._itemId]
  if cfg == nil then
    Log.fatal("cfg_item is nil." .. self._itemId)
  else
    local icon = cfg.Icon
    local quality = cfg.Color
    local text1 = self._itemCount
    if self._specialIcon then
      self._icon:LoadImage(self._specialIcon)
    else
      self._icon:LoadImage(icon)
    end
    self:InsertReward()
  end
  self:SetGray(false)
end

function UIHauteCoutureDrawPrizeItem:ImageOnClick(go)
  if self._specail and self._itemId > RoleAssetID.RoleAssetPetSkinBegin and self._itemId < RoleAssetID.RoleAssetPetSkinEnd then
    self:ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUOT_TIPS, self._itemId - 4000000)
  else
    if (self._itemId < RoleAssetID.RoleAssetPetSkinBegin or self._itemId > RoleAssetID.RoleAssetPetSkinEnd) and self._callback then
      self._callback(self._itemId, go.transform.position)
    else
    end
  end
end

function UIHauteCoutureDrawPrizeItem:InsertReward()
  local reward = RoleAsset:New()
  reward.assetid = self._data.RewardID
  reward.count = self._data.RewardCount
  if self._replace then
    reward.assetid = self._data.ReplaceRewardID
    reward.count = self._data.ReplaceRewardCount
  end
  table.insert(self._assetList, reward)
  if self._data.AppendGlow and self._data.AppendGlow > 0 then
    local rewardCoin = RoleAsset:New()
    rewardCoin.assetid = RoleAssetID.RoleAssetGlow
    rewardCoin.count = self._data.AppendGlow
    table.insert(self._assetList, rewardCoin)
  end
end

function UIHauteCoutureDrawPrizeItem:ItemBtnOnClick(go)
  if self._callback then
    self._callback(self._itemId, go.transform.position)
  end
end

function UIHauteCoutureDrawPrizeItem:GuangpoBtnOnClick(go)
  if self._callback then
    self._callback(RoleAssetID.RoleAssetGlow, go.transform.position)
  end
end
