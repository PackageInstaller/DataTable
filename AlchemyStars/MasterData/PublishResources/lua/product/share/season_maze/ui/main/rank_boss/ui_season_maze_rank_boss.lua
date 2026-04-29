_class("UISeasonMazeRankBoss", UICustomWidget)
UISeasonMazeRankBoss = UISeasonMazeRankBoss

function UISeasonMazeRankBoss:InitWidget()
  self._go = self:GetGameObject("Go")
end

function UISeasonMazeRankBoss:OnShow()
  self:InitWidget()
  self:AttachEvent(GameEventType.OnKeyChange, self.SetData)
end

function UISeasonMazeRankBoss:SetData()
  local haveKey = false
  self._go:SetActive(haveKey)
end

function UISeasonMazeRankBoss:BtnOnClick(go)
  local pass = false
  local haveKey = false
  if not pass then
    local tips = "wei tong guan"
    ToastManager.ShowToast(tips)
    return
  end
  if not haveKey then
    local tips = "mei yao shi"
    ToastManager.ShowToast(tips)
    return
  end
  ToastManager.ShowToast("enter boss rank !")
end

function UISeasonMazeRankBoss:OnHide()
end
