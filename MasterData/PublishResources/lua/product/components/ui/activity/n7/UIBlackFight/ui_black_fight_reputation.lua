_class("UIBlackFightReputation", UIController)
UIBlackFightReputation = UIBlackFightReputation

function UIBlackFightReputation:Constructor()
  local mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = mCampaign:GetN7BlackFightData()
end

function UIBlackFightReputation:LoadDataOnEnter(TT, res, uiParams)
  self.data:RequestCampaign(TT)
end

function UIBlackFightReputation:OnShow(uiParams)
  local btns = self:GetUIComponent("UISelectObjectPath", "btns")
  self._backBtns = btns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityN7MainRefresh)
    self:CloseDialog()
  end)
  self.imgBelt = self:GetUIComponent("RawImageLoader", "imgBelt")
  self.txtSalutation = self:GetUIComponent("UILocalizationText", "txtSalutation")
  self.txtSalutationOL = self:GetUIComponent("UILocalizationText", "txtSalutationOL")
  self.txtSalutationGlow = self:GetUIComponent("UILocalizationText", "txtSalutationGlow")
  self.txtReputation = self:GetUIComponent("UILocalizationText", "txtReputation")
  self.poolContent = self:GetUIComponent("UISelectObjectPath", "Content")
  self.rtContent = self:GetUIComponent("RectTransform", "Content")
  self.poolPaper = self:GetUIComponent("UISelectObjectPath", "paper")
  self.btnPaper = self:GetUIComponent("RectTransform", "btnPaper")
  self.redPaper = self:GetGameObject("redPaper")
  local selectInfo = self:GetUIComponent("UISelectObjectPath", "selectInfo")
  self.tips = selectInfo:SpawnObject("UISelectInfo")
  self.btnGetAll = self:GetGameObject("btnGetAll")
  self:AttachEvent(GameEventType.AircraftInteractiveEventRewardShowItemTips, self.ShowItemInfo)
  self:AttachEvent(GameEventType.BlackFistUpdatePaperRed, self.FlushPaper)
  self:Flush()
end

function UIBlackFightReputation:OnHide()
  self:DetachEvent(GameEventType.AircraftInteractiveEventRewardShowItemTips, self.ShowItemInfo)
  self:DetachEvent(GameEventType.BlackFistUpdatePaperRed, self.FlushPaper)
end

function UIBlackFightReputation:Flush()
  local curSalutation = self.data:GetCurSalutation()
  if curSalutation then
    UIBlackFightMain.FlushTextColorOutline(curSalutation, self.txtSalutation, self.txtSalutationOL, self.txtSalutationGlow, self.imgBelt, 1)
  end
  self.txtReputation:SetText(self.data:GetReputation())
  self:FlushReputationsAndSalutations()
  self:FlushPaper()
  self:Roll2Target()
end

function UIBlackFightReputation:FlushReputationsAndSalutations()
  local len = table.count(self.data.reputations)
  self.poolContent:SpawnObjects("UIBlackFightReputationItem", len)
  local uis = self.poolContent:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    ui:Flush(self.data.reputations[i], function()
      if self.curSelect then
        self.curSelect:FlushSelect(false)
      end
      self.curSelect = ui
      self.curSelect:FlushSelect(true)
    end, i)
  end
  self.btnGetAll:SetActive(self.data:ExistCanGetAwards())
end

function UIBlackFightReputation:FlushPaper()
  local paper = self.data:GetPaperByIdx(self.data.curOverviewPaper.idx)
  self:FlushElements(paper)
  self.btnPaper.anchoredPosition = self.data.curOverviewPaper.btnPos
  local existNotReadPaper, _ = self.data:ExistNotReadPaper()
  self.redPaper:SetActive(existNotReadPaper)
end

function UIBlackFightReputation:FlushElements(paper)
  local ui = self.poolPaper:SpawnObject("UIBlackFightPaperItem")
  ui:Flush(paper)
end

function UIBlackFightReputation:Roll2Target()
  local reputations = self.data.reputations
  if not reputations then
    return
  end
  if table.count(reputations) <= 0 then
    return
  end
  local target
  for i, v in ipairs(reputations) do
    if v.gotState == BlackFightReputationState.CanGet then
      target = i
      break
    end
  end
  if not target then
    for i, v in ipairs(reputations) do
      if v.gotState == nil then
        target = i
        break
      end
    end
  end
  local uis = self.poolContent:GetAllSpawnList()
  if uis then
    target = target or table.count(uis)
    local ui = uis[target]
    local rt = ui:GetGameObject():GetComponent(typeof(UnityEngine.RectTransform))
    UnityEngine.Canvas.ForceUpdateCanvases()
    local v3 = self.rtContent.transform:InverseTransformPoint(self.rtContent.position) - self.rtContent.transform:InverseTransformPoint(rt.position)
    self.rtContent.anchoredPosition = Vector2(0, v3.y - rt.rect.height * 0.5)
  end
end

function UIBlackFightReputation:ShowItemInfo(matid, pos)
  self.tips:SetData(matid, pos)
end

function UIBlackFightReputation:btnGetAllOnClick(go)
  self:StartTask(function(TT)
    local c = self.data:GetComponentReputation()
    local res = AsyncRequestRes:New()
    local awards = c:HandleOneKeyReceiveRewards(TT, res)
    if awards and table.count(awards) > 0 then
      UIBlackFightReputationItem.ShowRewards(awards)
      self.data:SetReputationsGot()
      self:FlushReputationsAndSalutations()
    end
  end, self)
end

function UIBlackFightReputation:btnPaperOnClick(go)
  self:ShowDialog("UIBlackFightPaper")
end
