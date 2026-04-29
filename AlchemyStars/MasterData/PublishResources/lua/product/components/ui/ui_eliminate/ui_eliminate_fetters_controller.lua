_class("UIEliminateFettersController", UIController)
UIEliminateFettersController = UIEliminateFettersController

function UIEliminateFettersController:OnShow(uiParams)
  local fettersID = uiParams[1]
  local topBarPool = self:GetUIComponent("UISelectObjectPath", "CommonTopBar")
  local topBtns = topBarPool:SpawnObject("UINewCommonTopButton")
  topBtns:SetData(function()
    self:_Close()
  end)
  self._fettersCfgList = Cfg.cfg_anipop_fetters({FettersID = fettersID})
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._anim = self:GetUIComponent("Animation", "anim")
  self:_InitComponent()
end

function UIEliminateFettersController:_InitComponent()
  self._widgets = self._content:SpawnObjects("UIEliminateFettersItem", #self._fettersCfgList)
  for i, widget in pairs(self._widgets) do
    widget:SetData(self._fettersCfgList[i])
  end
end

function UIEliminateFettersController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.CN7PopStarStep4)
end

function UIEliminateFettersController:_Close()
  self:StartTask(function(TT)
    self:Lock("uieff_UIEliminateFettersController_out")
    self._anim:Play("uieff_UIEliminateFettersController_out")
    YIELD(TT, 400)
    self:UnLock("uieff_UIEliminateFettersController_out")
    self:CloseDialog()
  end)
end
