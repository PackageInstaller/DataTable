_class("UIN23Movie", UIController)
UIN23Movie = UIN23Movie

function UIN23Movie:Constructor(ui_root_transform)
  self._isInHomeland = false
  self._callback = nil
  self._atlas = self:GetAsset("UIN23.spriteatlas", LoadType.SpriteAtlas)
  self._campaign_module = GameGlobal.GetModule(CampaignModule)
end

function UIN23Movie:OnShow(uiParams)
  self._isInHomeland = uiParams[1]
  self._callback = uiParams[2]
  if self._isInHomeland then
    GameGlobal.TaskManager():StartTask(function(TT)
      self:RemoveRed(TT)
    end)
  end
  self:InitWidget()
end

function UIN23Movie:RemoveRed(TT)
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N23, ECampaignN23ComponentID.ECAMPAIGN_N23_PANGOLIN)
  local component = self._campaign:GetComponent(ECampaignN23ComponentID.ECAMPAIGN_N23_PANGOLIN)
  component:SetPrefsComponentNew("N19TaskComp")
  component:SetDB(13)
end

function UIN23Movie:OnHide()
end

function UIN23Movie:InitWidget()
  self._movieContent = self:GetUIComponent("UILocalizationText", "movieContent")
  self._goBtn = self:GetUIComponent("Image", "goBtn")
  self._rewardContent = self:GetUIComponent("UISelectObjectPath", "rewardContent")
  self._typeTitle = self:GetUIComponent("UILocalizationText", "typeTitle")
  self._bottomBG = self:GetGameObject("bottomBG")
  self._movieContent:SetText(StringTable.Get("str_movie_campaign_intro"))
  local cfg = Cfg.cfg_global({})
  local rewards = cfg.homeland_movie_task_reward.ArrayValue
  local len = table.count(rewards)
  local index = 1
  self._widgets = self._rewardContent:SpawnObjects("UIItemHomeland", len)
  for i, v in pairs(rewards) do
    local rew = {}
    rew.assetid = v
    rew.count = nil
    self._widgets[index]:Flush(rew)
    index = index + 1
  end
  if self._isInHomeland then
    self._goBtn.sprite = self._atlas:GetSprite("dy_kpb_btn02")
    self._typeTitle:SetText(StringTable.Get("str_movie_inhomeland"))
    self._typeTitle.color = Color(0.45098039215686275, 0.45098039215686275, 0.45098039215686275)
    self._bottomBG:SetActive(true)
    self._goBtn.color = Color(0.45098039215686275, 0.45098039215686275, 0.45098039215686275, 0)
  else
    self._bottomBG:SetActive(false)
  end
end

function UIN23Movie:CloseBtnOnClick()
  self:CloseDialog()
end

function UIN23Movie:CheckBtnOnClick()
  if self._isInHomeland then
    if self._callback then
      self._callback()
    end
  else
    self:ShowDialog("UIHomelandStoryTaskSimpleController", 1, ECampaignType.CAMPAIGN_TYPE_N23, ECampaignN23ComponentID.ECAMPAIGN_N23_PANGOLIN)
  end
end

function UIN23Movie:GoBtnOnClick()
  if self._isInHomeland then
    return
  else
    self._functionId = 34
    local functionLockCfg = Cfg.cfg_module_unlock[self._functionId]
    if not functionLockCfg then
      Log.debug("don't have function config")
      return
    end
    local module = GameGlobal.GetModule(RoleModule)
    if module:CheckModuleUnlock(self._functionId) == false then
      local cfg = Cfg.cfg_module_unlock[self._functionId]
      if cfg then
        ToastManager.ShowToast(StringTable.Get(cfg.Tips))
      end
      return
    end
    GameGlobal.GetModule(HomelandModule):GetUIModule():LoadHomeland()
  end
end
