local UI_Passport_Choose_TipResource = require("UI.UIPackages.UI_Passport_Choose_TipResource")
local UIBasePanel = require("Managers.UI.UIBasePanel")
local System = require("System.System")
local LT = require("System.LangTable")
local Alert = require("System.Alert")
local CommonDefine = require("World.Enums.CommonDefine")
local ONEPAGESHOWNUM = 4
local BattlePassSelectRewardTipsModel = require("Model.BattlePassSelectRewardTipsModel")
local BattlePassSelectRewardTips, Super = System.NewClass("BattlePassSelectRewardTips", UIBasePanel)
BattlePassSelectRewardTips.uiResCls = UI_Passport_Choose_TipResource

function BattlePassSelectRewardTips:ctor(dropIdList, receiveCb)
  Super.ctor(self)
  self.dropIdList = dropIdList
  self.receiveCb = receiveCb
end

function BattlePassSelectRewardTips:OnBind(binder)
  local model = binder:createModel(BattlePassSelectRewardTipsModel, self.dropIdList)
  self.model = model
  local commonPopupTipsData = {
    sizeType = CommonDefine.PopupTipsType.L
  }
  binder:BindComponent(require("UI.Public.Tip.CommonPopupTips")(self.ui.UI_Common_Popup_Tips_L, commonPopupTipsData))
  binder:BindZ1Button(self.ui.Btn_Confirm, System.fn(self, self.OnClickRight), function()
    if model.SingleReward() then
      if model.NotSelect() then
        return CommonDefine.BtnType.Unclickable
      end
    elseif model.FinalAward() or model.NotSelect() then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.High
  end, function()
    if model.SingleReward() then
      do return LT.Text end
      return LT.Text, "BPChooseConfirmBtn"
    end
    do return LT.Text end
    return LT.Text, "BPChooseNextBtn"
  end)
  binder:BindZ1Button(self.ui.Btn_Direct, System.fn(self, self.OnClickMiddle), function()
    if model.NotSelect() then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "BPChooseColectDirectlyBtn"
  end)
  binder:BindZ1Button(self.ui.Btn_Cancel, System.fn(self, self.OnClickLeft), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "UniversalCancelButton"
  end)
  binder:BindToText(self.ui.Text_Num, function()
    if model.SingleReward() then
      return ""
    end
    do return LT.Textf, "BPMultiChooseTitleNum", model.curSelectIdx end
    return LT.Textf, "BPMultiChooseTitleNum", model.curSelectIdx, #model.dropIdList
  end)
  binder:BindToRaw(function(cBinder)
    for i = 1, ONEPAGESHOWNUM do
      local tmpTid = model.curSelectList[i] and model.curSelectList[i].tid or nil
      local tmpNum = model.curSelectList[i] and model.curSelectList[i].num or nil
      local obj = self.ui["UI_Passport_Choose_Reward_" .. i]
      if tmpTid then
        self.BindSelectItem(tmpTid, tmpNum, obj, model, cBinder)
      end
      obj:SetActive(tmpTid)
    end
  end, function()
    return model.curSelectIdx
  end)
  binder:BindToVisible(self.ui.ScrollView, function()
    return #model.curSelectList > ONEPAGESHOWNUM
  end)
  binder:BindToVisible(self.ui.ScrollView_Middle, function()
    return #model.curSelectList <= ONEPAGESHOWNUM
  end)
  binder:BindToVisible(self.ui.Btn_Direct, function()
    return not model.SingleReward()
  end)
end

function BattlePassSelectRewardTips:OnClickLeft()
  self:Cancel()
end

function BattlePassSelectRewardTips:OnClickMiddle()
  self:Receive()
end

function BattlePassSelectRewardTips:OnClickRight()
  if self.model.SingleReward() then
    self:Receive()
  else
    self:NextAward()
  end
end

function BattlePassSelectRewardTips:NextAward()
  if self.model.FinalAward() then
    Alert.ShowStr(LT.Text("BPMultiChooseLastHint"))
    return
  end
  if self.model.NotSelect() then
    Alert.ShowStr(LT.Text("BPChooseSelectHint"))
    return
  end
  self.model.AddItemTid()
  self.model.NextAward()
end

function BattlePassSelectRewardTips:Cancel()
  self:OnClose()
end

function BattlePassSelectRewardTips.BindSelectItem(tid, num, obj, model, binder)
  local tmpItemData = {
    tid = tid,
    model = model,
    clickCb = function()
      model.SetCurSelectTid(tid)
    end,
    num = num
  }
  binder:BindComponent(require("UI.BattlePass.Item.BattlePassSelectRewardItem")(obj, tmpItemData))
end

function BattlePassSelectRewardTips:Receive()
  if self.model.NotSelect() then
    Alert.ShowStr(LT.Text("BPChooseSelectHint"))
    return
  end
  self.model.AddItemTid()
  if self.receiveCb then
    self.receiveCb(table.deepclone(self.model.finalList))
  end
  self:OnClose()
end

function BattlePassSelectRewardTips:OnClose()
  self:Close()
end

return BattlePassSelectRewardTips
