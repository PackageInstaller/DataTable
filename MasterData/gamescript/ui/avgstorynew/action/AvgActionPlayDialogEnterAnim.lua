local CanvasGroup = CS.UnityEngine.CanvasGroup
local AvgActionPlayDialogEnterAnim = System.NewClass("AvgActionPlayDialogEnterAnim", AvgActionBase)

function AvgActionPlayDialogEnterAnim:DoAction(_, data, finishCb)
  finishCb()
  local isShowAnim = data.isShowAnim
  if not isShowAnim then
    local alpha = self.ui.Image_Dialog_Bg:GetComponent(typeof(CanvasGroup)).alpha
    if 1 ~= alpha then
      isShowAnim = true
    end
  end
  if isShowAnim then
    self.avgPanel.uiAnimController:PlayState("UI_Story_Panel_Group_Dialog_danru_vx", function()
    end)
  end
end

return AvgActionPlayDialogEnterAnim
