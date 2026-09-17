local this = class("cellMapInteractive", G_UIModuleBase)

function this.bind()
  return {
    txt_key = L_WordsTpl:getValue("ui_cellMapInteractive"),
    img_icon = "",
    img_icon_complex = "",
    img_bg_complex = "",
    txt_content = "",
    active_light = false,
    ani_state = "",
    toggle_isPress = false,
    lock_icon = false,
    toggle_complexIcon = false,
    canvas_group = 1
  }
end

function this.methods()
  return {
    onUp = function(self)
      self:invokeClick()
    end
  }
end

function this:open(options)
  self.bind.txt_key = string.format("%s", L_SettingStore:getSetData(L_Const.settingType.interaction))
  self.bind.toggle_isPress = L_DeviceTpl:getIsPc()
  local nodeData = self.bind.nodeData
  local isLocked = false
  if self.bind.type == L_MapConst.mapSievingType.task or self.bind.type == L_MapConst.mapSievingType.taskNpc or self.bind.type == L_MapConst.mapSievingType.entrustTaskNpc then
    self.bindComponents.imgIcon.sizeDelta = C_Vector2(60, 60)
  end
  if self.bind.type == L_MapConst.mapSievingType.selfNode then
    self.bind.toggle_complexIcon = false
    self.bind.txt_content = nodeData.notes
    self.bind.img_icon = nodeData.icon
    isLocked = false
    self.bind.lock_icon = false
  elseif self.bind.type == L_MapConst.mapSievingType.boss then
    isLocked = nodeData.isUnLock == false and true or false
    self.bind.toggle_complexIcon = not string.isEmpty(nodeData.iconBg)
    if not AzurWorld.MapMgr:IsUnLockBossNodeByID(nodeData.id) then
      local _worldFilterMarkTpl = L_GameTpl:getWorldFilterMarkTpl()
      local tpl = _worldFilterMarkTpl:getTplById(9701)
      nodeData.name = _worldFilterMarkTpl:getName(tpl)
      nodeData.iconPath = "UI/Atlas/MapNode/tex_icon_mapnode_boss_sjbg.png"
      self.bindComponents.imgIcon.sizeDelta = C_Vector2(50, 50)
    end
    self.bind.txt_content = nodeData.name
    if string.isEmpty(nodeData.iconBg) then
      self.bind.img_icon = nodeData.iconPath
    else
      self.bind.img_icon_complex = nodeData.iconPath
      self.bind.img_bg_complex = nodeData.iconBg
    end
    self.bind.lock_icon = isLocked
  else
    isLocked = nodeData.isUnLock == false and true or false
    self.bind.toggle_complexIcon = not string.isEmpty(nodeData.iconBg)
    self.bind.txt_content = nodeData.name
    if string.isEmpty(nodeData.iconBg) then
      self.bind.img_icon = nodeData.iconPath
    else
      self.bind.img_icon_complex = nodeData.iconPath
      self.bind.img_bg_complex = nodeData.iconBg
    end
    self.bind.lock_icon = isLocked
  end
  if string.len(self.bind.txt_content) > 30 then
    self.bind.txt_name = string.format("%s...", string.sub(self.bind.txt_content, 1, 30))
  end
  if not isLocked then
    self.bind.canvas_group = 1
  end
  self._callback = self.bind.onClick
end

function this:killTween()
  if self._longPressTween then
    self._longPressTween:Kill()
    self._longPressTween = nil
  end
  L_TimerManager:clearTimer(self)
end

function this:close()
  self:killTween()
end

function this:invokeClick()
  if self._callback then
    self._callback()
  end
  return true
end

function this:refreshState()
  local isSelect = self.parent.selectedIndex == self.bind.index
  self.bind.ani_state = (isSelect or L_DeviceTpl:getIsMobile()) and "anim_interactive_select_init" or "anim_interactive_deselect_init"
  self.bind.active_light = isSelect and #self.parent.modules.list_button > 1
  local interData = self.bind
  if isSelect and interData ~= nil and interData.selectCb ~= nil then
    interData.selectCb()
  end
end

return this
