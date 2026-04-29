_class("UIBreakStarPath", UICustomWidget)
UIBreakStarPath = UIBreakStarPath

function UIBreakStarPath:OnShow()
  self.btnPos = {
    [1] = {
      [1] = Vector2(81.6, 331.9)
    },
    [2] = {
      [1] = Vector2(-38, 172),
      [2] = Vector2(62, -137)
    },
    [3] = {
      [1] = Vector2(81.6, 331.9),
      [2] = Vector2(-99.99998, 71.40005),
      [3] = Vector2(99, -330.4)
    },
    [4] = {
      [1] = Vector2(-128.1, 331.7),
      [2] = Vector2(125.9, 117.8),
      [3] = Vector2(-94.5, -18.1),
      [4] = Vector2(-4, -330)
    },
    [5] = {
      [1] = Vector2(39.8, 343.6),
      [2] = Vector2(-114.3, 175.8),
      [3] = Vector2(144, 65.1),
      [4] = Vector2(106.9, -202.6),
      [5] = Vector2(-145, -341.5)
    },
    [6] = {
      [1] = Vector2(124.6, 336.8),
      [2] = Vector2(-17.7, 223.6),
      [3] = Vector2(190.6, 34.3),
      [4] = Vector2(71.2, -63.5),
      [5] = Vector2(-191.2, -114.1),
      [6] = Vector2(23.5, -335.9)
    }
  }
  self.leftorright = {
    [1] = {
      [1] = 2
    },
    [2] = {
      [1] = 1,
      [2] = 2
    },
    [3] = {
      [1] = 2,
      [2] = 1,
      [3] = 2
    },
    [4] = {
      [1] = 1,
      [2] = 2,
      [3] = 1,
      [4] = 1
    },
    [5] = {
      [1] = 2,
      [2] = 1,
      [3] = 2,
      [4] = 2,
      [5] = 1
    },
    [6] = {
      [1] = 2,
      [2] = 1,
      [3] = 2,
      [4] = 2,
      [5] = 1,
      [6] = 2
    }
  }
  self.transform = self:GetGameObject().transform
  local atlas = self:GetAsset("UIBreak.spriteatlas", LoadType.SpriteAtlas)
  self.sprites = {}
  self.sprites.passed = atlas:GetSprite("spirit_kuang6_frame")
  self.sprites.unReach = atlas:GetSprite("spirit_kuang8_frame")
  self.sprites.select = atlas:GetSprite("spirit_kuang7_frame")
  self.pathEff_factor = 10.0
  self.sprites.awakedPath = atlas:GetSprite("spirit_kuang19_frame")
  self.sprites.unAwakedPath = atlas:GetSprite("spirit_kuang20_frame")
  self.SelectBox = self:GetGameObject("SelectBox")
  self.pointPaths = {
    self:GetUIComponent("Image", "path1"),
    self:GetUIComponent("Image", "path2"),
    self:GetUIComponent("Image", "path3"),
    self:GetUIComponent("Image", "path4"),
    self:GetUIComponent("Image", "path5")
  }
  self.pointButtons = {
    self:GetUIComponent("RectTransform", "ButtonPoint1"),
    self:GetUIComponent("RectTransform", "ButtonPoint2"),
    self:GetUIComponent("RectTransform", "ButtonPoint3"),
    self:GetUIComponent("RectTransform", "ButtonPoint4"),
    self:GetUIComponent("RectTransform", "ButtonPoint5"),
    self:GetUIComponent("RectTransform", "ButtonPoint6")
  }
  self.attributes = {
    [1] = self:GetUIComponent("UISelectObjectPath", "Attribute1"),
    [2] = self:GetUIComponent("UISelectObjectPath", "Attribute2"),
    [3] = self:GetUIComponent("UISelectObjectPath", "Attribute3"),
    [4] = self:GetUIComponent("UISelectObjectPath", "Attribute4"),
    [5] = self:GetUIComponent("UISelectObjectPath", "Attribute5"),
    [6] = self:GetUIComponent("UISelectObjectPath", "Attribute6")
  }
  self.attributesGo = {
    [1] = self:GetGameObject("Attribute1"),
    [2] = self:GetGameObject("Attribute2"),
    [3] = self:GetGameObject("Attribute3"),
    [4] = self:GetGameObject("Attribute4"),
    [5] = self:GetGameObject("Attribute5"),
    [6] = self:GetGameObject("Attribute6")
  }
  self.effName = {}
  self.effName.path = "UIEff_UIAwakeController_lianxian.prefab"
  self.effName.onAwake = "UIEff_UIAwakeController_tupo.prefab"
  self.effName.awaked = "UIEff_UIAwakeController_xingxing_xiao.prefab"
  self.effName.next = "UIEff_UIAwakeController_xingxing_da.prefab"
  self.effName.back = "UIEff_UIAwakeController_xingxing_xiao_ht.prefab"
  self.effName.backAnim = "UIEff_UIAwakeController_huitui.prefab"
  self.effName.activeAnim = "UIEff_UIAwakeController_ht_sj.prefab"
  self.effName.canBreak = "UIEff_UIAwakeController_xingxing_ketupo.prefab"
  self.resReqs = {}
  self.effs = {}
  self.effs.star = {}
  self.effs.backStar = {}
  self.effs.path = {}
  self.effs.onAwake = nil
  self.effs.preNext = nil
  self.effs.backAnim = {}
  self.effs.activeAnim = {}
  self.selectPoint = -1
  AudioHelperController.RequestUISound(CriAudioIDConst.SoundAwakeStarEffect)
  AudioHelperController.RequestUISound(CriAudioIDConst.SoundSelectAwakePoint)
  self._player = EZTL_Player:New()
  self._isShow = true
end

function UIBreakStarPath:OnHide()
  self._isShow = false
  if self.awakeEffTimer then
    GameGlobal.Timer():CancelEvent(self.awakeEffTimer)
    self.awakeEffTimer = nil
  end
  AudioHelperController.ReleaseUISoundById(CriAudioIDConst.SoundAwakeStarEffect)
  AudioHelperController.ReleaseUISoundById(CriAudioIDConst.SoundSelectAwakePoint)
end

function UIBreakStarPath:LoadEft(_name)
  local resReq = ResourceManager:GetInstance():SyncLoadAsset(_name, LoadType.GameObject)
  resReq.Obj.transform:SetParent(self.transform)
  resReq.Obj:SetActive(true)
  self.resReqs[#self.resReqs + 1] = resReq
  return resReq.Obj
end

function UIBreakStarPath:Init(curPoint, backPoint, totalCount, promoteData, _clickEvent)
  self.curPointIdx = curPoint
  self.curBackPoint = backPoint
  self.awakeCount = totalCount
  self.promoteData = promoteData
  local poss = self.btnPos[self.awakeCount]
  local leftorright = self.leftorright[self.awakeCount]
  for i = 1, 6 do
    if i <= self.awakeCount then
      self.pointButtons[i].anchoredPosition = poss[i]
      self.pointButtons[i].gameObject:SetActive(true)
    else
      self.pointButtons[i].gameObject:SetActive(false)
    end
  end
  self.pointImages = {}
  for i = 1, 6 do
    local image = self:GetUIComponent("Image", "ButtonPoint" .. i)
    self.pointImages[#self.pointImages + 1] = image
  end
  for i = 1, 6 do
    if not self.effs.star[i] then
      local eff = self:LoadEft(self.effName.awaked)
      eff.transform.localScale = Vector3(1, 1, 1)
      self.effs.star[i] = eff
    end
    self.effs.star[i].transform.position = self.pointButtons[i].position
    if not self.effs.backStar[i] then
      local eff = self:LoadEft(self.effName.back)
      eff.transform.localScale = Vector3(1, 1, 1)
      self.effs.backStar[i] = eff
    end
    self.effs.backStar[i].transform.position = self.pointButtons[i].position
    if i <= curPoint then
      if backPoint < i then
        self.effs.backStar[i]:SetActive(true)
        self.effs.star[i]:SetActive(false)
      else
        self.effs.star[i]:SetActive(true)
        self.effs.backStar[i]:SetActive(false)
      end
    else
      self.effs.star[i]:SetActive(false)
      self.effs.backStar[i]:SetActive(false)
    end
  end
  for i = 1, #self.pointPaths do
    if i < self.awakeCount then
      local path = self.pointPaths[i]
      path.gameObject:SetActive(true)
      if i < self.curPointIdx then
        path.sprite = self.sprites.awakedPath
      else
        path.sprite = self.sprites.unAwakedPath
      end
      local pos, rot, height = self:GetPathTransform(i)
      path.transform.position = pos
      path.transform.rotation = rot
      path.rectTransform.sizeDelta = Vector2(path.rectTransform.sizeDelta.x, height)
    else
      self.pointPaths[i].gameObject:SetActive(false)
    end
  end
  self.attWidget = {}
  for i = 1, #self.attributes do
    local att = self.attributes[i]
    local widget = att:SpawnObject("UIBreakPromotionItem")
    self.attWidget[i] = widget
    if i <= self.awakeCount then
      self.attributesGo[i]:SetActive(true)
      self.attWidget[i]:SetData(self.promoteData[i], leftorright[i])
      self.attributesGo[i]:GetComponent("RectTransform").anchoredPosition = poss[i]
    else
      self.attributesGo[i]:SetActive(false)
    end
  end
  if self.curPointIdx < self.awakeCount then
    if not self.effs.next then
      local nextEff = self:LoadEft(self.effName.next)
      nextEff.transform.localScale = Vector3(1, 1, 1)
      nextEff.transform.position = self.pointButtons[self.curPointIdx + 1].position
      self.effs.next = nextEff
    else
      self.effs.next:SetActive(true)
    end
    self:OnSelected(self.curPointIdx + 1)
  else
    if self.effs.next then
      self.effs.next:SetActive(false)
    end
    self:OnSelected(self.awakeCount)
  end
  self.ClickEvent = _clickEvent
  self:RefreshPaths()
end

function UIBreakStarPath:ShowBreakBackAnim(active, pos)
end

function UIBreakStarPath:InitAgain(curPoint, backPoint, totalCount, promoteData)
  self.curPointIdx = curPoint
  self.curBackPoint = backPoint
  self.awakeCount = totalCount
  self.promoteData = promoteData
  local poss = self.btnPos[self.awakeCount]
  local leftorright = self.leftorright[self.awakeCount]
  for i = 1, 6 do
    if i <= self.awakeCount then
      self.pointButtons[i].anchoredPosition = poss[i]
      self.pointButtons[i].gameObject:SetActive(true)
    else
      self.pointButtons[i].gameObject:SetActive(false)
    end
  end
  for i = 1, 6 do
    if not self.effs.star[i] then
      local eff = self:LoadEft(self.effName.awaked)
      eff.transform.localScale = Vector3(1, 1, 1)
      self.effs.star[i] = eff
    end
    self.effs.star[i].transform.position = self.pointButtons[i].position
    if not self.effs.backStar[i] then
      local eff = self:LoadEft(self.effName.back)
      eff.transform.localScale = Vector3(1, 1, 1)
      self.effs.backStar[i] = eff
    end
    self.effs.backStar[i].transform.position = self.pointButtons[i].position
    if i <= curPoint then
      if backPoint < i then
        self.effs.backStar[i]:SetActive(true)
        self.effs.star[i]:SetActive(false)
      else
        self.effs.star[i]:SetActive(true)
        self.effs.backStar[i]:SetActive(false)
      end
    else
      self.effs.star[i]:SetActive(false)
      self.effs.backStar[i]:SetActive(false)
    end
  end
  for i = 1, #self.pointPaths do
    if i < self.awakeCount then
      local path = self.pointPaths[i]
      path.gameObject:SetActive(true)
      if i < self.curPointIdx then
        path.sprite = self.sprites.awakedPath
      else
        path.sprite = self.sprites.unAwakedPath
      end
      local pos, rot, height = self:GetPathTransform(i)
      path.transform.position = pos
      path.transform.rotation = rot
      path.rectTransform.sizeDelta = Vector2(path.rectTransform.sizeDelta.x, height)
    else
      self.pointPaths[i].gameObject:SetActive(false)
    end
  end
  self.attWidget = {}
  for i = 1, #self.attributes do
    local att = self.attributes[i]
    local widget = att:SpawnObject("UIBreakPromotionItem")
    self.attWidget[i] = widget
    if i <= self.awakeCount then
      self.attributesGo[i]:SetActive(true)
      self.attWidget[i]:SetData(self.promoteData[i], leftorright[i])
      self.attributesGo[i]:GetComponent("RectTransform").anchoredPosition = poss[i]
    else
      self.attributesGo[i]:SetActive(false)
    end
  end
  if self.curPointIdx < self.awakeCount then
    if not self.effs.next then
      local nextEff = self:LoadEft(self.effName.next)
      nextEff.transform.localScale = Vector3(1, 1, 1)
      nextEff.transform.position = self.pointButtons[self.curPointIdx + 1].position
      self.effs.next = nextEff
    else
      self.effs.next:SetActive(true)
      self.effs.next.transform.position = self.pointButtons[self.curPointIdx + 1].position
    end
    self:OnSelected(self.curPointIdx + 1)
  else
    if self.effs.next then
      self.effs.next:SetActive(false)
    end
    self:OnSelected(self.awakeCount)
  end
  self:RefreshPaths()
end

function UIBreakStarPath:RefreshBackOrActive(curPoint, backPoint, totalCount, promoteData)
  for i = 1, 6 do
    if not self.effs.backAnim[i] then
      local eff = self:LoadEft(self.effName.backAnim)
      eff.transform.localScale = Vector3(1, 1, 1)
      self.effs.backAnim[i] = eff
      eff:SetActive(false)
    end
    self.effs.backAnim[i].transform.position = self.pointButtons[i].position
    if not self.effs.activeAnim[i] then
      local eff = self:LoadEft(self.effName.activeAnim)
      eff.transform.localScale = Vector3(1, 1, 1)
      self.effs.activeAnim[i] = eff
      eff:SetActive(false)
    end
    self.effs.activeAnim[i].transform.position = self.pointButtons[i].position
  end
  if backPoint < self.curBackPoint then
    for i = backPoint + 1, self.curBackPoint do
      self.effs.backAnim[i]:SetActive(false)
      self.effs.backAnim[i]:SetActive(true)
    end
  else
    for i = self.curBackPoint + 1, backPoint do
      self.effs.activeAnim[i]:SetActive(false)
      self.effs.activeAnim[i]:SetActive(true)
    end
  end
  self.curPointIdx = curPoint
  self.curBackPoint = backPoint
  self.awakeCount = totalCount
  self.promoteData = promoteData
  for i = 1, 6 do
    if not self.effs.star[i] then
      local eff = self:LoadEft(self.effName.awaked)
      eff.transform.localScale = Vector3(1, 1, 1)
      self.effs.star[i] = eff
    end
    self.effs.star[i].transform.position = self.pointButtons[i].position
    if not self.effs.backStar[i] then
      local eff = self:LoadEft(self.effName.back)
      eff.transform.localScale = Vector3(1, 1, 1)
      self.effs.backStar[i] = eff
    end
    self.effs.backStar[i].transform.position = self.pointButtons[i].position
    if i <= curPoint then
      if backPoint < i then
        self.effs.backStar[i]:SetActive(true)
        self.effs.star[i]:SetActive(false)
      else
        self.effs.star[i]:SetActive(true)
        self.effs.backStar[i]:SetActive(false)
      end
    else
      self.effs.star[i]:SetActive(false)
      self.effs.backStar[i]:SetActive(false)
    end
  end
end

function UIBreakStarPath:RefreshAfterBreak(curPoint, backPoint, totalCount, promoteData)
  local oldPoint = self.curPointIdx + 1
  if self.curPointIdx == curPoint and self.curBackPoint ~= backPoint then
    self:RefreshBackOrActive(curPoint, backPoint, totalCount, promoteData)
    return
  end
  self.curPointIdx = curPoint
  self.curBackPoint = backPoint
  self.awakeCount = totalCount
  self.promoteData = promoteData
  local poss = self.btnPos[self.awakeCount]
  local leftorright = self.leftorright[self.awakeCount]
  for i = 1, 6 do
    if i <= self.awakeCount then
      self.pointButtons[i].gameObject:SetActive(true)
      self.pointButtons[i].anchoredPosition = poss[i]
    else
      self.pointButtons[i].gameObject:SetActive(false)
    end
  end
  for i = 1, #self.pointPaths do
    if i < self.awakeCount then
      local path = self.pointPaths[i]
      path.gameObject:SetActive(true)
      if i < self.curPointIdx then
        path.sprite = self.sprites.awakedPath
      else
        path.sprite = self.sprites.unAwakedPath
      end
      local pos, rot, height = self:GetPathTransform(i)
      path.transform.position = pos
      path.transform.rotation = rot
      path.rectTransform.sizeDelta = Vector2(path.rectTransform.sizeDelta.x, height)
    else
      self.pointPaths[i].gameObject:SetActive(false)
    end
  end
  self.attWidget = {}
  for i = 1, #self.attributes do
    local att = self.attributes[i]
    local widget = att:SpawnObject("UIBreakPromotionItem")
    self.attWidget[i] = widget
    if i <= self.awakeCount then
      self.attributesGo[i]:SetActive(true)
      self.attWidget[i]:SetData(self.promoteData[i], leftorright[i])
      self.attributesGo[i]:GetComponent("RectTransform").anchoredPosition = poss[i]
    else
      self.attributesGo[i]:SetActive(false)
    end
  end
  if self.curPointIdx < self.awakeCount then
    self:OnSelected(self.curPointIdx + 1)
  else
    self:OnSelected(self.awakeCount)
  end
  AudioHelperController.PlayRequestedUISound(CriAudioIDConst.SoundAwakeStarEffect)
  if self._player:IsPlaying() then
    self._player:Stop()
  end
  if not self.effs.onAwake then
    self.effs.onAwake = self:LoadEft(self.effName.onAwake)
    self.effs.onAwake.transform.localScale = Vector3(1, 1, 1)
  end
  if not self.effs.preNext then
    self.effs.preNext = self:LoadEft(self.effName.canBreak)
    self.effs.preNext.transform.localScale = Vector3(1, 1, 1)
  end
  local tls = {}
  tls[#tls + 1] = EZTL_Callback:New(function()
    if not self._isShow then
      return
    end
    GameGlobal.UIStateManager():Lock("UIBreakStarPath")
    self.effs.next:SetActive(false)
    self.effs.onAwake.transform.position = self.pointButtons[oldPoint].position
    self.effs.onAwake:SetActive(false)
    self.effs.onAwake:SetActive(true)
    if not self.effs.star[oldPoint] then
      local eff = self:LoadEft(self.effName.awaked)
      eff.transform.localScale = Vector3(1, 1, 1)
      self.effs.star[oldPoint] = eff
    end
    for i = 1, curPoint do
      local eff = self.effs.star[i]
      if not eff then
        eff = self:LoadEft(self.effName.awaked)
        self.effs.star[i] = eff
      end
      eff.transform.position = self.pointButtons[i].position
      if not self.effs.backStar[i] then
        local eff = self:LoadEft(self.effName.back)
        self.effs.backStar[i] = eff
      end
      self.effs.backStar[i].transform.position = self.pointButtons[i].position
      if i > self.curBackPoint then
        self.effs.backStar[i]:SetActive(false)
        self.effs.backStar[i]:SetActive(true)
      else
        eff:SetActive(false)
        eff:SetActive(true)
      end
    end
  end, "1.突破点播两个动效")
  if oldPoint < self.awakeCount then
    tls[#tls + 1] = EZTL_Wait:New(200, "2.等1秒")
    tls[#tls + 1] = EZTL_Callback:New(function()
      if not self._isShow then
        return
      end
      self.effs.preNext.transform.position = self.pointButtons[self.curPointIdx + 1].position
      self.effs.preNext:SetActive(false)
      self.effs.preNext:SetActive(true)
    end, "3.播过渡动画")
    tls[#tls + 1] = EZTL_Wait:New(1000, "4.等1秒")
    tls[#tls + 1] = EZTL_Callback:New(function()
      if not self._isShow then
        return
      end
      self.effs.preNext:SetActive(false)
      self.effs.next:SetActive(true)
      self.effs.next.transform.position = self.pointButtons[self.curPointIdx + 1].position
    end, "5.播可突破动效")
  end
  tls[#tls + 1] = EZTL_Callback:New(function()
    if not self._isShow then
      return
    end
    GameGlobal.UIStateManager():UnLock("UIBreakStarPath")
  end, "6.解锁屏幕")
  local tl = EZTL_Sequence:New(tls, "突破动画时间线")
  self._player:Play(tl)
  self:RefreshPaths()
end

function UIBreakStarPath:GetPathTransform(_idx)
  local from = self.pointButtons[_idx]
  local to = self.pointButtons[_idx + 1]
  local delta = to.position - from.position
  local pos = from.position + delta / 2
  local rot = Quaternion.FromToRotation(Vector3.up, delta)
  local height = Vector2.Distance(to.anchoredPosition, from.anchoredPosition)
  return pos, rot, height
end

function UIBreakStarPath:OnSelected(_num)
  if self.selectPoint > 0 and self.attWidget[self.selectPoint] then
    self.attWidget[self.selectPoint]:UnSelect()
  end
  self.attWidget[_num]:Select()
  self.selectPoint = _num
  self.SelectBox.transform.position = self.pointImages[_num].transform.position
  self:RefreshButtons()
end

function UIBreakStarPath:RefreshButtons()
  for i = 1, #self.pointImages do
    local image = self.pointImages[i]
    local eff = self.effs.star[i]
    image.raycastTarget = i ~= self.selectPoint
  end
end

function UIBreakStarPath:RefreshPaths()
  for i = 1, #self.pointPaths do
    if not self.effs.path[i] then
      local eff = self:LoadEft(self.effName.path)
      self.effs.path[i] = eff
    end
    local path = self.effs.path[i]
    if i < self.curPointIdx then
      local pos, rot, height = self:GetPathTransform(i)
      path.transform.position = pos
      path.transform.rotation = rot
      path.transform.localScale = Vector3(540, self.pathEff_factor * height, 540)
      path:SetActive(false)
      path:SetActive(true)
    else
      path:SetActive(false)
    end
  end
end

function UIBreakStarPath:PlayBreakEffect()
  AudioHelperController.PlayRequestedUISound(CriAudioIDConst.SoundAwakeStarEffect)
  if self._player:IsPlaying() then
    self._player:Stop()
  end
  if self.breakEff then
    self.breakEff:SetActive(false)
    self.breakEff:SetActive(true)
  else
    self.breakEff = self:LoadEft(self.effName.onAwake)
  end
  self.breakEff.transform.position = self.pointButtons[self.selectPoint].position
end

function UIBreakStarPath:OnSelectPathPoint(_num)
  AudioHelperController.PlayRequestedUISound(CriAudioIDConst.SoundSelectAwakePoint)
  self.ClickEvent(_num)
end

function UIBreakStarPath:ButtonPoint1OnClick(go)
  self:OnSelectPathPoint(1)
end

function UIBreakStarPath:ButtonPoint2OnClick(go)
  self:OnSelectPathPoint(2)
end

function UIBreakStarPath:ButtonPoint3OnClick(go)
  self:OnSelectPathPoint(3)
end

function UIBreakStarPath:ButtonPoint4OnClick(go)
  self:OnSelectPathPoint(4)
end

function UIBreakStarPath:ButtonPoint5OnClick(go)
  self:OnSelectPathPoint(5)
end

function UIBreakStarPath:ButtonPoint6OnClick(go)
  self:OnSelectPathPoint(6)
end
