local SummonSkinResultNextPanel, Super = System.NewClass("SummonSkinResultNextPanel", UIBasePanel)
SummonSkinResultNextPanel.uiResCls = UI_Summon_Result_PanelResource
local UIAnimationController = CS.Z1Client.UIAnimationController

function SummonSkinResultNextPanel:ctor(itemTid, closeCallback)
  Super.ctor(self)
  self.itemTid = itemTid
  self.itemQuality = self:GetItemQuality(itemTid)
  self.closeCallback = closeCallback
end

function SummonSkinResultNextPanel:OnBind(binder)
  Super.OnBind(self, binder)
  self.binder = binder
  self.binder:BindButtonClick(self.ui.Btn_Skip, System.fn(self, self.OnBtnSkip))
  self:_InitUIElements()
  self:PlayVideo()
end

function SummonSkinResultNextPanel:GetItemQuality(itemTid)
  local itemCfg = ItemDataUtils.GetItemConfig(itemTid)
  return itemCfg and itemCfg.Quality or cd.CommonQuality.Purple
end

function SummonSkinResultNextPanel:PlayVideo()
  local gameVideoPlayer = GameVideoPlayer(self.ui.Summon_Front_R, self.ui.Summon_Front_R_Bak)
  if ApplicationUtils.IsIOS() then
    gameVideoPlayer.forceUnityPlayer = true
  end
  
  function gameVideoPlayer.preparedCallback()
    self:SetSkinLogo()
    gameVideoPlayer:Play()
  end
  
  gameVideoPlayer.finishedCallback = System.fn(self, self.ClosePanel)
  if not cd.SummonItemQualityVideo[self.itemQuality] then
    self:Close()
    return
  end
  gameVideoPlayer:SetLooping(false)
  gameVideoPlayer:OpenMedia(cd.SummonItemQualityVideo[self.itemQuality])
end

function SummonSkinResultNextPanel:ClosePanel()
  self:ShowSkinReward()
  if self.closeCallback then
    self.closeCallback()
  end
  self:Close()
end

function SummonSkinResultNextPanel:OnBtnSkip()
  self:ClosePanel()
end

function SummonSkinResultNextPanel:ShowSkinReward()
  local itemCfg = ItemDataUtils.GetItemConfig(self.itemTid)
  if itemCfg.Type == cd.ItemType.SkinItem then
    local animData = {skipBeginAnim = false}
    local summonSkinData = {
      reason = "",
      skinTid = self.itemTid,
      transData = {}
    }
    SummonDataUtils.ShowGainItems(summonSkinData)
    UIManager.Instance:Reopen(Urls.SummonNewItemPanel, nil, nil, nil, animData, function()
    end)
  end
end

function SummonSkinResultNextPanel:SetSkinLogo()
  local logoGameObj = self.ui.Logo_SR
  if self.itemQuality == cd.CommonQuality.Orange then
    AudioManager.Instance:PostSoundEvent("Play_Anim_Awaking_Unveil_Level_SSR")
    logoGameObj = self.ui.Logo_SSR
  elseif self.itemQuality == cd.CommonQuality.Purple then
    AudioManager.Instance:PostSoundEvent("Play_Anim_Awaking_Unveil_Level_SR")
    logoGameObj = self.ui.Logo_SR
  else
    AudioManager.Instance:PostSoundEvent("Play_Anim_Awaking_Unveil_Level_R")
    logoGameObj = self.ui.Logo_R
  end
  logoGameObj:SetActive(true)
  local itemCfg = DT.Item[self.itemTid]
  if itemCfg and itemCfg.Type == cd.ItemType.SkinItem then
    local skinUI = UI_Summon_Popup_Show_SSRLogoResource(logoGameObj)
    local skinIconCfg = cd.SummonSkinIcon[self.itemQuality] or {}
    local normalIcon = skinIconCfg.Normal
    self.binder:SetImage(skinUI.Popup_Show_Logo01, normalIcon)
    local glowIcon = skinIconCfg.Glow
    self.binder:SetImage(skinUI.glow, glowIcon)
  elseif itemCfg then
    local normalIcon = ""
    local glowIcon = ""
    if itemCfg.Type == cd.ItemType.Weapon then
      normalIcon = cd.SummonItemLogo[self.itemQuality].Normal
      glowIcon = cd.SummonItemLogo[self.itemQuality].Glow
    elseif itemCfg.Type == cd.ItemType.AwakerItem then
      local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(self.itemTid)
      local awakerCfg = DT.AwakerConfig[awakerTid]
      if awakerCfg then
        local schoolCfg = DT.SchoolConfig[awakerCfg.School]
        if schoolCfg then
          local schoolLogo
          if self.itemQuality == cd.CommonQuality.Orange then
            schoolLogo = cd.SummonSchoolLogo[schoolCfg.NameEn].Orange
          elseif self.itemQuality == cd.CommonQuality.Purple then
            schoolLogo = cd.SummonSchoolLogo[schoolCfg.NameEn].Purple
          end
          if schoolLogo then
            normalIcon = schoolLogo.Normal
            glowIcon = schoolLogo.Glow
          end
        end
      end
    end
    local logoRes
    if self.itemQuality == cd.CommonQuality.Orange then
      logoRes = UI_Summon_Popup_Show_SSRLogoResource(logoGameObj)
    elseif self.itemQuality == cd.CommonQuality.Purple then
      logoRes = UI_Summon_Popup_Show_SRLogoResource(logoGameObj)
    else
      logoRes = UI_Summon_Popup_Show_RLogoResource(logoGameObj)
    end
    self.binder:SetImage(logoRes.Popup_Show_Logo01, normalIcon)
    self.binder:SetImage(logoRes.glow, glowIcon)
  end
  local animController = logoGameObj:GetComponent(typeof(UIAnimationController))
  local animationInfoList = animController.animationInfoList
  if 0 == animationInfoList.Count then
    return
  end
  local clipInfo = animationInfoList[0]
  animController:PlayState(clipInfo.clip.name, function()
  end, 1, false)
end

function SummonSkinResultNextPanel:_InitUIElements()
  self.ui.Mainbg:SetActive(false)
  self.ui.VideoMask_Black:SetActive(false)
  self.ui.VideoMask_Mainbg:SetActive(false)
  self.ui.WhiteScreen_R:SetActive(false)
  self.ui.WhiteScreen_SR:SetActive(false)
  self.ui.WhiteScreen_SSR:SetActive(false)
  self.ui.Logo_R:SetActive(false)
  self.ui.Logo_SR:SetActive(false)
  self.ui.Logo_SSR:SetActive(false)
  self.ui.Item_R:SetActive(false)
  self.ui.Item_SR:SetActive(false)
  self.ui.Item_SSR:SetActive(false)
  self.ui.Summon_R:SetActive(false)
  self.ui.Summon_R_Bak:SetActive(false)
  self.binder:SetActive(self.ui.Btn_Share, false)
  self.binder:SetActive(self.ui.UI_Common_Btn_Back3, false)
end

return SummonSkinResultNextPanel
