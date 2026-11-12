local BubbleVoiceManager = {}
local File = CS.System.IO.File
local RapidJson = require("rapidjson")
local TimerManager = require("GameCore.Timer.TimerManager")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local PlayerBaseData = PlayerData.Base
local map_BubbleData = {}
local map_BubbleOffset = {}
local map_VoResLen = {}
local mapDisplayData = {
  {
    0,
    "",
    ""
  },
  {
    0,
    "",
    ""
  },
  {
    0,
    "",
    ""
  },
  {
    0,
    "",
    ""
  }
}
local mapDisplayOffset = {
  left = true,
  x = 0,
  y = 0,
  cgLeft = true,
  cgX = 0,
  cgY = 0
}
local nCurTxtLanIndex = GetLanguageIndex(Settings.sCurrentTxtLanguage)
local sLanFolder = GetLanguageSurfixByIndex(nCurTxtLanIndex)
local sPath_BubbleData = ""
local sPath_BubbleOffset = ""
local sPath_VoResLen = ""
local sSpAnimSurfix = ""
local InUnityEditor = NovaAPI.IsEditorPlatform()
local bLoaded = false
local nSpeed = 1

local function LoadAll()
  if InUnityEditor == true then
    sPath_BubbleData = NovaAPI.ApplicationDataPath .. "/../../GameDataTables/text_data/bubble/" .. sLanFolder .. "/BubbleData.json"
    sPath_BubbleOffset = NovaAPI.ApplicationDataPath .. "/../AvgExcelToLua/Avg/bubble/BubbleOffset.json"
    sPath_VoResLen = NovaAPI.ApplicationDataPath .. "/../../GameDataTables/text_data/bubble/VoResLen.json"
  elseif RUNNING_BBV_EDITOR == true or AVG_EDITOR == true then
    sPath_BubbleData = NovaAPI.StreamingAssetsPath .. "/../../../" .. sLanFolder .. "/BBV/BubbleData.json"
    sPath_BubbleOffset = NovaAPI.StreamingAssetsPath .. "/../../../_cn/BBV/BubbleOffset.json"
    sPath_VoResLen = NovaAPI.StreamingAssetsPath .. "/../../../_cn/BBV/VoResLen.json"
  else
    sPath_BubbleData = "bubble/" .. sLanFolder .. "/BubbleData.json"
    sPath_BubbleOffset = "bubble/BubbleOffset.json"
    sPath_VoResLen = "bubble/VoResLen.json"
  end
  local sJsonText
  if InUnityEditor == true or RUNNING_BBV_EDITOR == true then
    sJsonText = File.ReadAllText(sPath_BubbleData)
    map_BubbleData = RapidJson.decode(sJsonText)
    sJsonText = File.ReadAllText(sPath_BubbleOffset)
    map_BubbleOffset = RapidJson.decode(sJsonText)
    sJsonText = File.ReadAllText(sPath_VoResLen)
    map_VoResLen = RapidJson.decode(sJsonText)
  else
    sJsonText = NovaAPI.LoadTextData(sPath_BubbleData)
    map_BubbleData = RapidJson.decode(sJsonText)
    sJsonText = NovaAPI.LoadTextData(sPath_BubbleOffset)
    map_BubbleOffset = RapidJson.decode(sJsonText)
    sJsonText = NovaAPI.LoadTextData(sPath_VoResLen)
    map_VoResLen = RapidJson.decode(sJsonText)
  end
  bLoaded = true
end

local map_BubbleData_Cn, map_BubbleData_Jp

local function LoadSpecificData(sLanFolder)
  local sPath
  if InUnityEditor == true then
    sPath = NovaAPI.ApplicationDataPath .. "/../../GameDataTables/text_data/bubble/" .. sLanFolder .. "/BubbleData.json"
  elseif RUNNING_BBV_EDITOR == true then
    sPath = NovaAPI.StreamingAssetsPath .. "/../../../" .. sLanFolder .. "/BBV/BubbleData.json"
  else
    sPath = "text_data/bubble/" .. sLanFolder .. "/BubbleData.json"
  end
  local sJsonText
  if InUnityEditor == true or RUNNING_BBV_EDITOR == true then
    sJsonText = File.ReadAllText(sPath)
  else
    sJsonText = NovaAPI.LoadTableData(sPath)
  end
  return RapidJson.decode(sJsonText)
end

local tbCheckOrder, _sVoLan, _bIsMale

function GetCheckOrder()
  local sVoLan = Settings.sCurrentVoLanguage
  local bIsMale = PlayerBaseData:GetPlayerSex()
  if _sVoLan ~= sVoLan or _bIsMale ~= bIsMale then
    _sVoLan = sVoLan
    _bIsMale = bIsMale
    tbCheckOrder = nil
  end
  if tbCheckOrder == nil then
    local sTextLan = Settings.sCurrentTxtLanguage
    local tbTemp = {}
    if sTextLan == AllEnum.Language.CN then
      table.insert(tbTemp, "female_cn")
      if bIsMale == true then
        table.insert(tbTemp, "male_cn")
      end
      if sVoLan == AllEnum.Language.JP then
        table.insert(tbTemp, "female_jp")
        if bIsMale == true then
          table.insert(tbTemp, "male_jp")
        end
      end
    elseif sTextLan == AllEnum.Language.JP then
      table.insert(tbTemp, "female_jp")
      if bIsMale == true then
        table.insert(tbTemp, "male_jp")
      end
    elseif sTextLan == AllEnum.Language.TW or sTextLan == AllEnum.Language.EN or sTextLan == AllEnum.Language.KR then
      table.insert(tbTemp, "female_jp")
      if bIsMale == true then
        table.insert(tbTemp, "male_jp")
      end
      if sVoLan == AllEnum.Language.CN then
        table.insert(tbTemp, "female_cn")
        if bIsMale == true then
          table.insert(tbTemp, "male_cn")
        end
      end
    end
    tbCheckOrder = {}
    for i = #tbTemp, 1, -1 do
      table.insert(tbCheckOrder, tbTemp[i])
    end
  end
end

local tbDefaultText = {
  "error",
  "",
  "",
  ""
}

local function GetText(mapTextData)
  local nCheckTotal = #tbCheckOrder
  for i = 1, nCheckTotal do
    local _sKey = tbCheckOrder[i]
    local _tbText = mapTextData[_sKey]
    if type(_tbText) == "table" and type(_tbText[1]) == "string" and _tbText[1] ~= "" then
      return _tbText
    end
  end
  return tbDefaultText
end

local tbDefaultTime = {
  1,
  0,
  0,
  0
}

local function GetTime(mapTimeData)
  local nCheckTotal = #tbCheckOrder
  for i = 1, nCheckTotal do
    local _sKey = tbCheckOrder[i]
    local _tbTime = mapTimeData[_sKey]
    if type(_tbTime) == "table" and type(_tbTime[1]) == "number" and _tbTime[1] > 0 then
      return _tbTime
    end
  end
  return tbDefaultTime
end

local tbDefaultAnim = {
  "",
  "",
  "",
  ""
}

local function GetAnim(mapAnimData)
  local function func_Available(_tb)
    if type(_tb) == "table" then
      for ii, vv in ipairs(_tb) do
        if type(vv) == "string" and vv ~= "" then
          return _tb
        end
      end
    end
  end
  
  local nCheckTotal = #tbCheckOrder
  for i = 1, nCheckTotal do
    local _sKey = tbCheckOrder[i]
    local _tbAnim = mapAnimData[_sKey]
    _tbAnim = func_Available(_tbAnim)
    if _tbAnim ~= nil then
      return _tbAnim
    end
  end
  return tbDefaultAnim
end

local function GetBubbleData(sVoResName, nCharSkinId, bTextOnly)
  if bLoaded ~= true then
    LoadAll()
  end
  GetCheckOrder()
  local data = map_BubbleData[sVoResName]
  if data == nil then
    printError("气泡语音 数据未配置：" .. sVoResName)
    return false
  end
  local tbTextData = GetText(data.text)
  if bTextOnly == true then
    return true, tbTextData
  end
  local tbTimeData = GetTime(data.time)
  local tbAnimData = GetAnim(data.anim)
  for i = 1, 4 do
    mapDisplayData[i][1] = 1 < i and tbTimeData[i] - tbTimeData[i - 1] or tbTimeData[i]
    mapDisplayData[i][2] = tbTextData[i]
    mapDisplayData[i][3] = tbAnimData[i]
  end
  local offset, offset_
  if type(nCharSkinId) == "number" then
    offset = map_BubbleOffset[tostring(nCharSkinId)]
    local mapCfgData_CharacterSkin = ConfigTable.GetData("CharacterSkin", nCharSkinId)
    if mapCfgData_CharacterSkin ~= nil and mapCfgData_CharacterSkin.Type ~= GameEnum.skinType.BASIC then
      local mapCfgData_Character = ConfigTable.GetData("Character", mapCfgData_CharacterSkin.CharId)
      if mapCfgData_Character ~= nil and type(mapCfgData_Character.DefaultSkinId) == "number" then
        local mapCfgData_CharacterDefaultSkin = ConfigTable.GetData("CharacterSkin", mapCfgData_Character.DefaultSkinId)
        if mapCfgData_CharacterDefaultSkin ~= nil and type(mapCfgData_CharacterDefaultSkin.CharacterCG) == "number" and mapCfgData_CharacterDefaultSkin.CharacterCG == mapCfgData_CharacterSkin.CharacterCG then
          offset_ = map_BubbleOffset[tostring(mapCfgData_Character.DefaultSkinId)]
        end
      end
    end
  end
  mapDisplayOffset.left = offset == nil and true or offset.left
  mapDisplayOffset.x = offset == nil and 0 or offset.x
  mapDisplayOffset.y = offset == nil and 0 or offset.y
  mapDisplayOffset.cgLeft = offset == nil and true or offset.cgLeft
  mapDisplayOffset.cgX = offset == nil and 0 or offset.cgX
  mapDisplayOffset.cgY = offset == nil and 0 or offset.cgY
  if offset_ ~= nil then
    mapDisplayOffset.cgLeft = offset_.cgLeft
    mapDisplayOffset.cgX = offset_.cgX
    mapDisplayOffset.cgY = offset_.cgY
  end
  return true
end

local LocalData = require("GameCore.Data.LocalData")

local function CheckEnable()
  local sBool = LocalData.GetPlayerLocalData("BubbleVoiceEnable")
  return sBool == nil or sBool == "true"
end

local anim, TMP, nCurIndex, timer, nCharIdx, trL2D

local function SetBubble()
  if anim == nil or TMP == nil then
    return
  end
  local bBubbleDone = false
  nCurIndex = nCurIndex + 1
  local tbData = mapDisplayData[nCurIndex]
  if tbData ~= nil then
    local nTime = tbData[1]
    local sText = tbData[2]
    local sAnim = tbData[3]
    if sText ~= "" and 0 < nTime then
      sText = string.gsub(sText, "==RT==", "\n")
      sText = string.gsub(sText, "==PLAYER_NAME==", PlayerBaseData:GetPlayerNickName())
      NovaAPI.SetTMPText(TMP, sText)
      anim:Play("bb_in", -1, 0)
      if sAnim ~= "" then
        sAnim = sAnim .. sSpAnimSurfix
        if RUNNING_BBV_EDITOR == true then
          Actor2DManager.PlayL2DAnim_InBBVEditor(sAnim)
        elseif trL2D ~= nil and trL2D:IsNull() == false then
          Actor2DManager.PlayL2DAnim(trL2D, sAnim, false, true)
        else
          Actor2DManager.PlayAnim(sAnim, true, nCharIdx)
        end
      end
      if RUNNING_BBV_EDITOR == true then
        nTime = nTime / nSpeed
      end
      timer = TimerManager.Add(1, nTime, nil, SetBubble, true, true, true, nil)
    else
      bBubbleDone = true
    end
  else
    bBubbleDone = true
  end
  if bBubbleDone == true then
    if RUNNING_BBV_EDITOR == true then
      NovaAPI.SetAnimatorSpeed(anim, nSpeed)
    end
    anim:Play("bb_out", -1, 0)
    anim = nil
    TMP = nil
    timer = nil
    trL2D = nil
  end
end

function BubbleVoiceManager.Init(bEditor)
  if bEditor == true then
    LoadAll()
    if Settings.sCurrentTxtLanguage ~= AllEnum.Language.CN and Settings.sCurrentTxtLanguage ~= AllEnum.Language.JP then
      map_BubbleData_Cn = LoadSpecificData("_cn")
      map_BubbleData_Jp = LoadSpecificData("_jp")
    end
  end
end

function BubbleVoiceManager.PlayBubbleAnim(goBubbleRoot, sVoResName, nCharSkinId, bIsCG, nCharIndex, trL2DInstance)
  if nCharIndex == nil then
    nCharIndex = 1
  end
  nCharIdx = nCharIndex
  if CheckEnable() == false then
    return
  end
  BubbleVoiceManager.StopBubbleAnim(true)
  if goBubbleRoot == nil or goBubbleRoot:IsNull() == true then
    return
  end
  if GetBubbleData(sVoResName, nCharSkinId) == true then
    local tr
    local bIsLeft = false
    if bIsCG == true then
      bIsLeft = mapDisplayOffset.cgLeft
    else
      bIsLeft = mapDisplayOffset.left
    end
    local n = bIsLeft == true and 0 or 1
    for i = 0, 1 do
      local trBubble = goBubbleRoot.transform:GetChild(i)
      trBubble.gameObject:SetActive(i == n)
      if i == n then
        tr = trBubble
      end
    end
    if tr ~= nil then
      local x = bIsCG == true and mapDisplayOffset.cgX or mapDisplayOffset.x
      local y = bIsCG == true and mapDisplayOffset.cgY or mapDisplayOffset.y
      local rt = goBubbleRoot:GetComponent("RectTransform")
      rt.anchoredPosition = Vector2(x, y)
      anim = tr:GetComponent("Animator")
      TMP = tr:GetComponentInChildren(typeof(CS.TMPro.TMP_Text))
      nCurIndex = 0
      trL2D = trL2DInstance
      SetBubble()
    end
  end
end

function BubbleVoiceManager.StopBubbleAnim(bNoAnim)
  if CheckEnable() == false then
    return
  end
  if anim ~= nil then
    if bNoAnim ~= true then
      anim:Play("bb_out", -1, 0)
    end
    anim = nil
  end
  if timer ~= nil then
    timer:Cancel()
    timer = nil
  end
  TMP = nil
  if trL2D ~= nil and trL2D:IsNull() == false then
    Actor2DManager.PlayL2DAnim(trL2D, "idle" .. sSpAnimSurfix, true, true)
    trL2D = nil
  else
    Actor2DManager.PlayAnim("idle" .. sSpAnimSurfix, true, nCharIdx)
  end
end

function BubbleVoiceManager.PauseBubbleAnim()
  if CheckEnable() == false then
    return
  end
  if timer ~= nil then
    timer:Pause(true)
  end
end

function BubbleVoiceManager.ResumeBubbleAnim()
  if CheckEnable() == false then
    return
  end
  if timer ~= nil then
    timer:Pause(false)
  end
end

function BubbleVoiceManager.PlayFixedBubbleAnim(goBubbleRoot, sVoResName, nCharIndex, trL2DInstance)
  if nCharIndex == nil then
    nCharIndex = 1
  end
  nCharIdx = nCharIndex
  if CheckEnable() == false then
    return
  end
  BubbleVoiceManager.StopBubbleAnim(true)
  if goBubbleRoot == nil or goBubbleRoot:IsNull() == true then
    return
  end
  if GetBubbleData(sVoResName) == true then
    anim = goBubbleRoot:GetComponent("Animator")
    TMP = goBubbleRoot:GetComponentInChildren(typeof(CS.TMPro.TMP_Text))
    nCurIndex = 0
    trL2D = trL2DInstance
    SetBubble()
  end
end

function BubbleVoiceManager.GetBubbleText(sVoResName)
  local tb = {
    "",
    "",
    "",
    ""
  }
  if type(sVoResName) == "string" and sVoResName ~= "" then
    if CacheTable.GetData("_CharGetLines", "vo_103_ui_gachaNew_001") == nil then
      local function func_Parse_CharGetLines(mapData)
        CacheTable.SetData("_CharGetLines", mapData.voResource, mapData)
      end
      
      ForEachTableLine(DataTable.CharGetLines, func_Parse_CharGetLines)
    end
    local mapData = CacheTable.GetData("_CharGetLines", sVoResName)
    if mapData ~= nil then
      local sContent = mapData.Lines
      local sContent = string.gsub(sContent, "==PLAYER_NAME==", PlayerBaseData:GetPlayerNickName())
      tb[1] = sContent
      return tb
    end
  end
  return tb
end

function BubbleVoiceManager.GetVoResLen(sVoResName)
  if bLoaded ~= true then
    LoadAll()
  end
  local nDuration = 0
  if type(map_VoResLen) == "table" then
    local nCurVoLanIndex = GetLanguageIndex(Settings.sCurrentVoLanguage)
    local sLanFolder = GetLanguageSurfixByIndex(nCurVoLanIndex)
    nDuration = map_VoResLen[sVoResName .. sLanFolder]
    if nDuration == nil then
      nDuration = 0
    end
  end
  return nDuration
end

function BubbleVoiceManager.GetL2DAnim(sVoResName)
  local data = map_BubbleData[sVoResName]
  local tbAnim = GetAnim(data.anim)
  if tbAnim == nil then
    return nil
  end
  return tbAnim
end

local mapDisplayData_EX = {
  {
    0,
    "",
    ""
  },
  {
    0,
    "",
    ""
  },
  {
    0,
    "",
    ""
  },
  {
    0,
    "",
    ""
  }
}
local mapDisplayOffset_EX = {
  left = true,
  x = 0,
  y = 0,
  cgLeft = true,
  cgX = 0,
  cgY = 0
}
local anim_EX, TMP_EX, nCurIndex_EX, timer_EX

local function GetBubbleData_EX(sVoResName, nCharSkinId, bTextOnly)
  if bLoaded ~= true then
    LoadAll()
  end
  GetCheckOrder()
  local data = map_BubbleData[sVoResName]
  if data == nil then
    printError("气泡语音 数据未配置：" .. sVoResName)
    return false
  end
  local tbTextData = GetText(data.text)
  if bTextOnly == true then
    return true, tbTextData
  end
  local tbTimeData = GetTime(data.time)
  local tbAnimData = GetAnim(data.anim)
  for i = 1, 4 do
    mapDisplayData_EX[i][1] = 1 < i and tbTimeData[i] - tbTimeData[i - 1] or tbTimeData[i]
    mapDisplayData_EX[i][2] = tbTextData[i]
    mapDisplayData_EX[i][3] = tbAnimData[i]
  end
  local offset
  if type(nCharSkinId) == "number" then
    offset = map_BubbleOffset[tostring(nCharSkinId)]
  end
  mapDisplayOffset_EX.left = offset == nil and true or offset.left
  mapDisplayOffset_EX.x = offset == nil and 0 or offset.x
  mapDisplayOffset_EX.y = offset == nil and 0 or offset.y
  mapDisplayOffset_EX.cgLeft = offset == nil and true or offset.cgLeft
  mapDisplayOffset_EX.cgX = offset == nil and 0 or offset.cgX
  mapDisplayOffset_EX.cgY = offset == nil and 0 or offset.cgY
  return true
end

local function SetBubble_EX()
  if anim_EX == nil or TMP_EX == nil then
    return
  end
  local bBubbleDone = false
  nCurIndex_EX = nCurIndex_EX + 1
  local tbData = mapDisplayData_EX[nCurIndex_EX]
  if tbData ~= nil then
    local nTime = tbData[1]
    local sText = tbData[2]
    local sAnim = tbData[3]
    if sText ~= "" and 0 < nTime then
      sText = string.gsub(sText, "==RT==", "\n")
      sText = string.gsub(sText, "==PLAYER_NAME==", PlayerBaseData:GetPlayerNickName())
      NovaAPI.SetTMPText(TMP_EX, sText)
      anim_EX:Play("bb_in", -1, 0)
      if sAnim ~= "" then
        sAnim = sAnim .. sSpAnimSurfix
        if RUNNING_BBV_EDITOR == true then
          Actor2DManager.PlayL2DAnim_InBBVEditor(sAnim)
        else
          Actor2DManager.PlayAnim(sAnim, true, 2)
        end
      end
      timer_EX = TimerManager.Add(1, nTime, nil, SetBubble_EX, true, true, true, nil)
    else
      bBubbleDone = true
    end
  else
    bBubbleDone = true
  end
  if bBubbleDone == true then
    anim_EX:Play("bb_out", -1, 0)
    anim_EX = nil
    TMP_EX = nil
    timer_EX = nil
  end
end

function BubbleVoiceManager.PlayFixedBubbleAnim_EX(goBubbleRoot, sVoResName)
  if CheckEnable() == false then
    return
  end
  sVoResName = sVoResName .. "_EX"
  BubbleVoiceManager.StopBubbleAnim_EX(true)
  if goBubbleRoot == nil or goBubbleRoot:IsNull() == true then
    return
  end
  if GetBubbleData_EX(sVoResName) == true then
    anim_EX = goBubbleRoot:GetComponent("Animator")
    TMP_EX = goBubbleRoot:GetComponentInChildren(typeof(CS.TMPro.TMP_Text))
    nCurIndex_EX = 0
    SetBubble_EX()
  end
end

function BubbleVoiceManager.StopBubbleAnim_EX(bNoAnim)
  if CheckEnable() == false then
    return
  end
  if anim_EX ~= nil then
    if bNoAnim ~= true then
      anim_EX:Play("bb_out", -1, 0)
    end
    anim_EX = nil
  end
  if timer_EX ~= nil then
    timer_EX:Cancel()
    timer_EX = nil
  end
  TMP_EX = nil
  Actor2DManager.PlayAnim("idle" .. sSpAnimSurfix, true, 2)
end

function BubbleVoiceManager.MarkPlaySpAnim(bUseSpAnim)
  if bUseSpAnim == true then
    sSpAnimSurfix = "_sp"
  else
    sSpAnimSurfix = ""
  end
end

local function WriteToJsonFile(sPath, sJsonText)
  local fs = CS.System.IO.FileStream(sPath, CS.System.IO.FileMode.Create)
  local sw = CS.System.IO.StreamWriter(fs, CS.System.Text.UTF8Encoding(false))
  sw:Write(sJsonText)
  sw:Close()
  fs:Close()
end

local sEditingVoResName

function BubbleVoiceManager.GetBubbleData_All(sVoResName)
  sEditingVoResName = sVoResName
  local mapEditingData = map_BubbleData[sVoResName]
  local bIsNewData = mapEditingData == nil
  if bIsNewData == true then
    mapEditingData = {
      text = {
        male_cn = {
          "",
          "",
          "",
          ""
        },
        female_cn = {
          "",
          "",
          "",
          ""
        },
        male_jp = {
          "",
          "",
          "",
          ""
        },
        female_jp = {
          "",
          "",
          "",
          ""
        }
      },
      time = {
        male_cn = {
          0,
          0,
          0,
          0
        },
        female_cn = {
          0,
          0,
          0,
          0
        },
        male_jp = {
          0,
          0,
          0,
          0
        },
        female_jp = {
          0,
          0,
          0,
          0
        }
      },
      anim = {
        male_cn = {
          "",
          "",
          "",
          ""
        },
        female_cn = {
          "",
          "",
          "",
          ""
        },
        male_jp = {
          "",
          "",
          "",
          ""
        },
        female_jp = {
          "",
          "",
          "",
          ""
        }
      }
    }
  end
  return mapEditingData, bIsNewData
end

function BubbleVoiceManager.GetReuseData(sLan)
  if sEditingVoResName == nil then
    return
  end
  if sLan == AllEnum.Language.CN then
    return map_BubbleData_Cn[sEditingVoResName]
  elseif sLan == AllEnum.Language.JP then
    return map_BubbleData_Jp[sEditingVoResName]
  end
end

function BubbleVoiceManager.DoSaveData(_mapData)
  if type(sEditingVoResName) == "string" and sEditingVoResName ~= "" then
    map_BubbleData[sEditingVoResName] = _mapData
    for sVoResName, mapVoData in pairs(map_BubbleData) do
      for sKey, mapData in pairs(mapVoData) do
        for sSubKey, arrData in pairs(mapData) do
          local bIsEmpty = true
          for i, v in ipairs(arrData) do
            if type(v) == "string" then
              if sKey == "text" and v ~= "" then
                v = string.gsub(v, "\r==RT==", "==RT==")
                v = string.gsub(v, "\r", "==RT==")
                arrData[i] = v
              end
              if v ~= "" then
                bIsEmpty = false
                break
              end
            elseif type(v) == "number" and v ~= 0 then
              bIsEmpty = false
              break
            end
          end
          if bIsEmpty == true then
            map_BubbleData[sVoResName][sKey][sSubKey] = nil
          end
        end
      end
    end
    local sJsonText = RapidJson.encode(map_BubbleData, {
      pretty = true,
      sort_keys = true,
      empty_table_as_array = true
    })
    WriteToJsonFile(sPath_BubbleData, sJsonText)
  end
end

function BubbleVoiceManager.BBVEditor_GetBBPos(nCharSkinId, bIsCG)
  local bIsLeft, x, y
  local mapOffset = map_BubbleOffset[tostring(nCharSkinId)]
  if mapOffset == nil then
    mapOffset = {
      left = true,
      x = 0,
      y = 0,
      cgLeft = true,
      cgX = 0,
      cgY = 0
    }
  end
  bIsLeft = bIsCG == true and mapOffset.cgLeft or mapOffset.left
  x = bIsCG == true and mapOffset.cgX or mapOffset.x
  y = bIsCG == true and mapOffset.cgY or mapOffset.y
  return bIsLeft, x, y
end

function BubbleVoiceManager.DoSaveOffset(nCharSkinId, bIsCG, bIsLeft, x, y)
  local mapOffset = map_BubbleOffset[tostring(nCharSkinId)]
  if mapOffset == nil then
    mapOffset = {
      left = true,
      x = 0,
      y = 0,
      cgLeft = true,
      cgX = 0,
      cgY = 0
    }
  end
  if bIsCG == true then
    mapOffset.cgX = x
    mapOffset.cgY = y
    mapOffset.cgLeft = bIsLeft
  else
    mapOffset.x = x
    mapOffset.y = y
    mapOffset.left = bIsLeft
  end
  map_BubbleOffset[tostring(nCharSkinId)] = mapOffset
  local sJsonText = RapidJson.encode(map_BubbleOffset, {
    pretty = true,
    sort_keys = true,
    empty_table_as_array = true
  })
  WriteToJsonFile(sPath_BubbleOffset, sJsonText)
end

function BubbleVoiceManager.HasNewDataToSave(tbVoResName)
  local bResult = false
  for i, v in ipairs(tbVoResName) do
    if BubbleVoiceManager.IsNew(v) == true then
      printLog(v)
      bResult = true
    end
  end
  return bResult
end

function BubbleVoiceManager.IsNew(sVoResName)
  if type(sVoResName) == "string" and sVoResName ~= "" then
    return map_BubbleData[sVoResName] == nil
  else
    return false
  end
end

function BubbleVoiceManager.CheckTime(sVoResName)
  local data = map_BubbleData[sVoResName]
  if data == nil then
    return false
  end
  local mapTimeData = data.time
  if mapTimeData == nil then
    return false
  end
  if mapTimeData.female_cn == nil then
    mapTimeData.female_cn = {
      0,
      0,
      0,
      0
    }
  end
  if mapTimeData.male_cn == nil then
    mapTimeData.male_cn = {
      0,
      0,
      0,
      0
    }
  end
  if 0 >= mapTimeData.female_cn[1] and 0 >= mapTimeData.male_cn[1] then
    return false
  end
  if mapTimeData.female_jp == nil then
    mapTimeData.female_jp = {
      0,
      0,
      0,
      0
    }
  end
  if mapTimeData.male_jp == nil then
    mapTimeData.male_jp = {
      0,
      0,
      0,
      0
    }
  end
  if 0 >= mapTimeData.female_jp[1] and 0 >= mapTimeData.male_jp[1] then
    return false
  end
  return true
end

function BubbleVoiceManager.SetSpeed(nIndex)
  local WwiseAudioMgr = CS.WwiseAudioManager.Instance
  if nIndex == 1 then
    WwiseAudioMgr:PostEvent("avg_speed_100")
    nSpeed = 1
  elseif nIndex == 2 then
    WwiseAudioMgr:PostEvent("avg_speed_50")
    nSpeed = 2
  elseif nIndex == 3 then
    WwiseAudioMgr:PostEvent("avg_speed_25")
    nSpeed = 4
  end
end

return BubbleVoiceManager
