local base = UIBaseWindow
local UIActBondDunSelect = class("UIActBondDunSelect", base)
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_ResLoader = CS.ResLoader
local UINActBondDunLevelItem = require("Game.ActivityBond.UI.DunSelect.UINActBondDunLevelItem")
local UINActBondDunRuleItem = require("Game.ActivityBond.UI.DunSelect.UINActBondDunRuleItem")

function UIActBondDunSelect:OnInit()
  UIUtil.SetTopStatus(self, self.Delete)
  self._resloader = cs_ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.Btn_Rank, self, self.__OnClickRank)
  self.levelItemPool = UIItemPool.New(UINActBondDunLevelItem, self.ui.levelItem, false)
  self.ruleItemPool = UIItemPool.New(UINActBondDunRuleItem, self.ui.RuleItem, false)
  self.__onClickLevel = BindCallback(self, self.__OnClickLevel)
end

function UIActBondDunSelect:InitActBondDunSelect(bondData, dunGroupData)
  self.__bondData = bondData
  self.__dunGroupData = dunGroupData
  self.__selectedLevelItem = nil
  self:__RefreAll()
  self:__RefreLevel()
  self:__RefreshScore()
end

function UIActBondDunSelect:__RefreAll()
  self.ruleItemPool:HideAll()
  local buffList = self.__dunGroupData:ActBond_GetBuffList()
  for _, buffId in ipairs(buffList) do
    local ruleItem = self.ruleItemPool:GetOne()
    ruleItem:ActBond_RuleItemInit(buffId)
  end
  local transferBuffId = self.__dunGroupData:ActBond_GetTransferBuffId()
  if transferBuffId == nil or transferBuffId == 0 then
    self.ui.Protocol:SetActive(false)
  else
    self.ui.Protocol:SetActive(true)
    local transCfg = ConfigData.activity_bond_transfer_buff[transferBuffId]
    self.ui.Tex_ProtocolName.text = LanguageUtil.GetLocaleText(transCfg.buff_name)
    self.ui.Tex_ProtocolDes.text = LanguageUtil.GetLocaleText(transCfg.buff_des)
    self.ui.Img_ProtocolPic.sprite = AtlasUtil.GetSpriteFromAtlas("BondIcon", transCfg.buff_icon, self._resloader)
  end
end

function UIActBondDunSelect:__RefreLevel()
  self.levelItemPool:HideAll()
  self.__selectedLevelItem = nil
  for _, dunData in ipairs(self.__dunGroupData:ActBond_GetDunDataList()) do
    local levelItem = self.levelItemPool:GetOne(true)
    levelItem:ActBond_InitDunLevelItem(self.__bondData, dunData, self.__onClickLevel)
  end
end

function UIActBondDunSelect:__RefreshScore()
  self.ui.Tex_Score.text = tostring(self.__dunGroupData:ActBond_GetGroupScore())
end

function UIActBondDunSelect:__OnClickLevel(levelItem)
  if self.__selectedLevelItem ~= nil then
    self.__selectedLevelItem:SetIsSelected(false)
  end
  if self.__selectedLevelItem == levelItem then
    return
  else
    self.__selectedLevelItem = levelItem
    self.__selectedLevelItem:SetIsSelected(true)
  end
  local isSelected = self.__selectedLevelItem ~= nil
  if isSelected then
    self:__OpenDunLevelDetail()
  else
  end
end

function UIActBondDunSelect:__OpenDunLevelDetail()
  local dunData = self.__selectedLevelItem:ActBond_GetDunData()
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonLevelDetail, function(win)
    if win == nil then
      return
    end
    win:InitDungeonLevelDetail(dunData, not dunData:GetIsLevelUnlock())
    win:SetDungeonLevelBgClose(true)
    win:SetDunLevelDetaiHideStartEvent(function()
      self:PlayMoveLongLeftTween(false)
      self.__selectedLevelItem:SetIsSelected(false)
      self.__selectedLevelItem = nil
    end)
    win:SetDunLevelDetaiHideEndEvent(function()
    end)
    local width, duration = win:GetDLevelDetailWidthAndDuration()
    self:PlayMoveLongLeftTween(true, width, duration)
  end)
end

function UIActBondDunSelect:PlayMoveLongLeftTween(isLeft, offset, duration)
  if self.__moveLeftLongSeq == nil then
    offset = offset * 2
    local endValue = Vector2.New(1 - offset / self.transform.rect.width, 1)
    local seq = cs_DoTween.Sequence()
    seq:SetAutoKill(false)
    seq:Append(self.transform:DOAnchorMax(endValue, duration))
    self.__moveLeftLongSeq = seq
  end
  if isLeft then
    self.__moveLeftLongSeq:PlayForward()
  else
    self.__moveLeftLongSeq:PlayBackwards()
  end
end

function UIActBondDunSelect:__OnClickRank()
  local rankId = self.__dunGroupData:ActBond_GetRankId()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonRank, function(rankWindow)
    if rankWindow == nil then
      return
    end
    rankWindow:InitCommonRank(rankId)
  end)
end

function UIActBondDunSelect:OnDelete()
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  base.Delete(self)
end

return UIActBondDunSelect
