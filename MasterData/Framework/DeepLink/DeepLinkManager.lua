DeepLinkManager = {}
local JumpManager = require("Game.Jump.JumpManager")
local HomeEnum = require("Game.Home.HomeEnum")
local deepLinkFunc = {
  jump = {
    DeepLinkAction = function(arg, continueAction)
      local argList = CommonUtil.SplitStrToNumber(arg, "_")
      if #argList <= 0 then
        return false
      end
      local jumpId = argList[1]
      local jumpArgs
      if 1 < #argList then
        table.remove(argList, 1)
        jumpArgs = argList
      end
      if JumpManager:ValidateJump(jumpId, jumpArgs) then
        JumpManager:Jump(jumpId, nil, nil, jumpArgs)
        return true
      end
      return false
    end
  },
  gamenotice = {
    DeepLinkAction = function(arg, continueAction)
      local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Notice)
      if not isUnlock then
        return false
      end
      if UIManager:GetWindow(UIWindowTypeID.GameNotice) ~= nil or UIManager:IsWindowInLoading(UIWindowTypeID.GameNotice) then
        return false
      end
      UIManager:CreateWindowAsync(UIWindowTypeID.GameNotice, function(win)
        if win == nil then
          return
        end
        local homeSide = UIManager:GetWindow(UIWindowTypeID.HomeSide)
        if homeSide ~= nil then
          homeSide:CloseSide()
        end
        win:SetCloseCallback(continueAction)
        win:InitUIGameNotice(false)
      end)
      return true
    end
  }
}

function DeepLinkManager:_Init()
  if Consts.GameChannelType.IsInland() and not isEditorMode then
    return
  end
  local cs_MonoDriver_Instance = CS.MonoDriver.Instance
  cs_MonoDriver_Instance:onDeepLinkActive("+", BindCallback(self, self._OnDeepLinkActive))
  local ok, funcName, arg = cs_MonoDriver_Instance:TryGetLastDeepLink()
  if not ok then
    return
  end
  if deepLinkFunc[funcName] == nil then
    return
  end
  self._linkFunc = funcName
  self._linkArg = arg
end

function DeepLinkManager:_OnDeepLinkActive(funcName, arg)
  if deepLinkFunc[funcName] == nil then
    return
  end
  local loginWindow = UIManager:GetWindow(UIWindowTypeID.Login)
  if loginWindow ~= nil then
    self._linkFunc = funcName
    self._linkArg = arg
    return
  end
  local homeController = ControllerManager:GetController(ControllerTypeId.HomeController)
  if homeController ~= nil and not homeController.isRunningAutoShow and homeController.homeState == HomeEnum.eHomeState.Normal then
    self._linkFunc = funcName
    self._linkArg = arg
    self:StartDeepLink()
  end
end

function DeepLinkManager:StartDeepLink(continueAction)
  if string.IsNullOrEmpty(self._linkFunc) then
    return false
  end
  if GuideManager.inGuide then
    DeepLinkManager:ClearLink()
    return false
  end
  local dpData = deepLinkFunc[self._linkFunc]
  if dpData == nil then
    DeepLinkManager:ClearLink()
    return false
  end
  local interrupt = dpData.DeepLinkAction(self._linkArg, continueAction)
  DeepLinkManager:ClearLink()
  return interrupt
end

function DeepLinkManager:ClearLink()
  self._linkFunc = nil
  self._linkArg = nil
end

DeepLinkManager:_Init()
