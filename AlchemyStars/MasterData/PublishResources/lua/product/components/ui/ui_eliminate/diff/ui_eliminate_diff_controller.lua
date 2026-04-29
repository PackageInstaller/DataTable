_class("UIEliminateDiffController", UIController)
UIEliminateDiffController = UIEliminateDiffController

function UIEliminateDiffController:Constructor()
end

function UIEliminateDiffController:OnShow(uiParams)
  self:_GetComponent()
end

function UIEliminateDiffController:OnHide()
end

function UIEliminateDiffController:_GetComponent()
  self._hardCfg = Cfg.cfg_anipop_hard({})
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._diffItems = self._content:SpawnObjects("UIEliminateDiffItem", #self._hardCfg)
  self._scrollRect = self:GetUIComponent("ScrollRect", "Scroll View")
  for i, item in pairs(self._diffItems) do
    item:SetData(self._hardCfg[i], i, function(hardID)
      self:StartTask(function(TT)
        local anipopModule = GameGlobal.GetModule(AnipopModule)
        local res = anipopModule:SelectHard(TT, hardID)
        if res:GetSucc() then
          self:SwitchState(UIStateType.UIEliminateLevelController)
        else
          Log.fatal("选择难度错误：", res:GetResult())
          self:CloseDialog()
        end
      end)
    end, self)
  end
  local anipopModule = GameGlobal.GetModule(AnipopModule)
  local anipopInfo = anipopModule:GetAniPopInfo()
  local percent = anipopInfo.cur_hard_id / #self._hardCfg
  if anipopInfo.cur_hard_id == 1 then
    percent = 0
  end
  self._scrollRect.horizontalNormalizedPosition = percent
end

function UIEliminateDiffController:CloseBtnOnClick()
  self:_Close()
end

function UIEliminateDiffController:_Close()
  self:StartTask(function(TT)
    self:Lock("uieff_UIEliminateDiffController_out")
    self._anim:Play("uieff_UIEliminateDiffController_out")
    YIELD(TT, 500)
    self:UnLock("uieff_UIEliminateDiffController_out")
    self:CloseDialog()
  end)
end
