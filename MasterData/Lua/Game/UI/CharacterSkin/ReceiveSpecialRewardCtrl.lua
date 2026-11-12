local ReceiveSpecialRewardCtrl = class("ReceiveSpecialRewardCtrl", BaseCtrl)
local GachaShowResRoot = "UI/GachaEx/Sprites_Show/"
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResTypeAny = GameResourceLoader.ResType.Any
local ResType = GameResourceLoader.ResType
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local BubbleVoiceManager = require("Game.Actor2D.BubbleVoiceManager")
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local Offset = CS.Actor2DOffsetData
local typeof = _ENV.typeof
ReceiveSpecialRewardCtrl._mapNodeConfig = {
  animatorRoot = {sNodeName = "GachaShow", sComponentName = "Animator"},
  goCharContent = {
    sNodeName = "----Char----",
    sComponentName = "RectTransform"
  },
  BgRare = {
    sComponentName = "SpriteRenderer"
  },
  BgRare1 = {
    sComponentName = "SpriteRenderer"
  },
  rImgL2D = {sComponentName = "RawImage"},
  OffScreen2DCamera = {
    sNodeName = "OffScreen3DCamera",
    sComponentName = "Camera"
  },
  rtSSRWord = {},
  animWord = {sNodeName = "rtSSRWord", sComponentName = "Animator"},
  TMP_Word1 = {sComponentName = "TMP_Text"},
  TMP_Word = {sComponentName = "TMP_Text"},
  goInfoContent = {
    sNodeName = "----Info----"
  },
  animInfoContent = {
    sNodeName = "----Info----",
    sComponentName = "Animator"
  },
  btnJumpAll = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Jump"
  },
  goOutfitContent = {
    sNodeName = "----Outfit----"
  },
  rtItemTips = {},
  imgItemIcon = {sComponentName = "Image"},
  TMP_ItemCount = {sComponentName = "TMP_Text"},
  TMP_ItemTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "GachaItemTIpsTitle"
  },
  imgBgRare = {sComponentName = "Image"},
  imgTitleRare = {sComponentName = "Image"},
  imgTitleBg = {sComponentName = "Image"},
  imgRareIcon = {sComponentName = "Image"},
  TMP_Title = {sComponentName = "TMP_Text"},
  ImgNew = {},
  imgBgOutfit = {sComponentName = "Image"},
  imgOutfit = {sComponentName = "Image"},
  imgOutfitRare = {sComponentName = "Image"},
  liveDiscCtrl = {
    sNodeName = "goLiveDisc",
    sCtrlName = "Game.UI.Disc.LiveDiscCtrl"
  },
  SSROutfitShow = {},
  animSSROutfitShow = {
    sNodeName = "SSROutfitShow",
    sComponentName = "Animator"
  },
  imgBgOutfitShow = {sComponentName = "Image"},
  btnSkipAnim = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SkipAnim"
  },
  imgOutfitMask = {},
  goCGInfoContent = {
    sNodeName = "----CGInfo----"
  },
  animCGInfoContent = {
    sNodeName = "----CGInfo----",
    sComponentName = "Animator"
  },
  TMP_CGTitle = {sComponentName = "TMP_Text"},
  TMP_CGWord = {sComponentName = "TMP_Text"},
  rtOffScreen = {
    sNodeName = "Live2D_OffScreen_Renderer",
    sComponentName = "Transform"
  },
  TMP_CGNew = {
    sComponentName = "TMP_Text",
    sLanguageId = "Receive_Reward_CG"
  },
  actor2dNode = {
    sNodeName = "----Actor2D_Node----",
    sComponentName = "Transform"
  }
}
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
local cgVoiceKey = "unlockCG"

function ReceiveSpecialRewardCtrl:SetStep(nStep)
  self.curStep = nStep
end

function ReceiveSpecialRewardCtrl:ShowReward()
  if #self.tbRewardList == 0 then
    EventManager.Hit(EventId.ClosePanel, PanelId.ReceiveSpecialReward)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      if self.callBack then
        self.callBack()
      end
    end
    
    cs_coroutine.start(wait)
    return
  end
  self._mapNode.btnSkipAnim.interactable = false
  local delayTime = ConfigTable.GetConfigNumber("DelaySkipSpecialRewardTime")
  self:AddTimer(1, delayTime, "DelayEnableSkip", true, true, true)
  local curReward = self.tbRewardList[1]
  self.bCG = curReward.bCG
  if self.bCG then
    local charCGCfg = ConfigTable.GetData("CharacterCG", curReward.nId)
    if charCGCfg == nil then
      printError(string.format("读取CharacterCG配置失败！！！id = [%s]", curReward.nId))
    else
      self:ShowCharCG()
    end
    table.remove(self.tbRewardList, 1)
    return
  end
  local itemCfg = ConfigTable.GetData_Item(curReward.nId)
  self.bNew = curReward.bNew
  self.bChar = itemCfg.Type == GameEnum.itemType.Char or itemCfg.Type == GameEnum.itemType.CharacterSkin
  if itemCfg.Type == GameEnum.itemType.Char then
    local mapCharCfgData = ConfigTable.GetData_Character(curReward.nId)
    local nSkinId = mapCharCfgData.DefaultSkinId
    self.nId = curReward.nId
    self:ShowTitle()
    self:ShowCharSkin(nSkinId, self.bNew)
  elseif itemCfg.Type == GameEnum.itemType.CharacterSkin then
    self.nId = curReward.nId
    self:ShowTitle()
    self:ShowCharSkin(curReward.nId)
    PlayerData.CharSkin:RemoveSkinQueue(curReward.nId)
  elseif itemCfg.Type == GameEnum.itemType.Disc then
    self.nId = curReward.nId
    self:ShowTitle()
    self:ShowOutfit(curReward.nId)
  end
  self:ShowItem(curReward.tbItemList)
  table.remove(self.tbRewardList, 1)
end

function ReceiveSpecialRewardCtrl:ShowCharSkin(nSkinId, bGetNew)
  self:SetStep(1)
  if self.goL2D ~= nil then
    Actor2DManager.UnSetActor2DWithRender(self.goL2D)
    self.goL2D = nil
  end
  self.goL2D = {}
  self._mapNode.goCharContent.gameObject:SetActive(true)
  self._mapNode.goOutfitContent:SetActive(false)
  self._mapNode.goInfoContent:SetActive(false)
  self._mapNode.goCGInfoContent:SetActive(false)
  self._mapNode.btnJumpAll.gameObject:SetActive(false)
  self._mapNode.btnSkipAnim.gameObject:SetActive(true)
  local mapSkinData = ConfigTable.GetData_CharacterSkin(nSkinId)
  self.nCharId = mapSkinData.CharId
  NovaAPI.SetSpriteRendererSprite(self._mapNode.BgRare1, self:LoadPngGacha(mapSkinData.Bg))
  if mapSkinData.L2D ~= nil and mapSkinData.L2D ~= "" then
    local bSetSuccess, nT, nAnimLength, tbRenderer = Actor2DManager.SetActor2DWithRender(PanelId.ReceiveSpecialReward, self._mapNode.rImgL2D, self.nCharId, nSkinId, nil, self._mapNode.actor2dNode)
    self.goL2D = tbRenderer
    local voice = "unlockLook"
    if bGetNew == true then
      voice = "gachaNew"
    elseif bGetNew == false then
      voice = "gacha"
    end
    self._mapNode.rtSSRWord:SetActive(false)
    if mapSkinData.Type ~= GameEnum.skinType.OTHER then
      self:ShowSSRWordEnd(0, voice)
    else
      self:ShowSSRWordEnd(0)
    end
    if self.goL2D.trL2DIns ~= nil then
      Actor2DManager.PlayL2DAnim(self.goL2D.trL2DIns.transform, "idle", true, false)
    end
  end
end

function ReceiveSpecialRewardCtrl:ShowOutfit(nOutfitTid)
  self:SetStep(1)
  self._mapNode.goCharContent.gameObject:SetActive(false)
  self._mapNode.goOutfitContent:SetActive(true)
  self._mapNode.goCGInfoContent:SetActive(false)
  self._mapNode.btnSkipAnim.gameObject:SetActive(true)
  self._mapNode.btnJumpAll.gameObject:SetActive(false)
  local mapItemCfgData = ConfigTable.GetData_Item(nOutfitTid)
  local mapOutfitCfgData = ConfigTable.GetData("Disc", nOutfitTid)
  self._mapNode.imgOutfitMask:SetActive(false)
  self._mapNode.liveDiscCtrl:SetDiscActive(true, mapOutfitCfgData.DiscBg ~= "")
  self._mapNode.liveDiscCtrl:SetRawImage(mapOutfitCfgData.DiscBg, mapItemCfgData.Rarity)
  if mapItemCfgData.Rarity == GameEnum.itemRarity.SSR then
    self:SetPngSprite(self._mapNode.imgBgOutfitShow, mapOutfitCfgData.DiscBg .. AllEnum.DiscBgSurfix.Image)
  end
  self:SetPngSprite(self._mapNode.imgBgOutfit, mapOutfitCfgData.DiscBg .. AllEnum.DiscBgSurfix.Image)
  NovaAPI.SetImageNativeSize(self._mapNode.imgBgOutfit)
  self._mapNode.imgBgOutfit.gameObject:SetActive(true)
  self._mapNode.goInfoContent:SetActive(false)
  if mapItemCfgData.Rarity == GameEnum.itemRarity.SSR and self.bNew then
    self:SetStep(2)
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
end

function ReceiveSpecialRewardCtrl:ShowSSRAnimEndOutfit(_, nRarity)
  self:SetStep(3)
  self._mapNode.SSROutfitShow:SetActive(false)
  self._mapNode.animatorRoot:Play(mapOutfitAnimName[nRarity])
  self.timerStep = self:AddTimer(1, mapOutfitAnimTime[nRarity], "ShowSSRAnimEnd", true, true, nil, nil)
  if nRarity == GameEnum.itemRarity.SSR then
    WwiseAudioMgr:PlaySound("ui_recuit_gacha_disk_SSR_show")
  elseif nRarity == GameEnum.itemRarity.SR then
    WwiseAudioMgr:PlaySound("ui_recuit_gacha_disk_SR_show")
  else
    WwiseAudioMgr:PlaySound("ui_recuit_gacha_N")
  end
end

function ReceiveSpecialRewardCtrl:ShowCharCG()
  self._mapNode.goCharContent.gameObject:SetActive(true)
  self._mapNode.rtSSRWord:SetActive(false)
  self._mapNode.goOutfitContent:SetActive(false)
  self._mapNode.goInfoContent:SetActive(false)
  self._mapNode.imgBgRare.gameObject:SetActive(false)
  self._mapNode.btnJumpAll.gameObject:SetActive(false)
  self._mapNode.btnSkipAnim.gameObject:SetActive(true)
  local curReward = self.tbRewardList[1]
  self.nCharId = curReward.nCharId
  local sAssetPath = ""
  local mapCfg = ConfigTable.GetData("CharacterCG", curReward.nId)
  if nil == mapCfg then
    printError(string.format("读取CharacterCG配置失败！！！id = [%s]", curReward.nId))
  else
    sAssetPath = mapCfg.FullScreenL2D
  end
  self.nId = curReward.nId
  self.bNew = curReward.bNew
  if self.goL2D ~= nil then
    Actor2DManager.UnSetActor2DWithRender(self.goL2D)
    self.goL2D = nil
  end
  local bSetSuccess, nT, nAnimLength, tbRenderer = Actor2DManager.SetActor2DWithRender(PanelId.ReceiveSpecialReward, self._mapNode.rImgL2D, self.nCharId, mapCfg.Id, nil, self._mapNode.actor2dNode, AllEnum.Actor2DType.FullScreen)
  if bSetSuccess then
    self.goL2D = tbRenderer
  end
  local nDuration = 0
  local nId = PlayerData.Voice:PlayCharVoice(cgVoiceKey, curReward.nCharId)
  if nId ~= 0 then
    local mapVoiceCfg = ConfigTable.GetData("VoDirectory", nId)
    if mapVoiceCfg ~= nil then
      local dataText = BubbleVoiceManager.GetBubbleText(mapVoiceCfg.voResource)
      if dataText ~= nil then
        local sContent = dataText[1] .. dataText[2] .. dataText[3] .. dataText[4]
        sContent = string.gsub(sContent, "==RT==", "\n")
        sContent = string.gsub(sContent, "==PLAYER_NAME==", PlayerData.Base:GetPlayerNickName())
        NovaAPI.SetTMPText(self._mapNode.TMP_CGWord, sContent)
      end
    end
  end
  if nDuration <= 0 then
    if self.goL2D ~= nil and self.goL2D.trL2DIns ~= nil then
      Actor2DManager.PlayL2DAnim(self.goL2D.trL2DIns.transform, "idle", true, false)
    end
    self:ShowCGEnd()
  else
    self:AddTimer(1, nDuration, "ShowCGEnd", true, true, true)
  end
  self.callBack = curReward.callBack
end

function ReceiveSpecialRewardCtrl:ShowTitle()
  local mapItemCfgData = ConfigTable.GetData_Item(self.nId)
  NovaAPI.SetTMPText(self._mapNode.TMP_Title, mapItemCfgData.Title)
  local bgSprite = self:LoadPngGacha(GachaShowResRoot .. "bg_gacha_character_" .. AllEnum.FrameColor_New[mapItemCfgData.Rarity])
  NovaAPI.SetImageSpriteAsset(self._mapNode.imgBgRare, bgSprite)
  NovaAPI.SetSpriteRendererSprite(self._mapNode.BgRare, bgSprite)
  NovaAPI.SetImageSpriteAsset(self._mapNode.imgRareIcon, self:LoadPngGacha(GachaShowResRoot .. "rare_character_gacha_" .. AllEnum.FrameColor_New[mapItemCfgData.Rarity]))
  NovaAPI.SetImageNativeSize(self._mapNode.imgRareIcon)
  self._mapNode.ImgNew:SetActive(self.bNew)
  self._mapNode.TMP_Word.gameObject:SetActive(self.bChar)
  if self.bChar then
    NovaAPI.SetImageSpriteAsset(self._mapNode.imgTitleBg, self:LoadPngGacha(GachaShowResRoot .. "zs_gacha_name"))
    NovaAPI.SetImageSpriteAsset(self._mapNode.imgTitleRare, self:LoadPngGacha(GachaShowResRoot .. "zs_gacha_name_" .. AllEnum.FrameColor_New[mapItemCfgData.Rarity]))
  else
    NovaAPI.SetImageSpriteAsset(self._mapNode.imgTitleBg, self:LoadPngGacha(GachaShowResRoot .. "zs_gacha_name_outfit"))
    NovaAPI.SetImageSpriteAsset(self._mapNode.imgTitleRare, self:LoadPngGacha(GachaShowResRoot .. "zs_gacha_name_outfit_" .. AllEnum.FrameColor_New[mapItemCfgData.Rarity]))
  end
end

function ReceiveSpecialRewardCtrl:ShowCGTitle()
  local mapCGCgfData = ConfigTable.GetData("CharacterCG", self.nId)
  if mapCGCgfData == nil then
    printError(string.format("读取CharacterCG配置失败！！！id = [%s]", self.nId))
  else
    NovaAPI.SetTMPText(self._mapNode.TMP_CGTitle, mapCGCgfData.Name)
  end
end

function ReceiveSpecialRewardCtrl:ShowSSRWordEnd(_, voice)
  self._mapNode.rtSSRWord:SetActive(false)
  if self.goL2D.trL2DIns == nil then
    self:ShowSSRAnimEnd(_, voice)
    return
  end
  self._mapNode.animatorRoot:Play("GachaShow_SR")
  self.timerStep = self:AddTimer(1, 1.2, "ShowSSRAnimEnd", true, true, nil, voice)
  local mapCharCfgData = ConfigTable.GetData_Character(self.nCharId)
  if mapCharCfgData ~= nil then
    if mapCharCfgData.Grade == GameEnum.characterGrade.SSR then
      WwiseAudioMgr:PlaySound("ui_recuit_gacha_SSR_show")
    else
      WwiseAudioMgr:PlaySound("ui_recuit_gacha_SR_long")
    end
  end
end

function ReceiveSpecialRewardCtrl:ShowSSRAnimEnd(_, voice)
  self:SetStep(4)
  self._mapNode.TMP_Word.gameObject:SetActive(false)
  if voice ~= nil then
    local nId = PlayerData.Voice:PlayCharVoice(voice, self.nCharId)
    local mapVoiceCfg = ConfigTable.GetData("VoDirectory", nId)
    if mapVoiceCfg ~= nil then
      local dataText = BubbleVoiceManager.GetBubbleText(mapVoiceCfg.voResource)
      if dataText ~= nil then
        self._mapNode.TMP_Word.gameObject:SetActive(true)
        local sContent = dataText[1] .. dataText[2] .. dataText[3] .. dataText[4]
        sContent = string.gsub(sContent, "==RT==", "\n")
        sContent = string.gsub(sContent, "==PLAYER_NAME==", PlayerData.Base:GetPlayerNickName())
        NovaAPI.SetTMPText(self._mapNode.TMP_Word, sContent)
        NovaAPI.SetTMPText(self._mapNode.TMP_Word1, sContent)
      end
    end
  elseif self.bChar then
    if CacheTable.Get("_CharGetLinesBySkinId") == nil or next(CacheTable.Get("_CharGetLinesBySkinId")) == nil then
      local function func_Parse_CharGetLines(mapData)
        if mapData.SkinId ~= 0 then
          CacheTable.SetData("_CharGetLinesBySkinId", mapData.SkinId, mapData)
        end
      end
      
      ForEachTableLine(DataTable.CharGetLines, func_Parse_CharGetLines)
    end
    local mapCfg = CacheTable.GetData("_CharGetLinesBySkinId", self.nId)
    if mapCfg ~= nil then
      self._mapNode.TMP_Word.gameObject:SetActive(true)
      local sContent = mapCfg.Lines
      sContent = string.gsub(sContent, "==RT==", "\n")
      sContent = string.gsub(sContent, "==PLAYER_NAME==", PlayerData.Base:GetPlayerNickName())
      NovaAPI.SetTMPText(self._mapNode.TMP_Word, sContent)
      NovaAPI.SetTMPText(self._mapNode.TMP_Word1, sContent)
    end
  end
  self._mapNode.goInfoContent:SetActive(true)
  self._mapNode.animInfoContent:Play("Info_rtTitle_in")
  local animTime = NovaAPI.GetAnimClipLength(self._mapNode.animInfoContent, {
    "Info_rtTitle_in"
  })
  if self.bNew then
    self:AddTimer(1, 0.4, function()
      WwiseAudioMgr:PlaySound("ui_recuit_gacha_new")
    end, true, true, true)
  end
  self.timerStep = self:AddTimer(1, animTime, "ShowTitleAnimEnd", true, true, true)
end

function ReceiveSpecialRewardCtrl:ShowCGEnd()
  self:ShowCGTitle()
  self._mapNode.goInfoContent:SetActive(false)
  self._mapNode.goCGInfoContent:SetActive(true)
  self._mapNode.animCGInfoContent:Play("CGInfo_in", 0, 0)
  self.bPlaySkipVoice = false
  local animTime = NovaAPI.GetAnimClipLength(self._mapNode.animCGInfoContent, {"CGInfo_in"})
  if self.bNew then
    self:AddTimer(1, 0.4, function()
      WwiseAudioMgr:PlaySound("ui_recuit_gacha_new")
    end, true, true, true)
  end
  self.timerStep = self:AddTimer(1, animTime, "ShowTitleAnimEnd", true, true, true)
end

function ReceiveSpecialRewardCtrl:ShowTitleAnimEnd()
  self:SetStep(5)
  if self.bSkipedAnim == nil or not self.bSkipedAnim then
    self.bSkipedAnim = true
  end
end

function ReceiveSpecialRewardCtrl:ShowItem(tbRewardItem)
  if tbRewardItem ~= nil and 0 < #tbRewardItem then
    local mapRewardItemCfgData = ConfigTable.GetData_Item(tbRewardItem[1].Tid)
    if mapRewardItemCfgData == nil then
      printError("item ID missing：" .. tbRewardItem[1].Tid)
      self._mapNode.rtItemTips:SetActive(false)
    else
      local nRewardItemCount = tbRewardItem[1].Qty
      self._mapNode.rtItemTips:SetActive(true)
      self:SetPngSprite(self._mapNode.imgItemIcon, mapRewardItemCfgData.Icon)
      NovaAPI.SetTMPText(self._mapNode.TMP_ItemCount, string.format("×%d", tostring(nRewardItemCount)))
    end
  else
    self._mapNode.rtItemTips:SetActive(false)
  end
end

function ReceiveSpecialRewardCtrl:DelayEnableSkip()
  self._mapNode.btnSkipAnim.interactable = true
end

function ReceiveSpecialRewardCtrl:OnEnable()
  self._mapNode.rtOffScreen.localScale = Vector3(1 / Settings.CANVAS_SCALE, 1 / Settings.CANVAS_SCALE, 1 / Settings.CANVAS_SCALE)
  self.timerStep = nil
  self.bPlaySkipVoice = true
  self._mapNode.btnSkipAnim.interactable = false
  local tbParam = self:GetPanelParam()
  if nil == tbParam or nil == tbParam[1] then
    return
  end
  self.tbRewardList = tbParam[1]
  self.callBack = tbParam[2]
  self:ShowReward()
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.EnableGamepadUI("ReceiveSpecialRewardCtrl", self:GetGamepadUINode(), nil, true)
  end
end

function ReceiveSpecialRewardCtrl:OnDisable()
  NovaAPI.SetTexture(self._mapNode.rImgL2D, nil)
  if self.goL2D ~= nil then
    Actor2DManager.UnSetActor2DWithRender(self.goL2D)
    self.goL2D = nil
  end
  if self.bCG then
    EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_ChooseHomePageRole")
  end
  EventManager.Hit("CharRefreshActor2D")
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.DisableGamepadUI("ReceiveSpecialRewardCtrl")
  end
end

function ReceiveSpecialRewardCtrl:LoadPngGacha(sPath)
  return self:LoadAsset(sPath .. ".png", typeof(Sprite))
end

function ReceiveSpecialRewardCtrl:LoadOffset(sPath)
  return self:LoadAsset(sPath, typeof(Offset))
end

function ReceiveSpecialRewardCtrl:OnBtnClick_Jump()
  WwiseAudioMgr:WwiseVoice_Stop(2)
  self._mapNode.animatorRoot.speed = 1
  self._mapNode.animInfoContent.speed = 1
  self:ShowReward()
end

function ReceiveSpecialRewardCtrl:OnBtnClick_SkipAnim(btn)
  if self.bSkipedAnim then
    self.bSkipedAnim = false
    self:OnBtnClick_Jump()
  else
    if self.curStep == 4 then
      self._mapNode.animatorRoot.speed = 1000
      if self.bCG then
        self._mapNode.animCGInfoContent.speed = 1000
      else
        self._mapNode.animInfoContent.speed = 1000
      end
    end
    if self.curStep ~= 5 and self.timerStep ~= nil then
      self.timerStep:Cancel(true)
      return
    end
  end
end

return ReceiveSpecialRewardCtrl
