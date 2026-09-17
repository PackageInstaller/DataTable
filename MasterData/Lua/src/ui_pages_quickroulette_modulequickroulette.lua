local this = class("moduleQuickRoulette", G_UIModuleBase)
local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
local maxCount = L_QuickRouletteStore.maxCount

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    list_mount = {
      moduleName = "pages/quickRoulette/cellQuickRoulette"
    },
    go_select = false,
    rot_select = L_Vector3.zero,
    rot_point = L_Vector3.zero,
    txt_center = "",
    activeSelect = false
  }
end

function this.methods()
  return {
    list_mount = {
      onClick_select = function(self, bind)
        self:emit("onClick_cell", bind.index)
      end
    }
  }
end

function this:open()
  L_QuickRouletteStore:listenCallFunc(L_QuickRouletteStore.event.rouletteDataUpdate, self.onEvent_refreshList, self)
end

function this:onHide()
  self.bind.activeSelect = false
end

function this:resetInfo()
  local current = CS.UnityEngine.InputSystem.Mouse.current
  if current then
    local height = Unity.Screen.height / 2
    local width = Unity.Screen.width / 2
    current:WarpCursorPosition(C_Vector2(width, height))
  end
  self._selectIndex = 0
  self:refreshInfo()
end

function this:close()
  L_QuickRouletteStore:unListenCallFunc(L_QuickRouletteStore.event.rouletteDataUpdate, self.onEvent_refreshList, self)
  self:closeDoTween()
end

function this:setSelectIndex(selectIndex)
  self:playChangeSelectAni(self._selectIndex, selectIndex)
  self._selectIndex = selectIndex
  self.bind.activeSelect = true
  self:refreshInfo(selectIndex)
end

function this:setData_roulette(type)
  self._type = type
  self:resetInfo()
  self:initDataList()
end

function this:setData_rouletteEdit(type)
  self._isEditMode = true
  self._type = type
  self:resetInfo()
  self:initDataList(true)
end

function this:initDataList(isInit)
  if not self.isListInit then
    self.isListInit = true
    isInit = true
  end
  if isInit then
    local tmp = {}
    for index = 1, maxCount do
      table.insert(tmp, {
        index = index,
        showSelect = not self._isEditMode
      })
    end
    self.bind.list_mount:clear()
    self.bind.list_mount:insert_array(tmp)
  else
    for i, v in pairs(self.modules.list_mount) do
      v:initCell()
    end
  end
end

function this:refreshInfo(selectIndex)
  selectIndex = selectIndex or self._selectIndex
  local info
  local guid = L_QuickRouletteStore:getGuidByIndex(selectIndex)
  if guid then
    info = L_QuickRouletteManager:getItemInfo(guid)
  end
  self.bind.txt_center = info and info.name or L_WordsTpl:getValue("ui_moduleQuickRoulette")
  local imgName = self._isEditMode and "UI/Texture/QuickRoulette/tex_quickroulette_bg_lp02.png" or "UI/Texture/QuickRoulette/tex_quickroulette_bg_lp01.png"
  self.bindComponents.bg_img:LoadSprite(imgName, false)
  local newPosX = self._isEditMode and -8 or 0
  L_Vector3.setAnchored(self.bindComponents.bg_img.transform, L_Vector3.getTemp(newPosX, 0, 0))
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
  local _, uiPos = _screenPosToUI(self.bindComponents.rect_petRoulette, C_Vector2(mousePosition.x, mousePosition.y), C_CameraManager.uiCamera)
  if isNearOrigin(uiPos, 60) then
    return
  end
  local deg = calculateDegree(uiPos)
  deg = adjustDegree(deg, maxCount)
  local curSelect = math.ceil(deg / (360 / maxCount))
  if self._selectIndex ~= curSelect then
    C_AudioManager.Play("Play_SFX_System_UI_MountRoulette_Tab_Slide")
    self._lastSelectIndex = self._selectIndex
    self:refreshInfo(curSelect)
  end
  self._selectIndex = curSelect
  self.bind.go_select = not math.isEmpty(self._selectIndex)
  if self.bind.go_select then
    self.bind.rot_select = L_Vector3.new(0, 0, (self._selectIndex - 1) * -45)
  end
  self.bind.rot_point = L_Vector3.new(0, 0, -(deg - 360 / maxCount / 2))
  self.bind.activeSelect = true
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

function this:onEvent_refreshList()
  self:initDataList()
  self:refreshInfo()
end

return this
