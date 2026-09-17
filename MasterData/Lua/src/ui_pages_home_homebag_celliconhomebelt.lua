local this = class("cellIconHomeBelt", G_UIModuleBase)
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _homeSeedTpl = L_GameTpl:getHomeSeedsTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()

function this.bind()
  return {
    active_none = false,
    active_content = false,
    active_select = false,
    img_icon = nil,
    img_iconFilter = nil,
    txt_num = nil,
    img_color = "",
    active_0 = false,
    ani_cell = "",
    active_lock = false,
    list_star = {}
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self.bind.onClickCell then
        self.bind.onClickCell()
      end
    end,
    onEnter = function(self)
      if self.bind.onEnterCell then
        self.bind.onEnterCell()
      end
    end,
    onExit = function(self)
      if self.bind.onExitCell then
        self.bind.onExitCell()
      end
    end,
    onPress = function(self)
      if self.bind.onPressCell then
        self.bind.onPressCell()
      end
    end
  }
end

function this:open()
  L_ShortCutManager:addShortKeyFlag(self, tostring(self.bind.index or 0), L_Const.AnchorType.Middle, self.bindComponents.shortKeyNode)
  self:refreshByItem(self._item)
end

function this:close()
  L_ShortCutManager:clearShortKeyFlag(self)
end

local itemData = {
  item_id = 0,
  build_id = 0,
  num = 0
}

function this:refreshByItem(itemData)
  itemData = itemData or {}
  self._item = itemData
  if not self.isBind then
    return
  end
  self.bind.img_iconFilter = ""
  local conf, condition = nil, L_Const.emptyTable
  if itemData.item_id then
    self._id = itemData.item_id
    conf = L_ItemTplManager:getCommonItem(self._id)
    local commonItemTpl = _commonItemTpl:getTplById(self._id)
    if commonItemTpl then
      self.bind.img_iconFilter = _commonItemTpl:getFilterIcon(commonItemTpl)
    end
    local starNum = L_ItemTplManager:getItemShowStarNum(L_Const.resType.commonItem, itemData.item_id)
    self.bind.list_star:clear()
    self.bind.list_star:insert_array(L_DataUtil.getEmptyModuleDatas(starNum))
    local tpl = _homeSeedTpl:getSeedTplByItem(self._id)
    if tpl then
      condition = _homeSeedTpl:getCondition(tpl)
    end
  elseif itemData.build_id then
    self._id = itemData.build_id
    conf = L_ItemTplManager:getBuildingItem(self._id)
  end
  if conf then
    self.bind.active_content = true
    self.bind.active_none = false
    self.bind.img_icon = conf.icon
    self.bind.txt_num = tostring(itemData.num)
    self.bind.img_color = itemData.build_id and "" or "UI/Atlas/HomeCrop/tex_homeplant_bg_rarity_" .. conf.quality
    self.bind.active_0 = itemData.num == 0
    self.bind.active_lock = not L_ConditionManager:isComplete(condition)
    self._isEmpty = false
  else
    self.bind.active_content = false
    self.bind.active_none = true
    self._isEmpty = true
  end
  self:refreshSelect()
end

function this:getRaycastGo()
  if self.isBind then
    return self.bindComponents.button.gameObject
  end
end

function this:setSelect(state)
  self._select = state
  self:refreshSelect()
end

function this:refreshSelect()
  self.bind.active_select = self._select and not self.bind.active_0
end

function this:invokeDragAni()
  self.bind.ani_cell = "anim_homebelt_icon_click"
  self.bind.ani_cell = ""
end

function this:invokeContentAni()
  self.bind.ani_cell = "anim_homebelt_icon_unclick"
  self.bind.ani_cell = ""
end

function this:invokeResetAni()
  self.bind.ani_cell = "anim_homebelt_icon_reset"
  self.bind.ani_cell = ""
end

function this:isEmpty()
  return self._isEmpty
end

function this:getId()
  return self._id
end

function this:setAlpha(value)
  local canvasGrp = self.gameObject.transform:GetComponent(typeof(C_CanvasGroup))
  canvasGrp.alpha = value
end

return this
