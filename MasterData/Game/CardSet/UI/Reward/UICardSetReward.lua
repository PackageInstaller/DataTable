local base = UIBaseWindow
local UICardSetReward = class("UICardSetReward", base)
local UINCardSetRewardItemHolder = require("Game.CardSet.UI.Reward.UINCardSetRewardItemHolder")
local UINCardSetRewardItemFinal = require("Game.CardSet.UI.Reward.UINCardSetRewardItemFinal")

function UICardSetReward:OnInit()
  UIUtil.AddButtonListener(self.ui.Btn_GetAll, self, self._OnClickGetAllReward)
  self.ui.scroll.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.scroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self._goItem = {}
  self._finalItem = UINCardSetRewardItemFinal.New()
  self._finalItem:Init(self.ui.FinalItem)
  self._finalItem:Hide()
  self._GetAllRewardFunc = BindCallback(self, self._OnClickGetAllReward)
  self._UpdStateFunc = BindCallback(self, self._UpdState)
  MsgCenter:AddListener(eMsgEventId.OnCardSetBpChange, self._UpdStateFunc)
end

function UICardSetReward:InitCardSetReward(cardSetCtrl, closeFunc)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._OnClickClose):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  self.cardSetCtrl = cardSetCtrl
  self._closeFunc = closeFunc
  self._cdStActData = self.cardSetCtrl:GetCdStActData()
  self._rewardCfgList = self._cdStActData:GetCsRewardBpCfg()
  local itemId = self._cdStActData:GetCardSetRewardItemId()
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("Cant get item cfg, id:" .. tostring(itemId))
  end
  self.ui.tex_TokenName.text = LanguageUtil.GetLocaleText(itemCfg.name)
  self.ui.Tex_Des.text = LanguageUtil.GetLocaleText(itemCfg.describe)
  self.ui.img_Token.sprite = CRH:GetSprite(itemCfg.icon)
  self:_UpdState(true)
  self:_RefillList()
end

function UICardSetReward:_UpdState(isInit)
  local toalExp = self._cdStActData:GetCsBpRewardTotalExp()
  self.ui.Tex_TokenNum:SetIndex(0, tostring(toalExp))
  self._curLv, self._curLvExp = self._cdStActData:GetCsBpLevel()
  self.ui.Tex_LvlCur:SetIndex(0, tostring(self._curLv))
  local rewardCfg = self._cdStActData:GetCsBpLevelCfg(self._curLv)
  self.ui.Tex_Exp.text = tostring(rewardCfg.need_num - self._curLvExp)
  local canPickReward = self._cdStActData:IsCsBpCanPickReward()
  self.ui.Btn_GetAll.gameObject:SetActive(canPickReward)
  if not isInit then
    self:_RereshList()
  end
end

function UICardSetReward:_RefillList()
  local totalCount = #self._rewardCfgList + 1
  self._totalCount = totalCount
  local pickedLv = self._cdStActData:GetCsBpLevelPicked()
  local idx = math.clamp(pickedLv % totalCount - 1, 0, totalCount - 1)
  self.ui.scroll.totalCount = totalCount
  self.ui.scroll:RefillCells(idx)
  self.ui.scroll:RefreshCells()
end

function UICardSetReward:_RereshList()
  self.ui.scroll:RefreshCells()
end

function UICardSetReward:__OnInstantiateItem(go)
  local item = UINCardSetRewardItemHolder.New()
  item:Init(go)
  self._goItem[go] = item
end

function UICardSetReward:__OnChangeItem(go, index)
  local item = self._goItem[go]
  local level = index + 1
  local rewardCfg = self._rewardCfgList[level]
  if level <= #self._rewardCfgList then
    item:InitCardSetRewardItemHolder(rewardCfg, self._curLv, self._curLvExp, self._cdStActData, self._GetAllRewardFunc)
    return
  end
  self._finalItem:InitCardSetRewardItemFinal(self._GetAllRewardFunc, self._cdStActData, self._curLv, self._curLvExp)
  item:InitCardSetRewardItemHolderFinal(self._finalItem)
end

function UICardSetReward:_OnClickGetAllReward()
  self.cardSetCtrl:ReqCardSetGetReward()
end

function UICardSetReward:_OnClickClose()
  self:Delete()
  if self._closeFunc ~= nil then
    self._closeFunc()
  end
end

function UICardSetReward:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnCardSetBpChange, self._UpdStateFunc)
  for k, v in pairs(self._goItem) do
    v:Delete()
  end
  base.OnDelete(self)
end

return UICardSetReward
