local Animator = CS.UnityEngine.Animator
local UIAnimationController = CS.Z1Client.UIAnimationController
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local Image = CS.UnityEngine.UI.Image
local AvgDialogBgComp, Super = System.NewClass("AvgDialogBgComp")

function AvgDialogBgComp:ctor(ui, binder, avgModel)
  Super.ctor(self)
  self.ui = ui
  self.binder = binder
  self.avgModel = avgModel
  self.isVideoBg = false
  self.ui.Image_Bg_Behind:SetActive(false)
  self.ui.Image_Bg_Show:SetActive(false)
end

function AvgDialogBgComp:SetBg()
  if self.avgModel.bgScale then
    local scale = self.avgModel.bgScale
    self.ui.Image_Bg_Show.transform.localScale = Vector3(scale, scale, 1)
  end
  local bgId = self.avgModel.bgId
  local bgLayer = self.avgModel.bgLayer
  if self.bgId == bgId then
    return
  end
  if bgId and string.contains(bgId, ".mp4") then
    self.bgId = bgId
    self:SetVideoBg(bgId)
    return
  end
  local bgRes = DT.AvgBg[bgId] and DT.AvgBg[bgId].Res
  if not bgRes then
    return
  end
  self:StopVideoBg()
  self.bgId = bgId
  if bgLayer == CommonDefine.AvgBgType.PrefabTop then
    self:SetTopPrefab(bgRes)
    return
  end
  if self.bgPrefabGameObj then
    CS.UnityEngine.Object.Destroy(self.bgPrefabGameObj)
    self.bgPrefabGameObj = nil
  end
  if bgRes:find(".prefab") then
    local prefab = self.binder:LoadAsset(bgRes)
    local parentTransfrom = self.ui.AvgDialogBg.transform
    self.bgPrefabGameObj = CS.UnityEngine.GameObject.Instantiate(prefab, parentTransfrom)
    local center = Vector2(0.5, 0.5)
    local rectTransform = self.bgPrefabGameObj:GetComponent(typeof(CS.UnityEngine.RectTransform))
    rectTransform.anchorMin = center
    rectTransform.anchorMax = center
    rectTransform.localScale = Vector3(1, 1, 1)
    return
  end
  if bgId and bgId ~= CommonDefine.TransparentBG then
    self.ui.Image_Bg_Behind:SetActive(true)
    self.ui.Image_Bg_Show:SetActive(true)
    if bgRes:find(".png") then
      self.binder:SetImageSync(self.ui.Image_Bg_Show, bgRes)
    end
  end
end

function AvgDialogBgComp:EnableDisturbMetiral(isEnabled)
  local bgImg = self.ui.Image_Bg_Show:GetComponent(typeof(Image))
  if isEnabled then
    if not self._disturbMaterial then
      self._disturbMaterial = self.binder:LoadAsset(CommonDefine.AvgMaterialType.Disturb)
      self.binder:onDestroy(function()
        self._disturbMaterial = nil
      end)
    end
    bgImg.material = self._disturbMaterial
  else
    bgImg.material = nil
  end
end

function AvgDialogBgComp:GetAvgVideoComp()
  local avgDialogPanel = UIManager.Instance:GetWindow(Urls.AvgDialogPanelNew)
  if avgDialogPanel then
    local videoComp = avgDialogPanel.avgVideoComp
    return videoComp
  end
end

function AvgDialogBgComp:SetVideoBg(videoUrl)
  self.isVideoBg = true
  local videoComp = self:GetAvgVideoComp()
  if videoUrl and videoComp then
    videoComp:PlayVideoBg(videoUrl)
  end
end

function AvgDialogBgComp:StopVideoBg()
  self.isVideoBg = false
  local videoComp = self:GetAvgVideoComp()
  if videoComp then
    videoComp:ClearVideo()
  end
end

function AvgDialogBgComp:SetTopPrefab(bgRes)
  self:ClearTopPrefab()
  local prefab = ResLoadMgr.LoadAsset(bgRes, self)
  local parentTransfrom = self.ui.uiNode.transform
  self.topPrefabGameObj = CS.UnityEngine.GameObject.Instantiate(prefab, parentTransfrom)
  local center = Vector2(0.5, 0.5)
  local rectTransform = self.topPrefabGameObj:GetComponent(typeof(CS.UnityEngine.RectTransform))
  rectTransform.anchorMin = center
  rectTransform.anchorMax = center
  rectTransform.localScale = Vector3(1, 1, 1)
end

function AvgDialogBgComp:ClearTopPrefab()
  if self.topPrefabGameObj then
    CS.UnityEngine.Object.Destroy(self.topPrefabGameObj)
    self.topPrefabGameObj = nil
  end
end

function AvgDialogBgComp:PlayBgAnim(animName, callBack)
  local prefabAnimator, uiAnimationCtrl
  if self.topPrefabGameObj then
    prefabAnimator = self.topPrefabGameObj:GetComponentInChildren(typeof(Animator))
    uiAnimationCtrl = self.topPrefabGameObj:GetComponentInChildren(typeof(UIAnimationController))
  elseif self.bgPrefabGameObj then
    prefabAnimator = self.bgPrefabGameObj:GetComponentInChildren(typeof(Animator))
    uiAnimationCtrl = self.bgPrefabGameObj:GetComponentInChildren(typeof(UIAnimationController))
  end
  if (not prefabAnimator or not uiAnimationCtrl) and callBack then
    callBack()
  end
  animName = string.replace(animName, ",0", "", true)
  if uiAnimationCtrl then
    uiAnimationCtrl:PlayState(animName, callBack)
  else
    local realAniName = string.format("Base Layer.%s", animName)
    if self._lastBgPrefabAni then
      AnimatorUtils.PlayState(prefabAnimator, self._lastBgPrefabAni, -1, 1)
    end
    self._lastBgPrefabAni = realAniName
    AnimatorUtils.PlayState(prefabAnimator, realAniName, -1, 0)
    local animTime = self:GetClipTime(prefabAnimator, animName) or 0
    self.binder:BindTimer(animTime, 0, nil, function()
      if callBack then
        callBack()
      end
    end)
  end
end

function AvgDialogBgComp:GetClipTime(animator, clipName)
  if not animator or not animator.runtimeAnimatorController then
    return
  end
  local clips = animator.runtimeAnimatorController.animationClips
  for i = 0, clips.Length - 1 do
    local clip = clips[i]
    if clip.name == clipName then
      return clip.length
    end
  end
  Logger.Warn("AvgDialogBgComp:GetClipTime not found clipName", clipName)
  return
end

function AvgDialogBgComp:PlayCfgEndAnim(cfgEndAnim)
  local topPrefab, time = table.unpack(cfgEndAnim)
  if DT.CommonID[topPrefab] then
    local avgDialogPanel = UIManager.Instance:GetWindow(Urls.AvgDialogPanelNew)
    if avgDialogPanel then
      avgDialogPanel.uiAnimController:PlayState(topPrefab)
    end
    return
  end
  if not topPrefab or not DT.AvgBg[topPrefab] then
    if topPrefab then
      Logger.Error("PlayCfgEndAnim Error", topPrefab)
    end
    return
  end
  local bgRes = DT.AvgBg[topPrefab].Res
  if not bgRes then
    Logger.Error("Have not bg cfg ", topPrefab)
    return
  end
  self:SetTopPrefab(bgRes)
  time = tonumber(time)
  if time then
    self.binder:BindTimer(time, 0, nil, function()
      self:ClearTopPrefab()
    end)
  end
end

return AvgDialogBgComp
