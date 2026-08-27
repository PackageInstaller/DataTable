local HeroCubismInteration = class("HeroCubismInteration")
local cs_CubismMaskTexture = CS.Live2D.Cubism.Rendering.Masking.CubismMaskTexture
local cs_CubismMaskController = CS.Live2D.Cubism.Rendering.Masking.CubismMaskController
local HeroL2dInterationController = require("Game.Hero.Live2D.HeroL2dInterationController")
local HeroPicInterationController = require("Game.Hero.Live2D.HeroPicInterationController")

function HeroCubismInteration:ctor()
  self.__PlayCvCallback = BindCallback(self, self.__PlayCv)
  self.IsCvOverBank = BindCallback(self, self.SetInterationCVOver)
end

function HeroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, heroSkinId, camera, haveCV, lastCvId, needHideBg, isCloseL2dSfx)
  self.skinId = heroSkinId
  self._controller = HeroL2dInterationController.New()
  local aniFunc = haveCV and self.__PlayCvCallback or nil
  self._controller:InitL2dInteration(cs_CubismInterationController, heroId, heroSkinId, camera, true, aniFunc, nil, lastCvId or 0, needHideBg, isCloseL2dSfx)
  self:__SetCommonWhenInit(heroId)
end

function HeroCubismInteration:InitHeroPicCubism(go, heroId, skinId, lastCvId)
  self.skinId = skinId
  self._controller = HeroPicInterationController.New()
  self._controller:InitPicInteration(go, self.__PlayCvCallback, lastCvId, heroId, skinId)
  self:__SetCommonWhenInit(heroId)
end

function HeroCubismInteration:__SetCommonWhenInit(heroId)
  self.homeController = ControllerManager:GetController(ControllerTypeId.HomeController, true)
  self.heroId = heroId
end

function HeroCubismInteration.JudgeL2DLocked(heroSkinId)
  if heroSkinId == 0 then
    return false
  end
  if ConfigData.skin[heroSkinId] == nil then
    return false
  end
  return PlayerDataCenter.skinData:GetSkinLive2dLevel(heroSkinId) == 0
end

function HeroCubismInteration:InitShopCubism(cs_CubismInterationController, camera, callFunction)
  self._controller = HeroL2dInterationController.New()
  self._controller:InitL2dInteration(cs_CubismInterationController, 0, 0, camera, false, nil, callFunction)
end

function HeroCubismInteration:SetInterationCVOver(flag)
  if self._controller == nil then
    return
  end
  self._controller:SetInterationCVOver(flag)
end

function HeroCubismInteration:SetInterationOpenWait(flag)
  if self._controller == nil then
    return
  end
  self._controller:SetInterationOpenWait(flag)
end

function HeroCubismInteration:SetInterationOpenRayCast(flag)
  if self._controller == nil then
    return
  end
  self._controller:SetInterationOpenRayCast(flag)
end

function HeroCubismInteration:PlayHeroEnterHomeAnimation(loginType)
  if self._controller == nil then
    return
  end
  self._controller:PlayHeroEnterHomeAnimation(loginType)
end

function HeroCubismInteration:PlayLoginAnimation(loginType)
  if self._controller == nil then
    return 0
  end
  return self._controller:PlayLoginAnimation(loginType)
end

function HeroCubismInteration:ResetInterationWaitTime()
  if self._controller == nil then
    return
  end
  self._controller:ResetInterationWaitTime()
end

function HeroCubismInteration:__PlayCv(cvId, timeLength, OpenMouseListen)
  if self.homeController ~= nil then
    local heroId = self:GetCubismHeroId()
    local skinId = self:GetCubismSkinId()
    self.homeController:PlayHomeVoice(heroId, skinId, cvId, self.IsCvOverBank, timeLength, OpenMouseListen)
  end
end

function HeroCubismInteration:RestartBodyAnimation()
  if self._controller == nil then
    return
  end
  self._controller:SetInterationCVOver(true)
  self._controller:RestartBodyAnimation()
end

function HeroCubismInteration:IsPlayLoginAnimationOnAutoShowOver(loginType)
  if self._controller == nil then
    return
  end
  return self._controller:IsPlayLoginAnimationOnAutoShowOver(loginType)
end

function HeroCubismInteration:GetCubismHeroId()
  return self.heroId
end

function HeroCubismInteration:GetCubismSkinId()
  return self.skinId
end

function HeroCubismInteration:OpenLookTarget(camera)
  if self._controller ~= nil and self._controller.OpenLookTarget ~= nil then
    self._controller:OpenLookTarget(camera)
  end
end

function HeroCubismInteration:SetRenderControllerSetting(sortingLayerName, uiCanvasGroup, sortingOrder, InfluencedByUICanvas)
  if self._controller ~= nil and self._controller.SetRenderControllerSetting ~= nil then
    self._controller:SetRenderControllerSetting(sortingLayerName, uiCanvasGroup, sortingOrder, InfluencedByUICanvas)
  end
end

function HeroCubismInteration:SetL2DPosType(posTypeName, alignUIFakeCam)
  if self._controller ~= nil and self._controller.SetL2DPosType ~= nil then
    self._controller:SetL2DPosType(posTypeName, alignUIFakeCam)
  end
end

function HeroCubismInteration:IsContainL2DPosTypeData(posTypeName)
  if self._controller ~= nil and self._controller.IsContainL2DPosTypeData ~= nil then
    return self._controller:IsContainL2DPosTypeData(posTypeName)
  end
  return false
end

function HeroCubismInteration:SetUIPenetration(isAllowedPenetration)
  if self._controller ~= nil and self._controller.SetUIPenetration ~= nil then
    self._controller:SetUIPenetration(isAllowedPenetration)
  end
end

function HeroCubismInteration:StopCubismInterationAuido()
  if self._controller ~= nil and self._controller.StopCubismInterationAuido ~= nil then
    self._controller:StopCubismInterationAuido()
  end
end

function HeroCubismInteration:SetCoundPlaySound(value)
  if self._controller ~= nil and self._controller.SetCoundPlaySound ~= nil then
    self._controller:SetCoundPlaySound(value)
  end
end

function HeroCubismInteration.DestroyInterationInstance(interationGameObject)
  if IsNull(interationGameObject) then
    return
  end
  local maskController = interationGameObject:GetComponent(typeof(cs_CubismMaskController))
  if not IsNull(maskController) then
    local maskTexture = cs_CubismMaskTexture.GlobalMaskTexture
    maskTexture:RemoveSource(maskController)
  end
  DestroyUnityObject(interationGameObject)
end

function HeroCubismInteration:Delete()
  if self._controller ~= nil then
    self._controller:Delete()
  end
end

return HeroCubismInteration
