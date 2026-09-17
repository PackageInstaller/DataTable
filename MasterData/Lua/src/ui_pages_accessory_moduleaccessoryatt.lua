local this = class("moduleAccessoryAtt", G_UIModuleBase)
local _battleInfoTpl = L_GameTpl:getBattleInfoTpl()

function this.bind()
  return {
    list_att = {
      moduleName = "pages/accessory/cellAccessoryAtt"
    }
  }
end

function this:initModule(guid, ignoreMain, ignoreAccessory)
  local serverData = C_AccessoryMgr:getAccessory(guid)
  local att = C_AccessoryMgr:getPackAtt(serverData)
  local tmp = {}
  local showBg = false
  if not ignoreMain then
    local main_att = att.mainAtt
    showBg = true
    for key, item in pairs(main_att) do
      table.insert(tmp, {
        name = item.showName,
        number = string.concat("+", _battleInfoTpl:getShowTxt(item.attId, item.value)),
        showNumber = true,
        showBg = showBg,
        lock = false,
        index = item.index
      })
    end
  end
  table.sort(tmp, function(a, b)
    return a.index < b.index
  end)
  if not ignoreAccessory then
    local sub_att = att.subAtt
    for i, v in pairs(sub_att) do
      showBg = not showBg
      table.insert(tmp, {
        name = v.name == nil and v.desc or v.name,
        number = tostring(v.desc),
        alpha_canvas = v.bLock and 0.6 or 1,
        showBg = showBg,
        bLock = v.bLock
      })
    end
  end
  self.bind.list_att:clear()
  self.bind.list_att:insert_array(tmp)
end

function this:initModulePreview(accessoryId, ignoreMain, ignoreAccessory)
  local att = C_AccessoryMgr:getPackAttByConfigId(accessoryId)
  local tmp = {}
  local showBg = false
  if not ignoreMain and att.mainAtt then
    local main_att = att.mainAtt
    showBg = true
    for key, item in pairs(main_att) do
      table.insert(tmp, {
        name = item.showName,
        number = string.concat("+", _battleInfoTpl:getShowTxt(item.attId, item.value)),
        showNumber = true,
        showBg = showBg,
        lock = false,
        index = item.index
      })
    end
  end
  if not ignoreAccessory and att.subAtt then
    local sub_att = att.subAtt
    for i, v in pairs(sub_att) do
      showBg = not showBg
      table.insert(tmp, {
        name = v.name == nil and v.desc or v.name,
        number = tostring(v.desc),
        alpha_canvas = v.bLock and 0.6 or 1,
        showBg = showBg,
        bLock = v.bLock
      })
    end
  end
  self.bind.list_att:clear()
  self.bind.list_att:insert_array(tmp)
end

return this
