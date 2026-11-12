local CS_SYS = CS.System
local CS_SYS_IO = CS_SYS.IO
local AvgEditorMultiLanTool = class("AvgEditorMultiLanTool", BaseCtrl)
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
local LocalData = require("GameCore.Data.LocalData")
AvgEditorMultiLanTool._mapNodeConfig = {
  dd_SwitchMode = {
    sComponentName = "Dropdown",
    callback = "OnDD_SwitchMode"
  },
  btn_Refresh = {
    sComponentName = "Button",
    callback = "OnBtn_Refresh"
  },
  tog_SortByMergeTime = {
    sComponentName = "Toggle",
    callback = "OnToggle_SortByMergeTime"
  },
  btn_SellectAll = {
    sComponentName = "Button",
    callback = "OnBtn_SelectAll_InCurLuaGroup"
  },
  btn_SellectNone = {
    sComponentName = "Button",
    callback = "OnBtn_SellectNone_InCurLuaGroup"
  },
  input_Search = {
    sComponentName = "InputField",
    callback = "OnInput_Search"
  },
  tog_EnableCheck_Name = {
    sComponentName = "Toggle",
    callback = "OnToggle_EnableCheck_Name"
  },
  tog_EnableCheck_W = {
    sComponentName = "Toggle",
    callback = "OnToggle_EnableCheck_W"
  },
  trMode_1 = {sNodeName = "--Mode_1--", sComponentName = "Transform"},
  btn_ProcMultiLanguage = {
    sComponentName = "Button",
    callback = "OnBtnClick_ProcMultiLanguage"
  },
  dd_MultiLanFrom = {
    sComponentName = "Dropdown",
    callback = "OnDD_LanFrom"
  },
  dd_MultiLanTo = {sComponentName = "Dropdown", callback = "OnDD_LanTo"},
  trMode_2 = {sNodeName = "--Mode_2--", sComponentName = "Transform"},
  btn_CheckW = {
    sComponentName = "Button",
    callback = "OnBtnClick_CheckW"
  },
  lsv_multi_lan = {
    sComponentName = "LoopScrollView"
  },
  cgLSV = {
    sNodeName = "lsv_multi_lan",
    sComponentName = "CanvasGroup"
  },
  procContent = {sComponentName = "Transform"},
  toggles = {sComponentName = "Transform"},
  tbTog = {
    nCount = 9,
    sNodeName = "tog_",
    sComponentName = "Toggle",
    callback = "onToggle_LuaGroup"
  },
  goProcResult = {},
  txtProcResult = {sComponentName = "Text"}
}
AvgEditorMultiLanTool._mapEventConfig = {}

function AvgEditorMultiLanTool:Awake()
  self.tbMode = {
    self._mapNode.trMode_1,
    self._mapNode.trMode_2
  }
  self:OnDD_SwitchMode()
  ENABLE_NAME_CHECK = self:GetLocalData("AvgEditorMultiLanTool", "EnableCheckName") == true
  ENABLE_W_CHECK = self:GetLocalData("AvgEditorMultiLanTool", "EnableCheckW") == true
  NovaAPI.SetToggleIsOn(self._mapNode.tog_EnableCheck_Name, ENABLE_NAME_CHECK)
  NovaAPI.SetToggleIsOn(self._mapNode.tog_EnableCheck_W, ENABLE_W_CHECK)
  local ListString = CS_SYS.Collections.Generic.List(CS_SYS.String)
  local listLanguage = ListString()
  for i, v in ipairs(AllEnum.LanguageInfo) do
    listLanguage:Add(v[2])
  end
  NovaAPI.ClearDropDownOptions(self._mapNode.dd_MultiLanFrom)
  NovaAPI.ClearDropDownOptions(self._mapNode.dd_MultiLanTo)
  NovaAPI.DropDownAddOptions(self._mapNode.dd_MultiLanFrom, listLanguage)
  NovaAPI.DropDownAddOptions(self._mapNode.dd_MultiLanTo, listLanguage)
  self.nFromLanIdx = 1
  self.nToLanIdx = 2
  NovaAPI.SetDropDownValue(self._mapNode.dd_MultiLanFrom, self.nFromLanIdx - 1)
  NovaAPI.SetDropDownValue(self._mapNode.dd_MultiLanTo, self.nToLanIdx - 1)
  self.bSortByTime = false
end

function AvgEditorMultiLanTool:GetLocalData(sMainKey, sSubKey)
  return LocalData.GetLocalData(sMainKey, sSubKey)
end

function AvgEditorMultiLanTool:SetLocalData(sMainKey, sSubKey, value)
  LocalData.SetLocalData(sMainKey, sSubKey, value)
end

function AvgEditorMultiLanTool:OnDD_SwitchMode()
  self:SetLSV_Visible(false)
  self.nCurMode = NovaAPI.GetDropDownValue(self._mapNode.dd_SwitchMode) + 1
  for i, v in ipairs(self.tbMode) do
    v.localScale = i == self.nCurMode and Vector3.one or Vector3.zero
  end
end

function AvgEditorMultiLanTool:OnBtn_Refresh(sSearchKeyWord)
  local nLanIdx = self.nFromLanIdx
  if self.nCurMode == 2 then
    nLanIdx = self.nToLanIdx
  elseif self.nFromLanIdx == self.nToLanIdx then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = "“从”与“至”的语言不能一样。"
    })
    return
  end
  local sRequireRoot = GetAvgLuaRequireRoot(nLanIdx)
  local sWriteFileRoot = NovaAPI.ApplicationDataPath .. "/../Lua/"
  if AVG_EDITOR == true and NovaAPI.IsRuntimeWindowsPlayer() == true then
    sWriteFileRoot = NovaAPI.StreamingAssetsPath .. "/Lua/"
  end
  sWriteFileRoot = sWriteFileRoot .. sRequireRoot
  local sRootConfig = sWriteFileRoot .. "Config/"
  local sRootPreset = sWriteFileRoot .. "Preset/"
  
  local function func_CollectLuaFileName(sRoot, sPattern, sAdd)
    local files = CS_SYS_IO.Directory.GetFiles(sRoot, sPattern, CS_SYS_IO.SearchOption.TopDirectoryOnly)
    local nFileCount = files.Length - 1
    local tbFileName = {}
    for i = 0, nFileCount do
      local sFileName = string.gsub(CS_SYS_IO.Path.GetFileName(files[i]), ".lua", "")
      if type(sSearchKeyWord) == "string" and sSearchKeyWord ~= "" then
        if string.find(string.lower(sFileName), string.lower(sSearchKeyWord), 1, true) ~= nil then
          local mt = NovaAPI.FileGetLastWriteTime(files[i])
          table.insert(tbFileName, {
            sName = sFileName,
            bSelected = false,
            nModifyTime = mt,
            nDefaultIdx = i + 1
          })
        end
      else
        local mt = NovaAPI.FileGetLastWriteTime(files[i])
        table.insert(tbFileName, {
          sName = sFileName,
          bSelected = false,
          nModifyTime = mt,
          nDefaultIdx = i + 1
        })
      end
    end
    if type(sAdd) == "string" and sAdd ~= "" then
      local files = CS_SYS_IO.Directory.GetFiles(sAdd, sPattern, CS_SYS_IO.SearchOption.TopDirectoryOnly)
      local nFileCount = files.Length - 1
      for i = 0, nFileCount do
        local sFileName = string.gsub(CS_SYS_IO.Path.GetFileName(files[i]), ".lua", "")
        if type(sSearchKeyWord) == "string" and sSearchKeyWord ~= "" then
          if string.find(string.lower(sFileName), string.lower(sSearchKeyWord), 1, true) ~= nil then
            local mt = NovaAPI.FileGetLastWriteTime(files[i])
            table.insert(tbFileName, {
              sName = sFileName,
              bSelected = false,
              nModifyTime = mt,
              nDefaultIdx = i + 1
            })
          end
        else
          local mt = NovaAPI.FileGetLastWriteTime(files[i])
          table.insert(tbFileName, {
            sName = sFileName,
            bSelected = false,
            nModifyTime = mt,
            nDefaultIdx = i + 1
          })
        end
      end
    end
    if self.bSortByTime == true then
      table.sort(tbFileName, function(a, b)
        if a.nModifyTime == b.nModifyTime then
          return a.nDefaultIdx < b.nDefaultIdx
        else
          return a.nModifyTime > b.nModifyTime
        end
      end)
    end
    return tbFileName
  end
  
  self.tbLuaFileName = {}
  self.tbLuaFileName[1] = func_CollectLuaFileName(sRootConfig, "*.lua", self.nCurMode == 2 and "" or sRootPreset)
  self.tbLuaFileName[2] = func_CollectLuaFileName(sRootConfig, "BB*.lua")
  self.tbLuaFileName[3] = func_CollectLuaFileName(sRootConfig, "BT*.lua")
  self.tbLuaFileName[4] = func_CollectLuaFileName(sRootConfig, "CG*.lua")
  self.tbLuaFileName[5] = func_CollectLuaFileName(sRootConfig, "DP*.lua")
  self.tbLuaFileName[6] = func_CollectLuaFileName(sRootConfig, "GD*.lua")
  self.tbLuaFileName[7] = func_CollectLuaFileName(sRootConfig, "PM*.lua")
  self.tbLuaFileName[8] = func_CollectLuaFileName(sRootConfig, "ST*.lua")
  self.tbLuaFileName[9] = self.nCurMode == 2 and {} or func_CollectLuaFileName(sRootPreset, "*.lua")
  self.nCurTogIdx = 1
  NovaAPI.SetToggleIsOn(self._mapNode.tbTog[self.nCurTogIdx], true)
  self:InitLSV()
  self:SetLSV_Visible(true)
end

function AvgEditorMultiLanTool:OnToggle_SortByMergeTime()
  self.bSortByTime = NovaAPI.GetToggleIsOn(self._mapNode.tog_SortByMergeTime)
  self:OnBtn_Refresh()
end

function AvgEditorMultiLanTool:OnBtn_SelectAll_InCurLuaGroup()
  local tbNames = {}
  for i, v in ipairs(self.tbLuaFileName[self.nCurTogIdx]) do
    v.bSelected = true
    table.insert(tbNames, v.sName)
  end
  local nFrom = self.nCurTogIdx == 1 and 2 or 1
  local nTo = self.nCurTogIdx == 1 and #self.tbLuaFileName or 1
  for i = nFrom, nTo do
    local tb = self.tbLuaFileName[i]
    for ii, vv in ipairs(tb) do
      if table.indexof(tbNames, vv.sName) > 0 then
        vv.bSelected = true
      end
    end
  end
  self._mapNode.lsv_multi_lan:ForceRefresh()
end

function AvgEditorMultiLanTool:OnBtn_SellectNone_InCurLuaGroup()
  local tbNames = {}
  for i, v in ipairs(self.tbLuaFileName[self.nCurTogIdx]) do
    v.bSelected = false
    table.insert(tbNames, v.sName)
  end
  local nFrom = self.nCurTogIdx == 1 and 2 or 1
  local nTo = self.nCurTogIdx == 1 and #self.tbLuaFileName or 1
  for i = nFrom, nTo do
    local tb = self.tbLuaFileName[i]
    for ii, vv in ipairs(tb) do
      if table.indexof(tbNames, vv.sName) > 0 then
        vv.bSelected = false
      end
    end
  end
  self._mapNode.lsv_multi_lan:ForceRefresh()
end

function AvgEditorMultiLanTool:OnInput_Search()
  local sSearchKeyWord = NovaAPI.GetInputFieldText(self._mapNode.input_Search)
  self._mapNode.toggles.localScale = sSearchKeyWord == "" and Vector3.one or Vector3.zero
  self:OnBtn_Refresh(sSearchKeyWord)
end

function AvgEditorMultiLanTool:OnToggle_EnableCheck_Name()
  local bCur = NovaAPI.GetToggleIsOn(self._mapNode.tog_EnableCheck_Name) == true
  if bCur ~= ENABLE_NAME_CHECK then
    ENABLE_NAME_CHECK = bCur
    self:SetLocalData("AvgEditorMultiLanTool", "EnableCheckName", ENABLE_NAME_CHECK)
  end
end

function AvgEditorMultiLanTool:OnToggle_EnableCheck_W()
  local bCur = NovaAPI.GetToggleIsOn(self._mapNode.tog_EnableCheck_W) == true
  if bCur ~= ENABLE_W_CHECK then
    ENABLE_W_CHECK = bCur
    self:SetLocalData("AvgEditorMultiLanTool", "EnableCheckW", ENABLE_W_CHECK)
  end
end

function AvgEditorMultiLanTool:OnDD_LanFrom()
  self:SetLSV_Visible(false)
  self.nFromLanIdx = NovaAPI.GetDropDownValue(self._mapNode.dd_MultiLanFrom) + 1
end

function AvgEditorMultiLanTool:OnDD_LanTo()
  self:SetLSV_Visible(false)
  self.nToLanIdx = NovaAPI.GetDropDownValue(self._mapNode.dd_MultiLanTo) + 1
end

function AvgEditorMultiLanTool:OnBtnClick_ProcMultiLanguage()
  local tbSelected = {}
  local nTogCount = #self.tbLuaFileName
  for i = 2, nTogCount do
    for ii, vv in ipairs(self.tbLuaFileName[i]) do
      if vv.bSelected == true then
        table.insert(tbSelected, vv.sName)
      end
    end
  end
  if #tbSelected <= 0 then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = "未选中任何需处理的文件。"
    })
    return
  end
  local nLanguageIndex_From = self.nFromLanIdx
  local nLanguageIndex_To = self.nToLanIdx
  local sRequireRoot = GetAvgLuaRequireRoot(nLanguageIndex_From)
  local sWriteFileRoot = NovaAPI.ApplicationDataPath .. "/../Lua/"
  if AVG_EDITOR == true and NovaAPI.IsRuntimeWindowsPlayer() == true then
    sWriteFileRoot = NovaAPI.StreamingAssetsPath .. "/Lua/"
  end
  local sWriteTo = sWriteFileRoot .. GetAvgLuaRequireRoot(nLanguageIndex_To)
  local _tbAvgChar = require(sRequireRoot .. "Preset/AvgCharacter")
  self.mapAvgCharacter_MultiLanProc = {}
  for i, v in ipairs(_tbAvgChar) do
    self.mapAvgCharacter_MultiLanProc[v.id] = v.name
  end
  _tbAvgChar = nil
  package.loaded[sRequireRoot .. "Preset/AvgCharacter"] = nil
  local sProcLog = ""
  for i, sLuaFileName in ipairs(tbSelected) do
    local sLuaFolder = "Config/"
    if sLuaFileName == "AvgCharacter" or sLuaFileName == "AvgContacts" or sLuaFileName == "AvgUIText" then
      sLuaFolder = "Preset/"
    end
    local sRequireFrom = sRequireRoot .. sLuaFolder .. sLuaFileName
    local tbLuaData = require(sRequireFrom)
    sProcLog = sProcLog .. self:_ProcSingleLuaFile(sLuaFolder, sLuaFileName, tbLuaData, sWriteTo) .. [[


]]
    tbLuaData = nil
    package.loaded[sRequireFrom] = nil
  end
  self.mapAvgCharacter_MultiLanProc = nil
  package.loaded[sRequireRoot .. "Preset/AvgUIText"] = nil
  local sProcLogPath = sWriteTo .. "/proc_log.txt"
  local fs
  if CS_SYS_IO.File.Exists(sProcLogPath) == false then
    fs = CS_SYS_IO.FileStream(sProcLogPath, CS_SYS_IO.FileMode.CreateNew)
  else
    fs = CS_SYS_IO.FileStream(sProcLogPath, CS_SYS_IO.FileMode.Append)
  end
  local sw = CS_SYS_IO.StreamWriter(fs, CS_SYS.Text.UTF8Encoding(false))
  local timeString = os.date("%Y-%m-%d %H:%M:%S")
  local sFromLan = AllEnum.LanguageInfo[nLanguageIndex_From][2]
  local sToLan = AllEnum.LanguageInfo[nLanguageIndex_To][2]
  local sLogTitle = string.format("----------【本地化处理日志】From:%s To:%s date:%s----------\n", sFromLan, sToLan, timeString)
  local sCurLog = sLogTitle .. sProcLog
  sw:Write(sCurLog)
  sw:Close()
  fs:Close()
  NovaAPI.SetText(self._mapNode.txtProcResult, sCurLog)
  self._mapNode.goProcResult:SetActive(true)
  GameResourceLoader.UnloadAsset(PanelId.AvgEditorMultiLanTool)
end

function AvgEditorMultiLanTool:_ProcSingleLuaFile(sLuaFolder, sLuaFileName, tbLuaData, sWriteTo)
  local sExcelPath_1 = sWriteTo .. "Excel_1_ToBeTranslate/" .. sLuaFileName .. ".xlsx"
  local sExcelPath_2 = sWriteTo .. "Excel_2_Translating/" .. sLuaFileName .. ".xlsx"
  local sExcelPath_3 = sWriteTo .. "Excel_3_Translated/" .. sLuaFileName .. ".xlsx"
  local func_Export = self["_Export_" .. sLuaFileName]
  if func_Export == nil then
    func_Export = self._Export_Text
  end
  local tbExportData = func_Export(self, tbLuaData)
  NovaAPI.WriteDataToExcel(tbExportData, sExcelPath_1, true)
  if CS_SYS_IO.File.Exists(sExcelPath_2) == true then
    CS_SYS_IO.File.Delete(sExcelPath_1)
    return sLuaFileName .. " 正在翻译中需稍后处理。"
  end
  if CS_SYS_IO.File.Exists(sExcelPath_3) ~= true then
    return sLuaFileName .. " 需要翻译。"
  end
  local tbTranslatedData = NovaAPI.ReadDataFromExcel(sExcelPath_3)
  local func_Compare = self["_Compare_" .. sLuaFileName]
  if func_Compare == nil then
    func_Compare = self._Compare_Text
  end
  local bSame, tbOverwriteTranslatedData, sDiff = func_Compare(self, tbTranslatedData, tbExportData)
  if bSame == false then
    return sLuaFileName .. " <color=red>文本有变动，需要更新已翻译完的 excel 数据。</color>" .. "\n" .. (sDiff or "")
  else
    if tbOverwriteTranslatedData ~= nil then
      NovaAPI.WriteDataToExcel(tbOverwriteTranslatedData, sExcelPath_3)
    end
    CS_SYS_IO.File.Delete(sExcelPath_1)
    local func_Import = self["_Import_" .. sLuaFileName]
    if func_Import == nil then
      func_Import = self._Import_Text
    end
    tbLuaData = func_Import(self, tbTranslatedData, tbLuaData)
    if tbLuaData == nil then
      return sLuaFileName .. " <color=red>由于路人角色名未翻译，跳过处理。</color>"
    end
    local sWriteLuaPath = sWriteTo .. sLuaFolder .. sLuaFileName .. ".lua"
    local sCheckWaitSignalLog = ""
    if sLuaFolder == "Preset/" then
      local tbLineData = {}
      table.insert(tbLineData, "return {")
      local sToString
      if sLuaFileName == "AvgUIText" then
        local tbMainKeys = {}
        local tbSexKeys = {}
        for k, v in pairs(tbLuaData) do
          table.insert(tbMainKeys, k)
          if k == "SEX" then
            for kk, vv in pairs(v) do
              table.insert(tbSexKeys, kk)
            end
          end
        end
        table.sort(tbMainKeys)
        table.sort(tbSexKeys)
        for i, keyM in ipairs(tbMainKeys) do
          if keyM == "SEX" then
            table.insert(tbLineData, "    SEX={")
            for ii, keyS in ipairs(tbSexKeys) do
              sToString = "        [\"" .. tostring(keyS) .. "\"]={\"" .. Avg_ProcEnquotes(tbLuaData.SEX[keyS][1]) .. "\",\"" .. Avg_ProcEnquotes(tbLuaData.SEX[keyS][2]) .. "\"},"
              table.insert(tbLineData, sToString)
            end
            table.insert(tbLineData, "    },")
          else
            sToString = "    " .. tostring(keyM) .. "=\"" .. Avg_ProcEnquotes(tbLuaData[keyM]) .. "\","
            table.insert(tbLineData, sToString)
          end
        end
      else
        for i, tbData in ipairs(tbLuaData) do
          if sLuaFileName == "AvgCharacter" then
            sToString = "    {id=\"" .. tbData.id .. "\",name=\"" .. Avg_ProcEnquotes(tbData.name) .. "\",name_bg_color=\"" .. tbData.name_bg_color .. "\""
            if type(tbData.surfix) == "string" then
              sToString = sToString .. ",surfix=\"" .. tbData.surfix .. "\""
            end
            if type(tbData.reuse) == "string" then
              sToString = sToString .. ",reuse=\"" .. tbData.reuse .. "\""
            end
            if type(tbData.reuseL2DPose) == "string" then
              sToString = sToString .. ",reuseL2DPose=\"" .. tbData.reuseL2DPose .. "\""
            end
            if type(tbData.ver) == "string" then
              sToString = sToString .. ",ver=\"" .. tbData.ver .. "\""
            end
            sToString = sToString .. "},"
          elseif sLuaFileName == "AvgContacts" then
            sToString = "    {id=" .. tbData.id .. ",icon=\"" .. tbData.icon .. "\",name=\"" .. Avg_ProcEnquotes(tbData.name) .. "\",landmark=\"" .. Avg_ProcEnquotes(tbData.landmark) .. "\",signature=\"" .. Avg_ProcEnquotes(tbData.signature) .. "\""
            if type(tbData.ver) == "string" then
              sToString = sToString .. ",ver=\"" .. tbData.ver .. "\""
            end
            sToString = sToString .. "},"
          end
          table.insert(tbLineData, sToString)
        end
      end
      table.insert(tbLineData, "}")
      EventManager.Hit("AvgMultiLanTool_DO_SAVE_LUA_FILE", sWriteLuaPath, tbLineData)
    else
      if ENABLE_W_CHECK == true then
        sCheckWaitSignalLog = self:CheckWaitSignal(tbLuaData, self.nToLanIdx)
      end
      EventManager.Hit("AvgMultiLanTool_SAVE_AVG_CONFIG", tbLuaData, sWriteLuaPath)
    end
    return sLuaFileName .. " <color=green>已完成本地化，应与 excel 一起提交至P4。</color>" .. sCheckWaitSignalLog
  end
end

function AvgEditorMultiLanTool:_GetAvgCharName(sAvgCharId)
  local sName = self.mapAvgCharacter_MultiLanProc[sAvgCharId]
  return sName ~= nil, sName or ""
end

function AvgEditorMultiLanTool:_ProcText(_s, bIsExport)
  if bIsExport == true then
    if TRANSLATE_SIGNAL == true then
      _s = ProcAvgTextContent(_s, self.nFromLanIdx)
      if string.find(_s, "==B==") ~= nil then
        _s = string.gsub(_s, "==B==", "")
      end
      if string.find(_s, "==W==") ~= nil then
        _s = string.gsub(_s, "==W==", "")
      end
      if string.find(_s, "==P==") ~= nil then
        _s = string.gsub(_s, "==P==", "")
      end
      if string.find(_s, "==A") ~= nil then
        _s = string.gsub(_s, "==A.-==", "")
      end
      if string.find(_s, "<") ~= nil then
        _s = string.gsub(_s, "<.->", "")
      end
    end
    if DEL_RT_SIGNAL == true and string.find(_s, "==RT==") ~= nil then
      _s = string.gsub(_s, "==RT==", "\n")
    end
  else
    if string.find(_s, "\r\n") ~= nil then
      _s = string.gsub(_s, "\r\n", "==RT==")
    end
    if string.find(_s, "\r") ~= nil then
      _s = string.gsub(_s, "\r", "==RT==")
    end
    if string.find(_s, "\n") ~= nil then
      _s = string.gsub(_s, "\n", "==RT==")
    end
  end
  return _s
end

function AvgEditorMultiLanTool:_Export_Text(tbLuaData)
  local tbExportData = {
    {
      "说话者",
      "路人译名",
      "原文-中配-女",
      "译文-中配-女",
      "原文-中配-男",
      "译文-中配-男",
      "原文-日配-女",
      "译文-日配-女",
      "原文-日配-男",
      "译文-日配-男"
    }
  }
  for i, v in ipairs(tbLuaData) do
    local sCmdName = v.cmd
    if sCmdName == "SetTalk" then
      local nType = v.param[1]
      local sAvgCharId = v.param[2]
      local sTalker = "error"
      if sAvgCharId == "0" then
        sTalker = "旁白 说"
      elseif sAvgCharId == "1" then
        sTalker = "主角 说"
      else
        local bExist, sCharName = self:_GetAvgCharName(sAvgCharId)
        if bExist == true then
          sTalker = sAvgCharId .. sCharName .. " 说"
        else
          sTalker = "※无ID角色 说※" .. sAvgCharId
        end
      end
      if nType == 1 then
        sTalker = sAvgCharId == "avg4_999" and sTalker .. " 说" or "主角 说"
      elseif nType == 2 then
        sTalker = sAvgCharId == "avg4_999" and sTalker .. " 想" or "主角 想"
      elseif nType == 3 then
        sTalker = "底部字幕 " .. sTalker
      elseif nType == 8 then
        sTalker = "居中字幕"
      elseif nType == 10 then
        sTalker = "全屏字幕"
      end
      local sCn_F = self:_ProcText(v.param[3] or "", true)
      local sCn_M = self:_ProcText(v.param[7] or "", true)
      local sJp_F = self:_ProcText(v.param[8] or "", true)
      local sJp_M = self:_ProcText(v.param[9] or "", true)
      table.insert(tbExportData, {
        "【id:" .. tostring(i) .. "】" .. sTalker,
        "",
        sCn_F,
        "",
        sCn_M,
        "",
        sJp_F,
        "",
        sCn_M,
        ""
      })
    elseif sCmdName == "SetPhoneMsg" then
      local nType = v.param[1]
      local sAvgCharId = v.param[2]
      local sTalker = "error"
      if sAvgCharId == "0" then
        sTalker = "旁白"
      elseif sAvgCharId == "1" then
        sTalker = "主角"
      else
        local bExist, sCharName = self:_GetAvgCharName(sAvgCharId)
        sTalker = sAvgCharId .. sCharName
      end
      if nType == 0 then
        sTalker = "手机收到消息 " .. sTalker
      elseif nType == 1 or nType == 2 then
        sTalker = "主角回复手机消息"
      elseif nType == 5 then
        sTalker = "手机系统消息"
      else
        sTalker = ""
      end
      if sTalker ~= "" then
        local sCn_F = self:_ProcText(v.param[3] or "", true)
        local sCn_M = self:_ProcText(v.param[7] or "", true)
        local sJp_F = self:_ProcText(v.param[8] or "", true)
        local sJp_M = self:_ProcText(v.param[9] or "", true)
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. sTalker,
          "",
          sCn_F,
          "",
          sCn_M,
          "",
          sJp_F,
          "",
          sCn_M,
          ""
        })
      end
    elseif sCmdName == "SetPhoneThinking" then
      if self.nFromLanIdx == 1 then
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "手机选项思考独白(主角)",
          "",
          self:_ProcText(v.param[4] or "", true),
          "",
          "",
          "",
          "",
          "",
          "",
          ""
        })
      else
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "手机选项思考独白(主角)",
          "",
          "",
          "",
          "",
          "",
          self:_ProcText(v.param[4] or "", true),
          "",
          "",
          ""
        })
      end
    elseif sCmdName == "SetPhoneMsgChoiceBegin" then
      sGroupId = v.param[1]
      table.insert(tbExportData, {
        "【id:" .. tostring(i) .. "】" .. string.format("----[手机选项] 开始 组:%s----", sGroupId),
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        ""
      })
      for j = 2, 4 do
        local sContent = v.param[j]
        local sContent_ = v.param[j + 3]
        if type(sContent) == "string" and sContent ~= "" or type(sContent_) == "string" and sContent_ ~= "" then
          if type(sContent) ~= "string" then
            sContent = ""
          end
          if type(sContent_) ~= "string" then
            sContent = ""
          end
          if self.nFromLanIdx == 1 then
            table.insert(tbExportData, {
              "【id:" .. tostring(i) .. "】" .. string.format("[手机选项] 组:%s 选项:%d", sGroupId, j - 1),
              "",
              self:_ProcText(sContent, true),
              "",
              self:_ProcText(sContent_, true),
              "",
              "",
              "",
              "",
              ""
            })
          else
            table.insert(tbExportData, {
              "【id:" .. tostring(i) .. "】" .. string.format("[手机选项] 组:%s 选项:%d", sGroupId, j - 1),
              "",
              "",
              "",
              "",
              "",
              self:_ProcText(sContent, true),
              "",
              self:_ProcText(sContent_, true),
              ""
            })
          end
        end
      end
    elseif sCmdName == "SetPhoneMsgChoiceJumpTo" then
      table.insert(tbExportData, {
        "【id:" .. tostring(i) .. "】" .. string.format("----[手机选项] 以下为组:%s 选项:%d 对应的演出----", v.param[1], v.param[2]),
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        ""
      })
    elseif sCmdName == "SetPhoneMsgChoiceEnd" then
      table.insert(tbExportData, {
        "【id:" .. tostring(i) .. "】" .. string.format("----[手机选项] 结束 组:%s----", v.param[1]),
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        ""
      })
    elseif sCmdName == "SetSceneHeading" then
      sContent = string.format("%s|%s|%s|%s|%s", v.param[1], v.param[2], v.param[3], v.param[4], v.param[5])
      if self.nFromLanIdx == 1 then
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "时间地点格式: 时间|月|日|主要地点|次要地点",
          "",
          sContent,
          "",
          "",
          "",
          "",
          "",
          "",
          ""
        })
      else
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "时间地点格式: 时间|月|日|主要地点|次要地点",
          "",
          "",
          "",
          "",
          "",
          sContent,
          "",
          "",
          ""
        })
      end
    elseif sCmdName == "SetIntro" then
      sContent = string.format("%s|%s|%s", v.param[2], v.param[3], self:_ProcText(v.param[4], true))
      if self.nFromLanIdx == 1 then
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "剧情梗概格式: 标题|名称|梗概内容",
          "",
          sContent,
          "",
          "",
          "",
          "",
          "",
          "",
          ""
        })
      else
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "剧情梗概格式: 标题|名称|梗概内容",
          "",
          "",
          "",
          "",
          "",
          sContent,
          "",
          "",
          ""
        })
      end
    elseif sCmdName == "SetChoiceBegin" then
      sGroupId = v.param[1]
      table.insert(tbExportData, {
        "【id:" .. tostring(i) .. "】" .. string.format("----[常规选项] 开始 组:%s----", sGroupId),
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        ""
      })
      local tbContent, tbContent_
      if self.nFromLanIdx == 1 then
        tbContent = v.param[4]
        tbContent_ = v.param[11]
      else
        tbContent = v.param[13]
        tbContent_ = v.param[14]
      end
      for j, sContent in ipairs(tbContent) do
        if type(sContent) == "string" and sContent ~= "" then
          local sContent_ = tbContent_[j]
          if self.nFromLanIdx == 1 then
            table.insert(tbExportData, {
              "【id:" .. tostring(i) .. "】" .. string.format("[常规选项] 组:%s 选项:%d", sGroupId, j),
              "",
              self:_ProcText(sContent, true),
              "",
              self:_ProcText(sContent_, true),
              "",
              "",
              "",
              "",
              ""
            })
          else
            table.insert(tbExportData, {
              "【id:" .. tostring(i) .. "】" .. string.format("[常规选项] 组:%s 选项:%d", sGroupId, j),
              "",
              "",
              "",
              "",
              "",
              self:_ProcText(sContent, true),
              "",
              self:_ProcText(sContent_, true),
              ""
            })
          end
        end
      end
      local sContent = v.param[10]
      if v.param[6] == 1 and type(sContent) == "string" and sContent ~= "" then
        if self.nFromLanIdx == 1 then
          table.insert(tbExportData, {
            "【id:" .. tostring(i) .. "】" .. "[常规选项] 主角沉思 组:%s" .. sGroupId,
            "",
            self:_ProcText(sContent, true),
            "",
            "",
            "",
            "",
            "",
            "",
            ""
          })
        else
          table.insert(tbExportData, {
            "【id:" .. tostring(i) .. "】" .. "[常规选项] 主角沉思 组:%s" .. sGroupId,
            "",
            "",
            "",
            "",
            "",
            self:_ProcText(sContent, true),
            "",
            "",
            ""
          })
        end
      end
    elseif sCmdName == "SetChoiceJumpTo" then
      table.insert(tbExportData, {
        "【id:" .. tostring(i) .. "】" .. string.format("----[常规选项] 以下为组:%s 选项:%d 对应的演出----", v.param[1], v.param[2]),
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        ""
      })
    elseif sCmdName == "SetChoiceRollback" then
      local sContent = string.format("【id:" .. tostring(i) .. "】" .. "----[常规选项] 返回至选项开始 组:%s----", v.param[1])
      if v.param[2] == 1 then
        sContent = sContent .. "\n(若选项都选过了，则跳至选项结束处)"
      end
      table.insert(tbExportData, {
        sContent,
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        ""
      })
    elseif sCmdName == "SetChoiceRollover" then
      table.insert(tbExportData, {
        "【id:" .. tostring(i) .. "】" .. string.format("----[常规选项] 跳至选项结束 组:%s ----", v.param[1]),
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        ""
      })
    elseif sCmdName == "SetChoiceEnd" then
      table.insert(tbExportData, {
        "【id:" .. tostring(i) .. "】" .. string.format("----[常规选项] 结束 组:%s----", v.param[1]),
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        ""
      })
    elseif sCmdName == "SetMajorChoice" then
      table.insert(tbExportData, {
        "【id:" .. tostring(i) .. "】" .. "----[路线选项] 开始----",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        ""
      })
      local bD_bExist = type(v.param[28]) == "string" and v.param[28] ~= ""
      if self.nFromLanIdx == 1 then
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "路线选项1-标题",
          "",
          self:_ProcText(v.param[4], true),
          "",
          "",
          "",
          "",
          "",
          "",
          ""
        })
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "路线选项1-描述",
          "",
          self:_ProcText(v.param[5], true),
          "",
          "",
          "",
          "",
          "",
          "",
          ""
        })
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "路线选项2-标题",
          "",
          self:_ProcText(v.param[11], true),
          "",
          "",
          "",
          "",
          "",
          "",
          ""
        })
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "路线选项2-描述",
          "",
          self:_ProcText(v.param[12], true),
          "",
          "",
          "",
          "",
          "",
          "",
          ""
        })
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "路线选项3-标题",
          "",
          self:_ProcText(v.param[18], true),
          "",
          "",
          "",
          "",
          "",
          "",
          ""
        })
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "路线选项3-描述",
          "",
          self:_ProcText(v.param[19], true),
          "",
          "",
          "",
          "",
          "",
          "",
          ""
        })
        if bD_bExist == true then
          table.insert(tbExportData, {
            "【id:" .. tostring(i) .. "】" .. "路线选项4-标题",
            "",
            self:_ProcText(v.param[30], true),
            "",
            "",
            "",
            "",
            "",
            "",
            ""
          })
          table.insert(tbExportData, {
            "【id:" .. tostring(i) .. "】" .. "路线选项4-描述",
            "",
            self:_ProcText(v.param[31], true),
            "",
            "",
            "",
            "",
            "",
            "",
            ""
          })
        end
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "路线选项-主角沉思",
          "",
          self:_ProcText(v.param[26], true),
          "",
          "",
          "",
          "",
          "",
          "",
          ""
        })
      else
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "路线选项1-标题",
          "",
          "",
          "",
          "",
          "",
          self:_ProcText(v.param[4], true),
          "",
          "",
          ""
        })
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "路线选项1-描述",
          "",
          "",
          "",
          "",
          "",
          self:_ProcText(v.param[5], true),
          "",
          "",
          ""
        })
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "路线选项2-标题",
          "",
          "",
          "",
          "",
          "",
          self:_ProcText(v.param[11], true),
          "",
          "",
          ""
        })
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "路线选项2-描述",
          "",
          "",
          "",
          "",
          "",
          self:_ProcText(v.param[12], true),
          "",
          "",
          ""
        })
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "路线选项3-标题",
          "",
          "",
          "",
          "",
          "",
          self:_ProcText(v.param[18], true),
          "",
          "",
          ""
        })
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "路线选项3-描述",
          "",
          "",
          "",
          "",
          "",
          self:_ProcText(v.param[19], true),
          "",
          "",
          ""
        })
        if bD_bExist == true then
          table.insert(tbExportData, {
            "【id:" .. tostring(i) .. "】" .. "路线选项4-标题",
            "",
            "",
            "",
            "",
            "",
            self:_ProcText(v.param[30], true),
            "",
            "",
            ""
          })
          table.insert(tbExportData, {
            "【id:" .. tostring(i) .. "】" .. "路线选项4-描述",
            "",
            "",
            "",
            "",
            "",
            self:_ProcText(v.param[31], true),
            "",
            "",
            ""
          })
        end
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "路线选项-主角沉思",
          "",
          "",
          "",
          "",
          "",
          self:_ProcText(v.param[26], true),
          "",
          "",
          ""
        })
      end
    elseif sCmdName == "SetMajorChoiceJumpTo" then
      table.insert(tbExportData, {
        "【id:" .. tostring(i) .. "】" .. string.format("----[路线选项] 以下为选项:%d 对应的演出----", v.param[2]),
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        ""
      })
    elseif sCmdName == "SetMajorChoiceRollover" then
      table.insert(tbExportData, {
        "【id:" .. tostring(i) .. "】" .. "----[路线选项] 跳至选项结束----",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        ""
      })
    elseif sCmdName == "SetMajorChoiceEnd" then
      table.insert(tbExportData, {
        "【id:" .. tostring(i) .. "】" .. "----[路线选项] 结束----",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        ""
      })
    elseif sCmdName == "SetPersonalityChoice" then
      table.insert(tbExportData, {
        "【id:" .. tostring(i) .. "】" .. "----[性格选项] 开始----",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        ""
      })
      if self.nFromLanIdx == 1 then
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "性格选项1",
          "",
          self:_ProcText(v.param[3], true),
          "",
          "",
          "",
          "",
          "",
          "",
          ""
        })
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "性格选项2",
          "",
          self:_ProcText(v.param[4], true),
          "",
          "",
          "",
          "",
          "",
          "",
          ""
        })
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "性格选项3",
          "",
          self:_ProcText(v.param[5], true),
          "",
          "",
          "",
          "",
          "",
          "",
          ""
        })
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "性格选项-主角沉思",
          "",
          self:_ProcText(v.param[9], true),
          "",
          "",
          "",
          "",
          "",
          "",
          ""
        })
      else
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "性格选项1",
          "",
          "",
          "",
          "",
          "",
          self:_ProcText(v.param[3], true),
          "",
          "",
          ""
        })
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "性格选项2",
          "",
          "",
          "",
          "",
          "",
          self:_ProcText(v.param[4], true),
          "",
          "",
          ""
        })
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "性格选项3",
          "",
          "",
          "",
          "",
          "",
          self:_ProcText(v.param[5], true),
          "",
          "",
          ""
        })
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "性格选项-主角沉思",
          "",
          "",
          "",
          "",
          "",
          self:_ProcText(v.param[9], true),
          "",
          "",
          ""
        })
      end
    elseif sCmdName == "SetPersonalityChoiceJumpTo" then
      table.insert(tbExportData, {
        "【id:" .. tostring(i) .. "】" .. string.format("----[性格选项] 以下为选项:%d 对应的演出----", v.param[2]),
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        ""
      })
    elseif sCmdName == "SetPersonalityChoiceRollover" then
      table.insert(tbExportData, {
        "【id:" .. tostring(i) .. "】" .. "----[性格选项] 跳至选项结束----",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        ""
      })
    elseif sCmdName == "SetPersonalityChoiceEnd" then
      table.insert(tbExportData, {
        "【id:" .. tostring(i) .. "】" .. "----[性格选项] 结束----",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        ""
      })
    elseif sCmdName == "SetBubble" then
      local sAvgCharId = v.param[1]
      local bExist, sCharName = self:_GetAvgCharName(sAvgCharId)
      local sTalker = "气泡对话" .. sAvgCharId .. sCharName
      local spName = v.param[7]
      if type(spName) == "string" and spName ~= "" then
        sTalker = "※无ID角色 气泡对话※" .. spName
      end
      local sCn_F = self:_ProcText(v.param[3] or "", true)
      local sCn_M = self:_ProcText(v.param[6] or "", true)
      local sJp_F = self:_ProcText(v.param[9] or "", true)
      local sJp_M = self:_ProcText(v.param[10] or "", true)
      table.insert(tbExportData, {
        "【id:" .. tostring(i) .. "】" .. sTalker,
        "",
        sCn_F,
        "",
        sCn_M,
        "",
        sJp_F,
        "",
        sCn_M,
        ""
      })
    elseif sCmdName == "SetGroupId" then
      table.insert(tbExportData, {
        "【id:" .. tostring(i) .. "】" .. string.format("----[分组] 以下为组:%s 对应的演出----", v.param[1]),
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        ""
      })
    elseif sCmdName == "NewCharIntro" then
      if self.nFromLanIdx == 1 then
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "新角登场-名字",
          "",
          v.param[2],
          "",
          "",
          "",
          "",
          "",
          "",
          ""
        })
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "新角登场-介绍",
          "",
          v.param[3],
          "",
          "",
          "",
          "",
          "",
          "",
          ""
        })
      else
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "新角登场-名字",
          "",
          "",
          "",
          "",
          "",
          v.param[2],
          "",
          "",
          ""
        })
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "新角登场-介绍",
          "",
          "",
          "",
          "",
          "",
          v.param[3],
          "",
          "",
          ""
        })
      end
    elseif sCmdName == "SetWordTrans" then
      local sContent = self:_ProcText(v.param[1] or "", true)
      if self.nFromLanIdx == 1 then
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "文字转场",
          "",
          sContent,
          "",
          "",
          "",
          "",
          "",
          "",
          ""
        })
      else
        table.insert(tbExportData, {
          "【id:" .. tostring(i) .. "】" .. "文字转场",
          "",
          "",
          "",
          "",
          "",
          sContent,
          "",
          "",
          ""
        })
      end
    end
  end
  return tbExportData
end

function AvgEditorMultiLanTool:_Compare_Text(tbTranslatedData, tbExportData)
  if tbTranslatedData == nil then
    return false
  end
  local nRowCountT = tbTranslatedData.Length
  if nRowCountT ~= #tbExportData then
    local log = string.format("已翻译的 excel 行数(%s) 与 现导出的 excel 行数(%s) 不一致。", tostring(nRowCountT), tostring(#tbExportData))
    return false, nil, log
  end
  nRowCountT = nRowCountT - 1
  local tbOverwrite = {}
  for i = 0, nRowCountT do
    local tbRowTranslated = tbTranslatedData[i]
    local tbRowExport = tbExportData[i + 1]
    table.insert(tbOverwrite, {
      tbRowTranslated[0],
      tbRowTranslated[1],
      tbRowTranslated[2],
      tbRowTranslated[3],
      tbRowTranslated[4],
      tbRowTranslated[5],
      tbRowTranslated[6],
      tbRowTranslated[7],
      tbRowTranslated[8],
      tbRowTranslated[9]
    })
    for j = 1, 9, 2 do
      local sTranslated = tbRowTranslated[j - 1]
      local sExport = tbRowExport[j]
      if j == 1 then
        if sTranslated ~= sExport then
          local tbTranslated = string.split(sTranslated, "】")
          local tbExport = string.split(sExport, "】")
          if #tbTranslated == 2 and #tbExport == 2 and tbTranslated[2] ~= tbExport[2] then
            local log = string.format("已翻译的中文文本：%s\n现导出的中文文本：%s", tbTranslated[2], tbExport[2])
            return false, nil, log
          end
          tbOverwrite[i + 1][j] = sExport
        end
      elseif sTranslated ~= sExport then
        local log = string.format("已翻译的中文文本：%s\n现导出的中文文本：%s", sTranslated, sExport)
        return false, nil, log
      end
    end
  end
  return true, tbOverwrite
end

function AvgEditorMultiLanTool:_Import_Text(tbTranslatedData, tbLuaData)
  local nTranslatedDataIndex = 0
  
  local function func_GetTranslatedData()
    nTranslatedDataIndex = nTranslatedDataIndex + 1
    return tbTranslatedData[nTranslatedDataIndex]
  end
  
  local function func_GetColumn_H_D(rowData, target, backup)
    if target == nil then
      target = 7
    end
    if backup == nil then
      backup = 3
    end
    local sText = rowData[target]
    if sText == nil or sText == "" then
      sText = rowData[backup]
    end
    return sText
  end
  
  for i, v in ipairs(tbLuaData) do
    local sCmdName = v.cmd
    if sCmdName == "SetTalk" then
      local rowData = func_GetTranslatedData()
      local sAvgCharId = v.param[2]
      local bExist, sCharName = self:_GetAvgCharName(sAvgCharId)
      if bExist == false then
        v.param[2] = rowData[1]
        if ENABLE_NAME_CHECK == true and (v.param[2] == nil or v.param[2] == "") then
          return nil
        end
      end
      v.param[3] = self:_ProcText(rowData[3], false)
      v.param[7] = self:_ProcText(rowData[5], false)
      v.param[8] = self:_ProcText(rowData[7], false)
      v.param[9] = self:_ProcText(rowData[9], false)
    elseif sCmdName == "SetPhoneMsg" then
      local nType = v.param[1]
      if nType == 0 or nType == 1 or nType == 2 or nType == 5 then
        local rowData = func_GetTranslatedData()
        v.param[3] = self:_ProcText(rowData[3], false)
        v.param[7] = self:_ProcText(rowData[5], false)
        v.param[8] = self:_ProcText(rowData[7], false)
        v.param[9] = self:_ProcText(rowData[9], false)
      end
    elseif sCmdName == "SetPhoneThinking" then
      local rowData = func_GetTranslatedData()
      v.param[4] = self:_ProcText(func_GetColumn_H_D(rowData), false)
    elseif sCmdName == "SetPhoneMsgChoiceBegin" then
      nTranslatedDataIndex = nTranslatedDataIndex + 1
      for j = 2, 4 do
        local sContent = v.param[j]
        local sContent_ = v.param[j + 3]
        if type(sContent) == "string" and sContent ~= "" or type(sContent_) == "string" and sContent_ ~= "" then
          local rowData = func_GetTranslatedData()
          v.param[j] = self:_ProcText(func_GetColumn_H_D(rowData), false)
          v.param[j + 3] = self:_ProcText(func_GetColumn_H_D(rowData, 9, 5), false)
        end
      end
    elseif sCmdName == "SetPhoneMsgChoiceJumpTo" then
      nTranslatedDataIndex = nTranslatedDataIndex + 1
    elseif sCmdName == "SetPhoneMsgChoiceEnd" then
      nTranslatedDataIndex = nTranslatedDataIndex + 1
    elseif sCmdName == "SetSceneHeading" then
      local rowData = func_GetTranslatedData()
      local sContent = self:_ProcText(func_GetColumn_H_D(rowData), false)
      local tbContent = string.split(sContent, "|")
      for ii, vv in ipairs(tbContent) do
        v.param[ii] = vv
      end
    elseif sCmdName == "SetIntro" then
      local rowData = func_GetTranslatedData()
      local sContent = self:_ProcText(func_GetColumn_H_D(rowData), false)
      local tbContent = string.split(sContent, "|")
      for ii, vv in ipairs(tbContent) do
        v.param[ii + 1] = vv
      end
    elseif sCmdName == "SetChoiceBegin" then
      nTranslatedDataIndex = nTranslatedDataIndex + 1
      local tbContent = v.param[4]
      if v.param[13] == nil then
        v.param[13] = {
          "",
          "",
          "",
          ""
        }
      end
      if v.param[14] == nil then
        v.param[14] = {
          "",
          "",
          "",
          ""
        }
      end
      for j, sContent in ipairs(tbContent) do
        if type(sContent) == "string" and sContent ~= "" then
          local rowData = func_GetTranslatedData()
          v.param[4][j] = self:_ProcText(rowData[3], false)
          v.param[11][j] = self:_ProcText(rowData[5], false)
          v.param[13][j] = self:_ProcText(rowData[7], false)
          v.param[14][j] = self:_ProcText(rowData[9], false)
        end
      end
      local sContent = v.param[10]
      if v.param[6] == 1 and type(sContent) == "string" and sContent ~= "" then
        local rowData = func_GetTranslatedData()
        v.param[10] = self:_ProcText(func_GetColumn_H_D(rowData), false)
      end
    elseif sCmdName == "SetChoiceJumpTo" then
      nTranslatedDataIndex = nTranslatedDataIndex + 1
    elseif sCmdName == "SetChoiceRollback" then
      nTranslatedDataIndex = nTranslatedDataIndex + 1
    elseif sCmdName == "SetChoiceRollover" then
      nTranslatedDataIndex = nTranslatedDataIndex + 1
    elseif sCmdName == "SetChoiceEnd" then
      nTranslatedDataIndex = nTranslatedDataIndex + 1
    elseif sCmdName == "SetMajorChoice" then
      local bD_bExist = type(v.param[28]) == "string" and v.param[28] ~= ""
      nTranslatedDataIndex = nTranslatedDataIndex + 1
      local rowData = func_GetTranslatedData()
      v.param[4] = self:_ProcText(func_GetColumn_H_D(rowData), false)
      local rowData = func_GetTranslatedData()
      v.param[5] = self:_ProcText(func_GetColumn_H_D(rowData), false)
      local rowData = func_GetTranslatedData()
      v.param[11] = self:_ProcText(func_GetColumn_H_D(rowData), false)
      local rowData = func_GetTranslatedData()
      v.param[12] = self:_ProcText(func_GetColumn_H_D(rowData), false)
      local rowData = func_GetTranslatedData()
      v.param[18] = self:_ProcText(func_GetColumn_H_D(rowData), false)
      local rowData = func_GetTranslatedData()
      v.param[19] = self:_ProcText(func_GetColumn_H_D(rowData), false)
      if bD_bExist == true then
        local rowData = func_GetTranslatedData()
        v.param[30] = self:_ProcText(func_GetColumn_H_D(rowData), false)
        local rowData = func_GetTranslatedData()
        v.param[31] = self:_ProcText(func_GetColumn_H_D(rowData), false)
      end
      local rowData = func_GetTranslatedData()
      v.param[26] = self:_ProcText(func_GetColumn_H_D(rowData), false)
    elseif sCmdName == "SetMajorChoiceJumpTo" then
      nTranslatedDataIndex = nTranslatedDataIndex + 1
    elseif sCmdName == "SetMajorChoiceRollover" then
      nTranslatedDataIndex = nTranslatedDataIndex + 1
    elseif sCmdName == "SetMajorChoiceEnd" then
      nTranslatedDataIndex = nTranslatedDataIndex + 1
    elseif sCmdName == "SetPersonalityChoice" then
      nTranslatedDataIndex = nTranslatedDataIndex + 1
      local rowData = func_GetTranslatedData()
      v.param[3] = self:_ProcText(func_GetColumn_H_D(rowData), false)
      local rowData = func_GetTranslatedData()
      v.param[4] = self:_ProcText(func_GetColumn_H_D(rowData), false)
      local rowData = func_GetTranslatedData()
      v.param[5] = self:_ProcText(func_GetColumn_H_D(rowData), false)
      local rowData = func_GetTranslatedData()
      v.param[9] = self:_ProcText(func_GetColumn_H_D(rowData), false)
    elseif sCmdName == "SetPersonalityChoiceJumpTo" then
      nTranslatedDataIndex = nTranslatedDataIndex + 1
    elseif sCmdName == "SetPersonalityChoiceRollover" then
      nTranslatedDataIndex = nTranslatedDataIndex + 1
    elseif sCmdName == "SetPersonalityChoiceEnd" then
      nTranslatedDataIndex = nTranslatedDataIndex + 1
    elseif sCmdName == "SetBubble" then
      local rowData = func_GetTranslatedData()
      local spName = v.param[7]
      if type(spName) == "string" and spName ~= "" then
        v.param[7] = rowData[1]
      end
      v.param[3] = self:_ProcText(rowData[3], false)
      v.param[6] = self:_ProcText(rowData[5], false)
      v.param[9] = self:_ProcText(rowData[7], false)
      v.param[10] = self:_ProcText(rowData[9], false)
    elseif sCmdName == "SetGroupId" then
      nTranslatedDataIndex = nTranslatedDataIndex + 1
    elseif sCmdName == "NewCharIntro" then
      local rowData = func_GetTranslatedData()
      v.param[2] = self:_ProcText(func_GetColumn_H_D(rowData), false)
      local rowData = func_GetTranslatedData()
      v.param[3] = self:_ProcText(func_GetColumn_H_D(rowData), false)
    elseif sCmdName == "SetWordTrans" then
      local rowData = func_GetTranslatedData()
      v.param[1] = self:_ProcText(func_GetColumn_H_D(rowData), false)
    end
  end
  return tbLuaData
end

function AvgEditorMultiLanTool:_Export_AvgCharacter(tbLuaData)
  local tbExportData = {
    {
      "角色名字",
      "译文-名字"
    }
  }
  for i, v in ipairs(tbLuaData) do
    local id = v.id
    local name = v.name
    if id ~= "0" and id ~= "1" and type(name) == "string" and name ~= "" then
      table.insert(tbExportData, {
        "【id:" .. id .. "】" .. v.name,
        ""
      })
    end
  end
  return tbExportData
end

function AvgEditorMultiLanTool:_Compare_AvgCharacter(tbTranslatedData, tbExportData)
  if tbTranslatedData == nil then
    return false
  end
  local nRowCountT = tbTranslatedData.Length
  if nRowCountT ~= #tbExportData then
    return false
  end
  nRowCountT = nRowCountT - 1
  for i = 0, nRowCountT do
    local tbRowTranslated = tbTranslatedData[i]
    local tbRowExport = tbExportData[i + 1]
    local sTranslated = tbRowTranslated[0]
    local sExport = tbRowExport[1]
    if sTranslated ~= sExport then
      return false
    end
  end
  return true
end

function AvgEditorMultiLanTool:_Import_AvgCharacter(tbTranslatedData, tbLuaData)
  local nTranslatedDataIndex = 0
  
  local function func_GetTranslatedData()
    nTranslatedDataIndex = nTranslatedDataIndex + 1
    return tbTranslatedData[nTranslatedDataIndex]
  end
  
  for i, v in ipairs(tbLuaData) do
    local id = v.id
    local name = v.name
    if id ~= "0" and id ~= "1" and type(name) == "string" and name ~= "" then
      local rowData = func_GetTranslatedData()
      local sName = rowData[1]
      v.name = sName
    end
  end
  return tbLuaData
end

function AvgEditorMultiLanTool:_Export_AvgContacts(tbLuaData)
  local tbExportData = {
    {
      "名字",
      "译文-名字",
      "所在地",
      "译文-所在地",
      "个性签名",
      "译文-个性签名"
    }
  }
  for i, v in ipairs(tbLuaData) do
    local name = v.name
    table.insert(tbExportData, {
      "【id:" .. tostring(v.id) .. "】" .. name,
      "",
      self:_ProcText(v.landmark, true),
      "",
      self:_ProcText(v.signature, true),
      ""
    })
  end
  return tbExportData
end

function AvgEditorMultiLanTool:_Compare_AvgContacts(tbTranslatedData, tbExportData)
  if tbTranslatedData == nil then
    return false
  end
  local nRowCountT = tbTranslatedData.Length
  if nRowCountT ~= #tbExportData then
    return false
  end
  nRowCountT = nRowCountT - 1
  for i = 0, nRowCountT do
    local tbRowTranslated = tbTranslatedData[i]
    local tbRowExport = tbExportData[i + 1]
    for j = 1, 5, 2 do
      local sTranslated = tbRowTranslated[j - 1]
      local sExport = tbRowExport[j]
      if sTranslated ~= sExport then
        return false
      end
    end
  end
  return true
end

function AvgEditorMultiLanTool:_Import_AvgContacts(tbTranslatedData, tbLuaData)
  local nTranslatedDataIndex = 0
  
  local function func_GetTranslatedData()
    nTranslatedDataIndex = nTranslatedDataIndex + 1
    return tbTranslatedData[nTranslatedDataIndex]
  end
  
  for i, v in ipairs(tbLuaData) do
    local name = v.name
    local rowData = func_GetTranslatedData()
    v.name = rowData[1]
    v.landmark = self:_ProcText(rowData[3], false)
    v.signature = self:_ProcText(rowData[5], false)
  end
  return tbLuaData
end

function AvgEditorMultiLanTool:_Export_AvgUIText(tbLuaData)
  local tbExportData = {
    {
      "主键",
      "文本内容",
      "译文"
    }
  }
  local tbMainKeys = {}
  local tbSexKeys = {}
  for k, v in pairs(tbLuaData) do
    table.insert(tbMainKeys, k)
    if k == "SEX" then
      for kk, vv in pairs(v) do
        table.insert(tbSexKeys, kk)
      end
    end
  end
  table.sort(tbMainKeys)
  table.sort(tbSexKeys)
  for i, keyM in ipairs(tbMainKeys) do
    if keyM == "SEX" then
      local mapSex = tbLuaData.SEX
      for ii, keyS in ipairs(tbSexKeys) do
        local _tb = mapSex[keyS]
        local sContent = _tb[1] .. "|" .. _tb[2]
        table.insert(tbExportData, {
          keyS,
          sContent,
          ""
        })
      end
    else
      table.insert(tbExportData, {
        keyM,
        self:_ProcText(tbLuaData[keyM], true),
        ""
      })
    end
  end
  return tbExportData
end

function AvgEditorMultiLanTool:_Compare_AvgUIText(tbTranslatedData, tbExportData)
  if tbTranslatedData == nil then
    return false
  end
  local nRowCountT = tbTranslatedData.Length
  if nRowCountT ~= #tbExportData then
    return false
  end
  nRowCountT = nRowCountT - 1
  for i = 0, nRowCountT do
    local tbRowTranslated = tbTranslatedData[i]
    local tbRowExport = tbExportData[i + 1]
    for j = 1, 2 do
      local sTranslated = tbRowTranslated[j - 1]
      local sExport = tbRowExport[j]
      if sTranslated ~= sExport then
        return false
      end
    end
  end
  return true
end

function AvgEditorMultiLanTool:_Import_AvgUIText(tbTranslatedData, tbLuaData)
  local nTranslatedDataIndex = 0
  
  local function func_GetTranslatedData()
    nTranslatedDataIndex = nTranslatedDataIndex + 1
    return tbTranslatedData[nTranslatedDataIndex]
  end
  
  local tbMainKeys = {}
  local tbSexKeys = {}
  for k, v in pairs(tbLuaData) do
    table.insert(tbMainKeys, k)
    if k == "SEX" then
      for kk, vv in pairs(v) do
        table.insert(tbSexKeys, kk)
      end
    end
  end
  table.sort(tbMainKeys)
  table.sort(tbSexKeys)
  for i, keyM in ipairs(tbMainKeys) do
    if keyM == "SEX" then
      for ii, keyS in ipairs(tbSexKeys) do
        local rowData = func_GetTranslatedData()
        local tbSplit = string.split(rowData[2], "|")
        tbLuaData.SEX[keyS][1] = tbSplit[1]
        tbLuaData.SEX[keyS][2] = tbSplit[2]
      end
    else
      local rowData = func_GetTranslatedData()
      tbLuaData[keyM] = self:_ProcText(rowData[2], false)
    end
  end
  return tbLuaData
end

function AvgEditorMultiLanTool:OnBtnClick_CheckW()
  local tbSelected = {}
  local nTogCount = #self.tbLuaFileName
  for i = 2, nTogCount do
    for ii, vv in ipairs(self.tbLuaFileName[i]) do
      if vv.bSelected == true then
        table.insert(tbSelected, vv.sName)
      end
    end
  end
  if #tbSelected <= 0 then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = "未选中任何需校验的文件。"
    })
    return
  end
  local nCheckLanIdx = self.nToLanIdx
  local sRequireRoot = GetAvgLuaRequireRoot(nCheckLanIdx)
  local sWriteFileRoot = NovaAPI.ApplicationDataPath .. "/../Lua/"
  if AVG_EDITOR == true and NovaAPI.IsRuntimeWindowsPlayer() == true then
    sWriteFileRoot = NovaAPI.StreamingAssetsPath .. "/Lua/"
  end
  local sWriteTo = sWriteFileRoot .. sRequireRoot
  sRequireRoot = sRequireRoot .. "Config/"
  local sCheckLog = ""
  for i, sLuaFileName in ipairs(tbSelected) do
    local sRequire = sRequireRoot .. sLuaFileName
    local tbLuaData = require(sRequire)
    sCheckLog = sCheckLog .. sLuaFileName .. self:CheckWaitSignal(tbLuaData, nCheckLanIdx) .. [[


]]
    tbLuaData = nil
    package.loaded[sRequire] = nil
  end
  local sCheckLogPath = sWriteTo .. "/check_log.txt"
  local fs
  if CS_SYS_IO.File.Exists(sCheckLogPath) == false then
    fs = CS_SYS_IO.FileStream(sCheckLogPath, CS_SYS_IO.FileMode.CreateNew)
  else
    fs = CS_SYS_IO.FileStream(sCheckLogPath, CS_SYS_IO.FileMode.Append)
  end
  local sw = CS_SYS_IO.StreamWriter(fs, CS_SYS.Text.UTF8Encoding(false))
  local timeString = os.date("%Y-%m-%d %H:%M:%S")
  local sLogTitle = string.format("----------【本地化处理日志】文本语言:%s date:%s----------\n", AllEnum.LanguageInfo[nCheckLanIdx][2], timeString)
  local sCurLog = sLogTitle .. sCheckLog
  sw:Write(sCurLog)
  sw:Close()
  fs:Close()
  NovaAPI.SetText(self._mapNode.txtProcResult, sCurLog)
  self._mapNode.goProcResult:SetActive(true)
  GameResourceLoader.UnloadAsset(PanelId.AvgEditorMultiLanTool)
end

function AvgEditorMultiLanTool:CheckWaitSignal(tbLuaData, nTxtLanIdx)
  if type(nTxtLanIdx) ~= "number" then
    nTxtLanIdx = 1
  end
  local nCheckId, nSetGoOnCount, nNextEventCountCn, nNextEventCountJp, goL2D, sAnim, nCn, nJp = 0, 0, 0, 0, nil, "", 0, 0
  
  local function func_CheckCountInContent(sContent, nBackup)
    local _, nCount = "", 0
    if type(sContent) == "string" and sContent ~= "" then
      _, nCount = string.gsub(sContent, "==W==", "")
    else
      nCount = nBackup
    end
    return nCount
  end
  
  local sReturn = ""
  for i, v in ipairs(tbLuaData) do
    local sCmdName = v.cmd
    local tbParam = v.param
    if sCmdName == "SetTalk" then
      if goL2D == nil then
        if nSetGoOnCount ~= 0 then
          local sErr = "多"
          if 0 < nSetGoOnCount then
            sErr = "少"
          end
          sReturn = sReturn .. string.format("\n校验失败id%d “续播”指令 %s 配了 %d 个", nCheckId, sErr, math.abs(nSetGoOnCount))
          nSetGoOnCount = 0
        end
        nCheckId = i
      end
      local nCountCnF, nCountCnM, nCountJpF, nCountJpM = 0, 0, 0, 0
      nCountCnF = func_CheckCountInContent(tbParam[3], 0)
      nCountCnM = func_CheckCountInContent(tbParam[7], nCountCnF)
      nCountJpF = func_CheckCountInContent(tbParam[8], 0)
      nCountJpM = func_CheckCountInContent(tbParam[9], nCountJpF)
      if 1 < nTxtLanIdx then
        if tbParam[3] == "" then
          nCountCnF = nCountJpF
        end
        if tbParam[7] == "" then
          nCountCnM = nCountCnF
        end
      else
        if tbParam[8] == "" then
          nCountJpF = nCountCnF
        end
        if tbParam[9] == "" then
          nCountJpM = nCountJpF
        end
      end
      if goL2D == nil then
        if nCountCnF == nCountCnM and nCountJpF == nCountJpM and nCountCnF == nCountJpF then
          nSetGoOnCount = nCountCnF
        else
          local sErr_Cn, sErr_Jp, sErr = "", "", ""
          if nCountCnF ~= nCountCnM then
            sErr_Cn = string.format("中配男%d 女%d 文本里数量不一致", nCountCnM, nCountCnF)
          end
          if nCountJpF ~= nCountJpM then
            sErr_Jp = string.format("日配男%d 女%d 文本里数量不一致", nCountJpM, nCountJpF)
          end
          if nCountCnF ~= nCountJpF then
            sErr = string.format("中%d 日%d 配的(女)文本里数量不一致", nCountCnF, nCountJpF)
          end
          sReturn = sReturn .. string.format("\n校验失败id%d %s %s %s", i, sErr_Cn, sErr_Jp, sErr)
        end
      elseif nCountCnF == nCountCnM and nCountJpF == nCountJpM then
        nNextEventCountCn = nNextEventCountCn - nCountCnF
        nNextEventCountJp = nNextEventCountJp - nCountJpF
      else
        local sErr_Cn, sErr_Jp = "", ""
        if nCountCnF ~= nCountCnM then
          sErr_Cn = string.format("中配男%d 女%d 文本里数量不一致", nCountCnM, nCountCnF)
        end
        if nCountJpF ~= nCountJpM then
          sErr_Jp = string.format("日配男%d 女%d 文本里数量不一致", nCountJpM, nCountJpF)
        end
        sReturn = sReturn .. string.format("\n校验失败id%d %s %s", i, sErr_Cn, sErr_Jp)
      end
    elseif sCmdName == "SetGoOn" then
      if goL2D == nil then
        nSetGoOnCount = nSetGoOnCount - 1
      end
    elseif sCmdName == "SetL2D" then
      if tbParam[1] == 0 then
        if nSetGoOnCount ~= 0 then
          local sErr = "多"
          if 0 < nSetGoOnCount then
            sErr = "少"
          end
          sReturn = sReturn .. string.format("\n校验失败id%d “续播”指令 %s 配了 %d 个", nCheckId, sErr, math.abs(nSetGoOnCount))
          nSetGoOnCount = 0
        end
        local sAvgCharId = tbParam[2]
        local sPose = tbParam[3]
        local sFullPath = Settings.AB_ROOT_PATH .. string.format("Actor2D/CharacterAvg/%s/%s_%s.prefab", sAvgCharId, sAvgCharId, sPose)
        goL2D = GameResourceLoader.LoadAsset(ResType.Any, sFullPath, typeof(Object), "UI", PanelId.AvgEditorMultiLanTool)
      else
        if nNextEventCountCn ~= 0 or nNextEventCountJp ~= 0 then
          local sErr_Cn, sErr_Jp = "", ""
          if nNextEventCountCn ~= 0 then
            local sErr = "多"
            if 0 < nNextEventCountCn then
              sErr = "少"
            end
            sErr_Cn = string.format("中配文本里 %s 配了 %d 个", sErr, math.abs(nNextEventCountCn))
            nNextEventCountCn = 0
          end
          if nNextEventCountJp ~= 0 then
            local sErr = "多"
            if 0 < nNextEventCountJp then
              sErr = "少"
            end
            sErr_Jp = string.format("日配文本里 %s 配了 %d 个", sErr, math.abs(nNextEventCountJp))
            nNextEventCountJp = 0
          end
          sReturn = sReturn .. string.format("\n校验失败id%d 与动画%s中的打点数量 cn%d jp%d 不一致 %s %s", nCheckId, sAnim, nCn, nJp, sErr_Cn, sErr_Jp)
        end
        goL2D = nil
        sAnim = ""
        nCn = 0
        nJp = 0
      end
    elseif sCmdName == "CtrlL2D" and goL2D ~= nil then
      if nNextEventCountCn ~= 0 or nNextEventCountJp ~= 0 then
        local sErr_Cn, sErr_Jp = "", ""
        if nNextEventCountCn ~= 0 then
          local sErr = "多"
          if 0 < nNextEventCountCn then
            sErr = "少"
          end
          sErr_Cn = string.format("中配文本里 %s 配了 %d 个", sErr, math.abs(nNextEventCountCn))
          nNextEventCountCn = 0
        end
        if nNextEventCountJp ~= 0 then
          local sErr = "多"
          if 0 < nNextEventCountJp then
            sErr = "少"
          end
          sErr_Jp = string.format("日配文本里 %s 配了 %d 个", sErr, math.abs(nNextEventCountJp))
          nNextEventCountJp = 0
        end
        sReturn = sReturn .. string.format("\n校验失败id:%d 与动画%s中的打点数量 cn%d jp%d 不一致 %s %s", nCheckId, sAnim, nCn, nJp, sErr_Cn, sErr_Jp)
      end
      nCheckId = i
      sAnim = tbParam[3]
      nNextEventCountCn = NovaAPIHotfix.CheckL2DAnimEventCount(goL2D, tbParam[3] .. "_cn")
      nNextEventCountJp = NovaAPIHotfix.CheckL2DAnimEventCount(goL2D, tbParam[3] .. "_jp")
      nCn = nNextEventCountCn
      nJp = nNextEventCountJp
    end
  end
  if sReturn == "" then
    sReturn = "\n校验通过"
  end
  return sReturn
end

function AvgEditorMultiLanTool:InitLSV()
  local nCount = 0
  if self.nCurTogIdx == 1 then
    local nTogCount = #self.tbLuaFileName
    for i = 2, nTogCount do
      nCount = nCount + #self.tbLuaFileName[i]
    end
    if nCount ~= #self.tbLuaFileName[1] then
      printError("演出配置文件数量统计有误！")
      nCount = 0
    end
  else
    nCount = #self.tbLuaFileName[self.nCurTogIdx]
  end
  if 0 < nCount then
    self._mapNode.lsv_multi_lan:Init(nCount, self, self.OnRefreshGrid, self.OnGridBtnClick)
    self._mapNode.lsv_multi_lan:ForceRefresh()
  else
    delChildren(self._mapNode.procContent)
  end
end

function AvgEditorMultiLanTool:OnRefreshGrid(go)
  local nIndex = tonumber(go.name) + 1
  local tbGridData = self:GetGridData(nIndex)
  if tbGridData == nil then
    return
  end
  NovaAPI.SetImageColor(go:GetComponent("Image"), tbGridData.bSelected == true and Color.green or Color.white)
  NovaAPI.SetText(go.transform:GetChild(0):GetComponent("Text"), tbGridData.sName)
end

function AvgEditorMultiLanTool:OnGridBtnClick(go)
  local nIndex = tonumber(go.name) + 1
  local tbGridData = self:GetGridData(nIndex)
  if tbGridData == nil then
    return
  end
  tbGridData.bSelected = not tbGridData.bSelected
  NovaAPI.SetImageColor(go:GetComponent("Image"), tbGridData.bSelected == true and Color.green or Color.white)
  local sName = tbGridData.sName
  local bSelected = tbGridData.bSelected
  local nFrom = self.nCurTogIdx == 1 and 2 or 1
  local nTo = self.nCurTogIdx == 1 and #self.tbLuaFileName or 1
  for i = nFrom, nTo do
    local tb = self.tbLuaFileName[i]
    for ii, vv in ipairs(tb) do
      if vv.sName == sName then
        vv.bSelected = bSelected
        break
      end
    end
  end
end

function AvgEditorMultiLanTool:GetGridData(nIndex)
  local tb = self.tbLuaFileName[self.nCurTogIdx]
  return tb[nIndex]
end

function AvgEditorMultiLanTool:SetLSV_Visible(bVisible)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgLSV, bVisible == true and 1 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.cgLSV, bVisible == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgLSV, bVisible == true)
  NovaAPI.SetButtonInteractable(self._mapNode.btn_ProcMultiLanguage, bVisible == true)
  NovaAPI.SetButtonInteractable(self._mapNode.btn_CheckW, bVisible == true)
end

function AvgEditorMultiLanTool:onToggle_LuaGroup(toggle, nIndex, bIsOn)
  if bIsOn == false then
    return
  end
  if nIndex == self.nCurTogIdx then
    return
  end
  self.nCurTogIdx = nIndex
  self:InitLSV()
end

return AvgEditorMultiLanTool
