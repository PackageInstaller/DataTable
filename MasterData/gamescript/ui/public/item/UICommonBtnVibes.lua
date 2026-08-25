local UICommonBtnVibes, Super = System.NewComponent("UICommonBtnVibes")

function UICommonBtnVibes:ctor(uiNode, btnFunc, btnText)
  Super.ctor(self)
  self.ui = UI_Common_Btn_VibesResource(uiNode)
  self.btnFunc = btnFunc
  self.btnText = Vue.ref(btnText)
end

function UICommonBtnVibes:OnBind(binder)
  binder:onDestroy(function()
    self.btnFunc = nil
  end)
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if self.btnFunc then
      self.btnFunc()
    end
  end)
  binder:BindToText(self.ui.Text_Effect, function()
    do return LT.Text, self.btnText.value end
    return LT.Text, self.btnText.value, true
  end)
end

function UICommonBtnVibes.BindCommonBtnVibes(binder, uiNode, gearUid)
  local gearType = WorldStageManager.Instance:GetCurTriggeredGearType()
  local curGearData = WorldStageManager.Instance:GetCurTriggerGearData()
  local gearConfig = curGearData and DT.MapNode[curGearData.tid]
  local resonanceGroupName = gearConfig and gearConfig.ResonanceHint
  
  local function doBindCommonBtnVibes()
    local activeResonanceList = ResonanceDataUtils.GetActiveResonanceList(WorldStageManager.Instance.curGroupId)
    binder:BindToVisible(uiNode, function()
      if not ResonanceDataUtils.IsMapNodeTypeRelateToResonance(gearType) then
        return false
      end
      if resonanceGroupName then
        return true
      end
      if not gearType or 0 == #activeResonanceList then
        return false
      end
      local gear = gearUid and WorldStageManager.Instance:GetGearObj(gearUid)
      if gear and gear:GetIsChoas() then
        return false
      end
      do return ResonanceDataUtils.IsMapNodeTypeRelateToResonance end
      return ResonanceDataUtils.IsMapNodeTypeRelateToResonance, gearType
    end)
  end
  
  local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(WorldStageManager.Instance.curGroupId)
  ResonanceDataUtils.ReqResonanceData(resonanceGroupId, doBindCommonBtnVibes)
  binder:BindUIBehavior(uiNode, function()
    UIManager.Instance:Reopen(Urls.CopyStageResonanceDetailPanel, resonanceGroupName)
  end, LT.Text("ResonanceRelateToEvent"))
  doBindCommonBtnVibes()
end

return UICommonBtnVibes
