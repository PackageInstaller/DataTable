local CharacterVoiceController = class("AvgController", ControllerBase)
local base = ControllerBase
local CS_LanguageGlobal = CS.LanguageGlobal
local SheetMaxNum = 10
local CommanderNameStrTag = "<cmdr>"

function CharacterVoiceController:OnInit()
  self.sheetDic = {}
  self.textCfgDic = {}
end

function CharacterVoiceController:HasCv(heroId)
  local heroCfg = ConfigData.hero_data[heroId]
  if heroCfg ~= nil then
    return heroCfg.hero_audio_res
  end
  return false
end

function CharacterVoiceController:PlayCv(heroId, voiceId, completeEvent, OpenMouseListen, skinId)
  local sheetName, cueName = self:GetSheetNameAndCueName(heroId, voiceId, skinId)
  if sheetName == nil then
    return
  end
  if (self.sheetDic[heroId] == nil or self.sheetDic[heroId][sheetName] == nil) and self:__GetSheetCount() >= SheetMaxNum then
    for heroId, v in pairs(self.sheetDic) do
      if self.sheetDic[heroId] ~= nil then
        self:RemoveCvCueSheet(heroId)
      end
      break
    end
  end
  if self.sheetDic[heroId] == nil then
    self.sheetDic[heroId] = {}
  end
  self.sheetDic[heroId][sheetName] = sheetName
  self.lastPlayedHeroId = heroId
  if OpenMouseListen == true then
    return AudioManager:PlayAudio(cueName, sheetName, eAudioSourceType.Live2DSource, completeEvent)
  else
    return AudioManager:PlayAudio(cueName, sheetName, eAudioSourceType.VoiceSource, completeEvent)
  end
end

function CharacterVoiceController:__GetSheetCount()
  local count = 0
  for heroId, table in pairs(self.sheetDic) do
    for key, sheetName in pairs(table) do
      count = count + 1
    end
  end
  return count
end

function CharacterVoiceController:RemoveCvCueSheet(heroId)
  local sheetNameTable = self.sheetDic[heroId]
  if sheetNameTable ~= nil then
    for index, sheetName in pairs(sheetNameTable) do
      AudioManager:RemoveCueSheet(sheetName)
    end
    self.sheetDic[heroId] = nil
  end
end

function CharacterVoiceController:RemoveCvAllCueSheet(removeLastCvHero)
  local lastsheetNameTable
  for heroId, sheetNameTable in pairs(self.sheetDic) do
    if not removeLastCvHero and heroId == self.lastPlayedHeroId then
      lastsheetNameTable = sheetNameTable
    else
      for index, sheetName in pairs(sheetNameTable) do
        AudioManager:RemoveCueSheet(sheetName)
      end
    end
  end
  self.sheetDic = {}
  if not removeLastCvHero and self.lastPlayedHeroId ~= nil then
    self.sheetDic[self.lastPlayedHeroId] = lastsheetNameTable
  end
end

function CharacterVoiceController:GetCvText(heroId, voiceId, skinId)
  local heroCfg, resCfg, voiceCfg, skinCfg = self:GetVoiceInfo(heroId, voiceId, skinId)
  local lang = CS_LanguageGlobal.GetLanguageStr()
  local langPath = self:GetTextConfigPath(skinCfg, resCfg, lang, voiceId)
  local textCfg
  local textCfgTable = self.textCfgDic[heroId]
  if textCfgTable ~= nil then
    textCfg = textCfgTable[langPath]
  end
  if textCfg == nil then
    local ok, err = pcall(function()
      textCfg = require(langPath)
      textCfg.cvLangPath = langPath
      return true
    end)
    if not ok then
      error("Can't get CvLanguage, path = " .. langPath .. ",\n" .. tostring(err))
      return
    end
    if self.textCfgDic[heroId] == nil then
      self.textCfgDic[heroId] = {}
    end
    self.textCfgDic[heroId][langPath] = textCfg
  end
  local text = textCfg[voiceCfg.name]
  if text == nil then
    error("文本不存在！！ 文件名 " .. langPath .. " 文本名 = " .. voiceCfg.name .. " heroId = " .. tostring(heroId) .. ", voiceId = " .. tostring(voiceId))
    return nil
  end
  if string.find(text, CommanderNameStrTag) and PlayerDataCenter.playerName ~= nil then
    text = string.gsub(text, CommanderNameStrTag, PlayerDataCenter.playerName)
  end
  return text
end

function CharacterVoiceController:GetTextConfigPath(skinCfg, resCfg, lang, voiceId)
  local langPath
  if resCfg ~= nil then
    langPath = "CvTextConfig." .. resCfg.res_Name .. "_" .. lang
  end
  if skinCfg == nil then
    return langPath
  end
  local existVoice = self:IsExistSkinVoiceId(skinCfg.id, voiceId)
  if existVoice then
    langPath = "CvTextConfig." .. skinCfg.src_id_pic .. "_" .. lang
  end
  return langPath
end

function CharacterVoiceController:RemoveCvText(heroId)
  local textCfgTable = self.textCfgDic[heroId]
  if textCfgTable ~= nil then
    for path, textCfg in pairs(textCfgTable) do
      if textCfg ~= nil then
        package.loaded[textCfg.cvLangPath] = nil
        self.textCfgDic[heroId] = nil
      end
    end
    collectgarbage()
  end
end

function CharacterVoiceController:RemoveAllCvText()
  for heroId, textCfgTable in pairs(self.textCfgDic) do
    if textCfgTable ~= nil then
      for path, textCfg in pairs(textCfgTable) do
        package.loaded[textCfg.cvLangPath] = nil
      end
    end
  end
  self.textCfgDic = {}
  collectgarbage()
end

function CharacterVoiceController:GetVoiceIdFromName(voiceName)
  for id, cfg in pairs(ConfigData.audio_voice) do
    if cfg.name == voiceName then
      return id
    end
  end
  return nil
end

function CharacterVoiceController:GetSheetNameAndCueName(heroId, voiceId, skinId)
  if not self:HasCv(heroId) then
    return
  end
  local heroCfg, resCfg, voiceCfg, skinCfg = self:GetVoiceInfo(heroId, voiceId, skinId)
  local sheetName = self:GetSheetName(resCfg, skinCfg, voiceId)
  local cueName = self:GetCueName(resCfg, voiceCfg, skinCfg, voiceId)
  return sheetName, cueName
end

function CharacterVoiceController:GetVoiceInfo(heroId, voiceId, skinId)
  if skinId == nil then
    skinId = self:GetHeroCurrentSkinId(heroId)
  end
  if skinId == 0 then
    skinId = heroId
  end
  local heroCfg = ConfigData.hero_data[heroId]
  if heroCfg == nil then
    error("Cant get hero_data, heroId = " .. tostring(heroId))
    return
  end
  local resCfg = ConfigData.resource_model[heroCfg.src_id]
  if resCfg == nil then
    error("resource model Cfg is null,id:" .. tostring(heroCfg.src_id))
    return
  end
  local skinVoiceId = self:GetRealVoiceId(skinId, voiceId)
  local voiceCfg = ConfigData.audio_voice[skinVoiceId]
  if voiceCfg == nil then
    error("Cant get audio_voice, voiceId = " .. tostring(voiceId))
    return
  end
  local skinCfg = ConfigData.skin[skinId]
  return heroCfg, resCfg, voiceCfg, skinCfg
end

function CharacterVoiceController:GetVoiceLength(heroId, voiceId, skinId)
  local sheetName, cueName = self:GetSheetNameAndCueName(heroId, voiceId, skinId)
  if sheetName == nil then
    return 0
  end
  return AudioManager:GetAudioLength(sheetName, cueName)
end

function CharacterVoiceController:OnDelete()
  self:RemoveAllCvText()
  self:RemoveCvAllCueSheet(true)
  base.OnDelete(self)
end

function CharacterVoiceController:GetSheetName(resCfg, skinCfg, voiceId)
  local sheetName
  if resCfg ~= nil then
    sheetName = "VO_" .. resCfg.res_Name
  end
  if skinCfg == nil then
    return sheetName
  end
  local existVoice = self:IsExistSkinVoiceId(skinCfg.id, voiceId)
  if existVoice then
    sheetName = "VO_" .. skinCfg.src_id_pic
  end
  return sheetName
end

function CharacterVoiceController:GetCueName(resCfg, voiceCfg, skinCfg, voiceId)
  local cueName
  if resCfg ~= nil then
    cueName = resCfg.res_Name .. "_" .. voiceCfg.name
  end
  if skinCfg == nil then
    return cueName
  end
  local existVoice = self:IsExistSkinVoiceId(skinCfg.id, voiceId)
  if existVoice then
    cueName = skinCfg.src_id_pic .. "_" .. voiceCfg.name
  end
  return cueName
end

function CharacterVoiceController:IsExistSkinVoiceId(skinId, voiceId)
  if not self:HasSkinCv(skinId) then
    return false
  end
  local skinVoiceId = self:GetSkinVoiceId(skinId, voiceId)
  local existVoice = self:IsExistVoiceId(skinVoiceId)
  return existVoice
end

function CharacterVoiceController:HasSkinCv(SkinId)
  local skinCfg = ConfigData.skin[SkinId]
  if skinCfg ~= nil then
    return skinCfg.has_voice
  end
  return false
end

function CharacterVoiceController:IsExistVoiceId(voiceId)
  local voiceCfg = ConfigData.audio_voice[voiceId]
  return voiceCfg ~= nil
end

function CharacterVoiceController:GetSkinVoiceId(skinId, voiceId)
  if 3.0E8 <= voiceId then
    return voiceId
  end
  if skinId < 3000 then
    return voiceId
  end
  local skinVoiceId = skinId * 1000 + voiceId
  return skinVoiceId
end

function CharacterVoiceController:GetRealVoiceId(skinId, voiceId)
  local skinVoiceId = self:GetSkinVoiceId(skinId, voiceId)
  if self:IsExistVoiceId(skinVoiceId) then
    return skinVoiceId
  else
    return voiceId
  end
end

function CharacterVoiceController:GetHeroCurrentSkinId(heroId)
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData ~= nil then
    return heroData:GetCurrentUseSkinId()
  end
  return (heroId + 2000) * 100
end

return CharacterVoiceController
