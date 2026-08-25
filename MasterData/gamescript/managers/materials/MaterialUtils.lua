local LuaCSharpUtil = CS.Z1Client.LuaCSharpUtil
local MaterialUtils = {}
MaterialUtils.AwakerPortraitEffect = System.NewEnum({
  Revert = 0,
  ToBase = 1,
  ToDark = 2,
  ToOrigin1 = 3,
  ToOrigin2 = 4
})
MaterialUtils.PortraitShaderPropertyId = System.NewEnum({
  CircleKey = CS.UnityEngine.Shader.PropertyToID("_CircleKey"),
  AMax = CS.UnityEngine.Shader.PropertyToID("_AMax"),
  BackMin1 = CS.UnityEngine.Shader.PropertyToID("_BackMin"),
  LightDarkD = CS.UnityEngine.Shader.PropertyToID("_LightDarkD")
})
MaterialUtils.PortraitFeatureMap = System.NewEnum({
  [MaterialUtils.PortraitShaderPropertyId.CircleKey] = {
    "_CIRCLEKEY_NORMAL",
    "_CIRCLEKEY_BACK",
    "_CIRCLEKEY_CIRCLEKEYA",
    "_CIRCLEKEY_CIRCLEKEYB",
    "_CIRCLEKEY_CIRCLEKEYC"
  }
})
MaterialUtils.EffectType = System.NewEnum({
  Stone = "Stone",
  Ice = "",
  VajraBody = "VajraBody",
  IgnoreDamage = "IgnoreDamage",
  GrayBody = "GrayBody"
})
MaterialUtils.EffectWeight = System.NewEnum({
  [MaterialUtils.EffectType.Stone] = 0,
  [MaterialUtils.EffectType.Ice] = 1,
  [MaterialUtils.EffectType.VajraBody] = 2,
  [MaterialUtils.EffectType.IgnoreDamage] = 3,
  [MaterialUtils.EffectType.GrayBody] = 4
})
MaterialUtils.MatEffetPath = System.NewEnum({
  [MaterialUtils.EffectType.Stone] = CommonRes.BattleMaterial.Stone[1],
  [MaterialUtils.EffectType.VajraBody] = CommonRes.BattleMaterial.VajraBody[1],
  [MaterialUtils.EffectType.IgnoreDamage] = CommonRes.BattleMaterial.IgnoreDamage[1],
  [MaterialUtils.EffectType.GrayBody] = CommonRes.BattleMaterial.GrayBody[1]
})
MaterialUtils.SpecialMatTemple = System.NewEnum({
  [MaterialUtils.EffectType.Stone] = "EffectType_StoneEffect_SpecialMatTemple",
  [MaterialUtils.EffectType.VajraBody] = "EffectType_VajraBody_SpecialMatTemple"
})
MaterialUtils.TexturePath = System.NewEnum({
  StoneMaskTex = CommonRes.BattleMaterial.StoneMaskTex[1],
  StoneMaskDissolveTex = CommonRes.BattleMaterial.StoneMaskDissolveTex[1],
  StoneGlowMapTex = CommonRes.BattleMaterial.StoneGlowMapTex[1],
  VajraBodyTex = CommonRes.BattleMaterial.VajraBodyTex[1]
})
MaterialUtils.ShderPropertyId = System.NewEnum({
  F_MaskDissolveProgress = CS.UnityEngine.Shader.PropertyToID("_MaskDissolveProgress"),
  C_OutlineColorStone = CS.UnityEngine.Shader.PropertyToID("_OutlineColorStone"),
  C_UpColor = CS.UnityEngine.Shader.PropertyToID("_UpColor"),
  F_UpColorContrast = CS.UnityEngine.Shader.PropertyToID("_UpColorContrast"),
  F_UpColorRange = CS.UnityEngine.Shader.PropertyToID("_UpColorRange"),
  F_UnderColorContrast = CS.UnityEngine.Shader.PropertyToID("_UnderColorContrast"),
  F_UnderColorRange = CS.UnityEngine.Shader.PropertyToID("_UnderColorRange"),
  F_OnOff = CS.UnityEngine.Shader.PropertyToID("_OnOff"),
  T_MaskTex = CS.UnityEngine.Shader.PropertyToID("_MaskTex"),
  V_MaskTex_ST = CS.UnityEngine.Shader.PropertyToID("_MaskTex_ST"),
  T_MaskDissolveTex = CS.UnityEngine.Shader.PropertyToID("_MaskDissolveTex"),
  T_GlowMap = CS.UnityEngine.Shader.PropertyToID("_GlowMap"),
  C_MaskDissolveEdgeColor = CS.UnityEngine.Shader.PropertyToID("_MaskDissolveEdgeColor"),
  F_MaskDissolveEdgeWidth = CS.UnityEngine.Shader.PropertyToID("_MaskDissolveEdgeWidth"),
  C_GlowMapColor = CS.UnityEngine.Shader.PropertyToID("_GlowMapColor"),
  C_OutlineColorGBody = CS.UnityEngine.Shader.PropertyToID("_OutlineColorGBody"),
  K_GoldenBodyKey = CS.UnityEngine.Shader.PropertyToID("_GoldenBodyKey"),
  F_GoldenBody = CS.UnityEngine.Shader.PropertyToID("_GoldenBody"),
  T_GoldenBodyGlow = CS.UnityEngine.Shader.PropertyToID("_GoldenBodyGlow"),
  V_GoldenBodyGlow_ST = CS.UnityEngine.Shader.PropertyToID("_GoldenBodyGlow_ST"),
  C_GoldenBodyGColor = CS.UnityEngine.Shader.PropertyToID("_GoldenBodyGColor"),
  F_GBodyy = CS.UnityEngine.Shader.PropertyToID("_GBodyy"),
  F_GBodyx = CS.UnityEngine.Shader.PropertyToID("_GBodyx"),
  F_GBodySpeed = CS.UnityEngine.Shader.PropertyToID("_GBodySpeed"),
  F_GlowMapSpeed = CS.UnityEngine.Shader.PropertyToID("_GlowMapSpeed"),
  F_MaskY = CS.UnityEngine.Shader.PropertyToID("_MaskY"),
  E_OutlineKey = CS.UnityEngine.Shader.PropertyToID("_OutlineKey"),
  E_OutlineColorKey = CS.UnityEngine.Shader.PropertyToID("_OutlineColorKey"),
  C_EdgeColor = CS.UnityEngine.Shader.PropertyToID("_EdgeColor"),
  F_OutLineWidth = CS.UnityEngine.Shader.PropertyToID("_OutLineWidth"),
  K_OpenAlphaOriTex = CS.UnityEngine.Shader.PropertyToID("_OPEN_ALPHA_ORITEX"),
  C_Color = CS.UnityEngine.Shader.PropertyToID("_Color"),
  F_YY = CS.UnityEngine.Shader.PropertyToID("_YY"),
  F_EdgeYMax1 = CS.UnityEngine.Shader.PropertyToID("_EdgeYMax1"),
  F_EdgeYMin1 = CS.UnityEngine.Shader.PropertyToID("_EdgeYMin1")
})
MaterialUtils.FeatureMap = System.NewEnum({
  [MaterialUtils.ShderPropertyId.K_GoldenBodyKey] = "_GOLDENBODYKEY_ON",
  [MaterialUtils.ShderPropertyId.E_OutlineKey] = {
    "_OUTLINEKEY_UNOUTLINE",
    "_OUTLINEKEY_OUTLINESTONE",
    "_OUTLINEKEY_OUTLINEGBODY"
  },
  [MaterialUtils.ShderPropertyId.E_OutlineColorKey] = {
    "_OUTLINECOLORKEY_OUTLINECOLORSTONE",
    "_OUTLINECOLORKEY_OUTLINECOLORGBODY"
  },
  [MaterialUtils.ShderPropertyId.K_OpenAlphaOriTex] = "_OPEN_ALPHA_ORITEX_ON"
})
MaterialUtils.PropertyType = System.NewEnum({
  Float = 0,
  Color = 1,
  Tex = 2,
  Key = 3,
  Enum = 4,
  Vector = 5
})

function MaterialUtils.OpenOutLine()
  local ref = MaterialUtils.OutlineCnt or 0
  local oriCnt = ref
  ref = ref + 1
  MaterialUtils.OutlineCnt = ref
  if 0 == oriCnt then
    LuaCSharpUtil.SetRenderFeatureState("OutLine", true)
  end
end

function MaterialUtils.CloseOutLine()
  local ref = MaterialUtils.OutlineCnt or 0
  local oriCnt = ref
  ref = ref - 1
  ref = ref >= 0 and ref or 0
  MaterialUtils.OutlineCnt = ref
  if 1 == oriCnt then
    LuaCSharpUtil.SetRenderFeatureState("OutLine", false)
  end
end

function MaterialUtils.toBinaryString(num, bits)
  bits = bits or 32
  local bin = ""
  for i = bits - 1, 0, -1 do
    if num >= 2 ^ i then
      bin = bin .. "1"
      num = num - 2 ^ i
    else
      bin = bin .. "0"
    end
  end
  return bin
end

function MaterialUtils.AddOutlineLayer(renderer)
  local layer = renderer.renderingLayerMask
  local outlineLayer = RenderingLayerMask.Outline
  local resultLayer = layer | 1 << outlineLayer - 1
  renderer.renderingLayerMask = resultLayer
end

function MaterialUtils.SubOutlineLayer(renderer)
  local layer = renderer.renderingLayerMask
  local outlineLayer = RenderingLayerMask.Outline
  local resultLayer = layer & ~(1 << outlineLayer - 1)
  renderer.renderingLayerMask = resultLayer
end

function MaterialUtils.GetUIImageMaterial(ui)
  local image = ui:GetComponent(typeof(CS.UnityEngine.UI.Image))
  local mat = image.material
  if not mat then
    return nil
  end
  if ApplicationUtils.is_editor_mode() then
    local newMat = CS.UnityEngine.GameObject.Instantiate(mat)
    image.material = newMat
    return newMat
  end
  return image.material
end

function MaterialUtils.SetUIImageMaterialMask(ui, path, own)
  local Texture2D = typeof(CS.UnityEngine.Texture2D)
  local tex = ResLoadMgr.LoadAsset(path, own, Texture2D)
  local mat = MaterialUtils.GetUIImageMaterial(ui)
  mat:SetTexture("_Mask", tex)
end

return MaterialUtils
