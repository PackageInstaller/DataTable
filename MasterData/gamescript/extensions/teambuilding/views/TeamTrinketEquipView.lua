local TrinketEquipViewType = CommonDefine.TrinketEquipViewType
local TeamTrinketEquipView, Super = NewClass("TeamTrinketEquipView", BaseView)
TeamTrinketEquipView.uiResCls = UI_Team_Panel_Trinket_EquipResource

function TeamTrinketEquipView:ctor(data)
  Super.ctor(self)
  self.tempMpdel = data.tempMpdel
  self.teamModel = data.teamModel
  self.viewType2InitFuncMap = {
    [TrinketEquipViewType.PartSelect] = System.fn(self, self._InitViewPartSelect),
    [TrinketEquipViewType.SuitSelect] = System.fn(self, self._InitViewSuitSelect),
    [TrinketEquipViewType.SuitEdit] = System.fn(self, self._InitViewSuitEdit)
  }
  TeamTrinketModel.Instance:SetSelectTrinketDatas(self.tempMpdel.trinkets)
end

function TeamTrinketEquipView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnTeamTrinketPageChanged, self._SwitchViewType, self)
  self:RegisterLocalNotify(NotifyId.OnTeamTrinketEquiped, self._InitTrinkeDetailGroup, self)
end

function TeamTrinketEquipView:RegisterEvents()
end

function TeamTrinketEquipView:OnEnterView()
  Super.OnEnterView(self)
  self:_InitCloseBtn()
  TeamTrinketModel.Instance:SetCurPage(TrinketEquipViewType.PartSelect)
end

function TeamTrinketEquipView:_SwitchViewType(viewType)
  TeamTrinketModel.Instance:UpdateTrinketShowList()
  self:_RefreshView()
  self.viewType2InitFuncMap[viewType]()
end

function TeamTrinketEquipView:_RefreshView()
  self:_InitAwakerInfo()
  self:_InitTrinkeDetailGroup()
end

function TeamTrinketEquipView:_InitCloseBtn()
  self.compCloseBtn = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self.OnClose))
end

function TeamTrinketEquipView:_InitViewPartSelect()
  self:AddViewComponentOnce(self.ui.uiNode, CompTrinketEquipPartSelect)
end

function TeamTrinketEquipView:_InitViewSuitSelect()
  self:AddViewComponentOnce(self.ui.uiNode, CompTrinketEquipSuitSelect)
end

function TeamTrinketEquipView:_InitViewSuitEdit()
  self:AddViewComponentOnce(self.ui.uiNode, CompTrinketEquipSuitEdit)
end

function TeamTrinketEquipView:_InitTrinkeDetailGroup()
  local compTrinketGroupDetailData = {
    showTrinketDataMap = TeamTrinketModel.Instance.selectTrinketDatas
  }
  self:AddViewComponentOnce(self.ui.UI_Team_Item_Trinket_Detail, CompTrinketGroupDetail, compTrinketGroupDetailData)
end

function TeamTrinketEquipView:_InitAwakerInfo()
  self.ui.Group_Awaker:SetActive(self.showAwakerTid and 0 ~= self.showAwakerTid)
  self:SetImage(self.ui.Icon_Awaker, AwakerDataUtils.GetCircleHeadIcon(self.showAwakerTid))
end

function TeamTrinketEquipView:RefreshOnRendered()
end

function TeamTrinketEquipView:OnEnterViewFinished()
end

function TeamTrinketEquipView:OnClose()
  self.compCloseBtn:PlayCloseAnim()
  self:Close()
end

function TeamTrinketEquipView:OnExitView()
  self.teamModel:SetCurAwakerSlot(0)
  Super.OnExitView(self)
end

return TeamTrinketEquipView
