local moduleTripleFolderEffect = class("moduleTripleFolderEffect", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _soulessenceTpl = L_GameTpl:getSoulessenceTpl()
local _animTimerKey = "tripleFolderEffectPlayAnim"

function moduleTripleFolderEffect:ctor(...)
  moduleTripleFolderEffect.super.ctor(self, ...)
end

function moduleTripleFolderEffect.bind()
  return {
    change = false,
    img1 = "",
    img2 = "",
    img3 = "",
    img4 = "",
    img5 = "",
    img6 = ""
  }
end

function moduleTripleFolderEffect.methods()
  return {}
end

function moduleTripleFolderEffect:open()
end

function moduleTripleFolderEffect:close()
  L_TimerManager:stopTimer(self, _animTimerKey)
  self.isAnimTimerRunning = false
  self.isAnimPaused = false
end

function moduleTripleFolderEffect:receiveRewards(id)
  self.soulEssenceItemIds = {}
  self.soulPaths = {}
  self.nextSoulPathIndex = 1
  self.hasInitSoulImages = false
  self.nextRefreshSoulImageGroup = 1
  self.hasPlayAnim = false
  self.isAnimTimerRunning = false
  self.isAnimPaused = false
  self.change = false
  local tpl = _commonItemTpl:getTplById(id)
  if tpl == nil then
    errorf("common_item表里不存在该id = " .. tostring(id))
    return
  end
  local items = _commonItemTpl:getGiftBagReward(tpl)
  if table.isEmpty(items) then
    return
  end
  local rewards = L_DataUtil.parseRewardConfig(items)
  for _, item in pairs(rewards) do
    table.insert(self.soulEssenceItemIds, item.itemId)
  end
  self:refreshSoulPaths()
  self:initSoulImagePaths()
  self:startPlayAnimTimer()
end

function moduleTripleFolderEffect:refreshSoulPaths()
  self.soulPaths = {}
  self.nextSoulPathIndex = 1
  self.hasInitSoulImages = false
  self.nextRefreshSoulImageGroup = 1
  if table.isEmpty(self.soulEssenceItemIds) then
    return
  end
  for _, itemId in ipairs(self.soulEssenceItemIds) do
    local tpl = _soulessenceTpl:getTplById(itemId)
    if tpl ~= nil then
      table.insert(self.soulPaths, _soulessenceTpl:getAvatarTexture(tpl, 5))
    else
      errorf("soulessence表里不存在该id = " .. tostring(itemId))
    end
  end
end

function moduleTripleFolderEffect:getNextSoulPath()
  if table.isEmpty(self.soulPaths) then
    return ""
  end
  local path = self.soulPaths[self.nextSoulPathIndex]
  self.nextSoulPathIndex = self.nextSoulPathIndex + 1
  if self.nextSoulPathIndex > #self.soulPaths then
    self.nextSoulPathIndex = 1
  end
  return path
end

function moduleTripleFolderEffect:initSoulImagePaths()
  if table.isEmpty(self.soulPaths) then
    return
  end
  self.nextSoulPathIndex = 1
  self.bind.img1 = self:getNextSoulPath()
  self.bind.img2 = self:getNextSoulPath()
  self.bind.img3 = self:getNextSoulPath()
  self.hasInitSoulImages = true
  self.nextRefreshSoulImageGroup = 2
end

function moduleTripleFolderEffect:refreshSoulImagePaths()
  if table.isEmpty(self.soulPaths) then
    return
  end
  if not self.hasInitSoulImages then
    self:initSoulImagePaths()
    return
  end
  if self.nextRefreshSoulImageGroup == 1 then
    self.bind.img1 = self:getNextSoulPath()
    self.bind.img2 = self:getNextSoulPath()
    self.bind.img3 = self:getNextSoulPath()
    self.nextRefreshSoulImageGroup = 2
  else
    self.bind.img4 = self:getNextSoulPath()
    self.bind.img5 = self:getNextSoulPath()
    self.bind.img6 = self:getNextSoulPath()
    self.nextRefreshSoulImageGroup = 1
  end
end

function moduleTripleFolderEffect:startPlayAnimTimer()
  L_TimerManager:stopTimer(self, _animTimerKey)
  L_TimerManager:newOrResetTimer(self, _animTimerKey, function()
    self:PlayAnim()
  end, 5, -1)
  self.isAnimTimerRunning = true
  self.isAnimPaused = false
end

function moduleTripleFolderEffect:PauseAnim()
  if not self.isAnimTimerRunning then
    return
  end
  local animPage = self.bindComponents and self.bindComponents.animPage
  if animPage ~= nil then
    animPage:SetBool("play", false)
    animPage:SetBool("stop", true)
    animPage:Rebind()
  end
  L_TimerManager:stopTimer(self, _animTimerKey)
  self:initSoulImagePaths()
  self.isAnimTimerRunning = false
  self.isAnimPaused = true
  self.change = false
end

function moduleTripleFolderEffect:ResumeAnim()
  if not self.isAnimPaused then
    return
  end
  local animPage = self.bindComponents and self.bindComponents.animPage
  if animPage ~= nil then
    animPage:SetBool("stop", false)
    animPage:SetBool("play", true)
    animPage:Rebind()
  end
  self.change = false
  self:startPlayAnimTimer()
end

function moduleTripleFolderEffect:PlayAnim()
  local animPage = self.bindComponents and self.bindComponents.animPage
  if animPage == nil then
    return
  end
  if not self.hasPlayAnim then
    animPage:SetBool("play", true)
    animPage:SetBool("stop", false)
    self.hasPlayAnim = true
  end
  self.bindComponents.animPage:SetBool("play", true)
  self:refreshSoulImagePaths()
  self.change = not self.change
  animPage:SetBool("change", self.change)
end

function moduleTripleFolderEffect:StopAnim()
  local animPage = self.bindComponents and self.bindComponents.animPage
  if animPage ~= nil then
    animPage:SetBool("stop", false)
    animPage:SetBool("play", true)
    animPage:Rebind()
  end
end

return moduleTripleFolderEffect
