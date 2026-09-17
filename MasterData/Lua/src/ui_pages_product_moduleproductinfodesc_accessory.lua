local this = class("moduleProductInfoDesc_accessory", G_UIModuleBase)
local _battleInfoTpl = L_GameTpl:getBattleInfoTpl()

function this.bind()
  return {
    module_accessorySuit = {
      moduleName = "pages/accessory/moduleAccessorySuit"
    },
    list_mainAtt = {
      moduleName = "pages/accessory/cellAccessoryAtt"
    },
    list_minAtt = {
      moduleName = "pages/accessory/cellAccessoryAtt"
    },
    longDesScrollV = 1,
    active_kiboWorkInfo = false,
    active_addExpInfo = false,
    txt_addExpDesc = "",
    active_noExpInfo = false,
    txt_noExpDesc = "",
    active_petGradeLimit = false,
    txt_petGradeLimitDesc = "",
    txt_petGradeLimitValue = "",
    txt_itemDesc = ""
  }
end

function this.methods()
  return {}
end

function this:open()
  self.bind.txt_addExpDesc = L_WordsTpl:getValue("ui_notice_text_kibo_labor_exp_can_get")
  self.bind.txt_noExpDesc = L_WordsTpl:getValue("ui_notice_text_kibo_labor_exp_can_not_get")
  self.bind.txt_petGradeLimitDesc = L_WordsTpl:getValue("ui_notice_text_kibo_labor_score_required", {
    [0] = ""
  })
end

function this:refreshProductAccessoryView(accessoryId)
  self.bind.longDesScrollV = 1
  self.modules.module_accessorySuit:setNormalSuitPreview(accessoryId)
  local att = C_AccessoryMgr:getPreviewPackAttByConfigId(accessoryId)
  local mainAttData = {}
  local subAttData = {}
  local showBg = false
  if att.mainAtt then
    local main_att = att.mainAtt
    showBg = true
    for key, item in pairs(main_att) do
      table.insert(mainAttData, {
        name = item.showName,
        number = string.concat("+", _battleInfoTpl:getShowTxt(item.attId, item.value)),
        showNumber = true,
        showBg = showBg,
        lock = false,
        index = item.index
      })
    end
  end
  if att.subAtt then
    showBg = false
    local sub_att = att.subAtt
    for i, v in pairs(sub_att) do
      showBg = not showBg
      table.insert(subAttData, {
        name = v.name == nil and v.desc or v.name,
        number = tostring(v.desc),
        showBg = showBg,
        bLock = v.bLock
      })
    end
  end
  self.bind.list_mainAtt:clear()
  self.bind.list_mainAtt:insert_array(mainAttData)
  self.bind.list_minAtt:clear()
  self.bind.list_minAtt:insert_array(subAttData)
  self:updateKiboWorkInfo(self.cacheKiBoExpInfos)
end

function this:updateKiboWorkInfo(kiboExpInfos)
  self.cacheKiBoExpInfos = kiboExpInfos
  local gradeLimitValue = kiboExpInfos and kiboExpInfos.petGradeLimit
  local addExp = kiboExpInfos and kiboExpInfos.addExp
  local noExp = kiboExpInfos and kiboExpInfos.noExp
  if not gradeLimitValue and not addExp and not noExp then
    self.bind.active_kiboWorkInfo = false
    return
  else
    self.bind.active_kiboWorkInfo = true
  end
  if gradeLimitValue then
    self.bind.active_petGradeLimit = true
    self.bind.active_addExpInfo = false
    self.bind.active_noExpInfo = false
    self.bind.txt_petGradeLimitValue = tostring(gradeLimitValue)
  else
    self.bind.active_petGradeLimit = false
    self.bind.active_addExpInfo = addExp
    self.bind.active_noExpInfo = noExp
  end
end

return this
