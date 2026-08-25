local CmdParserUtils = {}

function CmdParserUtils.GetCfgByCond(cfgCondList, cmdParser, parserEnv)
  if type(cfgCondList) ~= "table" then
    return nil
  end
  cmdParser = cmdParser or BattleCmdParserClient(parserEnv or {})
  for i = #cfgCondList, 1, -1 do
    local cfgCond = cfgCondList[i]
    if type(cfgCond) ~= "table" then
      return nil
    end
    local cond, rst = cfgCond[1], cfgCond[2]
    if "true" == cond then
      return rst
    end
    if tonumber(cond) then
      return nil
    end
    if cmdParser:GetValueByCmd(cond) == true then
      return rst
    end
  end
end

return CmdParserUtils
