local UIS4ProfitStatus = {
  CPPS_Accepted = 1,
  CPPS_Completed = 2,
  CPPS_Taken = 3
}
_enum("UIS4ProfitStatus", UIS4ProfitStatus)
_class("UIS4ProfitTarget", UICustomWidget)
UIS4ProfitTarget = UIS4ProfitTarget

function UIS4ProfitTarget:OnShow(uiParams)
  self:InitWidget()
end

function UIS4ProfitTarget:InitWidget()
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self.notGet = self:GetGameObject("NotGet")
  self.canGet = self:GetGameObject("CanGet")
  self.got = self:GetGameObject("Got")
  self.AwardsPool = self:GetUIComponent("UISelectObjectPath", "Awards")
  self._anim = self:GetUIComponent("Animation", "_anim")
  self.canvas = self:GetUIComponent("CanvasGroup", "DataArea")
  self.CanGetCanvas = self:GetUIComponent("CanvasGroup", "CanGet")
  self.notGetTxt = self:GetUIComponent("UILocalizationText", "txt")
  self.eff = self:GetGameObject("eff")
  self.eff2 = self:GetGameObject("eff2")
end

function UIS4ProfitTarget:SetData(i, number, status, progress, rewards, callback)
  self.id = i
  self.number = number
  self.status = status
  self.progress = progress
  self.rewards = rewards
  self._callback = callback
  local titleStr = StringTable.Get("str_season_s4_trade_reward_process_title_1") .. number
  self._name:SetText(titleStr)
  self:SetStatus()
  self:SetAwards()
end

function UIS4ProfitTarget:SetStatus()
  if self.status == UIS4ProfitStatus.CPPS_Accepted then
    self.notGet:SetActive(true)
    self.notGetTxt.color = Color(0.25098039215686274, 0.23921568627450981, 0.23529411764705882, 1)
    self.canGet:SetActive(false)
    self.got:SetActive(false)
  elseif self.status == UIS4ProfitStatus.CPPS_Completed then
    self.canGet:SetActive(true)
    if self.notGet.activeSelf then
      self.eff:SetActive(true)
      self.eff2:SetActive(true)
      self._anim:Play("uianim_UIS4ProfitTarget_receive")
    else
      self.CanGetCanvas.alpha = 1
    end
    self.notGet:SetActive(false)
    self.got:SetActive(false)
  elseif self.status == UIS4ProfitStatus.CPPS_Taken then
    self.notGet:SetActive(false)
    self.canGet:SetActive(false)
    self.got:SetActive(true)
  end
end

function UIS4ProfitTarget:CanGetOnClick(go)
  if self._callback then
    self._callback(self.progress)
  end
end

function UIS4ProfitTarget:SetAwards()
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

function UIS4ProfitTarget:PlayProfitAnimIn()
  local LockName = "UIS4DiaryItem_AnimIN"
  self.canvas.alpha = 0
  self:StartTask(function(TT)
    YIELD(TT, self.id * 60)
    if not tolua.isnull(self._anim) then
      self._anim:Play("uianim_UIS4ProfitTarget_in")
    end
  end)
end
