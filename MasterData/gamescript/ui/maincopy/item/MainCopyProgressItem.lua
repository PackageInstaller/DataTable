local MainCopyProgressItem, Super = System.NewComponent("MainCopyProgressItem")

function MainCopyProgressItem:ctor(uiNode, progressInfo, model)
  Super.ctor(self)
  self.ui = UI_Dungeous_Item_Popup_AwardResource(uiNode)
  self.progressInfo = progressInfo
  self.model = model
end

function MainCopyProgressItem:OnBind(binder)
  self.binder = binder
  binder:BindToText(self.ui.Text_StarNumber, function()
    return self.progressInfo.needStar
  end)
  binder:BindToVisible(self.ui.Text_Lost, function()
    if self.progressInfo.isGet then
      return false
    end
    return self.progressInfo.isAttach == false
  end)
  binder:SetText(self.ui.Text_Custom_Title, "")
  if self.progressInfo.awardTitle then
    binder:SetText(self.ui.Text_Custom_Title, self.progressInfo.awardTitle)
    binder:SetActive(self.ui.Text_Title, false)
  end
  if self.progressInfo.hideStar then
    binder:SetActive(self.ui.Image_Star, false)
  end
  binder:BindToVisible(self.ui.Image_Finish, function()
    return self.progressInfo.isGet
  end)
  binder:BindToVisible(self.ui.Button_Get, function()
    return self.progressInfo.isAttach and self.progressInfo.isGet == false
  end)
  binder:BindZ1Button(self.ui.Button_Get, function()
    self:OnBtnGetClick()
  end, function()
    if not self.progressInfo.isAttach then
      return CommonDefine.BtnType.Unclickable
    else
      return CommonDefine.BtnType.High
    end
  end, function()
    do return LT.Text end
    return LT.Text, "TaskModule_btn_reward"
  end)
  local rewards = self.progressInfo.rewards or {}
  local maxRewardCount = 6
  for i = 1, maxRewardCount do
    local gameObj = self.ui["UI_Dungeous_Item_Award_" .. i]
    gameObj:SetActive(i <= #rewards)
    if i <= #rewards then
      local itemData = {
        itemTid = rewards[i].tid,
        itemCount = rewards[i].num
      }
      binder:BindComponent(CommonIconItemType2(gameObj, itemData))
    end
  end
end

function MainCopyProgressItem:OnBtnGetClick()
  if not self.progressInfo.isAttach then
    Alert.ShowStr("星级数目未达成")
    return
  end
  EventMgr.Instance.OpenReqMask:Dispatch()
  
  local function _OnReqSucc()
    self.progressInfo.isGet = true
    local data = table.deepclone(self.progressInfo.rewards)
    for _, v in pairs(data) do
      v.changedNum = v.num or 0
    end
    local newGroup = table.deepclone(self.model.showRewardItemGroup)
    for key, val in pairs(newGroup) do
      if val.needStar == self.progressInfo.needStar then
        newGroup[key].isGet = true
      end
      if val.reqGetAwardFunc then
        setmetatable(newGroup[key], ReactiveFlags.SKIP)
      end
    end
    self.model:SetShowRewardItemGroup(newGroup)
  end
  
  if self.progressInfo.reqGetAwardFunc then
    self.progressInfo.reqGetAwardFunc(_OnReqSucc)
    return
  end
  ProtoManager.Instance:ReqServer("StageRequest", "AwardGet", _OnReqSucc, nil, self.progressInfo.groupTid, self.progressInfo.needStar)
end

return MainCopyProgressItem
