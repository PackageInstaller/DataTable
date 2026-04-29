local UIS4BusinessStatus = {
  CPPS_Accepted = 1,
  CPPS_Completed = 2,
  CPPS_Taken = 3
}
_enum("UIS4BusinessStatus", UIS4BusinessStatus)
_class("UIS4BusinessProgress", UICustomWidget)
UIS4BusinessProgress = UIS4BusinessProgress

function UIS4BusinessProgress:OnShow(uiParams)
  self:InitWidget()
end

function UIS4BusinessProgress:InitWidget()
  self.icon = self:GetUIComponent("Image", "Icon")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._condition = self:GetUIComponent("UILocalizationText", "Condition")
  self.notGet = self:GetGameObject("NotGet")
  self.canGet = self:GetGameObject("CanGet")
  self.got = self:GetGameObject("Got")
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
  self.numberTxt = self:GetUIComponent("UILocalizationText", "Number")
  self._atlas = self:GetAsset("UIS4TradeGame.spriteatlas", LoadType.SpriteAtlas)
  self.AwardsPool = self:GetUIComponent("UISelectObjectPath", "Awards")
  self._anim = self:GetUIComponent("Animation", "_anim")
  self.canvas = self:GetUIComponent("CanvasGroup", "DataArea")
  self.CanGetCanvas = self:GetUIComponent("CanvasGroup", "CanGet")
  self.eff = self:GetGameObject("eff")
  self.eff2 = self:GetGameObject("eff2")
  self.canvas.alpha = 0
end

function UIS4BusinessProgress:SetData(number, status, progress, rewards, callback)
  self.number = number
  self.status = status
  self.progress = progress
  self.rewards = rewards
  self._callback = callback
  self:SetOrderNumber()
  self:SetStatus()
  self:SetTitleText()
  self:SetAwards()
end

function UIS4BusinessProgress:SetOrderNumber()
  if self.number <= 2 then
    local colorStr = string.format("<color=#A36E56>%s</color>", self.number)
    self.numberTxt:SetText(colorStr)
    self.icon.sprite = self._atlas:GetSprite("exp_s4_paoshang_task_rare1")
  elseif self.number <= 4 then
    local colorStr = string.format("<color=#B5B7B8>%s</color>", self.number)
    self.numberTxt:SetText(colorStr)
    self.icon.sprite = self._atlas:GetSprite("exp_s4_paoshang_task_rare2")
  else
    local colorStr = string.format("<color=#C3A665>%s</color>", self.number)
    self.numberTxt:SetText(colorStr)
    self.icon.sprite = self._atlas:GetSprite("exp_s4_paoshang_task_rare3")
  end
end

function UIS4BusinessProgress:SetStatus()
  if self.status == UIS4BusinessStatus.CPPS_Accepted then
    self.notGet:SetActive(true)
    self.canGet:SetActive(false)
    self.got:SetActive(false)
  elseif self.status == UIS4BusinessStatus.CPPS_Completed then
    self.canGet:SetActive(true)
    if self.notGet.activeSelf then
      self.eff:SetActive(true)
      self.eff2:SetActive(true)
      self._anim:Play("uianim_UIS4BusinessProgress_receive")
    else
      self.CanGetCanvas.alpha = 1
    end
    self.notGet:SetActive(false)
    self.got:SetActive(false)
  elseif self.status == UIS4BusinessStatus.CPPS_Taken then
    self.notGet:SetActive(false)
    self.canGet:SetActive(false)
    self.got:SetActive(true)
  end
end

function UIS4BusinessProgress:SetTitleText(go)
  local titleStr = StringTable.Get("str_season_s4_trade_total_process_title_" .. self.number)
  self._name:SetText(titleStr)
  local introStr = StringTable.Get("str_season_s4_trade_total_process_intro_" .. self.number)
  self._condition:SetText(introStr)
end

function UIS4BusinessProgress:GetBtnOnClick(go)
  if self._callback then
    self._callback(self.progress)
  end
end

function UIS4BusinessProgress:SetAwards()
  local count = table.count(self.rewards)
  self.awardItems = self.AwardsPool:SpawnObjects("UISeasonItemS4", count)
  for i, v in ipairs(self.awardItems) do
    v:SetRect(0.8)
    local ra = RoleAsset:New()
    ra.assetid = self.rewards[i].assetid
    ra.count = self.rewards[i].count
    v:Flush(ra)
  end
end

function UIS4BusinessProgress:PlayProgressAnimIn()
  local LockName = "UIS4DiaryItem_AnimIN"
  self.canvas.alpha = 0
  self:StartTask(function(TT)
    YIELD(TT, self.number * 60)
    if not tolua.isnull(self._anim) then
      self._anim:Play("uianim_UIS4BusinessProgress_in")
    end
  end)
end
