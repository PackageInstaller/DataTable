local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local ArtCollectionLoginPVModifyView, Super = NewClass("ArtCollectionLoginPVModifyView", BaseView)
ArtCollectionLoginPVModifyView.uiResCls = "UI/UI_Login/UI_Login_Prefab/UI_Login_Popup_LoginPV.prefab"

function ArtCollectionLoginPVModifyView:ctor()
  Super.ctor(self)
end

function ArtCollectionLoginPVModifyView:OnEnterView()
  Super.OnEnterView(self)
  self:UpdateScroll()
end

function ArtCollectionLoginPVModifyView:UpdateScroll()
  if self.pvCfgList == nil then
    self.pvCfgList = {}
    local pvKeyList = {
      "LoginPV1",
      "LoginPV2",
      "LoginPV3",
      "LoginPV4",
      "LoginPV5",
      "LoginPV6",
      "LoginPV7",
      "LoginPV8",
      "LoginPV9",
      "LoginPV10",
      "LoginPV11",
      "LoginPV12",
      "LoginPV13",
      "LoginPV14",
      "LoginPV15"
    }
    for _, pvKey in ipairs(pvKeyList) do
      local pvCfg = DT.GetOriginalConstant(pvKey)
      if pvCfg then
        local pvStageId = pvCfg[1]
        if 0 == pvStageId or CopyDataUtils.IsFirstRewardDraw(pvStageId) then
          table.insert(self.pvCfgList, pvCfg)
        end
      end
    end
  end
  if nil == self.pvTableView then
    local cellRT = self.ui.UI_Collection_Item_PV_SubItem:GetComponent(TYPEOF_RectTransform)
    local width = 0
    local height = 0
    if nil ~= cellRT then
      width = cellRT.sizeDelta.x
      height = cellRT.sizeDelta.y
    end
    self.pvTableView = self:CreateTableview(self.ui.ScrollView_PV, function()
      return #self.pvCfgList
    end, function(view, index)
      local cell = self:DequeueCell(view, self.ui.UI_Collection_Item_PV_SubItem)
      local cfgId = self.pvCfgList[index]
      if nil ~= cfgId then
        self:AddViewComponentOnce(cell.gameObject, LoginPVModifyItem, cfgId)
      end
      return cell
    end, function()
      return width, height
    end)
  end
  self.pvTableView:ReloadData()
end

function ArtCollectionLoginPVModifyView:RegisterNotifications()
  self:BindEvent(EventMgr.Instance.GameEvent, function(eventType)
    if eventType == CommonDefine.GameEvent.LoginPVManualChanged and self.pvTableView then
      self.pvTableView:ReloadData()
    end
  end)
end

function ArtCollectionLoginPVModifyView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Question, System.fn(self, self.OnClickQuestion))
end

function ArtCollectionLoginPVModifyView:OnClickQuestion()
  PlayerDataUtils.OpenIllustrate(LT.Text("LoginPvModifyTipTitle"), LT.Text("LoginPvModifyTipDesc"))
end

return ArtCollectionLoginPVModifyView
