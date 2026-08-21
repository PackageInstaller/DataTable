_class("UICN19N48MiniGameScore", UICustomWidget)
UICN19N48MiniGameScore = UICN19N48MiniGameScore

function UICN19N48MiniGameScore:Constructor()
end

function UICN19N48MiniGameScore:OnShow(uiParams)
  self:_GetComponents()
end

function UICN19N48MiniGameScore:_GetComponents()
  self.scoreOutline = self:GetUIComponent("UILocalizationText", "ScoreOutline")
  self.score = self:GetUIComponent("UILocalizationText", "Score")
end

function UICN19N48MiniGameScore:SetData(score)
  self.scoreOutline:SetText("+" .. score)
  self.score:SetText("+" .. score)
end

function UICN19N48MiniGameScore:SetPosition(position, offset)
  self.view.transform.position = position
  self.view.transform.localPosition = self.view.transform.localPosition + offset
end

function UICN19N48MiniGameScore:SetActive(active)
  self.view.gameObject:SetActive(active)
end
