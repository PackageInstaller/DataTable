local debugActions = {}
local tag = "debugActions"
debugActions.isLightOpen = true
debugActions.isModelOpen = true
debugActions.isEffectOpen = true
debugActions.isOpenUwaLauncher = false
debugActions.isShowLogConsole = true
debugActions.refreshPet = true
debugActions.isUIOpen = true
debugActions.isDamageText = true
debugActions.isUpdateAutoOpenPageActivitySevenDaySign = false
if IS_DEV_BUILD then
  debugActions.enableMapPointTeleport = true
else
  debugActions.enableMapPointTeleport = false
end

function debugActions.SendGMCommand(command)
  local commands = string.split(command, " ")
  local commandType = commands[1]
  if type(commandType) ~= "string" or not (0 < #commandType) then
    printf(tag, "[SendGMCommand] invalid command")
    return
  end
  local msg = {
    command = commandType,
    args = {}
  }
  for i = 2, #commands do
    table.insert(msg.args, commands[i])
  end
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end

function debugActions.changeLightObjShow(type, isShow)
  local parentObj = Unity.GameObject.Find(type)
  if parentObj == nil then
    printf("changeTypeObjShow", "未找到" .. type .. "类型")
    return
  end
  local objs = parentObj:GetComponentsInChildren(typeof(CS.UnityEngine.Light), true)
  for i = 0, objs.Length - 1 do
    objs[i].gameObject:SetActive(isShow)
  end
end

function debugActions.changeModelObjShow(type, isShow)
  local parentObj = Unity.GameObject.Find(type)
  if parentObj == nil then
    printf("changeTypeObjShow", "未找到" .. type .. "类型")
    return
  end
  local objs = parentObj:GetComponentsInChildren(typeof(CS.UnityEngine.Renderer), true)
  for i = 0, objs.Length - 1 do
    objs[i].gameObject:SetActive(isShow)
  end
end

function debugActions.changeEffectObjShow(type, isShow)
  local parentObj = Unity.GameObject.Find(type)
  if parentObj == nil then
    printf("changeTypeObjShow", "未找到" .. type .. "类型")
    return
  end
  local objs = parentObj:GetComponentsInChildren(typeof(CS.UnityEngine.ParticleSystem), true)
  for i = 0, objs.Length - 1 do
    objs[i].gameObject:SetActive(isShow)
  end
end

function debugActions.changeGuideActive(isActive)
  G_GuideManager.isActivateGuide = isActive
end

function debugActions.setLanguage_debug(lang)
  lang = lang and string.trim(lang)
  local isHas, langEnum = C_I18NConst.LanguageTag2Enum:TryGetValue(lang)
  if not isHas then
    errorf("非法的语言代码")
    errorf(lang)
    return
  end
  L_Lang:clear()
  C_I18NManager.SetLanguage(langEnum)
end

function debugActions.startWebRuntimeInspector(port)
  local inspector = debugActions._proximaInspector
  if inspector == nil then
    local go = C_GameObject("[Proxima Inspector]")
    go:SetActive(false)
    inspector = go:AddComponent(typeof(CS.Proxima.ProximaInspector))
    inspector.DisplayName = "(*^—°)b"
    inspector.UseHttps = true
    inspector.Certificate = nil
    inspector.StartOnEnable = false
    inspector.InstantiateStatusUI = false
    inspector.InstantiateConnectUI = false
    debugActions._proximaInspector = inspector
    go:SetActive(true)
  end
  local status = inspector.Status
  if status.IsRunning then
    L_GameUtil.showCommonTip({
      txtContent = L_WordsTpl:getValue("notice_ProximaInspector_01", {
        [0] = tostring(status.ConnectInfo),
        [1] = inspector.Password
      })
    })
  else
    local randomPW = string.format("%04d", math.random(0, 9999))
    inspector.Port = port or 7759
    inspector.Password = randomPW
    inspector:Run()
    local timer = Timer.once(1, function()
      if inspector.Status.IsRunning then
        L_GameUtil.showCommonTip({
          txtContent = L_WordsTpl:getValue("notice_ProximaInspector_02", {
            [0] = tostring(status.ConnectInfo),
            [1] = inspector.Password
          })
        })
      else
        L_GameUtil.showCommonTip({
          txtContent = L_WordsTpl:getValue("notice_ProximaInspector_03", {
            [0] = tostring(status.Error)
          })
        })
      end
    end)
    timer:start()
  end
end

function debugActions.stopWebRuntimeInspector()
  local inspector = debugActions._proximaInspector
  if inspector then
    inspector:Stop()
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_ProximaInspector_04"))
  end
end

local m_logConsoleHandle

function debugActions.showLogConsole(isShow)
  if not Unity.Debug.isDebugBuild then
    isShow = false
  end
  return isShow
end

function debugActions.exeLuaScriptString(luaScriptStr)
  if luaScriptStr then
    load(luaScriptStr)()
  end
end

debugActions._UICamCullingMaskBackup = nil
debugActions._UICamNearClipPlane = nil
debugActions._UICamFarClipPlane = nil

function debugActions.getUIVisible()
  return debugActions._UICamCullingMaskBackup == nil
end

function debugActions.setUIVisible(visible)
  local uiCamera = C_CameraManager.uiCamera
  if visible then
    if not debugActions.getUIVisible() then
      debugActions._UICamCullingMaskBackup = nil
      uiCamera.nearClipPlane = debugActions._UICamNearClipPlane
      uiCamera.farClipPlane = debugActions._UICamFarClipPlane
    end
  else
    debugActions._UICamNearClipPlane = uiCamera.nearClipPlane
    debugActions._UICamFarClipPlane = uiCamera.farClipPlane
    uiCamera.nearClipPlane = 1
    uiCamera.farClipPlane = 1.01
    debugActions._UICamCullingMaskBackup = true
  end
end

return debugActions
