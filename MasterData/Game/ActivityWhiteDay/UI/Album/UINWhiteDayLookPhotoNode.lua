local UINWhiteDayLookPhotoNode = class("UINWhiteDayLookPhotoNode", UIBaseNode)
local base = UIBaseNode
local cs_ResLoader = CS.ResLoader

function UINWhiteDayLookPhotoNode:ctor(AWDCtrl, AWDData, resloader)
  self.AWDCtrl = AWDCtrl
  self.AWDData = AWDData
  self.resloader = resloader
  local BackgroundStretchSize = UIManager.BackgroundStretchSize
  local shortLen = math.min(BackgroundStretchSize.x, BackgroundStretchSize.y)
  self.__PhotoMaxSize = Vector3.New(shortLen * 0.9, shortLen, 0)
end

function UINWhiteDayLookPhotoNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnClickCloseLookPhoto)
  UIUtil.AddButtonListener(self.ui.btn_Story, self, self.__OnClickStory)
  UIUtil.AddButtonListener(self.ui.btn_Check, self, self.OnClickCheck)
  UIUtil.AddButtonListener(self.ui.btn_Skin, self, self.OnClickSkin)
  self.__isInCheck = false
  self.__photoOrigSize = self.ui.img_Photo.transform.sizeDelta
  self.__photoOrigPos = self.ui.img_Photo.transform.anchoredPosition
end

function UINWhiteDayLookPhotoNode:SetJustLookAvg()
  self._justLookAvg = true
end

function UINWhiteDayLookPhotoNode:InitWDSelectNode(photoCfg, closeCallback, openSkinCall)
  self.closeCallback = closeCallback
  self.openSkinCall = openSkinCall
  self.__isInCheck = false
  self.ui.obj_frame:SetActive(true)
  self.ui.obj_BigPhotoNode:SetActive(false)
  self.ui.img_Photo.transform:SetParent(self.ui.obj_PhotoRoot)
  self.ui.img_Photo.transform.sizeDelta = self.__photoOrigSize
  self.ui.img_Photo.transform.anchoredPosition = self.__photoOrigPos
  local color = self.ui.img_Photo.color
  color.a = 1
  self.ui.img_Photo.color = color
  if photoCfg == self.photoCfg then
    return
  end
  self.photoCfg = photoCfg
  local photo_resource = photoCfg.photo_resource
  if not string.IsNullOrEmpty(photo_resource) then
    if self.bigResLoader ~= nil then
      self.bigResLoader:Put2Pool()
      self.bigResLoader = nil
    end
    self.bigResLoader = cs_ResLoader.Create()
    local path = PathConsts:GetWhiteDayPhotoPath(photo_resource)
    UIUtil.LoadABAssetAsyncAndSetTexture(self.bigResLoader, path, self.ui.img_Photo)
  end
  local skinUseful = self.photoCfg.skinId ~= nil and PlayerDataCenter.skinData:IsSkinUnlocked(self.photoCfg.skinId)
  self.ui.btn_Skin.gameObject:SetActive(skinUseful)
end

function UINWhiteDayLookPhotoNode:__OnClickStory()
  local storyId = self.photoCfg.story_id
  local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
  if self._justLookAvg then
    local avgCfg = ConfigData.story_avg[storyId]
    avgCtrl:ShowAvg(avgCfg.script_id)
  else
    avgCtrl:StartAvg(nil, storyId)
  end
end

function UINWhiteDayLookPhotoNode:OnClickCheck()
  self.ui.obj_frame:SetActive(false)
  self.ui.obj_BigPhotoNode:SetActive(true)
  self.ui.img_Photo.transform:SetParent(self.ui.obj_BigPhotoRoot)
  self.ui.img_PhotoBg.transform.sizeDelta = self.__PhotoMaxSize
  self.ui.img_Photo.transform.anchoredPosition = Vector2.zero
  self.ui.img_Photo.transform.sizeDelta = Vector2.zero
  self.ui.img_Photo:DOFade(0, 1.5):From():SetEase(CS.DG.Tweening.Ease.OutQuad)
  AudioManager:PlayAudioById(1209)
  self.__isInCheck = true
end

function UINWhiteDayLookPhotoNode:OnClickSkin()
  if self.openSkinCall ~= nil then
    self.openSkinCall(self.photoCfg.skinId)
  end
end

function UINWhiteDayLookPhotoNode:OnClickCloseLookPhoto()
  if self.__isInCheck then
    self.ui.obj_frame:SetActive(true)
    self.ui.obj_BigPhotoNode:SetActive(false)
    self.ui.img_Photo.transform:SetParent(self.ui.obj_PhotoRoot)
    self.ui.img_Photo.transform.anchoredPosition = self.__photoOrigPos
    self.ui.img_Photo.transform.sizeDelta = self.__photoOrigSize
    self.__isInCheck = false
    self.ui.img_Photo:DOComplete()
    return
  end
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  self.ui.img_Photo:DOKill()
  self:Hide()
end

function UINWhiteDayLookPhotoNode:OnDelete()
  if self.bigResLoader ~= nil then
    self.bigResLoader:Put2Pool()
    self.bigResLoader = nil
  end
  self.ui.img_Photo:DOKill()
  base.OnDelete(self)
end

return UINWhiteDayLookPhotoNode
