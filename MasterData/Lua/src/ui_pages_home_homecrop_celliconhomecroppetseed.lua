local this = class("cellIconHomeCropPetSeed", G_UIPageBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()

function this.bind()
  return {
    img_icon = "",
    img_iconFilter = "",
    txt_num = ""
  }
end

function this.methods()
  return {}
end

function this:refreshByItem(itemData)
  if itemData then
    local conf = L_ItemTplManager:getCommonItem(itemData.item_id)
    local commonItemTpl = _commonItemTpl:getTplById(itemData.item_id)
    self.bind.img_iconFilter = commonItemTpl and _commonItemTpl:getFilterIcon(commonItemTpl) or ""
    self.bind.img_icon = conf.icon
    self.bind.txt_num = tostring(itemData.num)
  end
end

function this:close()
end

return this
