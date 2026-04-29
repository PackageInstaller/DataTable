_class("UICN13PerfectPuzzleIntro", UIController)
UICN13PerfectPuzzleIntro = UICN13PerfectPuzzleIntro

function UICN13PerfectPuzzleIntro:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UICN13PerfectPuzzleIntro:OnShow(uiParams)
  self:InitWidget()
end

function UICN13PerfectPuzzleIntro:InitWidget()
  self._root = self:GetGameObject("_root")
  self._title = self:GetUIComponent("UILocalizationText", "_title")
  self._subTitle = self:GetUIComponent("UILocalizationText", "_subTitle")
  self._pool = self:GetUIComponent("UISelectObjectPath", "_pool")
  self.mainBg = self:GetUIComponent("RawImageLoader", "MainBg")
end

function UICN13PerfectPuzzleIntro:CloseBtnOnClick(go)
  self:CloseDialog()
end
