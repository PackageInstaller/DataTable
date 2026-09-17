local this = class("cellIconHomeBag", G_UIModuleBase)
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()

function this.bind()
  return {
    toggle_isEmpty = false,
    active_showQualityLine = true,
    img_iconFilter = "",
    img_icon = "",
    img_colorBg = "",
    img_color = "",
    txt_name = "",
    ani_cell = "",
    list_star = {},
    img_sel = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self._callback then
        self._callback()
      end
    end
  }
end

function this:open()
  self:refreshByItem(self._item, self._callback)
end

local itemData = {
  item_id = 0,
  build_id = 0,
  num = 0
}

function this:refreshByItem(itemData, cb, hideQualityLine)
  self._callback = cb
  self._item = itemData
  if not self.isBind then
    return
  end
  if self.bind.active_showQualityLine then
    self.bind.active_showQualityLine = not hideQualityLine
  end
  if itemData then
    self.bind.toggle_isEmpty = false
    local conf
    if itemData.item_id then
      conf = L_ItemTplManager:getCommonItem(itemData.item_id)
      local commonItemTpl = _commonItemTpl:getTplById(itemData.item_id)
      if self.bind.img_iconFilter then
        self.bind.img_iconFilter = _commonItemTpl:getFilterIcon(commonItemTpl)
      end
      if self.bind.list_star then
        local starNum = L_ItemTplManager:getItemShowStarNum(L_Const.resType.commonItem, itemData.item_id)
        self.bind.list_star:clear()
        self.bind.list_star:insert_array(L_DataUtil.getEmptyModuleDatas(starNum))
      end
    elseif itemData.build_id then
      conf = L_ItemTplManager:getBuildingItem(itemData.build_id)
    end
    if conf then
      self.bind.img_icon = conf.icon
      if self.bind.img_colorBg then
        self.bind.img_colorBg = string.format("UI/Atlas/CellIcon/tex_icon_raritybsqrtd_%s.png", conf.quality or 0)
      end
      if self.bind.img_color then
        self.bind.img_color = string.format("UI/Atlas/CellIcon/tex_icon_raritybsqrt_%s.png", conf.quality or 0)
      end
      self.bind.txt_name = tostring(itemData.num)
      self:playEndDragAnim()
      return
    end
  end
  self.bind.toggle_isEmpty = true
end

function this:getRaycastGo()
  if self.isBind then
    return self.bindComponents.button.gameObject
  end
end

function this:getTipPosition()
  if self.isBind then
    return self.bindComponents.node.position
  end
end

function this:setSelect(isSelect)
  self.bind.img_sel = isSelect
  self._isSelected = isSelect
end

function this:invokeDragAni(isRecover)
  if isRecover then
    if self.bind.ani_cell then
      self.bind.ani_cell = "anim_homebag_icon_unclick"
    end
  elseif self.bind.ani_cell then
    self.bind.ani_cell = "anim_homebag_icon_click"
  end
  self.bind.ani_cell = ""
end

function this:playAnim(animName)
  if self.bind.ani_cell then
    self.bind.ani_cell = animName
  end
end

function this:rewindAnim(animName)
  if not self.isBind then
    return
  end
  if self.bindComponents.anim then
    local animState = self:getAnimationStateByName(animName)
    if not animState then
      return
    end
    animState.normalizedTime = 1
    animState.speed = -1
    self.bindComponents.anim:Play(animName)
  end
end

function this:getAnimationStateByName(clipName)
  if not self.bindComponents.anim then
    return
  end
  for _, state in pairs(self.bindComponents.anim) do
    if state and state.name == clipName then
      return state
    end
  end
  return nil
end

function this:playDragAnim()
  self:playAnim("anim_homebag_icon_translucent")
end

function this:playEndDragAnim()
  self:playAnim("anim_homebag_icon_hide")
end

function this:setAlpha(value)
  local canvasGrp = self.gameObject.transform:GetComponent(typeof(C_CanvasGroup))
  if canvasGrp ~= nil then
    canvasGrp.alpha = value
  else
    C_MJLog.LogWarning("[VTS] 没有找到CanvasGroup组件")
  end
end

return this
