_class("UICN14N43FrogGameGuide", UIController)
UICN14N43FrogGameGuide = UICN14N43FrogGameGuide

function UICN14N43FrogGameGuide:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UICN14N43FrogGameGuide:OnShow(uiParams)
  self:InitWidget()
end

function UICN14N43FrogGameGuide:InitWidget()
  self._animation = self:GetUIComponent("Animation", "SafeArea")
end

function UICN14N43FrogGameGuide:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UICN14N43FrogGameGuide:OpenBtnOnClick(go)
  self:StartTask(function(TT)
    self._animation:Play("uieff_UICN14N43FrogGameGuide_out")
    YIELD(TT, 300)
    GameGlobal.UIStateManager():ShowDialog("UISideEnterCenterController", {
      campaign_type = ECampaignType.CAMPAIGN_TYPE_COLLECT_FROG,
      single_mode = false,
      params = {true}
    })
    self:CloseDialog()
  end, self)
end
