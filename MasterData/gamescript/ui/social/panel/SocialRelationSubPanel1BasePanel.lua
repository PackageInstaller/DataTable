local UIAnimationController = CS.Z1Client.UIAnimationController
local SocialRelationSubPanel1BasePanel, Super = System.NewClass("SocialRelationSubPanel1BasePanel", UIBasePanel)
SocialRelationSubPanel1BasePanel.uiResCls = UI_Social_Panel_Main_SubPanel_1Resource

function SocialRelationSubPanel1BasePanel:ctor(mainModel)
  Super.ctor(self)
  self.mainModel = mainModel
end

function SocialRelationSubPanel1BasePanel:OnBind(binder)
  self.uiAnimationController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self:Init(binder)
  self:_OnBindFollowNum()
  self:_OnBindFollowPlayerGroup()
  self:_OnBindEmptyState()
  self:_OnBindFilter()
  self:_OnBindSlider()
end

function SocialRelationSubPanel1BasePanel:_OnBindFilter()
  self.ui.Group_Inquire:SetActive(false)
  self.ui.UI_Common_Filter_List:SetActive(false)
end

function SocialRelationSubPanel1BasePanel:_OnAttentionCallback(newRelation, index)
  local facadeData = SocialDataUtils.GetRelationByindex(self.model.relationListType, index)
  if facadeData then
    facadeData.relation = newRelation
  end
end

function SocialRelationSubPanel1BasePanel:_OnBindFollowPlayerGroup()
  local binder, model = self.binder, self.model
  SocialDataUtils.MarkSocialListDirty(model.relationListType)
  binder:BindToCircularListView(self.ui.ScrollView_PlayerItem2, function()
    return model.showGroup
  end, function(itemBinder, item, index)
    local facade = model.showGroup[index]
    local itemData = {
      facade = facade,
      socialListItemType = self.socialListItemType,
      attentionCb = function(newRelation)
        self:_OnAttentionCallback(newRelation, index)
      end
    }
    itemBinder:SetIcon(MaterialIconType.SocialRelationListItem, item.gameObject, itemData)
  end)
  binder:BindToRaw(function(_, nVal, oVal)
    if not oVal or not nVal then
      return
    end
    if model.followNum and #model.showGroup >= model.followNum then
      return
    end
    if model.banNum and #model.showGroup >= model.banNum then
      return
    end
    if model.maxListNum and #model.showGroup >= model.maxListNum then
      return
    end
    if nVal <= 0 and oVal > 0 then
      if not model.sortOrderType or model.sortOrderType == CommonDefine.SortOrder.Ascend or model.sortOrderType and model.sortOrderType.order == CommonDefine.SortOrder.Descend then
        local curListNum = #model.showGroup
        local queryEnd = math.min(model.maxListNum, curListNum + model.perQueryNum)
        SocialDataUtils.ReqOnSocialQueryList(model.relationListType, curListNum + 1, queryEnd, 1)
      elseif model.sortOrderType and model.sortOrderType == CommonDefine.SortOrder.Descend or model.sortOrderType and model.sortOrderType.order == CommonDefine.SortOrder.Ascend then
        local curListNum = #model.showGroup
        local queryStart = math.max(1, model.followNum - curListNum - model.perQueryNum + 1)
        SocialDataUtils.ReqOnSocialQueryList(model.relationListType, queryStart, model.followNum - curListNum, 1)
      end
    end
  end, function()
    return model.scrollBarVal
  end)
  self.ui.Btn_Unfollow:SetActive(false)
  binder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView_PlayerItem2)
end

function SocialRelationSubPanel1BasePanel:_OnBindSlider()
  local binder, model = self.binder, self.model
  binder:BindToScrollbarValueChange(self.ui.Scrollbar_Vertical, function(val)
    model:SetScrollBarVal(val)
  end)
end

function SocialRelationSubPanel1BasePanel:_OnBindEmptyState()
  local binder, model = self.binder, self.model
  binder:BindToVisible(self.ui.Group_Null_Black, function()
    return 0 == #model.showGroup
  end)
end

function SocialRelationSubPanel1BasePanel:PlayOpenAnim()
  self.uiAnimationController:PlayState("UI_Social_Panel_Main_SubPanel_1_Open", function()
  end)
end

function SocialRelationSubPanel1BasePanel:CloseWithAnim()
  self.uiAnimationController:PlayState("UI_Social_Panel_Main_SubPanel_1_Close", System.fn(self, self.Close))
end

function SocialRelationSubPanel1BasePanel:Close()
  Super.Close(self)
end

return SocialRelationSubPanel1BasePanel
