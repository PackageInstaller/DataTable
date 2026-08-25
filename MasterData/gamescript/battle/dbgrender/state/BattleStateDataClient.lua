local BattleStateDataClient, Super = System.NewClass("BattleStateDataClient", BattleEntity)

function BattleStateDataClient:ctor(data, useMergeConfigFirst)
  Super.ctor(self)
  self.state = data
  if useMergeConfigFirst then
    self:SetConfigData(data.mergeConfigData or data.configData)
  else
    self:SetConfigData(data.configData)
  end
  if not self.configData then
    self:SetConfigData(DT.State[self.state.stateId])
  end
end

function BattleStateDataClient:SetConfigData(tbl)
  self.configData = tbl
end

function BattleStateDataClient:GetCmdParser()
  if self.cmdParser then
    return self.cmdParser
  end
  local parserEnv = {
    state = self.state
  }
  local ownerUid = self.state.ownerUid
  if self.state.stateType == bc.StateType.Card then
    local card = bg.battleRender.cardMgr:GetCardByUid(ownerUid)
    if card then
      parserEnv.card = card
    end
  elseif self.state.stateType == bc.StateType.Role then
    local roleDataModel = bg.battleDataCenter:GetRoleDataModel(ownerUid)
    if roleDataModel then
      parserEnv.awaker = roleDataModel
    end
  elseif self.state.stateType == bc.StateType.Awaker then
    local awakerDataModel = bg.battleDataCenter:GetAwakerDataModel(ownerUid)
    if awakerDataModel then
      parserEnv.awaker = awakerDataModel
    end
  end
  self.cmdParser = BattleCmdParserClient(parserEnv)
  return self.cmdParser
end

function BattleStateDataClient:GetDescArg(index)
  local descPara = self.configData.DescPara or {}
  local argStr = descPara[index]
  if argStr then
    do return self.GetFormulaValue, self end
    return self.GetFormulaValue, self, argStr
  end
  return 0
end

function BattleStateDataClient:GetDesc()
  local str = LT.Text(self.configData.Desc)
  if not str then
    return ""
  end
  str = self:ReplaceStateTextArgs(str)
  local _, _, subStr = string.find(str, "%[ShowIfState:(.-)%]")
  if subStr then
    str = string.replace(str, "%[ShowIfState:.-%]", subStr)
  end
  local awakerDataModel = bg.battleDataCenter:GetAwakerDataModel(self.state.ownerUid)
  local awakerTid = awakerDataModel and awakerDataModel.tid
  if not awakerTid then
    local cardClient = bg.battleRender.cardMgr:GetCardByUid(self.state.ownerUid)
    if cardClient and cardClient.awaker then
      awakerTid = cardClient.awaker.tid
    end
  end
  str = StrUtils.SetWordEffectStr(str, function(_, wordEffectKey, wordEffectValue, content)
    return CardDataUtils.GetWordEffectSkillName(wordEffectKey, wordEffectValue, awakerTid, bg.isPVP) or "-"
  end)
  if not self.state.descArgs then
    do return self.GetStateFormula, self end
    return self.GetStateFormula, self, str, nil, nil
  end
  if self.state.mergeConfigData and self.state.descArgs.curValues then
    self.state.descArgs.curValues[1] = self.state.layer
  end
  local cnDesc = self:ReplaceStateTextArgs(self.configData.Desc)
  local desc = CardDataUtils.ReplaceDescArgs(str, self.state.descArgs, cnDesc)
  return desc
end

function BattleStateDataClient:ReplaceStateTextArgs(str)
  do return StateDataUtils.ReplaceStatusApplierText, str end
  return StateDataUtils.ReplaceStatusApplierText, str, self.state
end

function BattleStateDataClient:GetBuffName()
  local str = LT.Text(self.configData.Name)
  if not self.state.nameArgs then
    do return self.GetStateFormula, self end
    return self.GetStateFormula, self, str, nil
  end
  do return CardDataUtils.ReplaceDescArgs, str, self.state.nameArgs end
  return CardDataUtils.ReplaceDescArgs, str, self.state.nameArgs, self.configData.Name
end

function BattleStateDataClient:GetBaseArgs()
  local cmdParser = self:GetCmdParser()
  local stateCfg = DT.State[self.state.stateId]
  local baseArgs = {}
  if stateCfg.StatePara and next(stateCfg.StatePara) ~= nil then
    local stateParas = cmdParser:GetValueByCmdList(stateCfg.StatePara)
    for i, v in ipairs(stateParas) do
      baseArgs["StateArg" .. i] = v
    end
  end
  if stateCfg.DescPara and nil ~= next(stateCfg.DescPara) then
    local descParas = cmdParser:GetValueByCmdList(stateCfg.DescPara)
    for i, v in ipairs(descParas) do
      baseArgs["DescArg" .. i] = v
    end
  end
  baseArgs.Layer = self.state.layer
  return baseArgs
end

function BattleStateDataClient:GetStateFormula(str)
  if not str then
    return
  end
  local cmdParser = self:GetCmdParser()
  local baseArgs = self:GetBaseArgs()
  for valueStr in string.gmatch(str, "%b[]") do
    valueStr = string.match(valueStr, "%[(.+)]")
    local subStrs = string.split(valueStr, ":")
    local tagStr = #subStrs > 1 and subStrs[1] or nil
    valueStr = subStrs[#subStrs]
    local value = baseArgs[valueStr] or 0
    if "Float" ~= tagStr then
      value = math.ceil(value)
    end
    value = SkillUtils.GetShowValue(cmdParser, tagStr, value)
    str = string.gsub(str, "%b[]", value, 1)
  end
  return str
end

function BattleStateDataClient:GetBuffTypeDesc()
  do return LT.Text end
  return LT.Text, "Buff_Tips_Buff"
end

function BattleStateDataClient:GetLifeText()
  do return LT.Textf, "Battle_State_Layer", bc.NumberToK(math.ceil(self.state.layer)) end
  return LT.Textf, "Battle_State_Layer", bc.NumberToK(math.ceil(self.state.layer))
end

function BattleStateDataClient:ShowJudgement()
  if not self.configData.ShowJudgement then
    return true
  end
  local cmdParser = self:GetCmdParser()
  do return cmdParser.GetValueByCmd, cmdParser end
  return cmdParser.GetValueByCmd, cmdParser, self.configData.ShowJudgement
end

return BattleStateDataClient
