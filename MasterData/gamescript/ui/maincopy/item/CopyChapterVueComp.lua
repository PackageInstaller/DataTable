local CopyChapterVueComp, Super = System.NewComponent("CopyChapterVueComp")

function CopyChapterVueComp:ctor(uiNode, stageId, isShowRound)
  Super.ctor(self)
  self.ui = UI_Common_Btn_StageChapterResource(uiNode)
  self.stageId = stageId
  self.isShowRound = isShowRound
end

function CopyChapterVueComp:OnBind(binder)
  self.binder = binder
  local stageChapter = CopyDataUtils.GetStageChapter(self.stageId)
  if not stageChapter then
    self.binder:SetActive(self.ui.uiNode, false)
  else
    self.binder:SetActive(self.ui.uiNode, true)
    local text, index = CopyDataUtils.GetStageChapterTextAndIdx(self.stageId)
    if not self.isShowRound then
      self.binder:SetText(self.ui.Text_ChapterName, text)
    else
      self.binder:BindToRaw(function(_, phaseData)
        local nowPhase = phaseData.nowPhase
        local curIndex = phaseData.curIndex
        local totalIndex = phaseData.totalIndex
        if nowPhase and curIndex and totalIndex then
          self.binder:SetActive(self.ui.Text_ChapterName, true)
          self.binder:SetText(self.ui.Text_ChapterName, nowPhase .. "-" .. curIndex .. "/" .. totalIndex)
          self.binder:SetActive(self.ui.ChapterNameView, true)
        elseif curIndex and totalIndex then
          self.binder:SetActive(self.ui.Text_ChapterName, true)
          self.binder:SetText(self.ui.Text_ChapterName, curIndex .. "/" .. totalIndex)
          self.binder:SetActive(self.ui.ChapterNameView, true)
        else
          self.binder:SetText(self.ui.Text_ChapterName, "1/1")
          self.binder:SetActive(self.ui.ChapterNameView, false)
        end
      end, function()
        local nowPhase, curIndex, totalIndex = RailWayDataUtils.GetRailWayStageNow(self.stageId)
        return {
          nowPhase = nowPhase,
          curIndex = curIndex,
          totalIndex = totalIndex
        }
      end)
    end
    if index then
      for i = 1, 5 do
        if self.ui["Image_Bg" .. i] then
          self.binder:SetActive(self.ui["Image_Bg" .. i], index == i)
        end
      end
    end
    if self.ui.Btn_Click then
      self.binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnBtnClick))
    end
  end
  self:CheckIsHide()
end

function CopyChapterVueComp:CheckIsHide()
  local stageCfg = CopyDataUtils.GetStageCfg(self.stageId)
  if stageCfg and stageCfg.MapType == cd.StageMapType.Story then
    self.binder:SetActive(self.ui.uiNode, false)
  else
    self.binder:SetActive(self.ui.uiNode, true)
  end
end

function CopyChapterVueComp:OnBtnClick()
  if UIManager.Instance:GetWindow(Urls.CopyChapterDetailView) then
    UIManager.Instance:CloseByUrl(Urls.CopyChapterDetailView)
    return
  end
  UIManager.Instance:Reopen(Urls.CopyChapterDetailView, self.stageId)
end

return CopyChapterVueComp
