local module = class("cellHeroStarItem", G_UIModuleBase)

function module.bind()
  return {
    pos = 0,
    unLock = true,
    txt_name = ""
  }
end

function module.methods()
  return {
    onClick_btn = function(self)
      self:emit("showSkill", not self.bind.unLock, self.bind.skill, self.bind.index, self.bind.attr, self.bind.rwd)
    end
  }
end

function module:open()
  local heroId = self.bind.heroId
  local index = self.bind.index
  self.bindComponents.icon_cellFate:LoadSprite("Assets/Arts/UI/Page/HeroPanel/HeroGradeFate/tex_hero_grade_icon_0" .. index .. "_illustration.png", false)
  self.bind.txt_name = self.bind.title
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.rect_horizontal)
  self._pauseUpdate = true
  L_TimerManager:newOrResetTimer(self, "resumeUpdatePreopen", function()
    self._pauseUpdate = false
  end, 0.3)
  if self.bind.isPreview then
    self.bindComponents.redotNormal.gameObject:SetActive(false)
  else
    self:addUpdateHandle()
  end
end

function module:playUnlock()
  local clipName = "anim_pageHeroGrade_cellStarItem"
  self.bindComponents.anim_unlock:Play(clipName)
  local clip = self.bindComponents.anim_unlock:GetClip(clipName)
  if clip then
    return clip.length
  end
end

function module:addUpdateHandle()
  if self._updateHandle then
    return
  end
  self._updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self._updateHandle, "cellHeroStarItem.update")
end

function module:removeUpdateHandle()
  if self._updateHandle then
    C_UpdateSource.RemoveUpdateEventHandler(self._updateHandle)
    self._updateHandle = nil
  end
end

function module:setCloseReddot(pause)
  if pause then
    self._pauseUpdate = true
    self.bindComponents.redotNormal.gameObject:SetActive(false)
  else
    self._pauseUpdate = false
  end
end

function module:update()
  if self._pauseUpdate then
    if self.bindComponents.redotNormal.gameObject.activeSelf then
      self.bindComponents.redotNormal.gameObject:SetActive(false)
    end
    return
  end
  if self.bind.isPreview then
    return
  end
  local heroId = self.bind.heroId
  local index = self.bind.index
  local dotKey = string.format(L_ReddotManager.DotDef.HeroGrade, heroId .. "_" .. index)
  local state = AzurWorld.RedDotMgr:GetRedDotState(dotKey, false)
  self.bindComponents.redotNormal.gameObject:SetActive(state)
end

function module:setUnlockState(isUnlock)
  if isUnlock then
    self.bindComponents.anim_unlock:Play("anim_pageHeroGrade_cellStarItem_unlock")
  end
end

function module:close()
  L_TimerManager:stopTimer(self, "resumeUpdatePreopen")
  self:removeUpdateHandle()
end

return module
