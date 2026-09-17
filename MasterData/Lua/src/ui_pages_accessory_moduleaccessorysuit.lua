local this = class("moduleAccessorySuit", G_UIModuleBase)
local _accessoryTpl = L_GameTpl:getAccessoryTpl()
local _accessorySetTpl = L_GameTpl:getAccessorySetTpl()

function this.bind()
  return {
    txt_suitName = nil,
    list_suitDesc = {
      moduleName = "pages/accessory/cellAccessorySuit"
    }
  }
end

function this:setNormalSuit(guid)
  local serverData = C_AccessoryMgr:getAccessory(guid)
  self:setNormalSuitPreview(serverData.accessoryId)
end

function this:setNormalSuitPreview(accessoryId)
  local tpl_accessory = _accessoryTpl:getTplById(accessoryId)
  local suitId = _accessoryTpl:getSetId(tpl_accessory)
  if 0 < suitId then
    local suitTxtData = C_AccessoryMgr:getSuitDesc(accessoryId)
    self.bind.txt_suitName = suitTxtData.name
    local tmp = {}
    for i, v in pairs(suitTxtData.suit) do
      table.insert(tmp, {
        txt_desc = v.desc,
        alpha_canvas = 1,
        enterBg = false
      })
    end
    self.bind.list_suitDesc:clear()
    self.bind.list_suitDesc:insert_array(tmp)
  else
    self.bind.txt_suitName = L_WordsTpl:getValue("ui_moduleAccessorySuit")
    self.bind.list_suitDesc:clear()
  end
end

function this:setEquippedSuit(guid, heroGuid, isPreview)
  local serverData = C_AccessoryMgr:getAccessory(guid)
  local accessoryId = serverData.accessoryId
  local wearHero = serverData.wearHero
  local tpl_accessory = _accessoryTpl:getTplById(accessoryId)
  local suitId = _accessoryTpl:getSetId(tpl_accessory)
  if suitId <= 0 then
    self.bind.txt_suitName = L_WordsTpl:getValue("ui_moduleAccessorySuit")
    self.bind.list_suitDesc:clear()
    return
  end
  local suitTxtData = C_AccessoryMgr:getSuitDesc(accessoryId)
  local heroAccessoryGuidList = L_HeroStore:getHeroAccessoryGuidList(L_HeroStore:getHero(heroGuid))
  local suitNum = 1
  local tplCur = _accessoryTpl:getTplById(accessoryId)
  local posCur = _accessoryTpl:getType(tplCur)
  local setCur = _accessoryTpl:getSetId(tplCur)
  for _, guidTmp in pairs(heroAccessoryGuidList) do
    if not math.isEmpty(guidTmp) and guidTmp ~= guid and not math.isEmpty(setCur) then
      local serverDataTmp = C_AccessoryMgr:getAccessory(guidTmp)
      local tplTmp = _accessoryTpl:getTplById(serverDataTmp.accessoryId)
      local posTmp = _accessoryTpl:getType(tplTmp)
      local setTmp = _accessoryTpl:getSetId(tplTmp)
      if setTmp == setCur then
        if isPreview and posCur ~= posTmp then
          suitNum = suitNum + 1
        elseif not isPreview and serverDataTmp.wearHero == wearHero then
          suitNum = suitNum + 1
        end
      end
    end
  end
  for i, v in pairs(suitTxtData.suit) do
    if suitNum >= v.index then
      suitTxtData.suit[i].active = true
    end
  end
  local tpl_set = _accessorySetTpl:getTplById(_accessoryTpl:getSetId(tplCur))
  local suitSkillList = _accessorySetTpl:getSkill(tpl_set)
  local maxSuitNum = suitSkillList[#suitSkillList][1]
  local nameColor = suitNum >= suitTxtData.suit[1].index and "#e0923e" or "#4f525d"
  self.bind.txt_suitName = L_GameUtil.fillColor(string.format("%s(%s/%s)", suitTxtData.name, suitNum, maxSuitNum), nameColor)
  local tmp = {}
  for i, v in pairs(suitTxtData.suit) do
    table.insert(tmp, {
      txt_desc = L_GameUtil.fillColor(v.desc, v.active and "#e0923e" or "#4f525d"),
      pointColor = v.active and C_Color(0.9568627450980393, 0.5725490196078431, 0.24313725490196078, 1) or nil,
      alpha_canvas = v.active and 1 or 0.8,
      enterBg = false
    })
  end
  self.bind.list_suitDesc:clear()
  self.bind.list_suitDesc:insert_array(tmp)
end

return this
