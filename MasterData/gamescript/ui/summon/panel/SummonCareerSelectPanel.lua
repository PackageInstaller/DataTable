local MAXSHOWNUM = 4
local SummonCareerSelectPanel, Super = System.NewClass("SummonCareerSelectPanel", UIBasePanel)
SummonCareerSelectPanel.uiResCls = UI_Summon_Popup_RealmsResource

function SummonCareerSelectPanel:ctor(model)
  Super.ctor(self)
  self.model = model
  self.curSelectSummonId = Vue.ref(SummonDataUtils.GetSelectCareer())
end

function SummonCareerSelectPanel:OnBind(binder)
  binder:BindZ1Button(self.ui.Btn_Confirm, System.fn(self, self.OnClickConfirm), System.fn(self, self.OnConfirmBtnState), function()
    do return LT.Text end
    return LT.Text, "UniversalConfirmButton"
  end)
  binder:BindZ1Button(self.ui.Btn_Cancel, System.fn(self, self.OnClickClose), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "UniversalCancelButton"
  end)
  self:_OnBindCareerGroup(binder)
end

function SummonCareerSelectPanel:_OnBindCareerGroup(binder)
  local effectGroup = {
    self.ui.Choose_Hundun,
    self.ui.Choose_Shenhai,
    self.ui.Choose_Xuerou,
    self.ui.Choose_Chaowei
  }
  for i = 1, MAXSHOWNUM do
    local obj = self.ui["Group_" .. i]
    local summonId = self.model.showCareerList[i]
    if summonId then
      local function selectedFunc()
        return summonId == self.curSelectSummonId.value
      end
      
      local function effectedFunc()
        return summonId == SummonDataUtils.GetSelectCareer()
      end
      
      local itemData = {
        model = self.model,
        clickCb = function()
          self.curSelectSummonId.value = summonId
        end,
        summonId = summonId,
        schoolId = DT.Summon[summonId].ShowSchool,
        selectedFunc = selectedFunc,
        effectedFunc = effectedFunc
      }
      binder:BindComponent(SummonCareerSelectItem(obj, itemData, effectGroup[i]))
    end
    obj:SetActive(summonId)
  end
end

function SummonCareerSelectPanel:OnConfirmBtnState()
  return CommonDefine.BtnType.High
end

function SummonCareerSelectPanel:OnClickConfirm()
  SummonDataUtils.ReqChooseCareer(self.curSelectSummonId.value, function()
    self.model:SetCurrPoolId(self.curSelectSummonId.value)
    self:OnClose()
  end)
end

function SummonCareerSelectPanel:OnClickClose()
  self:OnClose()
end

function SummonCareerSelectPanel:OnClose()
  self:Close()
end

return SummonCareerSelectPanel
