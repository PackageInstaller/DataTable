_class("UICN20N49AlchemyShopRevenueLevelUpInfoItem", UICustomWidget)
UICN20N49AlchemyShopRevenueLevelUpInfoItem = UICN20N49AlchemyShopRevenueLevelUpInfoItem

function UICN20N49AlchemyShopRevenueLevelUpInfoItem:OnShow(uiParams)
  self:InitWidget()
end

function UICN20N49AlchemyShopRevenueLevelUpInfoItem:InitWidget()
  self.planTypeText = self:GetUIComponent("UILocalizationText", "PlanTypeText")
  self.planTipsText = self:GetUIComponent("UILocalizationText", "PlanTipsText")
  self.planStateText = self:GetUIComponent("UILocalizationText", "PlanStateText")
  self.overRoot = self:GetUIComponent("Image", "OverRoot")
  self.getBtn = self:GetUIComponent("Image", "GetBtn")
  self.getBtnText = self:GetUIComponent("UILocalizationText", "GetBtnText")
  self.beingText = self:GetUIComponent("UILocalizationText", "BeingText")
  self.awardRoot = self:GetUIComponent("UISelectObjectPath", "AwardRoot")
  self._atlas = self:GetAsset("UICN20N49_Ryza.spriteatlas", LoadType.SpriteAtlas)
end

function UICN20N49AlchemyShopRevenueLevelUpInfoItem:SetData(campaign, index, progress, callback, tipsCallback, level)
  self._level = level
  self._index = index
  self._campaign = campaign
  self._progress = progress
  self._callback = callback
  self._tipsCallback = tipsCallback
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self.personProcessInfo = UICN20N49Helper.GetComponentInfo(self._campaign, "alchemyShop")
  self._component = UICN20N49Helper.GetComponent(self._campaign, "alchemyShop")
  self._state = self._component:CheckItemStatus(self._progress)
  self:_Refresh()
end

function UICN20N49AlchemyShopRevenueLevelUpInfoItem:_Refresh()
  self:_SetState(self._state)
  self:_SetStateCount(self._state)
  local val = {}
  val[CampaignPersonProgressStatus.CPPS_Completed] = 0
  val[CampaignPersonProgressStatus.CPPS_Accepted] = 1
  val[CampaignPersonProgressStatus.CPPS_Taken] = 2
  local curProg = self._component:GetCurrentProgress()
  if curProg >= self._progress then
    curProg = self._progress
  end
  self.planStateText:SetText(StringTable.Get("str_cn20_n49_shop_progress_need_level", self._level))
  local progressList = self._component:GetProgressList()
  self.planTipsText:SetText(StringTable.Get("str_cn20_n49_shop_progress_need_gold", progressList[self._level]))
  if self._state == CampaignPersonProgressStatus.CPPS_Completed then
    self.getBtnText:SetText(StringTable.Get("str_cn20_n49_shop_progress_get"))
    self.getBtn.sprite = self._atlas:GetSprite("cn20_ysdj_button01")
    self.getBtn.gameObject:SetActive(true)
    self.overRoot.gameObject:SetActive(false)
  elseif self._state == CampaignPersonProgressStatus.CPPS_Accepted then
    self.getBtnText:SetText(StringTable.Get("str_cn20_n49_shop_progress_cant_get"))
    self.getBtn.sprite = self._atlas:GetSprite("cn20_ysdj_button02")
    self.getBtn.gameObject:SetActive(true)
    self.overRoot.gameObject:SetActive(false)
  elseif self._state == CampaignPersonProgressStatus.CPPS_Taken then
    self.getBtnText:SetText(StringTable.Get("str_cn20_n49_shop_progress_complete_btn"))
    self.getBtn.sprite = self._atlas:GetSprite("cn20_ysdj_button01")
    self.getBtn.gameObject:SetActive(true)
    self.overRoot.gameObject:SetActive(true)
  end
  if 0 < #self.personProcessInfo.m_progress_rewards[self._progress] then
    self.awardList = self.awardRoot:SpawnObjects("UICN20N49AlchemyShopRevenueLevelUpInfoItemItem", #self.personProcessInfo.m_progress_rewards[self._progress])
    for i = 1, #self.awardList do
      local award = self.awardList[i]
      local cfgAward = self.personProcessInfo.m_progress_rewards[self._progress][i]
      award:SetData(cfgAward, function(matid, pos)
        if self._tipsCallback then
          self._tipsCallback(matid, pos)
        end
      end)
    end
  end
end

function UICN20N49AlchemyShopRevenueLevelUpInfoItem:_SetState(state)
end

function UICN20N49AlchemyShopRevenueLevelUpInfoItem:_SetStateCount(state)
end

function UICN20N49AlchemyShopRevenueLevelUpInfoItem:GetBtnOnClick(go)
  if self._callback then
    self._callback(self._progress)
  end
end
