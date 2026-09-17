local module = class("moduleScanPetTip", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()

function module.bind()
  return {
    active_content = false,
    img_scanLensIcon = "",
    txt_tipInfo = "",
    txt_num = ""
  }
end

function module.methods()
  return {}
end

function module:showTip(lensLevel)
  printf("当前使用透镜：：：等级  " .. tostring(lensLevel))
  if 0 < lensLevel then
    self.bind.active_content = true
    local itemId = L_PetConst.PetCatchLensItemIds[lensLevel]
    local itemTpl = _commonItemTpl:getTplById(itemId)
    if not itemTpl then
      self:hideTip()
      return
    end
    self.bind.img_scanLensIcon = _commonItemTpl:getIcon(itemTpl)
    self.bind.txt_tipInfo = L_GameTpl:getWordsTpl():getValue("notice_lens_working", {
      [0] = _commonItemTpl:getName(itemTpl)
    })
    self.bind.txt_num = tostring(C_BagMgr:getItemNumByItemId(itemId))
  else
    self.bind.active_content = false
  end
end

function module:hideTip()
  self.bind.active_content = false
end

function module:PlayHide()
  self.bindComponents.anim:Play("anim_scanpet_hide")
end

return module
