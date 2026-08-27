local UrlUtil = {}
local cs_UnityWebRequest = CS.UnityEngine.Networking.UnityWebRequest
local cs_MicaSDKManager = CS.MicaSDKManager.Instance
local cs_AESEncrypt = CS.AESEncrypt

function UrlUtil.GetWebURL(sourceURL)
  if string.match(sourceURL, "h5game=true") ~= nil then
    local url = sourceURL
    local UID = PlayerDataCenter.strPlayerId
    local game_channel_id = cs_MicaSDKManager.SDK_Channel_Id
    local type_id = cs_MicaSDKManager.Type_id
    url = GR.StringFormat(url, game_channel_id, type_id, UID)
    local args = string.split(url, "?")
    args[2] = cs_AESEncrypt.Encrypt(args[2])
    url = args[1] .. "?token=" .. args[2]
    sourceURL = url
  else
    local token = cs_MicaSDKManager.accessToken
    token = cs_UnityWebRequest.EscapeURL(token)
    if token == nil then
      token = ""
    end
    if string.match(sourceURL, "?") ~= nil then
      sourceURL = sourceURL .. "&token=" .. token
    else
      sourceURL = sourceURL .. "?token=" .. token
    end
  end
  return sourceURL
end

return UrlUtil
