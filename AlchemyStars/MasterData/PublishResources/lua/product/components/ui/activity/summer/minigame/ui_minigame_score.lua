_class("UIMiniGameScore", UICustomWidget)
UIMiniGameScore = UIMiniGameScore

function UIMiniGameScore:Constructor()
end

function UIMiniGameScore:OnShow(uiParams)
  self:_GetComponents()
end

function UIMiniGameScore:_GetComponents()
  self.score = self:GetUIComponent("UILocalizationText", "Score")
end

function UIMiniGameScore:SetData(score)
  self.score:SetText("+" .. score)
end

function UIMiniGameScore:SetPosition(position, offset)
  self.view.transform.position = position
  self.view.transform.localPosition = self.view.transform.localPosition + offset
end

function UIMiniGameScore:SetActive(active)
  self.view.gameObject:SetActive(active)
end
