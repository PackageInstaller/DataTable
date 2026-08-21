_class("UISeasonBalanceEvidenceController", UIController)
UISeasonBalanceEvidenceController = UISeasonBalanceEvidenceController

function UISeasonBalanceEvidenceController:GetComponents()
  self._evidences = {}
  self._idx2animIdx = {
    [1] = 1,
    [2] = 3,
    [3] = 5,
    [4] = 2,
    [5] = 4,
    [6] = 6
  }
  self._evidenceCount = 6
  for i = 1, self._evidenceCount do
    local evidencePool = self:GetUIComponent("UISelectObjectPath", "e" .. i)
    local evidenceItem = evidencePool:SpawnObject("UISeasonBalanceEvidenceItem")
    self._evidences[i] = evidenceItem
  end
  self._tips = self:GetUIComponent("UILocalizationText", "tips")
  self._enter = self:GetGameObject("enter")
  local backBtn = self:GetUIComponent("UISelectObjectPath", "backBtn")
  self._backBtn = backBtn:SpawnObject("UISeasonTopBtn")
  self._backBtn:SetData(function()
    self:BgOnClick()
  end)
end

function UISeasonBalanceEvidenceController:OnShow(uiParams)
  self._closeCallback = uiParams[2]
  self:GetComponents()
  local mapPoint = uiParams[1]
  self._missionid = mapPoint:GetID()
  self:ShowEvidenceInfo()
end

function UISeasonBalanceEvidenceController:ShowEvidenceInfo()
  local cfgs = Cfg.cfg_season_balance({
    StageID = self._missionid
  })
  if cfgs and next(cfgs) then
    local cfg = cfgs[1]
    local evidences = cfg.EvidenceList
    self._balanceID = cfg.ID
    if evidences == nil or #evidences == 0 then
      self:ShowUnEvidenceView(cfg)
      return
    end
    if #evidences ~= self._evidenceCount then
      Log.error("###[UISeasonBalanceEvidenceController] cfg.EvidenceList count ~= self._evidenceCount ! missionid : ", self._missionid)
    end
    local allHave = true
    local itemModule = GameGlobal.GetModule(ItemModule)
    local yieldTime = 80
    for i = 1, self._evidenceCount do
      local evidenceid = evidences[i]
      local e_cfg = Cfg.cfg_season_evidence[evidenceid]
      if not e_cfg then
        Log.error("###[UISeasonBalanceEvidenceController] cfg_season_evidence is nil ! id : ", evidenceid)
      end
      local itemid = e_cfg.ItemID
      local count = itemModule:GetItemCount(itemid)
      local have = false
      if count and 0 < count then
        have = true
      end
      local widget = self._evidences[i]
      local animIdx = self._idx2animIdx[i]
      local item_yieldTime = yieldTime + (animIdx - 1) * 5 * 20
      widget:SetData(i, have, e_cfg, item_yieldTime)
      if not have and allHave then
        allHave = false
      end
    end
    local enoughStr = "str_season_s2_evidenough_1"
    local lostStr = "str_season_s2_evidlost_1"
    if cfg.CanBeginTitleStr ~= nil then
      enoughStr = cfg.CanBeginTitleStr
    end
    if cfg.UnCanTitleStr ~= nil then
      lostStr = cfg.UnCanTitleStr
    end
    local tipsTex = allHave and enoughStr or lostStr
    self._tips:SetText(StringTable.Get(tipsTex))
    self._enter:SetActive(allHave)
  else
    Log.error("###[UISeasonBalanceEvidenceController] cfg_season_balance is nil ! missionid : ", self._missionid)
  end
end

function UISeasonBalanceEvidenceController:ShowUnEvidenceView(cfg)
  self._enter:SetActive(true)
  local enoughStr = "str_season_s2_evidenough_1"
  if cfg.CanBeginTitleStr ~= nil then
    enoughStr = cfg.CanBeginTitleStr
  end
  self._tips:SetText(StringTable.Get(enoughStr))
end

function UISeasonBalanceEvidenceController:OnHide()
end

function UISeasonBalanceEvidenceController:BgOnClick(go)
  if self._closeCallback then
    self._closeCallback()
  end
  self:CloseDialog()
end

function UISeasonBalanceEvidenceController:EnterBtnOnClick(go)
  self:ShowDialog("UISeasonBalanceQAController", self._balanceID, function(finish)
    if self._closeCallback then
      self._closeCallback(finish)
    end
    self:CloseDialog()
  end)
end
