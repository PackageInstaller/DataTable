local HomeMainBg = class("HomeMainBg")
local CS_Resloader = CS.ResLoader
local CS_Object = CS.UnityEngine.Object
local CS_coroutine = require("XLua.Common.cs_coroutine")

function HomeMainBg:SetLoadedSuccessFunc(func)
  self._loadSuccessFunc = func
end

function HomeMainBg:MainBgSetBind(bind)
  self._mainBind = bind
  self._mainImage = self._mainBind:GetBind("commandCentre_Image")
  if self._bgCfg ~= nil and not string.IsNullOrEmpty(self._bgCfg.src_id_pic_prefab) then
    self._obj = self._mainBind:GetBind(self._bgCfg.src_id_pic_prefab)
  end
  self._stopMeshParentObj = self._mainBind:GetBind("static")
end

function HomeMainBg:UpdateBgId(bgCfg)
  if bgCfg == self._bgCfg then
    if IsNull(self._stopMeshObj) then
      self._resloader:LoadABAssetAsync(PathConsts:GetMainSceneDeckPath(self._bgCfg.stop_mesh), function(stopMeshObj)
        if not IsNull(stopMeshObj) then
          self._stopMeshObj = stopMeshObj:Instantiate()
          self._stopMeshObj:SetActive(self._isShow)
          if not IsNull(self._stopMeshParentObj) then
            self._stopMeshObj.transform:SetParent(self._stopMeshParentObj.transform)
          end
        end
      end)
    end
    return
  end
  if self._oldResloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  else
    self._oldResloader = self._resloader
    self._oldDayMat = self._matDay
    self._oldNightMat = self._matNight
  end
  if self._isShow and not IsNull(self._obj) then
    self._obj:SetActive(false)
  end
  self._textureDay = nil
  self._textureNight = nil
  self._obj = nil
  self._matDay = nil
  self._matNight = nil
  self._bgCfg = bgCfg
  self._resloader = CS_Resloader.Create()
  if not string.IsNullOrEmpty(self._bgCfg.src_id_pic_prefab) and self._mainBind ~= nil then
    self._obj = self._mainBind:GetBind(self._bgCfg.src_id_pic_prefab)
  end
  if not IsNull(self._stopMeshObj) then
    DestroyUnityObject(self._stopMeshObj)
    self._stopMeshObj = nil
  end
  local progress = 5
  self._resloader:LoadABAssetAsync(PathConsts:GetMainSceneDeckPath(self._bgCfg.stop_mesh), function(stopMeshObj)
    progress = progress - 1
    if not IsNull(stopMeshObj) then
      self._stopMeshObj = stopMeshObj:Instantiate()
      self._stopMeshObj:SetActive(false)
      if not IsNull(self._stopMeshParentObj) then
        self._stopMeshObj.transform:SetParent(self._stopMeshParentObj.transform)
      end
    end
    self:__TryApply(progress)
  end)
  self._resloader:LoadABAssetAsync(PathConsts:GetMainSceneBgPath(self._bgCfg.src_id_pic_day), function(texture)
    self._textureDay = texture
    progress = progress - 1
    self:__TryApply(progress)
  end)
  self._resloader:LoadABAssetAsync(PathConsts:GetMainSceneMatPath(self._bgCfg.src_id_mat_day), function(mat)
    if not IsNull(self._matDay) then
      DestroyUnityObject(self._matDay)
    end
    self._matDay = CS_Object.Instantiate(mat)
    progress = progress - 1
    self:__TryApply(progress)
  end)
  self._resloader:LoadABAssetAsync(PathConsts:GetMainSceneBgPath(self._bgCfg.src_id_pic_night), function(texture)
    self._textureNight = texture
    progress = progress - 1
    self:__TryApply(progress)
  end)
  self._resloader:LoadABAssetAsync(PathConsts:GetMainSceneMatPath(self._bgCfg.src_id_mat_night), function(mat)
    if not IsNull(self._matNight) then
      DestroyUnityObject(self._matNight)
    end
    self._matNight = CS_Object.Instantiate(mat)
    progress = progress - 1
    self:__TryApply(progress)
  end)
end

function HomeMainBg:__TryApply(progress)
  if 0 < progress then
    return
  end
  self._matDay.mainTexture = self._textureDay
  self._matNight.mainTexture = self._textureNight
  if self._isShow then
    if not IsNull(self._obj) then
      self._obj:SetActive(self._isShow)
    end
    self:__RefreshHomeMainMat()
  end
  if not IsNull(self._stopMeshObj) then
    self._stopMeshObj:SetActive(self._isShow)
  end
  if not IsNull(self._oldDayMat) then
    DestroyUnityObject(self._oldDayMat)
    self._oldDayMat = nil
  end
  if not IsNull(self._oldNightMat) then
    DestroyUnityObject(self._oldNightMat)
    self._oldNightMat = nil
  end
  if self._oldResloader ~= nil then
    self._oldResloader:Put2Pool()
    self._oldResloader = nil
  end
  if self._loadSuccessFunc ~= nil then
    self._loadSuccessFunc()
  end
end

function HomeMainBg:SetHomeMainEnable(isShow)
  self._isShow = isShow
  if self._bgCfg == nil then
    return
  end
  if not IsNull(self._obj) then
    self._obj:SetActive(self._isShow)
  end
  if not self._isShow then
    if not IsNull(self._stopMeshObj) then
      self._stopMeshObj:SetActive(false)
    end
    return
  end
  self:__RefreshHomeMainMat()
end

function HomeMainBg:SetHomeMainState(isDay)
  self._isDay = isDay
  if self._bgCfg == nil then
    return
  end
  if not self._isShow then
    return
  end
  self:__RefreshHomeMainMat()
end

function HomeMainBg:__RefreshHomeMainMat()
  if IsNull(self._mainImage) or IsNull(self._matDay) or IsNull(self._matNight) then
    return
  end
  if not IsNull(self._stopMeshObj) then
    self._stopMeshObj:SetActive(true)
  end
  self._mainImage.material = self._isDay and self._matDay or self._matNight
end

function HomeMainBg:ClearMainBgRes()
  self._bgCfg = nil
  self._textureDay = nil
  self._textureNight = nil
  if not IsNull(self._obj) then
    self._obj = nil
  end
  if not IsNull(self._matDay) then
    DestroyUnityObject(self._matDay)
    self._matDay = nil
  end
  if not IsNull(self._matNight) then
    DestroyUnityObject(self._matNight)
    self._matNight = nil
  end
  if not IsNull(self._stopMeshObj) then
    DestroyUnityObject(self._stopMeshObj)
    self._stopMeshObj = nil
  end
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  if not IsNull(self._oldDayMat) then
    DestroyUnityObject(self._oldDayMat)
    self._oldDayMat = nil
  end
  if not IsNull(self._oldNightMat) then
    DestroyUnityObject(self._oldNightMat)
    self._oldNightMat = nil
  end
  if self._oldResloader ~= nil then
    self._oldResloader:Put2Pool()
    self._oldResloader = nil
  end
end

function HomeMainBg:Delete()
  self:ClearMainBgRes()
end

return HomeMainBg
