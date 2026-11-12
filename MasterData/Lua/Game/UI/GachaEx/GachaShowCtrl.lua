local GachaShowCtrl = class("GachaShowCtrl", BaseCtrl)
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResTypeAny = GameResourceLoader.ResType.Any
local ResType = GameResourceLoader.ResType
local WwiseManger = CS.WwiseAudioManager
local GachaShowResRoot = "UI/GachaEx/Sprites_Show/"
local PlayablesPlayStatePlaying = CS.UnityEngine.Playables.PlayState.Playing
local Offset = CS.Actor2DOffsetData
local typeof = _ENV.typeof
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local BubbleVoiceManager = require("Game.Actor2D.BubbleVoiceManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local mapOutfitAnimName = {
  [1] = "GachaShow_Outfit_SSR",
  [2] = "GachaShow_Outfit_SR",
  [3] = "GachaShow_Outfit_R",
  [4] = "GachaShow_Outfit_N",
  [5] = "GachaShow_Outfit_N"
}
local mapOutfitAnimTime = {
  [1] = 0.6,
  [2] = 0.6,
  [3] = 0.6,
  [4] = 0.6,
  [5] = 0.6
}
GachaShowCtrl._mapNodeConfig = {
  imgBgRare = {sComponentName = "Image"},
  BgRare = {
    sComponentName = "SpriteRenderer"
  },
  BgRare1 = {
    sComponentName = "SpriteRenderer"
  },
  goCharContent = {
    sNodeName = "----Char----",
    sComponentName = "RectTransform"
  },
  rImgL2D = {sComponentName = "RawImage"},
  OffScreen2DCamera = {
    sNodeName = "OffScreen3DCamera",
    sComponentName = "Camera"
  },
  L2DRoot = {sNodeName = "L2D", sComponentName = "Transform"},
  rtSSRWord = {},
  TMP_Word1 = {sComponentName = "TMP_Text"},
  goOutfitContent = {
    sNodeName = "----Outfit----"
  },
  imgBgOutfit = {sComponentName = "Image"},
  imgOutfit = {sComponentName = "Image"},
  imgOutfitRare = {sComponentName = "Image"},
  goInfoContent = {
    sNodeName = "----Info----"
  },
  animInfoContent = {
    sNodeName = "----Info----",
    sComponentName = "Animator"
  },
  rtItemTips = {},
  imgItemIcon = {sComponentName = "Image"},
  TMP_ItemCount = {sComponentName = "TMP_Text"},
  TMP_ItemTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "GachaItemTIpsTitle"
  },
  rtItemTips2 = {},
  imgItemIcon2 = {sComponentName = "Image"},
  TMP_ItemCount2 = {sComponentName = "TMP_Text"},
  TMP_ItemTitle2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_GiveItemTitle"
  },
  imgTitleRare = {sComponentName = "Image"},
  imgTitleBg = {sComponentName = "Image"},
  imgRareIcon = {sComponentName = "Image"},
  TMP_Title = {sComponentName = "TMP_Text"},
  TMP_Word = {sComponentName = "TMP_Text"},
  ImgNew = {},
  btnJumpStep = {
    sComponentName = "Button",
    callback = "OnBtnClick_JumpStep"
  },
  btnJumpAll = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_JumpAll"
  },
  animWord = {sNodeName = "rtSSRWord", sComponentName = "Animator"},
  SSROutfitShow = {},
  animSSROutfitShow = {
    sNodeName = "SSROutfitShow",
    sComponentName = "Animator"
  },
  imgBgOutfitShow = {sComponentName = "Image"},
  imgOutfitMask = {},
  liveDiscCtrl = {
    sNodeName = "goLiveDisc",
    sCtrlName = "Game.UI.Disc.LiveDiscCtrl"
  },
  rtOffScreen = {
    sNodeName = "Live2D_OffScreen_Renderer",
    sComponentName = "Transform"
  },
  rtTitle = {
    sComponentName = "CanvasGroup"
  },
  actor2dNode = {
    sNodeName = "----Actor2D_Node----",
    sComponentName = "Transform"
  },
  rtPreviewShow = {
    sNodeName = "---ShowPreview---"
  },
  rtPreviewItems = {
    sNodeName = "rtPreviewItem_",
    nCount = 10
  }
}
GachaShowCtrl._mapEventConfig = {}

function GachaShowCtrl:Awake()
end

function GachaShowCtrl:FadeIn()
end

function GachaShowCtrl:FadeOut()
end

function GachaShowCtrl:OnEnable()
  self.animatorRoot = self.gameObject:GetComponent("Animator")
  self.gameObject:SetActive(false)
  self._mapNode.rtPreviewShow:SetActive(false)
  self._mapNode.rtOffScreen.localScale = Vector3(1 / Settings.CANVAS_SCALE, 1 / Settings.CANVAS_SCALE, 1 / Settings.CANVAS_SCALE)
  self.timerStep = nil
end

function GachaShowCtrl:OnDisable()
  self._mapNode.OffScreen2DCamera.targetTexture = nil
  NovaAPI.SetTexture(self._mapNode.rImgL2D, nil)
  if self.rtCharL2d ~= nil then
    GameUIUtils.ReleaseRenderTexture(self.rtCharL2d)
    self.rtCharL2d = nil
  end
  if self.goL2D ~= nil then
    if self.goL2D.trL2DIns ~= nil then
      Actor2DManager.UnSetActor2DWithRender(self.goL2D)
    end
    self.goL2D = nil
  end
end

function GachaShowCtrl:OnDestroy()
end

function GachaShowCtrl:OnRelease()
end

function GachaShowCtrl:ShowPreview()
  self._mapNode.rtPreviewShow:SetActive(true)
  for i = 1, 10 do
    if self.tbItems[i] == nil then
      self._mapNode.rtPreviewItems[i]:SetActive(false)
    else
      self._mapNode.rtPreviewItems[i]:SetActive(true)
      local mapItemCfgData = ConfigTable.GetData_Item(self.tbItems[i].id)
      if mapItemCfgData == nil then
        self._mapNode.rtPreviewItems[i]:SetActive(false)
      else
        local rtR = self._mapNode.rtPreviewItems[i].transform:Find("imgR")
        local rtSR = self._mapNode.rtPreviewItems[i].transform:Find("imgSR")
        local rtSSR = self._mapNode.rtPreviewItems[i].transform:Find("imgSSR")
        if rtR ~= nil then
          rtR.gameObject:SetActive(mapItemCfgData.Rarity > 2)
        end
        if rtSR ~= nil then
          rtSR.gameObject:SetActive(mapItemCfgData.Rarity == 2)
        end
        if rtSSR ~= nil then
          rtSSR.gameObject:SetActive(mapItemCfgData.Rarity == 1)
        end
      end
    end
  end
end

function GachaShowCtrl:ShowResults(tbItems, mapTrans)
  self.tbItems = tbItems
  self.curIdx = 1
  self.bJumpAll = false
  self.bShowPreview = false
  
  local function ShowResult()
    self.showPreviewTimer = nil
    self.bShowPreview = false
    self._mapNode.rtPreviewShow:SetActive(false)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.rtTitle, 1)
    if self.bJumpAll then
      self.curIdx = 0
      self:OnBtnClick_JumpAll()
    else
      self:ShowItem(self.tbItems[self.curIdx])
    end
  end
  
  local function ShowPreview()
    self:ShowPreview()
    self.showPreviewTimer = self:AddTimer(1, 1, ShowResult, true, true, true)
    self.bShowPreview = true
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if 1 < #tbItems then
      ShowPreview()
    else
      ShowResult()
    end
  end
  
  self.gameObject:SetActive(true)
  cs_coroutine.start(wait)
end

function GachaShowCtrl:ShowItem(mapItem)
  self.curStep = 1
  self.nTid = mapItem.id
  self.bNew = mapItem.bNew
  local mapItemCfgData = ConfigTable.GetData_Item(mapItem.id)
  self.bChar = mapItemCfgData.Type == GameEnum.itemType.Char
  if mapItem.rewardItem ~= nil and #mapItem.rewardItem > 0 then
    local mapRewardItemCfgData = ConfigTable.GetData_Item(mapItem.rewardItem[1].Tid)
    if mapRewardItemCfgData == nil then
      printError("item ID missing：" .. mapItem.rewardItem[1].Tid)
      self._mapNode.rtItemTips:SetActive(false)
    else
      local nRewardItemCount = mapItem.rewardItem[1].Qty
      self._mapNode.rtItemTips:SetActive(true)
      self:SetPngSprite(self._mapNode.imgItemIcon, mapRewardItemCfgData.Icon)
      NovaAPI.SetTMPText(self._mapNode.TMP_ItemCount, string.format("×%d", tostring(nRewardItemCount)))
    end
  else
    self._mapNode.rtItemTips:SetActive(false)
  end
  if mapItem.exItem ~= nil and 0 < #mapItem.exItem then
    local mapRewardItemCfgData = ConfigTable.GetData_Item(mapItem.exItem[1].Tid)
    if mapRewardItemCfgData == nil then
      printError("item ID missing：" .. mapItem.exItem[1].Tid)
      self._mapNode.rtItemTips2:SetActive(false)
    else
      local nRewardItemCount = mapItem.exItem[1].Qty
      self._mapNode.rtItemTips2:SetActive(true)
      self:SetPngSprite(self._mapNode.imgItemIcon2, mapRewardItemCfgData.Icon)
      NovaAPI.SetTMPText(self._mapNode.TMP_ItemCount2, string.format("×%d", tostring(nRewardItemCount)))
    end
  else
    self._mapNode.rtItemTips2:SetActive(false)
  end
  if self.bChar or mapItemCfgData.Rarity == GameEnum.itemRarity.SSR then
    WwiseManger.Instance:SetState("recruit_rarity", "SSR")
  else
    WwiseManger.Instance:SetState("recruit_rarity", "R")
  end
  NovaAPI.SetTMPText(self._mapNode.TMP_Title, mapItemCfgData.Title)
  local bgSprite = self:LoadPngGacha(GachaShowResRoot .. "bg_gacha_character_" .. AllEnum.FrameColor_New[mapItemCfgData.Rarity])
  NovaAPI.SetImageSpriteAsset(self._mapNode.imgBgRare, bgSprite)
  NovaAPI.SetSpriteRendererSprite(self._mapNode.BgRare, bgSprite)
  NovaAPI.SetImageSpriteAsset(self._mapNode.imgRareIcon, self:LoadPngGacha(GachaShowResRoot .. "rare_character_gacha_" .. AllEnum.FrameColor_New[mapItemCfgData.Rarity]))
  if self.bChar then
    NovaAPI.SetImageSpriteAsset(self._mapNode.imgTitleBg, self:LoadPngGacha(GachaShowResRoot .. "zs_gacha_name"))
    NovaAPI.SetImageSpriteAsset(self._mapNode.imgTitleRare, self:LoadPngGacha(GachaShowResRoot .. "zs_gacha_name_" .. AllEnum.FrameColor_New[mapItemCfgData.Rarity]))
  else
    NovaAPI.SetImageSpriteAsset(self._mapNode.imgTitleBg, self:LoadPngGacha(GachaShowResRoot .. "zs_gacha_name_outfit"))
    NovaAPI.SetImageSpriteAsset(self._mapNode.imgTitleRare, self:LoadPngGacha(GachaShowResRoot .. "zs_gacha_name_outfit_" .. AllEnum.FrameColor_New[mapItemCfgData.Rarity]))
  end
  NovaAPI.SetImageNativeSize(self._mapNode.imgRareIcon)
  self._mapNode.ImgNew:SetActive(self.bNew)
  if self.bChar then
    self:SetCharacter(mapItem.id)
  else
    NovaAPI.SetTMPText(self._mapNode.TMP_Word, "")
    self:SetOutfit(mapItem.id)
  end
end

function GachaShowCtrl:LoadPngGacha(sPath)
  return self:LoadAsset(sPath .. ".png", typeof(Sprite))
end

function GachaShowCtrl:LoadOffset(sPath)
  return self:LoadAsset(sPath, typeof(Offset))
end

function GachaShowCtrl:SetOutfit(nOutfitTid)
  self._mapNode.goCharContent.gameObject:SetActive(false)
  self._mapNode.goOutfitContent:SetActive(true)
  local mapItemCfgData = ConfigTable.GetData_Item(nOutfitTid)
  local mapOutfitCfgData = ConfigTable.GetData("Disc", nOutfitTid)
  self._mapNode.imgOutfitMask:SetActive(false)
  self._mapNode.liveDiscCtrl:SetDiscActive(true, mapOutfitCfgData.DiscBg ~= "")
  self._mapNode.liveDiscCtrl:SetRawImage(mapOutfitCfgData.DiscBg, mapItemCfgData.Rarity)
  self._mapNode.liveDiscCtrl:SetClickCallback(function()
    self:OnBtnClick_JumpStep()
  end)
  if mapItemCfgData.Rarity == GameEnum.itemRarity.SSR then
    self:SetPngSprite(self._mapNode.imgBgOutfitShow, mapOutfitCfgData.DiscBg .. AllEnum.DiscBgSurfix.Image)
  end
  self:SetPngSprite(self._mapNode.imgBgOutfit, mapOutfitCfgData.DiscBg .. AllEnum.DiscBgSurfix.Image)
  self._mapNode.imgBgOutfit.gameObject:SetActive(true)
  NovaAPI.SetImageNativeSize(self._mapNode.imgBgOutfit)
  self._mapNode.goInfoContent:SetActive(false)
  if mapItemCfgData.Rarity == GameEnum.itemRarity.SSR and self.bNew then
    self._mapNode.SSROutfitShow:SetActive(true)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      self._mapNode.animSSROutfitShow:Play("SSROutfitShow_in")
      WwiseAudioMgr:PlaySound("ui_recuit_gacha_disk_SSR_glass")
    end
    
    cs_coroutine.start(wait)
    self.timerStep = self:AddTimer(1, 2.7, "ShowSSRAnimEndOutfit", true, true, nil, mapItemCfgData.Rarity)
  else
    self:ShowSSRAnimEndOutfit(0, mapItemCfgData.Rarity)
  end
  self:BlockJump(0.5)
end

function GachaShowCtrl:SetCharacter(nCharTid)
  if self.goL2D ~= nil then
    if self.goL2D.trL2DIns ~= nil then
      Actor2DManager.UnSetActor2DWithRender(self.goL2D)
    end
    self.goL2D = nil
  end
  self._mapNode.goCharContent.gameObject:SetActive(true)
  self._mapNode.goOutfitContent:SetActive(false)
  self._mapNode.goInfoContent:SetActive(false)
  local mapCharCfgData = ConfigTable.GetData_Character(nCharTid)
  local mapSkinData = ConfigTable.GetData_CharacterSkin(mapCharCfgData.DefaultSkinId)
  NovaAPI.SetSpriteRendererSprite(self._mapNode.BgRare1, self:LoadPngGacha(mapSkinData.Bg))
  local sPath = string.format("Actor2D/Character/%d/atlas_png/a/%d_001.png", mapCharCfgData.DefaultSkinId, mapCharCfgData.DefaultSkinId)
  if mapSkinData.L2D ~= nil and mapSkinData.L2D ~= "" then
    local bSetSuccess, nT, nAnimLength, tbRenderer = Actor2DManager.SetActor2DWithRender(PanelId.GachaSpin, self._mapNode.rImgL2D, nCharTid, mapCharCfgData.DefaultSkinId, nil, self._mapNode.actor2dNode)
    self.goL2D = tbRenderer
    local voice = "gachaNew"
    if not self.bNew then
      voice = "gacha"
    end
    local nId = PlayerData.Voice:PlayCharVoice(voice, nCharTid)
    local mapVoiceCfgData = ConfigTable.GetData("VoDirectory", nId)
    if nil ~= mapVoiceCfgData then
      local tbStr = BubbleVoiceManager.GetBubbleText(mapVoiceCfgData.voResource)
      local str = ""
      if tbStr ~= nil then
        str = tbStr[1] .. tbStr[2] .. tbStr[3] .. tbStr[4]
        str = string.gsub(str, "==RT==", "\n")
        str = string.gsub(str, "==PLAYER_NAME==", PlayerData.Base:GetPlayerNickName())
      end
      NovaAPI.SetTMPText(self._mapNode.TMP_Word, str)
    end
    if mapCharCfgData.Grade == GameEnum.characterGrade.SSR then
      self._mapNode.rtSSRWord:SetActive(true)
      self._mapNode.animWord:Play("SSRWord_in")
      WwiseAudioMgr:PlaySound("ui_recuit_gacha_SSR_glass")
      self.timerStep = self:AddTimer(1, 1.7, "ShowSSRWordEnd", true, true, true, nil)
      self:BlockJump(0.5)
      if mapVoiceCfgData ~= nil then
        local tbStr = BubbleVoiceManager.GetBubbleText(mapVoiceCfgData.voResource)
        local str = ""
        if tbStr ~= nil then
          str = tbStr[1] .. tbStr[2] .. tbStr[3] .. tbStr[4]
          str = string.gsub(str, "==RT==", "\n")
          str = string.gsub(str, "==PLAYER_NAME==", PlayerData.Base:GetPlayerNickName())
        end
        NovaAPI.SetTMPText(self._mapNode.TMP_Word1, str)
      end
    else
      self._mapNode.rtSSRWord:SetActive(false)
      self:ShowSSRWordEnd(0, nId)
    end
    if self.goL2D ~= nil and self.goL2D.trL2DIns ~= nil then
      Actor2DManager.PlayL2DAnim(self.goL2D.trL2DIns.transform, "idle", true, false)
    end
  end
end

function GachaShowCtrl:ShowSSRWordEnd(_, nId)
  self:BlockJump(1.2)
  self._mapNode.rtSSRWord:SetActive(false)
  local mapCharCfgData = ConfigTable.GetData_Character(self.nTid)
  if self.goL2D.trL2DIns == nil or mapCharCfgData == nil then
    self._mapNode.goInfoContent:SetActive(true)
    self.curStep = 3
    return
  end
  if mapCharCfgData.Grade == GameEnum.characterGrade.SSR then
    self.animatorRoot:Play("GachaShow_SSR")
    WwiseAudioMgr:PlaySound("ui_recuit_gacha_SSR_show")
    self.timerStep = self:AddTimer(1, 0.6, "ShowSSRAnimEnd", true, true, nil, nil)
  else
    WwiseAudioMgr:PlaySound("ui_recuit_gacha_SR_long")
    self.animatorRoot:Play("GachaShow_SR")
    self.timerStep = self:AddTimer(1, 1.2, "ShowSSRAnimEnd", true, true, nil, nId)
    goto lbl_75
    self._mapNode.goInfoContent:SetActive(true)
    self.curStep = 3
  end
  ::lbl_75::
end

function GachaShowCtrl:ShowSSRAnimEnd(_, nId)
  self:BlockJump(1)
  if nId ~= nil then
    local mapVoiceCfgData = ConfigTable.GetData("VoDirectory", nId)
    if mapVoiceCfgData ~= nil then
      local tbStr = BubbleVoiceManager.GetBubbleText(mapVoiceCfgData.voResource)
      local str = ""
      if tbStr ~= nil then
        str = tbStr[1] .. tbStr[2] .. tbStr[3] .. tbStr[4]
        str = string.gsub(str, "==RT==", "\n")
        str = string.gsub(str, "==PLAYER_NAME==", PlayerData.Base:GetPlayerNickName())
      end
      NovaAPI.SetTMPText(self._mapNode.TMP_Word, str)
      NovaAPI.SetTMPText(self._mapNode.TMP_Word1, str)
    end
  end
  self._mapNode.goInfoContent:SetActive(true)
  self._mapNode.animInfoContent:Play("Info_rtTitle_in")
  if self.bNew then
    self:AddTimer(1, 0.4, function()
      WwiseAudioMgr:PlaySound("ui_recuit_gacha_new")
    end, true, true, true)
  end
  self.curStep = 3
end

function GachaShowCtrl:ShowSSRAnimEndOutfit(_, nRarity)
  self:BlockJump(0.5)
  self._mapNode.SSROutfitShow:SetActive(false)
  self.curStep = 2
  self.animatorRoot:Play(mapOutfitAnimName[nRarity])
  self.timerStep = self:AddTimer(1, mapOutfitAnimTime[nRarity], "ShowSSRAnimEnd", true, true, nil, nil)
  if nRarity == GameEnum.itemRarity.SSR then
    WwiseAudioMgr:PlaySound("ui_recuit_gacha_disk_SSR_show")
  elseif nRarity == GameEnum.itemRarity.SR then
    WwiseAudioMgr:PlaySound("ui_recuit_gacha_disk_SR_show")
  else
    WwiseAudioMgr:PlaySound("ui_recuit_gacha_N")
  end
end

function GachaShowCtrl:OnBtnClick_JumpStep()
  if self.bBlockJump or self.bShowPreview then
    return
  end
  print("jump step")
  WwiseAudioMgr:WwiseVoice_Stop(2)
  if self.curStep ~= 3 then
    self.timerStep:Cancel(true)
    return
  end
  if self.bJumpAll then
    self:OnBtnClick_JumpAll()
    return
  end
  if self.curIdx == #self.tbItems then
    self.gameObject:SetActive(false)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.rtTitle, 0)
    if self.goL2D ~= nil then
      if self.goL2D.trL2DIns ~= nil then
        Actor2DManager.UnSetActor2DWithRender(self.goL2D)
      end
      self.goL2D = nil
    end
    WwiseManger.Instance:SetState("recruit_rarity", "R")
    EventManager.Hit("GachaShowItemEnd")
    NovaAPI.SetImageSpriteAsset(self._mapNode.imgBgOutfit, nil)
    NovaAPI.SetImageSpriteAsset(self._mapNode.imgOutfit, nil)
    NovaAPI.SetImageSpriteAsset(self._mapNode.imgOutfitRare, nil)
    self._mapNode.liveDiscCtrl:ReleaseRawImage()
    self._mapNode.liveDiscCtrl:ClearClickCallback()
    if self.goL2D ~= nil then
      if self.goL2D.trL2DIns ~= nil then
        Actor2DManager.UnSetActor2DWithRender(self.goL2D)
      end
      self.goL2D = nil
    end
  else
    self.curIdx = self.curIdx + 1
    self:ShowItem(self.tbItems[self.curIdx])
  end
end

function GachaShowCtrl:OnBtnClick_JumpAll()
  if self.bBlockJump then
    return
  end
  if self.bShowPreview and self.showPreviewTimer ~= nil then
    self.bJumpAll = true
    self.showPreviewTimer:Cancel(true)
    return
  end
  print("Jump all")
  WwiseAudioMgr:WwiseVoice_Stop(2)
  self.bJumpAll = true
  if self.timerStep ~= nil then
    local bStep = self.curStep ~= 3
    self.timerStep:Cancel(bStep)
    if bStep then
      return
    end
  end
  for i = self.curIdx + 1, #self.tbItems do
    local mapItemCfgData = ConfigTable.GetData_Item(self.tbItems[i].id)
    if self.tbItems[i].bForceJump ~= true and (mapItemCfgData.Rarity == GameEnum.itemRarity.SSR or self.tbItems[i].bNew and mapItemCfgData.Rarity ~= GameEnum.itemRarity.R) then
      self.curIdx = i
      self:ShowItem(self.tbItems[self.curIdx])
      return
    end
  end
  self.gameObject:SetActive(false)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.rtTitle, 0)
  if self.goL2D ~= nil then
    if self.goL2D.trL2DIns ~= nil then
      Actor2DManager.UnSetActor2DWithRender(self.goL2D)
    end
    self.goL2D = nil
  end
  WwiseManger.Instance:SetState("recruit_rarity", "R")
  EventManager.Hit("GachaShowItemEnd")
  NovaAPI.SetImageSpriteAsset(self._mapNode.imgBgOutfit, nil)
  NovaAPI.SetImageSpriteAsset(self._mapNode.imgOutfit, nil)
  NovaAPI.SetImageSpriteAsset(self._mapNode.imgOutfitRare, nil)
  self._mapNode.liveDiscCtrl:ReleaseRawImage()
  self._mapNode.liveDiscCtrl:ClearClickCallback()
  if self.goL2D ~= nil then
    if self.goL2D.trL2DIns ~= nil then
      Actor2DManager.UnSetActor2DWithRender(self.goL2D)
    end
    self.goL2D = nil
  end
end

function GachaShowCtrl:BlockJump(nTime)
  self.bBlockJump = true
  
  local function unBlockJump()
    self.bBlockJump = false
  end
  
  self:AddTimer(1, nTime, unBlockJump, true, true, nil, nil)
end

return GachaShowCtrl
