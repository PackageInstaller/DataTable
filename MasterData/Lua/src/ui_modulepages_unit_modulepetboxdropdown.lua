local this = class("modulePetBoxDropdown", G_UIModuleBase)
local SelectIndexKeyStringEnums = {
  [L_PetConst.PetBoxFilterEnums.PetDuel] = "PetDuel",
  [L_PetConst.PetBoxFilterEnums.Formation] = "Formation"
}

function this.bind()
  return {
    txt_index = "",
    txt_name = "",
    list = {
      moduleName = "modulePages/unit/cellPetBoxDropdown"
    },
    activeDropdown = nil,
    activeLock = nil,
    activeArrowUp = nil,
    activeArrowDown = nil,
    focusIndex = nil
  }
end

function this.methods()
  return {
    onClickFold = function(self)
      self:onClickFold(not self._isDropdownOpen)
      self:playDropAudio()
    end,
    list = {
      onClick_select = function(self, index)
        if index ~= self.selectIndex then
          self.selectIndex = index
          self:refreshInfo()
          self:refreshSelect()
        end
      end
    }
  }
end

function this:playDropAudio()
  local audioKey = self._isDropdownOpen and "Play_SFX_System_UI_General_Drop_Open" or "Play_SFX_System_UI_General_Drop_Close"
  L_AudioUtil.playSound(audioKey)
end

function this:initPetBoxFilterModule(entranceEnum, callback)
  self.callback = callback
  self.keyString = string.format("%s_%s", L_PlayerStore:getPlayerId(), SelectIndexKeyStringEnums[entranceEnum])
  self.selectIndex = C_PlayerPrefsUtility.GetInt(self.keyString)
  if not self.selectIndex or self.selectIndex < 1 then
    self.selectIndex = 1
  end
  self:onClickFold(false)
  self:refreshInfo()
end

function this:initModuleByDefaultIndex(selectIndex, callback)
  self.callback = callback
  self.selectIndex = selectIndex
  self:onClickFold(false)
  self:refreshInfo()
end

function this:refreshInfoWithoutCallback(index)
  self:playContentTxtRefreshAnim(index > self.selectIndex)
  self.selectIndex = index
  self:refreshInfo(true)
end

function this:refreshInfo(ignore)
  self.selectIndex = self.selectIndex or 1
  if self.selectIndex < 1 then
    self.selectIndex = L_PetStore:getPetBoxNum()
  elseif self.selectIndex > L_PetStore:getPetBoxNum() then
    self.selectIndex = 1
  end
  if self.keyString then
    C_PlayerPrefsUtility.SetInt(self.keyString, self.selectIndex)
  end
  self.bind.txt_name = L_PetStore:getPetBoxName(self.selectIndex)
  self.bind.txt_index = string.format("%02d", self.selectIndex)
  self.bind.activeLock = false
  if self.callback and not ignore then
    self.callback(self.selectIndex)
  end
end

function this:onClickFold(isOn)
  self._isDropdownOpen = isOn
  self:playContentAnimation(self._isDropdownOpen)
  if self._isDropdownOpen then
    self:initDropDown()
  end
  self.bind.activeArrowUp = not self._isDropdownOpen
  self.bind.activeArrowDown = self._isDropdownOpen
  if self._isDropdownOpen then
    self.bind.focusIndex = self.selectIndex
  end
end

function this:playContentAnimation(isShow)
  if not self.isBind or not self.bindComponents.ani_content then
    return
  end
  self.bindComponents.ani_content:Stop()
  L_TimerManager:stopTimer(self, "onTimerHideDropdown")
  if isShow then
    self.bind.activeDropdown = true
    self.bindComponents.ani_content:Play("anim_filter_dropdown_petbox_show")
  else
    self.bindComponents.ani_content:Play("anim_filter_dropdown_petbox_hide")
    L_TimerManager:newOrResetTimer(self, "onTimerHideDropdown", function()
      if not self.isBind then
        return
      end
      self.bind.activeDropdown = false
    end, 0.2)
  end
end

function this:initDropDown()
  self.bind.list:clear()
  local datas = {}
  for i = 1, L_PetStore:getPetBoxNum() do
    local name = string.format("%02d %s", i, L_PetStore:getPetBoxName(i))
    local temp = {
      id = i,
      txt_name = name,
      txt_nameh = name,
      go_select = i == self.selectIndex,
      txt_name_h = i ~= self.selectIndex,
      txt_name_w = i == self.selectIndex,
      go_lock = false
    }
    table.insert(datas, temp)
  end
  self.bind.list:insert_array(datas)
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_content)
end

function this:refreshSelect()
  for i = 1, #self.bind.list do
    local id = self.bind.list:getValue(i, "id")
    local flag = id == self.selectIndex
    self.bind.list:change(i, {
      go_select = flag,
      txt_name_h = not flag,
      txt_name_w = flag
    })
  end
end

function this:open()
  self.onClickEvent = L_CommonUtil.handle(self.onScreenTouch_click, self)
  C_ScreenTouch.On_Touch("+", self.onClickEvent)
  C_ScreenTouch.OnUI_Touch("+", self.onClickEvent)
end

function this:unBind()
  if self.onClickEvent then
    C_ScreenTouch.On_Touch("-", self.onClickEvent)
    C_ScreenTouch.OnUI_Touch("-", self.onClickEvent)
    self.onClickEvent = nil
  end
  L_TimerManager:stopTimer(self, "onTimerHideDropdown")
end

function this:onScreenTouch_click(gesture)
  if not self.isBind or not self._isDropdownOpen then
    return
  end
  local isUI = Unity.RectTransformUtility.RectangleContainsScreenPoint(self.bindComponents.rect_content, gesture.position, C_CameraManager.uiCamera)
  if not isUI then
    local active = self.bind.activeDropdown
    self:onClickFold(false)
    if active then
      self:playDropAudio()
    end
  end
end

function this:playContentTxtRefreshAnim(isLeft)
  if not self.isBind or not self.bindComponents.ani_contentTxt then
    return
  end
  local animName = isLeft and "anim_filter_dropdown_petbox_left" or "anim_filter_dropdown_pebox_right"
  self.bindComponents.ani_contentTxt:Stop()
  self.bindComponents.ani_contentTxt:Play(animName)
end

return this
