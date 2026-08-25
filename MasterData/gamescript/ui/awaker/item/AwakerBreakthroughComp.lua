local VerticalLayoutGroup = CS.UnityEngine.UI.VerticalLayoutGroup
local AwakerBreakthroughComp, Super = System.NewComponent("AwakerBreakthroughComp", AwakerBasePageComp)

function AwakerBreakthroughComp:ctor(uiNode, model)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Topped_DetailResource(uiNode)
  self.model = model
  local tid = self.model.selectAwakerId
  local maxStar = self.model:GetAwakerBreakthroughMaxStar(tid)
  self.breakthroughStars = AwakerBreakthroughStars(self.ui.RootStars, maxStar)
end

function AwakerBreakthroughComp:OnBind(binder)
  self.binder = binder
  self.attrModel = self.binder:createModel(AwakerAttrModel, self.model)
  local goldId = CommonDefine.CurrencyType.JuniorMoney
  binder:BindComponent(CoinInfoComponent(self.ui.Coin_Gold, goldId))
  binder:BindToImage(self.ui.Image_Awaker_Career_Icon, function()
    local tid = self.model.selectAwakerId
    local config = self.model:GetAwakerConfig(tid)
    if not config then
      return ""
    end
    local iconPath = self.model:GetSchoolIcon(config.School)
    return iconPath
  end)
  binder:BindToText(self.ui.Text_Awaker_Name, function()
    local tid = self.model.selectAwakerId
    do return self.model.GetAwakerName, self.model end
    return self.model.GetAwakerName, self.model, tid
  end)
  binder:BindToRaw(function(_, awakerTid)
    local maxStar = self.model:GetAwakerBreakthroughMaxStar(awakerTid)
    self.breakthroughStars:AdjustStarCount(maxStar)
    local numStars = self.model:GetAwakerCurrBreakthroughStar(awakerTid)
    self:_TurnOnBreakthroughStars(numStars)
  end, function()
    return self.model.selectAwakerId
  end)
  binder:BindToRaw(function(_, numStars)
    if not numStars then
      return
    end
    self:_TurnOnBreakthroughStars(numStars)
  end, function()
    local tid = self.model.selectAwakerId
    do return self.model.GetAwakerCurrBreakthroughStar, self.model end
    return self.model.GetAwakerCurrBreakthroughStar, self.model, tid
  end)
  binder:BindButtonClick(self.ui.Btn_BreakthroughPreview, function()
    UIManager.Instance:Reopen(Urls.AwakerBreakthroughPreviewPanel, self.model)
  end)
  binder:BindToText(self.ui.Text_Number_Old, function()
    local tid = self.model.selectAwakerId
    local level = self.model:GetAwakerLevel(tid)
    local currLevelLimit = self.model:GetAwakerCurrLevelLimit(tid)
    do return string.format, "Lv.%s/%s", level end
    return string.format, "Lv.%s/%s", level, currLevelLimit
  end)
  binder:BindToText(self.ui.Text_Number_New, function()
    local tid = self.model.selectAwakerId
    local level = self.model:GetAwakerLevel(tid)
    local nextLevelLimit = self.model:GetAwakerNextLevelLimit(tid)
    do return string.format, "<color=white>%s/</color>%s", level end
    return string.format, "<color=white>%s/</color>%s", level, nextLevelLimit
  end)
  binder:BindToVisible(self.ui.Image_Skill, function()
    local awakerTid = self.model.selectAwakerId
    return self.model:GetAwakerNextBreakthroughStarSkillName(awakerTid) ~= nil
  end)
  binder:BindToText(self.ui.Text_Skill, function()
    local awakerTid = self.model.selectAwakerId
    return self.model:GetAwakerNextBreakthroughStarSkillName(awakerTid) or ""
  end)
  binder:BindToVisible(self.ui.Image_Skill_Icon, function()
    local awakerTid = self.model.selectAwakerId
    return self.model:GetAwakerNextBreakthroughStarSkillIcon(awakerTid) ~= nil
  end)
  binder:BindToImage(self.ui.Image_Skill_Icon, function()
    local awakerTid = self.model.selectAwakerId
    return self.model:GetAwakerNextBreakthroughStarSkillIcon(awakerTid) or ""
  end)
  binder:BindToRaw(function()
    if self.model:HasOwnedAwaker(self.model.selectAwakerId) then
      self.model:CalcNextBreakthroughStarAttrChange(self.model.selectAwakerId, self.attrModel)
    end
  end, function()
    return self.attrModel.baseAttrs
  end)
  binder:BindToCircularListView(self.ui.ScrollView_AttrAdd, function()
    local awakerTid = self.model.selectAwakerId
    do return self.model.GetAwakerNextBreakthroughStarAttrChange, self.model end
    return self.model.GetAwakerNextBreakthroughStarAttrChange, self.model, awakerTid
  end, function(itemBinder, obj, index)
    local awakerTid = self.model.selectAwakerId
    local attrChangeList = self.model:GetAwakerNextBreakthroughStarAttrChange(awakerTid)
    itemBinder:BindComponent(AwakerBreakthroughAttrAdd(obj, attrChangeList[index]))
  end)
  binder:BindToRaw(function(childBinder, mtrlCost)
    local mtrlRootTrans = self.ui.MaterialRoot.transform
    for idx = 0, mtrlRootTrans.childCount - 1 do
      local mtrlGO = mtrlRootTrans:GetChild(idx).gameObject
      local cost = mtrlCost[idx + 1]
      local itemID = cost and cost.id or -1
      local item = ItemDataUtils.GetItemByTid(itemID)
      local itemInfo = {
        id = itemID,
        currCount = item and item.num or 0,
        requiredCount = cost and cost.count or 0
      }
      childBinder:BindComponent(AwakerBreakthroughMaterial(mtrlGO, itemInfo))
    end
  end, function()
    local awakerTid = self.model.selectAwakerId
    do return self.model.GetAwakerNextBreakthroughStarMtrlCost, self.model end
    return self.model.GetAwakerNextBreakthroughStarMtrlCost, self.model, awakerTid
  end)
  binder:BindToText(self.ui.Text_Coin_Count, function()
    local currGoldCount = ItemDataUtils.GetItemNum(goldId)
    local awakerTid = self.model.selectAwakerId
    local requiredGoldCount = self.model:GetAwakerNextBreakthroughStarGoldCost(awakerTid)
    local effectType = CommonDefine.AwakerSpecialSkillType.ResNeedReduce
    local funcModule = "AwakerBreakThrough"
    local effectResultValue = self.model:GetResNeedReducePreviewResult(requiredGoldCount, effectType, funcModule)
    if effectResultValue and effectResultValue ~= requiredGoldCount then
      local extraStr = LT.Textf("<color=#9A9A9A><Del:{s1}></color>", requiredGoldCount)
      if currGoldCount < effectResultValue then
        effectResultValue = string.format("<Color4:%d>", effectResultValue)
      end
      return effectResultValue .. " " .. extraStr
    end
    if currGoldCount >= requiredGoldCount then
      return requiredGoldCount
    else
      do return string.format, "<Color4:%d>" end
      return string.format, "<Color4:%d>", requiredGoldCount, extraStr
    end
  end)
  binder:BindZ1Button(self.ui.Btn_Breakthrough, function()
    local awakerTid = self.model.selectAwakerId
    if not self.model:GetAwakerNextBreakthroughStarCostMtrlEnough(awakerTid) then
      local costMoney = AwakerDataUtils.GetNextBreakthroughGold(awakerTid)
      if not ItemAlchemyUtils.OpenUpgradeViewWithAwakerTid(awakerTid, false, costMoney) then
        Alert.Show(10559)
      end
      return
    end
    if not self.model:GetAwakerNextBreakthroughStarCostGoldEnough(awakerTid) then
      Alert.Show(10561)
      return
    end
    self.model:ReqBreakthrough(awakerTid, function()
      UIManager.Instance:Reopen(Urls.AwakerBreakthroughSuccessPanel, self.model, self.attrModel)
    end)
  end, function()
    local awakerTid = self.model.selectAwakerId
    local mtrlEnough = self.model:GetAwakerNextBreakthroughStarCostMtrlEnough(awakerTid)
    local goldEnough = self.model:GetAwakerNextBreakthroughStarCostGoldEnough(awakerTid)
    local costMoney = AwakerDataUtils.GetNextBreakthroughGold(awakerTid)
    if (mtrlEnough or ItemAlchemyUtils.OpenUpgradeViewWithAwakerTid(awakerTid, true, costMoney)) and goldEnough then
      return CommonDefine.BtnType.Normal
    else
      return CommonDefine.BtnType.Unclickable
    end
  end, function()
    local awakerTid = self.model.selectAwakerId
    local mtrlEnough = self.model:GetAwakerNextBreakthroughStarCostMtrlEnough(awakerTid)
    local goldEnough = self.model:GetAwakerNextBreakthroughStarCostGoldEnough(awakerTid)
    local costMoney = AwakerDataUtils.GetNextBreakthroughGold(awakerTid)
    if mtrlEnough and goldEnough or not ItemAlchemyUtils.OpenUpgradeViewWithAwakerTid(awakerTid, true, costMoney) then
      do return LT.Text end
      return LT.Text, "BreakThrough_Detail_Btn_Str", true, costMoney
    else
      do return LT.Text end
      return LT.Text, "AwakerUpgradeMaterialCompose", true, costMoney
    end
  end)
  binder:BindToRaw(function(_, match)
    self.ui.Btn_Breakthrough:SetActive(match)
    self.ui.Group_Warning:SetActive(not match)
  end, function()
    local awakerTid = self.model.selectAwakerId
    local list = self.model:GetAwakerBreakthroughNextLvRequireTask(awakerTid)
    local tasksFirst = list[1]
    local tasksSecond = list[2]
    local tasksThrid = list[3]
    local taskFirstFinish = TaskDataUtils.CheckTaskListIsAllDone(tasksFirst)
    local taskSecondFinish = TaskDataUtils.CheckTaskListIsAllDone(tasksSecond)
    local tasksThridFinish = TaskDataUtils.CheckTaskListIsAllDone(tasksThrid)
    return taskFirstFinish or taskSecondFinish or tasksThridFinish
  end)
  binder:BindToText(self.ui.Text_Warning, function()
    do return LT.Text end
    return LT.Text, "BreakThrough_Task_Requirement"
  end)
  binder:BindToText(self.ui.Text_C_Condition, function()
    do return LT.Text end
    return LT.Text, "BreakThroughCondition_1"
  end)
  binder:BindToText(self.ui.Text_C_Condition_2, function()
    do return LT.Text end
    return LT.Text, "BreakThroughCondition_2"
  end)
  binder:BindToText(self.ui.Text_C_Condition_3, function()
    do return LT.Text end
    return LT.Text, "BreakThroughCondition_3"
  end)
  local vg1 = self.ui.Image_List_1:GetComponent(typeof(VerticalLayoutGroup))
  local vg2 = self.ui.Image_List_2:GetComponent(typeof(VerticalLayoutGroup))
  local vg3 = self.ui.Image_List_3:GetComponent(typeof(VerticalLayoutGroup))
  binder:BindToRaw(function(_, list)
    local taskFirst = list[1] or {}
    local taskSecond = list[2] or {}
    local taskThrid = list[3] or {}
    self.ui.Group_Condition:SetActive(#taskFirst > 0)
    self.ui.Group_Condition_2:SetActive(#taskSecond > 0)
    self.ui.Group_Condition_3:SetActive(#taskThrid > 0)
    local spacing = #taskThrid > 0 and 0 or 10
    vg1.spacing = spacing
    vg2.spacing = spacing
    vg3.spacing = spacing
  end, function()
    local awakerTid = self.model.selectAwakerId
    do return self.model.GetAwakerBreakthroughNextLvRequireTask, self.model end
    return self.model.GetAwakerBreakthroughNextLvRequireTask, self.model, awakerTid
  end)
  self:BindCondition(1)
  self:BindCondition(2)
  self:BindCondition(3)
  binder:BindToText(self.ui.Text_Steps, function()
    local tid = self.model.selectAwakerId
    local star = self.model:GetAwakerCurrBreakthroughStar(tid) + 1
    do return LT.Textf, "BreakthroughTitleText" end
    return LT.Textf, "BreakthroughTitleText", star
  end)
  binder:BindComponent(AwakerSpecialSkillAdditionItem(self.ui.UI_Awaker_Button_Addition, CommonDefine.AwakerSpecialSkillType.ResNeedReduce, "AwakerBreakThrough"))
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Content)
end

function AwakerBreakthroughComp:BindCondition(index)
  self.binder:BindRawTable(function()
    local awakerTid = self.model.selectAwakerId
    local list = self.model:GetAwakerBreakthroughNextLvRequireTask(awakerTid)
    local taskList = list[index] or {}
    return taskList
  end, function(childBinder, taskId, _, _)
    if nil == childBinder then
      return
    end
    childBinder:BindNewComponent(self.ui["Image_List_" .. index], BreakthroughConditionItem, UI_Awaker_Item_ConditionResource, taskId)
  end)
end

function AwakerBreakthroughComp:OnUnbind()
  Super.OnUnbind(self)
end

function AwakerBreakthroughComp:_TurnOnBreakthroughStars(numStars)
  for idx = 1, self.breakthroughStars:NumStars() do
    if idx <= numStars then
      self.breakthroughStars:TurnOn(idx)
    elseif idx == numStars + 1 then
      self.breakthroughStars:PreTurnOn(idx)
    else
      self.breakthroughStars:TurnOff(idx)
    end
  end
end

function AwakerBreakthroughComp:OnOpen()
  self.ui.uiNode:SetActive(true)
end

function AwakerBreakthroughComp:OnClose()
  self.ui.uiNode:SetActive(false)
end

function AwakerBreakthroughComp:OnEnterDetail()
  self.ui.uiNode:SetActive(true)
end

function AwakerBreakthroughComp:OnExitDetail()
  self.ui.uiNode:SetActive(false)
end

function AwakerBreakthroughComp:GetEnterDetailAnim()
  return "UI_Awaker_Item_Topped_Detail_Open", nil
end

function AwakerBreakthroughComp:GetExitDetailAnim()
  return "UI_Awaker_Item_Topped_Detail_Close", nil
end

return AwakerBreakthroughComp
