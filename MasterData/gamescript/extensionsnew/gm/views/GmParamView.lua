local GmParamView, Super = NewClass("GmParamView", BaseView)
GmParamView.uiResCls = GmParamPanelResource
local MAX_PARAM = 6
local GM_ATTACK_ALL_ENEMY_ID = 258
local SAVE_KEY_FMT = "_%s_%s"

local function _IsCard(skillType)
  for _, t in pairs(skillType) do
    if type(t) == "table" then
      for _, _t in pairs(t) do
        if string.find(_t, "Intent") then
          return false
        end
      end
    elseif string.find(t, "Intent") then
      return false
    end
  end
  return true
end

local function _SkillCfgNameFunc(showList)
  local rst = showList
  local isPVP = bg and bg.isPVP
  for _, info in pairs(DT.Skill) do
    if _IsCard(info.Type) then
      local skillIsPVP = info.IsPVP == true
      if nil == isPVP or isPVP == skillIsPVP then
        if type(info.Name) == "table" then
          if info.Name[1] and info.Name[1][2] then
            table.insert(rst, {
              id = info.ID,
              text = string.format("%s-%s", info.CnID, LT.Text(info.Name[1][2]))
            })
          end
        else
          table.insert(rst, {
            id = info.ID,
            text = string.format("%s-%s", info.CnID, LT.Text(info.Name))
          })
        end
      end
    end
  end
  return rst
end

local function _WeaponCfgNameFunc(showList)
  local rst = showList
  for _, info in pairs(DT.Item) do
    if info.Type == "Weapon" then
      table.insert(rst, {
        id = info.ID,
        text = info.ID .. "-" .. (info.CnID or "") .. "-" .. (info.Name or "")
      })
    end
  end
  return rst
end

local function _TrinketCfgNameFunc(showList)
  local rst = showList
  for _, info in pairs(DT.Item) do
    if info.Type == "Trinket" then
      table.insert(rst, {
        id = info.ID,
        text = info.ID .. "-" .. (info.CnID or "") .. "-" .. (info.Name or "")
      })
    end
  end
  return rst
end

local function _QualityFunc(showList)
  local rst = showList
  for k, v in pairs(CommonDefine.CommonQuality) do
    if "__kind" ~= k then
      table.insert(rst, {id = k, text = v})
    end
  end
  return rst
end

local function _ConstantTrinketSubAttrTypeWeight(showList)
  local rst = showList
  local attrList = {}
  for i = 1, 6 do
    local constantCfg = DT.Constant["TrinketSubAttrTypeWeight_" .. i]
    if constantCfg and constantCfg.Data then
      for j = 1, #constantCfg.Data, 2 do
        local attrCfg = DT.ActorAttrType[constantCfg.Data[j]]
        if attrCfg and not attrList[attrCfg.ID] then
          local text = string.replace(attrCfg.Text, "ActorAttrType_" .. attrCfg.ID .. "_Text|", "")
          table.insert(rst, {
            id = attrCfg.ID,
            text = attrCfg.ID .. "-" .. text
          })
          attrList[attrCfg.ID] = true
        end
      end
    end
  end
  return rst
end

local function _AccountJsonCfgNameFunc(showList)
  local rst = showList
  if ApplicationUtils.is_editor_mode() then
    local filePath = CS.UnityEngine.Application.streamingAssetsPath .. "/AccountJson"
    local fileGroup = CS.System.IO.Directory.GetFiles(filePath, "*.json")
    local recordFile = io.open(filePath .. "/AccountJsonRecord.txt", "w")
    for i = 0, fileGroup.Length - 1 do
      local jsonFileName = string.sub(fileGroup[i], string.find(fileGroup[i], "\\[^\\]*$") + 1)
      table.insert(rst, {id = jsonFileName, text = jsonFileName})
      if recordFile then
        recordFile:write(jsonFileName .. "\n")
      end
    end
    if recordFile then
      recordFile:close()
    end
  else
    local recordData = CS.Framework.AssetLoadUtil.GetJsonFileInApp("AccountJson/AccountJsonRecord.txt")
    local persistentFileName = Utils.GetApplicationPersistenDataPath() .. "/_game_data_/DownLoad/AccountJson/AccountJsonRecord.txt"
    local persisFileInfo = CS.System.IO.FileInfo(persistentFileName)
    persisFileInfo:Refresh()
    if persisFileInfo.Exists then
      recordData = CS.Framework.AssetLoadUtil.LoadTextData(persistentFileName, true)
    end
    persisFileInfo:Refresh()
    for line in recordData:gmatch([[
[^
]+]]) do
      local lineWithoutNewline = line:sub(1, -1)
      lineWithoutNewline = string.gsub(lineWithoutNewline, "%s*$", "")
      table.insert(rst, {id = lineWithoutNewline, text = lineWithoutNewline})
    end
  end
  return rst
end

function GmParamView:ctor(gmConfig)
  Super.ctor(self)
  self._config = gmConfig
  self._specialCfgNameFuncMap = {
    Skill = _SkillCfgNameFunc,
    Weapon = _WeaponCfgNameFunc,
    Trinket = _TrinketCfgNameFunc,
    AccountJson = _AccountJsonCfgNameFunc,
    Quality = _QualityFunc,
    ["Constant.TrinketSubAttrTypeWeight"] = _ConstantTrinketSubAttrTypeWeight
  }
end

function GmParamView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Send, System.fn(self, self._OnClickSend))
  self:AddButtonClickListener(self.ui.Btn_Close, System.fn(self, self._OnClickClose))
end

function GmParamView:OnEnterView()
  Super.OnEnterView(self)
  self:SetRawText(self.ui.Text_GnName, "Gm命令: " .. self._config.name)
  self:SetRawText(self.ui.Text_Gm_Desc, self._config.otherDesc or "")
  for index = 1, MAX_PARAM do
    self:_SetParam(index, self._config.num)
  end
  if self._config.id == GM_ATTACK_ALL_ENEMY_ID then
    self:_SetupAttackAllEnemyHitCountParam()
  end
end

function GmParamView:OnExitView()
  Super.OnExitView(self)
end

function GmParamView:_SetParam(index, maxCount)
  local argObj = self._config["arg" .. index]
  local textParamObj = self.ui["Text_Param" .. index]
  local inputParamObj = self.ui["Input_Param" .. index]
  if textParamObj then
    textParamObj:SetActive(index <= maxCount)
  end
  if inputParamObj then
    inputParamObj:SetActive(index <= maxCount)
  end
  if not (argObj and textParamObj) or not inputParamObj then
    return
  end
  if maxCount < index then
    return
  end
  self:SetRawText(textParamObj, self._config["arg" .. index] .. ": ")
  local saveArg = MobileFileDataManager.Instance:GetCommFileValue(self:_GetSaveKey(index))
  saveArg = saveArg or self:_GetDefaultArg(index)
  self:SetInputText(inputParamObj, saveArg)
  local cfgName = self._config["arg" .. index .. "Cfg"]
  local cfgBtn = self.ui["Btn_Param" .. index]
  if cfgBtn then
    cfgBtn:SetActive(nil ~= cfgName)
    self:AddButtonClickListener(cfgBtn, function()
      self:_ShowSimpleListPanel(cfgName, function(data)
        UIManager.Instance:CloseByUrl(Urls.SimpleListView)
        if data.text ~= "清除" then
          self:SetInputText(inputParamObj, data.id)
        else
          self:SetInputText(inputParamObj, "")
        end
      end)
    end)
  end
end

function GmParamView:_ShowSimpleListPanel(cfgName, callback)
  if not cfgName then
    return
  end
  local list = {
    [1] = {id = 0, text = "清除"}
  }
  if self._specialCfgNameFuncMap[cfgName] then
    list = self._specialCfgNameFuncMap[cfgName](list, cfgName)
  else
    for _, info in pairs(DT[cfgName]) do
      table.insert(list, {
        id = info.ID,
        text = info.ID .. "-" .. (info.CnID or "") .. "-" .. LT.Text(info.Name or "")
      })
    end
  end
  Logger.Info("Reopen(Urls.SimpleListView) list", table.tostring(list))
  UIManager.Instance:Reopen(Urls.SimpleListView, list, function(data)
    callback(data)
  end, true)
end

function GmParamView:_GetParam(index)
  local arg, desc
  if self.ui["Input_Param" .. index] then
    arg = self:GetInputText(self.ui["Input_Param" .. index]) or ""
  end
  if "" == arg then
    desc = LT.Textf(DT.TipsType[10192].Desc, self._config["arg" .. index])
  end
  return arg, desc
end

function GmParamView:_OnClickSend()
  local argList = {}
  for index = 1, self._config.num do
    if index <= MAX_PARAM then
      local arg, desc = self:_GetParam(index)
      if desc and index <= self._config.num and self._config.id ~= 183 then
        Alert.Show(10192, nil, nil, nil, desc)
        return
      end
      table.insert(argList, arg)
    end
  end
  if self._config.id == GM_ATTACK_ALL_ENEMY_ID then
    local hitCount = math.max(1, math.floor(tonumber(self:_GetParam(2)) or 1))
    Logger.Info("GmCommond cmd=%s, arg1=%s hitCount=%s", self._config.name, table.tostring(argList), hitCount)
    for _ = 1, hitCount do
      GmManager.Instance.TriggerGm(self._config.id, argList[1])
    end
    local hitCountArg = self:_GetParam(2)
    if hitCountArg and "" ~= hitCountArg then
      MobileFileDataManager.Instance:SetCommFileValue(self:_GetSaveKey(2), hitCountArg)
    end
  else
    Logger.Info("GmCommond cmd=%s, arg1=%s arg2=%s", self._config.name, table.tostring(argList))
    GmManager.Instance.TriggerGm(self._config.id, table.unpack(argList))
  end
  self:Close()
  for index = 1, self._config.num do
    if argList[index] then
      MobileFileDataManager.Instance:SetCommFileValue(self:_GetSaveKey(index), argList[index])
    end
  end
  MobileFileDataManager.Instance:OnSaveCommInfo()
end

function GmParamView:_OnClickClose()
  self:Close()
end

function GmParamView:_GetDefaultArg(index)
  return self._config["arg" .. index .. "DefaultVal"]
end

function GmParamView:_GetSaveKey(index)
  do return string.format, CommonDefine.LocalSaveKeyCommon.GMPrefix .. SAVE_KEY_FMT, self._config.name end
  return string.format, CommonDefine.LocalSaveKeyCommon.GMPrefix .. SAVE_KEY_FMT, self._config.name, index
end

function GmParamView:_SetupAttackAllEnemyHitCountParam()
  local textParamObj = self.ui.Text_Param2
  local inputParamObj = self.ui.Input_Param2
  if not textParamObj or not inputParamObj then
    return
  end
  textParamObj:SetActive(true)
  inputParamObj:SetActive(true)
  self:SetRawText(textParamObj, "伤害次数: ")
  local saveArg = MobileFileDataManager.Instance:GetCommFileValue(self:_GetSaveKey(2))
  saveArg = saveArg or "1"
  self:SetInputText(inputParamObj, saveArg)
end

return GmParamView
