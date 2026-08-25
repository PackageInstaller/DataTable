local LanguangeConfig = require("Lang.LanguageConfig")
local GameUpdateConstant = require("Constant.GameUpdateConstant")
local Z1Const = CS.FrameWork.Z1Const
local Languange = {cur_lang = "TW"}

function Languange.Init()
  Languange.HasClientCacheLang = false
  local cacheLang = Languange.GetClientCacheLang()
  if "ENAI" == cacheLang then
    cacheLang = "EN"
  end
  if cacheLang and LanguangeConfig[cacheLang] then
    Languange.SetLanguage(cacheLang)
    Languange.HasClientCacheLang = true
    return
  end
  local publishRegion = CS.FrameWork.Z1Const.GetPublishRegion()
  if "JP" == publishRegion then
    Languange.HasClientCacheLang = true
    Languange.SetLanguage("JP")
    return
  end
  if Z1Const.IsSteam and Z1Const.IsSteam() then
    local lang = Languange.GetSteamDefaultLang()
    Languange.SetLanguage(lang)
    return
  end
  local initLangKey = "InitLanguageCode_" .. publishRegion
  local initLang = GameUpdateConstant[initLangKey]
  if initLang and LanguangeConfig[initLang] then
    Languange.SetLanguage(initLang)
    return
  end
  Languange.SetLanguage("TW")
end

function Languange.GetSteamDefaultLang()
  local defaultLang = "CN"
  local SteamManager = CS.SteamManager
  if not SteamManager then
    return defaultLang
  end
  if SteamManager.Instance:IsInitialized() then
    local lang = CS.Steamworks.SteamApps.GetCurrentGameLanguage()
    if "schinese" == lang then
      return "CN"
    elseif "tchinese" == lang then
      return "TW"
    else
      return "EN"
    end
  end
end

function Languange.GetClientCacheLang()
  local cacheField = GameUpdateConstant.LanguageClientCacheField
  if Z1Const.IsSteam and Z1Const.IsSteam() then
    cacheField = GameUpdateConstant.SteamLanguageClientCacheField
  end
  local UpdateUtils = require("UpdateUtils")
  local data = UpdateUtils.ReadJsonCache("z1_use.cfg")
  if not data or type(data) ~= "table" then
    return
  end
  return data[cacheField]
end

function Languange.SetLanguage(lang_type)
  if "ENAI" == lang_type then
    lang_type = "EN"
  end
  if LanguangeConfig[lang_type] then
    Languange.cur_lang = lang_type
    print("Languange.SetLanguage", lang_type)
  end
end

function Languange.SaveLanguage()
  if not Languange.cur_lang then
    return
  end
  local UpdateUtils = require("UpdateUtils")
  local data = UpdateUtils.ReadJsonCache("z1_use.cfg") or {}
  local cacheField = GameUpdateConstant.LanguageClientCacheField
  if Z1Const.IsSteam and Z1Const.IsSteam() then
    cacheField = GameUpdateConstant.SteamLanguageClientCacheField
  end
  data[cacheField] = Languange.cur_lang
  UpdateUtils.WriteJsonCache("z1_use.cfg", data)
end

function Languange.GetSDKErrorCodeMsg(err_code, msg)
  local lang_type = Languange.cur_lang
  if err_code then
    local show_msg = LanguangeConfig[lang_type].ErrorCode[err_code]
    show_msg = show_msg or Languange.Text("网络繁忙，请稍后重试")
    return show_msg
  else
    print(Languange.Text(msg))
    return msg and Languange.Text(msg) or Languange.Text("网络繁忙，请稍后重试")
  end
end

function Languange.Text(txt_key)
  local lang_type = Languange.cur_lang
  return LanguangeConfig[lang_type].PlanText[txt_key] or txt_key
end

function Languange.Textf(txt_key, ...)
  local lang_type = Languange.cur_lang
  local text = LanguangeConfig[lang_type].PlanText[txt_key]
  if text and string.find(text, "%{s.*%}") then
    text = Languange.Format(text, ...)
    return text
  end
  return text or txt_key
end

function Languange.Format(str, ...)
  if not str or "" == str then
    return
  end
  local argsNum = select("#", ...)
  if argsNum <= 0 then
    return str
  end
  for i = 1, argsNum do
    local arg = select(i, ...)
    local replaceStr = "%{s" .. i .. "%}"
    if string.find(arg, "%%") then
      arg = string.gsub(arg, "%%", "%%%%")
    end
    str = string.gsub(str, replaceStr, arg)
  end
  return str
end

return Languange
