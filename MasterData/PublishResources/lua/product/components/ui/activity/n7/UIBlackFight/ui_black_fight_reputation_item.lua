_class("UIBlackFightReputationItem", UICustomWidget)
UIBlackFightReputationItem = UIBlackFightReputationItem

function UIBlackFightReputationItem:OnShow()
  self.reputation = self:GetGameObject("reputation")
  self.imgBG = self:GetGameObject("imgBG")
  self.special = self:GetGameObject("special")
  self.txtTotal = self:GetUIComponent("UILocalizationText", "txtTotal")
  self.imgReputation = self:GetUIComponent("Image", "imgReputation")
  self.txtReputation = self:GetUIComponent("UILocalizationText", "txtReputation")
  self.poolAward = self:GetUIComponent("UISelectObjectPath", "award")
  self.canGet = self:GetGameObject("canGet")
  self.got = self:GetGameObject("got")
  self.select = self:GetGameObject("select")
  self.salutation = self:GetGameObject("salutation")
  self.bgSa = self:GetUIComponent("RawImageLoader", "bgSa")
  self.txtScoreSa = self:GetUIComponent("UILocalizationText", "txtScoreSa")
  self.txtSalutation = self:GetUIComponent("UILocalizationText", "txtSalutation")
  self.txtSalutationOL = self:GetUIComponent("UILocalizationText", "txtSalutationOL")
  self.txtSalutationGlow = self:GetUIComponent("UILocalizationText", "txtSalutationGlow")
  local f = 0.5372549019607843
  self.gray = Color(f, f, f)
  self:FlushSelect(false)
end

function UIBlackFightReputationItem:OnHide()
end

function UIBlackFightReputationItem:Flush(data, selectCallback, i)
  self.data = data
  self.selectCallback = selectCallback
  self.i = i
  self.imgBG:SetActive(i % 2 == 0)
  self:FlushReputation()
  self:FlushSalutation()
end

function UIBlackFightReputationItem:FlushReputation()
  if self.data.reputation == 0 then
    self.reputation:SetActive(false)
    return
  else
    self.reputation:SetActive(true)
  end
  self.special:SetActive(self.data.isSpecial)
  self.txtReputation:SetText(self.data.reputation)
  local len = table.count(self.data.awards)
  self.poolAward:SpawnObjects("UIBlackFightReputationItemAward", len)
  local uis = self.poolAward:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local award = self.data.awards[i]
    ui:Flush(award)
  end
  self:FlushGot()
end

function UIBlackFightReputationItem:FlushGot()
  local state = self.data.gotState
  if state == BlackFightReputationState.CanGet then
    self.canGet:SetActive(true)
    self.got:SetActive(false)
    self.txtTotal.color = Color.white
    self.imgReputation.color = Color.white
    self.txtReputation.color = Color.white
    self:FlushGray(false)
  elseif state == BlackFightReputationState.Got then
    self.canGet:SetActive(false)
    self.got:SetActive(true)
    self.txtTotal.color = self.gray
    self.imgReputation.color = self.gray
    self.txtReputation.color = self.gray
    self:FlushGray(true)
  else
    self.canGet:SetActive(false)
    self.got:SetActive(false)
    self.txtTotal.color = Color.white
    self.imgReputation.color = Color.white
    self.txtReputation.color = Color.white
    self:FlushGray(false)
  end
end

function UIBlackFightReputationItem:FlushGray(gray)
  local uis = self.poolAward:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    ui:FlushGray(gray)
  end
end

function UIBlackFightReputationItem:FlushSalutation()
  local isShow = false
  local dataN7 = GameGlobal.GetModule(CampaignModule):GetN7BlackFightData()
  if dataN7.salutations and table.count(dataN7.salutations) > 0 then
    local s = dataN7:GetSalutionByReputation(self.data.reputation)
    if s then
      isShow = true
      UIBlackFightMain.FlushTextColorOutline(s, self.txtSalutation, self.txtSalutationOL, self.txtSalutationGlow, self.bgSa, 2)
      self.txtScoreSa:SetText(StringTable.Get("str_n7_black_fight_sep_salutation", s.reputation))
      local cfg = Cfg.cfg_n7_black_fight_salutation()
      if cfg then
        local function arr2color(arr)
          local color = Color.white
          
          if arr then
            color:Set(arr[1] / 255, arr[2] / 255, arr[3] / 255)
          end
          return color
        end
        
        for index, cfgv in pairs(cfg) do
          if s.reputation == cfgv.Reputation then
            self.txtScoreSa.color = arr2color(cfgv.UI.colorUnlock)
            return
          end
        end
      end
    end
  end
  self.salutation:SetActive(isShow)
end

function UIBlackFightReputationItem:FlushSelect(isSelect)
  self.select:SetActive(isSelect)
end

function UIBlackFightReputationItem:bgOnClick()
  if self.selectCallback then
    self.selectCallback()
  end
end

function UIBlackFightReputationItem:btnGetOnClick()
  self:StartTask(function(TT)
    local dataN7 = GameGlobal.GetModule(CampaignModule):GetN7BlackFightData()
    local c = dataN7:GetComponentReputation()
    local res = AsyncRequestRes:New()
    local awards = c:HandleReceiveReward(TT, res, self.data.reputation)
    if awards then
      UIBlackFightReputationItem.ShowRewards(awards)
      self.data.gotState = BlackFightReputationState.Got
      self:Flush(self.data, self.selectCallback, self.i)
    end
  end, self)
end

function UIBlackFightReputationItem.ShowRewards(rewards, callback)
  local petIdList = {}
  local mPet = GameGlobal.GetModule(PetModule)
  for _, reward in pairs(rewards) do
    if mPet:IsPetID(reward.assetid) then
      table.insert(petIdList, reward)
    end
  end
  if table.count(petIdList) > 0 then
    GameGlobal.UIStateManager():ShowDialog("UIPetObtain", petIdList, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      GameGlobal.UIStateManager():ShowDialog("UIGetItemController", rewards, function()
        if callback then
          callback()
        end
      end)
    end)
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIGetItemController", rewards, function()
    if callback then
      callback()
    end
  end)
end
