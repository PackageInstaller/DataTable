local UINBaseHead = class("UINBaseHead", UIBaseNode)
local base = UIBaseNode

function UINBaseHead:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINBaseHead:InitBaseHead(headId, resloader, frameEffectPool)
  self.ui.img_Frame.gameObject:SetActive(false)
  self:__RecycleFrameEffect(frameEffectPool)
  self:__InitBaseHead(headId, resloader)
end

function UINBaseHead:SetLoadHeadSync()
  self._isLoadSync = true
end

function UINBaseHead:__InitBaseHead(headId, resloader)
  self.ui.img_UserHead.gameObject:SetActive(false)
  self.ui.img_DynHead.gameObject:SetActive(false)
  if headId == nil then
    return
  end
  local cfg = ConfigData.portrait[headId]
  if cfg == nil then
    return
  end
  if not string.IsNullOrEmpty(cfg.dyn_head) and resloader ~= nil then
    self.ui.img_DynHead.gameObject:SetActive(true)
    self.ui.img_DynHead.texture = resloader:LoadABAsset(PathConsts:GetDynHeadPath(cfg.dyn_head))
    return
  end
  local icon = cfg.icon
  if not string.IsNullOrEmpty(icon) then
    self.ui.img_UserHead.gameObject:SetActive(true)
    self.ui.img_UserHead.sprite = CRH:GetSprite(icon, CommonAtlasType.HeroHeadIcon)
  end
end

function UINBaseHead:InitBaseHeadFrame(frameId, resloader, frameEffectPool)
  self.ui.img_UserHead.gameObject:SetActive(false)
  self.ui.img_DynHead.gameObject:SetActive(false)
  self:__InitBaseHeadFrame(frameId, resloader, frameEffectPool)
end

function UINBaseHead:__InitBaseHeadFrame(frameId, resloader, frameEffectPool)
  self.ui.img_Frame.gameObject:SetActive(true)
  if frameId == nil then
    self:__RecycleFrameEffect(frameEffectPool)
    return
  end
  self:__RecycleFrameEffect(frameEffectPool)
  self.__frameId = frameId
  local cfg = ConfigData.portrait_frame[frameId]
  if cfg == nil then
    return
  end
  if cfg.fx_type > 0 and resloader ~= nil then
    local go
    if frameEffectPool ~= nil then
      go = frameEffectPool:PoolGet(frameId)
    end
    if go == nil then
      local path = PathConsts:GetDynHeadFramePath(cfg.dyn_frame)
      if self._isLoadSync then
        local prefab = resloader:LoadABAsset(path)
        self:_OnFrameLoaded(prefab, frameId, frameEffectPool)
      else
        resloader:LoadABAssetAsync(path, function(prefab)
          self:_OnFrameLoaded(prefab, frameId, frameEffectPool)
        end)
      end
    else
      self:_SetFrameEffectGo(go, frameId)
    end
    if cfg.fx_type == eHeadFrameFxType.Sequence then
      self.ui.img_Frame.enabled = false
      return
    end
  end
  self.ui.img_Frame.enabled = true
  self.ui.img_Frame.sprite = CRH:GetSprite(cfg.icon, CommonAtlasType.HeroHeadIcon)
end

function UINBaseHead:_OnFrameLoaded(prefab, frameId, frameEffectPool)
  if IsNull(prefab) or self.__frameId ~= frameId then
    if self.__frameId ~= self.__effectFrameId then
      self:__RecycleFrameEffect(frameEffectPool)
    end
    return
  end
  self:__RecycleFrameEffect(frameEffectPool)
  local go = prefab:Instantiate(self.ui.img_Frame.transform)
  self:_SetFrameEffectGo(go, frameId)
end

function UINBaseHead:_SetFrameEffectGo(go, frameId)
  self.__frameEffect = go
  self.__frameEffect.transform:SetParent(self.ui.img_Frame.transform)
  self.__frameEffect.transform.localPosition = Vector3.zero
  self.__effectFrameId = frameId
end

function UINBaseHead:__RecycleFrameEffect(frameEffectPool)
  if self.__frameEffect == nil then
    return
  end
  if frameEffectPool == nil then
    DestroyUnityObject(self.__frameEffect)
    self.__frameEffect = nil
    self.__effectFrameId = nil
    return
  end
  if self.__effectFrameId ~= nil then
    frameEffectPool:PoolPut(self.__effectFrameId, self.__frameEffect)
    self.__frameEffect = nil
    self.__effectFrameId = nil
  else
    DestroyUnityObject(self.__frameEffect)
    self.__frameEffect = nil
  end
end

function UINBaseHead:InitBaseHeadFull(headId, frameId, resloader, frameEffectPool)
  self:__InitBaseHead(headId, resloader)
  self:__InitBaseHeadFrame(frameId, resloader, frameEffectPool)
end

function UINBaseHead:OnDelete()
  base.OnDelete(self)
end

return UINBaseHead
