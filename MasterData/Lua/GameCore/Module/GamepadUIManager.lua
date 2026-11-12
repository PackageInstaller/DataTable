local GamepadUIManager = {}
local InputManager = CS.InputManager
local ClientManager = CS.ClientManager.Instance
local sRootPath = Settings.AB_ROOT_PATH
local nCurUIType = AllEnum.GamepadUIType.Other
local sCurUIName
local tbHistory = {}
local mapGamepadUI = {}
local mapMouseConfig = {}
local mapUIOrder = {}
local bEnableInput = false
local bBlockUI = false
local bFirstInputEnable = false
local bVirtualMouseStickEnable = true

local function ApplyVirtualMouseStickEnableDelay()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    InputManager.Instance:SetVirtualMouseStickEnable(bVirtualMouseStickEnable)
  end
  
  cs_coroutine.start(wait)
end

local function SetGamepadIcon(img, sAction, sIconType)
  local sIcon
  if nCurUIType == AllEnum.GamepadUIType.PS then
    sIcon = ConfigTable.GetField("GamepadAction", sAction, "PlayStationIcon")
  elseif nCurUIType == AllEnum.GamepadUIType.Xbox then
    sIcon = ConfigTable.GetField("GamepadAction", sAction, "XboxIcon")
  elseif nCurUIType == AllEnum.GamepadUIType.Keyboard or nCurUIType == AllEnum.GamepadUIType.Mouse then
    sIcon = ConfigTable.GetField("GamepadAction", sAction, "KeyboardIcon")
  end
  if sIcon == "" then
    img.gameObject:SetActive(false)
    return
  end
  img.gameObject:SetActive(true)
  if sIconType == nil then
    sIconType = "Light"
  end
  local sSuffix = AllEnum.GamepadIconSuffix[sIconType]
  sIcon = sRootPath .. sIcon .. sSuffix .. ".png"
  NovaAPI.SetImageSprite(img, sIcon)
  NovaAPI.SetImageNativeSize(img)
end

local function RefreshCurTypeUINode(v)
  if not v.sAction then
    return
  end
  if v.sComponentName == "NaviButton" then
    if v.mapNode:IsNull() then
      return
    end
    local trRoot = v.mapNode.gameObject:GetComponent("Transform"):Find("AnimRoot")
    if trRoot then
      local Other = trRoot:Find("Other")
      if not Other then
        return
      end
      local General = trRoot:Find("General")
      local Xbox = trRoot:Find("Xbox")
      local PS = trRoot:Find("PS")
      local Keyboard = trRoot:Find("Keyboard")
      if General then
        if Xbox then
          Xbox.gameObject:SetActive(false)
        end
        if PS then
          PS.gameObject:SetActive(false)
        end
        if Keyboard then
          Keyboard.gameObject:SetActive(false)
        end
        General.gameObject:SetActive(nCurUIType ~= AllEnum.GamepadUIType.Other)
        Other.gameObject:SetActive(nCurUIType == AllEnum.GamepadUIType.Other)
        if nCurUIType ~= AllEnum.GamepadUIType.Other then
          local icon = General:Find("imgAction")
          if icon then
            SetGamepadIcon(icon:GetComponent("Image"), v.sAction, v.sActionIconType)
          end
        end
      elseif not General and Xbox and PS and Keyboard then
        Xbox.gameObject:SetActive(nCurUIType == AllEnum.GamepadUIType.Xbox)
        PS.gameObject:SetActive(nCurUIType == AllEnum.GamepadUIType.PS)
        Keyboard.gameObject:SetActive(nCurUIType == AllEnum.GamepadUIType.Keyboard or nCurUIType == AllEnum.GamepadUIType.Mouse)
        Other.gameObject:SetActive(nCurUIType == AllEnum.GamepadUIType.Other)
        local icon
        if nCurUIType == AllEnum.GamepadUIType.Xbox then
          icon = Xbox:Find("imgAction")
        elseif nCurUIType == AllEnum.GamepadUIType.PS then
          icon = PS:Find("imgAction")
        elseif nCurUIType == AllEnum.GamepadUIType.Keyboard or nCurUIType == AllEnum.GamepadUIType.Mouse then
          icon = Keyboard:Find("imgAction")
        end
        if icon then
          SetGamepadIcon(icon:GetComponent("Image"), v.sAction, v.sActionIconType)
        end
      end
    end
  elseif v.sComponentName == "GamepadScroll" then
    if v.mapNode:IsNull() then
      return
    end
    local trRoot = v.mapNode.gameObject:GetComponent("Transform"):Find("Scrollbar")
    if trRoot then
      local icon = trRoot:Find("imgAction")
      if icon then
        icon.gameObject:SetActive(nCurUIType ~= AllEnum.GamepadUIType.Other)
        if nCurUIType ~= AllEnum.GamepadUIType.Other then
          SetGamepadIcon(icon:GetComponent("Image"), v.sAction, v.sActionIconType)
        end
      end
    end
  end
end

local function FindHistoryInsertIndex(nOrder)
  for i = #tbHistory, 1, -1 do
    if nOrder >= mapUIOrder[tbHistory[i]] then
      return i + 1
    end
  end
  return 1
end

local function RefreshCurTypeUI()
  if not sCurUIName then
    return
  end
  local tbNode = mapGamepadUI[sCurUIName]
  if (tbNode == nil or next(tbNode) == nil) and mapMouseConfig[sCurUIName] == nil then
    printWarn("GamepadUIManager：当前UI内节点刷新失败，可能该UI从来没有打开过：" .. sCurUIName)
    return
  end
  for _, v in pairs(tbNode) do
    RefreshCurTypeUINode(v)
  end
end

local function ChangeUIType(nAfterType)
  if nAfterType == nCurUIType then
    return
  end
  local nBeforeType = nCurUIType
  nCurUIType = nAfterType
  EventManager.Hit("GamepadUIChange", sCurUIName, nBeforeType, nAfterType)
  RefreshCurTypeUI()
end

local function GetUITypeByGamepad()
  local nType = InputManager.Instance:CheckGamepadType()
  local nAfterType = AllEnum.GamepadUIType.Other
  if nType == InputManager.GamepadType.PS then
    nAfterType = AllEnum.GamepadUIType.PS
  elseif nType == InputManager.GamepadType.XBox or nType == InputManager.GamepadType.Switch or nType == InputManager.GamepadType.Other then
    nAfterType = AllEnum.GamepadUIType.Xbox
  elseif nType == InputManager.GamepadType.None then
    nAfterType = AllEnum.GamepadUIType.Other
  end
  return nAfterType
end

local function OnEvent_LastInputDeviceChange(_, nType)
  local bMobile = NovaAPI.IsMobilePlatform()
  local bTable = ClientManager.isTabletDevice
  local nAfterType = AllEnum.GamepadUIType.Other
  if nType == InputManager.InputDeviceType.PSGamepad then
    nAfterType = AllEnum.GamepadUIType.PS
  elseif nType == InputManager.InputDeviceType.XBoxGamepad then
    nAfterType = AllEnum.GamepadUIType.Xbox
  elseif nType == InputManager.InputDeviceType.Keyboard and (not bMobile or bTable) then
    nAfterType = AllEnum.GamepadUIType.Keyboard
  elseif nType == InputManager.InputDeviceType.Mouse and (not bMobile or bTable) then
    nAfterType = AllEnum.GamepadUIType.Mouse
  elseif nType == InputManager.InputDeviceType.Other then
    nAfterType = GetUITypeByGamepad()
  elseif nType == InputManager.InputDeviceType.None then
    nAfterType = AllEnum.GamepadUIType.Other
  end
  ChangeUIType(nAfterType)
  ApplyVirtualMouseStickEnableDelay()
end

local function GetUITypeByInputDevice()
  local bMobile = NovaAPI.IsMobilePlatform()
  local nType = InputManager.Instance:CheckInputDeviceType()
  local nAfterType = AllEnum.GamepadUIType.Other
  if nType == InputManager.InputDeviceType.PSGamepad then
    nAfterType = AllEnum.GamepadUIType.PS
  elseif nType == InputManager.InputDeviceType.XBoxGamepad then
    nAfterType = AllEnum.GamepadUIType.Xbox
  elseif nType == InputManager.InputDeviceType.Keyboard and not bMobile then
    nAfterType = AllEnum.GamepadUIType.Keyboard
  elseif nType == InputManager.InputDeviceType.Mouse and not bMobile then
    nAfterType = AllEnum.GamepadUIType.Mouse
  elseif nType == InputManager.InputDeviceType.Other then
    nAfterType = GetUITypeByGamepad()
  elseif nType == InputManager.InputDeviceType.None then
    nAfterType = AllEnum.GamepadUIType.Other
  end
  return nAfterType
end

local function OnEvent_OnDeviceChange(_, changeType)
  if changeType.value__ == 0 or changeType.value__ == 1 then
    local nAfterType = GetUITypeByInputDevice()
    ChangeUIType(nAfterType)
  end
end

local function OnEvent_BlockGamepadUI(_, bBlock)
  bBlockUI = bBlock
  if not sCurUIName then
    return
  end
  local tbNode = mapGamepadUI[sCurUIName]
  if tbNode == nil or next(tbNode) == nil then
    return
  end
  for _, v in pairs(tbNode) do
    if v.mapNode:IsNull() == false then
      if bFirstInputEnable then
        NovaAPI.SetComponentEnable(v.mapNode, not bBlock)
      else
        NovaAPI.SetComponentEnable(v.mapNode, false)
      end
    else
      printWarn("GamepadUIManager：当前UI实例已销毁，无需屏蔽：" .. sCurUIName)
      return
    end
  end
end

local function EnableNode(sCtrlName)
  if not sCtrlName then
    printWarn("GamepadUIManager：当前UI内节点打开失败，CtrlName为空")
    return
  end
  if NovaAPI.IsEditorPlatform() then
    printLog("GamepadUIManager：Enable UI " .. sCtrlName)
  end
  local tbNode = mapGamepadUI[sCtrlName]
  if (tbNode == nil or next(tbNode) == nil) and mapMouseConfig[sCtrlName] == nil then
    printWarn("GamepadUIManager：当前UI内节点打开失败，可能该UI从来没有打开过：" .. sCtrlName)
    return
  end
  for _, v in pairs(tbNode) do
    if v.mapNode:IsNull() then
      printError("GamepadUIManager：当前UI内节点打开失败，UI实例已销毁：" .. sCtrlName)
      return
    end
    if not bBlockUI and bFirstInputEnable then
      if v.mapNode.enabled == true then
        NovaAPI.SetComponentEnable(v.mapNode, false)
      end
      NovaAPI.SetComponentEnable(v.mapNode, true)
    else
      NovaAPI.SetComponentEnable(v.mapNode, false)
    end
  end
end

local function DisableNode(sCtrlName)
  if not sCtrlName then
    printWarn("GamepadUIManager：当前UI内节点关闭失败，CtrlName为空")
    return
  end
  if NovaAPI.IsEditorPlatform() then
    printLog("GamepadUIManager：Disable UI " .. sCtrlName)
  end
  local tbNode = mapGamepadUI[sCtrlName]
  if (tbNode == nil or next(tbNode) == nil) and mapMouseConfig[sCtrlName] == nil then
    printWarn("GamepadUIManager：当前UI内节点关闭失败，可能该UI从来没有打开过：" .. sCtrlName)
    return
  end
  for _, v in pairs(tbNode) do
    if v.mapNode:IsNull() then
      printError("GamepadUIManager：当前UI内节点关闭失败，UI实例已销毁：" .. sCtrlName)
      return
    end
    NovaAPI.SetComponentEnable(v.mapNode, false)
  end
end

local function OnEvent_FirstInputEnable()
  bFirstInputEnable = true
  if sCurUIName then
    EnableNode(sCurUIName)
  end
end

local function OnEvent_OpenBuiltinAlert(_, bOpen, _okBtn, _confirmBtn, _cancelBtn)
  if not bEnableInput then
    NovaAPI.SetNaviButtonAction(_okBtn, false)
    NovaAPI.SetNaviButtonAction(_confirmBtn, false)
    NovaAPI.SetNaviButtonAction(_cancelBtn, false)
    return
  end
  if bOpen then
    local tbGamepadUINode = {
      [1] = {
        mapNode = _okBtn,
        sComponentName = "NaviButton",
        sAction = "buttonSouth"
      },
      [2] = {
        mapNode = _confirmBtn,
        sComponentName = "NaviButton",
        sAction = "buttonSouth"
      },
      [3] = {
        mapNode = _cancelBtn,
        sComponentName = "NaviButton",
        sAction = "buttonEast"
      }
    }
    GamepadUIManager.EnableGamepadUI("BuiltinUI", tbGamepadUINode, nil, nil, nil, AllEnum.UI_SORTING_ORDER.BuiltIn_Alert)
    NovaAPI.SetNaviButtonAction(_okBtn, true)
    NovaAPI.SetNaviButtonAction(_confirmBtn, true)
    NovaAPI.SetNaviButtonAction(_cancelBtn, true)
  else
    GamepadUIManager.DisableGamepadUI("BuiltinUI")
  end
end

local function Uninit(_)
  EventManager.Remove("LuaEventName_OnDeviceChange", GamepadUIManager, OnEvent_OnDeviceChange)
  EventManager.Remove("LuaEventName_LastInputDeviceChange", GamepadUIManager, OnEvent_LastInputDeviceChange)
  EventManager.Remove("__BlockGamepadUI", GamepadUIManager, OnEvent_BlockGamepadUI)
  EventManager.Remove("FirstInputEnable", GamepadUIManager, OnEvent_FirstInputEnable)
  EventManager.Remove("__OpenBuiltinAlert", GamepadUIManager, OnEvent_OpenBuiltinAlert)
  EventManager.Remove(EventId.CSLuaManagerShutdown, GamepadUIManager, Uninit)
end

function GamepadUIManager.Init()
  nCurUIType = GetUITypeByInputDevice()
  EventManager.Add("LuaEventName_OnDeviceChange", GamepadUIManager, OnEvent_OnDeviceChange)
  EventManager.Add("LuaEventName_LastInputDeviceChange", GamepadUIManager, OnEvent_LastInputDeviceChange)
  EventManager.Add("__BlockGamepadUI", GamepadUIManager, OnEvent_BlockGamepadUI)
  EventManager.Add("FirstInputEnable", GamepadUIManager, OnEvent_FirstInputEnable)
  EventManager.Add("__OpenBuiltinAlert", GamepadUIManager, OnEvent_OpenBuiltinAlert)
  EventManager.Add(EventId.CSLuaManagerShutdown, GamepadUIManager, Uninit)
end

function GamepadUIManager.EnableGamepadUI(sCtrlName, tbNode, goDefaultSelected, bEnableVirtualMouse, bBlockCursor, nPanelIndex)
  if sCurUIName == sCtrlName then
    printWarn("GamepadUIManager：重复打开Gamepad UI：" .. sCtrlName)
    return
  end
  mapGamepadUI[sCtrlName] = clone(tbNode)
  if not mapMouseConfig[sCtrlName] then
    mapMouseConfig[sCtrlName] = {}
  end
  mapMouseConfig[sCtrlName].VirtualMouse = bEnableVirtualMouse == true
  mapMouseConfig[sCtrlName].BlockCursor = bBlockCursor == true
  nPanelIndex = nPanelIndex or 0
  mapUIOrder[sCtrlName] = nPanelIndex
  local nOldIndex = table.indexof(tbHistory, sCtrlName)
  if nOldIndex ~= 0 then
    table.remove(tbHistory, nOldIndex)
  end
  local nIndex = FindHistoryInsertIndex(nPanelIndex)
  table.insert(tbHistory, nIndex, sCtrlName)
  if nIndex ~= #tbHistory then
    if NovaAPI.IsEditorPlatform() then
      printLog(string.format("GamepadUIManager：%s 层级(%s)低于当前 %s(%s)，不抢焦点，等上层关闭后唤醒", sCtrlName, tostring(nPanelIndex), tostring(sCurUIName), tostring(mapUIOrder[sCurUIName])))
    end
    DisableNode(sCtrlName)
    return
  end
  NovaAPI.ClearSelectedUI()
  if goDefaultSelected then
    NovaAPI.SetSelectedUI(goDefaultSelected)
  end
  InputManager.Instance.IsVirtualMouseEnabled = bEnableVirtualMouse == true
  InputManager.Instance.IsBlockCursor = bBlockCursor == true
  local bSwitch = false
  if sCurUIName then
    DisableNode(sCurUIName)
    bSwitch = true
  end
  sCurUIName = sCtrlName
  RefreshCurTypeUI()
  if bSwitch then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      
      EnableNode(sCurUIName)
    end
    
    cs_coroutine.start(wait)
  else
    EnableNode(sCurUIName)
  end
end

function GamepadUIManager.DisableGamepadUI(sCtrlName)
  local nIndex = table.indexof(tbHistory, sCtrlName)
  if nIndex == 0 then
    return
  end
  if sCurUIName == sCtrlName then
    DisableNode(sCtrlName)
    mapGamepadUI[sCtrlName] = nil
    mapMouseConfig[sCtrlName] = nil
    mapUIOrder[sCtrlName] = nil
    table.remove(tbHistory, nIndex)
    sCurUIName = nil
    if next(tbHistory) ~= nil then
      sCurUIName = tbHistory[#tbHistory]
      if mapMouseConfig[sCurUIName] then
        InputManager.Instance.IsVirtualMouseEnabled = mapMouseConfig[sCurUIName].VirtualMouse
        InputManager.Instance.IsBlockCursor = mapMouseConfig[sCurUIName].BlockCursor
      elseif sCurUIName then
        printWarn("GamepadUIManager：关闭历史未找到对应鼠标配置" .. sCurUIName)
      else
        printWarn("GamepadUIManager：关闭历史未找到对应鼠标配置")
      end
      RefreshCurTypeUI()
      
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        if sCurUIName then
          EnableNode(sCurUIName)
          EventManager.Hit("GamepadUIReopen", sCurUIName)
        else
          printWarn("GamepadUIManager：关闭历史未找到对应ctrl")
        end
      end
      
      cs_coroutine.start(wait)
    end
  else
    mapGamepadUI[sCtrlName] = nil
    mapMouseConfig[sCtrlName] = nil
    mapUIOrder[sCtrlName] = nil
    table.remove(tbHistory, nIndex)
  end
end

function GamepadUIManager.AddGamepadUINode(sCtrlName, tbNode)
  if not mapGamepadUI or not mapGamepadUI[sCtrlName] then
    printWarn("GamepadUIManager：当前ui不存在，添加节点失败Gamepad UI：" .. sCtrlName)
    return
  end
  for _, v in pairs(tbNode) do
    table.insert(mapGamepadUI[sCtrlName], v)
  end
  if sCurUIName == sCtrlName then
    EnableNode(sCtrlName)
    for _, v in pairs(tbNode) do
      RefreshCurTypeUINode(v)
    end
  else
    DisableNode(sCtrlName)
  end
end

function GamepadUIManager.SetSelectedUI(goSelected)
  NovaAPI.SetSelectedUI(goSelected)
end

function GamepadUIManager.ClearSelectedUI()
  NovaAPI.ClearSelectedUI()
end

function GamepadUIManager.SetNavigation(tbUIObj, bHorizontal, bLoop)
  if bHorizontal == nil then
    bHorizontal = true
  end
  if bLoop == nil then
    bLoop = true
  end
  NovaAPI.SetGamepadUINavigation(tbUIObj, bHorizontal, bLoop)
end

function GamepadUIManager.GetCurUIType()
  return nCurUIType
end

function GamepadUIManager.GetCurUIName()
  return sCurUIName
end

function GamepadUIManager.GetInputState()
  return bEnableInput
end

function GamepadUIManager.GetPrveUIName()
  if next(tbHistory) == nil then
    return
  end
  local nCount = #tbHistory
  if 1 < nCount then
    return tbHistory[nCount - 1]
  end
end

function GamepadUIManager.EnterAdventure(bSkipFirstInputEnable)
  InputManager.Instance.IsVirtualMouseEnabled = false
  InputManager.Instance.IsBlockCursor = false
  InputManager.Instance.IsBattleSubmit = true
  sCurUIName = nil
  tbHistory = {}
  mapGamepadUI = {}
  mapMouseConfig = {}
  mapUIOrder = {}
  bEnableInput = true
  bFirstInputEnable = bSkipFirstInputEnable
end

function GamepadUIManager.QuitAdventure()
  InputManager.Instance.IsVirtualMouseEnabled = true
  InputManager.Instance.IsBlockCursor = false
  InputManager.Instance.IsBattleSubmit = false
  sCurUIName = nil
  tbHistory = {}
  mapGamepadUI = {}
  mapMouseConfig = {}
  mapUIOrder = {}
  bEnableInput = false
  bFirstInputEnable = false
end

function GamepadUIManager.SetVirtualMouseStickEnable(bEnable)
  bVirtualMouseStickEnable = bEnable ~= false
  InputManager.Instance:SetVirtualMouseStickEnable(bVirtualMouseStickEnable)
end

function GamepadUIManager.GetInputName(mapInput)
  if not mapInput.name or not mapInput.displayName then
    return
  end
  local sName = mapInput.displayName
  if string.find(mapInput.name, "left") then
    sName = string.gsub(mapInput.name, "left", "L-")
  elseif string.find(mapInput.name, "right") then
    sName = string.gsub(mapInput.name, "right", "R-")
  elseif sName == "Num Del" then
    sName = "Num."
  elseif string.find(mapInput.name, "numpad") then
    local position = string.find(sName, " ")
    if position then
      sName = "Num" .. string.sub(sName, position + 1)
    else
      sName = "Num" .. sName
    end
  end
  return sName
end

return GamepadUIManager
