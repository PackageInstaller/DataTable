local Binder = binder
local typeof = _ENV.typeof
local T_UITableview = typeof(CS.UITableview)
local TYPEOF_UIExport = typeof(CS.FrameWork.UIExport)
local TYPEOF_Text = typeof(CS.UnityEngine.UI.Text)
local TYPEOF_Button = typeof(CS.UnityEngine.UI.Button)
local TYPEOF_Image = typeof(CS.UnityEngine.UI.Image)
local TYPEOF_TMP_Text = typeof(CS.TMPro.TMP_Text)
local TYPEOF_TMP_InputField = typeof(CS.TMPro.TMP_InputField)
local TYPEOF_Z1Toggle = typeof(CS.Z1Client.Z1Toggle)
local TYPEOF_Z1Button = typeof(CS.Z1Client.Z1Button)
local Z1ButtonState = CS.Z1Client.Z1ButtonState
local Z1ButtonType = CS.Z1Client.Z1ButtonType
local TYPEOF_AudioEffect = typeof(CS.FrameWork.AudioEffect)
local TYPEOF_TextMeshProUGUI = typeof(CS.TMPro.TextMeshProUGUI)
local TYPEOF_CanvasGroup = typeof(CS.UnityEngine.CanvasGroup)
local TypeHyperLinkText = typeof(CS.Z1Client.HyperLinkText)
local TYPEOF_RepeatButton = typeof(CS.RepeatButton)
local TYPEOF_Slider = typeof(CS.UnityEngine.UI.Slider)
local TYPEOF_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local TYPEOF_InputField = typeof(CS.UnityEngine.UI.InputField)
local TYPEOF_Dropdown = typeof(CS.UnityEngine.UI.Dropdown)
local TYPEOF_NormalListView = typeof(CS.Z1ScrollView.NormalListView)
local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local TYPEOF_CircularScrollView = typeof(CS.UICircularScrollView.CircularScrollView)
local FadeInAnimType = CS.UICircularScrollView.FadeInAnimType
local TYPEOF_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local GameObject = CS.UnityEngine.GameObject
local DOTween = CS.DG.Tweening.DOTween
local UICustomInput = CS.UICustomInput
local Vector3_Zero = CS.UnityEngine.Vector3(0, 0)
local Vector2_One = CS.UnityEngine.Vector2(1, 1)
local Vector2_Zero = CS.UnityEngine.Vector2(0, 0)
local ColorZero = CS.UnityEngine.Color(0, 0, 0, 0)
local sformat = string.format
local UIInitPos = CS.Framework.GameObjectUtil.UIInitPos
local ClearAllTextInPrefab = CS.Framework.UIUtilTool.ClearAllTextInPrefab
local IsResourceLoading = CS.Z1Client.LuaCSharpUtil.IsResourceLoading

local function replacePluralTags(str)
  if not string.find(string.lower(str), "<plural", 1, true) then
    return str
  end
  local result = {}
  local lastEnd = 1
  local searchFrom = 1
  while true do
    local tagStart, tagEnd, attrs = string.find(str, "<[Pp]lural([^>]*)>", searchFrom)
    if not tagStart then
      break
    end
    local singular = string.match(attrs, "singular%s*=%s*\"([^\"]*)\"") or ""
    local plural = string.match(attrs, "plural%s*=%s*\"([^\"]*)\"") or ""
    singular = singular:match("^%s*(.-)%s*$")
    plural = plural:match("^%s*(.-)%s*$")
    local valueStr = string.match(attrs, "value%s*=%s*\"([^\"]*)\"")
    local value = valueStr and tonumber(valueStr:match("^%s*(.-)%s*$"))
    if not value then
      local preceding = string.sub(str, 1, tagStart - 1)
      value = tonumber(string.match(preceding, "(%d+)%s*$"))
    end
    local word = (not value or value <= 1) and singular or plural
    table.insert(result, string.sub(str, lastEnd, tagStart - 1))
    table.insert(result, word)
    lastEnd = tagEnd + 1
    searchFrom = tagEnd + 1
  end
  table.insert(result, string.sub(str, lastEnd))
  do return table.concat end
  return table.concat, result, string.sub(str, lastEnd)
end

local old_constructor = Binder.constructor

function Binder:constructor(source, parent)
  old_constructor(self, source, parent)
  self.imagesLoader = UIImagesLoader(self)
  self.iconMgr = UIBinderMaterialIconMgr(self)
  self.effectMgr = UIBinderEffectMgr(self)
end

function Binder:OnDispose()
  local assetTarget = self.__assetTarget or self
  if assetTarget == self then
    ResLoadMgr.UnloadAssetByTarget(assetTarget)
  end
end

function Binder:BindNewComponent(parent, componentClass, uiResourceClass, ...)
  local ui = PoolManager.Instance:GetItemUIResouce(uiResourceClass)
  local uiNode = ui.uiNode
  local parentRoot = parent or UIRootMgr.GetUIRoot()
  UIManager.InitUIPos(parentRoot, uiNode)
  ClearAllTextInPrefab(uiNode)
  local component = componentClass(uiNode, ...)
  if not component.ui then
    component.ui = ui
  end
  local binder = self:createChild(component)
  binder:UpdateLocalizedTextAndResouce(uiNode)
  component:Setup(binder)
  binder:onDestroy(function()
    if component.ui then
      component.ui = nil
    end
    if not IsNil(uiNode) then
      local uiExport = uiNode:GetComponent(typeof(CS.FrameWork.UIExport))
      if not Main.isAppDestroyed then
        pcall(uiExport.ResetObjActive, uiExport)
        PoolManager.Instance:FreeItemUI(ui)
      end
    end
    if binder.OnDispose then
      binder:OnDispose()
    end
  end)
  return component, binder
end

function Binder:BindNewComponentWithCanvas(parent, componentClass, uiResourceClass, ...)
  local ui = PoolManager.Instance:GetItemUIResouce(uiResourceClass)
  local uiNode = ui.uiNode
  local parentRoot = parent or UIRootMgr.GetUIRoot()
  UIInitPos(parentRoot, uiNode)
  ClearAllTextInPrefab(uiNode)
  local component = componentClass(uiNode, ...)
  if not component.ui then
    component.ui = ui
  end
  local binder = self:createChild(component)
  binder:UpdateLocalizedTextAndResouce(uiNode)
  component:Setup(binder)
  binder:onDestroy(function()
    if component.ui then
      component.ui = nil
    end
    if not IsNil(uiNode) then
      local uiExport = uiNode:GetComponent(typeof(CS.FrameWork.UIExport))
      if not Main.isAppDestroyed then
        pcall(uiExport.ResetObjActive, uiExport)
        PoolManager.Instance:FreeItemUI(ui)
      end
    end
    if binder.OnDispose then
      binder:OnDispose()
    end
  end)
  return component, binder
end

function Binder:BindUIBehavior(uiNode, ...)
  local uiLuaBehavior = uiNode:GetComponent(typeof(CS.FrameWork.UILuaBehavior))
  if uiLuaBehavior then
    local luaScript = uiLuaBehavior.luaScript
    local luaCls = require("GameScript." .. luaScript)
    local instance = luaCls(uiNode, ...)
    instance:OnBind(self)
    return instance
  end
end

function Binder:BindComponent(component)
  local binder = self:createChild(component)
  component:Setup(binder)
  binder:onDestroy(function()
    if component.ui then
      component.ui = nil
    end
    if binder.OnDispose then
      binder:OnDispose()
    end
  end)
  return component
end

function Binder:BindChildPanel(panelUrl, childGameObj, ...)
  local childPanelCls = require(panelUrl)
  local childPanel = childPanelCls(...)
  local binder = self:CreateChild(childPanel)
  childPanel.ui = childPanel.uiResCls(childGameObj)
  childPanel:OnBind(binder)
  self:UpdateLocalizedTextAndResouce(childGameObj)
  
  function childPanel.Close(childPanel)
    UIManager.Instance:CloseByUrl(panelUrl)
  end
  
  return childPanel
end

function Binder:RegisterChildPanel(panelUrl, childGameObj, openFunc, closeFunc)
  if not self.childPanels then
    self.childPanels = {}
    self:BindEvent(EventMgr.Instance.OpenChildPanel, System.fn(self, self._OpenChildFunc))
    self:BindEvent(EventMgr.Instance.CloseChildPanel, System.fn(self, self._CloseChildFunc))
    self:onDestroy(function()
      self.childPanels = nil
    end)
  end
  childGameObj:SetActive(false)
  self.childPanels[panelUrl] = {
    childPanel = nil,
    childGameObj = childGameObj,
    openFunc = openFunc,
    closeFunc = closeFunc
  }
end

function Binder:_OpenChildFunc(panelUrl, ...)
  if not self.childPanels or not self.childPanels[panelUrl] then
    return
  end
  local childInfo = self.childPanels[panelUrl]
  if childInfo.childPanel then
  else
    childInfo.childPanel = self:BindChildPanel(panelUrl, childInfo.childGameObj, ...)
  end
  if childInfo.childPanel.OnOpen then
    childInfo.childPanel:OnOpen()
  end
end

function Binder:_CloseChildFunc(panelUrl, ...)
  if not self.childPanels or not self.childPanels[panelUrl] then
    return
  end
  local childInfo = self.childPanels[panelUrl]
  if not childInfo.closeFunc then
  else
    childInfo.closeFunc()
  end
  if childInfo.childPanel and childInfo.childPanel.OnClose then
    childInfo.childPanel:OnClose()
  end
end

function Binder:BindResponse(class, protoClassName, name, func)
  self:BindAction(function(action)
    if action then
      ProtoBase.RegisterDispatcher(class, protoClassName, name, func)
    else
      ProtoBase.UnRegisterDispatcher(class, protoClassName, name, func)
    end
  end, func)
end

function Binder:BindNewComponentWithMask(parent, componentClass, uiResourceClass, ...)
  local path = "UI/UI_Common/UI_Common_Prefab/UI_Old_Public/UI_Common_Mask.prefab"
  local obj = self:LoadAsset(path)
  local maskNode = CS.UnityEngine.Object.Instantiate(obj)
  UIManager.InitUIPos(parent, maskNode)
  local obj = self:LoadAsset(uiResourceClass.assetPath)
  local uiNode = CS.UnityEngine.Object.Instantiate(obj)
  UIManager.InitUIPos(maskNode, uiNode)
  ClearAllTextInPrefab(uiNode)
  local component = componentClass(uiNode, maskNode, ...)
  local binder = self:createChild(component)
  component:Setup(binder)
  binder:UpdateLocalizedTextAndResouce(uiNode)
  binder:BindButtonClick(maskNode, function()
    if component.OnMaskClicked ~= nil then
      component.OnMaskClicked(component)
    end
  end)
  binder:onDestroy(function()
    if component.ui then
      component.ui = nil
    end
    UIRootMgr.DestroyGameObject(uiNode)
    UIRootMgr.DestroyGameObject(maskNode)
  end)
  return component, binder
end

function Binder:AddClickMask(binder, parent, callback)
  local mask = self:LoadAsset("UI/UI_Common/UI_Common_Prefab/UI_Old_Public/UI_Common_Mask.prefab")
  local maskNode = CS.UnityEngine.GameObject.Instantiate(mask, parent.transform)
  maskNode.transform:SetAsFirstSibling()
  binder:BindButtonClick(maskNode, function()
    if callback then
      callback()
    end
  end)
  binder:onDestroy(function()
    UIRootMgr.DestroyGameObject(maskNode)
  end)
end

function Binder:GetTextComp(owner)
  local isTmp = false
  local textComp = owner:GetComponent(TYPEOF_Text)
  if nil == textComp then
    textComp = owner:GetComponent(TYPEOF_TMP_Text)
    isTmp = true
  end
  return textComp, isTmp
end

function Binder:GetTextPreferredWH(owner)
  local tmpComp = owner:GetComponent(TYPEOF_TMP_Text)
  if tmpComp then
    return tmpComp.preferredWidth, tmpComp.preferredHeight
  end
  return 0, 0
end

function Binder:RemoveUnderline(owner)
  local textComp = self:GetTextComp(owner)
  local text = textComp.text
  if string.contains(text, "<u>") then
    text = string.gsub(text, "<u>", "")
    text = string.gsub(text, "</u>", "")
    textComp.text = text
  end
end

function Binder:SetText(owner, value, isUseBigFont, linkCallBack, extraParam)
  if not extraParam or type(extraParam) ~= "table" then
    extraParam = {}
  end
  if ApplicationUtils.is_editor_mode() or ApplicationUtils.IsWindows() then
    LT.RecordTextGo(owner, LT.Text(value), isUseBigFont, linkCallBack, extraParam)
  end
  local textComp, isTmp = self:GetTextComp(owner)
  if not textComp then
    return
  end
  if textComp.supportRichText ~= nil then
    textComp.supportRichText = true
  end
  local str = tostring(LT.Text(value)) or ""
  str = string.gsub(str, "\\n", "\n")
  str = replacePluralTags(str)
  if Binder.OpenConfuseText or extraParam.OpenConfuseText then
    local color = textComp.color
    local tmpCom = owner:GetComponent(TYPEOF_TMP_Text)
    if not tmpCom then
      local oriRectTrans = textComp:GetComponent(TYPEOF_RectTransform)
      local empty = GameObject()
      tmpCom = empty:AddComponent(TYPEOF_TextMeshProUGUI)
      local fitMode = CS.UnityEngine.UI.ContentSizeFitter.FitMode.PreferredSize
      local sizeFitter = empty:AddComponent(typeof(CS.UnityEngine.UI.ContentSizeFitter))
      sizeFitter.horizontalFit = fitMode
      sizeFitter.verticalFit = fitMode
      local rectTrans = empty:GetComponent(TYPEOF_RectTransform)
      empty.transform:SetParent(owner.transform, false)
      rectTrans.anchorMax = Vector2_One
      rectTrans.anchorMin = Vector2_Zero
      rectTrans.offsetMin = Vector2_Zero
      rectTrans.offsetMax = Vector2_Zero
      rectTrans.localPosition = Vector3_Zero
      textComp.color = ColorZero
    end
    local colorHex = string.format("color=#%s", StrUtils.ToHtmlStringRGB(color))
    local result = StrUtils.Fix2ConfuseText(str, colorHex)
    tmpCom.text = result
    if textComp.gameObject.name == "Text_C_New" then
      local parent = textComp.transform.parent
      local imgTrans = parent and parent:Find("Image_New") or nil
      if imgTrans then
        imgTrans.gameObject:SetActive(false)
      end
    end
  else
    str = StrUtils.SafeSetWordEffectStr(str)
    str = LT.ReplaceUnicodeSpace(str)
    str = StrUtils.ReplaceAvgContent(str)
    if DataCenter.gameData.CurrTextLanguage == cd.Lang.EN and isTmp and #str > 0 and textComp.richText then
      str = sformat("<nobr>%s</nobr>", str)
    end
    if linkCallBack then
      self:AddTextHyperLinkCom(textComp, owner, str, linkCallBack)
    elseif not extraParam.banKeywordBtn then
      if StrUtils.CheckContainsEffectLink(str) then
        local function showKeyWordTipsCb()
          UIManager.Instance:Reopen(Urls.CommonCardKeyWorldDescPanel, {str}, owner, extraParam)
        end
        
        local buttonComp = owner:GetComponent(TYPEOF_Button)
        if not buttonComp then
          buttonComp = owner:AddComponent(TYPEOF_Button)
          buttonComp.transition = CS.UnityEngine.UI.Selectable.Transition.None
        end
        buttonComp.enabled = true
        self:BindButtonClick(owner, showKeyWordTipsCb)
        textComp.raycastTarget = true
      else
        local buttonComp = owner:GetComponent(TYPEOF_Button)
        if buttonComp then
          buttonComp.onClick:RemoveAllListeners()
          buttonComp.enabled = false
        end
      end
      textComp.text = str
    else
      textComp.text = str
    end
  end
end

function Binder:AddTextHyperLinkCom(textComp, owner, str, linkCallBack)
  local hyperLinkCom = owner:GetComponent(TypeHyperLinkText)
  if not hyperLinkCom and owner:GetComponent(TYPEOF_TMP_Text) then
    hyperLinkCom = owner:AddComponent(TypeHyperLinkText)
  end
  if hyperLinkCom then
    hyperLinkCom:SetHtmlText(str, linkCallBack)
  else
    textComp.text = str
  end
end

function Binder:BindToText(owner, expOrFn, isUseBigFont, linkCallBack, extraParam)
  self:BindToRaw(function(data, v, o)
    local text = v and v[1]
    local lang = v and v[2]
    if not lang then
      return
    end
    self:SetText(owner, text, isUseBigFont, linkCallBack, extraParam)
  end, function()
    local text = expOrFn()
    local lang = DataCenter.gameData.CurrTextLanguage
    return {text, lang}
  end)
end

function Binder:SetRawText(owner, text)
  local textComp = self:GetTextComp(owner)
  if not textComp then
    return
  end
  if ApplicationUtils.is_editor_mode() or ApplicationUtils.IsWindows() then
    LT.RecordTextGo(owner, LT.Text(text))
  end
  local str = tostring(text or "")
  str = StrUtils.SafeSetWordEffectStr(str)
  str = LT.ReplaceUnicodeSpace(str)
  textComp.text = str
end

function Binder:BindToRawText(owner, expOrFn)
  self:BindToRaw(function(data, v, o)
    self:SetRawText(owner, v)
  end, expOrFn)
end

function Binder:BindToTextWithColor(owner, expOrFn, isUseBigFont, linkCallBack, extraParam)
  self:BindToRaw(function(data, v, o)
    self:SetText(owner, v, isUseBigFont, linkCallBack, extraParam)
  end, expOrFn)
end

function Binder:GetColorStr(wordEffectKey)
  local wordEffectCfg = DT.WordsEffectConfig[wordEffectKey]
  if not wordEffectCfg or not wordEffectCfg.Color then
    return text
  end
  local colorKey, darkOrLight = table.unpack(string.split(wordEffectCfg.Color, ","))
  if not colorKey then
    return text
  end
  local colorCfg = DT.ColorConfig[colorKey]
  local colorStr = colorCfg and colorCfg[darkOrLight or "Light"]
  return colorStr
end

function Binder:GetColorText(text, wordEffectKey)
  local colorStr = self:GetColorStr(wordEffectKey)
  if not colorStr then
    return text
  end
  do return string.color, text end
  return string.color, text, colorStr
end

function Binder:SetTextColor(owner, x, y, z, w)
  owner:GetComponent(TYPEOF_Text).color = CS.UnityEngine.Color(x, y, z, w)
end

function Binder:SetTextColorByHtml(owner, colorStr)
  local text = self:GetTextComp(owner)
  local color = ColorUtils.ParseHtmlStringToUnityColor(colorStr, text.color.a)
  text.color = color
end

function Binder:BindToTextColorOld(owner, expOrFn)
  self:BindToRaw(function(data, v, o)
    if not v then
      return
    end
    local text = self:GetTextComp(owner)
    if type(v) == "string" then
      local color = ColorUtils.ParseHtmlStringToUnityColor(v, text.color.a)
      text.color = color
    else
      text.color = v
    end
  end, expOrFn)
end

function Binder:ChangeNumInAnim(owner, oldNum, targetNum)
  if not (owner and oldNum) or not targetNum then
    Logger.Info("<Binder.ChangeNumInAnim> error params:", owner, oldNum, targetNum)
    return
  end
  local time = 0.5
  local interval = time / math.abs(targetNum - oldNum)
  local currNum = oldNum
  local isAdd = targetNum - currNum > 0
  local delta = isAdd and 1 or -1
  delta = math.floor(delta * (math.abs(targetNum - currNum) / 50))
  if 0 == delta % 10 then
    delta = isAdd and delta + 1 or delta - 1
  end
  local timer
  timer = self:BindTimer(interval, -1, function()
    if timer and currNum == targetNum then
      TimerManager.Instance:StopTimer(timer)
      timer = nil
      return
    end
    currNum = currNum + delta
    if delta > 0 and currNum > targetNum then
      currNum = targetNum
    elseif delta < 0 and currNum < targetNum then
      currNum = targetNum
    end
    self:SetText(owner, currNum)
  end)
end

function Binder:BindToTextSize(owner, expOrFn)
  local textComp = self:GetTextComp(owner)
  self:BindToRaw(function(_, n, _)
    if not textComp then
      Logger.Error("找不到文本组件, gameObject name:", owner.name, debug.traceback())
      return
    end
    textComp.fontSize = n
  end, expOrFn)
end

function Binder:SetTextSize(owner, size)
  local textComp = self:GetTextComp(owner)
  if not textComp then
    Logger.Error("找不到文本组件, gameObject name:", owner.name, debug.traceback())
    return
  end
  textComp.fontSize = size
end

function Binder:BindToTextColor(owner, bindValueFunc)
  if not owner or not bindValueFunc then
    return
  end
  local colorComp = owner:GetComponent(typeof(CS.FrameWork.TextColor))
  if nil == colorComp then
    return
  end
  local textComp = self:GetTextComp(owner)
  if not textComp then
    return
  end
  local colorKey = colorComp.colorKey
  local alpha = textComp.color and textComp.color.a
  self:BindToRaw(function(_, currColorType, _)
    if not currColorType then
      return
    end
    local colorHexCode = ColorUtils.GetColorHexCode(colorKey, currColorType)
    local color = ColorUtils.ParseHtmlStringToUnityColor(colorHexCode, alpha)
    if not color then
      return
    end
    textComp.color = color
  end, bindValueFunc)
end

function Binder:BindToTextColorCode(owner, colorCodeValueFunc)
  if not owner or not colorCodeValueFunc then
    return
  end
  local textComp = self:GetTextComp(owner)
  if not textComp then
    return
  end
  local alpha = textComp.color.a
  self:BindToRaw(function(_, colorHexCode)
    if not colorHexCode or "" == colorHexCode then
      return
    end
    local color = ColorUtils.ParseHtmlStringToUnityColor(colorHexCode, alpha)
    if not color then
      return
    end
    textComp.color = color
  end, colorCodeValueFunc)
end

function Binder:SetTextColorType(owner, colorType)
  if not owner or not colorType then
    return
  end
  local colorComp = owner:GetComponent(typeof(CS.FrameWork.TextColor))
  if nil == colorComp then
    return
  end
  local textComp = self:GetTextComp(owner)
  if not textComp then
    return
  end
  local colorKey = colorComp.colorKey
  local alpha = textComp.color and textComp.color.a
  local colorHexCode = ColorUtils.GetColorHexCode(colorKey, colorType)
  local color = ColorUtils.ParseHtmlStringToUnityColor(colorHexCode, alpha)
  if not color then
    return
  end
  textComp.color = color
end

function Binder:PlayAnimator(animator, name, argType, arg)
  AnimatorUtils.PlayBlendParams(animator, name, argType, arg)
end

function Binder:SetIcon(iconType, parent, itemData)
  if not self._setIconDestroyed then
    self:onDestroy(function()
      self.iconMgr:ClearAll()
    end)
    self._setIconDestroyed = true
  end
  do return self.iconMgr.SetIcon, self.iconMgr, iconType, self, parent end
  return self.iconMgr.SetIcon, self.iconMgr, iconType, self, parent, itemData
end

function Binder:ClearIcon(parent)
  if self.iconMgr then
    self.iconMgr:ClearIcon(parent)
  end
end

function Binder:PlayEffect(effPath, owner, offsetX, offsetY, loop)
  if not self._playEffectDestroyed then
    self:onDestroy(function()
      self.effectMgr:ClearAll()
    end)
    self._playEffectDestroyed = true
  end
  do return self.effectMgr.PlayEffect, self.effectMgr, effPath, owner, offsetX, offsetY end
  return self.effectMgr.PlayEffect, self.effectMgr, effPath, owner, offsetX, offsetY, loop
end

function Binder:StopEffect(eff)
  if self.effectMgr then
    self.effectMgr:StopEffect(eff)
  end
end

function Binder:BindToImage(owner, expOrFn, nativeSize)
  self:BindToRaw(function(childBinder, n, o)
    if not n then
      return
    end
    if "" == n then
      return
    end
    childBinder:SetImage(owner, n, nativeSize)
  end, expOrFn)
end

function Binder:BindToImageSync(owner, expOrFn, nativeSize)
  self:BindToRaw(function(childBinder, n, o)
    if not n then
      return
    end
    if "" == n then
      return
    end
    childBinder:SetImageSync(owner, n, nativeSize)
  end, expOrFn)
end

function Binder:BindToImageColor(owner, expOrFn)
  self:BindToRaw(function(_, n, _)
    if not n then
      return
    end
    if type(n) == "string" then
      local color = ColorUtils.ParseHtmlStringToUnityColor(n, owner:GetComponent(TYPEOF_Image).color.a)
      owner:GetComponent(TYPEOF_Image).color = color
    else
      owner:GetComponent(TYPEOF_Image).color = n
    end
  end, expOrFn)
end

function Binder:BindToImageFillAmount(owner, expOrFn)
  self:BindToRaw(function(_, n, _)
    owner:GetComponent(TYPEOF_Image).fillAmount = n
  end, expOrFn)
end

function Binder:SetImageFillAmount(owner, value)
  local img = owner:GetComponent(TYPEOF_Image)
  if img then
    img.fillAmount = value
  end
end

function Binder:SetImage(owner, path, nativeSize)
  if not self._SetImageDetroyed then
    self:onDestroy(function(...)
      self.imagesLoader:ClearAll()
    end)
    self._SetImageDetroyed = true
  end
  self.imagesLoader:SetImage(owner, path, nativeSize)
end

function Binder:SetImageSync(owner, path, nativeSize)
  if path then
    if IsResourceLoading then
      local ret, result = pcall(IsResourceLoading, path)
      if ret and result then
        self:SetImage(owner, path, nativeSize)
        return
      end
    end
    local imageComp = owner:GetComponent(TYPEOF_Image)
    if imageComp then
      imageComp.sprite = self:LoadAsset(path)
      imageComp.enabled = true
      if nativeSize then
        imageComp:SetNativeSize()
      end
    end
  end
end

function Binder:ClearImage(owner)
  owner:GetComponent(TYPEOF_Image).sprite = nil
end

function Binder:SetImageColor(owner, x, y, z, w)
  owner:GetComponent(TYPEOF_Image).color = CS.UnityEngine.Color(x, y, z, w)
end

function Binder:SetImageAlpha(owner, a)
  local image = owner:GetComponent(TYPEOF_Image)
  local color = CS.UnityEngine.Color(image.color.r, image.color.g, image.color.b, a)
  image.color = color
end

function Binder:SetImageColorByHtml(owner, colorStr)
  if not colorStr or not owner then
    return
  end
  local image = owner:GetComponent(TYPEOF_Image)
  local color = ColorUtils.ParseHtmlStringToUnityColor(colorStr, image.color.a)
  image.color = color
end

function Binder:BindToAnimator(owner, bindFunc, setAnimCb, bindTo)
  local animator = owner:GetComponent(typeof(CS.UnityEngine.Animator))
  assert(nil ~= animator, "找不到animator组件:" .. debug.traceback())
  if setAnimCb then
    setAnimCb(animator)
  end
  self:BindToRaw(function(childBinder, newVal, oldVal)
    if bindFunc then
      bindFunc(childBinder, animator, newVal, oldVal)
    end
  end, bindTo)
end

function Binder:BindToCanvasGroup(owner, expOrFn)
  self:BindToRaw(function(data, v, o)
    owner:GetComponent(TYPEOF_CanvasGroup).alpha = v
  end, expOrFn)
end

function Binder:GetCanvasGroupValue(owner)
  local canvasGroup = owner:GetComponent(TYPEOF_CanvasGroup)
  if canvasGroup then
    return canvasGroup.alpha
  end
  return 1
end

function Binder:SetCanvasGroup(owner, alpha)
  if not owner:GetComponent(TYPEOF_CanvasGroup) then
    owner:AddComponent(TYPEOF_CanvasGroup)
  end
  owner:GetComponent(TYPEOF_CanvasGroup).alpha = alpha
end

function Binder:GetOrAddCanvasGroup(owner)
  if not owner:GetComponent(TYPEOF_CanvasGroup) then
    local com = owner:AddComponent(TYPEOF_CanvasGroup)
    return com
  end
  do return owner.GetComponent, owner end
  return owner.GetComponent, owner, TYPEOF_CanvasGroup
end

function Binder:DotweenProcessAlpha(owner, alpha, time)
  local canvasGroup = self:GetOrAddCanvasGroup(owner)
  local tween = DOTween.To(function()
    return canvasGroup.alpha
  end, function(v)
    canvasGroup.alpha = v
  end, alpha, time, self)
  return tween
end

function Binder:SetCanvasGroupBlocksRaycasts(owner, blocksRaycasts)
  if not owner:GetComponent(TYPEOF_CanvasGroup) then
    owner:AddComponent(TYPEOF_CanvasGroup)
  end
  owner:GetComponent(TYPEOF_CanvasGroup).blocksRaycasts = blocksRaycasts
end

function Binder:BindToVisibleByCanvasGroup(owner, expOrFn)
  self:BindToRaw(function(data, v, o)
    owner:GetComponent(TYPEOF_CanvasGroup).alpha = v and 1 or 0
  end, expOrFn)
end

function Binder:BindButtonClick(owner, onClick, stateFunc, chosenFunc, CanPlayAudioFunc)
  local intervalTime = 0
  local ButtonComp = owner:GetComponent(TYPEOF_Z1Button)
  if nil == ButtonComp then
    ButtonComp = owner:GetComponent(TYPEOF_Button)
  end
  ButtonComp.onClick:RemoveAllListeners()
  if stateFunc and ButtonComp.BtnType == Z1ButtonType.CommonButton then
    self:BindToRaw(function(_, n, _)
      if not n then
        return
      end
      ButtonComp.BtnState = n
    end, stateFunc)
  end
  if chosenFunc and ButtonComp.BtnType == Z1ButtonType.SingleChooseButton then
    self:BindToRaw(function(_, n, _)
      if nil == n then
        return
      end
      ButtonComp.IsChosen = n
    end, chosenFunc)
  end
  local AudioEffectComp = owner:GetComponent(TYPEOF_AudioEffect)
  if CanPlayAudioFunc and AudioEffectComp then
    self:BindToRaw(function(_, n, _)
      if nil == n then
        return
      end
      AudioEffectComp.CanPlayAudio = n
    end, CanPlayAudioFunc)
  end
  local playAudioEffectFunc = self:GetButtonPlayAudioEffectFunc(owner)
  self:BindAction(function(onAction)
    if onAction then
      if ButtonComp then
        ButtonComp.onClick:AddListener(onAction)
      end
    elseif ButtonComp then
      ButtonComp.onClick:RemoveAllListeners()
    end
  end, function()
    local alpha = self:GetCanvasGroupValue(owner)
    if 0 == alpha then
      return
    end
    if CS.Framework.TimeUtil.GetRealtimeSinceStartup() - DataCenter.gameData.ButtonClickTime < 0.1 then
      return
    end
    EventMgr.Instance.ClickButtonEffect:Dispatch(owner)
    if onClick then
      onClick()
      DataCenter.gameData.ButtonClickTime = CS.Framework.TimeUtil.GetRealtimeSinceStartup()
    end
    if not playAudioEffectFunc then
      return
    end
    local btnState = ButtonComp.BtnState or Z1ButtonState.Default
    playAudioEffectFunc(btnState)
  end)
end

function Binder:BindZ1Button(owner, onClick, stateFunc, TextFunc, redPointFunc, chosenFunc, CanPlayAudioFunc)
  local ButtonComp = owner:GetComponent(TYPEOF_Z1Button)
  if nil == ButtonComp then
    if TextFunc or redPointFunc then
      Logger.Error("BindZ1Button: GameObject lacks Z1Button but TextFunc/redPointFunc need it, name=" .. tostring(owner and owner.name))
    end
    self:BindButtonClick(owner, onClick, stateFunc, chosenFunc, CanPlayAudioFunc)
    return
  end
  if stateFunc and ButtonComp.BtnType == Z1ButtonType.CommonButton then
    self:BindToRaw(function(_, n, _)
      if not n or Main.isAppDestroyed then
        return
      end
      ButtonComp.BtnState = n
    end, stateFunc)
  end
  if chosenFunc and ButtonComp.BtnType == Z1ButtonType.SingleChooseButton then
    self:BindToRaw(function(_, n, _)
      if nil == n or Main.isAppDestroyed then
        return
      end
      ButtonComp.IsChosen = n
    end, chosenFunc)
  end
  local AudioEffectComp = owner:GetComponent(TYPEOF_AudioEffect)
  if CanPlayAudioFunc and AudioEffectComp then
    self:BindToRaw(function(_, n, _)
      if nil == n or Main.isAppDestroyed then
        return
      end
      AudioEffectComp.CanPlayAudio = n
    end, CanPlayAudioFunc)
  end
  if TextFunc and ButtonComp.buttonTextComp then
    self:BindToRaw(function(_, n, _)
      if nil == n or Main.isAppDestroyed then
        return
      end
      local str = StrUtils.SafeSetWordEffectStr(n)
      str = LT.ReplaceUnicodeSpace(str)
      self:SetText(ButtonComp.buttonTextComp, str)
    end, TextFunc)
  end
  if redPointFunc and ButtonComp.RedDotObj then
    self:BindComponent(RedDotComponent(ButtonComp.RedDotObj, nil, nil, redPointFunc))
  end
  local playAudioEffectFunc = self:GetButtonPlayAudioEffectFunc(owner)
  self:BindAction(function(onAction)
    if onAction then
      ButtonComp.onClick:AddListener(onAction)
    else
      ButtonComp.onClick:RemoveAllListeners()
    end
  end, function()
    local alpha = self:GetCanvasGroupValue(owner)
    if 0 == alpha then
      return
    end
    if CS.Framework.TimeUtil.GetRealtimeSinceStartup() - DataCenter.gameData.ButtonClickTime < 0.1 then
      return
    end
    EventMgr.Instance.ClickButtonEffect:Dispatch(owner)
    if onClick then
      onClick()
      DataCenter.gameData.ButtonClickTime = CS.Framework.TimeUtil.GetRealtimeSinceStartup()
    end
    if not playAudioEffectFunc then
      return
    end
    local btnState = ButtonComp.BtnState or Z1ButtonState.Default
    playAudioEffectFunc(btnState)
  end)
end

function Binder:BindEffectToButton(owner, isShowAppear)
  local animator = owner:GetComponent(typeof(CS.UnityEngine.Animator))
  if not animator then
    return
  end
  if isShowAppear then
    AnimatorUtils.SetTrigger(animator, CommonDefine.BtnAniTrigger.Appear)
    animator:Update(0)
  end
  self:BindEvent(EventMgr.Instance.ClickButtonEffect, function(own)
    if owner == own and not IsNil(animator) then
      AnimatorUtils.SetTrigger(animator, CommonDefine.BtnAniTrigger.Click)
      animator:Update(0)
    end
  end)
end

function Binder:SetButtonState(owner, btnState)
  local buttonComp = self:GetButton(owner)
  if not buttonComp then
    Logger.Error("UIBinder Binder:SetButtonState")
    return
  end
  if buttonComp.BtnType == Z1ButtonType.CommonButton then
    buttonComp.BtnState = btnState
  end
end

function Binder:BindToButtonState(owner, btnStateFunc)
  self:BindToRaw(function(_, n, _)
    if n then
      self:SetButtonState(owner, n)
    end
  end, btnStateFunc)
end

function Binder:GetButtonState(owner)
  local buttonComp = self:GetButton(owner)
  if not buttonComp then
    Logger.Error("UIBinder Binder:SetButtonState")
    return
  end
  return buttonComp.BtnState
end

function Binder:GetButton(owner)
  local buttonComp = owner:GetComponent(TYPEOF_Z1Button)
  if nil == buttonComp then
    buttonComp = owner:GetComponent(TYPEOF_Button)
  end
  return buttonComp
end

function Binder:BindPressDown(owner, onLongPress)
  local RepeatButtonComp = owner:GetComponent(TYPEOF_RepeatButton)
  local playAudioEffectFunc = self:GetButtonPlayAudioEffectFunc(owner)
  self:BindAction(function(onAction)
    if onAction then
      RepeatButtonComp.onClickDown:AddListener(onAction)
    else
      RepeatButtonComp.onClickDown:RemoveAllListeners()
    end
  end, function()
    onLongPress()
    if not playAudioEffectFunc then
      return
    end
    playAudioEffectFunc(Z1ButtonState.Default)
  end)
end

function Binder:BindLongPressButton(owner, onLongPress, onShortPress, intervalTime)
  local longPressPlayAudioTime = 0
  local RepeatButtonComp = owner:GetComponent(TYPEOF_RepeatButton)
  RepeatButtonComp = RepeatButtonComp or owner:AddComponent(TYPEOF_RepeatButton)
  RepeatButtonComp.onLongPress:RemoveAllListeners()
  RepeatButtonComp.onShortPress:RemoveAllListeners()
  local playAudioEffectFunc = self:GetButtonPlayAudioEffectFunc(owner)
  self:BindAction(function(onAction)
    if onAction then
      if intervalTime then
        RepeatButtonComp.interval = intervalTime
      end
      local repeatLongPressTimer
      local triggeredTimes = 0
      RepeatButtonComp.onLongPress:AddListener(function()
        triggeredTimes = triggeredTimes + 1
        onAction(triggeredTimes)
      end)
      self:BindEvent(EventMgr.Instance.TouchEndEvent, function()
        longPressPlayAudioTime = 0
        triggeredTimes = 0
        self:StopTimer(repeatLongPressTimer)
      end)
    else
      RepeatButtonComp.onLongPress:RemoveAllListeners()
    end
  end, function(triggeredTimes)
    if onLongPress then
      onLongPress(triggeredTimes)
    end
    if playAudioEffectFunc and longPressPlayAudioTime <= 0 then
      playAudioEffectFunc(Z1ButtonState.Default)
      longPressPlayAudioTime = longPressPlayAudioTime + 1
    end
  end)
  self:BindAction(function(onAction)
    if onAction then
      if intervalTime then
        RepeatButtonComp.interval = intervalTime
      end
      RepeatButtonComp.onShortPress:AddListener(onAction)
    else
      RepeatButtonComp.onShortPress:RemoveAllListeners()
    end
  end, function()
    if CS.Framework.TimeUtil.GetRealtimeSinceStartup() - DataCenter.gameData.ButtonClickTime < 0.1 then
      return
    end
    if onShortPress then
      onShortPress()
    end
    DataCenter.gameData.ButtonClickTime = CS.Framework.TimeUtil.GetRealtimeSinceStartup()
    if not playAudioEffectFunc then
      return
    end
    playAudioEffectFunc(Z1ButtonState.Default)
  end)
end

function Binder:BindUICustomInput(owner, onClick)
  if not onClick then
    return
  end
  self:BindAction(function(onAction)
    UICustomInput.Get(owner).onAction = nil
    if onAction then
      UICustomInput.Get(owner).onAction = onAction
    end
  end, function(hover)
    onClick(hover)
  end)
end

function Binder:CancelRepeatButtonPress(owner)
  local RepeatButtonComp = owner:GetComponent(TYPEOF_RepeatButton)
  if not RepeatButtonComp then
    return
  end
  if RepeatButtonComp.isPointerDown == nil then
    owner:SetActive(false)
    owner:SetActive(true)
    return
  end
  RepeatButtonComp.isPointerDown = false
end

function Binder:BindPressUp(owner, onLongPress)
  local RepeatButtonComp = owner:GetComponent(TYPEOF_RepeatButton)
  self:BindAction(function(onAction)
    if onAction then
      RepeatButtonComp.onRelease:AddListener(onAction)
    else
      RepeatButtonComp.onRelease:RemoveAllListeners()
    end
  end, onLongPress)
end

function Binder:BindOnBeginDrag(owner, onBegion)
  local RepeatButtonComp = owner:GetComponent(TYPEOF_RepeatButton)
  self:BindAction(function(onAction)
    if onAction then
      RepeatButtonComp.onBeginDrag:AddListener(onAction)
    else
      RepeatButtonComp.onBeginDrag:RemoveAllListeners()
    end
  end, onBegion)
end

function Binder:BindToButtonGray(owner, grayExpOrFn, clickExpOrFn)
  local gray = ColorUtils.ParseHtmlStringToUnityColor(CommonDefine.TextColorDefine.Gray)
  local normal = ColorUtils.ParseHtmlStringToUnityColor(CommonDefine.TextColorDefine.White)
  local ImageObj = owner:GetComponent(TYPEOF_Image)
  self:BindToRaw(function(_, n, o)
    ImageObj.color = n and gray or normal
  end, grayExpOrFn)
  local btnObj = owner:GetComponent(TYPEOF_Z1Button)
  if nil == btnObj then
    btnObj = owner:GetComponent(TYPEOF_Button)
  end
  if clickExpOrFn then
    self:BindToRaw(function(_, n, o)
      btnObj.interactable = n
    end, clickExpOrFn)
  end
end

function Binder:SetButtonInteractable(owner, clickExpOrFn, resetCd)
  local btnObj = owner:GetComponent(TYPEOF_Z1Button)
  if nil == btnObj then
    btnObj = owner:GetComponent(TYPEOF_Button)
  end
  if btnObj then
    btnObj.interactable = clickExpOrFn
    if resetCd then
      self._btnInteraTimer = self._btnInteraTimer or {}
      local ownerName = owner.name
      TimerManager.Instance:StopTimer(self._btnInteraTimer[ownerName])
      self._btnInteraTimer[ownerName] = self:BindTimer(resetCd, 0, nil, function()
        btnObj.interactable = not clickExpOrFn
      end)
    end
  end
end

function Binder:BindTimer(duration, repeatTimes, repeatCallback, finishCallback)
  local timerId
  self:BindAction(function(onAction)
    if onAction then
      timerId = TimerManager.Instance:CreateTimer(duration, repeatTimes, repeatCallback, function()
        if timerId then
          TimerManager.Instance:StopTimer(timerId)
          timerId = nil
        end
        if finishCallback then
          finishCallback()
        end
      end)
    elseif timerId then
      TimerManager.Instance:StopTimer(timerId)
      timerId = nil
    end
  end, true)
  return timerId
end

function Binder:StopTimer(timerId)
  if timerId then
    TimerManager.Instance:StopTimer(timerId)
  end
end

function Binder:BindShortCut(keyStr, func)
  ShortCutKeyManager.Instance:Register(keyStr, func)
  self:onDestroy(function()
    ShortCutKeyManager.Instance:UnRegister(keyStr, func)
  end)
end

local _

function Binder:BindToCircularListView(owner, expOrFn, itemUpdateFunc, unBindUpdateFunc, sync, preGenerateNum)
  local circularScrollView = owner:GetComponent(TYPEOF_CircularScrollView)
  local ListChangeType = CS.UICircularScrollView.ListChangeType
  local scrollRect = owner:GetComponent(TYPEOF_ScrollRect)
  if scrollRect then
    scrollRect.scrollSensitivity = cd.ScrollSensitivity
  end
  local initLength
  
  local function GetDataList()
    local list
    if type(expOrFn) == "function" then
      list = expOrFn()
    elseif type(expOrFn) == "table" then
      list = expOrFn
    end
    return list or {}
  end
  
  local dataList = GetDataList()
  initLength = #dataList
  local ownerBinder = self
  local listBinder = ownerBinder:createChild()
  local binderList = {}
  
  local function updateUnBindFunc(index)
    if binderList[index] then
      binderList[index]:Unbind()
      binderList[index] = nil
      if unBindUpdateFunc then
        unBindUpdateFunc(index)
      end
    end
  end
  
  local function updateFunc(gameObject, index)
    if nil == binderList[index] then
      local binder = listBinder:createChild(dataList[index])
      binderList[index] = binder
    end
    itemUpdateFunc(binderList[index], gameObject, index)
  end
  
  local originGOSizeDelta, listItemRectTransform
  if circularScrollView.itemGameObject then
    listItemRectTransform = circularScrollView.itemGameObject:GetComponent(TYPEOF_RectTransform)
    local sizeDelta = listItemRectTransform.sizeDelta
    originGOSizeDelta = CS.UnityEngine.Vector2(sizeDelta.x, sizeDelta.y)
  end
  preGenerateNum = preGenerateNum or 0
  circularScrollView:Init(updateFunc, updateUnBindFunc, preGenerateNum)
  if originGOSizeDelta and listItemRectTransform then
    listItemRectTransform.sizeDelta = originGOSizeDelta
  end
  circularScrollView:InitList(initLength)
  listBinder:BindRawTable(expOrFn, function(_, n, o, index)
    local cType
    if type(index) ~= "number" then
      return
    end
    if n then
      cType = ListChangeType.Changed
      if not o then
        cType = ListChangeType.Add
      end
    elseif nil ~= o then
      cType = ListChangeType.Remove
    end
    if nil == cType then
      return
    end
    if cType == ListChangeType.Remove then
      if binderList[index] then
        binderList[index]:Unbind()
      end
      circularScrollView:UpdateList(cType, 1)
      return
    end
    local binder = listBinder:createChild(n)
    if cType == ListChangeType.Changed then
      if binderList[index] then
        binderList[index]:Unbind()
      end
      binderList[index] = binder
      circularScrollView:UpdateItem(index)
    elseif cType == ListChangeType.Add then
      binderList[index] = binder
      if index <= initLength then
        circularScrollView:UpdateItem(index)
        return
      end
      circularScrollView:UpdateList(cType, 1)
    end
  end, sync, function(resetNil)
    if resetNil then
      for _, value in pairs(binderList) do
        value:Unbind()
      end
      binderList = {}
      if not Main.isAppDestroyed then
        circularScrollView:RecycleObjs()
      end
    end
  end)
  if circularScrollView:CheckItemSize() then
    circularScrollView:UpdateList(ListChangeType.Changed, 0)
  end
  initLength = 0
  listBinder:onDestroy(function()
    for _, value in pairs(binderList) do
      value:Unbind()
    end
    binderList = {}
    if not Main.isAppDestroyed then
      circularScrollView:RecycleObjs()
    end
  end)
  return listBinder
end

function Binder:CircularScrollTo(listGo, index)
  if not listGo then
    return
  end
  local circularScrollView = listGo:GetComponent(TYPEOF_CircularScrollView)
  if not circularScrollView then
    return
  end
  circularScrollView:ScrollTo(index)
end

function Binder:CircularRemoveItemWithAnim(listGo, index, func)
  if not listGo then
    return
  end
  local circularScrollView = listGo:GetComponent(TYPEOF_CircularScrollView)
  if not circularScrollView then
    return
  end
  circularScrollView:RemoveItemWithAnim(index, func)
end

function Binder.PlayTableViewFadeInAnim(target, listGo)
  Logger.Debug("PlayTableViewFadeInAnim ", listGo.name)
  if not listGo then
    return
  end
  local tableview = listGo:GetComponent(typeof(T_UITableview))
  if not tableview then
    return
  end
  local reloadFinishCallback = tableview.reloadFinishCallback
  local isReady = tableview.isReady
  
  local function doPlayFadeInAnim(tableview)
    if not isReady then
      if reloadFinishCallback then
        tableview.reloadFinishCallback = reloadFinishCallback
        reloadFinishCallback(tableview)
      else
        tableview.reloadFinishCallback = nil
      end
    end
    local fadeInAnimName = tableview.fadeInAnimName
    if not fadeInAnimName or "" == fadeInAnimName then
      return
    end
    local gameObjectList = tableview:GetVisibleCellsList()
    if not gameObjectList or gameObjectList.Count <= 0 then
      return
    end
    if not target.listTimerDict then
      target.listTimerDict = {}
    end
    local fadeInAnimTimeType = tableview.fadeInAnimType
    local fadeInInterval = tableview.fadeInInterval
    local timer = target.listTimerDict[listGo]
    if timer then
      target:StopTimer(timer)
      target.listTimerDict[listGo] = nil
    end
    local time = 0
    local interval = 0.01
    local objIndex = 0
    local fadeInIntervalArr = tableview.fadeInIntervalArr
    local animCtrlList = {}
    for i = 0, gameObjectList.Count - 1 do
      local obj = gameObjectList[i]
      local animCtrl
      if obj then
        animCtrl = obj.gameObject:GetComponent(TYPEOF_UIAnimationController)
      end
      if not animCtrl then
      else
        table.insert(animCtrlList, animCtrl)
        obj.gameObject:SetActive(false)
      end
    end
    local fadeInAnimTimer
    fadeInAnimTimer = target:BindTimer(interval, -1, function()
      local timeToPlay = fadeInInterval * objIndex
      if fadeInAnimTimeType == FadeInAnimType.NotFixed then
        timeToPlay = fadeInIntervalArr[objIndex]
      end
      if timeToPlay <= time then
        local animCtrl = animCtrlList[objIndex + 1]
        if animCtrl then
          animCtrl.gameObject:SetActive(true)
          animCtrl:PlayMultiState(fadeInAnimName, nil, 1, false)
        end
        objIndex = objIndex + 1
      end
      if objIndex > #animCtrlList then
        target:StopTimer(fadeInAnimTimer)
        target.listTimerDict[listGo] = nil
      end
      time = time + interval
    end)
    target.listTimerDict[listGo] = fadeInAnimTimer
  end
  
  if not isReady then
    tableview.reloadFinishCallback = doPlayFadeInAnim
  else
    doPlayFadeInAnim(tableview)
  end
end

function Binder:PlayCircularScrollViewFadeInAnim(listGo)
  Logger.Debug("PlayCircularScrollViewFadeInAnim ", listGo.name)
  if not listGo then
    return
  end
  if not self.listTimerDict then
    self.listTimerDict = {}
  end
  local timer = self.listTimerDict[listGo]
  if timer then
    self:StopTimer(timer)
    self.listTimerDict[listGo] = nil
  end
  local circularScrollView = listGo:GetComponent(TYPEOF_CircularScrollView)
  if not circularScrollView then
    return
  end
  local fadeInAnimName = circularScrollView.fadeInAnimName
  local fadeInAnimTimeType = circularScrollView.fadeInAnimType
  local fadeInInterval = circularScrollView.fadeInInterval
  if not fadeInAnimName or "" == fadeInAnimName then
    return
  end
  local gameObjectList = circularScrollView:GetShowObjList()
  if not gameObjectList or gameObjectList.Count <= 0 then
    return
  end
  local time = 0
  local interval = 0.01
  local objIndex = 0
  local fadeInIntervalArr = circularScrollView.fadeInIntervalArr
  local animCtrlList = {}
  for i = 0, gameObjectList.Count - 1 do
    local obj = gameObjectList[i]
    local animCtrl
    if obj then
      animCtrl = obj:GetComponent(TYPEOF_UIAnimationController)
    end
    if not animCtrl then
    else
      table.insert(animCtrlList, animCtrl)
      obj:SetActive(false)
    end
  end
  local fadeInAnimTimer
  fadeInAnimTimer = self:BindTimer(interval, -1, function()
    local timeToPlay = fadeInInterval * objIndex
    if fadeInAnimTimeType == FadeInAnimType.NotFixed then
      timeToPlay = fadeInIntervalArr[objIndex]
    end
    if timeToPlay <= time then
      local animCtrl = animCtrlList[objIndex + 1]
      if animCtrl then
        animCtrl.gameObject:SetActive(true)
        animCtrl:PlayMultiState(fadeInAnimName, nil, 1, false)
      end
      objIndex = objIndex + 1
    end
    if objIndex > #animCtrlList then
      self:StopTimer(fadeInAnimTimer)
      self.listTimerDict[listGo] = nil
    end
    time = time + interval
  end)
  self.listTimerDict[listGo] = fadeInAnimTimer
end

function Binder:ListViewJumpToIndex(owner, index, offset)
  local listView = owner:GetComponent(TYPEOF_NormalListView)
  assert(listView, string.format("owner = %s GetComponent<normalListView> nil", owner.name))
  offset = offset or 0
  listView:ScrollTo(index, offset)
end

function Binder:BindNormalListView(owner, dataFn, getPrefabFunc, updateFunc, unBindUpdateFunc)
  local normalListView = owner:GetComponent(TYPEOF_NormalListView)
  assert(normalListView, string.format("owner = %s GetComponent<normalListView> nil", owner.name))
  assert(dataFn, "dataFn is nil")
  local ownerBinder = self
  local listBinder = ownerBinder:createChild()
  local binderList = {}
  
  local function onRecycle(index)
    if binderList[index] then
      binderList[index]:Unbind()
      binderList[index] = nil
    end
  end
  
  local function update(loopListViewItem, index)
    if binderList[index] then
      binderList[index]:Unbind()
    end
    local binder = listBinder:createChild(dataFn()[index])
    binderList[index] = binder
    pcall(updateFunc, binderList[index], loopListViewItem.gameObject, index)
  end
  
  listBinder:BindToRaw(function(_, n, o)
    if o and 0 == o and n and n > 0 then
      normalListView:Init(n, getPrefabFunc, update, onRecycle, nil)
      return
    end
    if not o and n and n > 0 then
      normalListView:Init(n, getPrefabFunc, update, onRecycle, nil)
      return
    end
    if n and o and n ~= o then
      normalListView:OnListNumChanged(n)
    end
  end, function()
    return #dataFn()
  end, true)
  listBinder:BindRawTable(dataFn, function(_, n, o, _index)
    if n and o and n ~= o then
      local index = _index - 1
      if index < 0 then
        index = 0
      end
      local listViewItem = normalListView:GetListViewItem(index)
      if listViewItem then
        update(listViewItem, _index)
      end
    end
  end, false)
  listBinder:onDestroy(function()
    for _, value in pairs(binderList) do
      value:Unbind()
    end
    binderList = {}
    normalListView:ResetAll()
  end)
end

function Binder:BindExpandListView(owner, dataFn, getPrefabFunc, updateFunc, single, unBindUpdateFunc)
  assert(owner, "[BindExpandListView] owner nil")
  local expandListView = owner:GetComponent(typeof(CS.Z1ScrollView.ExpandListView))
  assert(expandListView, string.format("owner = %s GetComponent<ExpandListView> nil", owner.name))
  assert(dataFn, "dataFn is nil")
  local ownerBinder = self
  local listBinder = ownerBinder:createChild()
  local scrollRect = owner:GetComponent(TYPEOF_ScrollRect)
  if scrollRect then
    scrollRect.scrollSensitivity = 50
  end
  local binderList = {}
  
  local function onRecycle(index)
    if binderList[index] then
      binderList[index]:Unbind()
      binderList[index] = nil
    end
  end
  
  local function update(loopListViewItem, index)
    local function onExpand(width, height, scale, notRest)
      local rectTransform = loopListViewItem.gameObject:GetComponent(TYPEOF_RectTransform)
      
      local size = rectTransform.sizeDelta
      if width then
        size.x = width
      end
      if height then
        size.y = height
      end
      if scale then
        rectTransform.localScale = CS.UnityEngine.Vector3(scale, scale, scale)
      end
      rectTransform.sizeDelta = size
      loopListViewItem.ParentListView:OnItemSizeChanged(index - 1)
      if single and not notRest then
        expandListView:ResetOtherSizeExcept(index - 1)
      end
    end
    
    if binderList[index] then
      binderList[index]:Unbind()
    end
    local binder = listBinder:createChild(dataFn()[index])
    binderList[index] = binder
    updateFunc(binderList[index], loopListViewItem.gameObject, index, onExpand)
  end
  
  listBinder:BindToRaw(function(_, n, o)
    if o and 0 == o and n and n > 0 then
      expandListView:Init(n, getPrefabFunc, update, onRecycle)
      return
    end
    if not o and n and n > 0 then
      expandListView:Init(n, getPrefabFunc, update, onRecycle)
      return
    end
    if n and o and n ~= o then
      expandListView:OnListNumChanged(n)
    end
  end, function()
    return #dataFn()
  end, false)
  listBinder:BindRawTable(dataFn, function(_, n, o, _index)
    if n and o and n ~= o then
      local index = _index - 1
      if index < 0 then
        index = 0
      end
      local listViewItem = expandListView:GetListViewItem(index)
      if listViewItem then
        update(listViewItem, _index)
      end
    end
  end, false)
  listBinder:onDestroy(function()
    for _, value in pairs(binderList) do
      value:Unbind()
    end
    binderList = {}
    expandListView:ResetAll()
  end)
end

function Binder:BindPageListView(ownerList, dataFn, getPrefabFunc, updateFunc, onTurnPage, unBindUpdateFunc)
  assert(ownerList and #ownerList > 0, "[BindPageListView] ownerList nil")
  local listGo = ownerList[1]
  local btnPrev = ownerList[2]
  local btnNext = ownerList[3]
  local dotList = ownerList[4]
  local pageListView = listGo:GetComponent(CS.Z1ScrollView.PageListView)
  assert(pageListView, string.format("owner = %s GetComponent<PageListView> nil", listGo.name))
  assert(dataFn, "dataFn is nil")
  local ownerBinder = self
  local listBinder = ownerBinder:createChild()
  local binderList = {}
  
  local function onRecycle(index)
    if binderList[index] then
      binderList[index]:Unbind()
      binderList[index] = nil
    end
  end
  
  local function update(loopListViewItem, index)
    if binderList[index] then
      binderList[index]:Unbind()
    end
    local binder = listBinder:createChild(dataFn()[index])
    binderList[index] = binder
    updateFunc(binderList[index], loopListViewItem.gameObject, index)
  end
  
  local initParam = CS.Z1ScrollView.LoopListViewInitParam()
  initParam.mSmoothDumpRate = 0.1
  initParam.mSnapVecThreshold = 99999
  if btnPrev and btnNext then
    listBinder:BindButtonClick(btnPrev, function()
      pageListView:SetSnapIndex(-1)
    end)
    listBinder:BindButtonClick(btnNext, function()
      pageListView:SetSnapIndex(1)
    end)
  end
  if dotList and #dotList > 0 then
    for i = 1, #dotList do
      local dot = dotList[i]
      if dot then
        listBinder:BindButtonClick(dot, function()
          if #dataFn() < i then
            Logger.Debug("no such page to show")
            return
          end
          pageListView:JumpSnapIndex(i - 1)
        end)
      end
    end
  end
  listBinder:BindToRaw(function(_, n, o)
    if o and 0 == o and n and n > 0 then
      pageListView:Init(n, getPrefabFunc, onTurnPage, update, onRecycle, initParam)
      return
    end
    if not o and n and n > 0 then
      pageListView:Init(n, getPrefabFunc, onTurnPage, update, onRecycle, initParam)
      return
    end
    if n and o and n ~= o then
      pageListView:OnListNumChanged(n)
    end
  end, function()
    return #dataFn()
  end, false)
  listBinder:BindRawTable(dataFn, function(_, n, o, _index)
    if n and o and n ~= o then
      local index = _index - 1
      if index < 0 then
        index = 0
      end
      local listViewItem = pageListView:GetListViewItem(index)
      if listViewItem then
        update(listViewItem, _index)
      end
    end
  end, false)
  listBinder:onDestroy(function()
    for _, value in pairs(binderList) do
      value:Unbind()
    end
    binderList = {}
    pageListView:ResetAll()
  end)
end

function Binder:BindCenterListView(owner, dataFn, getPrefabFunc, updateFunc, onCenterChanged, unBindUpdateFunc)
  assert(owner, "[BindCenterListView] owner nil")
  local centerListView = owner:GetComponent(typeof(CS.Z1ScrollView.CenterListView))
  assert(centerListView, string.format("owner = %s GetComponent<centerListView> nil", owner.name))
  assert(dataFn, "dataFn is nil")
  local ownerBinder = self
  local listBinder = ownerBinder:createChild()
  local binderList = {}
  local maxShowNum = centerListView:GetListMaxShowNum()
  if 0 ~= maxShowNum / 2 then
    maxShowNum = maxShowNum - 1
  end
  local halfAddNum = maxShowNum / 2
  centerListView:SetHalfAddNum(halfAddNum)
  
  local function onRecycle(index)
    index = index - halfAddNum
    if binderList[index] then
      binderList[index]:Unbind()
      binderList[index] = nil
      if unBindUpdateFunc then
        unBindUpdateFunc(index)
      end
    end
  end
  
  local function update(loopListViewItem, index)
    if binderList[index] then
      binderList[index]:Unbind()
    end
    local binder = listBinder:createChild(dataFn()[index])
    binderList[index] = binder
    updateFunc(binderList[index], loopListViewItem.gameObject, index)
  end
  
  local initParam = CS.Z1ScrollView.LoopListViewInitParam()
  initParam.mSmoothDumpRate = 0.1
  initParam.mSnapVecThreshold = 99999
  listBinder:BindToRaw(function(_, n, o)
    if o and 0 == o and n and n > 0 then
      centerListView:Init(n, getPrefabFunc, onCenterChanged, update, onRecycle, initParam)
      return
    end
    if not o and n and n > 0 then
      centerListView:Init(n, getPrefabFunc, onCenterChanged, update, onRecycle, initParam)
      return
    end
    if n and o and n ~= o then
      centerListView:OnListNumChanged(n)
    end
  end, function()
    return #dataFn()
  end, true)
  listBinder:BindRawTable(dataFn, function(_, n, o, _index)
    if n and o and n ~= o then
      local index = _index - 1
      if index < 0 then
        index = 0
      end
      local listViewItem = centerListView:GetListViewItem(index)
      if listViewItem then
        update(listViewItem, _index)
      end
    end
  end, false)
  listBinder:onDestroy(function()
    for _, value in pairs(binderList) do
      value:Unbind()
    end
    binderList = {}
    centerListView:ResetAll()
  end)
end

function Binder:CenterListScrollTo(owner, index)
  assert(owner, "[BindCenterListView] owner nil")
  local centerListView = owner:GetComponent(typeof(CS.Z1ScrollView.CenterListView))
  assert(centerListView, string.format("owner = %s GetComponent<centerListView> nil", owner.name))
  if not index then
    return
  end
  centerListView:ScrollTo(index)
end

function Binder:GetInputFieldComp(owner)
  local comp = owner:GetComponent(TYPEOF_InputField)
  comp = comp or owner:GetComponent(TYPEOF_TMP_InputField)
  return comp
end

function Binder:GetInputText(owner)
  return self:GetInputFieldComp(owner).text
end

function Binder:BindToInputText(owner, expOrFn)
  self:BindToRaw(function(data, v, o)
    owner:GetComponent(TYPEOF_InputField).text = v
  end, expOrFn)
end

function Binder:SetInputTextCharLimite(owner, value)
  local comp = self:GetInputFieldComp(owner)
  if not comp then
    return
  end
  comp.characterLimit = value
end

function Binder:SetInputText(owner, value)
  local comp = self:GetInputFieldComp(owner)
  if not comp then
    return
  end
  comp.text = value
end

function Binder:BindToInputValueChange(owner, onChange)
  self:BindAction(function(onAction)
    local comp = self:GetInputFieldComp(owner)
    if onAction then
      comp.onValueChanged:AddListener(onAction)
    else
      comp.onValueChanged:RemoveAllListeners()
    end
  end, onChange)
end

function Binder:BindToInputEndEdit(owner, onEndEdit)
  self:BindAction(function(onAction)
    local comp = self:GetInputFieldComp(owner)
    if onAction then
      comp.onEndEdit:AddListener(onAction)
    else
      comp.onEndEdit:RemoveAllListeners()
    end
  end, onEndEdit)
end

function Binder:BindToToggleIsOn(owner, expOrFn)
  local ToggleComp = owner:GetComponent(typeof(CS.UnityEngine.UI.Toggle))
  local playAudioEffectFunc = self:GetTogglePlayAudioEffectFunc(owner)
  self:BindToRaw(function(data, v, o)
    ToggleComp.isOn = v
    if not playAudioEffectFunc then
      return
    end
    playAudioEffectFunc(v)
  end, function(...)
    expOrFn(...)
  end)
end

function Binder:BindToToggleValueChange(owner, onChange)
  local ToggleComp = owner:GetComponent(typeof(CS.UnityEngine.UI.Toggle))
  local playAudioEffectFunc = self:GetTogglePlayAudioEffectFunc(owner)
  self:BindAction(function(onAction)
    if onAction then
      ToggleComp.onValueChanged:RemoveAllListeners()
      ToggleComp.onValueChanged:AddListener(onAction)
    else
      ToggleComp.onValueChanged:RemoveAllListeners()
    end
  end, function(...)
    onChange(...)
    if not playAudioEffectFunc then
      return
    end
    playAudioEffectFunc(...)
  end)
end

function Binder:SetToggle(owner, isOn)
  owner:GetComponent(typeof(CS.UnityEngine.UI.Toggle)).isOn = isOn
end

function Binder:SetToggleInteractable(owner, state)
  owner:GetComponent(typeof(CS.UnityEngine.UI.Toggle)).interactable = state
end

function Binder:SetZ1ToggleInteractable(owner, state)
  owner:GetComponent(TYPEOF_Z1Toggle).interactable = state
end

function Binder:SetZ1Toggle(owner, isOn, withoutNotify)
  local toggleComp = owner:GetComponent(TYPEOF_Z1Toggle)
  if not withoutNotify then
    toggleComp.isOn = isOn
  else
    toggleComp:SetIsOnWithoutNotify(isOn)
  end
  if toggleComp.toggleTextComp then
    local colorType = isOn and CommonDefine.ColorType.Light or CommonDefine.ColorType.Normal
    self:SetTextColorType(toggleComp.toggleTextComp, colorType)
  end
end

function Binder:BindCommonLockPrefab(owner, lockResCls, onBtnClick, expOrFn)
  if not owner then
    return
  end
  if not lockResCls then
  end
  local ui = lockResCls(owner)
  if not (ui and ui.Btn_Lock) or not ui.Btn_Unlock then
    return
  end
  self:BindButtonClick(ui.Btn_Lock, function()
    if onBtnClick then
      onBtnClick(false)
    end
  end)
  self:BindButtonClick(ui.Btn_Unlock, function()
    if onBtnClick then
      onBtnClick(true)
    end
  end)
  self:BindToRaw(function(_, locked)
    ui.Btn_Lock:SetActive(locked)
    ui.Btn_Unlock:SetActive(not locked)
  end, expOrFn)
  return ui
end

function Binder:BindToZ1Toggle(owner, relativeUI, onToggleChange, expOrFn, textFunc, lockShowFunc, lockClickFunc)
  local toggleComp = owner:GetComponent(TYPEOF_Z1Toggle)
  if relativeUI then
    relativeUI:SetActive(toggleComp.isOn)
  end
  local playAudioEffectFunc = self:GetTogglePlayAudioEffectFunc(owner)
  self:BindAction(function(onAction)
    if onAction then
      toggleComp.onValueChanged:AddListener(onAction)
    else
      toggleComp.onValueChanged:RemoveAllListeners()
    end
  end, function(...)
    local isOn = (...)
    if relativeUI then
      relativeUI:SetActive(isOn)
    end
    if onToggleChange then
      onToggleChange(...)
    end
    if toggleComp.toggleTextComp and not expOrFn then
      local isOn = (...)
      local colorType = isOn and CommonDefine.ColorType.Light or CommonDefine.ColorType.Normal
      self:SetTextColorType(toggleComp.toggleTextComp, colorType)
    end
  end)
  self:BindAction(function(onAction)
    if onAction then
      toggleComp.onToggleTouched:AddListener(onAction)
    else
      toggleComp.onToggleTouched:RemoveAllListeners()
    end
  end, function(...)
    local isOn = (...)
    if playAudioEffectFunc then
      playAudioEffectFunc(isOn)
    end
  end)
  if toggleComp.toggleTextComp then
    if textFunc then
      self:BindToRaw(function(_, n, _)
        if nil == n then
          return
        end
        local str = StrUtils.SafeSetWordEffectStr(n)
        str = LT.ReplaceUnicodeSpace(str)
        toggleComp.toggleTextComp.text = str
      end, textFunc)
    end
    if lockShowFunc and lockShowFunc() then
      self:SetTextColorType(toggleComp.toggleTextComp, CommonDefine.ColorType.Dark)
    end
    if expOrFn then
      self:BindToTextColor(toggleComp.toggleTextComp, function()
        if lockShowFunc and lockShowFunc() then
          return CommonDefine.ColorType.Dark
        end
        local isOn = expOrFn and expOrFn()
        if isOn then
          return CommonDefine.ColorType.Light
        end
        return CommonDefine.ColorType.Normal
      end)
    end
  end
  if expOrFn then
    self:BindToRaw(function(_, n, _)
      toggleComp:SetIsOnWithoutNotify(n)
    end, expOrFn)
  end
  if lockShowFunc and toggleComp.disableNode then
    self:BindToVisible(toggleComp.disableNode, lockShowFunc)
  end
  if lockClickFunc and toggleComp.disableNode then
    self:BindZ1Button(toggleComp.disableNode, lockClickFunc)
  end
end

function Binder:BindToScrollbarValue(owner, expOrFn)
  self:BindToRaw(function(data, v, o)
    owner:GetComponent(typeof(CS.UnityEngine.UI.Scrollbar)).value = v
  end, expOrFn)
end

function Binder:BindToScrollbarValueChange(owner, onChange)
  self:BindAction(function(onAction)
    if onAction then
      owner:GetComponent(typeof(CS.UnityEngine.UI.Scrollbar)).onValueChanged:AddListener(onAction)
    else
      owner:GetComponent(typeof(CS.UnityEngine.UI.Scrollbar)).onValueChanged:RemoveAllListeners()
    end
  end, onChange)
end

function Binder:BindToSliderValue(owner, expOrFn)
  if not owner then
    return
  end
  local sliderComp = owner:GetComponent(TYPEOF_Slider)
  if not sliderComp then
    return
  end
  self:BindToRaw(function(data, v, o)
    sliderComp.value = v
  end, expOrFn)
end

function Binder:SetSliderCurValue(owner, value)
  owner:GetComponent(TYPEOF_Slider).value = value
end

function Binder:BindToSliderMinValue(owner, expOrFn)
  self:BindToRaw(function(data, v, o)
    owner:GetComponent(TYPEOF_Slider).minValue = v
  end, expOrFn)
end

function Binder:BindToSliderMaxValue(owner, expOrFn)
  self:BindToRaw(function(data, v, o)
    owner:GetComponent(TYPEOF_Slider).maxValue = v
  end, expOrFn)
end

function Binder:SetSliderMaxValue(owner, value)
  owner:GetComponent(TYPEOF_Slider).maxValue = value
end

function Binder:BindToSliderValueChange(owner, onChange)
  self:BindAction(function(onAction)
    if onAction then
      owner:GetComponent(TYPEOF_Slider).onValueChanged:AddListener(onAction)
    else
      owner:GetComponent(TYPEOF_Slider).onValueChanged:RemoveAllListeners()
    end
  end, function(...)
    if onChange then
      onChange(...)
    end
  end)
end

function Binder:BindToSlider(owner, onChange, minExpOrFn, maxExpOrFn)
  if onChange then
    self:BindToSliderValueChange(owner, onChange)
  end
  if minExpOrFn then
    self:BindToSliderMinValue(owner, minExpOrFn)
  end
  if maxExpOrFn then
    self:BindToSliderMaxValue(owner, maxExpOrFn)
  end
end

function Binder:BindToScrollRectValueChange(owner, onChange)
  self:BindAction(function(onAction)
    if onAction then
      owner:GetComponent(TYPEOF_ScrollRect).onValueChanged:AddListener(onAction)
    else
      owner:GetComponent(TYPEOF_ScrollRect).onValueChanged:RemoveAllListeners()
    end
  end, onChange)
end

function Binder:GetPreferredSize(owner)
  do return owner:GetComponent(typeof(CS.ContentSizeCalc)).GetPreferredSize end
  return owner:GetComponent(typeof(CS.ContentSizeCalc)).GetPreferredSize, owner:GetComponent(typeof(CS.ContentSizeCalc)), typeof(CS.ContentSizeCalc)
end

function Binder:GetPreferredSizeNew(owner)
  do return owner:GetComponent(typeof(CS.ContentSizeCalc)).GetPreferredSizeNew end
  return owner:GetComponent(typeof(CS.ContentSizeCalc)).GetPreferredSizeNew, owner:GetComponent(typeof(CS.ContentSizeCalc)), typeof(CS.ContentSizeCalc)
end

local shaderPropertyIdCache = {}

local function ShaderPropertyNameToId(propertyName)
  local id = shaderPropertyIdCache[propertyName]
  if nil == id then
    id = CS.UnityEngine.Shader.PropertyToID(propertyName)
    shaderPropertyIdCache[propertyName] = id
  end
  return id
end

function Binder:BindToMeshTexture(owner, expOrFn)
  self:BindToRaw(function(_, v, _)
    local material = owner:GetComponent(typeof(CS.UnityEngine.MeshRenderer)).sharedMaterial
    local sprite = self:LoadAsset(v)
    material:SetTexture(ShaderPropertyNameToId("_Texture"), sprite.texture)
  end, expOrFn)
end

function Binder:BindToRendererTexture(owner, expOrFn, propertyName)
  self:BindToRaw(function(_, v, _)
    local material = owner:GetComponent(typeof(CS.UnityEngine.UI.Image)).material
    local sprite = self:LoadAsset(v)
    local texture = sprite.texture or sprite
    material:SetTexture(ShaderPropertyNameToId(propertyName), texture)
  end, expOrFn)
end

function Binder:SetRendererTexture(owner, texturePath, propertyName)
  local material = owner:GetComponent(typeof(CS.UnityEngine.UI.Image)).material
  local sprite = self:LoadAsset(texturePath)
  local texture = sprite.texture or sprite
  material:SetTexture(ShaderPropertyNameToId(propertyName), texture)
end

function Binder:BindToMeshShaderTexture(owner, expOrFn, shadertexture)
  self:BindToRaw(function(_, v, _)
    if not v or "" == v then
      return
    end
    local material = owner:GetComponent(typeof(CS.UnityEngine.MeshRenderer)).sharedMaterial
    local sprite = self:LoadAsset(v)
    material:SetTexture(shadertexture, sprite.texture)
  end, expOrFn)
end

function Binder:SetMeshTexture(owner, path, shaderTexture)
  shaderTexture = shaderTexture or "_Texture"
  local id = ShaderPropertyNameToId(shaderTexture)
  local material = owner:GetComponent(typeof(CS.UnityEngine.MeshRenderer)).sharedMaterial
  local sprite = self:LoadAsset(path)
  material:SetTexture(id, sprite.texture)
end

local _cacheMap = {}

function Binder:UpdateLocalizedTextAndResouce(panelObj)
  if not panelObj then
    return
  end
  table.clear(_cacheMap)
  local langComps = panelObj:GetComponentsInChildren(typeof(CS.FrameWork.LangComp), true)
  for i = 0, langComps.Length - 1 do
    self:UpdatePanelStaticText(langComps[i], _cacheMap)
  end
  table.clear(_cacheMap)
  local uiExports = panelObj:GetComponentsInChildren(TYPEOF_UIExport, true)
  for i = 0, uiExports.Length - 1 do
    self:UpdateUIExportTextFont(uiExports[i], DataCenter.gameData.CurrTextLanguage, _cacheMap)
  end
end

function Binder:UpdateLocalizedSingle(panelObj)
  local langComp = panelObj:GetComponent(typeof(CS.FrameWork.LangComp))
  if langComp then
    self:UpdatePanelStaticText(langComp)
  end
  local uiExport = panelObj:GetComponent(TYPEOF_UIExport)
  if uiExport then
    self:UpdateUIExportTextFont(uiExport, DataCenter.gameData.CurrTextLanguage)
  end
end

function Binder:CheckUpdatePanelResource(panelObj, langCode)
  if not panelObj or not langCode then
    return
  end
  local uiExport = panelObj:GetComponent(TYPEOF_UIExport)
  if not uiExport then
    return
  end
  self:UpdateUIExportTextFont(uiExport, langCode)
end

function Binder:UpdateUIExportTextFont(uiExport, langCode, cachedMap)
  local langResList = uiExport:GetLangResList()
  if not langResList then
    return
  end
  local cnCode = "CN"
  local langIndex
  local emptyFontsName = LangManager.Instance:GetEmptyFontNames()
  local langRes, gameObject, langArr
  for i = 0, langResList.Count - 1 do
    langRes = langResList[i]
    gameObject, langArr = langRes.gameObject, langRes.langArr
    if not (langRes and gameObject) or not langArr then
    elseif cachedMap and cachedMap[gameObject] then
    else
      if cachedMap then
        cachedMap[gameObject] = true
      end
      if not langIndex then
        local cnIndex = 0
        for j = 0, langArr.Count - 1 do
          if string.startswith(langArr[j], langCode) then
            langIndex = j
            break
          end
          if string.startswith(langArr[j], cnCode) then
            cnIndex = j
          end
        end
        langIndex = langIndex or cnIndex
      end
      local resPathStr = langArr[langIndex]
      local compType = langRes.compType
      if "Text" == compType then
        local isTmp = true
        local textComp = gameObject:GetComponent(TYPEOF_TMP_Text)
        if not textComp then
          isTmp = false
          textComp = gameObject:GetComponent(TYPEOF_Text)
        end
        if not textComp then
        else
          local fontLangRes = LangManager.Instance:GetFontAssetByResString(resPathStr, langCode)
          local isTmpFont = string.endswith(resPathStr or "", "asset")
          local isMatch = isTmp == isTmpFont
          if fontLangRes and fontLangRes.font and isMatch then
            textComp.font = fontLangRes.font
          end
        end
      elseif "Image" == compType then
        local imageComp = gameObject:GetComponent(TYPEOF_Image)
        if nil == imageComp or imageComp.sprite then
        else
          local _, resPath = LangManager.GetResInfo(resPathStr)
          local sprite = self:LoadAsset(resPath)
          if sprite then
            imageComp.sprite = sprite
          end
        end
      end
    end
  end
end

function Binder:UpdatePanelStaticText(panelObj, cachedMap)
  if not panelObj then
    return
  end
  local langComp = panelObj:GetComponent(typeof(CS.FrameWork.LangComp))
  if not langComp then
    return
  end
  local textObjList = langComp:GetExportNodeList()
  local langUINode, obj, panelTextKey, textValue
  for i = 0, textObjList.Count - 1 do
    langUINode = textObjList[i]
    obj = langUINode and langUINode.gameObject
    if not obj or cachedMap and cachedMap[obj] then
    else
      if cachedMap then
        cachedMap[obj] = true
      end
      panelTextKey = langUINode.key
      textValue = ""
      local config = DT.PanelText[panelTextKey]
      if config then
        textValue = LT.Text(config.Content)
      else
        Logger.Warn("找不到界面文字配置:", panelTextKey)
      end
      self:SetText(obj, textValue)
    end
  end
end

function Binder:PlayAudioEffect(owner)
  do return UIAudioManager.Instance.PlayAudioEffect, UIAudioManager.Instance end
  return UIAudioManager.Instance.PlayAudioEffect, UIAudioManager.Instance, owner
end

function Binder:GetButtonPlayAudioEffectFunc(owner)
  if not UIAudioManager or not UIAudioManager.Instance then
    return
  end
  do return UIAudioManager.Instance.GetButtonPlayAudioEffectFunc, UIAudioManager.Instance end
  return UIAudioManager.Instance.GetButtonPlayAudioEffectFunc, UIAudioManager.Instance, owner
end

function Binder:GetTogglePlayAudioEffectFunc(owner)
  do return UIAudioManager.Instance.GetTogglePlayAudioEffectFunc, UIAudioManager.Instance end
  return UIAudioManager.Instance.GetTogglePlayAudioEffectFunc, UIAudioManager.Instance, owner
end

function Binder:BindDropdownChanged(owner, onChanged)
  self:BindAction(function(onAction, t)
    if onAction then
      owner:GetComponent(TYPEOF_Dropdown).onValueChanged:AddListener(onAction, t)
    else
      owner:GetComponent(TYPEOF_Dropdown).onValueChanged:RemoveAllListeners()
    end
  end, onChanged)
end

function Binder:SetAssetTarget(target)
  self:onDestroy(function()
    ResLoadMgr.UnloadAssetByTarget(self.__assetTarget)
    self.__assetTarget = nil
  end)
  self.__assetTarget = target
end

function Binder:GetAssetTarget()
  local target = self.__assetTarget
  local parent = self.parent
  while not target and parent do
    target = parent.__assetTarget
    parent = parent.parent
  end
  if not target then
    Logger.Warn(target, "没有找到 __assetTarget, 请检查是否调用了 Binder:SetAssetsTarget")
    target = self
    self:SetAssetTarget(self)
  end
  return target
end

function Binder:LoadAsset(path, assetType)
  local asset = ResLoadMgr.LoadAsset(path, self:GetAssetTarget(), assetType)
  return asset
end

function Binder:LoadAssetAsync(path, callback)
  do return ResLoadMgr.LoadAssetAsync, path, (self:GetAssetTarget()) end
  return ResLoadMgr.LoadAssetAsync, path, self:GetAssetTarget(), callback
end

function Binder:Instantiate(asset, parentTrans)
  local go = GameObject.Instantiate(asset, parentTrans)
  self:onDestroy(function()
    if not IsNil(go) then
      GameObject.Destroy(go)
    end
  end)
  return go
end

function Binder:BindToRotation(owner, expOrFn)
  local transform = owner.transform
  self:BindToRaw(function(_, n, o)
    if not n then
      return
    end
    transform.localRotation = n
  end, expOrFn)
end

function Binder:SetActive(owner, v)
  if IsNil(owner) then
    return
  end
  if owner.activeSelf ~= v then
    owner:SetActive(v)
  end
end

function Binder:BindToVisible(owner, expOrFn)
  self:BindToRaw(function(data, v, o)
    self:SetActive(owner, v)
  end, expOrFn)
end

function Binder:BindUIToModel(ui, model)
  local commFuncNames = {"GetBindCls"}
  for _, uiName in ipairs(ui.nameList) do
    local childUI = ui[uiName]
    if childUI then
      local bindClsFName = "GetBindClsOf" .. uiName
      if model[bindClsFName] then
        local cls = self:GetModelFuncValue(model, bindClsFName)
        local bindClsValueFName = "GetBindClsValueOf" .. uiName
        local values = self:GetModelFuncValue(model, bindClsValueFName) or {}
        if cls then
          self:BindComponent(cls(childUI, table.unpack(values)))
        end
      end
      local clickFName = "OnClick" .. uiName
      if model[clickFName] then
        local func = System.bind(model[clickFName], model)
        self:BindButtonClick(childUI, func)
      end
      local toggleFName = "OnToggle" .. uiName
      if model[toggleFName] then
        local func = System.bind(model[toggleFName], model)
        self:BindToZ1Toggle(childUI, nil, func)
      end
      local langIdFName = "GetLangIdOf" .. uiName
      if model[langIdFName] then
        local langId = self:GetModelFuncValue(model, langIdFName)
        self:SetText(childUI, LT.Text(langId, true))
      end
      local textFName = "GetTextOf" .. uiName
      if model[textFName] then
        local func = System.bind(model[textFName], model)
        self:BindToText(childUI, func)
      end
      local activeFName = "GetActiveOf" .. uiName
      if model[activeFName] then
        local func = System.bind(model[activeFName], model)
        self:BindToVisible(childUI, func)
      end
      local fillAmountFName = "GetFillAmountOf" .. uiName
      if model[fillAmountFName] then
        local func = System.bind(model[fillAmountFName], model)
        self:BindToImageFillAmount(childUI, func)
      end
      local imageFName = "GetImageOf" .. uiName
      if model[imageFName] then
        local func = System.bind(model[imageFName], model)
        self:BindToImage(childUI, func, true)
      end
    else
      Logger.Warn("控件不存在:" .. uiName)
    end
  end
end

function Binder:GetModelFuncValue(model, funcName)
  local func = funcName and model[funcName]
  local values = func and func(model)
  return values
end

function Binder:BindToMesh(owner, expOrFn, nativeSize)
  self:BindToRaw(function(data, n, o)
    if "" == n then
      return
    end
    owner:GetComponent(typeof(CS.UnityEngine.MeshRenderer)).material = self:LoadAsset(n)
    if nativeSize then
      owner:GetComponent(typeof(CS.UnityEngine.MeshRenderer)):SetNativeSize()
    end
  end, expOrFn)
end

local Language2FontPathDict = {
  JP = CommonRes.AllLangFontPathJP,
  KR = CommonRes.AllLangFontPathKR,
  TH = CommonRes.AllLangFontPathTH
}

function Binder:LoadAllLangFont(owner)
  if not owner then
    return
  end
  local textComp = owner:GetComponent(TYPEOF_TextMeshProUGUI)
  if not textComp then
    return
  end
  local targetResPath
  if DataCenter.gameData.CurrTextLanguage == "CN" then
    if string.contains(textComp.font.name, "BeiWeiKaiShu") then
      targetResPath = CommonRes.AllLangFontPathCNBWKS
    elseif string.contains(textComp.font.name, "XiaoBiaoSong") then
      targetResPath = CommonRes.AllLangFontPathCNXBS
    end
  elseif DataCenter.gameData.CurrTextLanguage == "TW" then
    if string.contains(textComp.font.name, "BeiWeiKaiShu") then
      targetResPath = CommonRes.AllLangFontPathTWBWKS
    elseif string.contains(textComp.font.name, "XiaoBiaoSong") then
      targetResPath = CommonRes.AllLangFontPathTWXBS
    end
  else
    targetResPath = Language2FontPathDict[DataCenter.gameData.CurrTextLanguage]
  end
  if not targetResPath then
    return
  end
  local fontAsset = ResLoadMgr.LoadAsset(targetResPath, self)
  if not fontAsset then
    return
  end
  textComp.font = fontAsset
  self:onDestroy(function()
    fontAsset = nil
    if not IsNil(textComp) then
      textComp.font = nil
    end
    ResLoadMgr.UnloadAssetByTarget(self)
  end)
end

return Binder
