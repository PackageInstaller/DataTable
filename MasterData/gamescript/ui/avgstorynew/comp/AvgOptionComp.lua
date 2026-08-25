local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local AvgOptionComp, Super = System.NewClass("AvgOptionComp")

function AvgOptionComp:ctor(avgPanel, binder, avgModel)
  Super.ctor(self)
  self.ui = avgPanel.ui
  self.binder = binder
  self.avgPanel = avgPanel
  self.avgModel = avgModel
  self.isOptionShow = nil
  self.isPlayedOptionOpen = false
  self:OnBind(binder)
end

function AvgOptionComp:OnBind(binder)
  self:InitOptionItems(binder)
  binder:BindToRaw(function(_, optionIds, _)
    self:SetOptions(optionIds or {})
  end, function()
    local isShowOption = self:IsShowOption()
    local optionIds = self.avgModel.optionIds
    if not isShowOption then
      return nil
    end
    return optionIds
  end)
  binder:BindToRaw(function(_, isShow, _)
    if isShow then
      return
    end
    self:ShowOptionItems(false)
  end, function()
    do return self.IsShowOption end
    return self.IsShowOption, self
  end)
end

function AvgOptionComp:InitOptionItems(binder)
  for i = 1, 3 do
    local itemNode = self.ui["AvgOptionItem" .. i]
    local optionItemUI = AvgOptionItemResource(itemNode)
    
    local function PlayClickAnim()
      local animCtrl = itemNode:GetComponent(T_UIAnimationController)
      if animCtrl then
        animCtrl:PlayState("UX_Vx_Story_AvgOptionItem_Click", function()
          self:OnChooseOption(i)
        end)
      end
    end
    
    binder:BindButtonClick(optionItemUI.Btn_Click, PlayClickAnim)
    binder:BindButtonClick(optionItemUI.Text_Info, PlayClickAnim)
    binder:CheckUpdatePanelResource(itemNode, DataCenter.gameData.CurrTextLanguage)
  end
end

function AvgOptionComp:ShowOptionItems(isShow)
  if self.isOptionShow == isShow then
    return
  end
  if isShow then
    self.avgPanel.roleComp:SetAllRoleDark()
  end
  self.isOptionShow = isShow
  local animCtrl = self.ui.uiNode:GetComponent(T_UIAnimationController)
  if isShow then
    self.ui.GroupOption:SetActive(true)
    if animCtrl then
      animCtrl:StopPlayableGraph()
      animCtrl:PlayState("UI_Story_Panel_Main_GroupOptionItem_Open", function()
        self.ui.GroupOption:SetActive(true)
      end)
    end
    self.isPlayedOptionOpen = true
  else
    if self.isPlayedOptionOpen then
      if animCtrl then
        animCtrl:PlayState("UI_Story_Panel_Main_GroupOptionItem_Close", function()
          self.ui.GroupOption:SetActive(false)
        end)
      else
        self.ui.GroupOption:SetActive(false)
      end
    end
    self.isPlayedOptionOpen = false
  end
end

function AvgOptionComp:IsShowOption()
  local isShowOption = self.avgPanel.isShowOption.value
  local isHud = self.avgPanel.isManualHideDialog.value
  return isShowOption and not isHud
end

function AvgOptionComp:SetOptions(optionIds)
  for index = 1, 5 do
    local optionId = optionIds and optionIds[index]
    if self.ui["AvgOptionItem" .. index] then
      local optionGameUi = AvgOptionItemResource(self.ui["AvgOptionItem" .. index])
      optionGameUi.uiNode:SetActive(nil ~= optionId)
      if optionId then
        local optionInfo = AvgStoryManager.Instance:GetDialogInfo(self.avgModel.storyId, optionId)
        self.binder:SetText(optionGameUi.Text_Info, StrUtils.ReplaceAvgContent(optionInfo.Content))
      end
    end
  end
end

function AvgOptionComp:OnChooseOption(index)
  self.avgPanel.isShowOption.value = false
  self.avgModel:OnChooseOption(index)
end

return AvgOptionComp
