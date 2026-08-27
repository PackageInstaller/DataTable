local UINLtrPtNode = class("UINLtrPtNode", UIBaseNode)
local base = UIBaseNode
local UINLtrPtRrewardItem = require("Game.Lottery.UI.PtNode.UINLtrPtRrewardItem")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease
local cs_ResLoader = CS.ResLoader

function UINLtrPtNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self._OnClickCancel)
  self.ui.exchangeItem:SetActive(false)
  self.ptRewardItemPool = UIItemPool.New(UINLtrPtRrewardItem, self.ui.exchangeItem)
  self._ExchangePtRewardFunc = BindCallback(self, self._ExchangePtReward)
  self.heroItem = UINHeroHeadItem:New()
  self.heroItem:Init(self.ui.obj_heroHeadItem)
  self.ui.img_Star.gameObject:SetActive(false)
  self.starList = {}
  self:_InitSwithTween()
  self.ui.tex_Tips.text = ConfigData:GetTipContent(306)
  self.ui.tex_End.text = ConfigData:GetTipContent(307)
  self.ui.tex_Title.text = ConfigData:GetTipContent(305)
  self.resLoader = cs_ResLoader.Create()
end

function UINLtrPtNode:InitLtrPtNode(ltrPoolData, ltrCtrl)
  self.ltrCtrl = ltrCtrl
  self.ltrPoolData = ltrPoolData
  self.showSeq:Rewind()
  AudioManager:PlayAudioById(1066)
  UIUtil.SetTopStatus(self, self.BackAction, {}, nil, nil, true)
  local ltrCfg = ltrPoolData:GetLtrPoolDataCfg()
  local startTime, endTime = self.ltrPoolData:GetStartAndEndTime()
  if endTime ~= -1 then
    self.ui.tex_Time.text = tostring(os.date("%m/%d %H:%M", endTime))
  end
  self:ReFreshLtrPtUI()
end

function UINLtrPtNode:ReFreshLtrPtUI()
  local ltrCfg = self.ltrPoolData:GetLtrPoolDataCfg()
  local ptNum = self.ltrPoolData:GetLtrPtNum()
  local specialSelelctDic
  local speSelectList = self.ltrPoolData:GetLtrSpeSelectedList()
  if self.ltrPoolData:IsLtrSpecialSelectHero() and speSelectList ~= nil then
    specialSelelctDic = {}
    for k, itemId in ipairs(speSelectList) do
      specialSelelctDic[itemId] = true
    end
  end
  self.ptRewardItemPool:HideAll()
  local dataList = {}
  for k, itemId in ipairs(ltrCfg.pt_rewardItemIdList) do
    if specialSelelctDic == nil or specialSelelctDic[itemId] ~= nil then
      local costNum = ltrCfg.pt_rewardCostNumList[k]
      local firstAwardId, firstAwardNum
      if not self.ltrPoolData.pickBig then
        firstAwardId = ltrCfg.pt_first_rewardItemIdList[k]
        firstAwardNum = ltrCfg.pt_first_rewardCostNumList[k]
      end
      if firstAwardNum == 0 then
        firstAwardId = nil
        firstAwardNum = nil
      end
      table.insert(dataList, {
        itemId = itemId,
        costNum = costNum,
        firstAwardId = firstAwardId,
        firstAwardNum = firstAwardNum
      })
    end
  end
  table.sort(dataList, function(a, b)
    local aItemCfg = ConfigData.item[a.itemId]
    local bItemCfg = ConfigData.item[b.itemId]
    if aItemCfg.action_type ~= eItemActionType.HeroCard then
      return true
    else
      local aHeroId = aItemCfg.arg[1]
      local bHeroId = bItemCfg.arg[1]
      if PlayerDataCenter.heroDic[aHeroId] == nil ~= (PlayerDataCenter.heroDic[bHeroId] == nil) then
        return PlayerDataCenter.heroDic[aHeroId] == nil
      end
      local aInitStar = aItemCfg.arg[2]
      local bInitStar = bItemCfg.arg[2]
      if aInitStar ~= bInitStar then
        return aInitStar > bInitStar
      end
      return aHeroId < bHeroId
    end
  end)
  for index, value in pairs(dataList) do
    local rewardItem = self.ptRewardItemPool:GetOne()
    rewardItem:InitLtrPtRrewardItem(value.itemId, value.costNum, self.resLoader, self._ExchangePtRewardFunc, ptNum, value.firstAwardId, value.firstAwardNum)
  end
  self.ui.tex_Count.text = tostring(ptNum)
end

function UINLtrPtNode:_ExchangePtReward(itemId, costNum, heroCfg, firstAwardId, firstAwardNum)
  self._exchangItemId = itemId
  if firstAwardId ~= nil then
    self._extraAward = {
      [firstAwardId] = firstAwardNum
    }
  else
    self._extraAward = nil
  end
  self.showSeq:Rewind()
  self.showSeq:Restart()
  local heroName = LanguageUtil.GetLocaleText(heroCfg.name)
  self.ui.tex_Name.text = heroName
  self.ui.tex_Info.text = string.format(ConfigData:GetTipContent(308), costNum, heroName)
  local ptNum = self.ltrPoolData:GetLtrPtNum()
  self.ui.tex_PtFrom.text = tostring(ptNum)
  self.ui.tex_PtTo.text = tostring(ptNum - costNum)
  self.heroItem:InitHeroHeadItemWithId(heroCfg.id)
  local rankCfg = ConfigData.hero_rank[heroCfg.rank]
  if rankCfg == nil then
    error("Can't find rankCfg, id = " .. tostring(heroCfg.rank))
  end
  self:__RefreshStar(rankCfg.star)
  if firstAwardId == nil then
    self.ui.confirmItemObj:SetActive(false)
    self.ui.tex_EXInfo.gameObject:SetActive(false)
    return
  end
  self.ui.confirmItemObj:SetActive(true)
  if self.confirmIte == nil then
    self.confirmIte = UINBaseItemWithCount.New()
    self.confirmIte:Init(self.ui.confirmItem)
  end
  local firstAwardCfg = ConfigData.item[firstAwardId]
  self.confirmIte:InitItemWithCount(firstAwardCfg, firstAwardNum)
  local awardName = LanguageUtil.GetLocaleText(firstAwardCfg.name)
  self.ui.tex_confirm_ItemName.text = awardName
  self.ui.tex_EXInfo.gameObject:SetActive(true)
  self.ui.tex_EXInfo.text = string.format(ConfigData:GetTipContent(309), awardName)
end

function UINLtrPtNode:__RefreshStar(heroStar)
  local half = heroStar % 2
  local rankImgIndex = (heroStar - half) / 2 - 1
  if 0 <= rankImgIndex then
    self.ui.img_Star.gameObject:SetActive(true)
    self.ui.img_Star:SetIndex(rankImgIndex)
    local vec = self.ui.img_Star.image.rectTransform.sizeDelta
    vec.x = self.ui.img_Star.image.sprite.rect.width
    self.ui.img_Star.image.rectTransform.sizeDelta = vec
  else
    self.ui.img_Star.gameObject:SetActive(false)
  end
  self.ui.img_Half.gameObject:SetActive(half == 1)
end

function UINLtrPtNode:_OnClickConfirm()
  local function realConfirm()
    self.ltrCtrl:ReqExchangeLtrPtReward(self._exchangItemId, self._extraAward)
    
    self.showSeq:PlayBackwards()
    self:_OnClickClose()
  end
  
  local itemCfg = ConfigData.item[self._exchangItemId]
  local heroId = itemCfg.arg[1]
  if itemCfg.action_type == eItemActionType.HeroCard and PlayerDataCenter.heroDic[heroId] then
    local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    local msg = ConfigData:GetTipContent(9501, PlayerDataCenter.heroDic[heroId]:GetName())
    window:ShowTextBoxWithYesAndNo(msg, function()
      realConfirm()
    end)
    return
  end
  realConfirm()
end

function UINLtrPtNode:_OnClickCancel()
  self.showSeq:PlayBackwards()
end

function UINLtrPtNode:BindCloseFun(closeFun)
  self.__closeFun = closeFun
end

function UINLtrPtNode:BackAction()
  self:Hide()
  if self.__closeFun ~= nil then
    self.__closeFun()
  end
end

function UINLtrPtNode:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UINLtrPtNode:_InitSwithTween()
  self:_KillTween()
  local sequence = cs_DoTween.Sequence()
  self.ui.tran_List.gameObject:SetActive(true)
  self.ui.tran_Confirm.gameObject:SetActive(true)
  sequence:Insert(0, self.ui.tran_List:DOAnchorPosX(self.ui.tran_List.anchoredPosition.x - 1156, 0.45):SetRelative(true))
  sequence:Insert(0, self.ui.fade_List:DOFade(0, 0.35))
  sequence:Insert(0, self.ui.tran_Confirm:DOAnchorPosX(self.ui.tran_Confirm.anchoredPosition.x + 1156, 0.45):From(true))
  sequence:Insert(0, self.ui.fade_Confirm:DOFade(0, 0.35):From())
  sequence:SetEase(cs_Ease.InQuad)
  sequence:SetAutoKill(false)
  sequence:Pause()
  self.showSeq = sequence
end

function UINLtrPtNode:_KillTween()
  if self.showSeq ~= nil then
    self.showSeq:Kill(true)
    self.showSeq = nil
  end
end

function UINLtrPtNode:OnDelete()
  self:_KillTween()
  self.ptRewardItemPool:DeleteAll()
  self.resLoader:Put2Pool()
  base.OnDelete(self)
end

return UINLtrPtNode
