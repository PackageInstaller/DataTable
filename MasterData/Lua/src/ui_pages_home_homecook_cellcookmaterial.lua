local this = class("cellCookMaterial", G_UIModuleBase)
local _foodGroupTpl = L_GameTpl:getFoodGroupTpl()

function this.bind()
  return {
    img_icon = "",
    list_star = {},
    txt_num = ""
  }
end

function this.methods()
  return {
    onClick = function(self)
      self._callback()
    end
  }
end

function this:open()
end

function this:setCallback(cb)
  self._callback = cb
end

function this:setItem(itemId, needNum)
  if math.isEmpty(itemId) then
    self.bind.txt_num = ""
    self.bind.img_icon = ""
    self.bind.list_star:clear()
  else
    local conf = L_ItemTplManager:getCommonItem(itemId)
    self.bind.img_icon = conf.icon
    local haveNum = L_ItemTplManager:getItemNum(L_Const.resType.commonItem, itemId)
    self.bind.txt_num = string.format(needNum > haveNum and L_GameUtil.fillColor("%s/%s", "#ff0000") or "%s/%s", needNum, haveNum)
    local starNum = L_ItemTplManager:getItemShowStarNum(L_Const.resType.commonItem, itemId)
    if #self.modules.list_star ~= starNum then
      self.bind.list_star:clear()
      self.bind.list_star:insert_array(L_DataUtil.getEmptyModuleDatas(starNum))
    end
  end
end

return this
