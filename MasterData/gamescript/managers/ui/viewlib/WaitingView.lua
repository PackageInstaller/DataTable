local WaitingView = NewClass("WaitingView")
local UnityTime = CS.UnityEngine.Time
WaitingView.Flag_Default = 0
WaitingView.Flag_BlockMsg = 100
WaitingView.Flag_LoadingView = 200
WaitingView.Flag_BattleSceneLoading = 300
WaitingView.Flag_Reconnected = 400
WaitingView.Flag_WarmUpShaders = 500
WaitingView.Flag_Logining = 600
WaitingView.Flag_SocialBatch = 700

function WaitingView:ctor()
  self.txtTips = nil
  self.timing = 0
  self.timeDelay = {}
  self.delayShowTime = 0
  self.timeouts = {}
  self.timeoutCounter = 0
  self.flags = {}
  self.openingFlags = {}
  self.tipsKey = {}
end

function WaitingView:Init()
  self:_TryCreateWaitingView()
  self.tipsKey[WaitingView.Flag_BlockMsg] = "NetBlockMaskTips"
  self.tipsKey[WaitingView.Flag_LoadingView] = "UIBlockMaskTips"
  self.tipsKey[WaitingView.Flag_Reconnected] = "ReConnect_1"
  self.tipsKey[WaitingView.Flag_BattleSceneLoading] = "NetBlockMaskTips"
  self.tipsKey[WaitingView.Flag_WarmUpShaders] = "CompilingShaders"
  self.tipsKey[WaitingView.Flag_Logining] = "SDKLogining"
  self.tipsKey[WaitingView.Flag_SocialBatch] = "NetBlockMaskTips"
  self.timeDelay[WaitingView.Flag_BlockMsg] = 1
  self.timeDelay[WaitingView.Flag_LoadingView] = 3
  self.timeDelay[WaitingView.Flag_Reconnected] = 2
  self.timeDelay[WaitingView.Flag_BattleSceneLoading] = 5
  self.timeDelay[WaitingView.Flag_WarmUpShaders] = 0
  self.timeDelay[WaitingView.Flag_Logining] = 2
  self.timeouts[WaitingView.Flag_Reconnected] = -1
  self.timeouts[WaitingView.Flag_BattleSceneLoading] = -1
  self.timeouts[WaitingView.Flag_WarmUpShaders] = -1
end

function WaitingView:SetTips(key)
  if not self.txtTips then
    return
  end
  self.txtTips.text = key and LT.Text(key) or ""
end

function WaitingView:Show(key, openFlag)
  openFlag = openFlag or WaitingView.Flag_Default
  self.openingFlags[openFlag] = self.openingFlags[openFlag] or 0
  self.openingFlags[openFlag] = self.openingFlags[openFlag] + 1
  self.flags[key] = true
  if 0 == self.timing then
    self.timing = 1
    if not self.gameObject.activeSelf then
      self.gameObject:SetActive(true)
      if self.canvasGroup then
        self.canvasGroup.alpha = 0
      end
    end
    self.delayShowTime = self.timeDelay[openFlag] or 1
  end
  self:_JudgeTips()
  self.gameObject.transform:SetAsLastSibling()
end

function WaitingView:ShowOnce(key, openFlag)
  openFlag = openFlag or WaitingView.Flag_Default
  if self:ContainsFlag(openFlag) then
    return
  end
  self:Show(key, openFlag)
end

function WaitingView:SetDelayShowTime(delayShowTime)
  self.delayShowTime = delayShowTime or 0
end

function WaitingView:Update()
  if 0 == self.timing then
    return
  end
  if 1 == self.timing then
    self.delayShowTime = self.delayShowTime - UnityTime.deltaTime
    if self.delayShowTime <= 0 then
      self.timing = 2
      if not self.gameObject.activeSelf then
        self.gameObject:SetActive(true)
      end
      if self.canvasGroup then
        self.canvasGroup.alpha = 1
      end
    end
  elseif 2 == self.timing then
    self.timeoutCounter = self.timeoutCounter + UnityTime.deltaTime
    if self.timeoutCounter >= self:_JudgeTimeout() then
      self:CancelAll()
    end
  end
end

function WaitingView:IsShowed()
  return table.length(self.flags) > 0
end

function WaitingView:Hide(key, openFlag)
  if IsNil(self.gameObject) then
    return
  end
  openFlag = openFlag or WaitingView.Flag_Default
  if self.openingFlags[openFlag] and self.openingFlags[openFlag] > 0 then
    self.openingFlags[openFlag] = self.openingFlags[openFlag] - 1
  end
  self:_JudgeTips()
  self.flags[key] = nil
  local num = table.length(self.flags)
  if 0 == num then
    self.gameObject:SetActive(false)
    self.timing = 0
    self.delayShowTime = 0
    self.timeoutCounter = 0
  end
end

function WaitingView:CancelAll()
  table.clear(self.flags)
  table.clear(self.openingFlags)
  if not IsNil(self.gameObject) then
    self.gameObject:SetActive(false)
  end
  self.timing = 0
  self.delayShowTime = 0
  self.timeoutCounter = 0
end

function WaitingView:ResetTimeout()
  self.timeoutCounter = 0
end

function WaitingView:Dispose()
  self:CancelAll()
  if not IsNil(self.gameObject) then
    CS.UnityEngine.GameObject.Destroy(self.gameObject)
  end
  self.gameObject = nil
  self.canvasGroup = nil
  ResLoadMgr.UnloadAssetByTarget(self)
end

function WaitingView:ContainsFlag(flag)
  return self.openingFlags ~= nil and self.openingFlags[flag] ~= nil and self.openingFlags[flag] > 0
end

function WaitingView:_TryCreateWaitingView()
  if self.gameObject then
    return
  end
  local mainAsset = ResLoadMgr.LoadAsset(CommonRes.UILoadingBlockMask, self)
  if not mainAsset then
    local root = UIManager.GetTopRoot()
    self.gameObject = CS.UnityEngine.GameObject("WaitingView")
    self.gameObject.transform:SetParent(root.transform, false)
    local img = self.gameObject:AddComponent(typeof(CS.UnityEngine.UI.Image))
    local rect = self.gameObject.transform
    img.color = CS.UnityEngine.Color(0, 0, 0, 0)
    rect.anchorMin = CS.UnityEngine.Vector2(0, 0)
    rect.anchorMax = CS.UnityEngine.Vector2(0, 0)
    rect.offsetMin = CS.UnityEngine.Vector2(-150, -150)
    rect.offsetMax = CS.UnityEngine.Vector2(-150, -150)
    self.gameObject:SetActive(false)
  else
    self.gameObject = GameObject.Instantiate(mainAsset)
    self.canvasGroup = self.gameObject:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
    self.txtTips = self.gameObject.transform:Find("Text_Desc"):GetComponent(typeof(CS.UnityEngine.UI.Text))
    self.canvasGroup.alpha = 0
    UIManager.Instance.binder:UpdateLocalizedTextAndResouce(self.gameObject)
    self.gameObject:SetActive(false)
  end
end

function WaitingView:_JudgeTips()
  local maxFlag = 0
  for flag, num in pairs(self.openingFlags) do
    if flag > maxFlag and num > 0 then
      maxFlag = flag
    end
  end
  self:SetTips(self.tipsKey[maxFlag])
end

function WaitingView:_JudgeTimeout()
  local maxTimeout = 0
  for flag, num in pairs(self.openingFlags) do
    if num > 0 then
      local t = self.timeouts[flag] or 20
      if t < 0 then
        t = math.huge
      end
      if maxTimeout < t then
        maxTimeout = t
      end
    end
  end
  return maxTimeout
end

WaitingView.Instance = WaitingView()
return WaitingView
