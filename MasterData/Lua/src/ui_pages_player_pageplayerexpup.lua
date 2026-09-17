local this = class("pagePlayerExpUp", G_UIPageBase)
local playerLevelTpl = L_GameTpl:getPlayerLevelTpl()

function this.bind()
  return {
    txt_lv = "",
    txt_newLv = "",
    txt_percent = "",
    txt_currencyNum = "",
    go_currency = false,
    progress = 1,
    starPos = C_Vector2(0, 0),
    starRot = C_Quaternion.Euler(C_Vector3(0, 0, 0))
  }
end

function this.methods()
  return {
    animEvent_onExpUp = function(self, name)
      self:handleOnanimEvent_onExpUp(name)
    end
  }
end

function this:open()
  self.bindComponents.expUpAnim:SetBool("Start", true)
end

function this:show()
  self:kill()
  self:init(L_PlayerStore:getExpUpParam())
end

function this:close()
  self:kill()
end

function this:init(options)
  self.lastLv = options.lastLv
  self.curLv = options.curLv
  self.maxLv = playerLevelTpl:getMaxLevel()
  self.lastExp = options.lastExp
  self.curExp = options.curExp
  self.isLevelUp = options.isLevelUp
  self.needExp = playerLevelTpl:getExp(playerLevelTpl:getTplById(self.lastLv))
  self.curNeedExp = playerLevelTpl:getExp(playerLevelTpl:getTplById(self.curLv))
  self.actulneedExp = self.needExp
  self.offsetRadius = 15
  self.maxStarPos = C_Vector2(0, 67)
  self.bindComponents.expUpAnim.enabled = true
  self.bindComponents.expUpAnim:SetBool("LevelUp", self.isLevelUp)
  self.bind.txt_newLv = tostring(self.curLv)
  L_PlayerStore:ResetExpUp(false)
  local num = 0
  for i = self.lastLv + 1, self.curLv do
    local tpl = playerLevelTpl:getTplById(i)
    if tpl then
      local reward = playerLevelTpl:getLevelReward(playerLevelTpl:getTplById(i))
      if reward then
        local item = L_DataUtil.parseRewardConfig(reward)
        if item[1] then
          num = item[1].itemNum + num
        end
      end
    end
  end
  if 0 < num then
    self.bind.go_currency = true
    self.bind.txt_currencyNum = "+" .. tostring(num)
  end
end

function this:handleOnanimEvent_onExpUp(name)
  self.progressRect = self.bindComponents.progressRect
  if name == "Dotween1" then
    self.bind.txt_lv = tostring(self.lastLv)
    self.bind.txt_percent = self.lastLv == self.maxLv and "MAX" or string.format("%d/%d", self.lastExp, self.needExp)
    self.bind.progress = self.lastExp / self.needExp
    self.curValue = self.lastExp
    if self.lastLv == self.maxLv and self.lastExp > self.needExp then
      self.bind.starPos = self.maxStarPos
      self.bind.starRot = C_Quaternion.Euler(C_Vector3(0, 0, 0))
      return
    end
    local curve_expUp = self.bindComponents.playerExpUpTweenCurve.curves[0]
    
    local function getter()
      if not self.isBind then
        return
      end
      return self.bind.progress
    end
    
    local function setter(r)
      if not self.isBind then
        return
      end
      self.bind.progress = r
      self.bind.starPos = self:CalculatePointOnCircle(r * 360, (self.progressRect.sizeDelta.x - 4) / 2 - self.offsetRadius)
      local tempPos = self:CalculatePointOnCircle(r * 360 * 1.02, (self.progressRect.sizeDelta.x - 4) / 2 - self.offsetRadius)
      self.bind.starRot = self:CalculateTangentOnCircle(tempPos, self.bind.starPos)
    end
    
    local function getterT()
      if not self.isBind then
        return
      end
      return self.curValue
    end
    
    local function setterT(r)
      if not self.isBind then
        return
      end
      self.curValue = r
      self.bind.txt_percent = string.format("%d/%d", math.ceil(r), self.actulneedExp)
    end
    
    if self.isLevelUp then
      local mainHero = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
      if mainHero == nil then
        return
      end
      L_AudioUtil.playSound("Play_SFX_System_HUD_StarLevel_Upgrade_FX")
      L_AudioUtil.playSound("Play_SFX_System_HUD_StarLevel_Upgrade")
      C_MediaPackUtility.MediaPackPlay("pre_playerlevel_up", mainHero, 1.0, C_EEffectBindType.Local)
      self.tween = DOTween.To(getter, setter, self.needExp / self.needExp, 1):SetEase(curve_expUp)
      self.tweenT = DOTween.To(getterT, setterT, self.needExp, 1):SetEase(curve_expUp)
    else
      L_AudioUtil.playSound("Play_SFX_System_HUD_StarLevel_Increase")
      self.tween = DOTween.To(getter, setter, self.curExp / self.needExp, 1.15):SetEase(curve_expUp)
      self.tweenT = DOTween.To(getterT, setterT, self.curExp, 1.15):SetEase(curve_expUp)
    end
  elseif name == "Fresh" then
    self.bind.txt_lv = tostring(self.curLv)
    self.actulneedExp = self.curNeedExp
  elseif name == "Dotween2" then
    if self.curLv == self.maxLv then
      self.bind.txt_percent = "MAX"
      self.bind.starPos = self.maxStarPos
      self.bind.starRot = C_Quaternion.Euler(C_Vector3(0, 0, 0))
      Timer.once(1.3, function()
        L_UI:close(self.pageName)
      end)
      return
    end
    self.bind.progress = 0
    self.curValue = 0
    local curve_levelUp = self.bindComponents.playerExpUpTweenCurve.curves[1]
    
    local function getter()
      if not self.isBind then
        return
      end
      return self.bind.progress
    end
    
    local function setter(r)
      if not self.isBind then
        return
      end
      self.bind.progress = r
      self.bind.starPos = self:CalculatePointOnCircle(r * 360, (self.progressRect.sizeDelta.x - 4) / 2 - self.offsetRadius)
      local tempPos = self:CalculatePointOnCircle(r * 360 * 1.02, (self.progressRect.sizeDelta.x - 4) / 2 - self.offsetRadius)
      self.bind.starRot = self:CalculateTangentOnCircle(tempPos, self.bind.starPos)
    end
    
    local function getterT()
      return self.curValue
    end
    
    local function setterT(r)
      self.curValue = r
      self.bind.txt_percent = string.format("%d/%d", math.ceil(r), self.actulneedExp)
    end
    
    if 0 < self.curExp then
      L_AudioUtil.playSound("Play_SFX_System_HUD_StarLevel_Increase")
    end
    self.tween = DOTween.To(getter, setter, self.curExp / self.curNeedExp, 1.3):SetEase(curve_levelUp)
    self.tweenT = DOTween.To(getterT, setterT, self.curExp, 1.3):SetEase(curve_levelUp)
  elseif name == "Out" then
    Timer.once(2, function()
      L_UI:close(self.pageName)
    end)
  end
end

function this:CalculatePointOnCircle(angleDegrees, radius)
  local angleRadians = angleDegrees * (Mathf.PI / 180)
  local x = Mathf.Cos(angleRadians + Mathf.PI / 2 + Mathf.PI) * radius
  local y = Mathf.Sin(angleRadians + Mathf.PI / 2 + Mathf.PI) * radius * -1
  return C_Vector2(x, y)
end

function this:CalculateTangentOnCircle(circleCenter, selfPos)
  local direction = (selfPos - circleCenter).normalized
  local angle = Mathf.Atan2(direction.y, direction.x) * Mathf.Rad2Deg
  return C_Quaternion.Euler(0, 0, angle)
end

function this:kill()
  if L_CommonUtil.isValid(self.tween) then
    self.tween:Kill()
    self.tween = nil
  end
  if L_CommonUtil.isValid(self.tweenT) then
    self.tweenT:Kill()
    self.tweenT = nil
  end
end

function this:disposeTween()
  self:kill()
  L_UI:close(self.pageName)
end

return this
