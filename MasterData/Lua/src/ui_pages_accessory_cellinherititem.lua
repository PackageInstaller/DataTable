local this = class("cellInheritItem", G_UIModuleBase)
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local accessoryQualityTpl = L_GameTpl:getAccessoryQualityTpl()
local accessoryTpl = L_GameTpl:getAccessoryTpl()
local elementTypeTpl = L_GameTpl:getElementTypeTpl()
local qualitys_icon = {
  "UI/Atlas/AccessoryStrength/tex_soulessence_decompose_equip_gary01.png",
  "UI/Atlas/AccessoryStrength/tex_soulessence_decompose_equip_green01.png",
  "UI/Atlas/AccessoryStrength/tex_soulessence_decompose_equip_blue01.png",
  "UI/Atlas/AccessoryStrength/tex_soulessence_decompose_equip_purple01.png",
  "UI/Atlas/AccessoryStrength/tex_soulessence_decompose_equip_gold01.png"
}

function this.bind()
  return {
    go_accessoryActive = false,
    go_emptyActive = false,
    img_icon = "",
    img_eleIcon = "",
    txt_propertyName = "",
    txt_propertyDes = "",
    txt_propertyValue = "",
    img_qualitysBg = "",
    go_accessoryQuality = false,
    go_eleIconActive = false,
    go_isMax = false
  }
end

function this.methods()
  return {
    onclick_AddItem = function(self)
      if self.callback then
        self.callback()
      end
    end
  }
end

function this:InitModule(params)
  self.callback = params.callback
  self.isMax = params.isMax
  self:refreshUI(params.guid)
end

function this:refreshUI(guid)
  if self.isMax then
    self:RefreshMaxUI(true)
    return
  end
  local hasEquip = guid ~= 0
  self.guid = guid
  if hasEquip then
    local serverData = C_AccessoryMgr:getAccessory(self.guid)
    local att = C_AccessoryMgr:getPackAtt(serverData)
    if att.elemAtt.attId ~= 0 then
      local battleTpl = battleInfoTpl:getTplById(att.elemAtt.attId)
      local eleTpl = elementTypeTpl:getTplById(battleInfoTpl:getElementType(battleTpl))
      self.bind.img_eleIcon = elementTypeTpl:getPetElem(eleTpl)
      self.bind.go_eleIconActive = true
    else
      self.bind.go_eleIconActive = false
    end
    local accessoryCfg = accessoryTpl:getTplById(serverData.accessoryId)
    local accessoryQuality = accessoryTpl:getRarity(accessoryCfg)
    self.bind.img_qualitysBg = qualitys_icon[serverData.quality]
    for i = 0, self.bindComponents.bgEftRoot.childCount - 1 do
      local go = self.bindComponents.bgEftRoot:GetChild(i)
      L_CommonUtil.setObjActive(go.gameObject, 4 - accessoryQuality == i)
    end
    if serverData.quality == 5 then
      local path = accessoryTpl:getLargeIconByTpl(accessoryCfg)
      self.bind.img_icon = path:gsub("%.png$", "_G.png")
    else
      self.bind.img_icon = accessoryTpl:getLargeIconByTpl(accessoryCfg)
    end
    local quality_tpl = accessoryQualityTpl:getTplById(serverData.quality)
    self.bind.txt_propertyName = accessoryQualityTpl:getNameByTpl(quality_tpl)
    self.bind.txt_propertyDes = "装备主属性加成"
    self.bind.txt_propertyValue = tostring(accessoryQualityTpl:getValueByTpl(quality_tpl) / 100) .. "%"
  end
  self.bind.go_accessoryActive = hasEquip
  self.bind.go_emptyActive = not hasEquip
  self.bind.go_accessoryQuality = hasEquip
end

function this:RefreshMaxUI(state)
  self.bind.go_isMax = state
  self.bind.go_emptyActive = not state
  self.bind.go_accessoryActive = not state
end

return this
