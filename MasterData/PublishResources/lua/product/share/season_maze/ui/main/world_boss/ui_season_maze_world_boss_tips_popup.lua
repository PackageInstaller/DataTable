_class("UISeasonMazeWorldBossTipsPopUp", UIController)
UISeasonMazeWorldBossTipsPopUp = UISeasonMazeWorldBossTipsPopUp

function UISeasonMazeWorldBossTipsPopUp:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeWorldBossTipsPopUp:OnShow(uiParams)
  self:InitWidget()
  self.title = uiParams[1]
  self.tips = uiParams[2]
  self.titleText:SetText(StringTable.Get(self.title))
  self.tipsText:SetText(StringTable.Get(self.tips) .. [[






]])
end

function UISeasonMazeWorldBossTipsPopUp:InitWidget()
  self._anim = self:GetGameObject("_anim")
  self.titleText = self:GetUIComponent("UILocalizationText", "TitleText")
  self.tipsText = self:GetUIComponent("UILocalizationText", "TipsText")
end

function UISeasonMazeWorldBossTipsPopUp:BgOnClick(go)
  self:CloseDialog()
end
