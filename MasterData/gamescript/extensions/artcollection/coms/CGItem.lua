local CGItem, Super = NewViewComponent("CGItem")

function CGItem:ctor(uiNode, view, cfgId, uiMap)
  Super.ctor(self, uiNode, view)
  self.ui = uiMap and uiMap or UI_Collection_Item_VideoResource(uiNode)
  if self.ui.Image_Bg then
    self.ui.Image_Bg:SetActive(false)
  end
  local featureType = CommonDefine.FeatureId.CollectionPicture
  self.videoTypeList = {
    ArtCollectionController:GetCollectTypeByFeature(featureType, CommonDefine.PictureSubFeature.PV),
    ArtCollectionController:GetCollectTypeByFeature(featureType, CommonDefine.PictureSubFeature.RadioDrama)
  }
  self.activityType = ArtCollectionController:GetCollectTypeByFeature(featureType, CommonDefine.PictureSubFeature.Activity)
  self:InitParams(cfgId)
end

function CGItem:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:UpdateShow(self.cfgId)
end

function CGItem:InitParams(cfgId)
  self.cfgId = cfgId
  self.cfg = DT.CollectionHall[cfgId]
  self.showVideo = table.contains(self.videoTypeList, self.cfg.CollectionType)
  self.showActivity = self.cfg.CollectionType == self.activityType
  self.showCG = not self.showVideo and not self.showActivity
  if self.ui.Image_CurrentCG then
    self.ui.Image_CurrentCG:SetActive(ArtCollectionModel.Instance:IsBg(self.cfgId))
  end
end

function CGItem:UpdateShow(cfgId)
  self:InitParams(cfgId)
  self:InitLockState()
  self:InitItemLockState()
  self:UpdateRedComp()
end

local cgImageCount = 0
local cgImageLoaded = {}

function CGItem:StopCgImageLoader()
  if self.cgLoaderTicker then
    self.binder:StopTimer(self.cgLoaderTicker)
    self.cgLoaderTicker = nil
    cgImageCount = cgImageCount - 1
  end
end

function CGItem:GetCgDisplayImage()
  local uiImg = self.showVideo and self.ui.Image_PV or self.ui.Image_CG
  if self.showActivity then
    uiImg = self.ui.Image_Anim
  end
  return uiImg
end

function CGItem:ApplyCgPicture()
  local uiImg = self:GetCgDisplayImage()
  self:SetPicture(uiImg, self.cfg.Picture)
  self.ui.Image_PV:SetActive(self.showVideo)
  self.ui.Image_CG:SetActive(self.showCG)
  self.ui.Image_Anim:SetActive(self.showActivity)
end

function CGItem:InitLockState()
  local cfg = self.cfg
  local str = LT.Text(cfg.Title)
  local unlock = ArtCollectionController.Instance:IsUnlock(self.cfgId)
  if unlock then
    if ApplicationUtils.IsEditor() and not cgImageLoaded[cfg.Picture] then
      self:StopCgImageLoader()
      cgImageCount = cgImageCount + 1
      self.ui.Image_PV:SetActive(false)
      self.ui.Image_CG:SetActive(false)
      self.ui.Image_Anim:SetActive(false)
      local loadCfgId = self.cfgId
      self.cgLoaderTicker = self.binder:BindTimer(cgImageCount * 0.12, 0, nil, function()
        self.cgLoaderTicker = nil
        cgImageCount = cgImageCount - 1
        if self.cfgId ~= loadCfgId then
          return
        end
        cgImageLoaded[cfg.Picture] = true
        self:ApplyCgPicture()
      end)
    else
      self:StopCgImageLoader()
      self:ApplyCgPicture()
    end
  else
    self:StopCgImageLoader()
    self.ui.Image_CG:SetActive(false)
    self.ui.Image_PV:SetActive(false)
    self.ui.Image_Anim:SetActive(false)
    str = StrUtils.Fix2ConfuseText(str)
  end
  self:SetText(self.ui.Text_Introduce, str)
end

function CGItem:SetPicture(uiImg, pic)
  if pic and string.contains(pic, ";") then
    local picList = string.split(pic, ";")
    if PlayerDataUtils.IsMale() then
      pic = picList[1]
    else
      pic = picList[2]
    end
  end
  self:SetImage(uiImg, pic)
end

function CGItem:InitItemLockState()
  local isItemUnlocked = ArtCollectionModel.Instance:IsItemUnlocked(self.cfgId)
  local isUnlocked = ArtCollectionModel.Instance:IsUnlock(self.cfgId)
  if not isUnlocked then
    self:SetActive(self.ui.Group_Lock, false)
  elseif isItemUnlocked then
    self:SetActive(self.ui.Group_Lock, false)
  else
    self:SetActive(self.ui.Group_Lock, true)
    if self.cfg.UnlockConsume and self.cfg.UnlockConsume[2] then
      self:SetText(self.ui.Text_CostNum, ItemNumUtils.GetStr(self.cfg.UnlockConsume[2]))
    end
  end
end

function CGItem:GetRedShowFunc()
  if self.redFunc == nil then
    function self.redFunc()
      do return RedPointDataUtils.IsShowCollectionItem end
      
      return RedPointDataUtils.IsShowCollectionItem, self.cfgId
    end
  end
  return self.redFunc
end

function CGItem:UpdateRedComp()
  self:AddViewComponentOnce(self.ui.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.TextNew, nil, self:GetRedShowFunc())
end

function CGItem:OnCollectionItemUnlocked(cfgId)
  if cfgId ~= self.cfgId then
    return
  end
  self:UpdateShow(cfgId)
end

function CGItem:RegisterNotifications()
  self:RegisterNotify(NotifyId.CollectionItemUnlocked, self.OnCollectionItemUnlocked, self)
end

function CGItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, function()
    local unlock = ArtCollectionController.Instance:IsUnlock(self.cfgId)
    if unlock then
      self:ReqClearRed()
      if not ArtCollectionModel.Instance:IsItemUnlocked(self.cfgId) then
        local collectCfg = ArtCollectionModel.Instance:GetCfg(self.cfgId)
        local consumeTid, cost = table.unpack(collectCfg.UnlockConsume or {})
        local title = LT.Text("CollectionUnlockItemTitle")
        local content = LT.Textf("CollectionUnlockItem", ItemDataUtils.GetItemName(consumeTid), cost)
        UIManager.Instance:Reopen(Urls.CollectionUnlockConfirmView, title, content, collectCfg.UnlockConsume, function()
          ArtCollectionController.Instance:OnItemUnlock(self.cfgId)
        end)
        return
      end
      if self.showVideo then
        local cfg = self.cfg
        if cfg.Video ~= nil then
          AvgStoryManager.Instance:SetCommentId(self.cfgId)
          AvgStoryManager.Instance:StartStoryById(cfg.Video, nil, nil, function()
            local soundOpenEvt = UIChangeAudioUtils.GetOpenEventByUrl(Urls.ArtCollectionCGView)
            if soundOpenEvt then
              AudioManager.Instance:PostSoundEvent(soundOpenEvt)
            end
          end, {isLoop = true})
        end
      else
        self:LocalNotify(NotifyId.OnClickCGImage, self.cfgId)
      end
    elseif self.cfg and self.cfg.LockTip then
      local lockTip = LT.Text(self.cfg.LockTip)
      Alert.ShowStr(lockTip)
    else
      Alert.Show(10843)
    end
  end)
end

function CGItem:ReqClearRed()
  local unlock = ArtCollectionController.Instance:IsUnlock(self.cfgId)
  if unlock then
    RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Collection, RedPointDataUtils.RedAttrType.IsNew, self.cfgId)
    self:UpdateRedComp()
  end
end

return CGItem
