local this = class("moduleDoubleRewardTipItem", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()

function this.bind()
  return {
    txtTimesLeft = "2",
    txtTimesRight = "2",
    txtTittle = "",
    bShowSelf = false,
    bShowTxtSplite = true,
    bShowTxtRight = true
  }
end

function this:open()
  self:initPage()
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventSync, self.initPage, self)
end

function this:close()
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventSync, self.initPage)
end

function this:initPage()
  local gameEventId = L_GameEventStore:getIdByType(L_Const.ActivityType.AT_DOUBLE_DROP)
  if not gameEventId then
    self.hideSelf = true
    self:refreshVisible()
    return
  end
  local gameEventData = L_GameEventStore:getGameEventData(gameEventId)
  if not gameEventData then
    self.hideSelf = true
    self:refreshVisible()
    return
  end
  gameEventData = gameEventData:getGameEvent()
  if not gameEventData then
    self.hideSelf = true
    self:refreshVisible()
    return
  end
  if gameEventData:getLockState() then
    self.hideSelf = true
    self:refreshVisible()
    return
  end
  self.hideSelf = false
  self.hideByDroptype = false
  self.hideByEntrusttype = false
  self.hideByCustom = false
  self.gameEventId = gameEventId
  self.count, self.maxCount = gameEventData:getCount()
  self.bind.txtTittle = L_WordsTpl:getValue("ui_gameevents_double_notice")
  self.bind.bShowTxtSplite = true
  self.bind.bShowTxtRight = true
  self.bind.txtTimesLeft = tostring(self.count)
  self.bind.txtTimesRight = tostring(self.maxCount)
  self:refreshColorOnlyActivityModule()
end

function this:setCount(count)
  self.bind.txtTittle = L_WordsTpl:getValue("ui_gameevents_double_box_notice")
  self.bind.bShowTxtSplite = false
  self.bind.bShowTxtRight = false
  self.bind.txtTimesLeft = tostring(math.min(self.count or 0, count))
  self:refreshColorOnlyActivityModule()
end

function this:refreshVisible()
  if self.hideSelf or self.hideByDroptype or self.hideByEntrusttype or self.hideByCustom then
    self.bind.bShowSelf = false
  else
    self.bind.bShowSelf = true
  end
end

function this:SetHideByCustom()
  self.hideByCustom = true
  self:refreshVisible()
end

function this:SetHideByDroptype(groupId)
  if self.gameEventId then
    self.hideByDroptype = true
    local _GameEventDoubleDropTpl = L_GameTpl:getGameEventsDoubleDropTpl()
    local tpl = _GameEventDoubleDropTpl:getTplById(self.gameEventId)
    if tpl then
      local entrustTypeids = _GameEventDoubleDropTpl:getEntrustTypeid(tpl)
      if type(groupId) == "table" then
        for _, typeid in ipairs(groupId) do
          if table.indexOf(entrustTypeids, typeid) then
            self.hideByDroptype = false
            break
          end
        end
      elseif table.indexOf(entrustTypeids, groupId) then
        self.hideByDroptype = false
      end
    end
  end
  self:refreshVisible()
end

function this:SetHideByMaterialType(typeId)
  if self.gameEventId then
    self.hideByDroptype = true
    local _GameEventDoubleDropTpl = L_GameTpl:getGameEventsDoubleDropTpl()
    local tpl = _GameEventDoubleDropTpl:getTplById(self.gameEventId)
    if tpl then
      local materialTypeIds = _GameEventDoubleDropTpl:getMaterialTypeid(tpl)
      if type(typeId) == "table" then
        for _, typeid in ipairs(typeId) do
          if table.indexOf(materialTypeIds, typeid) then
            self.hideByDroptype = false
            break
          end
        end
      elseif table.indexOf(materialTypeIds, typeId) then
        self.hideByDroptype = false
      end
    end
  end
  self:refreshVisible()
end

function this:SetHideByEntrusttype(entrustType)
  self.hideByEntrusttype = entrustType == L_Const.EntrustTypeEnum.MultiCoopEntrust or entrustType == L_Const.EntrustTypeEnum.PetDuel or entrustType == L_Const.EntrustTypeEnum.TrainTask
  self:refreshVisible()
end

function this:refreshColorOnlyActivityModule()
  if self.bindComponents.moduleDoubleDropTipItem.name == "moduleDoubleDropTipItemActivity" and self.count <= 0 then
    self.bindComponents.txtTittle.color = C_Color(0.9372549019607843, 0.3803921568627451, 0.3803921568627451)
    self.bindComponents.txtTimesLeft.color = C_Color(0.9372549019607843, 0.3803921568627451, 0.3803921568627451)
    self.bindComponents.txtSplite.color = C_Color(0.9372549019607843, 0.3803921568627451, 0.3803921568627451)
    self.bindComponents.txtTimesRight.color = C_Color(0.9372549019607843, 0.3803921568627451, 0.3803921568627451)
  elseif self.bindComponents.moduleDoubleDropTipItem.name == "moduleDoubleDropTipItemActivity" then
    self.bindComponents.txtTittle.color = C_Color(0.615686274509804, 0.44313725490196076, 0.3058823529411765)
    self.bindComponents.txtTimesLeft.color = C_Color(0.615686274509804, 0.44313725490196076, 0.3058823529411765)
    self.bindComponents.txtSplite.color = C_Color(0.615686274509804, 0.44313725490196076, 0.3058823529411765)
    self.bindComponents.txtTimesRight.color = C_Color(0.615686274509804, 0.44313725490196076, 0.3058823529411765)
  end
end

return this
