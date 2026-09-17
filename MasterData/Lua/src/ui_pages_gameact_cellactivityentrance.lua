local this = class("cellActivityEntrance", G_UIModuleBase)

function this.bind()
  return {
    txt_actNameL = "",
    txt_actNameR = "",
    txt_artNameSmall = "",
    go_redDot = false
  }
end

function this.methods()
  return {
    onClick_btnEnter = function(self)
      this:openActivity()
    end
  }
end

function this:open(data)
  self:initData(data)
  self:initInternalData()
  self:refreshUI()
end

function this:show()
  self:refreshRedDot()
end

function this:initData()
  self.activityId = self.bind.activityId
  self.redDotFuc = self.bind.redDotFuc
  self.onEnter = self.bind.onEnter
  print(self.activityId)
end

function this:initInternalData()
end

function this:refreshUI()
  local nameL, nameR = self:getArtName(self.activityId)
  self.bind.txt_actNameL = nameL
  self.bind.txt_actNameR = nameR
  self.bind.txt_artNameSmall = self:getName(self.activityId)
end

function this:refreshRedDot()
  if self.redDotFuc then
    self.bind.go_redDot = self.redDotFuc()
  end
end

function this:setName(name)
  self.bind.txt_actName = name
end

function this:setBg(icon)
end

function this:openActivity()
  L_EntrustStore:call(L_EntrustStore.event.entrustEnterDetail, function()
    L_UI:open("pageGameActivitykiboBattle")
  end)
end

function this:getName(activityId)
  local tplApi = L_GameTpl:getGameEventsEntrustEnterTpl()
  if tplApi == nil then
    return string.empty
  end
  local tpl = tplApi:getTplById(activityId)
  local name = string.empty
  if tpl then
    name = tplApi:getName(tpl)
  end
  return name
end

function this:getArtName(activityId)
  local tplApi = L_GameTpl:getGameEventsEntrustEnterTpl()
  if tplApi == nil then
    return string.empty
  end
  local tpl = tplApi:getTplById(activityId)
  local nameL = string.empty
  local nameR = string.empty
  if tpl then
    local nameStringList = tplApi:getArtName(tpl)
    nameL = L_Config:provider(nameStringList[1])
    nameR = L_Config:provider(nameStringList[2])
  end
  return nameL, nameR
end

return this
