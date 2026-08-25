local Text = CS.UnityEngine.UI.Text
local InputField = CS.UnityEngine.UI.InputField
local typeof = _ENV.typeof
local GmParamPanel, Super = System.NewClass("GmParamPanel", UIBasePanel)
GmParamPanel.uiResCls = GmParamPanelResource
local MAX_PARAM = 6
local GM_ATTACK_ALL_ENEMY_ID = 258

function GmParamPanel:ctor(gmConfig)
  Super.ctor(self)
  self.config = gmConfig
  self.specialCfgNameFuncMap = {
    Skill = self.SkillCfgNameFunc,
    Weapon = self.WeaponCfgNameFunc,
    Trinket = self.TrinketCfgNameFunc,
    AccountJson = self.AccountJsonCfgNameFunc,
    Quality = self.QualityFunc,
    ["Constant.TrinketSubAttrTypeWeight"] = self.Constant_TrinketSubAttrTypeWeight
  }
end

function GmParamPanel:SetParam(index, maxCount)
  local argObj = self.config["arg" .. index]
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
  textParamObj:GetComponent(typeof(Text)).text = self.config["arg" .. index] .. ": "
  local key = CommonDefine.LocalSaveKeyCommon.GMPrefix .. "_%s_%s"
  local saveArg = MobileFileDataManager.Instance:GetCommFileValue(string.format(key, self.config.name, index))
  saveArg = saveArg or self:GetDefaultArg(index)
  inputParamObj:GetComponent(typeof(InputField)).text = saveArg
  local cfgName = self.config["arg" .. index .. "Cfg"]
  local cfgBtn = self.ui["Btn_Param" .. index]
  if cfgBtn then
    cfgBtn:SetActive(nil ~= cfgName)
    self.binder:BindButtonClick(cfgBtn, function()
      self:ShowSimpleListPanel(cfgName, function(data)
        UIManager.Instance:CloseByUrl(Urls.SimpleListView)
        if data.text ~= "清除" then
          inputParamObj:GetComponent(typeof(InputField)).text = data.id
        else
          inputParamObj:GetComponent(typeof(InputField)).text = ""
        end
      end)
    end)
  end
end

function GmParamPanel:ShowSimpleListPanel(cfgName, callback)
  if not cfgName then
    return
  end
  local list = {
    [1] = {id = 0, text = "清除"}
  }
  if self.specialCfgNameFuncMap[cfgName] then
    list = self.specialCfgNameFuncMap[cfgName](list, cfgName)
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

local function is_card(skillType)
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

function GmParamPanel.SkillCfgNameFunc(showList)
  local rst = showList
  local isPVP = bg and bg.isPVP
  for _, info in pairs(DT.Skill) do
    if is_card(info.Type) then
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

function GmParamPanel.WeaponCfgNameFunc(showList)
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

function GmParamPanel.TrinketCfgNameFunc(showList)
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

function GmParamPanel.QualityFunc(showList)
  local rst = showList
  for k, v in pairs(CommonDefine.CommonQuality) do
    if "__kind" ~= k then
      table.insert(rst, {id = k, text = v})
    end
  end
  return rst
end

function GmParamPanel.Constant_TrinketSubAttrTypeWeight(showList)
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

function GmParamPanel.AccountJsonCfgNameFunc(showList)
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
    recordFile:close()
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

function GmParamPanel:OnBind(binder)
  self.binder = binder
  self.ui.Text_GnName:GetComponent(typeof(Text)).text = "Gm命令: " .. self.config.name
  self.binder:BindButtonClick(self.ui.Btn_Send, System.fn(self, self.OnClickSend))
  self.binder:BindButtonClick(self.ui.Btn_Close, System.fn(self, self.OnClickClose))
  self.binder:BindToText(self.ui.Text_Gm_Desc, function()
    return self.config.otherDesc or ""
  end)
  for index = 1, MAX_PARAM do
    self:SetParam(index, self.config.num)
  end
  if self.config.id == GM_ATTACK_ALL_ENEMY_ID then
    self:SetupAttackAllEnemyHitCountParam()
  end
end

function GmParamPanel:GetParam(index)
  local arg, desc
  if self.ui["Input_Param" .. index] then
    arg = self.ui["Input_Param" .. index]:GetComponent(typeof(InputField)).text or ""
  end
  if "" == arg then
    desc = LT.Textf(DT.TipsType[10192].Desc, self.config["arg" .. index])
  end
  return arg, desc
end

function GmParamPanel:OnClickSend()
  local argList = {}
  for index = 1, self.config.num do
    if index <= MAX_PARAM then
      local arg, desc = self:GetParam(index)
      if desc and index <= self.config.num and self.config.id ~= 183 then
        Alert.Show(10192, nil, nil, nil, desc)
        return
      end
      table.insert(argList, arg)
    end
  end
  local key = CommonDefine.LocalSaveKeyCommon.GMPrefix .. "_%s_%s"
  if self.config.id == GM_ATTACK_ALL_ENEMY_ID then
    local hitCount = math.max(1, math.floor(tonumber(self:GetParam(2)) or 1))
    Logger.Info("GmCommond cmd=%s, arg1=%s hitCount=%s", self.config.name, table.tostring(argList), hitCount)
    for _ = 1, hitCount do
      GmManager.Instance.TriggerGm(self.config.id, argList[1])
    end
    local hitCountArg = self:GetParam(2)
    if hitCountArg and "" ~= hitCountArg then
      MobileFileDataManager.Instance:SetCommFileValue(string.format(key, self.config.name, 2), hitCountArg)
    end
  else
    Logger.Info("GmCommond cmd=%s, arg1=%s arg2=%s", self.config.name, table.tostring(argList))
    GmManager.Instance.TriggerGm(self.config.id, table.unpack(argList))
  end
  GmParamPanel.OnClickClose()
  for index = 1, self.config.num do
    if argList[index] then
      MobileFileDataManager.Instance:SetCommFileValue(string.format(key, self.config.name, index), argList[index])
    end
  end
  MobileFileDataManager.Instance:OnSaveCommInfo()
end

function GmParamPanel.OnClickClose()
  if UIManager.Instance then
    UIManager.Instance:CloseByUrl(Urls.GmParamPanel)
  end
end

function GmParamPanel:GetDefaultArg(index)
  return self.config["arg" .. index .. "DefaultVal"]
end

function GmParamPanel:SetupAttackAllEnemyHitCountParam()
  local textParamObj = self.ui.Text_Param2
  local inputParamObj = self.ui.Input_Param2
  if not textParamObj or not inputParamObj then
    return
  end
  textParamObj:SetActive(true)
  inputParamObj:SetActive(true)
  textParamObj:GetComponent(typeof(Text)).text = "伤害次数: "
  local key = CommonDefine.LocalSaveKeyCommon.GMPrefix .. "_%s_%s"
  local saveArg = MobileFileDataManager.Instance:GetCommFileValue(string.format(key, self.config.name, 2))
  saveArg = saveArg or "1"
  inputParamObj:GetComponent(typeof(InputField)).text = saveArg
end

return GmParamPanel
