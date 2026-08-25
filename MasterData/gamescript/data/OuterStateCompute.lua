local OuterStateCompute, Super = System.NewClass("OuterStateCompute")

function OuterStateCompute:ctor(stateId, roleData, layer, stateParams, state, card, skillId)
  Super.ctor(self)
  self.stateId = stateId
  local stateCfg = stateId and DT.State[stateId]
  self.configData = stateCfg and table.deepclone(stateCfg) or nil
  self.roleData = roleData
  self.layer = layer
  self.stateParams = {}
  self.state = state
  self.card = card
  self.skillId = skillId
  local cmdParser = self:GetCmdParser()
  self.stateParams = cmdParser:GetValueByCmdList(stateParams or {})
end

function OuterStateCompute:GetBuffName()
  if not self.configData then
    return ""
  end
  local str = LT.Text(self.configData.Name)
  do return self.GetStateFormula, self end
  return self.GetStateFormula, self, str
end

function OuterStateCompute:GetDesc()
  if not self.configData then
    return ""
  end
  local str = LT.Text(self.configData.Desc)
  if not str then
    return ""
  end
  str = self:ReplaceStateTextArgs(str)
  do return self.GetStateFormula, self end
  return self.GetStateFormula, self, str
end

function OuterStateCompute:ReplaceStateTextArgs(str)
  do return StateDataUtils.ReplaceStatusApplierText, str end
  return StateDataUtils.ReplaceStatusApplierText, str, self.state
end

function OuterStateCompute:GetCmdParser()
  if not self.cmdParser then
    local card = self.card
    card = type(card) == "table" and card.uid and CardDataUtils.GetCardInfo(card.uid) or card
    local awaker = self.roleData
    awaker = card and card.uid and CardDataUtils.GetCardAwakerData(card.uid) or awaker
    local parserEnv = {
      awaker = awaker,
      state = self.state,
      card = card,
      skillId = self.skillId
    }
    local cmdParser = BattleCmdParserClient(parserEnv)
    self.cmdParser = cmdParser
  end
  return self.cmdParser
end

function OuterStateCompute:GetBaseArgs()
  local cmdParser = self:GetCmdParser()
  local baseArgs = {}
  local stateParas = self.stateParams
  for i, v in ipairs(stateParas) do
    baseArgs["StateArg" .. i] = v
  end
  if self.configData and self.configData.DescPara and next(self.configData.DescPara) ~= nil then
    local descParas = cmdParser:GetValueByCmdList(self.configData.DescPara)
    for i, v in ipairs(descParas) do
      baseArgs["DescArg" .. i] = v
    end
  end
  baseArgs.Layer = self.layer
  return baseArgs
end

function OuterStateCompute:GetStateFormula(str)
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
    local value = tonumber(valueStr) or baseArgs[valueStr] or 0
    if "Float" ~= tagStr then
      value = math.ceil(value)
    end
    value = SkillUtils.GetShowValue(cmdParser, tagStr, value)
    str = string.gsub(str, "%b[]", value, 1)
  end
  return str
end

function OuterStateCompute:ShowJudgement()
  if not self.configData then
    return false
  end
  if not self.configData.ShowJudgement then
    return true
  end
  local cmdParser = self:GetCmdParser()
  do return cmdParser.GetValueByCmd, cmdParser end
  return cmdParser.GetValueByCmd, cmdParser, self.configData.ShowJudgement
end

return OuterStateCompute
