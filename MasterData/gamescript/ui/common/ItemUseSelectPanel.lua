local UI_Passport_Choose_TipResource = require("UI.UIPackages.UI_Passport_Choose_TipResource")
local System = require("System.System")
local UIBasePanel = require("Managers.UI.UIBasePanel")
local ONEPAGESHOWNUM = 4
local ItemUseSelectPanelModel = require("Model.ItemUseSelectPanelModel")
local ItemUseSelectPanel, Super = System.NewClass("ItemUseSelectPanel", UIBasePanel)
ItemUseSelectPanel.uiResCls = UI_Passport_Choose_TipResource

function ItemUseSelectPanel:ctor(data, isPreview)
  Super.ctor(self)
  self.itemId = data.itemId
  self.useNum = data.useNum
  self.isPreview = isPreview or false
end

function ItemUseSelectPanel:OnBind(binder)
  self.binder = binder
  local model = binder:createModel(ItemUseSelectPanelModel, self.itemId, self.useNum)
  self.model = model
  binder:SetActive(self.ui.Btn_Direct, false)
  binder:SetActive(self.ui.Text_Num, false)
  binder:SetActive(self.ui.ScrollView, false)
  binder:SetActive(self.ui.ScrollView_Middle, true)
  if self.isPreview then
    binder:SetText(self.ui.Text_Title, LT.Text("ChestPreviewTitle"))
    binder:SetActive(self.ui.Btn_Confirm, false)
    binder:SetActive(self.ui.Btn_Cancel, true)
  end
  binder:BindZ1Button(self.ui.Btn_Confirm, System.fn(self, self.OnClickConfirm), function()
    if model:NotSelect() then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "BPChooseConfirmBtn"
  end)
  binder:BindZ1Button(self.ui.Btn_Cancel, System.fn(self, self.OnClickCancel), function()
    return CommonDefine.BtnType.High
  end, function()
    if self.isPreview then
      do return LT.Text end
      return LT.Text, "PreviewClose"
    else
      do return LT.Text end
      return LT.Text, "UniversalCancelButton"
    end
  end)
  binder:BindToRaw(function(cBinder)
    for i = 1, ONEPAGESHOWNUM do
      local tmpTid = model.curSelectList[i] and model.curSelectList[i].tid or nil
      local tmpNum = model.curSelectList[i] and model.curSelectList[i].num or nil
      local obj = self.ui["UI_Passport_Choose_Reward_" .. i]
      if tmpTid and tmpNum then
        tmpNum = tmpNum * model.num
        model:SetCurSelectNum(tmpNum)
        self:BindSelectItem(tmpTid, tmpNum, obj, model, cBinder)
      end
      obj:SetActive(tmpTid)
    end
  end, function()
    return model.curSelectIdx
  end)
end

function ItemUseSelectPanel:BindSelectItem(tid, num, obj, model, binder)
  local tmpItemData = {
    tid = tid,
    model = model,
    clickCb = function()
      model.SetCurSelectTid(tid)
    end,
    num = num,
    isPreview = self.isPreview
  }
  binder:BindComponent(require("UI.BattlePass.Item.BattlePassSelectRewardItem")(obj, tmpItemData))
end

function ItemUseSelectPanel:OnClickConfirm()
  if self.model:NotSelect() then
    Alert.ShowStr(LT.Text("BPChooseSelectHint"))
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnUseChooseItem", function(svrData)
    Logger.Info(" OnUseChooseItem Successful")
    self:Close()
  end, function()
    Logger.Info(" OnUseChooseItem Fail")
  end, self.model.itemId, self.model.curSelectTid, self.model.num)
end

function ItemUseSelectPanel:OnClickCancel()
  self:Close()
end

return ItemUseSelectPanel
