_class("UIN20MiniGameScore", UICustomWidget)
UIN20MiniGameScore = UIN20MiniGameScore

function UIN20MiniGameScore:Constructor()
end

function UIN20MiniGameScore:OnShow(uiParams)
  self:_GetComponents()
end

function UIN20MiniGameScore:_GetComponents()
  self.scoreOutline = self:GetUIComponent("UILocalizationText", "ScoreOutline")
  self.score = self:GetUIComponent("UILocalizationText", "Score")
end

function UIN20MiniGameScore:SetData(score)
  self.scoreOutline:SetText("+" .. score)
  self.score:SetText("+" .. score)
end

function UIN20MiniGameScore:SetPosition(position, offset)
  self.view.transform.position = position
  self.view.transform.localPosition = self.view.transform.localPosition + offset
end

function UIN20MiniGameScore:SetActive(active)
  self.view.gameObject:SetActive(active)
end
