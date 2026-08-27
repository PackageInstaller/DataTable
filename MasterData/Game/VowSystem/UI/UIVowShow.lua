local UIVowShow = class("UIVowShow", UIBaseWindow)
local base = UIBaseWindow
local HeroL2dInterationController = require("Game.Hero.Live2D.HeroL2dInterationController")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local SkinEnum = require("Game.Skin.SkinEnum")
local cs_ResLoader = CS.ResLoader
local cs_Material = CS.UnityEngine.Material
local cs_SkyController = CS.SkyController
local CS_Canvas = CS.UnityEngine.Canvas
local totalTime = 7.5
local startBlurTime = 3.3
local startBlur = 0.1
local curBlur = 0.1
local blurOffset = (1 - startBlur) / (totalTime - startBlurTime)
local DealVowDialogFunc = {
  [1] = function(self, dialogCfg)
    self.ui.obj_TextNarratorNode:SetActive(true)
    self.ui.obj_DialogNode:SetActive(false)
    self.ui.tex_TextNarratorSpeaker.text = LanguageUtil.GetLocaleText(dialogCfg.speaker)
    self.ui.tex_TextNarrator.text = LanguageUtil.GetLocaleText(dialogCfg.dialog)
  end,
  [2] = function(self, dialogCfg)
    self.ui.obj_TextNarratorNode:SetActive(false)
    self.ui.obj_DialogNode:SetActive(true)
    local content = LanguageUtil.GetLocaleText(dialogCfg.dialog)
    self.ui.text_Dialog.text = content
    local extents = self.ui.text_Dialog.rectTransform.sizeDelta
    extents.y = 0
    local sizeDelta = self.ui.text_Dialog:PreSetTextSizeDelta(content, false, true, extents)
    self.ui.text_Dialog_Layout.preferredHeight = sizeDelta.y
  end
}

function UIVowShow:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.__BackAction):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_Bg, self, self.__OnClickNextDialog)
  UIUtil.AddButtonListener(self.ui.btn_Skip, self, self.__OnClickSkip)
  CS_Canvas.ForceUpdateCanvases()
  self.__OnUpdateCallback = BindCallback(self, self.__OnUpdate)
  self._resLoader = cs_ResLoader.Create()
  self.ui.obj_TextNarratorNode:SetActive(false)
  self.ui.obj_DialogNode:SetActive(false)
  self.mat = cs_Material(self.ui.img_Bg.material)
  self.ui.img_Bg.material = self.mat
  self.mat:SetFloat("_01", startBlur)
  self._totalTime = 0
end

function UIVowShow:InitVowCardShow(heroId, closeFunc)
  self._heroId = heroId
  self._closeFunc = closeFunc
  self._ShowCfg = ConfigData.hero_vow_avg[heroId]
  if self._ShowCfg == nil then
    return
  end
  local heroData = PlayerDataCenter:GetHeroData(heroId)
  local curSkinId = heroData:GetCurrentUseSkinId()
  if ConfigData.skin_live2d[curSkinId] ~= nil and not PlayerDataCenter.skinData:IsSkinUpgrageOpenAndNotUpgradeEnd(curSkinId) then
    self._skinId = curSkinId
  else
    self._skinId = self._ShowCfg[1].live2d_skinid
  end
  local live2dConfig = ConfigData.skin_live2d[self._skinId]
  if live2dConfig == nil then
    self:__LoadPic(self._heroId, self._skinId)
  else
    self:__LoadL2D(self._heroId, self._skinId)
  end
  self._curDialogId = 0
  self._curDialogVoice = nil
  self:StartVowShowTimeLine()
  self:__ShowNextVowDialog()
end

function UIVowShow:__OnUpdate()
  self:__DealVowByFrame(Time.deltaTime)
end

function UIVowShow:__LoadL2D(heroId, skinId)
  local skinCfg = ConfigData.skin[skinId]
  local live2dConfig = ConfigData.skin_live2d[skinId]
  if skinCfg == nil then
    error("skinCfg is NIL")
    return
  end
  local resName = skinCfg.src_id_pic
  self._resLoader:LoadABAssetAsync(PathConsts:GetCharacterLive2DPath(resName, SkinEnum.fromWhere.heroVow), function(l2dModelAsset)
    if IsNull(l2dModelAsset) then
      return
    end
    self.liveGo = l2dModelAsset:Instantiate()
    self.liveGo.transform:SetParent(self.ui.heroHolder.transform)
    self.liveGo.transform:SetLayer(LayerMask.UI)
    local cs_CubismInterationController = self.liveGo.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting(self:GetWindowSortingLayer(), self.ui.heroHolder, nil, true)
      local posTypeName = "VowShow"
      if not self.heroCubismInteration:IsContainL2DPosTypeData(posTypeName) then
        posTypeName = "HeroList"
      end
      self.heroCubismInteration:SetL2DPosType(posTypeName, false)
      self.heroCubismInteration:SetInterationOpenWait(false)
      HeroL2dInterationController.ActiveLive2dBg(self.heroCubismInteration._controller.cs_renderController, false)
    end
  end)
end

function UIVowShow:__LoadPic(heroId, skinId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("skinCfg is NIL")
    return
  end
  local resName = skinCfg.src_id_pic
  self._resLoader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resName, SkinEnum.fromWhere.heroVow), function(prefab)
    self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder.transform)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    local posTypeName = "VowShow"
    if not commonPicCtrl:IsContainPosTypeData(posTypeName) then
      posTypeName = "HeroList"
    end
    commonPicCtrl:SetPosType(posTypeName)
  end)
end

function UIVowShow:StartVowShowTimeLine(callback)
  curBlur = startBlur
  self._totalTime = 0
  self:__AddVowUpdate()
  self._settedUpdate = true
  self._tlCoroutine = TimelineUtil.Play(self.ui.timeLine, function()
    if callback ~= nil then
      callback()
    end
    self:StopVowShowTimeLine()
    self:__RemoveVowUpdate()
  end)
end

function UIVowShow:__AddVowUpdate()
  if self._settedUpdate then
    return
  end
  self._settedUpdate = true
  UpdateManager:AddUpdate(self.__OnUpdateCallback)
end

function UIVowShow:__RemoveVowUpdate()
  if not self._settedUpdate then
    return
  end
  self._settedUpdate = false
  UpdateManager:RemoveUpdate(self.__OnUpdateCallback)
end

function UIVowShow:StopVowShowTimeLine()
  if self._tlCoroutine ~= nil then
    TimelineUtil.StopTlCo(self._tlCoroutine)
    self._tlCoroutine = nil
  end
end

function UIVowShow:__DealVowByFrame(deltatime)
  self._totalTime = self._totalTime + deltatime
  if self._totalTime >= startBlurTime then
    curBlur = math.min(curBlur + blurOffset * deltatime, 1)
    self.mat:SetFloat("_01", curBlur)
  end
end

function UIVowShow:__ShowNextVowDialog()
  self._curDialogId = self._curDialogId + 1
  local curDialogCfg = self._ShowCfg[self._curDialogId]
  if curDialogCfg == nil then
    self:CloseVowShow()
    return
  end
  if DealVowDialogFunc[curDialogCfg.dialog_box] ~= nil then
    DealVowDialogFunc[curDialogCfg.dialog_box](self, curDialogCfg)
  end
  local hasVoiceCfg = curDialogCfg.voiceId ~= 0
  local isCanAudio = ConfigData.hero_vow_no_audio[self._heroId] == nil
  if hasVoiceCfg and isCanAudio then
    self:__PlayVowHeroCv(self._heroId, curDialogCfg.voiceId, self._skinId)
  end
end

function UIVowShow:__SetHeroMouthActive(isActive)
  if self.heroCubismInteration == nil then
    return
  end
  self.heroCubismInteration:SetInterationCVOver(not isActive)
end

function UIVowShow:__OnClickNextDialog()
  if self._tlCoroutine ~= nil then
    return
  end
  self:__ShowNextVowDialog()
end

function UIVowShow:__PlayVowHeroCv(heroId, voiceId, skinId)
  self:__StopVowHeroCv()
  self:__SetHeroMouthActive(true)
  local CVController = ControllerManager:GetController(ControllerTypeId.Cv, true)
  self.AudioPlayback = CVController:PlayCv(heroId, voiceId, function()
    self.AudioPlayback = nil
    self:__SetHeroMouthActive(false)
  end, true, skinId)
end

function UIVowShow:__StopVowHeroCv()
  if self.AudioPlayback ~= nil then
    AudioManager:StopAudioByBack(self.AudioPlayback)
    self.AudioPlayback = nil
    self:__SetHeroMouthActive(false)
  end
end

function UIVowShow:__OnClickSkip()
  UIUtil.OnClickBackByUiTab(self)
end

function UIVowShow:__BackAction()
  UIManager:ShowWindowAsync(UIWindowTypeID.VowShowSkip, function(window)
    window:InitVowShowSkip(function()
      self:CloseVowShow(true)
    end)
  end)
  return false
end

function UIVowShow:CloseVowShow(isSkip)
  UIManager:ShowWindow(UIWindowTypeID.CommonMask):InitCommonMask(Color.black):CommonMaskFadeIn(1, function()
    self:Delete()
    if self._closeFunc ~= nil then
      self._closeFunc(isSkip)
    else
      UIManager:DeleteWindow(UIWindowTypeID.CommonMask)
    end
  end)
end

function UIVowShow:OnDelete()
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  DestroyUnityObject(self.mat)
  self:__RemoveVowUpdate()
  self:__StopVowHeroCv()
  self:StopVowShowTimeLine()
  if not IsNull(self.liveGo) then
    HeroCubismInteration.DestroyInterationInstance(self.liveGo)
    self.liveGo = nil
  end
  if not IsNull(self.bigImgGameObject) then
    HeroCubismInteration.DestroyInterationInstance(self.bigImgGameObject)
    self.bigImgGameObject = nil
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  base.OnDelete(self)
end

return UIVowShow
