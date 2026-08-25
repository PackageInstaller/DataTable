local UIBlackScreenMgr = NewClass("UIBlackScreenMgr")
local UnityTime = CS.UnityEngine.Time

function UIBlackScreenMgr:ctor()
  self.timing = 0
  self.timeoutCounter = 0
  self.flags = {}
end

function UIBlackScreenMgr:Init()
  self:_TryCreateBlackScreenView()
end

function UIBlackScreenMgr:Show(key)
  key = key or self
  self.flags[key] = true
  if 0 == self.timing then
    self.timing = 1
    self.timeoutCounter = 0
    if not self.gameObject.activeSelf then
      self.gameObject:SetActive(true)
      if self.canvasGroup then
        self.canvasGroup.alpha = 1
      end
    end
  end
end

function UIBlackScreenMgr:Update()
  if 0 == self.timing then
    return
  end
  if 1 == self.timing then
    self.timeoutCounter = self.timeoutCounter + UnityTime.deltaTime
    if self.timeoutCounter >= 3 then
      self.timing = 0
      self:CancelAll()
    end
  end
end

function UIBlackScreenMgr:Hide(key)
  key = key or self
  self.flags[key] = nil
  if IsNil(self.gameObject) then
    return
  end
  local num = table.length(self.flags)
  if 0 == num then
    self.gameObject:SetActive(false)
    self.timing = 0
    self.timeoutCounter = 0
  end
end

function UIBlackScreenMgr:CancelAll()
  table.clear(self.flags)
  if not IsNil(self.gameObject) then
    self.gameObject:SetActive(false)
  end
  self.timing = 0
  self.timeoutCounter = 0
end

function UIBlackScreenMgr:RegisterToTimeline()
  if self.gameObject then
    CS.AMTimeline.AMResourcesCache.AddGameObject("BlackScreen", self.gameObject)
  end
end

function UIBlackScreenMgr:Dispose()
  self:CancelAll()
  if not IsNil(self.gameObject) then
    CS.UnityEngine.GameObject.Destroy(self.gameObject)
  end
  self.gameObject = nil
  self.canvasGroup = nil
  ResLoadMgr.UnloadAssetByTarget(self)
end

function UIBlackScreenMgr:_TryCreateBlackScreenView()
  if self.gameObject then
    return
  end
  local blackScreenAsset = ResLoadMgr.LoadAsset(CommonRes.AddtionalAssetList.BlackScreen, self)
  local blackScreenGo = CS.UnityEngine.GameObject.Instantiate(blackScreenAsset)
  blackScreenGo.name = "BlackScreenUI"
  blackScreenGo.transform.position = CS.UnityEngine.Vector3(0, 0, 0)
  blackScreenGo.transform.eulerAngles = CS.UnityEngine.Vector3(0, 0, 0)
  blackScreenGo:SetActive(false)
  self.gameObject = blackScreenGo
  self.canvasGroup = blackScreenGo:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
end

UIBlackScreenMgr.Instance = UIBlackScreenMgr()
return UIBlackScreenMgr
