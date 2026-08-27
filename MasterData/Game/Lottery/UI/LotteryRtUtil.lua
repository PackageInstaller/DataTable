local LotteryRtUtil = {}
local cs_UnityEngine = CS.UnityEngine
local cs_RenderTexture = cs_UnityEngine.RenderTexture
local cs_SystemInfo = cs_UnityEngine.SystemInfo
local cs_RenderTextureFormat = cs_UnityEngine.RenderTextureFormat

function LotteryRtUtil.GetARGBHalfRtTemporary(w, h, depthBufferBits)
  local rtDesc = cs_UnityEngine.RenderTextureDescriptor(w, h, cs_RenderTextureFormat.ARGBHalf, depthBufferBits)
  local texture = cs_RenderTexture.GetTemporary(rtDesc)
  return texture
end

function LotteryRtUtil.ReleaseTemporaryAndDestory(texture)
  cs_RenderTexture.ReleaseTemporary(texture)
end

function LotteryRtUtil.SupportsRenderTextures(RenderTextureFormat)
  return cs_SystemInfo.SupportsRenderTextureFormat(RenderTextureFormat)
end

return LotteryRtUtil
