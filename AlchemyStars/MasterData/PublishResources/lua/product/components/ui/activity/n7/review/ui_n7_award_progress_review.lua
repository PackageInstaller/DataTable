_class("UIN7AwardProgressReview", UIController)
UIN7AwardProgressReview = UIN7AwardProgressReview

function UIN7AwardProgressReview:Constructor(ui_root_transform)
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN7DataReview()
end

function UIN7AwardProgressReview:OnShow(uiParams)
  self.anim = self:GetUIComponent("Animation", "UIN7AwardProgressReview")
  self.poolContent = self:GetUIComponent("UISelectObjectPath", "Content")
  self:Flush()
end

function UIN7AwardProgressReview:Flush()
  local len = #self.data.progresses
  self.poolContent:SpawnObjects("UIN7AwardProgressItemReview", len)
  local uis = self.poolContent:GetAllSpawnList()
  for i, progress in pairs(self.data.progresses) do
    local ui = uis[i]
    ui:Flush(progress, function()
      self:StartTask(function(TT)
        local key = "UIN7AwardProgressReviewImgCanGetOnClick"
        self:Lock(key)
        local c = self.data:GetComponentProgress()
        local res = AsyncRequestRes:New()
        c:HandleReceiveReward(TT, res, progress.progress)
        if N7DataReview.CheckCode(res) then
          self:ShowUIGetItemController(progress.awards)
          local uiName = "UIN7MainReview"
          if GameGlobal.UIStateManager():IsShow(uiName) then
            GameGlobal.UIStateManager():CallUIMethod(uiName, "Flush")
          end
          self:Close()
        end
        self:UnLock(key)
      end, self)
    end, function()
      local ra = progress:Get1stAward()
      self:ShowDialog("UIItemTips", ra, ui.go, "UIN7AwardProgressReview", Vector2(450, 120))
    end)
    ui:ShowHideGo(false)
  end
  self:StartTask(function(TT)
    local key = "UIN7AwardProgressReviewFlush"
    self:Lock(key)
    for i, ui in ipairs(uis) do
      ui:ShowHideGo(true)
      ui:PlayAnim()
      YIELD(TT, 50)
    end
    self:UnLock(key)
  end, self)
end

function UIN7AwardProgressReview:ShowUIGetItemController(rewards)
  if not rewards then
    return
  end
  self._petModule = GameGlobal.GetModule(PetModule)
  local tempPets = {}
  if 0 < #rewards then
    for i = 1, #rewards do
      local ispet = self._petModule:IsPetID(rewards[i].assetid)
      if ispet then
        table.insert(tempPets, rewards[i])
      end
    end
  end
  
  local function cbFunc()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, 0)
  end
  
  if 0 < #tempPets then
    self:ShowDialog("UIPetObtain", tempPets, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      self:ShowDialog("UIGetItemController", rewards, cbFunc)
    end)
  else
    self:ShowDialog("UIGetItemController", rewards, cbFunc)
  end
end

function UIN7AwardProgressReview:BgOnClick(go)
  self:Close()
end

function UIN7AwardProgressReview:BtnXOnClick(go)
  self:Close()
end

function UIN7AwardProgressReview:Close()
  self:StartTask(function(TT)
    local key = "UIN7AwardProgressReviewClose"
    self:Lock(key)
    self.anim:Play("uieff_N7_AwardProgressReview_out")
    YIELD(TT, 133)
    self:UnLock(key)
    self:CloseDialog()
  end, self)
end
