local ExeEditorCtrl = class("ExeEditorCtrl", BaseCtrl)
ExeEditorCtrl._mapNodeConfig = {
  btn_AvgEditor = {
    sComponentName = "Button",
    callback = "onBtn_AvgEditor"
  },
  btn_BubbleVoiceEditor = {
    sComponentName = "Button",
    callback = "onBtn_BubbleVoiceEditor"
  },
  tog_CanEdit = {
    sComponentName = "Toggle",
    callback = "OnTog_CanEdit"
  },
  btn_TEST = {sComponentName = "Button", callback = "onBtn_TEST"}
}
ExeEditorCtrl._mapEventConfig = {}

function ExeEditorCtrl:OnEnable()
  local go = GameObject.Find("==== UI ROOT ====/---- UI OVERLAY ----/TouchEffectUI")
  go:SetActive(false)
  local _goLogView = GameObject.Find("==== UI ROOT ====/---- UI OVERLAY ----/_InGameLogView")
  if _goLogView ~= nil and _goLogView:IsNull() == false then
    _goLogView:SetActive(true)
  end
  self.bCanEdit = Settings.sCurrentTxtLanguage == AllEnum.Language.CN or Settings.sCurrentTxtLanguage == AllEnum.Language.JP
  NovaAPI.SetToggleIsOn(self._mapNode.tog_CanEdit, self.bCanEdit)
end

function ExeEditorCtrl:onBtn_AvgEditor()
  require("Game.UI.Avg.Editor.main")
  CAN_EDIT = self.bCanEdit
  EventManager.Hit(EventId.OpenPanel, PanelId.AvgEditor)
end

function ExeEditorCtrl:onBtn_BubbleVoiceEditor()
  require("Game.Actor2D.Editor_BBV.main")
  EventManager.Hit(EventId.OpenPanel, PanelId.BBVEditor)
end

function ExeEditorCtrl:OnTog_CanEdit()
  local bCan = NovaAPI.GetToggleIsOn(self._mapNode.tog_CanEdit) == true
  if bCan ~= self.bCanEdit then
    self.bCanEdit = bCan
  end
end

function ExeEditorCtrl:onBtn_TEST()
end

function ExeEditorCtrl:CheckMissingAvgCharacterId()
  local rootPath = CS.UnityEngine.Application.dataPath .. "/../Lua/Game/UI/Avg/"
  local sourceDir = {
    rootPath .. "_cn/Config",
    rootPath .. "_en/Config",
    rootPath .. "_jp/Config",
    rootPath .. "_kr/Config",
    rootPath .. "_tw/Config"
  }
  local targetFile = rootPath .. "AvgCharacter/AvgCharacter.lua"
  local cmdGroup = self:ScanCmdGetParamTarget()
  local allFields = {}
  for k, v in ipairs(sourceDir) do
    print("开始扫描源目录: " .. v)
    local sourceFiles = self:ScanDirectoryForLuaFiles(v)
    for _, filePath in ipairs(sourceFiles) do
      local allParamTables = self:ExtractFieldsFromFile(filePath, cmdGroup)
      allFields[filePath] = allParamTables
    end
  end
  local missing = self:CheckFieldsInTarget(allFields, targetFile)
  self:ExportTxtFile(missing)
end

function ExeEditorCtrl:ScanCmdGetParamTarget()
  local filePath = "D:/NewNovaProject/Nova_Client/Lua/Game/UI/Avg/Editor/CmdInfo.lua"
  local paramTables = {}
  if CS.System.IO.File.Exists(filePath) then
    local lines = CS.System.IO.File.ReadAllLines(filePath)
    local funcName = ""
    for i = 0, lines.Length - 1 do
      local line = lines[i]
      if line:match("function") then
        funcName = line:match("_([^%(]+)%(")
      end
      if funcName ~= "" and line:match("SetAvgCharId") then
        local number = line:match("%[(%d+)%]")
        if number ~= nil then
          paramTables[funcName] = tonumber(number)
        end
      end
    end
  end
  return paramTables
end

function ExeEditorCtrl:ScanDirectoryForLuaFiles(directory)
  local files = {}
  if CS.System.IO.Directory.Exists(directory) then
    local fileEntries = CS.System.IO.Directory.GetFiles(directory, "*.lua", CS.System.IO.SearchOption.AllDirectories)
    for i = 0, fileEntries.Length - 1 do
      table.insert(files, fileEntries[i])
    end
  else
    print("[错误] 目录不存在: " .. directory)
  end
  return files
end

function ExeEditorCtrl:ExtractFieldsFromFile(filePath, tbCmd)
  local paramTables = {}
  if CS.System.IO.File.Exists(filePath) then
    local lines = CS.System.IO.File.ReadAllLines(filePath)
    for i = 0, lines.Length - 1 do
      local line = lines[i]
      local content = line:match("cmd=\"(.-)\"")
      if tbCmd[content] ~= nil then
        local paramTableStr = line:match("param%s*=%s*(%b{})")
        if paramTableStr then
          do
            local success, result = pcall(function()
              local env = {
                table = table
              }
              local func, err = load("return " .. paramTableStr, "tmp", "t", env)
              if func then
                return func()
              else
                print("[解析错误] 行 " .. i + 1 .. ": " .. err)
                return nil
              end
            end)
            if success and result then
              local num = tbCmd[content]
              local AvgCharacterId = result[num]
              table.insert(paramTables, {
                line = i + 1,
                value = AvgCharacterId
              })
            end
          end
        end
      end
    end
  end
  return paramTables
end

function ExeEditorCtrl:CheckFieldsInTarget(fields, targetDir)
  local missing = {}
  local tbAllIds = {}
  if CS.System.IO.File.Exists(targetDir) then
    local lines = CS.System.IO.File.ReadAllLines(targetDir)
    for i = 0, lines.Length - 1 do
      local line = lines[i]
      local content = line:match("id = \"(.-)\"")
      if content ~= nil then
        table.insert(tbAllIds, content)
      end
    end
  end
  for k, v in pairs(fields) do
    if 0 < #v then
      for _, param in ipairs(v) do
        if 0 >= table.indexof(tbAllIds, param.value) then
          if missing[k] == nil then
            missing[k] = {}
          end
          table.insert(missing[k], param)
        end
      end
    end
  end
  return missing
end

function ExeEditorCtrl:ExportTxtFile(missing)
  local exportDir = CS.UnityEngine.Application.dataPath .. "/../AvgCharacterMissingId/"
  local filePath = exportDir .. "output.txt"
  if not CS.System.IO.Directory.Exists(exportDir) then
    CS.System.IO.Directory.CreateDirectory(exportDir)
  end
  local streamWriter = CS.System.IO.File.CreateText(filePath)
  for filePath, params in pairs(missing) do
    streamWriter:WriteLine(filePath)
    for _, param in pairs(params) do
      local line = string.format("    第%s行, name:%s", param.line, param.value)
      streamWriter:WriteLine(line)
    end
  end
  streamWriter:Close()
  print("导出成功！路径: " .. filePath)
end

return ExeEditorCtrl
