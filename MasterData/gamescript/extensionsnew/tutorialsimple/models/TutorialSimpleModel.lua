local TutorialSimpleModel = NewClass("TutorialSimpleModel", BaseModel)

function TutorialSimpleModel:OnInit()
  self:OnReset()
end

function TutorialSimpleModel:OnReset()
  self._tutorialTid = nil
  self._tutorialCfg = nil
  self._totalPage = 0
  self._curPage = 1
end

function TutorialSimpleModel:SetTutorialTid(tutorialTid)
  self._tutorialTid = tutorialTid
  self._tutorialCfg = DT.Tutorial[tutorialTid]
  self._totalPage = self._tutorialCfg and #self._tutorialCfg.data_list or 0
  self._curPage = 1
end

function TutorialSimpleModel:GetCurPage()
  return self._curPage
end

function TutorialSimpleModel:GetTotalPage()
  return self._totalPage
end

function TutorialSimpleModel:SetCurPage(page)
  self._curPage = page
end

function TutorialSimpleModel:GetCurPageData()
  if not self._tutorialCfg then
    return nil
  end
  return self._tutorialCfg.data_list[self._curPage]
end

return TutorialSimpleModel
