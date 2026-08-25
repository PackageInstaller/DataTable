local typeof = _ENV.typeof
local Animator = CS.UnityEngine.Animator
local AwakerSkillLevelUpPanel, Super = System.NewClass("AwakerSkillLevelUpPanel", UIBasePanel)
AwakerSkillLevelUpPanel.uiResCls = UI_Awaker_Popup_Skillup_TipResource

function AwakerSkillLevelUpPanel:ctor(model)
  Super.ctor(self)
  self.model = model
end

local function GetCostItemNumText(needNum, currNum, effectResultValue)
  if not needNum or not currNum then
    return ""
  end
  local currNumText = currNum
  local notEnough = currNum < needNum
  if effectResultValue then
    notEnough = currNum < effectResultValue
  end
  if notEnough then
    currNumText = LT.Textf("<Color4:{s1}>", currNum)
  end
  if effectResultValue then
    needNum = LT.Textf("{s1} <color=#9A9A9A><Del:{s2}></color>", effectResultValue, needNum)
  end
  do return LT.Textf, "{s1}/{s2}", currNumText end
  return LT.Textf, "{s1}/{s2}", currNumText, needNum
end

function AwakerSkillLevelUpPanel:OnBind(binder)
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  local animator = self.ui.uiNode:GetComponent(typeof(Animator))
  AnimatorUtils.SetStateEndInBehavior(animator, "Close", System.fn(self, self.Close))
  self.ui.Image_Gradient:SetActive(false)
  local confirmBtnTipsData = {
    clickFunc = function()
      local function OnLevelUpSuccess()
        local awakerTid = self.model.awakerTid
        
        UIManager.Instance:Reopen(Urls.ActiveSuccessPanel, LT.Text("Skill_LevelUp_Success"), nil, awakerTid)
        self.model.awakerModel:SetCurAwakerVoice("", "")
        if not self.model.canLevelUp then
          self:Close()
        end
      end
      
      self.model:ReqAwakerSkillLevelUp(OnLevelUpSuccess)
    end,
    stateFunc = function()
      local enough = self.model.isItemEnoughForLevelUp
      return enough and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
    end,
    text = LT.Text("RoleDetailsSkillLevelUp_Btn_Determine")
  }
  local cancelBtnTipsData = {
    clickFunc = function()
      if not animator then
        self:Close()
        return
      end
      AnimatorUtils.PlayState(animator, "Base Layer.ClosePanel")
    end,
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.L,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData
  }
  binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_L, commonPopupConfirmTipsData))
  binder:BindComponent(AwakerSpecialSkillAdditionItem(self.ui.UI_Awaker_Button_Addition, CommonDefine.AwakerSpecialSkillType.ResNeedReduce, "AwakerSkillLvUp"))
  binder:BindToText(self.ui.Text_Level_Old, function()
    local currLevel = self.model.selectSlotLevel
    local levelStr = string.format("Lv.%s", currLevel)
    return levelStr
  end)
  binder:BindToText(self.ui.Text_Level_Next, function()
    local targetLevel = self.model.targetLevel
    local levelStr = string.format("Lv.%s", targetLevel)
    return levelStr
  end)
  binder:BindToText(self.ui.Text_Level_Total, function()
    local maxLevel = self.model.skillMaxLevel
    local levelStr = string.format("/%s", maxLevel)
    return levelStr
  end)
  binder:BindToText(self.ui.Text_Levelup_Condition, function()
    if self.model.canLevelUp then
      return ""
    end
    local currLevel = self.model.selectSlotLevel
    if not AwakerDataUtils.CheckSkillLevelUpUnlockCondition(currLevel, false) then
      do return AwakerDataUtils.GetSkillLevelUplockConditionTips end
      return AwakerDataUtils.GetSkillLevelUplockConditionTips, currLevel, false
    end
    local warningText = LT.Textf("AwakerSkillUpgradeTips", self.model.needAwakerLevel)
    return warningText
  end)
  binder:BindToText(self.ui.Text_Coin_Need, function()
    local moneyTid = self.model.levelUpNeedMoneyData.tid
    local moneyNeed = self.model.levelUpNeedMoneyData.num
    local item = ItemDataUtils.GetItemByTid(moneyTid)
    local moneyOwned = item and item.num or 0
    local effectType = CommonDefine.AwakerSpecialSkillType.ResNeedReduce
    local funcModule = "AwakerSkillLvUp"
    local awakerModel = self.model.awakerModel
    local effectResultValue = awakerModel:GetResNeedReducePreviewResult(moneyNeed, effectType, funcModule)
    do return GetCostItemNumText, moneyNeed, moneyOwned end
    return GetCostItemNumText, moneyNeed, moneyOwned, effectResultValue
  end)
  binder:BindToImage(self.ui.Image_Coin_Icon, function()
    local moneyTid = self.model.levelUpNeedMoneyData.tid
    do return ItemDataUtils.GetSmallIcon end
    return ItemDataUtils.GetSmallIcon, moneyTid
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Levelup_List, function()
    return self.model.skillChangeArgs
  end, function(childBinder, obj, index)
    local data = self.model.skillChangeArgs[index]
    local itemData = {
      nameText = data.nameText,
      oldValue = data.currArgShowText,
      newValue = data.nextArgShowText,
      iconPath = data.iconPath,
      hasImproved = data.hasImproved
    }
    childBinder:BindComponent(AwakerSkillUpAttrItem(obj, itemData))
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Article, function()
    return self.model.levelUpCostItems
  end, function(childBinder, obj, index)
    local data = self.model.levelUpCostItems[index]
    local item = ItemDataUtils.GetItemByTid(data.tid)
    local num = item and item.num or 0
    local numText = GetCostItemNumText(data.num, num) or ""
    local itemData = {
      itemTid = data.tid,
      showText = numText,
      ifShowAppr = true,
      ifShowDesc = true
    }
    local itemComp = childBinder:BindComponent(ItemPublicArticleCommon(obj, itemData))
    childBinder:BindToRaw(function(_, nVal)
      if not nVal then
        return
      end
      itemComp:SetNumText(nVal)
    end, function()
      local _item = ItemDataUtils.GetItemByTid(data.tid)
      local _num = _item and _item.num or 0
      local _numText = GetCostItemNumText(data.num, _num) or ""
      return _numText
    end)
  end)
  binder:BindToVisible(self.ui.Text_Activate, function()
    return self.model.levelUpCostItems and #self.model.levelUpCostItems > 0
  end)
end

function AwakerSkillLevelUpPanel:Close()
  self.model:ShowSkillLevelUp(false)
  Super.Close(self)
end

return AwakerSkillLevelUpPanel
