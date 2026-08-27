local UIGetHeroSkin = class("UIGetHeroSkin", UIBaseWindow)
local base = UIBaseWindow
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease
local UINHeroSkinTag = require("Game.Skin.UI.UINHeroSkinTag")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local SkinEnum = require("Game.Skin.SkinEnum")

function UIGetHeroSkin:OnInit()
  UIUtil.AddButtonListener(self.ui.Btn_immediate, self, self.OnClickUse)
  UIUtil.AddButtonListener(self.ui.Btn_Close, self, self.OnCloseHeroSkin)
  UIUtil.AddButtonListener(self.ui.btn_l2dLvUp, self, self.OnClickJump2SkinDetail)
  self.tagPool = UIItemPool.New(UINHeroSkinTag, self.ui.tagItem, false)
  self.skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
end

function UIGetHeroSkin:InitGetHeroSkin(skinCfg, callback)
  self._callback = callback
  self.skinCfg = skinCfg
  self:StopGetHeroCv()
  self:StopHomeLive2dVoice()
  self:InitializeUI()
  self:InitTweens()
  self:RefreshGetHeroSkinInfo()
  self:RefreshSkinLimitBtn()
end

function UIGetHeroSkin:GetHeroId()
  if self.heroId == nil and self.skinCtrl and self.skinCfg ~= nil then
    local skinId = self:GetSkinId()
    self.heroId = ConfigData.hero_data[self.skinCtrl:GetHeroId(skinId)].id
  end
  return self.heroId
end

function UIGetHeroSkin:GetSkinId()
  if self.skinCfg ~= nil then
    return self.skinCfg.id
  end
end

function UIGetHeroSkin:InitializeUI()
  local windowX = self.ui.obj_Center.transform.rect.width
  local windowY = self.ui.obj_Center.transform.rect.height
  self._defaultWindowSize = {windowX, windowY}
  local middleCenter = Vector2.New(0.5, 0.5)
  self.ui.obj_Center.gameObject:SetActive(true)
  self.ui.obj_IntroMask.gameObject:SetActive(true)
  self.ui.group_Top.gameObject:SetActive(true)
  self.ui.group_Bottom.gameObject:SetActive(true)
  self.ui.group_left.gameObject:SetActive(false)
  self.ui.group_Right.gameObject:SetActive(false)
  self.ui.group_Top.sizeDelta = Vector2.New(0, -windowY / 2)
  self.ui.group_Bottom.sizeDelta = Vector2.New(0, -windowY / 2)
  self.ui.obj_Center.transform.sizeDelta = Vector2.New(74, windowX)
  self.ui.obj_Center.transform.rotation = Quaternion.Euler(0, 0, 90)
  self.ui.img_Background.sizeDelta = Vector2.New(windowX, windowX)
  self.ui.LeftLineGroup.anchorMin = middleCenter
  self.ui.LeftLineGroup.anchorMax = middleCenter
  self.ui.RightLineGroup.anchorMin = middleCenter
  self.ui.RightLineGroup.anchorMax = middleCenter
  self.ui.LeftLineGroup.localPosition = Vector2.New(-19, -windowX / 2)
  self.ui.RightLineGroup.localPosition = Vector2.New(19, windowX / 2)
  self.ui.group_left.transform.localPosition = Vector2.New(0, 0)
  self.ui.group_Right.transform.localPosition = Vector2.New(0, 0)
  self.ui.LeftLineGroup.sizeDelta = Vector2.New(40, 0)
  self.ui.RightLineGroup.sizeDelta = Vector2.New(40, 0)
  self.ui.img_Background.gameObject:SetActive(false)
  self.ui.textNode:SetActive(self:SkinHasVoice())
end

function UIGetHeroSkin:InitTweens()
  local lineWidth = 38.66431
  local TopGroup = self.ui.Tween_TopGroup
  local BottomGroup = self.ui.Tween_BottomGroup
  local halfX = self._defaultWindowSize[1] / 2
  local halfY = self._defaultWindowSize[2] / 2
  local stripeY = self.ui.rect_Stripe.localPosition.y
  local texCloudY = self.ui.rect_Stripe.localPosition.y
  self.twSequence = cs_DoTween.Sequence()
  self.twSequence:AppendCallback(function()
    for index, moveItem in ipairs(TopGroup) do
      if index == 1 then
        moveItem:DOLocalMove(Vector2.New(0, 0), 0.25):From():SetEase(cs_Ease.OutQuart)
      else
        moveItem:DOLocalMove(Vector2.New(0, 0), 0.2 * index):From():SetEase(cs_Ease.OutQuart):SetDelay(0.1)
      end
    end
    for index, bottomItem in ipairs(BottomGroup) do
      if index == 1 then
        bottomItem:DOLocalMove(Vector2.New(0, 0), 0.25):From():SetEase(cs_Ease.OutQuart)
      else
        bottomItem:DOLocalMove(Vector2.New(0, 0), 0.2 * index):From():SetEase(cs_Ease.OutQuart):SetDelay(0.1)
      end
    end
    self.ui.rect_TexProjectionTop:DOLocalMove(Vector2.New(0, -halfY - 164), 0.5):From():SetEase(cs_Ease.OutQuart)
    self.ui.rect_neuralCloud:DOLocalMoveY(-texCloudY - 164, 0.5):From():SetEase(cs_Ease.OutQuart)
    self.ui.rect_TexProjectionBottom:DOLocalMove(Vector2.New(0, halfY + 164), 0.5):From():SetEase(cs_Ease.OutQuart)
    self.ui.rect_Stripe:DOLocalMoveY(stripeY + 164, 0.5):From():SetEase(cs_Ease.OutQuart)
    self.ui.LeftLineGroup:DOSizeDelta(Vector2.New(lineWidth, self._defaultWindowSize[1] * 1.1), 0.5):SetEase(cs_Ease.OutQuart)
    self.ui.RightLineGroup:DOSizeDelta(Vector2.New(lineWidth, self._defaultWindowSize[1] * 1.1), 0.5):SetEase(cs_Ease.OutQuart):OnComplete(function()
      self.ui.img_Background.gameObject:SetActive(true)
    end)
  end)
  self.twSequence:AppendInterval(0.6)
  self.twSequence:AppendCallback(function()
    self.ui.obj_Center:DORotateQuaternion(Quaternion.Euler(0, 0, 0), 0.45):SetEase(cs_Ease.InOutSine)
  end)
  self.twSequence:AppendInterval(0.45)
  self.twSequence:AppendCallback(function()
    self.ui.group_left.gameObject:SetActive(true)
    self.ui.group_Right.gameObject:SetActive(true)
    self.ui.group_Top.gameObject:SetActive(false)
    self.ui.group_Bottom.gameObject:SetActive(false)
    self.ui.LeftLineGroup:DOLocalMove(Vector2.New(-halfX + lineWidth / 2, -halfY), 0.4):SetEase(cs_Ease.OutQuart)
    self.ui.RightLineGroup:DOLocalMove(Vector2.New(halfX - lineWidth / 2, halfY), 0.4):SetEase(cs_Ease.OutQuart)
    self.ui.group_left:DOLocalMoveX(-halfX + lineWidth / 2, 0.4):SetEase(cs_Ease.OutQuart)
    self.ui.group_Right:DOLocalMoveX(halfX - lineWidth / 2, 0.4):SetEase(cs_Ease.OutQuart)
    self.ui.img_Background.gameObject.transform:DOSizeDelta(Vector2.New(self._defaultWindowSize[1], self._defaultWindowSize[2]), 0.4):SetEase(cs_Ease.OutQuart)
    self.ui.obj_Center:DOSizeDelta(Vector2.New(self._defaultWindowSize[1], self._defaultWindowSize[2]), 0.4):SetEase(cs_Ease.OutQuart):OnComplete(function()
      self.ui.obj_IntroMask:SetActive(false)
      self.ui.obj_CastMask:SetActive(false)
    end)
    self:__PlayGetSkinVoice()
  end)
  self.twSequence:Restart()
end

function UIGetHeroSkin:RefreshGetHeroSkinInfo()
  if self.skinCfg == nil then
    error("skinCfg is nil")
    return
  end
  if #self.skinCfg.showlabel > 0 then
    self.ui.img_Tag.gameObject:SetActive(true)
    self.ui.img_Tag:SetIndex(0)
    self.ui.tex_promotion.text = LanguageUtil.GetLocaleText(ConfigData:GetTipTag(TipTag.skinTag, self.skinCfg.showlabel[1]))
  elseif PlayerDataCenter.skinData:IsHaveSkinLimit(self.skinCfg.id) then
    self.ui.img_Tag.gameObject:SetActive(true)
    self.ui.img_Tag:SetIndex(1)
    self.ui.textItem_promotion:SetIndex(0)
  else
    self.ui.img_Tag.gameObject:SetActive(false)
  end
  local isShowL2DComingSoon = self.skinCfg.temp_label
  self.ui.obj_L2DComingSoon:SetActive(isShowL2DComingSoon)
  self.ui.obj_L2DComingSoon.transform:SetAsLastSibling()
  local heroId = self:GetHeroId()
  local heroName = ConfigData.hero_data[heroId].name
  local skinName = self.skinCfg.name
  self.ui.tex_SkinTitle.text = string.format("%s「%s」", LanguageUtil.GetLocaleText(heroName), LanguageUtil.GetLocaleText(skinName))
  self.ui.Tex_immediate.gameObject:SetActive(true)
  self.ui.tex_isEquiped.gameObject:SetActive(false)
  local color = self.ui.defaultColor
  local heroData = PlayerDataCenter.heroDic[heroId]
  local skinId = self:GetSkinId()
  if heroId == nil or heroData == nil then
    self.ui.Tex_immediate.gameObject:SetActive(false)
    self.ui.tex_isEquiped.gameObject:SetActive(true)
    self.ui.tex_isEquiped:SetIndex(1)
    color = self.ui.deepColor
  elseif heroData.skinId == skinId then
    self.ui.Tex_immediate.gameObject:SetActive(false)
    self.ui.tex_isEquiped.gameObject:SetActive(true)
    self.ui.tex_isEquiped:SetIndex(0)
    color = self.ui.deepColor
  elseif not PlayerDataCenter.skinData:IsHaveSkin(skinId) then
    self.ui.Tex_immediate.gameObject:SetActive(false)
    self.ui.tex_isEquiped.gameObject:SetActive(true)
    self.ui.tex_isEquiped:SetIndex(2)
    color = self.ui.deepColor
  end
  self.ui.img_immediate.color = color
  self.tagPool:HideAll()
  CommonUIUtil.CreateHeroSkinTags(self.skinCfg, self.tagPool)
  self.ui.tex_Title.text = string.format("[%s]", LanguageUtil.GetLocaleText(ConfigData.skinTheme[self.skinCfg.theme].name))
  self.ui.tex_SkinName.text = LanguageUtil.GetLocaleText(self.skinCfg.name)
  self.ui.tex_Desc.text = LanguageUtil.GetLocaleText(self.skinCfg.describe)
  local resModel = self.skinCtrl:GetResModel(heroId, skinId)
  if not IsNull(self.l2dModelIns) then
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
    self.l2dModelIns = nil
    self.l2dBinding = nil
  end
  if not IsNull(self.bigImgGameObject) then
    DestroyUnityObject(self.bigImgGameObject)
  end
  if self.Live2DResloader ~= nil then
    self.Live2DResloader:Put2Pool()
    self.Live2DResloader = nil
    self.l2dBinding = nil
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  self.l2dBinding = nil
  local isHaveL2D = PlayerDataCenter.skinData:IsHaveL2d(skinId)
  if isHaveL2D then
    local resPath = PathConsts:GetCharacterLive2DPath(resModel.src_id_pic, SkinEnum.fromWhere.getSkin)
    self:__LoadLive2D(resPath)
  else
    self:__LoadPic(PathConsts:GetCharacterBigImgPrefabPath(resModel.src_id_pic, SkinEnum.fromWhere.getSkin))
  end
end

function UIGetHeroSkin:__LoadLive2D(path)
  self.Live2DResloader = CS.ResLoader.Create()
  self.Live2DResloader:LoadABAssetAsync(path, function(l2dModelAsset)
    if IsNull(self.transform) then
      return
    end
    self.l2dModelIns = l2dModelAsset:Instantiate()
    self.l2dModelIns.transform:SetParent(self.ui.heroFade.transform)
    self.l2dModelIns.transform:SetLayer(LayerMask.UI)
    local cs_CubismInterationController = self.l2dModelIns.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      local heroId = ConfigData.hero_data[self.skinCtrl:GetHeroId(self.skinCfg.id)].id
      local skinId = self.skinCfg.id
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:SetInterationOpenWait(false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting(self:GetWindowSortingLayer(), self.ui.heroFade, 1, true)
      self.heroCubismInteration:SetL2DPosType("HeroSkin", false)
    end
    self.l2dBinding = {}
    UIUtil.LuaUIBindingTable(self.l2dModelIns, self.l2dBinding)
  end)
end

function UIGetHeroSkin:__LoadPic(path)
  self.bigImgResloader = CS.ResLoader.Create()
  self.bigImgResloader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) or IsNull(self.transform) then
      return
    end
    self.bigImgGameObject = prefab:Instantiate(self.ui.picHolder.transform)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroSkin")
  end)
end

function UIGetHeroSkin:StopGetHeroCv()
  if self.playCvcallBack ~= nil then
    AudioManager:StopAudioByBack(self.playCvcallBack)
  end
end

function UIGetHeroSkin:StopHomeLive2dVoice()
  local homeController = ControllerManager:GetController(ControllerTypeId.HomeController)
  if homeController ~= nil then
    homeController:ResetShowHeroVoiceImme()
  end
end

function UIGetHeroSkin:SkinHasVoice()
  local skinId = self:GetSkinId()
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  return cvCtr:HasSkinCv(skinId)
end

function UIGetHeroSkin:__PlayGetSkinVoice()
  local skinId = self:GetSkinId()
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  if cvCtr:HasSkinCv(skinId) then
    local heroId = self:GetHeroId()
    local voiceId = 101
    local text = cvCtr:GetCvText(heroId, voiceId, skinId)
    self:StopGetHeroCv()
    self.playCvcallBack = cvCtr:PlayCv(heroId, voiceId, function()
    end, true, skinId)
    self.ui.tex_Audio.text = text
  end
end

function UIGetHeroSkin:RefreshSkinLimitBtn()
  local skinId = self:GetSkinId()
  local showSkinUpgrade = PlayerDataCenter.skinData:IsSkinCanUpgrade(skinId)
  showSkinUpgrade = showSkinUpgrade and PlayerDataCenter.skinData:IsInSkinUpgradeTimeRange(skinId)
  self.ui.btn_l2dLvUp.gameObject:SetActive(showSkinUpgrade)
end

function UIGetHeroSkin:OnClickUse()
  if self.ui.tex_isEquiped.gameObject.activeSelf == true then
    return
  end
  local heroId = self:GetHeroId()
  
  local function callback()
    local win = UIManager:GetWindow(UIWindowTypeID.HeroSkin)
    if win ~= nil then
      win:ClickHeroSkinUseCallback()
    end
    self.ui.Tex_immediate.gameObject:SetActive(false)
    self.ui.tex_isEquiped.gameObject:SetActive(true)
    self.ui.tex_isEquiped:SetIndex(0)
    self.ui.img_immediate.color = self.ui.deepColor
  end
  
  local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  skinCtrl:HeroSkinChange(heroId, self.skinCfg, callback)
  PlayerClickCollectManager:BtnClickNumCollect(1015)
end

function UIGetHeroSkin:OnClickJump2SkinDetail()
  if not self.ui.btn_l2dLvUp.gameObject.activeSelf then
    return
  end
  local JumpManager = require("Game.Jump.JumpManager")
  local skinId = self:GetSkinId()
  JumpManager:Jump(JumpManager.eJumpTarget.HeroSkin, nil, nil, {
    skinId,
    require("Game.Skin.SkinEnum").fromWhere.getSkin
  })
  self:OnCloseHeroSkin()
end

function UIGetHeroSkin:OnCloseHeroSkin()
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UIGetHeroSkin:OnDelete()
  if self.twSequence ~= nil then
    self.twSequence:Kill()
    self.twSequence = nil
  end
  self.ui.group_left:DOKill()
  self.ui.group_Right:DOKill()
  self.ui.img_Background:DOKill()
  self.ui.FontUICanvas:DOKill()
  self.ui.img_Background.gameObject.transform:DOKill()
  self.ui.obj_Center:DOKill()
  self.ui.RightLineGroup:DOKill()
  self.ui.LeftLineGroup:DOKill()
  for index, topItem in ipairs(self.ui.Tween_TopGroup) do
    topItem:DOKill()
  end
  for index, bottomItem in ipairs(self.ui.Tween_BottomGroup) do
    bottomItem:DOKill()
  end
  self.ui.rect_TexProjectionTop:DOKill()
  self.ui.rect_neuralCloud:DOKill()
  self.ui.rect_TexProjectionBottom:DOKill()
  self.ui.rect_Stripe:DOKill()
  if self.Live2DResloader ~= nil then
    self.Live2DResloader:Put2Pool()
    self.Live2DResloader = nil
    self.l2dBinding = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  self:StopGetHeroCv()
  self.heroId = nil
  base.OnDelete(self)
end

return UIGetHeroSkin
