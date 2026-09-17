local this = class("moduleAttGroup", G_UIModuleBase)
local _battleInfoTpl = L_GameTpl:getBattleInfoTpl()

function this.bind()
  return {
    list_elemAtt = {
      moduleName = "pages/accessory/cellAccessoryAtt"
    },
    list_mainAtt = {
      moduleName = "pages/accessory/cellAccessoryAtt"
    },
    list_subAtt = {
      moduleName = "pages/accessory/cellAccessoryAtt"
    }
  }
end

function this.methods()
  return {}
end

function this:close()
end

function this:setServerData(guid)
  local serverData = C_AccessoryMgr:getAccessory(guid)
  local att = C_AccessoryMgr:getPackAtt(serverData)
  self:refreshUI(att)
end

function this:setNotServerData(accessoryId)
  local att = C_AccessoryMgr:getPackAttByConfigId(accessoryId)
  self:refreshUI(att)
end

function this:refreshUI(att)
  if not self.isBind then
    return
  end
  local elemTmp = {}
  local elem_att = att.elemAtt
  table.insert(elemTmp, {
    name = elem_att.showName,
    number = string.concat("+", _battleInfoTpl:getShowTxt(elem_att.attId, elem_att.value)),
    showNumber = true,
    showBg = true,
    lock = false,
    index = elem_att.index
  })
  self.bind.list_elemAtt:clear()
  self.bind.list_elemAtt:insert_array(elemTmp)
  local mainTmp = {}
  local main_att = att.mainAtt
  for key, item in pairs(main_att) do
    table.insert(mainTmp, {
      name = item.showName,
      number = string.concat("+", _battleInfoTpl:getShowTxt(item.attId, item.value)),
      showNumber = true,
      showBg = true,
      lock = false,
      index = item.index,
      bSkill = false
    })
  end
  table.sort(mainTmp, function(a, b)
    return a.index < b.index
  end)
  self.bind.list_mainAtt:clear()
  self.bind.list_mainAtt:insert_array(mainTmp)
  local subTmp = {}
  local sub_att = att.subAtt
  for i, v in pairs(sub_att) do
    table.insert(subTmp, {
      name = v.skillName,
      number = "Lv." .. tostring(v.skillLv),
      alpha_canvas = 1,
      showBg = false,
      bSkill = true
    })
  end
  self.bind.list_subAtt:clear()
  self.bind.list_subAtt:insert_array(subTmp)
end

return this
