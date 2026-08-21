_class("UIBattlePassCN1MainController", UIController)
UIBattlePassCN1MainController = UIBattlePassCN1MainController

function UIBattlePassCN1MainController:_SetCommonTopButton()
  local obj = UIWidgetHelper.SpawnObject(self, "backBtns", "UINewCommonTopButton")
  obj:SetData(function()
    self:CloseDialog()
  end, function()
    self:ShowDialog("UIHelpController", "UIActivityBattlePassMainController")
  end)
end

function UIBattlePassCN1MainController:Constructor()
  function self._tipsCallback(matid, pos)
    UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
  end
  
  self._tabIndex_Reward = 1
  self._tabIndex_Quest = 2
  self._tabTitles = {
    "str_activity_battlepass_tab_reward_title",
    "str_activity_battlepass_tab_quest_title"
  }
end

function UIBattlePassCN1MainController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityBattlePassHelper.LoadDataOnEnter(TT, res)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    return
  end
  UIActivityBattlePassHelper.GetAllGiftLocalPrice(self._campaign)
  self._campaign:ClearCampaignNew(TT)
end

function UIBattlePassCN1MainController:OnShow(uiParams)
  self._callBack = uiParams[1]
  self:_SetCommonTopButton()
  UIBattlePassStyleHelper.FitStyle_Widget(self._campaign, self)
  self:_SetTabBtns()
  self:_SetTabPages()
  self._tabIndex = 0
  self:_SetTabSelect(self._tabIndex_Reward)
  self:_CheckRedPointAll()
  self:_AttachEvents()
end

function UIBattlePassCN1MainController:OnHide()
  if self._callBack then
    self._callBack()
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BattlePassRedPoint)
  self:_DetachEvents()
end

function UIBattlePassCN1MainController:_SetTabBtns()
  local title = self._tabTitles
  self._tabBtns = UIWidgetHelper.SpawnObjects(self, "_tabBtns", "UIActivityCommonTextTabBtn", #title)
  for i, v in ipairs(self._tabBtns) do
    v:SetData(i, {
      indexWidgets = {},
      onoffWidgets = {
        {"OnBtn"},
        {"OffBtn"}
      },
      lockWidgets = {
        {},
        {}
      },
      titleWidgets = {"txtTitle"},
      titleText = StringTable.Get(title[i]),
      callback = function(index, isOffBtnClick)
        if isOffBtnClick then
          self:_SetTabSelect(index)
        end
      end,
      lockCallback = nil
    })
  end
  self._tabBtnImage = {
    self:GetGameObject("_tabSelect1"),
    self:GetGameObject("_tabSelect2")
  }
end

function UIBattlePassCN1MainController:_SetTabPages()
  local tabReward = UIWidgetHelper.SpawnObject(self, "_tabReward", "UIBattlePassCN1RewardMain")
  tabReward:SetData(self._campaign, self._tipsCallback, self)
  local tabQuest = UIWidgetHelper.SpawnObject(self, "_tabQuest", "UIBattlePassCN1QuestMain")
  tabQuest:SetData(self._campaign, self._tipsCallback, self)
  self._tabPages = {tabReward, tabQuest}
end

function UIBattlePassCN1MainController:_SetTabSelect(index)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  if index == self._tabIndex then
    return
  end
  local animType = index == self._tabIndex_Reward and "quest_out" or "quest_in"
  self:PlayAnim(animType)
  local page = self._tabPages and self._tabPages[self._tabIndex]
  if page and page.PlayAnimOut then
    page:PlayAnimOut(function()
      self:_SwitchTabPage(index)
    end)
  else
    self:_SwitchTabPage(index)
  end
end

function UIBattlePassCN1MainController:_SwitchTabPage(index)
  self._tabIndex = index
  for i = 1, #self._tabBtns do
    self._tabBtns[i]:SetSelected(i == index)
    self._tabBtnImage[i]:SetActive(i == index)
  end
  self:_RefreshTabPage({
    resetPos = true,
    expData = true,
    expUpgrade = false,
    anim_PlayIn = true,
    anim_ListItem = true
  })
end

function UIBattlePassCN1MainController:_RefreshTabPage(params)
  for i, v in ipairs(self._tabPages) do
    v:GetGameObject():SetActive(i == self._tabIndex)
  end
  self._tabPages[self._tabIndex]:Refresh_ByParams(params)
end

function UIBattlePassCN1MainController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:AttachEvent(GameEventType.ActivityQuestAwardItemClick, self._OnActivityQuestAwardItemClick)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:AttachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIBattlePassCN1MainController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.ActivityQuestAwardItemClick, self._OnActivityQuestAwardItemClick)
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:DetachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIBattlePassCN1MainController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIBattlePassCN1MainController:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckRedPointAll()
  end
end

function UIBattlePassCN1MainController:_CheckRedPointAll()
  local obj = self._tabBtns[self._tabIndex_Reward]:GetGameObject("red")
  local show = self._campaign and UIActivityBattlePassHelper.CalcRed_Reward(self._campaign) or false
  obj:SetActive(show)
  local obj = self._tabBtns[self._tabIndex_Quest]:GetGameObject("red")
  local show = self._campaign and UIActivityBattlePassHelper.CalcRed_Quest(self._campaign, 1, 2, 3) or false
  obj:SetActive(show)
end

function UIBattlePassCN1MainController:_OnActivityQuestAwardItemClick(matid, pos)
  self._tipsCallback(matid, pos)
end

function UIBattlePassCN1MainController:OnUIGetItemCloseInQuest(type)
  self:_RefreshTabPage({
    resetPos = true,
    expData = true,
    expUpgrade = true,
    anim_PlayIn = false,
    anim_ListItem = false
  })
end

function UIBattlePassCN1MainController:_OnQuestUpdate()
  self:_RefreshTabPage({
    resetPos = false,
    expData = false,
    expUpgrade = false,
    anim_PlayIn = false,
    anim_ListItem = false
  })
end

function UIBattlePassCN1MainController:PlayAnim(type, callback)
  if not self.view then
    return
  end
  local tb = {
    ["in"] = {
      animName = "UIeff_UIBattlePassCN1MainController_in",
      duration = 267
    },
    buy_in = {
      animName = "UIeff_UIBattlePassCN1MainController_buyin",
      duration = 267
    },
    buy_out = {
      animName = "UIeff_UIBattlePassCN1MainController_buyout",
      duration = 167
    },
    quest_in = {
      animName = "UIeff_UIBattlePassCN1MainController_Questin",
      duration = 200
    },
    quest_out = {
      animName = "UIeff_UIBattlePassCN1MainController_Questout",
      duration = 200
    }
  }
  UIWidgetHelper.PlayAnimation(self, "_anim", tb[type].animName, tb[type].duration, callback, true)
end

function UIBattlePassCN1MainController:BattlePassBtnOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIShopController", nil, ShopMainTabType.Secret, MarketType.Shop_BattlePass)
end
