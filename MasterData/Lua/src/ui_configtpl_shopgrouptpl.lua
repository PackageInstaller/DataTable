local this = class("shopGroupTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getShopList(tpl)
  return tpl.shopList
end

function this:getShopGroupName(tpl)
  return L_Config:provider(tpl.shopGroupName)
end

function this:getShopGroupId(tpl)
  return tpl.shopGroupId
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getShopIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.icon)
  return icon
end

function this:getNpcShopIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.npcShopIcon)
  if string.isEmpty(icon) then
    icon = "UI/Atlas/ShopPage/tex_npcshop_dec_name1.png"
  end
  return icon
end

function this:getAllShopGroupId(idTable)
end

function this:getNpcCameraParam(tpl)
  if not tpl.npcParam then
    return C_Vector3(0, 0, 0)
  end
  return C_Vector3((tpl.npcParam[1] or 0) / 10000, (tpl.npcParam[2] or 0) / 10000, (tpl.npcParam[3] or 0) / 10000)
end

return this
