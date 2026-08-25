local DOTween = CS.DG.Tweening.DOTween
local MeshRenderer = CS.UnityEngine.MeshRenderer
local SpineMaterialReplace = CS.Z1Client.SpineMaterialReplace
local PropId = MaterialUtils.ShderPropertyId
local PType = MaterialUtils.PropertyType
local PFeatureMap = MaterialUtils.FeatureMap
local TexPath = MaterialUtils.TexturePath
local CsMaterial = typeof(CS.UnityEngine.Material)
local BattleMaterialEffect, Super = System.NewClass("BattleMaterialEffect")

function BattleMaterialEffect:ctor(entity, spineNode)
  Super.ctor(self, entity)
  self.entity = entity
  self.spineNode = spineNode
  self.effectCnt = {}
  self.tweenerMap = {}
end

function BattleMaterialEffect:PlayMaterialEffect(effectlist)
  local spineNode = self.spineNode
  if nil == spineNode or IsNil(spineNode) then
    return
  end
  local stopAni = 1 == effectlist[1]
  local effectType = effectlist[2]
  self:AddEffectCnt(effectType)
  if self:IsInEffect(effectType) then
    return
  end
  local duration = effectlist[3]
  local renderer = spineNode:GetComponent(typeof(MeshRenderer))
  if 0 == renderer.materials.Length then
    return
  end
  local templateMat = self:GetMaterial(effectType)
  if nil == templateMat then
    return
  end
  self:CallBack()
  self:PreSetMaterial(spineNode, renderer)
  self:RecordMatOriParam(effectType, renderer, templateMat)
  self:PlayMatParam(effectType, renderer, duration, templateMat)
  self:FixAnimation(effectType, stopAni)
  self:OutlineEffect(effectType, renderer)
end

function BattleMaterialEffect:Set24ShaderSwitch(isOpen)
  local spineNode = self.spineNode
  if nil == spineNode or IsNil(spineNode) then
    return
  end
  local renderer = spineNode:GetComponent(typeof(MeshRenderer))
  local effectKey = "24ShaderSwitch"
  if isOpen then
    self:PreSetMaterial(spineNode, renderer)
    self:AddEffectCnt(effectKey)
    self.renderMat:EnableKeyword("_SPECULARKEY_ON")
    self.renderMat:EnableKeyword("_DARK_ON")
  else
    self.effectCnt[effectKey] = 0
    self.renderMat:DisableKeyword("_SPECULARKEY_ON")
    self.renderMat:DisableKeyword("_DARK_ON")
  end
end

function BattleMaterialEffect:IsInEffect(effectType)
  local roleEffect = self:GetRoleAllEffect()
  local temp = roleEffect[effectType]
  return nil ~= temp
end

function BattleMaterialEffect:AddEffectCnt(effectType)
  self.effectCnt[effectType] = self.effectCnt[effectType] or 0
  self.effectCnt[effectType] = self.effectCnt[effectType] + 1
end

function BattleMaterialEffect:SubEffectCnt(effectType)
  local oriCnt = self.effectCnt[effectType] or 0
  oriCnt = oriCnt - 1
  oriCnt = oriCnt >= 0 and oriCnt or 0
  self.effectCnt[effectType] = oriCnt
end

function BattleMaterialEffect:GetEffectCnt(effectType)
  return self.effectCnt[effectType] or 0
end

function BattleMaterialEffect:PreSetMaterial(spineNode, renderer)
  if not self.renderMat then
    self.renderMat = renderer.material
    local spineMaterialReplace = self:GetOrAddSpineMaterialReplace(spineNode)
    spineMaterialReplace:SetMaterial(self.renderMat)
    self:RecordBaseMatParams()
  end
end

function BattleMaterialEffect:RecordBaseMatParams()
  if self.baseStaticProps or not self.renderMat then
    return
  end
  local p = {}
  local mat = self.renderMat
  for k, v in pairs(PropId) do
    if k:startswith("F_") then
      self:SetProperty(p, v, PType.Float, mat)
    elseif k:startswith("C_") then
      self:SetProperty(p, v, PType.Color, mat)
    elseif k:startswith("V_") then
      self:SetProperty(p, v, PType.Vector, mat)
    elseif k:startswith("K_") then
      self:SetProperty(p, v, PType.Key, mat)
    elseif k:startswith("E_") then
      self:SetProperty(p, v, PType.Enum, mat)
    elseif k:startswith("T_") then
      self:SetProperty(p, v, PType.Tex, mat)
    end
  end
  self.baseStaticProps = p
end

function BattleMaterialEffect:GetOrAddSpineMaterialReplace(spineNode)
  local spineMaterialReplace = spineNode:GetComponent(typeof(SpineMaterialReplace))
  spineMaterialReplace = spineMaterialReplace or spineNode:AddComponent(typeof(SpineMaterialReplace))
  return spineMaterialReplace
end

function BattleMaterialEffect:OutlineEffect(effectType, renderer)
  if effectType == MaterialUtils.EffectType.Stone or effectType == MaterialUtils.EffectType.VajraBody or effectType == MaterialUtils.EffectType.IgnoreDamage or effectType == MaterialUtils.EffectType.GrayBody then
    self:OpenOutline(renderer)
  end
end

function BattleMaterialEffect:ClearMaterialEffect(effectlist, isFriend)
  local effectType = effectlist[2]
  local duration = effectlist[3]
  local needStop = false
  self:SubEffectCnt(effectType)
  if self:GetEffectCnt(effectType) > 0 then
    return
  end
  self:_ClearMaterialEffect(effectType, duration, needStop)
  if MaterialUtils.EffectType.Stone == effectType then
    local eventName = isFriend and "Play_SFX_Ft_Debuff_Petrify_Off_Player" or "Play_SFX_Ft_Debuff_Petrify_Off_En"
    AudioManager.Instance:PostSoundEvent(eventName)
  end
end

function BattleMaterialEffect:_ClearMaterialEffect(effectType, duration, needStop, skipReApply)
  local spineNode = self.spineNode
  if nil == spineNode or IsNil(spineNode) then
    return
  end
  local renderer = spineNode:GetComponent(typeof(MeshRenderer))
  local matParam = self:GetRoleTypeEffect(effectType)
  if nil == matParam then
    return
  end
  self:ReSetMatParam(effectType, renderer, duration, needStop, skipReApply)
end

function BattleMaterialEffect:ResetAll()
  self:ClearTweener()
  local spineNode = self.spineNode
  if nil == spineNode or IsNil(spineNode) then
    return
  end
  local needStop = false
  for effectType, cnt in pairs(self.effectCnt) do
    if cnt > 0 then
      local duration = 0
      self:_ClearMaterialEffect(effectType, duration, needStop, true)
    end
  end
  local spineMaterialReplace = spineNode:GetComponent(typeof(SpineMaterialReplace))
  if spineMaterialReplace then
    spineMaterialReplace:SetMaterial(nil)
  end
  self.effectCnt = {}
  self.renderMat = nil
  self.baseStaticProps = nil
  self.aniState = nil
  self.isUseCfgParams = true
end

function BattleMaterialEffect:GetMaterial(effectType)
  local path = MaterialUtils.MatEffetPath[effectType]
  local spineNode = self.spineNode
  local curSpineName = string.replace(spineNode.transform.parent.name, "(Clone)", "", true)
  local cfgId = MaterialUtils.SpecialMatTemple[effectType]
  local specialSpineList = bg.DT.GetOriginalConstant(cfgId)
  if specialSpineList then
    for i = 1, #specialSpineList, 2 do
      local spineName = specialSpineList[i]
      local matName = specialSpineList[i + 1]
      if spineName == curSpineName then
        path = "Render/Material/ActorTemplate/" .. matName .. ".mat"
        self.isUseCfgParams = false
        break
      end
    end
  end
  if path then
    local result = ResLoadMgr.LoadAsset(path, self, CsMaterial)
    return result
  end
  return nil
end

function BattleMaterialEffect:RecordMatOriParam(effectType, renderer, templateMat)
  local matParam = self:GetRoleTypeEffect(effectType)
  matParam.resetDynamicProps = self:GetDynamicData(effectType, templateMat, self.renderMat, self.isUseCfgParams)
  matParam.resetStaticProps = self:GetStaticData(effectType, self.renderMat, true)
end

function BattleMaterialEffect:PlayMatParam(effectType, renderer, duration, templateMat)
  local data = {}
  data.renderer = renderer
  data.duration = duration
  data.dynamicProps = self:GetDynamicData(effectType, self.renderMat, templateMat)
  data.staticProps = self:GetStaticData(effectType, templateMat)
  self:BaseSetMaterial(effectType, data)
  local matParam = self:GetRoleTypeEffect(effectType)
  matParam.finalDynamicProps = data.dynamicProps
  matParam.finalstaticProps = data.staticProps
  self:FixShareProperty(renderer)
end

function BattleMaterialEffect:ReSetMatParam(effectType, renderer, duration, needStop, skipReApply)
  local data = {}
  data.renderer = renderer
  data.duration = duration
  data.dynamicCallBack = nil
  local matParam = self:GetRoleTypeEffect(effectType)
  if self.baseStaticProps then
    data.dynamicProps = self:BuildDynamicResetToBase(effectType)
    data.staticProps = self.baseStaticProps
  else
    data.dynamicProps = matParam.resetDynamicProps
    data.staticProps = matParam.resetStaticProps
  end
  
  function data.dynamicCallBack()
    self:SetStaticProps(data.renderer, data.staticProps)
    self:ClearRoleTypeEffect(effectType, renderer)
    self:FixAnimation(effectType, needStop)
    if effectType == MaterialUtils.EffectType.Stone or effectType == MaterialUtils.EffectType.VajraBody or effectType == MaterialUtils.EffectType.IgnoreDamage or effectType == MaterialUtils.EffectType.GrayBody then
      self:CloseOutLine(renderer)
    end
    if not skipReApply then
      self:ReApplyRemainingEffects(renderer)
    end
  end
  
  self:SetDynamicProps(data.renderer, data.duration, data.dynamicProps, data.dynamicCallBack)
end

function BattleMaterialEffect:BuildDynamicResetToBase(effectType)
  local p = {}
  if not self.renderMat or not self.baseStaticProps then
    return p
  end
  local progressId
  if effectType == MaterialUtils.EffectType.Stone then
    progressId = PropId.F_MaskDissolveProgress
  elseif effectType == MaterialUtils.EffectType.VajraBody or effectType == MaterialUtils.EffectType.IgnoreDamage then
    progressId = PropId.F_GoldenBody
  end
  if not progressId or not self.renderMat:HasProperty(progressId) then
    return p
  end
  local baseProp = self.baseStaticProps[progressId]
  if not baseProp then
    return p
  end
  local curValue = self.renderMat:GetFloat(progressId)
  local baseValue = baseProp[2]
  table.insert(p, {
    progressId,
    curValue,
    baseValue
  })
  return p
end

function BattleMaterialEffect:ReApplyRemainingEffects(renderer)
  if not self.renderMat or not renderer then
    return
  end
  local remaining = self:GetSortedRemainingEffectTypes()
  if #remaining <= 0 then
    return
  end
  local all = self:GetRoleAllEffect()
  for _, effectType in ipairs(remaining) do
    local matParam = all[effectType]
    if matParam and matParam.finalstaticProps then
      self:SetStaticProps(renderer, matParam.finalstaticProps)
      self:ApplyFinalDynamicProps(matParam.finalDynamicProps)
    end
  end
  self:FixShareProperty(renderer)
end

function BattleMaterialEffect:GetSortedRemainingEffectTypes()
  local all = self:GetRoleAllEffect()
  local list = {}
  for effectType, matParam in pairs(all) do
    if matParam and matParam.finalstaticProps and self:GetEffectCnt(effectType) > 0 then
      table.insert(list, effectType)
    end
  end
  table.sort(list, function(a, b)
    local weightA = MaterialUtils.EffectWeight[a] or 0
    local weightB = MaterialUtils.EffectWeight[b] or 0
    return weightA < weightB
  end)
  return list
end

function BattleMaterialEffect:ApplyFinalDynamicProps(dynamicProps)
  if not dynamicProps or #dynamicProps <= 0 or not self.renderMat then
    return
  end
  for _, v in ipairs(dynamicProps) do
    local progressId = v[1]
    local resultValue = v[3]
    if progressId and nil ~= resultValue then
      self.renderMat:SetFloat(progressId, resultValue)
    end
  end
end

function BattleMaterialEffect:BaseSetMaterial(effectType, data)
  self:SetStaticProps(data.renderer, data.staticProps)
  self:SetDynamicProps(data.renderer, data.duration, data.dynamicProps, data.dynamicCallBack)
end

function BattleMaterialEffect:ClearTweener(callback)
  for id, tweener in pairs(self.tweenerMap) do
    tweener:Kill(true)
  end
  self.tweenerMap = {}
end

function BattleMaterialEffect:CallBack()
  if self.curCallBack then
    self.curCallBack()
    self.curCallBack = nil
  end
end

function BattleMaterialEffect:SetDynamicProps(renderer, duration, dynamicProps, callback)
  self:ClearTweener()
  self.curCallBack = callback
  if not dynamicProps or #dynamicProps <= 0 then
    self.curCallBack = nil
    if callback then
      callback()
    end
    return
  end
  for _, v in ipairs(dynamicProps) do
    local progressId = v[1]
    local oriValue = v[2]
    local resultValue = v[3]
    local dura = v[4] or duration
    if duration > 0 then
      self.tweenerMap[progressId] = DOTween.To(function()
        return oriValue
      end, function(newV)
        self.renderMat:SetFloat(progressId, newV)
      end, resultValue, dura, self):OnComplete(function()
        self:CallBack()
      end)
    else
      self.renderMat:SetFloat(progressId, resultValue)
      self:CallBack()
    end
  end
end

function BattleMaterialEffect:SetStaticProps(renderer, propertys)
  if nil == propertys then
    return
  end
  for propertyId, v in pairs(propertys) do
    local type = v[1]
    local propertyValue = v[2]
    if type == PType.Color then
      self.renderMat:SetColor(propertyId, propertyValue)
    elseif type == PType.Float then
      self.renderMat:SetFloat(propertyId, propertyValue)
    elseif type == PType.Tex then
      self.renderMat:SetTexture(propertyId, propertyValue)
    elseif type == PType.Key then
      self.renderMat:SetFloat(propertyId, propertyValue)
      local func = 0 == propertyValue and "DisableKeyword" or "EnableKeyword"
      self.renderMat[func](self.renderMat, PFeatureMap[propertyId])
    elseif type == PType.Enum then
      self.renderMat:SetFloat(propertyId, propertyValue)
      local enableKey = propertyValue
      local map = PFeatureMap[propertyId]
      for index, feature in ipairs(map) do
        local key = index - 1
        local func = enableKey == key and "EnableKeyword" or "DisableKeyword"
        self.renderMat[func](self.renderMat, feature)
      end
    elseif type == PType.Vector then
      self.renderMat:SetVector(propertyId, propertyValue)
    end
  end
end

function BattleMaterialEffect:GetDynamicData(effectType, oriMat, targetMat, isUseCfgParams)
  local p = {}
  if effectType == MaterialUtils.EffectType.Stone then
    local progressId = PropId.F_MaskDissolveProgress
    if oriMat:HasProperty(progressId) and targetMat:HasProperty(progressId) then
      if isUseCfgParams then
        local animCfg = self.entity:GetAnimationConfig()
        local spineSize = animCfg.spineSize
        local dieDissolveCfgName = spineSize and CommonDefine.SpineStoneDissolve[spineSize]
        if dieDissolveCfgName then
          local dieDissolveParams = bg.DT.GetOriginalConstant(dieDissolveCfgName)
          if dieDissolveParams then
            local dissolveStart, dissolveEnd, dissoleDura = table.unpack(dieDissolveParams)
            table.insert(p, {
              progressId,
              dissolveEnd,
              dissolveStart,
              dissoleDura
            })
            return p
          end
        end
      end
      local oriValue = oriMat:GetFloat(progressId)
      local resultValue = targetMat:GetFloat(progressId)
      table.insert(p, {
        progressId,
        oriValue,
        resultValue
      })
    end
  elseif effectType == MaterialUtils.EffectType.VajraBody or effectType == MaterialUtils.EffectType.IgnoreDamage then
    local progressId = PropId.F_GoldenBody
    if oriMat:HasProperty(progressId) and targetMat:HasProperty(progressId) then
      local oriValue = oriMat:GetFloat(progressId)
      local resultValue = targetMat:GetFloat(progressId)
      table.insert(p, {
        progressId,
        oriValue,
        resultValue
      })
    end
  end
  return p
end

function BattleMaterialEffect:GetMatValue(propId, pType, mat)
  if pType == PType.Color then
    do return mat.GetColor, mat end
    return mat.GetColor, mat, propId
  elseif pType == PType.Float then
    do return mat.GetFloat, mat end
    return mat.GetFloat, mat, propId
  elseif pType == PType.Enum then
    do return mat.GetFloat, mat end
    return mat.GetFloat, mat, propId
  elseif pType == PType.Tex then
    do return mat.GetTexture, mat end
    return mat.GetTexture, mat, propId
  elseif pType == PType.Key then
    do return mat.GetFloat, mat end
    return mat.GetFloat, mat, propId
  elseif pType == PType.Vector then
    do return mat.GetVector, mat end
    return mat.GetVector, mat, propId
  end
  return nil
end

function BattleMaterialEffect:SetProperty(p, propId, pType, mat)
  if mat:HasProperty(propId) then
    local value = self:GetMatValue(propId, pType, mat)
    p[propId] = {pType, value}
  end
end

function BattleMaterialEffect:GetStaticData(effectType, mat, notTexture)
  local p = {}
  local needSetTexture = not notTexture
  if effectType == MaterialUtils.EffectType.Stone then
    self:SetProperty(p, PropId.C_EdgeColor, PType.Color, mat)
    self:SetProperty(p, PropId.C_OutlineColorStone, PType.Color, mat)
    self:SetProperty(p, PropId.C_UpColor, PType.Color, mat)
    self:SetProperty(p, PropId.F_UpColorContrast, PType.Float, mat)
    self:SetProperty(p, PropId.F_UpColorRange, PType.Float, mat)
    self:SetProperty(p, PropId.F_UnderColorContrast, PType.Float, mat)
    self:SetProperty(p, PropId.F_UnderColorRange, PType.Float, mat)
    self:SetProperty(p, PropId.F_OnOff, PType.Float, mat)
    self:SetProperty(p, PropId.C_GlowMapColor, PType.Color, mat)
    self:SetProperty(p, PropId.E_OutlineKey, PType.Enum, mat)
    self:SetProperty(p, PropId.E_OutlineColorKey, PType.Enum, mat)
    self:SetProperty(p, PropId.F_OutLineWidth, PType.Float, mat)
    if needSetTexture then
      self:SetProperty(p, PropId.T_MaskTex, PType.Tex, mat)
      table.insert(p[PropId.T_MaskTex], TexPath.StoneMaskTex)
      self:SetProperty(p, PropId.V_MaskTex_ST, PType.Vector, mat)
      self:SetProperty(p, PropId.T_MaskDissolveTex, PType.Tex, mat)
      table.insert(p[PropId.T_MaskDissolveTex], TexPath.StoneMaskDissolveTex)
      self:SetProperty(p, PropId.T_GlowMap, PType.Tex, mat)
      table.insert(p[PropId.T_GlowMap], TexPath.StoneGlowMapTex)
    end
  elseif effectType == MaterialUtils.EffectType.VajraBody or effectType == MaterialUtils.EffectType.IgnoreDamage then
    self:SetProperty(p, PropId.C_EdgeColor, PType.Color, mat)
    self:SetProperty(p, PropId.C_OutlineColorGBody, PType.Color, mat)
    self:SetProperty(p, PropId.C_GoldenBodyGColor, PType.Color, mat)
    self:SetProperty(p, PropId.F_GBodyy, PType.Float, mat)
    self:SetProperty(p, PropId.F_GBodyx, PType.Float, mat)
    self:SetProperty(p, PropId.F_GBodySpeed, PType.Float, mat)
    self:SetProperty(p, PropId.K_GoldenBodyKey, PType.Key, mat)
    self:SetProperty(p, PropId.E_OutlineKey, PType.Enum, mat)
    self:SetProperty(p, PropId.E_OutlineColorKey, PType.Enum, mat)
    self:SetProperty(p, PropId.F_OutLineWidth, PType.Float, mat)
    if needSetTexture then
      self:SetProperty(p, PropId.T_GoldenBodyGlow, PType.Tex, mat)
      table.insert(p[PropId.T_GoldenBodyGlow], TexPath.VajraBodyTex)
    end
  else
    for k, v in pairs(PropId) do
      if k:startswith("F_") then
        self:SetProperty(p, v, PType.Float, mat)
      end
      if k:startswith("C_") then
        self:SetProperty(p, v, PType.Color, mat)
      end
      if k:startswith("V_") then
        self:SetProperty(p, v, PType.Vector, mat)
      end
      if k:startswith("K_") then
        self:SetProperty(p, v, PType.Key, mat)
      end
      if k:startswith("E_") then
        self:SetProperty(p, v, PType.Enum, mat)
      end
    end
    if needSetTexture and effectType == MaterialUtils.EffectType.GrayBody then
      self:SetProperty(p, PropId.T_GoldenBodyGlow, PType.Tex, mat)
    end
  end
  return p
end

function BattleMaterialEffect:FixAnimation(effectType, needStop)
  self.aniState = self.aniState or {}
  if needStop then
    self.aniState[effectType] = needStop
  else
    self.aniState[effectType] = nil
  end
  local result = false
  for _, state in pairs(self.aniState) do
    if state then
      result = true
      break
    end
  end
  local spineComp = self.entity:GetSpineCom()
  if not spineComp then
    return
  end
  if result then
    spineComp:Pause()
  else
    spineComp:UnPause()
  end
end

function BattleMaterialEffect:OpenOutline(renderer)
  MaterialUtils.OpenOutLine()
  local ref = self.OutlineCnt or 0
  local oriCnt = ref
  ref = ref + 1
  self.OutlineCnt = ref
  if 0 == oriCnt then
    MaterialUtils.AddOutlineLayer(renderer)
  end
end

function BattleMaterialEffect:CloseOutLine(renderer)
  MaterialUtils.CloseOutLine()
  local ref = self.OutlineCnt or 0
  local oriCnt = ref
  ref = ref - 1
  ref = ref >= 0 and ref or 0
  self.OutlineCnt = ref
  if 1 == oriCnt then
    MaterialUtils.SubOutlineLayer(renderer)
  end
end

function BattleMaterialEffect:GetRoleAllEffect()
  self.materialEffect = self.materialEffect or {}
  return self.materialEffect
end

function BattleMaterialEffect:GetRoleTypeEffect(effectType)
  local roleEffect = self:GetRoleAllEffect()
  local temp = roleEffect[effectType]
  if not temp then
    temp = {}
    roleEffect[effectType] = temp
  end
  return temp
end

function BattleMaterialEffect:ClearRoleTypeEffect(effectType, renderer)
  local roleEffect = self:GetRoleAllEffect()
  roleEffect[effectType] = nil
end

function BattleMaterialEffect:FixShareProperty(renderer)
  local effectType = self:GetMaxWeightEffectType()
  if nil == effectType then
    return
  end
  local matParam = self:GetRoleTypeEffect(effectType)
  if not matParam.finalstaticProps then
    return
  end
  local p = {}
  p[PropId.E_OutlineKey] = matParam.finalstaticProps[PropId.E_OutlineKey]
  p[PropId.E_OutlineColorKey] = matParam.finalstaticProps[PropId.E_OutlineColorKey]
  self:SetStaticProps(renderer, p)
end

function BattleMaterialEffect:GetMaxWeightEffectType()
  local all = self:GetRoleAllEffect()
  local maxType
  local maxWeight = 0
  for effectType, _ in pairs(all) do
    local weight = MaterialUtils.EffectWeight[effectType]
    if nil == maxType or maxWeight < weight then
      maxType = effectType
      maxWeight = weight
    end
  end
  return maxType
end

function BattleMaterialEffect:Dispose()
  self:ResetAll()
end

return BattleMaterialEffect
