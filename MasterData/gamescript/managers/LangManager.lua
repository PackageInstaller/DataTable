local System = require("System.System")
local Manager = require("Utility.Manager")
local IUpdater = require("Ecs.IUpdater")
local LangManager, Super = System.NewClass("LangManager", Manager, IUpdater)
local EMPTY_FONTS = {UX_Empty_Font = true, empty_font = true}

function LangManager:ctor()
  Super.ctor(self)
  self.fontResMap = {}
  self._isShowLangKey = false
  self._isDownloadShortKeyFile = false
end

function LangManager:Awake(binder)
  self.binder = binder
  self:SetupGlobalFallbackFonts()
end

function LangManager:SetupGlobalFallbackFonts()
  local DataCenter = require("Data.DataCenter")
  local langCode = DataCenter.gameData.CurrTextLanguage
  local fallbackFontMap = {
    BN = "LangRes/BN/UI/UI_Font/UI_Text_NotoSansBengali.asset"
  }
  local fontPath = fallbackFontMap[langCode]
  if not fontPath then
    return
  end
  local fontAsset = self.binder:LoadAsset(fontPath)
  if not fontAsset then
    return
  end
  local fallbackList = CS.TMPro.TMP_Settings.fallbackFontAssets
  if fallbackList then
    fallbackList:Add(fontAsset)
  end
end

function LangManager:Update()
  if self._isShowLangKey then
    LangTable.ShowLangKey()
  end
end

function LangManager:SetShowLangKey(isShow)
  self._isShowLangKey = isShow
  if not isShow then
    LangTable.ShowOrigText()
  end
end

function LangManager:SwitchShowLangKey()
  if not self._isDownloadShortKeyFile then
    self:StartDownloadShortKeyFile()
    return
  end
  self:SetShowLangKey(not self._isShowLangKey)
end

function LangManager:StartDownloadShortKeyFile()
  if self._isDownloading then
    return
  end
  self._isDownloading = true
  self:DownloadShortKeyFile(function(isSuccess)
    self._isDownloading = nil
    if isSuccess then
      self._isDownloadShortKeyFile = true
      self:SwitchShowLangKey()
    else
      ErrorMsg.ShowErrCodeTips({code = 2})
    end
  end)
end

function LangManager:DownloadShortKeyFile(cb)
  if ApplicationUtils.IsEditor() then
    cb(true)
    return
  end
  Alert.Show("KeyShortNameDownLoadTips")
  GroupDownloadMgr.Instance:DownLoadDebugGroup(cb)
end

function LangManager:GetFontAssetByResString(resPathStr, langCode)
  local fontRes = self.fontResMap[resPathStr]
  if fontRes then
    return fontRes
  end
  local resName, resPath = LangManager.GetResInfo(resPathStr, langCode)
  local fontLangRes = self:GetFontLangRes(resName, langCode, resPath)
  self.fontResMap[resPathStr] = fontLangRes
  return fontLangRes
end

function LangManager:GetFontLangRes(fontName, langCode, resPath)
  if not fontName or "" == fontName then
    return
  end
  local DataCenter = require("Data.DataCenter")
  langCode = langCode or DataCenter.gameData.CurrTextLanguage
  local fontLangRes
  if not (self.fontResMap and self.fontResMap[fontName]) or not self.fontResMap[fontName][langCode] then
    fontLangRes = self:AddFontLangRes(fontName, langCode, resPath)
  else
    fontLangRes = self.fontResMap[fontName][langCode]
  end
  return fontLangRes
end

function LangManager:AddFontLangRes(fontName, langCode, resPath)
  if not self.fontResMap then
    self.fontResMap = {}
  end
  if not langCode or not resPath then
    return
  end
  local font = self.binder:LoadAsset(resPath)
  if not font then
    return
  end
  if not self.fontResMap[fontName] then
    self.fontResMap[fontName] = {}
  end
  local fontLangRes = {
    langCode = langCode,
    resPath = resPath,
    font = font
  }
  self.fontResMap[fontName][langCode] = fontLangRes
  return fontLangRes
end

local fontCodeMap = {
  CN = {
    FZXBSK = "Assets/ArtRes/UI/UI_Font/SourceFont/FZXBSK.TTF",
    FZBWKSK = "Assets/ArtRes/UI/UI_Font/SourceFont/FZBWKSK.TTF",
    UX_Text_FZBeiWeiKaiShu = "Assets/ArtRes/UI/UI_Font/UX_Text_FZBeiWeiKaiShu.asset",
    UX_Title_FZXiaoBiaoSong = "Assets/ArtRes/UI/UI_Font/UX_Title_FZXiaoBiaoSong.asset",
    UX_Title_FZXiaoBiaoSong_Gradient = "LAssets/ArtRes/UI/UI_Font/UX_Title_FZXiaoBiaoSong_Gradient.asset",
    UX_Title_FZXiaoBiaoSong_Gradient_1 = "Assets/ArtRes/UI/UI_Font/UX_Title_FZXiaoBiaoSong_Gradient_1.asset",
    UX_Title_FZXiaoBiaoSong_Gradient_2 = "Assets/ArtRes/UI/UI_Font/UX_Title_FZXiaoBiaoSong_Gradient_2.asset"
  },
  TW = {
    FZXBSK = "Assets/ArtRes/LangRes/TW/UI/UI_Font/SourceFont/FZXBSK_TW.TTF",
    FZBWKSK = "Assets/ArtRes/LangRes/TW/UI/UI_Font/SourceFont/FZBWKSK_TW.TTF",
    UX_Text_FZBeiWeiKaiShu = "Assets/ArtRes/LangRes/TW/UI/UI_Font/UX_Text_FZBeiWeiKaiShu_TW.asset",
    UX_Title_FZXiaoBiaoSong = "Assets/ArtRes/LangRes/TW/UI/UI_Font/UX_Title_FZXiaoBiaoSong_TW.asset",
    UX_Title_FZXiaoBiaoSong_Gradient = "Assets/ArtRes/LangRes/TW/UI/UI_Font/UX_Title_FZXiaoBiaoSong_Gradient_TW.asset",
    UX_Title_FZXiaoBiaoSong_Gradient_1 = "Assets/ArtRes/LangRes/TW/UI/UI_Font/UX_Title_FZXiaoBiaoSong_Gradient_1_TW.asset",
    UX_Title_FZXiaoBiaoSong_Gradient_2 = "Assets/ArtRes/LangRes/TW/UI/UI_Font/UX_Title_FZXiaoBiaoSong_Gradient_2_TW.asset"
  },
  KR = {
    FZXBSK = "LangRes/KR/UI/UI_Font/SourceFont/SYST_KR.ttf",
    FZBWKSK = "LangRes/KR/UI/UI_Font/SourceFont/SYST_KR.ttf",
    UX_Text_FZBeiWeiKaiShu = "LangRes/KR/UI/UI_Font/UI_Text_SYSY_KR.asset",
    UX_Title_FZXiaoBiaoSong = "LangRes/KR/UI/UI_Font/UI_Text_SYSY_KR.asset",
    UX_Title_FZXiaoBiaoSong_Gradient = "LangRes/KR/UI/UI_Font/UX_Title_SYSY_Gradient_KR.asset",
    UX_Title_FZXiaoBiaoSong_Gradient_1 = "LangRes/KR/UI/UI_Font/UX_Title_SYSY_Gradient_1_KR.asset",
    UX_Title_FZXiaoBiaoSong_Gradient_2 = "LangRes/KR/UI/UI_Font/UX_Title_SYSY_Gradient_2_KR.asset"
  },
  JP = {
    FZXBSK = "LangRes/JP/UI/UI_Font/SourceFont/SYST_JP.ttf",
    FZBWKSK = "LangRes/JP/UI/UI_Font/SourceFont/SYST_JP.ttf",
    UX_Text_FZBeiWeiKaiShu = "LangRes/JP/UI/UI_Font/UI_Text_SYSY_JP.asset",
    UX_Title_FZXiaoBiaoSong = "LangRes/JP/UI/UI_Font/UI_Text_SYSY_JP.asset",
    UX_Title_FZXiaoBiaoSong_Gradient = "LangRes/JP/UI/UI_Font/UX_Title_SYSY_Gradient_JP.asset",
    UX_Title_FZXiaoBiaoSong_Gradient_1 = "LangRes/JP/UI/UI_Font/UX_Title_SYSY_Gradient_1_JP.asset",
    UX_Title_FZXiaoBiaoSong_Gradient_2 = "LangRes/JP/UI/UI_Font/UX_Title_SYSY_Gradient_2_JP.asset"
  },
  TH = {
    FZXBSK = "LangRes/TH/UI/UI_Font/SourceFont/SYST_TH.ttf",
    FZBWKSK = "LangRes/TH/UI/UI_Font/SourceFont/SYST_TH.ttf",
    UX_Text_FZBeiWeiKaiShu = "LangRes/TH/UI/UI_Font/UI_Text_SYSY_TH.asset",
    UX_Title_FZXiaoBiaoSong = "LangRes/TH/UI/UI_Font/UI_Text_SYSY_TH.asset",
    UX_Title_FZXiaoBiaoSong_Gradient = "LangRes/TH/UI/UI_Font/UX_Title_SYSY_Gradient_TH.asset",
    UX_Title_FZXiaoBiaoSong_Gradient_1 = "LangRes/TH/UI/UI_Font/UX_Title_SYSY_Gradient_1_TH.asset",
    UX_Title_FZXiaoBiaoSong_Gradient_2 = "LangRes/TH/UI/UI_Font/UX_Title_SYSY_Gradient_2_TH.asset"
  },
  COM = {
    FZXBSK = "LangRes/COM/UI/UI_Font/SourceFont/SYST_COM.ttf",
    FZBWKSK = "LangRes/COM/UI/UI_Font/SourceFont/SYST_COM.ttf",
    UX_Text_FZBeiWeiKaiShu = "LangRes/COM/UI/UI_Font/UI_Text_SYSY_COM.asset",
    UX_Title_FZXiaoBiaoSong = "LangRes/COM/UI/UI_Font/UI_Text_SYSY_COM.asset",
    UX_Title_FZXiaoBiaoSong_Gradient = "LangRes/COM/UI/UI_Font/UX_Title_SYSY_Gradient_COM.asset",
    UX_Title_FZXiaoBiaoSong_Gradient_1 = "LangRes/COM/UI/UI_Font/UX_Title_SYSY_Gradient_1_COM.asset",
    UX_Title_FZXiaoBiaoSong_Gradient_2 = "LangRes/COM/UI/UI_Font/UX_Title_SYSY_Gradient_2_COM.asset"
  },
  BN = {
    FZXBSK = "LangRes/BN/UI/UI_Font/SourceFont/NotoSansBengali-Regular.ttf",
    FZBWKSK = "LangRes/BN/UI/UI_Font/SourceFont/NotoSansBengali-Regular.ttf",
    UX_Text_FZBeiWeiKaiShu = "LangRes/BN/UI/UI_Font/UI_Text_NotoSansBengali.asset",
    UX_Title_FZXiaoBiaoSong = "LangRes/BN/UI/UI_Font/UI_Text_NotoSansBengali.asset",
    UX_Title_FZXiaoBiaoSong_Gradient = "LangRes/BN/UI/UI_Font/UX_Title_NotoSansBengali_Gradient.asset",
    UX_Title_FZXiaoBiaoSong_Gradient_1 = "LangRes/BN/UI/UI_Font/UX_Title_NotoSansBengali_Gradient_1.asset",
    UX_Title_FZXiaoBiaoSong_Gradient_2 = "LangRes/BN/UI/UI_Font/UX_Title_NotoSansBengali_Gradient_2.asset"
  }
}

function LangManager.GetResInfo(resPathStr, langCode)
  if not resPathStr then
    return
  end
  local arr = string.split(resPathStr, "##")
  if not arr or #arr <= 2 then
    return
  end
  local resName, resPath = arr[2], arr[3]
  if "CN" ~= langCode and "TW" ~= langCode then
    local fontMap = fontCodeMap[langCode] or fontCodeMap.COM or {}
    resPath = fontMap[resName] or resPath
  end
  resPath = string.gsub(resPath, "Assets/", "")
  resPath = string.gsub(resPath, "ArtRes/", "")
  return resName, resPath
end

function LangManager:GetEmptyFontNames()
  return EMPTY_FONTS
end

function LangManager:OnDestroy()
  if self.fontResMap then
    for k, _ in pairs(self.fontResMap) do
      self.fontResMap[k] = nil
    end
  end
end

return LangManager
