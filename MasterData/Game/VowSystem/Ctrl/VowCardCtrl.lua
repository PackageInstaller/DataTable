local base = require("Game.VowSystem.Ctrl.VowCtrlBase")
local VowCardCtrl = class("VowCardCtrl", base)
local util = require("XLua.Common.xlua_util")
local UINVowCard = require("Game.VowSystem.UI.UINVowCard")
local CS_RenderTexture = CS.UnityEngine.RenderTexture
local cs_WaitForEndOfFrame = CS.UnityEngine.WaitForEndOfFrame
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_PhysicsUtility = CS.PhysicsUtility
local cs_array = CS.System.Array
local cs_bool = CS.System.Boolean
local cs_Collider = CS.UnityEngine.Collider
local lastX, lastY, indexOffset
local VowCardCtrlState = {
  Standby = 0,
  Signing = 1,
  WaitingConfirm = 2,
  CheckCard = 3,
  Leave = 4
}
local VowCardStateEnterFunc = {
  [VowCardCtrlState.Standby] = function(self, fromState)
    self:ClearVowCard()
    TimerManager:StopTimer(self._genTimer)
    TimerManager:StopTimer(self._specialGenTimer)
    TimerManager:StopTimer(self._cardFxTimer)
    self:SetVowCardSignNodeActive(true)
  end,
  [VowCardCtrlState.Signing] = function(self, fromState)
    self:VowCardSampleText(self._heroData:GetName())
    self:PlaySignVowCardFlipAnim(function()
      self:AddVowFingerListen()
    end)
  end,
  [VowCardCtrlState.CheckCard] = function(self, fromState)
    if fromState == VowCardCtrlState.WaitingConfirm or fromState == VowCardCtrlState.Signing then
      self:AddVowFingerListen()
      return
    else
      self:PlayReviewVowCardFlipAnim(function()
        self:AddVowFingerListen()
      end)
      self:__RefreshVowCardInCheckState()
    end
  end,
  [VowCardCtrlState.Leave] = function(self, fromState)
    if self.__leaveFunc ~= nil then
      self.__leaveFunc()
    end
    if not IsNull(self.vowCardNode) then
      self.vowCardNode:Delete()
    end
    DestroyUnityObject(self.vowCardGo)
    self:_ClearSampleCo()
    if not IsNull(self._sampleCamRt) then
      CS_RenderTexture.ReleaseTemporary(self._sampleCamRt)
      self._sampleCamRt = nil
    end
    TimerManager:StopTimer(self._genTimer)
    TimerManager:StopTimer(self._specialGenTimer)
    TimerManager:StopTimer(self._animTimer)
    TimerManager:StopTimer(self._reviewAnimTimer)
    TimerManager:StopTimer(self._signAnimTimer)
    TimerManager:StopTimer(self._cardFxTimer)
    self:SetVowCardSignNodeActive(true)
  end
}
local VowCardStateLeaveFunc = {
  [VowCardCtrlState.Signing] = function(self)
    self:RemoveVowFingerListen()
    self._isUserPainted = false
  end,
  [VowCardCtrlState.CheckCard] = function(self)
    self:RemoveVowFingerListen()
  end
}
local VowCardFingerDownFunc = {
  [VowCardCtrlState.Signing] = function(self, finger)
    if self._drawFingerIndex == nil then
      self._drawFingerIndex = finger.Index
    end
  end,
  [VowCardCtrlState.CheckCard] = function(self, finger)
    if self._bind.anim_Card.isPlaying then
      self._bind.anim_Card:Stop("UI_VowCardCheckIntro")
    end
  end
}
local VowCardFingerSetFunc = {
  [VowCardCtrlState.Signing] = function(self, finger)
    if self._drawFingerIndex ~= finger.Index then
      return
    end
    if self._signLoopAudio == nil then
      self._signLoopAudio = AudioManager:PlayAudioById(1285)
    end
    local hits = CS_PhysicsUtility.Raycast(self._bind.prefabCamera, 1 << LayerMask.Vow, false, finger.ScreenPosition)
    for i = 0, hits.Length - 1 do
      local hitCollider = hits[i].collider
      if not IsNull(hitCollider) then
        local uv = hits[i].textureCoord
        local curX = math.floor(uv.x * self._bind.card.widthCount)
        local curY = math.floor((1 - uv.y) * self._bind.card.heightCount)
        if lastX == nil then
          self:_TryAddPoint(curX, curY)
          lastX = curX
          lastY = curY
          break
        end
        for x = lastX, curX, lastX - curX < 0 and 1 or -1 do
          if lastX == curX then
          elseif lastY == curY then
            self:_TryAddPoint(x, curY)
          else
            local y = (x - lastX) * (curY - lastY) / (curX - lastX) + lastY
            self:_TryAddPoint(x, math.floor(y))
          end
        end
        for y = lastY, curY, lastY - curY < 0 and 1 or -1 do
          if lastX == curX then
            self:_TryAddPoint(curX, y)
          elseif lastY == curY then
          else
            local x = (y - lastY) * (curX - lastX) / (curY - lastY) + lastX
            self:_TryAddPoint(math.floor(x), y)
          end
        end
        lastX = curX
        lastY = curY
        break
      end
    end
    self._bind.card:RefreshPoint()
  end,
  [VowCardCtrlState.CheckCard] = function(self, finger)
    local screenDelta = finger.ScreenDelta
    local oldAngularMomentum = self.vowCardNode:GetAngularMomentum()
    if oldAngularMomentum.sqrMagnitude < 0.01 or screenDelta.sqrMagnitude > 10 then
      local angularMomentum = self:CalculateAngularMomentumBySwip(screenDelta)
      self.vowCardNode:SetAngularMomentum(angularMomentum)
    end
    local isRotToBack = self.vowCardNode:IsRotToBack()
    if not self.hasCheckCardStateEvolution and isRotToBack then
      self:StartVowCardGen(ConfigData.hero_vow_config.genCdCheck)
      self.hasCheckCardStateEvolution = true
    end
  end
}
local VowCardFingerUpFunc = {
  [VowCardCtrlState.Signing] = function(self, finger)
    if self._drawFingerIndex == finger.Index then
      self._drawFingerIndex = nil
      lastX = nil
      lastY = nil
    end
    if self._signLoopAudio ~= nil then
      AudioManager:StopAudioByBack(self._signLoopAudio)
      self._signLoopAudio = nil
    end
    if self._isUserPainted then
      self:RemoveVowFingerListen()
      self._bind.fX_VowCard_kapai:SetActive(true)
      AudioManager:PlayAudioById(1287)
      self:StartVowCardGen(ConfigData.hero_vow_config.genCdSign, function()
        self:__SetNewVowCardState(VowCardCtrlState.WaitingConfirm)
        local vowCardWindow = UIManager:GetWindow(UIWindowTypeID.VowCard)
        if vowCardWindow ~= nil then
          vowCardWindow:OnVowDrawOver()
        end
      end)
    end
  end,
  [VowCardCtrlState.CheckCard] = function(self, finger)
  end
}

function VowCardCtrl:_SetMatrix(matrixArray, x, y, alive)
  alive = alive or nil
  local index = x + y * self._width
  self:_SetMatrixByIndex(matrixArray, index, alive)
end

function VowCardCtrl:_SetMatrixByIndex(matrixArray, index, alive)
  alive = alive or nil
  if index < 0 or index >= self._arrayLength then
    return
  end
  matrixArray[index] = alive
end

function VowCardCtrl:_GetMatrix(matrixArray, x, y)
  local index = x + y * self._width
  return self:_GetMatrixByIndex(matrixArray, index)
end

function VowCardCtrl:_GetMatrixByIndex(matrixArray, index)
  if index < 0 or index >= self._arrayLength then
    return false
  end
  return matrixArray[index]
end

function VowCardCtrl:ctor()
  self.__onFingerSet = BindCallback(self, self._OnFingerSet)
  self.__onFingerDown = BindCallback(self, self._OnFingerDown)
  self.__onFingerUp = BindCallback(self, self._OnFingerUp)
  self._resLoader = CS.ResLoader.Create()
end

function VowCardCtrl:InitVowCardCtrl()
  self:__SetNewVowCardState(VowCardCtrlState.Standby)
end

function VowCardCtrl:InitVowCardGo(go)
  self.vowCardGo = go
  self._bind = {}
  UIUtil.LuaUIBindingTable(self.vowCardGo, self._bind)
  self._bind.sampleCam.enabled = false
  self.vowCardNode = UINVowCard.New()
  self.vowCardNode:Init(self._bind.obj_CardNode)
  self._width = self._bind.card.widthCount
  self._height = self._bind.card.heightCount
  self._arrayLength = self._height * self._width
  self._matrixArrayA = {}
  self._matrixArrayB = {}
  self._matrixArraySource = {}
  indexOffset = {
    -self._width - 1,
    -1,
    self._width - 1,
    -self._width,
    self._width,
    -self._width + 1,
    1,
    self._width + 1
  }
end

function VowCardCtrl:AddVowFingerListen()
  if self._isAddedListen then
    return
  end
  self._isAddedListen = true
  CS_LeanTouch.OnFingerSet("+", self.__onFingerSet)
  CS_LeanTouch.OnFingerDown("+", self.__onFingerDown)
  CS_LeanTouch.OnFingerUp("+", self.__onFingerUp)
end

function VowCardCtrl:RemoveVowFingerListen()
  if not self._isAddedListen then
    return
  end
  self._isAddedListen = false
  CS_LeanTouch.OnFingerSet("-", self.__onFingerSet)
  CS_LeanTouch.OnFingerDown("-", self.__onFingerDown)
  CS_LeanTouch.OnFingerUp("-", self.__onFingerUp)
end

function VowCardCtrl:StartVowCardGen(repeatCd, callback)
  self._isGening = true
  self:CopyVowMatrix(self._matrixArraySource, self:__GetVowCardShowingArray())
  TimerManager:StopTimer(self._cardFxTimer)
  self._cardFxTimer = TimerManager:StartTimer(10, function()
    self._bind.fX_VowCard_kapai:SetActive(false)
  end, self, true)
  if callback ~= nil then
    callback()
  end
  TimerManager:StopTimer(self._genTimer)
  self._genTimer = TimerManager:StartTimer(repeatCd, function()
    self:GenGameOfLife()
  end, self)
end

function VowCardCtrl:SetVowCardSignNodeActive(isActive)
  if self._bind == nil or self._bind.card == nil then
    return
  end
  self._bind.card.gameObject:SetActive(isActive)
end

function VowCardCtrl:StartVowCardSpecialGen(repeatCount)
  self:CopyVowMatrix(self._matrixArraySource, self:__GetVowCardShowingArray())
  local count = 0
  self:SetVowCardSignNodeActive(false)
  TimerManager:StopTimer(self._specialGenTimer)
  self._specialGenTimer = TimerManager:StartTimer(1, function()
    count = count + 1
    if count > repeatCount then
      TimerManager:StopTimer(self._specialGenTimer)
      self:SetVowCardSignNodeActive(true)
      return
    end
    self:GenGameOfLife()
  end, self, nil, true)
end

function VowCardCtrl:__RefreshVowCardInCheckState()
  self.hasCheckCardStateEvolution = false
  if not self._heroData:GetIsSetVowCard() then
    self:VowCardSampleText(self._heroData:GetName(), ConfigData:GetTipContent(14022))
  else
    self:DecodeVowSignData(self._matrixArraySource, self._heroData:GetVowSignData())
    self:StartVowCardSpecialGen(3)
  end
end

function VowCardCtrl:DecodeVowSignData(matrix, signData)
  for xValue, yMask in ipairs(signData) do
    for iMaskIndex = 0, self._height - 1 do
      local alive = 0 < yMask & 1 << iMaskIndex
      if alive then
        self:_SetMatrix(matrix, xValue, iMaskIndex, alive)
        self:_SetMatrixArrayValue(xValue, iMaskIndex, alive)
      end
    end
  end
  return matrix
end

function VowCardCtrl:EncodeVowSignData(signMatrix)
  self.signData = self.signData or {}
  table.clearmap(self.signData)
  for iX = 0, self._width - 1 do
    local mask = 0
    for iY = 0, self._height - 1 do
      local alive = self:_GetMatrix(signMatrix, iX, iY)
      if alive then
        mask = mask | 1 << iY
      end
    end
    table.insert(self.signData, mask)
  end
  return self.signData
end

function VowCardCtrl:CalculateAngularMomentumBySwip(swipeScreenDelta)
  local swipeFactor = 0.1
  if self.__CardAngularMomentum == nil then
    self.__CardAngularMomentum = Vector3.New(0, 0, 0)
  end
  self.__CardAngularMomentum.x = swipeScreenDelta.y * swipeFactor
  self.__CardAngularMomentum.y = -swipeScreenDelta.x * swipeFactor
  self.__CardAngularMomentum.z = 0
  return self.__CardAngularMomentum
end

function VowCardCtrl:__GetVowCardShowingArray()
  if self._isFlip then
    return self._matrixArrayA
  end
  return self._matrixArrayB
end

function VowCardCtrl:__GetVowCardBackUpArray()
  if self._isFlip then
    return self._matrixArrayB
  end
  return self._matrixArrayA
end

function VowCardCtrl:__SetNewVowCardState(newState)
  if self._currentState == newState then
    return
  end
  local prefState = self._currentState
  self._currentState = newState
  if VowCardStateLeaveFunc[prefState] ~= nil then
    VowCardStateLeaveFunc[prefState](self)
  end
  if VowCardStateEnterFunc[newState] ~= nil then
    VowCardStateEnterFunc[newState](self, prefState)
  end
end

function VowCardCtrl:SetVowEnterLeaveFunc(enterFunc, leaveFunc)
  self.__enterFunc = enterFunc
  self.__leaveFunc = leaveFunc
end

function VowCardCtrl:LoadAndSetCard(heroId, callback)
  self.__initCoroutine = GR.StartCoroutine(util.cs_generator(BindCallback(self, self.__LoadVowCardScene, VowCardCtrlState.Signing, heroId, callback)))
end

function VowCardCtrl:LoadAndCheckCard(heroId, callback)
  self.__initCoroutine = GR.StartCoroutine(util.cs_generator(BindCallback(self, self.__LoadVowCardScene, VowCardCtrlState.CheckCard, heroId, callback)))
end

function VowCardCtrl:PlayVowCardFlipAnim(callback)
  TimerManager:StopTimer(self._animTimer)
  self._bind.anim_Card:Play("VowCardPrefab")
  self._animTimer = TimerManager:StartTimer(1.5, callback, self, true)
end

function VowCardCtrl:PlayReviewVowCardFlipAnim(callback)
  TimerManager:StopTimer(self._reviewAnimTimer)
  self._bind.anim_Card:Play("UI_VowCardCheckIntro")
  self._reviewAnimTimer = TimerManager:StartTimer(1, callback, self, true)
end

function VowCardCtrl:PlaySignVowCardFlipAnim(callback)
  TimerManager:StopTimer(self._signAnimTimer)
  self._bind.anim_Card:Play("UI_VowCardSignIntro")
  self._signAnimTimer = TimerManager:StartTimer(1.5, callback, self, true)
end

function VowCardCtrl:ForceEnterVowCheckState()
  self:__RefreshVowCardInCheckState()
  if self._currentState ~= VowCardCtrlState.CheckCard then
    self:PlayVowCardFlipAnim(function()
      self:__SetNewVowCardState(VowCardCtrlState.CheckCard)
    end)
  end
  local vowCardWindow = UIManager:GetWindow(UIWindowTypeID.VowCard)
  if vowCardWindow ~= nil then
    vowCardWindow:OnVowChangeStateToConfirm()
  end
end

function VowCardCtrl:LeaveVowCard()
  self:__SetNewVowCardState(VowCardCtrlState.Leave)
  self:__SetNewVowCardState(VowCardCtrlState.Standby)
end

function VowCardCtrl:__LoadVowCardScene(afterLoadState, heroId, callback)
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData == nil then
    return
  end
  self._heroData = heroData
  UIUtil.AddOneCover("VowCardLoad", SafePack(nil, nil, nil, Color.clear, false))
  local path = PathConsts:GetVowPrefabPath("VowCardPrefab")
  local sceneWait = self._resLoader:LoadABAssetAsyncAwait(path)
  coroutine.yield(sceneWait)
  local go = sceneWait.Result:Instantiate()
  self:InitVowCardGo(go)
  if self.__enterFunc ~= nil then
    self.__enterFunc()
  end
  self:__SetNewVowCardState(afterLoadState)
  self.vowCardNode:InitVowCardNode(heroId)
  UIManager:ShowWindowAsync(UIWindowTypeID.VowCard, function(win)
    self._vowUiMain = win
    local hideWindowList = UIManager:HideAllWindow({
      [UIWindowTypeID.TopStatus] = true,
      [UIWindowTypeID.VowCard] = true
    })
    win:SetFromWhichUI(eBaseWinFromWhere.jumpCorver)
    win.jumpCorverArgs = {hideWinList = hideWindowList}
    if afterLoadState == VowCardCtrlState.Signing then
      win:InitVowCardMainWithSign(heroId, function()
        ControllerManager:GetController(ControllerTypeId.VowSystem, true):ReqVowSign(heroId, self:EncodeVowSignData(self._matrixArraySource))
        self:PlayVowCardFlipAnim(function()
          self:__SetNewVowCardState(VowCardCtrlState.CheckCard)
        end)
      end, function()
        self:RemoveVowFingerListen()
        self:__SetNewVowCardState(VowCardCtrlState.Standby)
        self:__SetNewVowCardState(VowCardCtrlState.Signing)
      end)
    else
      win:InitVowCardMainWithCheck(heroId)
    end
  end)
  while self._vowUiMain == nil do
    coroutine.yield(nil)
  end
  if callback ~= nil then
    callback()
  end
  UIUtil.CloseOneCover("VowCardLoad")
end

function VowCardCtrl:_SetMatrixArrayValue(x, y, alive)
  local index = x + (self._height - y - 1) * self._width
  local toPointValueArray = self._bind.card.ToPointValueArray
  if index < 0 or index >= toPointValueArray.Length then
    return
  end
  toPointValueArray[index] = alive and 1 or 0
end

function VowCardCtrl:VowCardSampleText(heroStr, userStr)
  self._bind.tex_HeroName.text = heroStr
  self._bind.tex_UserName.text = userStr or ""
  self._SampleTextCoFunc = self._SampleTextCoFunc or BindCallback(self, self._SampleTextCo)
  self:_ClearSampleCo()
  self._sampleCo = GR.StartCoroutine(util.cs_generator(self._SampleTextCoFunc))
end

function VowCardCtrl:_SampleTextCo()
  local scale = 2
  if self._sampleCamRt == nil then
    self._sampleCamRt = CS_RenderTexture.GetTemporary(self._width * scale, self._height * scale)
    self._bind.sampleCam.targetTexture = self._sampleCamRt
  end
  self._bind.sampleCam.enabled = true
  self._bind.sampleCam:Render()
  local waitForEndOfFrame = cs_WaitForEndOfFrame()
  coroutine.yield(waitForEndOfFrame)
  local matrix = self._bind.card:SampleMatrix(self._sampleCamRt, self._width, self._height)
  for x = 0, self._width - 1 do
    for y = 0, self._height - 1 do
      local show = matrix:GetValue(x, y)
      self:_SetMatrixArrayValue(x, y, show)
      self:_SetMatrix(self:__GetVowCardShowingArray(), x, y, show)
    end
  end
  self._bind.card:RefreshPoint()
  self:CopyVowMatrix(self:__GetVowCardShowingArray(), self._matrixArraySource)
  self._sampleCo = nil
end

function VowCardCtrl:_ClearSampleCo()
  if self._sampleCo ~= nil then
    GR.StopCoroutine(self._sampleCo)
    self._sampleCo = nil
  end
end

function VowCardCtrl:ClearVowCard()
  lastX = nil
  lastY = nil
  if IsNull(self._bind) then
    return
  end
  local toPointValueArray = self._bind.card.ToPointValueArray
  if not IsNull(toPointValueArray) then
    cs_array.Clear(toPointValueArray, 0, toPointValueArray.Length)
  end
  local showingArray = self:__GetVowCardShowingArray()
  if not IsNull(showingArray) then
    self:ClearVowMatrix(showingArray)
  end
  self._bind.card:RefreshPoint()
  self._bind.fX_VowCard_kapai:SetActive(false)
end

function VowCardCtrl:ClearVowMatrix(matrix)
  table.clearmap(matrix)
end

function VowCardCtrl:CopyVowMatrix(fromMatrix, toMatrix)
  self:ClearVowMatrix(toMatrix)
  for index, alive in pairs(fromMatrix) do
    if alive then
      toMatrix[index] = alive
    end
  end
end

function VowCardCtrl:GenGameOfLife()
  if self:__GetVowCardShowingArray() == nil then
    return
  end
  self._genedPoint = {}
  local backupArray = self:__GetVowCardBackUpArray()
  if not IsNull(backupArray) then
    self:ClearVowMatrix(backupArray)
  end
  for index, alive in pairs(self:__GetVowCardShowingArray()) do
    self:_GenSinglePoint(index)
    for iOffset = 1, #indexOffset do
      self:_GenSinglePoint(index + indexOffset[iOffset])
    end
  end
  self._bind.card:LerpTo(0.5)
  self._isFlip = not self._isFlip
end

function VowCardCtrl:_GetPosFromIndex(index)
  local x = index % self._width
  local y = index // self._width
  return x, y
end

function VowCardCtrl:_GenSinglePoint(index)
  if self._genedPoint[index] ~= nil then
    return
  end
  self._genedPoint[index] = true
  local curAlive = self:_GetMatrixByIndex(self:__GetVowCardShowingArray(), index)
  local liveAround = 0
  for iOffset = 1, #indexOffset do
    if self:_GetMatrixByIndex(self:__GetVowCardShowingArray(), index + indexOffset[iOffset]) then
      liveAround = liveAround + 1
    end
  end
  local aliveResult
  if curAlive then
    if liveAround < 2 then
      aliveResult = false
    elseif liveAround <= 3 then
      aliveResult = curAlive
    else
      aliveResult = false
    end
  else
    aliveResult = liveAround == 3
  end
  self:_SetMatrixByIndex(self:__GetVowCardBackUpArray(), index, aliveResult)
  local x, y = self:_GetPosFromIndex(index)
  self:_SetMatrixArrayValue(x, y, aliveResult)
end

function VowCardCtrl:_TryAddPoint(x, y)
  if 0 <= x and x < self._width and 0 <= y and y < self._height then
    local alive = self:_GetMatrix(self:__GetVowCardShowingArray(), x, y)
    if not alive then
      self._isUserPainted = true
      self:_SetMatrix(self:__GetVowCardShowingArray(), x, y, true)
      self:_SetMatrix(self._matrixArraySource, x, y, true)
      self:_SetMatrixArrayValue(x, y, true)
    end
  end
end

function VowCardCtrl:_OnFingerSet(finger)
  if finger == nil then
    return
  end
  if self._currentState == VowCardCtrlState.Signing or self._currentState == VowCardCtrlState.CheckCard then
    if UIManager:GetWindow(UIWindowTypeID.VowShowSkip) ~= nil then
      return
    end
  elseif finger.IsOverGui then
    return
  end
  if VowCardFingerSetFunc[self._currentState] ~= nil then
    VowCardFingerSetFunc[self._currentState](self, finger)
  end
end

function VowCardCtrl:_OnFingerDown(finger)
  if finger == nil then
    return
  end
  if self._currentState == VowCardCtrlState.Signing or self._currentState == VowCardCtrlState.CheckCard then
    if UIManager:GetWindow(UIWindowTypeID.VowShowSkip) ~= nil then
      return
    end
  elseif finger.IsOverGui then
    return
  end
  if VowCardFingerDownFunc[self._currentState] ~= nil then
    VowCardFingerDownFunc[self._currentState](self, finger)
  end
end

function VowCardCtrl:_OnFingerUp(finger)
  if finger == nil then
    return
  end
  if self._currentState == VowCardCtrlState.Signing or self._currentState == VowCardCtrlState.CheckCard then
    if UIManager:GetWindow(UIWindowTypeID.VowShowSkip) ~= nil then
      return
    end
  elseif finger.IsOverGui then
    return
  end
  if VowCardFingerUpFunc[self._currentState] ~= nil then
    VowCardFingerUpFunc[self._currentState](self, finger)
  end
end

function VowCardCtrl:Delete()
  if self._signLoopAudio ~= nil then
    AudioManager:StopAudioByBack(self._signLoopAudio)
    self._signLoopAudio = nil
  end
  self:__SetNewVowCardState(VowCardCtrlState.Leave)
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  self._matrixArrayA = nil
  self._matrixArrayB = nil
  self._matrixArraySource = nil
  base.Delete(self)
end

return VowCardCtrl
