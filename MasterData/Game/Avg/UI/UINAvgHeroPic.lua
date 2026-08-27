local UINAvgHeroPic = class("UINAvgHeroPic")
local eAvgImgPosType = require("Game.Avg.Enum.eAvgImgPosType")
local AvgImgTweenUntil = require("Game.Avg.AvgImgTweenUntil")
local CS_ResLoader = CS.ResLoader
local CS_DOTweenAnimation = CS.DG.Tweening.DOTweenAnimation
local CS_GameObject = CS.UnityEngine.GameObject
local CS_RectTransform = CS.UnityEngine.RectTransform
local CS_RawImage = CS.UnityEngine.UI.RawImage
local CS_Ease = CS.DG.Tweening.Ease
local CS_Material = CS.UnityEngine.Material

function UINAvgHeroPic:InitAvgHeroPic(imgCfg, heroItemPrefab, tweenCompleteEvent)
  self.imgId = imgCfg.imgId
  self.imgCfg = imgCfg
  self.tweenCompleteEvent = tweenCompleteEvent
  self.gameObject = heroItemPrefab:Instantiate()
  self.transform = self.gameObject.transform
  self.ui = {}
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.breatheRoot.gameObject:SetActive(false)
  local breathTweenList = self.ui.breatheRoot:GetComponents(typeof(CS_DOTweenAnimation))
  local delay = math.random() * 2
  for i = 0, breathTweenList.Length - 1 do
    local dt = breathTweenList[i]
    dt.delay = delay
  end
  self.gameObject:SetActive(true)
  self.immediateComplete = false
  self.tweenCfgList = {}
  self:LoadHeroPic()
end

function UINAvgHeroPic:LoadHeroPic()
  self.loadResComplete = false
  self.resloader = CS_ResLoader.Create()
  local path = self:_GetImgPrefabPath()
  self.resloader:LoadABAssetAsync(path, function(prefab)
    local go = prefab:Instantiate(self.ui.breatheRoot)
    self.picGo = go
    local commonPicCtrl = go:FindComponent(eUnityComponentID.CommonPicController)
    if self.imgCfg.posId ~= nil then
      local posType = "AvgHero" .. tostring(self.imgCfg.posId)
      if commonPicCtrl:SetPosType(posType) == false then
        warn(string.format("[SetPosType]Avg hero posId error, imgPath = %s, posType = %s", self:_GetImgPath(), posType))
      end
    end
    self.commonPicCtrl = commonPicCtrl
    self.ui.rawImg = go:FindComponent(eUnityComponentID.RawImage)
    self.heroMatDefault = CS_Material(self.ui.heroFaceMat)
    self.ui.rawImg.material = self.heroMatDefault
    self:InitAvgHeroPicParam()
    self.loadResComplete = true
    for k, tweenCfg in ipairs(self.tweenCfgList) do
      AvgImgTweenUntil.Tween(self, tweenCfg)
    end
    self:PlayAvgImgTween()
    self:_EnableFace(false)
    if self.faceId ~= nil then
      self:AvgHeroChangeFace(self.faceId)
    end
    self.ui.breatheRoot.gameObject:SetActive(true)
  end)
end

function UINAvgHeroPic:_GetImgPath()
  local imgPath = self.imgCfg.imgPath
  if not string.IsNullOrEmpty(self.imgCfg.imgPathBoy) then
    local isGirl = PlayerDataCenter.inforData ~= nil and PlayerDataCenter.inforData:GetSex()
    if not isGirl then
      imgPath = self.imgCfg.imgPathBoy
    end
  end
  return imgPath
end

function UINAvgHeroPic:_GetImgPrefabPath()
  local imgPath = self:_GetImgPath()
  return PathConsts:GetCharacterBigImgPrefabPath(imgPath)
end

function UINAvgHeroPic:InitAvgHeroPicParam()
  local imgCfg = self.imgCfg
  local pos
  if imgCfg.pos ~= nil then
    pos = Vector3.New(imgCfg.pos[1], imgCfg.pos[2], imgCfg.pos[3])
  else
    pos = self.ui.rawImg.transform.localPosition
  end
  self.ui.rawImg.transform.localPosition = Vector3.zero
  self.transform.localPosition = pos
  local rot
  if imgCfg.rot == nil then
    rot = Vector3.zero
  else
    rot = Vector3.New(imgCfg.rot[1], imgCfg.rot[2], imgCfg.rot[3])
  end
  self.transform.localEulerAngles = rot
  local scale
  if imgCfg.scale == nil then
    scale = Vector3.one
  else
    scale = Vector3.New(imgCfg.scale[1], imgCfg.scale[2], imgCfg.scale[3])
  end
  self.transform.localScale = scale
  local color = imgCfg.isDark and Color.gray or Color.white
  local alpha = imgCfg.alpha == nil and self.ui.rawImg.color.a or imgCfg.alpha
  color.a = alpha
  self.ui.rawImg.color = color
  self:__ShowCommunication(imgCfg.comm)
  local ripple = imgCfg.ripple and not imgCfg.comm
  self:__ShowRipple(imgCfg.ripple)
end

function UINAvgHeroPic:GetAvgImgOrder()
  return self.imgCfg.order or 0
end

function UINAvgHeroPic:ChangeAvgImgOrder(order)
  self.imgCfg.order = order
end

function UINAvgHeroPic:GetAvgHeroPicResetData(posPresetId)
  local posType = "AvgHero" .. tostring(posPresetId)
  local picPosData = self.commonPicCtrl:GetPosTypeData(posType)
  if picPosData == nil then
    warn(string.format("Avg hero posId error, imgPath = %s, posType = %s", self:_GetImgPath(), posType))
  end
  return picPosData
end

function UINAvgHeroPic:__ShowCommunication(show)
  local avgWindow = UIManager:GetWindow(UIWindowTypeID.Avg)
  if avgWindow == nil then
    return
  end
  if show and self.commItem == nil and self.commonPicCtrl ~= nil then
    local commItem, heroMat = avgWindow:GetHeroCommItem()
    commItem:InitAvgHeroCommItem(self.commonPicCtrl.avgCommPos, self.ui.breatheRoot)
    self.picGo.transform.localScale = self.commonPicCtrl.avgCommScale
    self.ui.rawImg.material = heroMat
    self.commItem = commItem
    self.commMat = heroMat
  elseif not show and self.commItem ~= nil then
    self.ui.breatheRoot:SetParent(self.transform)
    self.picGo.transform.localScale = Vector3.one
    avgWindow:ReturnHeroCommItem(self.commItem, self.commMat)
    self.ui.rawImg.material = self.heroMatDefault
    self.commItem = nil
    self.commMat = nil
  end
  self:AvgHeroChangeFace(self.faceId)
end

function UINAvgHeroPic:__ShowRipple(show)
  local avgWindow = UIManager:GetWindow(UIWindowTypeID.Avg)
  if avgWindow == nil then
    return
  end
  if show and self._rippleMat == nil then
    local mat = avgWindow:GetAvgRippleMat()
    self.ui.rawImg.material = mat
    self._rippleMat = mat
  elseif not show and self._rippleMat ~= nil then
    self.ui.rawImg.material = self.heroMatDefault
    avgWindow:ReturnAvgRippleMat(self._rippleMat)
    self._rippleMat = nil
  end
  self:AvgHeroChangeFace(self.faceId)
end

function UINAvgHeroPic:AvgHeroDissolveTween(duration)
  local avgWindow = UIManager:GetWindow(UIWindowTypeID.Avg)
  if avgWindow == nil then
    return
  end
  local matParam = "_Dissolve"
  local dissolveMat = avgWindow:GetAvgHeroDissolveMat()
  dissolveMat:SetFloat(matParam, 0)
  self.ui.rawImg.material = dissolveMat
  self:AvgHeroChangeFace(self.faceId)
  if IsNull(self.dissolveEffectGo) then
    local path = PathConsts:GetEffectPath("avg/FXP_Lihui-Dis")
    self.resloader:LoadABAssetAsync(path, function(prefab)
      if IsNull(prefab) then
        return
      end
      local go = prefab:Instantiate(self.transform)
      self.dissolveEffectGo = go
    end)
  else
    self.dissolveEffectGo:SetActive(false)
    self.dissolveEffectGo:SetActive(true)
  end
  return dissolveMat:DOFloat(0.55, matParam, duration):SetEase(CS_Ease.OutQuart)
end

function UINAvgHeroPic:AvgHeroChangeFace(faceId)
  self.faceId = faceId or 0
  if not self.loadResComplete then
    return
  end
  if faceId == 0 then
    self:_EnableFace(false)
    return
  end
  local heroImgSize = self.ui.rawImg.transform.sizeDelta
  local faceSize = self.commonPicCtrl.avgFaceSize
  local facePos = Vector2.New(self.commonPicCtrl.avgFacePos.x, self.commonPicCtrl.avgFacePos.y)
  local scale = Vector2.New(faceSize.x / heroImgSize.x, faceSize.y / heroImgSize.y)
  self.ui.rawImg.material:SetTextureScale("_FaceTex", scale)
  local offset = facePos - Vector2.New(faceSize.x / 2, faceSize.y / 2) + Vector2.New(heroImgSize.x / 2, heroImgSize.y / 2)
  offset = Vector2.New(offset.x / heroImgSize.x, offset.y / heroImgSize.y)
  self.ui.rawImg.material:SetTextureOffset("_FaceTex", offset)
  local path = PathConsts:GetCharacterFaceImgPath(self:_GetImgPath(), tostring(faceId))
  self.resloader:LoadABAssetAsync(path, function(texture)
    if texture == nil then
      return
    end
    self.ui.rawImg.material:SetTexture("_FaceTex", texture)
    self:_EnableFace(true)
  end)
end

function UINAvgHeroPic:_EnableFace(enable)
  if enable then
    self.ui.rawImg.material:EnableKeyword("FACE_TEX_ENABLE")
  else
    self.ui.rawImg.material:DisableKeyword("FACE_TEX_ENABLE")
  end
end

function UINAvgHeroPic:GetAvgImgType()
  return self.imgCfg.imgType
end

function UINAvgHeroPic:PlayAvgImgTween()
  if self.sequence ~= nil and self.loadResComplete then
    if self.immediateComplete then
      self.sequence:Complete()
      self:OnTweenComplete()
      return
    end
    self.sequence:AppendCallback(self:GetAvgImgTweenCompleteEvent())
    self.sequence:Play()
  end
end

function UINAvgHeroPic:AddAvgImgTween(tweenCfg)
  if self.loadResComplete then
    AvgImgTweenUntil.Tween(self, tweenCfg)
  else
    table.insert(self.tweenCfgList, tweenCfg)
  end
end

function UINAvgHeroPic:GetAvgImgSequence()
  return self.sequence
end

function UINAvgHeroPic:SetAvgImgSequence(sequence)
  self.sequence = sequence
end

function UINAvgHeroPic:GetAvgImgTweenCompleteEvent()
  if self.__onTweenComplete == nil then
    self.__onTweenComplete = BindCallback(self, self.OnTweenComplete)
  end
  return self.__onTweenComplete
end

function UINAvgHeroPic:OnTweenComplete()
  self.sequence = nil
  self.tweenCfgList = {}
  if self.tweenCompleteEvent ~= nil then
    self.tweenCompleteEvent(self.imgId)
  end
end

function UINAvgHeroPic:AvgImgTweenDoComplete()
  if self.sequence ~= nil and self.sequence:IsPlaying() then
    self.sequence:Complete(true)
  else
    self.immediateComplete = true
  end
end

function UINAvgHeroPic:AvgImgTweenDoEnd()
  if self.sequence ~= nil and self.sequence:IsPlaying() then
    self.sequence:Kill()
  end
end

function UINAvgHeroPic:Delete()
  if self.sequence ~= nil then
    self.sequence:Kill()
    self.sequence = nil
  end
  self:__ShowCommunication(false)
  self:__ShowRipple(false)
  DestroyUnityObject(self.heroMatDefault)
  self.heroMatDefault = nil
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  DestroyUnityObject(self.gameObject)
end

return UINAvgHeroPic
