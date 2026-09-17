local this = class("cellHomeEditBag", G_UIModuleBase)
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()

function this.bind()
  return {
    txt_name = "",
    txt_count = "",
    img_icon = "",
    active_0 = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      self:onClick()
    end,
    onEnter = function(self)
      if not math.isEmpty(self.bind.buildingId) then
        self.parent:onEnterItem(self.bind.buildingId)
      end
    end,
    onExit = function(self)
      self.parent:onExitItem()
    end,
    onPress = function(self)
      if not math.isEmpty(self.bind.buildingId) then
        self.parent:onEnterItem(self.bind.buildingId)
      end
    end
  }
end

function this:onClick()
  self.parent:onClickBagItem(self.bind.buildingId)
end

function this:refresh()
  if math.isEmpty(self.bind.buildingId) then
    self.bind.txt_count = ""
    self.bind.img_icon = ""
    self.bind.txt_name = ""
    self.bind.active_0 = false
  else
    local tpl = _homeBuildingTpl:getTplById(self.bind.buildingId)
    local data = L_HomeStore:getBuildingInBag(self.bind.buildingId)
    local count = data.total_num - data.used_num
    self.bind.txt_count = tostring(count)
    self.bind.img_icon = _homeBuildingTpl:getBuildIcon(tpl)
    self.bind.txt_name = _homeBuildingTpl:getName(tpl)
    self.bind.active_0 = count <= 0
  end
end

function this:open()
  L_ShortCutManager:addShortKeyFlag(self, tostring(self.bind.index), L_Const.AnchorType.Middle, self.bindComponents.shortKeyNode)
end

function this:close()
  L_ShortCutManager:clearShortKeyFlag(self)
end

return this
