local this = class("pageAccessoryUpgrade", G_UIPageBase)
local _battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local _accessoryTpl = L_GameTpl:getAccessoryTpl()
local _accessoryLevelTpl = L_GameTpl:getAccessoryLevelTpl()

function this.bind()
  return {
    img_icon = nil,
    txt_levelNew = nil,
    img_mainAtt = nil,
    txt_mainAttName = nil,
    txt_mainAttValue = nil,
    txt_mainAttValueChange = nil,
    list_subAtt = {
      moduleName = "pages/accessory/cellAccessorySubAttStrength"
    }
  }
end

function this.methods()
  return {
    onClick_mask = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._guid = options.guid
  self._oldData = options.oldData
  self:initPage()
end

function this:initPage()
  local serverData = C_AccessoryMgr:getAccessory(self._guid)
  local newData = C_AccessoryMgr:getPackAtt(serverData)
  local tpl = _accessoryTpl:getTplById(serverData.accessoryId)
  local quality = _accessoryTpl:getRarity(tpl)
  local type = _accessoryTpl:getType(tpl)
  self.bind.img_icon = _accessoryTpl:getIcon(tpl)
  self.bind.txt_levelNew = string.format("%s", newData.level)
  local newMainAtt = newData.mainAtt
  local oldMainAtt = self._oldData.mainAtt
  local tpl_mainAttBattleInfo = _battleInfoTpl:getTplById(newMainAtt.attId[1])
  self.bind.img_mainAtt = _battleInfoTpl:getIcon(tpl_mainAttBattleInfo)
  self.bind.txt_mainAttName = newMainAtt.showName
  self.bind.txt_mainAttValue = _battleInfoTpl:getShowTxt(oldMainAtt.attId[1], oldMainAtt.value)
  self.bind.txt_mainAttValueChange = _battleInfoTpl:getShowTxt(newMainAtt.attId[1], newMainAtt.value)
  local tmp = {}
  local oldSubAttNum = _accessoryLevelTpl:getUnlockEntry(_accessoryLevelTpl:getTplByAccessoryIdAndLevel(serverData.accessoryId, self._oldData.level))
  local newSubAttNum = _accessoryLevelTpl:getUnlockEntry(_accessoryLevelTpl:getTplByAccessoryIdAndLevel(serverData.accessoryId, newData.level))
  local sub_att = newData.subAtt
  local showBg = true
  for i, v in ipairs(sub_att) do
    if not v.bLock then
      showBg = not showBg
      local showHighLight = oldSubAttNum < i and i <= newSubAttNum
      table.insert(tmp, {
        showBg = showBg,
        showHighLight = showHighLight,
        bLock = v.bLock,
        txt_desc_lock = v.desc,
        txt_desc_unlock = v.desc
      })
    end
  end
  self.bind.list_subAtt:clear()
  self.bind.list_subAtt:insert_array(tmp)
end

return this
