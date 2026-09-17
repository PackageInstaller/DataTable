local this = class("cellBuffElement", G_UIModuleBase)
local _buffInfoTpl = L_GameTpl:getBuffInfoTpl()

function this.bind()
  return {
    txt_num = "",
    img_buff = "",
    img_mask = "",
    go_buff = false,
    endTime = "",
    endFiled = 0,
    ani_name = "",
    ani_flash_name = "",
    goAddNum = false,
    txt_addNum = "",
    goContent = false
  }
end

function this.methods()
  return {
    onPoint_Enter = function(self)
      local elementConfigId = self.element.config.elementConfigId
      local elementType = self.element.config.elementType
      local elementLayer = self.element:GetLayerType()
      self:emit("onEnter", elementConfigId, elementType, elementLayer)
    end,
    onPoint_Leave = function(self)
      self:emit("onLeave")
    end
  }
end

function this:open()
  self._buffNum = 0
  self.element = self.bind.element
  if self.bind.isNew then
    local elementConfigId = self.bind.element.config.elementConfigId
    local tpl = _buffInfoTpl:getTplById(elementConfigId)
    local type = _buffInfoTpl:getType(tpl)
    self.bind.ani_name = type == L_Const.buffType.buff and "anim_battle_buffElement_buff_show" or "anim_battle_buffElement_debuff_show"
  end
  self:refreshLocalBuff()
end

function this:refresh()
  if self.bind.addNum then
    self.bind.goAddNum = true
    self.bind.txt_addNum = string.concat("+", self.bind.addNum)
    if self._buffNum ~= self.bind.addNum then
      self._buffNum = self.bind.addNum
      self.bindComponents.addAni:Play("anim_battle_buff_addNum", CS.UnityEngine.PlayMode.StopAll)
    end
    return
  end
  if self._buffNum > 0 then
    self._buffNum = 0
  end
  if not self.element or self.element.free then
    return
  end
  self.curLayer = self.element.numberLayers
  if self.element.combineType == CS.Lens.Gameplay.Modules.BigWorld.ECombineType.Overlying then
    self.bind.txt_num = tostring(self.curLayer)
  else
    self.bind.txt_num = ""
  end
  local elementConfigId = self.element.config.elementConfigId
  local tpl = _buffInfoTpl:getTplById(elementConfigId)
  if not tpl then
    return
  end
  self.bind.go_buff = true
  local icon = _buffInfoTpl:getIcon(tpl)
  self.bind.img_buff = icon
  self.bind.img_mask = icon
end

function this:refreshLocalBuff()
  if self.bind.addNum then
    self.bind.goAddNum = true
    self.bind.txt_addNum = string.concat("+", self.bind.addNum)
    self.bind.goContent = false
    if self._buffNum ~= self.bind.addNum then
      self._buffNum = self.bind.addNum
      self.bindComponents.addAni:Play("anim_battle_buff_addNum", CS.UnityEngine.PlayMode.StopAll)
    end
    return
  end
  if self._buffNum > 0 then
    self._buffNum = 0
  else
    self.bind.goContent = true
    self.bind.goAddNum = false
  end
  if self.element == nil or self.element.free then
    return
  end
  self.curLayer = self.element.numberLayers
  if self.element.combineType == CS.Lens.Gameplay.Modules.BigWorld.ECombineType.Overlying then
    self.bind.txt_num = tostring(self.curLayer)
  else
    self.bind.txt_num = ""
  end
  local endTime = self.element.endTime
  local checkTime = endTime - C_TimeManager.localTime
  self.bind.endTime = self.element.forever and "" or string.concat(math.ceil(checkTime), "s")
  if math.ceil(checkTime) > 3 or self.element.forever then
    self.bind.ani_flash_name = "anim_battle_buffElement_flash_init"
  elseif self.bind.ani_flash_name ~= "anim_battle_buffElement_flash" then
    self.bind.ani_flash_name = "anim_battle_buffElement_flash"
  end
  if checkTime <= 0 then
    return true
  end
  return false
end

return this
