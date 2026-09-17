local this = class("moduleMountRoulette", G_UIModuleBase)
local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
local maxCount = 8

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    list_mount = {
      moduleName = "pages/mount/cellMountRoulette"
    },
    go_select = false,
    rot_select = L_Vector3.zero,
    rot_point = L_Vector3.zero
  }
end

function this.methods()
  return {
    list_mount = {
      onClick_select = function(self, bind)
        local guid = L_MountStore:getMountMap()[bind.index]
        if math.isEmpty(guid) then
          self:emit("onClick_empty", bind.index)
          return
        end
        if guid == L_MountStore:getEquipMountId() then
          if AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount() then
            self:emit("onClick_inMounting")
          else
            self:emit("onClick_equipped", bind.index)
          end
        else
          self:emit("onClick_notEquipped", bind.index)
        end
      end,
      onPointEnter_content = function(self)
        if not self.isInSelectSpace then
          C_AudioManager.Play("Play_SFX_System_UI_MountRoulette_Tab_Slide")
        end
        self.isInSelectSpace = true
      end,
      onPointExit_content = function(self)
        self.isInSelectSpace = false
      end
    }
  }
end

function this:open()
  local current = CS.UnityEngine.InputSystem.Mouse.current
  if current and not C_InputManager.IsEnableGamePad then
    local height = Unity.Screen.height / 2
    local width = Unity.Screen.width / 2
    current:WarpCursorPosition(C_Vector2(width, height))
  end
  self._selectIndex = 0
  self._ESyncMountRouletteServerDataHandler = handler(self, self.onEvent_refreshMount)
  AzurWorld.mountMgr:RegisterEvent(C_EMountEvent.ESyncMountRouletteServerData, self._ESyncMountRouletteServerDataHandler)
end

function this:close()
  self:closeDoTween()
  AzurWorld.mountMgr:UnregisterEvent(C_EMountEvent.ESyncMountRouletteServerData, self._ESyncMountRouletteServerDataHandler)
end

function this:setData_roulette()
  self:initMountList(true)
end

function this:setData_rouletteEdit(selectIndex)
  self._isEditMode = true
  self:setSelectIndex(selectIndex)
  self:initMountList(true)
end

function this:setSelectIndex(selectIndex)
  self:playChangeSelectAni(self._selectIndex, selectIndex)
  self._selectIndex = selectIndex
end

function this:initMountList(isInit)
  if isInit then
    local tmp = {}
    for index = 1, maxCount do
      table.insert(tmp, {index = index})
    end
    self.bind.list_mount:clear()
    self.bind.list_mount:insert_array(tmp)
  else
    for i, v in pairs(self.modules.list_mount) do
      v:initCell()
    end
  end
end

local function calculateDegree(uiPos)
  if uiPos.x == 0 then
    return 0 <= uiPos.y and 270 or 90
  else
    local rawDeg = math.atan(uiPos.y / uiPos.x) * (180 / math.pi)
    return uiPos.x >= 0 and (0 > uiPos.y and -rawDeg or 360 - rawDeg) or 180 - rawDeg
  end
end

local function adjustDegree(deg)
  deg = deg + 90 + 360 / maxCount / 2
  return 360 <= deg and deg - 360 or deg
end

local function isNearOrigin(pos, radius)
  return radius > math.abs(pos.x) and radius > math.abs(pos.y)
end

function this:update()
  local mousePosition = CS.UnityEngine.Input.mousePosition
  if C_InputManager.IsEnableGamePad then
    local stickPos = C_InputManager.GetRStickValue()
    if stickPos.x == 0 and stickPos.y == 0 then
      self._selectIndex = 0
      self.bind.go_select = false
      return
    end
    mousePosition = C_Vector2(C_Screen.width * (stickPos.x + 1.0) / 2.0, C_Screen.height * (stickPos.y + 1.0) / 2.0)
  end
  local _, uiPos = _screenPosToUI(self.bindComponents.rect_petRoulette, C_Vector2(mousePosition.x, mousePosition.y), C_CameraManager.uiCamera)
  local deg = calculateDegree(uiPos)
  deg = adjustDegree(deg, maxCount)
  if not isNearOrigin(uiPos, 2) then
    local curSelect = math.ceil(deg / (360 / maxCount))
    if self._selectIndex ~= curSelect and self._selectIndex ~= 0 then
      self.bindComponents.ani_petRouletteSelect:Stop()
      self.bindComponents.ani_petRouletteSelect:Play("anim_mountwheel_select")
      self._lastSelectIndex = self._selectIndex
    end
    self._selectIndex = curSelect
  end
  if not self.isInSelectSpace and not C_InputManager.IsEnableGamePad then
    self._selectIndex = 0
  end
  self.bind.go_select = not math.isEmpty(self._selectIndex)
  if self.bind.go_select then
    self.bind.rot_select = L_Vector3.new(0, 0, (self._selectIndex - 1) * -45)
  end
  self.bind.rot_point = L_Vector3.new(0, 0, -(deg - 360 / maxCount / 2))
end

function this:playChangeSelectAni(old, new)
  if not self._isEditMode then
    return
  end
  self.bind.go_select = not math.isEmpty(new)
  if math.isEmpty(new) or old == new then
    return
  end
  local startAngle = (old - 1) * -45
  local endAngle = (new - 1) * -45
  if math.isEmpty(old) and not math.isEmpty(new) then
    self.bind.rot_select = L_Vector3.new(0, 0, endAngle)
    self.bind.rot_point = L_Vector3.new(0, 0, endAngle)
    return
  end
  local difference = endAngle - startAngle
  difference = (difference + 180) % 360 - 180
  
  local function getter()
    return startAngle
  end
  
  local function setter(r)
    self.bind.rot_select = L_Vector3.new(0, 0, r)
    self.bind.rot_point = L_Vector3.new(0, 0, r)
  end
  
  self._doTween = DOTween.To(getter, setter, startAngle + difference, 0.4)
  self._doTween:SetEase(Tweening.Ease.OutCubic)
end

function this:closeDoTween()
  if L_CommonUtil.isValid(self._doTween) then
    self._doTween:Kill()
    self._doTween = nil
  end
end

function this:onEvent_refreshMount()
  self:initMountList()
  local mountMap = L_MountStore:getMountMap()
  if self._isEditMode and not math.isEmpty(mountMap[self._selectIndex]) then
    local newIndex = L_MountManager:getMinCanAddMountRoulettePos()
    self:emit("onClick_empty", newIndex)
  end
end

function this:getSelectIndex()
  return self._selectIndex
end

function this:determineRouletteTarget(targetIdx)
  for i, v in pairs(self.modules.list_mount) do
    if i == targetIdx then
      v.methods.onClick_select(v)
      break
    end
  end
end

return this
