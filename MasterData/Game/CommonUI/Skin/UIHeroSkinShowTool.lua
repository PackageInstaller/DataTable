local UIHeroSkinShowTool = class("UIHeroSkinShowTool")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")
local cs_ResManger = CS.ResManager.Instance

function UIHeroSkinShowTool:InitSkinShow(heroHolder, picHolder, sortingLayer, poseType)
  self.heroHolder = heroHolder
  self.picHolder = picHolder
  self.sortingLayer = sortingLayer
  self.poseType = poseType
  self.picHolderTweensAnimations = self.picHolder.transform:GetComponentsInChildren(typeof(CS.DG.Tweening.DOTweenAnimation))
  self.heroHolderTweensAnimations = self.heroHolder.transform:GetComponentsInChildren(typeof(CS.DG.Tweening.DOTweenAnimation))
end

function UIHeroSkinShowTool:ShowSkinById(skinId, forceShowRectify, isShowTween)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("skin cfg is null,skinId:" .. tostring(skinId))
    return
  end
  if self.l2dModelIns ~= nil then
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
  end
  if self.bigImgGameObject ~= nil then
    DestroyUnityObject(self.bigImgGameObject)
  end
  local resPath = PathConsts:GetCharacterLive2DPath(skinCfg.src_id_pic)
  local isHaveL2D = PlayerDataCenter.skinData:IsHaveL2d(skinId)
  local isLocked = HeroCubismInteration.JudgeL2DLocked(skinCfg.id)
  local isRectify = not string.IsNullOrEmpty(skinCfg.src_id_pic_rectify)
  if isHaveL2D and not isLocked and not isRectify then
    self:LoadLive2D(resPath, skinCfg, isShowTween)
  else
    self:LoadPic(PathConsts:GetCharacterBigImgPrefabPath(skinCfg.src_id_pic, forceShowRectify), isShowTween)
  end
end

function UIHeroSkinShowTool:SetLoadOverFunc(func)
  self.LoadOverFunc = func
end

function UIHeroSkinShowTool:LoadLive2D(path, skinCfg, isShowTween)
  if self.Live2DResloader ~= nil then
    self.Live2DResloader:Put2Pool()
    self.Live2DResloader = nil
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  self.Live2DResloader = CS.ResLoader.Create()
  self.Live2DResloader:LoadABAssetAsync(path, function(l2dModelAsset)
    self.l2dModelIns = l2dModelAsset:Instantiate(self.heroHolder.transform)
    self.l2dModelIns.transform:SetLayer(LayerMask.UI)
    local cs_CubismInterationController = self.l2dModelIns.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      local heroId = skinCfg.heroId
      local skinId = skinCfg.id
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting(self.sortingLayer, self.heroHolder)
      self.heroCubismInteration:SetL2DPosType(self.poseType or "SkinPreview", false)
      if isShowTween and self.heroHolderTweensAnimations ~= nil then
        for i = 0, self.heroHolderTweensAnimations.Length - 1 do
          local tween = self.heroHolderTweensAnimations[i]
          tween:DORestart(false)
        end
      end
    end
  end)
end

function UIHeroSkinShowTool:LoadPic(path, isShowTween)
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  self.bigImgResloader = CS.ResLoader.Create()
  self.bigImgResloader:LoadABAssetAsync(path, function(prefab)
    if isShowTween and self.picHolderTweensAnimations ~= nil then
      for i = 0, self.picHolderTweensAnimations.Length - 1 do
        local tween = self.picHolderTweensAnimations[i]
        tween:DORestart(false)
      end
    end
    self.bigImgGameObject = prefab:Instantiate(self.picHolder.transform)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType(self.poseType or "HeroList")
    if self.LoadOverFunc ~= nil then
      self.LoadOverFunc()
    end
  end)
end

function UIHeroSkinShowTool:OnDelete()
  if self.Live2DResloader ~= nil then
    self.Live2DResloader:Put2Pool()
    self.Live2DResloader = nil
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  self.picHolder = nil
  self.heroHolder = nil
  self.picHolderTweensAnimations = nil
  self.heroHolderTweensAnimations = nil
end

return UIHeroSkinShowTool
