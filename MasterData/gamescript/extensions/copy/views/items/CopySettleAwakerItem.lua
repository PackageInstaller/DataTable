local CopySettleAwakerItem, Super = NewViewComponent("CopySettleAwakerItem")

function CopySettleAwakerItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Item_SurveyTeamResource(uiNode)
  self.data = data
  self.awakerData = data.awakerData
  self.awakerTid = data.awakerData.tid
end

function CopySettleAwakerItem:OnEnterComponent()
  self:_InitAwakerDetailBaseItem()
  self:_InitAwakerAttr()
end

local showAttrGroup = {
  bc.RoleProperty.crit,
  bc.RoleProperty.crit_damage,
  bc.RoleProperty.ulti_energy_plus_3,
  bc.RoleProperty.keeper_energy_eff_2
}

function CopySettleAwakerItem:_InitAwakerAttr()
  for idx, attrName in pairs(showAttrGroup) do
    local obj = self.ui["Text_AwakerProperty_" .. idx]
    self:SetText(obj, CopySettleModel.Instance:GetAwakerShowPropertyByType(self.awakerTid, attrName))
  end
end

function CopySettleAwakerItem:_InitAwakerDetailBaseItem()
  local viewData = {
    awakerData = self.data.awakerData,
    weaponDatas = self.data.weaponDatas,
    trinketDatas = self.data.trinketDatas,
    specialTeamTrinketSuit = self.data.specialTeamTrinketSuit,
    awakerClickFunc = function()
      local awakerBasePanelData = {
        jumpPage = CommonDefine.AwakerPage.Detail,
        previewAwakersData = {
          awakers = {
            self.awakerData
          },
          items = CopySettleModel.Instance:Get_settleItemDataMap(),
          hideAwakerChangeForm = true
        },
        selectAwakerId = self.awakerData.tid
      }
      UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
    end
  }
  self:AddViewComponentOnce(self.ui.UI_Team_Item_Awaker_List, CompAwakerDetailBaseItem, viewData)
end

function CopySettleAwakerItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return CopySettleAwakerItem
