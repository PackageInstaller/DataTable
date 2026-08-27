local cs_ResLoader = CS.ResLoader
local UIFightNamePlate = require("Game.Fight.Ui.SceneUI.UIFightNamePlate")
local UIFightVitalityBar = require("Game.Fight.Ui.SceneUI.UIFightVitalityBar")
local UIFightMainUserInfoNode = require("Game.Fight.Ui.UIFightMainUserInfoNode")
local DormFightConst = require("Game.Fight.DormFightConst")
local UIFightMain = class("UIFightMain", UIBaseWindow)

function UIFightMain:OnInit()
  self._resLoader = cs_ResLoader.Create()
  self._itemPools = {}
  self._itemPools[DormFightConst.SceneUiType.NamePlate] = UIItemPool.New(UIFightNamePlate, self.ui.obj_name)
  self._itemPools[DormFightConst.SceneUiType.VitalityBar] = UIItemPool.New(UIFightVitalityBar, self.ui.obj_hp)
  self._index = 0
  self._sceneUiMap = {}
  self._cameraZ = UIManager:GetUICamera().transform.position.z
  self._itemZ = self.ui.obj_hp.transform.position.z
  self._startCountdown = 0
  self._startTimer = nil
  self._displayCountdown = 0
  self._lastDragPosition = nil
  self._dragListener = nil
  UIUtil.AddButtonListener(self.ui.btn_attack, self, self.OnAttackBtnClick)
  UIUtil.AddButtonListener(self.ui.btn_weapon, self, self.OnAttackBtnClick)
  self.ui.btn_run.onPressDown:AddListener(BindCallback(self, self.OnRunBtnPressDown))
  self.ui.btn_run.onPressUp:AddListener(BindCallback(self, self.OnRunBtnPressUp))
  self.ui.joystick:onTouchMove("+", BindCallback(self, self.OnJoyStickMove))
  self.ui.joystick:onTouchUp("+", BindCallback(self, self.OnJoyStickUp))
end

function UIFightMain:ExitButtonClicked()
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight, true)
  dormFightCtrl:ExitScene()
end

function UIFightMain:OnAttackBtnClick()
  if self._attackCb ~= nil then
    self._attackCb()
  end
end

function UIFightMain:OnRunBtnPressDown()
  if self._pressDownRunningCb ~= nil then
    self._pressDownRunningCb()
  end
end

function UIFightMain:OnRunBtnPressUp()
  if self._pressUpRunningCb ~= nil then
    self._pressUpRunningCb()
  end
end

function UIFightMain:OnJoyStickMove(joyStickData)
  local radians = joyStickData.radians
  local radius = joyStickData.power
  local axisH = math.cos(radians) * radius
  local axisV = math.sin(radians) * radius
  if self._moveCb ~= nil then
    self._moveCb(axisH, axisV)
  end
end

function UIFightMain:OnJoyStickUp()
  if self._moveCb ~= nil then
    self._moveCb(0, 0)
  end
end

function UIFightMain:Bind(moveCb, pressDownRunningCb, pressUpRunningCb, attackCb)
  self._moveCb = moveCb
  self._pressDownRunningCb = pressDownRunningCb
  self._pressUpRunningCb = pressUpRunningCb
  self._attackCb = attackCb
end

function UIFightMain:ShowStartCountDown(countdown)
  if self._startTimer ~= nil then
    TimerManager:StopTimer(self._startTimer)
    self._startTimer = nil
  end
  self._startCountdown = countdown
  self._startTimer = TimerManager:StartTimer(1, self.OnStartCountDown, self, false, false, false)
  self.ui.txt_Start.gameObject:SetActive(true)
end

function UIFightMain:OnStartCountDown()
  self._startCountdown = self._startCountdown - 1
  if self._startCountdown > 0 then
    self:RefreshStartCountdownDisplay()
  else
    self.ui.txt_Start.gameObject:SetActive(false)
    TimerManager:StopTimer(self._startTimer)
    self._startTimer = nil
  end
end

function UIFightMain:RefreshStartCountdownDisplay()
  self.ui.txt_Start.text = tostring(self._startCountdown)
end

function UIFightMain:CreateSceneUi(sceneUiType)
  local itemPool = sceneUiType and self._itemPools[sceneUiType]
  if itemPool == nil then
    return -1
  end
  local item = itemPool:GetOne()
  self._index = self._index + 1
  self._sceneUiMap[self._index] = item
  return self._index
end

function UIFightMain:ClearAllSceneUi()
  for _, pool in pairs(self._itemPools) do
    pool:HideAll()
  end
  self._index = 0
  self._sceneUiMap = {}
end

function UIFightMain:UpdatePosition(index, screenPos)
  local item = self:GetSceneUi(index)
  if item == nil then
    return
  end
  local uiCamera = UIManager:GetUICamera()
  local dz = self._cameraZ - self._itemZ
  local worldPosition = uiCamera:ScreenToWorldPoint(screenPos)
  local ratio = dz / (self._cameraZ - worldPosition.z)
  item:SetPosition(Vector3.New(worldPosition.x * ratio, worldPosition.y * ratio, self._itemZ))
end

function UIFightMain:SetName(index, name)
  local item = self:GetSceneUi(index)
  if item == nil or item:GetSceneUiType() ~= DormFightConst.SceneUiType.NamePlate then
    return
  end
  item:SetName(name)
end

function UIFightMain:SetNamePlateStyle(index, isSelf)
  local item = self:GetSceneUi(index)
  if item == nil or item:GetSceneUiType() ~= DormFightConst.SceneUiType.NamePlate then
    return
  end
  item:SetSelfStyle(isSelf)
end

function UIFightMain:SetVitalityRatio(index, ratio)
  local item = self:GetSceneUi(index)
  if item == nil or item:GetSceneUiType() ~= DormFightConst.SceneUiType.VitalityBar then
    return
  end
  item:SetVitalityRatio(ratio)
end

function UIFightMain:ShowVitalityNode(index)
  local item = self:GetSceneUi(index)
  if item == nil or item:GetSceneUiType() ~= DormFightConst.SceneUiType.VitalityBar then
    return
  end
  item:ShowVitalityNode()
end

function UIFightMain:GetSceneUi(index)
  return index and self._sceneUiMap[index] or nil
end

function UIFightMain:SetUserInfo(comp, userInfo)
  local targetNode = comp == DormFightConst.DormFightComp.Myself and self._leftUserInfoNode or self._rightUserInfoNode
  targetNode:SetUserInfo(userInfo)
end

function UIFightMain:SetScore(comp, score, scoreMax)
  local targetNode = comp == DormFightConst.DormFightComp.Myself and self._leftUserInfoNode or self._rightUserInfoNode
  targetNode:SetScore(score, scoreMax)
end

function UIFightMain:SetCountdown(countdown)
  local displayCountdown = math.max(0, math.floor(countdown))
  if math.abs(self._displayCountdown - displayCountdown) < 1.0E-5 then
    return
  end
  self._displayCountdown = displayCountdown
  self.ui.txt_CountDown.text = tostring(displayCountdown)
end

function UIFightMain:SetCountdownVisible(visible)
  self.ui.obj_countdown:SetActive(visible)
end

function UIFightMain:OnMaskBeginDrag(go, eventData)
  self._lastDragPosition = eventData.position
end

function UIFightMain:OnMaskDragging(go, eventData)
  if self._lastDragPosition == nil then
    self._lastDragPosition = eventData.position
    return
  end
  local position = eventData.position
  local dx = self._lastDragPosition.x - position.x
  local dy = self._lastDragPosition.y - position.y
  self._lastDragPosition = position
  if self._dragListener ~= nil then
    pcall(self._dragListener, dx, dy)
  end
end

function UIFightMain:OnMaskEndDrag(go, eventData)
  self._lastDragPosition = nil
end

function UIFightMain:SetDragListener(listener)
  self._dragListener = listener
end

function UIFightMain:OnDelete()
  UIBaseWindow.OnDelete(self)
  if self._itemPools ~= nil then
    for _, pool in pairs(self._itemPools) do
      pool:DeleteAll()
    end
    self._itemPools = nil
  end
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  if self._leftUserInfoNode ~= nil then
    self._leftUserInfoNode:Dispose()
    self._leftUserInfoNode = nil
  end
  if self._rightUserInfoNode ~= nil then
    self._rightUserInfoNode:Dispose()
    self._rightUserInfoNode = nil
  end
end

return UIFightMain
