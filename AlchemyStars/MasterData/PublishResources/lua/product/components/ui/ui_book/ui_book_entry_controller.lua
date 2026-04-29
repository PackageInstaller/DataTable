_class("UIBookEntryController", UIController)
UIBookEntryController = UIBookEntryController

function UIBookEntryController:Constructor()
  self.medalModule = GameGlobal.GetModule(MedalModule)
  self.uiMedalModuel = self.medalModule:GetUIModule()
end

function UIBookEntryController:OnShow(uiParams)
  local topButton = self:GetUIComponent("UISelectObjectPath", "topbtn")
  self.topButtonWidget = topButton:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    self:CloseDialog()
  end)
  local atlas = self:GetAsset("UIBook.spriteatlas", LoadType.SpriteAtlas)
  self.qingBaoCmp = UIBookEntryCell:New()
  self.qingBaoCmp:Refresh(self:GetUIComponent("UIView", "g_1"), BookMainType.RenShiQingBao, atlas)
  self.cgCmp = UIBookEntryCell:New()
  self.cgCmp:Refresh(self:GetUIComponent("UIView", "g_2"), BookMainType.CG, atlas)
  self.musicCmp = UIBookEntryCell:New()
  self.musicCmp:Refresh(self:GetUIComponent("UIView", "g_3"), BookMainType.Music, atlas)
  self.plotCmp = UIBookEntryCell:New()
  self.plotCmp:Refresh(self:GetUIComponent("UIView", "g_4"), BookMainType.Plot, atlas)
  self.medalCmp = UIBookEntryCell:New()
  self.medalCmp:Refresh(self:GetUIComponent("UIView", "g_5"), BookMainType.Medal, atlas)
  local unLock = GameGlobal.GetModule(RoleModule):CheckModuleUnlock(GameModuleID.MD_MEDAL)
  self.medalCmp:SetUnlock(unLock)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UIBookEntryController:OnHide()
  self:DetachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UIBookEntryController:LoadDataOnEnter(TT, res, uiParams)
  res:SetSucc(true)
end

function UIBookEntryController:OnUpdate(deltaTimeMS)
end

function UIBookEntryController:OnHide()
  self.qingBaoCmp:OnHide()
  self.cgCmp:OnHide()
  self.musicCmp:OnHide()
  self.plotCmp:OnHide()
  self.medalCmp:OnHide()
end

function UIBookEntryController:AfterUILayerChanged()
  local bRed = self.uiMedalModuel:IsMedalNew() or self.uiMedalModuel:IsMedalBoardNew()
  self.medalCmp:SetRed(bRed)
end
