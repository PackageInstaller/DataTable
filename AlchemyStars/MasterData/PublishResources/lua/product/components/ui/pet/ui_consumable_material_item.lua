_class("UIConsumableMaterialItem", UICustomWidget)
UIConsumableMaterialItem = UIConsumableMaterialItem

function UIConsumableMaterialItem:Constructor()
  self._perSecondCout = 2
  self._perNextSecondCout = 5
end

function UIConsumableMaterialItem:OnShow(uiParams)
  self._callBack = nil
  self._itemInfo = nil
  self._reduceCount = 0
  self._addCountPerSecond = Cfg.cfg_global.pet_up_level_add_count_per_second.IntValue
  self._anim = self:GetUIComponent("Animation", "anim")
  self._chooseGO = self:GetGameObject("choose")
  self._uiCommonAtlas = self:RootUIOwner():GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIAsset")
  self._transform = self:GetGameObject().transform
  self.firstShow = true
end

function UIConsumableMaterialItem:PlayFadeAnimIn()
  self._anim:Play("uieff_UIConsumableMaterialItem_FadeIn")
end

function UIConsumableMaterialItem:OnHide()
  self._reduceInfo = nil
  self._addCallBack = nil
  self._reduceCallback = nil
  self._checkReachCallBack = nil
end

function UIConsumableMaterialItem:Select(select, noAnim)
  if self._chooseGO then
    self._chooseGO:SetActive(select)
    if select then
      if noAnim then
        return
      end
      if self._tweener then
        self._tweener:Kill(true)
      end
      self._tweener = self._transform:DOPunchScale(Vector3(0.1, 0.1, 0.1), 0.2)
    end
  end
end

function UIConsumableMaterialItem:SetData(itemInfo, petElement, consumInfo, tItemIndex, addCallBack, reduceCallback, checkReachCallBack, maxCount)
  self._itemInfo = itemInfo
  if itemInfo == nil then
    self.uiItem:SetItemData({showBG = true})
    self.uiItem:SetBgImage(false)
    if self.expComponent then
      self.expComponent:SetExpNum(nil)
    end
    if self.reduceComponent then
      self.reduceComponent:SetReduceNum(nil)
    end
    self:Select(false)
    return
  end
  local exp = ""
  local icon = ""
  local quality = 0
  local text1 = ""
  self._reduceNum = 0
  local itemId = self._itemInfo.m_template_data.ID
  self._reduceInfo = consumInfo
  self._maxCount = maxCount
  self._addCallBack = addCallBack
  self._reduceCallback = reduceCallback
  self._checkReachCallBack = checkReachCallBack
  text1 = HelperProxy:GetInstance():FormatItemCount(itemInfo.m_data.count)
  local cfg = Cfg.cfg_item[self._itemInfo.m_template_data.ID]
  if cfg then
    icon = cfg.Icon
    quality = cfg.Color
  end
  self._itemIndex = tItemIndex
  self._reduceNum = self._reduceInfo and self._reduceInfo.count or 0
  local cfg_ite_type = Cfg.cfg_item_pet_exp[self._itemInfo.m_template_data.ID]
  if cfg_ite_type and cfg_ite_type.Element == petElement then
    local v = "+" .. Cfg.cfg_global.ElementAddExp.IntValue .. "%"
    exp = v
  end
  local isUp = true
  if 0 < self._reduceNum then
    isUp = false
  end
  self.uiItem:SetData(itemId)
  self.uiItem:SetItemData({
    text = text1,
    icon = icon,
    quality = quality,
    showBG = true
  })
  self.expComponent = self.uiItem:AddComponent(UIAssetComponentExp)
  self.eventComponent = self.uiItem:AddComponent(UIAssetComponentEvent)
  self.reduceComponent = self.uiItem:AddComponent(UIAssetComponentReduce)
  self.expComponent:ChangePos(true, isUp)
  self.expComponent:SetExpNum(exp)
  self.reduceComponent:SetReduceNum(self._reduceNum, function(flag)
    self:Select(flag)
  end)
  self.uiItem:SetBgImage(true)
  if self.firstShow then
    self.firstShow = false
    self.eventComponent:SetClickCallBack(function()
      self:MaterialItembtnOnClick()
    end)
    self.eventComponent:SetLongPressCallBack(function()
      self:MaterialItembtnOnClick()
      return self._reduceInfo and self._reduceInfo.count or 0
    end, nil, self._addCountPerSecond, true)
    self.reduceComponent:SetReduceLongPressCallBack(function()
      self:reduceBtnOnClick()
    end, self._addCountPerSecond)
  end
end

function UIConsumableMaterialItem:reduceBtnOnClick(go)
  if GuideHelper.IsUIGuideShow() then
    return
  end
  if self._itemInfo == nil then
    return
  end
  local iteminfo = {}
  iteminfo.fromeIndex = self._itemIndex
  iteminfo.assetid = self._itemInfo.m_data.item_pstid
  iteminfo.m_templateid = self._itemInfo.m_template_data.ID
  iteminfo.count = 1
  self._reduceInfo = self._reduceCallback(iteminfo)
  local reduceNum = self._reduceInfo and self._reduceInfo.count or 0
  local changePos = false
  if self._reduceNum ~= reduceNum then
    self._reduceNum = reduceNum
    changePos = true
  end
  local isUp = true
  if 0 < self._reduceNum then
    isUp = false
  end
  self.expComponent:ChangePos(changePos, isUp)
  self.reduceComponent:SetReduceNum(reduceNum, function(flag)
    self:Select(flag)
  end)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDecDown)
end

function UIConsumableMaterialItem:MaterialItembtnOnClick(go)
  if self._itemInfo == nil then
    return
  end
  local iteminfo = {}
  iteminfo.fromeIndex = self._itemIndex
  iteminfo.assetid = self._itemInfo.m_data.item_pstid
  iteminfo.m_templateid = self._itemInfo.m_template_data.ID
  iteminfo.count = 1
  local coutLerp = 0
  local addNum = 0
  if self._reduceInfo then
    addNum = self._reduceInfo.count
  end
  local haveNum = self._itemInfo.m_data.count
  coutLerp = haveNum - addNum
  if haveNum - addNum <= 0 then
    return
  end
  if self._checkReachCallBack(iteminfo) then
    return
  end
  if self._maxCount and addNum >= self._maxCount then
    return
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundAddUp)
  self._reduceInfo = self._addCallBack(iteminfo)
  local reduceNum = self._reduceInfo and self._reduceInfo.count or 0
  local changePos = false
  if self._reduceNum ~= reduceNum then
    self._reduceNum = reduceNum
    changePos = true
  end
  local isUp = true
  if 0 < self._reduceNum then
    isUp = false
  end
  self.expComponent:ChangePos(changePos, isUp)
  self.reduceComponent:SetReduceNum(reduceNum, function(flag)
    self:Select(flag)
  end)
end

function UIConsumableMaterialItem:ShowUpAnim(changePos, isUp)
  self.expComponent:ChangePos(changePos, isUp)
end
