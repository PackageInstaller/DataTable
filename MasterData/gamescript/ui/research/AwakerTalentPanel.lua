local Z1ToggleGroup = CS.Z1Client.Z1ToggleGroup
local Z1Toggle = CS.Z1Client.Z1Toggle
local AwakerTalentPanel, Super = System.NewClass("AwakerTalentPanel", UIBasePanel)
AwakerTalentPanel.uiResCls = UI_Research_Panel_CeriResource

function AwakerTalentPanel:ctor()
  Super.ctor(self)
end

function AwakerTalentPanel:OnBind(binder)
  self.model = binder:createModel(AwakerTalentPanelModel)
  self:BindCloseBtn()
  self:BindTab()
  self:BindScrollView()
  self:BindActiveNum()
end

function AwakerTalentPanel:BindActiveNum()
  local binder = self.binder
  binder:BindToText(self.ui.Text_Num, function()
    do return self.model.GetActiveNumStr end
    return self.model.GetActiveNumStr, self.model
  end)
end

function AwakerTalentPanel:BindCloseBtn()
  local binder = self.binder
  self.closeBtn = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self:ClosePanel()
  end))
end

function AwakerTalentPanel:BindTab()
  local binder = self.binder
  local toggleGroup = self.ui.Group_Toggle:GetComponent(typeof(Z1ToggleGroup))
  local list = DT.GetOriginalConstant("AwakerTalent_TabList")
  local iconNormalList = DT.GetOriginalConstant("AwakerTalent_TabNormalIconList")
  local iconSelectList = DT.GetOriginalConstant("AwakerTalent_TabSelectIconList")
  for i, schoolId in ipairs(list) do
    local tabType = schoolId
    local schoolCfg = DT.SchoolConfig[schoolId]
    local tabName = nil == schoolCfg and LT.Text("TalentTab_ALL") or schoolCfg.Name
    local tabIcons = {
      iconNormalList[i],
      iconSelectList[i]
    }
    local tabItemCom = binder:BindNewComponent(self.ui.Group_Toggle, AwakerTalentTabItem, UI_Research_Panel_Ceri_Item_ToggleResource, tabType, tabName, tabIcons)
    local uiRoot = tabItemCom.rootUINode
    
    local function toggleFunc(selecType)
      binder:SetZ1Toggle(tabItemCom.rootUINode, true)
      if selecType == tabType then
        self.model:SetCurTabType(selecType)
        binder:CircularScrollTo(self.ui.ScrollView_Bag_Material, 1)
      end
    end
    
    uiRoot:GetComponent(typeof(Z1Toggle)).group = toggleGroup
    tabItemCom:SetCallBack(toggleFunc)
    if nil == schoolCfg then
      binder:SetZ1Toggle(tabItemCom.rootUINode, true)
    end
  end
end

function AwakerTalentPanel:BindScrollView()
  self.binder:BindToCircularListView(self.ui.ScrollView_Bag_Material, System.fn(self, self._GetEffectList), System.fn(self, self._OnEffectListItemUpdate))
end

function AwakerTalentPanel:_GetEffectList()
  do return self.model.GetCurList end
  return self.model.GetCurList, self.model
end

function AwakerTalentPanel:_OnEffectListItemUpdate(itemBinder, gameObj, index)
  local curList = self.model:GetCurList()
  local talentData = curList[index]
  local bCanOperate = true
  itemBinder:BindComponent(AwakerTalentItem(gameObj, self.model, talentData.configId, talentData.awakerId, bCanOperate))
end

function AwakerTalentPanel:ClosePanel()
  self.closeBtn:PlayCloseAnim()
  self:Close()
end

return AwakerTalentPanel
