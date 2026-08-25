local AvgCmdComponent, Super = System.NewClass("AvgCmdComponent", Component)

function AvgCmdComponent:ctor(avgModel)
  Super.ctor(self)
  self.cmdList = nil
  self.avgModel = avgModel
end

function AvgCmdComponent:Awake()
  Super.Awake(self)
end

function AvgCmdComponent:InitSequence(Sequence)
  self:Clear()
  self.cmdList = string.split(Sequence or "", ";")
  self.curCmdIndex = 0
  self:ExecuteNextCmd()
end

function AvgCmdComponent:Clear()
  self.cmdList = nil
  self.curCmdIndex = nil
  if self.curCmd then
    self.curCmd:OnDestroy()
    self.curCmd = nil
  end
end

function AvgCmdComponent:ExecuteNextCmd()
  if self.curCmd then
    self.curCmd:OnDestroy()
    self.curCmd = nil
  end
  self.curCmdIndex = self.curCmdIndex + 1
  if self.curCmdIndex > #(self.cmdList or {}) then
    self:CmdFinish()
    return
  end
  local cmdStr = self.cmdList[self.curCmdIndex]
  if not cmdStr or "" == cmdStr then
    self:CmdFinish()
    return
  end
  local cmdName, cmdParams = self:ParseCmdStr(cmdStr)
  local cmdCls = require("GameScript.Managers.AvgStory.Cmd.AvgCmd" .. cmdName)
  local curCmd = cmdCls(self, cmdParams)
  curCmd:Awake()
  if curCmd.isPaused then
    self.curCmd = curCmd
    return
  end
  curCmd:OnDestroy()
  do return self.ExecuteNextCmd end
  return self.ExecuteNextCmd, self
end

function AvgCmdComponent:ParseCmdStr(cmdStr)
  local strList = string.split(cmdStr, "(")
  local cmdName = strList[1]
  local cmdParamStr = string.replace(strList[2] or "", "%)", "")
  local cmdParamStrList = string.split(cmdParamStr, ",")
  local cmdParams = {}
  for index, paramStr in ipairs(cmdParamStrList) do
    cmdParams[index] = string.replace(paramStr, " ", "")
  end
  return cmdName, cmdParams
end

function AvgCmdComponent:CmdFinish()
  self:Clear()
end

function AvgCmdComponent:OnDestroy()
  Super.OnDestroy(self)
end

return AvgCmdComponent
