local UINAvgNounItem = class("UINAvgNounItem", UIBaseNode)
local UINAvgNounDetailNode = require("Game.Avg.UI.NounDes.UINAvgNounDetailNode")
local base = UIBaseNode
local cs_Ease = CS.DG.Tweening.Ease

function UINAvgNounItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_nounItem, self, self.OnClickBtn)
end

function UINAvgNounItem:InitNounItem(nounId, SetDetailNode, SetSelect)
  self.nounId = nounId
  self.nounCfg = ConfigData.noun_des[nounId]
  self.ui.text.text = LanguageUtil.GetLocaleText(self.nounCfg.name)
  self.nounstate = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetAvgNounIsRead(nounId)
  self.SetDetailNode = SetDetailNode
  self.SetSelect = SetSelect
  if self.nounstate then
    self.ui.obj_isNew:SetActive(false)
  else
    self.ui.obj_isNew:SetActive(true)
  end
end

function UINAvgNounItem:BindNounStateReadEvent(stateEvent)
  self.__readStateEvent = stateEvent
end

function UINAvgNounItem:OnClickBtn()
  self:SetNounItemAsRead()
  if self.SetDetailNode ~= nil then
    self.SetDetailNode(true)
  else
    error("callback nil")
  end
  if self.SetSelect ~= nil then
    self.SetSelect(self.ui.obj_item.transform)
  else
    error("callback nil")
  end
  local AvgNounDesWin = UIManager:GetWindow(UIWindowTypeID.AvgNounDes)
  AvgNounDesWin.ItemClickDesId = self.nounId
  if AvgNounDesWin.IsDoPlay == nil then
    AvgNounDesWin.DetailCanvas.alpha = 0
    AvgNounDesWin.DetailCanvas:DOFade(1, 0.25):SetEase(cs_Ease.OutQuad)
    AvgNounDesWin.IsDoPlay = true
  else
  end
  AvgNounDesWin:InitDetatilNode()
end

function UINAvgNounItem:SetNounItemAsRead()
  if self.nounstate then
  else
    self.ui.obj_isNew:SetActive(false)
    PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SaveAvgNoun(self.nounId)
    self.nounstate = true
    if self.__readStateEvent ~= nil then
      self.__readStateEvent(self.nounId)
    end
  end
end

function UINAvgNounItem:OnDelete()
  base.OnDelete(self)
end

return UINAvgNounItem
