_class("UISeasonBalanceWeightController", UIController)
UISeasonBalanceWeightController = UISeasonBalanceWeightController

function UISeasonBalanceWeightController:GetComponents()
  self._weightPool = {}
  local w1pool = self:GetUIComponent("UISelectObjectPath", "w1")
  local w1 = w1pool:SpawnObject("UISeasonBalanceWeightItem")
  local w2pool = self:GetUIComponent("UISelectObjectPath", "w2")
  local w2 = w2pool:SpawnObject("UISeasonBalanceWeightItem")
  local w3pool = self:GetUIComponent("UISelectObjectPath", "w3")
  local w3 = w3pool:SpawnObject("UISeasonBalanceWeightItem")
  self._weightPool[1] = w1
  self._weightPool[2] = w2
  self._weightPool[3] = w3
  self._tips = self:GetUIComponent("UILocalizationText", "tips")
  self._enter = self:GetGameObject("enter")
  local backBtn = self:GetUIComponent("UISelectObjectPath", "backBtn")
  self._backBtn = backBtn:SpawnObject("UISeasonTopBtn")
  self._backBtn:SetData(function()
    self:CloseDialog()
  end)
end

function UISeasonBalanceWeightController:OnShow(uiParams)
  self._closeCallback = uiParams[2]
  self:GetComponents()
  self._finish = false
  self._enterFinish = false
  local mapPoint = uiParams[1]
  self._missionid = mapPoint:GetID()
  self:ShowWeightInfo()
end

function UISeasonBalanceWeightController:ShowWeightInfo()
  local cfgs = Cfg.cfg_season_balance({
    StageID = self._missionid
  })
  if cfgs and next(cfgs) then
    local cfg = cfgs[1]
    local weights = cfg.WeightList
    local allHave = true
    local itemModule = GameGlobal.GetModule(ItemModule)
    for i = 1, #weights do
      local weightid = weights[i]
      local count = itemModule:GetItemCount(weightid)
      local have = false
      if count and 0 < count then
        have = true
      end
      local widget = self._weightPool[i]
      widget:SetData(i, have, weightid)
      if not have and allHave then
        allHave = false
      end
    end
    local tipsTex = allHave and "str_season_s2_last_quiz_2" or "str_season_s2_last_quiz_1"
    local showTex
    if allHave then
      showTex = "<color=#fff7e9>" .. StringTable.Get(tipsTex) .. "</color>"
    else
      showTex = "<color=#dcc4ae>" .. StringTable.Get(tipsTex) .. "</color>"
    end
    self._tips:SetText(showTex)
    self._enter:SetActive(allHave)
    self._finish = allHave
  else
    Log.error("###[UISeasonBalanceWeightController] cfg_season_balance is nil ! missionid : ", self._missionid)
  end
end

function UISeasonBalanceWeightController:OnHide()
  if self._closeCallback then
    self._closeCallback(self._enterFinish)
  end
end

function UISeasonBalanceWeightController:EnterBtnOnClick(go)
  if self._finish then
    self._enterFinish = true
  end
  self:CloseDialog()
end
