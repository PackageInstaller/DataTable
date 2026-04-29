_class("UIHauteCoutureDuplicateReward", UIController)
UIHauteCoutureDuplicateReward = UIHauteCoutureDuplicateReward

function UIHauteCoutureDuplicateReward:LoadDataOnEnter(TT, res)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self.CtxData = campaignModule:GetCurHauteCouture_Review()
  if not self.CtxData then
    Log.fatal("没有开启的高级时装复刻活动")
    res:SetSucc(false)
    return
  end
  res:SetSucc(true)
end

function UIHauteCoutureDuplicateReward:OnShow(uiParams)
  self:InitWidget()
  local bg, bgClass = self.CtxData:Review_DuplicateRewardBgInfo()
  local ui, uiClass = self.CtxData:Review_DuplicateRewardUIInfo()
  if bg and bgClass then
    self.bg.dynamicInfoOfEngine:SetObjectName(bg)
    self.bg:SpawnObject(bgClass._className)
  end
  self.content.dynamicInfoOfEngine:SetObjectName(ui)
  local content = self.content:SpawnObject(uiClass._className)
  content:SetData(uiParams)
end

function UIHauteCoutureDuplicateReward:InitWidget()
  self.bg = self:GetUIComponent("UISelectObjectPath", "bg")
  self.content = self:GetUIComponent("UISelectObjectPath", "content")
end

function UIHauteCoutureDuplicateReward:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UIHauteCoutureDuplicateReward:OnItemClick(id, pos)
  if self._selectInfo then
    self._selectInfo:SetData(id, pos)
  end
end
