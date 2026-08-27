local UIGetHero = class("UIGetHero", UIBaseWindow)
local base = UIBaseWindow
local UINHeroCardConvert = require("Game.CommonUI.Hero.New.UINHeroCardConvert")
local cs_ResLoader = CS.ResLoader
local cs_ParticleSystem = CS.UnityEngine.ParticleSystem
local cs_MovieManager = CS.MovieManager.Instance
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_PlayState = CS.UnityEngine.Playables.PlayState
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local SkinEnum = require("Game.Skin.SkinEnum")
local util = require("XLua.Common.xlua_util")
local eSkipMode = {
  None = 1,
  SkipOldHero = 2,
  NotNewStar3 = 3
}
local heroNameEffColor = {
  [3] = Color.New(1, 0.671, 0.476, 1),
  [2] = Color.New(0.798, 0.561, 1, 1),
  [1] = Color.New(0.524, 0.746, 1, 1)
}
local m_moviePlayer

local function HeroIdTo4Hex(id)
  local out = string.format("%X", id)
  local len = string.len(out)
  if len < 4 then
    for i = 1, 4 - len do
      out = "0" .. out
    end
  elseif 4 < len then
    out = string.sub(out, len - 3)
  end
  return "#" .. out
end

function UIGetHero:OnInit()
  self.resloader = cs_ResLoader.Create()
  self.resloader:LoadABAssetAsync(ItemEffPatch.greetBlastThenLoop)
  self.TagList = {}
  table.insert(self.TagList, self.ui.tagItem)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Skip, self, self.OnClickSkip)
  local codeActionBinding = self.ui.ui_timeline:FindComponent(eUnityComponentID.CodeActionBinding)
  codeActionBinding:RegisterAction("ZoomOut", BindCallback(self, self._OnCamZoomOut))
  codeActionBinding:RegisterAction("StarVoice1", BindCallback(self, self._OnStarVoice, 1))
  codeActionBinding:RegisterAction("StarVoice2", BindCallback(self, self._OnStarVoice, 2))
  codeActionBinding:RegisterAction("StarVoice3", BindCallback(self, self._OnStarVoice, 3))
  codeActionBinding:RegisterAction("StarVoice4", BindCallback(self, self._OnStarVoice, 4))
  codeActionBinding:RegisterAction("StarVoice5", BindCallback(self, self._OnStarVoice, 5))
  codeActionBinding:RegisterAction("ConvertTween", BindCallback(self, self._OnConvertTween))
  self.auBack_StarDic = {}
  self.ui.heroConvertItem:SetActive(false)
  self.cardConvertItemPool = UIItemPool.New(UINHeroCardConvert, self.ui.heroConvertItem)
  self.skipMode = eSkipMode.None
  UIManager.UICamera.fieldOfView = 90
end

function UIGetHero:SetCustomVoiceType(type)
  self.__customVoiceType = type
end

function UIGetHero:SetGetHeroConvertFrag(upHeroFragDic)
  self._convertFrag = true
  self._upHeroFragDic = upHeroFragDic
end

function UIGetHero:InitGetHeroList(heroIdList, useHeroData, withGetHeroSound, newHeroIndexDic, closeFunc, skipOldHero, newSkinIdDic)
  if #heroIdList < 1 then
    return
  end
  self.ui.btn_Skip.gameObject:SetActive(not useHeroData)
  self.withGetHeroSound = withGetHeroSound
  self.haveNext = true
  self.heroIdList = heroIdList
  self.useHeroData = useHeroData
  self.newHeroIndexDic = newHeroIndexDic
  self.newSkinIdDic = newSkinIdDic
  self.showIndex = 1
  if skipOldHero then
    self.skipMode = eSkipMode.SkipOldHero
  end
  self.allTweens = self.transform:GetComponentsInChildren(typeof(CS.DG.Tweening.DOTweenAnimation))
  self:SetCloseFunction(closeFunc)
  self:_TryShowNext()
end

function UIGetHero:_TryShowNext()
  self.__tempPlayAllTween = nil
  self:_StopCampAudio()
  self:_ReturnMovie()
  self:_StopAllAudio()
  if self.haveNext then
    self:ShowNext()
  else
    self:_OnComplete()
  end
end

function UIGetHero:ShowNext()
  self:_StopHeroVoice()
  self.ui.ui_timeline:Stop()
  self.isNew = self.newHeroIndexDic ~= nil and self.newHeroIndexDic[self.showIndex] or false
  local heroId = self.heroIdList[self.showIndex]
  local heroCfg = ConfigData.hero_data[heroId]
  if heroCfg == nil then
    error("hero cfg is null,id:" .. tostring(heroId))
    return
  end
  local rankCfg = ConfigData.hero_rank[heroCfg.rank]
  if rankCfg == nil then
    error("Can't find rankCfg, id = " .. tostring(heroCfg.rank))
    return
  end
  local heroStar = rankCfg.star
  self.ui.btn_Skip.gameObject:SetActive(not self.useHeroData and not self.isNew)
  local skip = false
  if self.skipMode == eSkipMode.SkipOldHero then
    skip = not self.isNew
  elseif self.skipMode == eSkipMode.NotNewStar3 then
    skip = not self.isNew or heroStar < 6
  end
  if not skip then
    local newSkinId
    if self.newSkinIdDic ~= nil then
      newSkinId = self.newSkinIdDic[heroId]
    end
    self:_InitGetHero(heroId, self.isNew, newSkinId)
    self.isSkipAllTween = false
  end
  self.showIndex = self.showIndex + 1
  if self.showIndex > #self.heroIdList then
    self.haveNext = false
  end
  if skip then
    self:_TryShowNext()
  end
end

function UIGetHero:_InitGetHero(heroId, isNew, newSkinId)
  self.curHeroId = heroId
  local heroData, heroCfg
  if self.useHeroData then
    heroData = PlayerDataCenter:GetHeroData(heroId)
    heroCfg = heroData.heroCfg
  else
    heroCfg = ConfigData.hero_data[heroId]
  end
  self.cardConvertItemPool:HideAll()
  if isNew then
    self.ui.img_movie_bg.color = Color.New(0, 0, 0, 1)
    self.__tempPlayAllTween = self.PlayAllTween
    self.movieCB = BindCallback(self, function(table)
      if table.__tempPlayAllTween ~= nil then
        table.__tempPlayAllTween(table)
        table.__tempPlayAllTween = nil
      end
    end)
    local camCfg = ConfigData.camp[heroCfg.camp]
    if camCfg == nil then
      error("camp cfg is null,id:" .. tostring(heroCfg.camp))
      return
    end
    if string.IsNullOrEmpty(camCfg.camp_video_path) then
      error("camp gethero_path is null,id:" .. tostring(heroCfg.camp))
    end
    local videoname = PathConsts:GetHeroVideoPath(camCfg.camp_video_path)
    m_moviePlayer = cs_MovieManager:GetMoviePlayer()
    m_moviePlayer:SetVideoRender(self.ui.img_movie)
    m_moviePlayer:PlayVideo(videoname)
    m_moviePlayer:SetVideoFadeInoutPercent(0.4, self.movieCB)
    self.auBack_camp = AudioManager:PlayAudioById(camCfg.camp_audio, function()
      self.auBack_camp = nil
    end)
  else
    if not self.useHeroData then
      self:_HeroConvert(heroCfg)
    end
    self:PlayAllTween()
  end
  self:_ExtraHeroFrag(heroCfg)
  for index, com in ipairs(self.ui.isNews) do
    com.enabled = isNew
  end
  self.ui.tex_HeroID_Big.text = HeroIdTo4Hex(heroId)
  self.ui.tex_HeroID_Small.text = HeroIdTo4Hex(heroId)
  local campCfg = ConfigData.camp[heroCfg.camp]
  local campIcon = LanguageUtil.GetLocaleText(campCfg.icon)
  self.resloader:LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon), function(texture)
    if IsNull(self.transform) then
      return
    end
    self.ui.img_Camp.texture = texture
  end)
  if newSkinId ~= nil then
    local skinCfg = ConfigData.skin[newSkinId]
    local resModelCfg = ControllerManager:GetController(ControllerTypeId.Skin, true):GetResModel(heroId, skinCfg ~= nil and skinCfg.id or nil)
    local resPath = PathConsts:GetCharacterLive2DPath(resModelCfg.src_id_pic, SkinEnum.fromWhere.getSkin)
    local isHaveL2D = PlayerDataCenter.skinData:IsHaveL2d(skinCfg.id)
    local isLocked = skinCfg ~= nil and HeroCubismInteration.JudgeL2DLocked(skinCfg.id)
    if isHaveL2D and not isLocked then
      self:__LoadLive2D(resPath, skinCfg)
    else
      self:__LoadPic(PathConsts:GetCharacterBigImgPrefabPath(resModelCfg.src_id_pic, SkinEnum.fromWhere.getSkin))
    end
  else
    local resCfg = ConfigData.resource_model[heroCfg.src_id]
    if resCfg == nil then
      error("resource model Cfg is null,id:" .. tostring(heroCfg.src_id))
    end
    self:__LoadPic(PathConsts:GetCharacterBigImgPrefabPath(resCfg.res_Name, SkinEnum.fromWhere.getSkin))
  end
  self.ui.img_Carrer:SetIndex(heroCfg.career - 1)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(heroCfg.name)
  local enName = LanguageUtil.GetLocaleText(heroCfg.name_en)
  self.ui.tex_NameEN_Big.text = enName
  self.ui.tex_NameEN_small.text = enName
  self:ShowTags(heroCfg.tag)
  local heroStar, heroRare
  if self.useHeroData then
    heroStar = heroData.star
    heroRare = heroData.rare
  else
    local rankCfg = ConfigData.hero_rank[heroCfg.rank]
    if rankCfg == nil then
      error("Can't find rankCfg, id = " .. tostring(heroCfg.rank))
      return
    end
    heroStar = rankCfg.star
    heroRare = rankCfg.rare
  end
  self:ShowStars(heroStar)
  local qualityColor = HeroRareColor[heroRare]
  local nameEffColor = heroNameEffColor[heroRare]
  self.ui.img_Quality.color = qualityColor
  self:SetPlayEffectColor(qualityColor, nameEffColor)
  self:ShowTimeAndTimeZone()
  self.ui.tex_Signet.text = PlayerDataCenter.playerName
end

function UIGetHero:_ExtraHeroFrag(heroCfg)
  self.ui.cg_spChangeItem.gameObject:SetActive(false)
  self._hasFragExtra = false
  if not self._convertFrag or self.useHeroData then
    return
  end
  local upExtraNum = self._upHeroFragDic[heroCfg.id]
  if upExtraNum ~= nil then
    self.ui.tex_SpChangeCount.text = "x" .. tostring(upExtraNum)
    local itemCfg = ConfigData.item[heroCfg.fragment]
    if self._upHeroFragExtraItem == nil then
      self._upHeroFragExtraItem = UINBaseItem.New()
      self._upHeroFragExtraItem:Init(self.ui.spChangeItem)
      self._upHeroFragExtraItem:SetItemNoClickEvent(true)
    end
    self._upHeroFragExtraItem:InitBaseItem(itemCfg)
    self._hasFragExtra = true
  end
end

function UIGetHero:_HeroConvert(heroCfg)
  local rankCfg = ConfigData.hero_rank[heroCfg.rank]
  if rankCfg == nil then
    error("Can't find rankCfg, id = " .. tostring(heroCfg.rank))
    return
  end
  if self._convertFrag then
    local itemNum = rankCfg.repeat_frag_trans
    local convertItem = self.cardConvertItemPool:GetOne(false)
    convertItem:InitHeroCardConvert(heroCfg.fragment, itemNum)
    return
  end
  for k, itemId in ipairs(rankCfg.repeat_extra_trans_id) do
    local itemNum = rankCfg.repeat_extra_trans_num[k]
    local convertItem = self.cardConvertItemPool:GetOne(false)
    convertItem:InitHeroCardConvert(itemId, itemNum)
  end
end

function UIGetHero:__LoadLive2D(path, skinCfg)
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  if self.Live2DResloader ~= nil then
    self.Live2DResloader:Put2Pool()
    self.Live2DResloader = nil
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  self.Live2DResloader = CS.ResLoader.Create()
  HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
  self.Live2DResloader:LoadABAssetAsync(path, function(l2dModelAsset)
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
    self.l2dModelIns = l2dModelAsset:Instantiate(self.ui.heroHolder.transform)
    self.l2dModelIns.transform:SetLayer(LayerMask.UI)
    local cs_CubismInterationController = self.l2dModelIns.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      local skinId = skinCfg ~= nil and skinCfg.id or 0
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, self.curHeroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting("UIOverHigh", self.ui.heroHolder, 1)
      self.heroCubismInteration:SetL2DPosType("GetHero", false)
    end
  end)
end

function UIGetHero:__LoadPic(path)
  if self.Live2DResloader ~= nil then
    self.Live2DResloader:Put2Pool()
    self.Live2DResloader = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  self.bigImgResloader = CS.ResLoader.Create()
  DestroyUnityObject(self.bigImgGameObject)
  self.bigImgResloader:LoadABAssetAsync(path, function(prefab)
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder.transform)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("GetHero")
  end)
end

function UIGetHero:SetPlayEffectColor(qualityColor, nameEffColor)
  for index, effect in ipairs(self.ui.Eff_QualityList) do
    if effect.isPlaying then
      effect:Stop()
      effect.gameObject:SetActive(false)
    end
    local minMaxGradient = cs_ParticleSystem:MinMaxGradient()
    if index == 4 then
      minMaxGradient.color = nameEffColor
    else
      minMaxGradient.color = qualityColor
    end
    effect.main.startColor = minMaxGradient
    effect.gameObject:SetActive(true)
    effect:Play()
  end
end

function UIGetHero:ShowTimeAndTimeZone()
  self.ui.tex_Time.text = os.date("%m/%d %H:%M", os.time())
end

function UIGetHero:PlayAllTween()
  if IsNull(self.gameObject) then
    return
  end
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  self.ui.dialogue:SetActive(true)
  local voiceId
  if self.__customVoiceType ~= nil then
    voiceId = self.__customVoiceType
  elseif self.useHeroData then
    voiceId = ConfigData:GetVoicePointRandom(eVoicePointType.rankup, nil, self.curHeroId)
  else
    voiceId = eVoiceType.GAIN
  end
  local cvText = cvCtr:GetCvText(self.curHeroId, voiceId)
  self.ui.tex_Dialogue:DOKill(true)
  self.ui.tex_Dialogue.text = ""
  self.ui.tex_Dialogue:DOText(cvText, 1.5):SetLink(self.ui.tex_Dialogue.gameObject)
  if cvCtr:HasCv(self.curHeroId) then
    self.auBack_Voice = cvCtr:PlayCv(self.curHeroId, voiceId, function()
      self.auBack_Voice = nil
    end)
  end
  self.ui.ui_timeline.time = 0
  self.ui.ui_timeline:Play()
  self:_ReturnMovie()
  for i = 0, self.allTweens.Length - 1 do
    local tween = self.allTweens[i]
    tween:DOPause()
    tween:DORewind()
    tween:DOPlay()
  end
end

function UIGetHero:CheckIsTweening()
  if not IsNull(self.allTweens) then
    for i = 0, self.allTweens.Length - 1 do
      local tween = self.allTweens[i].tween
      local loopNum = tween:Loops()
      if loopNum ~= -1 then
        local isPlaying = tween:IsPlaying()
        if isPlaying then
          return true
        end
      end
    end
  end
  return false
end

function UIGetHero:GotoTweenAnimation(rate, keepPlay)
  self:_StopAllAudio()
  if self.ui.ui_timeline.time < 2.5 then
    self.ui.ui_timeline.time = 2.5
  end
  if not IsNull(self.allTweens) then
    for i = 0, self.allTweens.Length - 1 do
      local tween = self.allTweens[i].tween
      local loopNum = tween:Loops()
      if loopNum ~= -1 then
        local duration = tween:Duration()
        local elapsed = tween:Elapsed()
        if elapsed < duration * rate then
          tween:SetDelay(0)
          tween:Goto(duration * rate, keepPlay)
        end
      end
    end
  end
end

function UIGetHero:ShowStars(num)
  for _, starGo in ipairs(self.ui.ui_starList) do
    starGo.gameObject:SetActive(false)
  end
  local count = math.ceil(num / 2)
  local isHalf = num % 2 == 1
  for i = 1, count do
    local item = self.ui.ui_starList[i]
    if item ~= nil then
      item.gameObject:SetActive(true)
      item:SetIndex(0)
    end
  end
  if isHalf then
    self.ui.ui_starList[count]:SetIndex(1)
  end
  self.starCount = count
end

function UIGetHero:ShowTags(tagList)
  for _, starGo in ipairs(self.TagList) do
    starGo:SetActive(false)
  end
  for index, tagId in ipairs(tagList) do
    if self.TagList[index] ~= nil then
      self.TagList[index]:SetActive(true)
      local textItemInfo = self.TagList[index]:GetComponentInChildren(typeof(CS.UiTextItemInfo))
      textItemInfo:SetIndex(tagId)
      local imgItem = self.TagList[index]:GetComponentsInChildren(typeof(CS.UnityEngine.UI.Image))
      local spriteName = eHeroShowTag[tagId]
      imgItem[1].sprite = CRH:GetSprite(spriteName)
    else
      local item = self.ui.tagItem:Instantiate()
      local textItemInfo = item:GetComponentInChildren(typeof(CS.UiTextItemInfo))
      local imgItem = item:GetComponentsInChildren(typeof(CS.UnityEngine.UI.Image))
      table.insert(self.TagList, item)
      textItemInfo:SetIndex(tagId)
      local spriteName = eHeroShowTag[tagId]
      imgItem[1].sprite = CRH:GetSprite(spriteName)
    end
  end
end

function UIGetHero:_OnCamZoomOut()
  if self.withGetHeroSound then
    local audioId
    if self.starCount == 1 then
      audioId = 1020
    elseif self.starCount == 2 then
      audioId = 1021
    elseif self.starCount == 3 then
      audioId = 1022
    end
    self.auBack_ShowHero = AudioManager:PlayAudioById(audioId, function()
      self.auBack_ShowHero = nil
    end)
  end
end

function UIGetHero:_OnConvertTween()
  if #self.cardConvertItemPool.listItem == 0 and not self._hasFragExtra then
    return
  end
  if self.convertSeq ~= nil then
    self.convertSeq:Rewind(true)
    self.convertSeq:Kill(true)
    self.convertSeq = nil
  end
  local xOffset = 510
  local sequence = cs_DoTween.Sequence()
  local deplay = 0
  for index, item in ipairs(self.cardConvertItemPool.listItem) do
    deplay = (index - 1) * 0.15
    item:Show()
    item.transform.anchoredPosition.x = 0
    sequence:Insert(0, item.ui.tran_tween:DOAnchorPosX(item.transform.anchoredPosition.x + xOffset, 0.45):From():SetDelay(deplay))
    sequence:Insert(0, item.ui.fade_tween:DOFade(0, 0.45):From():SetDelay(deplay))
    if ConfigData.game_config.itemWithGreatFxDic[item.itemId] then
      sequence:AppendCallback(function()
        item.baseItem:LoadGetGreatRewardFx(self.resloader)
      end)
    end
  end
  if self._hasFragExtra then
    deplay = #self.cardConvertItemPool.listItem * 0.15
    self.ui.cg_spChangeItem.gameObject:SetActive(true)
    local posX = -175
    self.ui.cg_spChangeItem.transform.anchoredPosition.x = posX
    self.ui.cg_spChangeItem.alpha = 1
    sequence:Insert(0, self.ui.cg_spChangeItem.transform:DOAnchorPosX(posX + xOffset, 0.45):From():SetDelay(deplay))
    sequence:Insert(0, self.ui.cg_spChangeItem:DOFade(0, 0.45):From():SetDelay(deplay))
  end
  self.convertSeq = sequence
end

function UIGetHero:_OnStarVoice(starNum)
  if starNum <= self.starCount then
    self.auBack_StarDic[starNum] = AudioManager:PlayAudioById(1110, function()
      self.auBack_StarDic[starNum] = nil
    end)
  end
end

function UIGetHero:_StopAllAudio()
  for k, auBack in pairs(self.auBack_StarDic) do
    AudioManager:StopAudioByBack(auBack)
  end
  self.auBack_StarDic = {}
  if self.auBack_ShowHero ~= nil then
    AudioManager:StopAudioByBack(self.auBack_ShowHero)
    self.auBack_ShowHero = nil
  end
end

function UIGetHero:_StopHeroVoice()
  if self.auBack_Voice ~= nil then
    AudioManager:StopAudioByBack(self.auBack_Voice)
    self.auBack_Voice = nil
  end
end

function UIGetHero:_StopCampAudio()
  if self.auBack_camp ~= nil then
    AudioManager:StopAudioByBack(self.auBack_camp)
    self.auBack_camp = nil
  end
end

function UIGetHero:OnClickClose()
  if m_moviePlayer ~= nil then
    return
  end
  if not self.isNew then
    if not self.isSkipAllTween and not self:CheckIsTweening() then
      self:GotoTweenAnimation(0.4, true)
      self.isSkipAllTween = true
      return
    else
      self.isSkipAllTween = false
    end
  elseif self:CheckIsTweening() or self.ui.ui_timeline.state == cs_PlayState.Playing then
    return
  end
  self:_TryShowNext()
end

function UIGetHero:OnClickSkip()
  if self.useHeroData or self.isNew then
    return
  end
  if self.skipMode == eSkipMode.SkipOldHero then
  elseif self.skipMode == eSkipMode.None then
    self.skipMode = eSkipMode.SkipOldHero
    self:_TryShowNext()
  end
end

function UIGetHero:_OnComplete()
  if self.closeFunc ~= nil then
    local func = self.closeFunc
    self.closeFunc = nil
    func()
  else
    self:Delete()
  end
end

function UIGetHero:_ReturnMovie()
  self.ui.img_movie_bg.color = Color.New(0, 0, 0, 0)
  if m_moviePlayer ~= nil then
    cs_MovieManager:ReturnMoviePlayer(m_moviePlayer)
    m_moviePlayer = nil
  end
end

function UIGetHero:SetCloseFunction(closeFunc)
  self.closeFunc = closeFunc
end

function UIGetHero:OnDelete()
  self:_ReturnMovie()
  self:_StopAllAudio()
  self:_StopCampAudio()
  self:_StopHeroVoice()
  if self._upHeroFragExtraItem ~= nil then
    self._upHeroFragExtraItem:Delete()
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.__initCoroutine ~= nil then
    GR.StopCoroutine(self.__initCoroutine)
  end
  UIManager.UICamera.fieldOfView = 30
  if self.convertSeq ~= nil then
    self.convertSeq:Rewind()
    self.convertSeq:Kill()
    self.convertSeq = nil
  end
  base.OnDelete(self)
end

return UIGetHero
