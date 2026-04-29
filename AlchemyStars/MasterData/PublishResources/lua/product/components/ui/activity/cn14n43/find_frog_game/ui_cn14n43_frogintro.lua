_class("UICN14N43FrogIntro", UIController)
UICN14N43FrogIntro = UICN14N43FrogIntro

function UICN14N43FrogIntro:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UICN14N43FrogIntro:OnShow(uiParams)
  self:InitWidget()
end

function UICN14N43FrogIntro:InitWidget()
  self._title = self:GetUIComponent("UILocalizationText", "_title")
  self._animation = self:GetUIComponent("Animation", "Anim")
end

function UICN14N43FrogIntro:CloseBtnOnClick(go)
  self:StartTask(function(TT)
    self._animation:Play("effanim_UICN14N43FrogIntro_out")
    YIELD(TT, 200)
    self:CloseDialog()
  end, self)
end
