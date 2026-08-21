_class("UISeasonMazeRoomMining", UISeasonMazeRoomBase)
UISeasonMazeRoomMining = UISeasonMazeRoomMining

function UISeasonMazeRoomMining:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeRoomMining:OnShowUI(uiParams)
  self:InitWidget()
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._seasonMazeObj = self._seasonMazeModule:CurSeasonObj()
  self._component = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self.cfgId = self._roomInfo.cfg_id
  self.miningCfg = self:GetMiningCfg()
  self.curSelectPet = nil
  self.petJsonIcon = {
    [2001] = "epg_gqxq_icon08",
    [2002] = "epg_gqxq_icon06",
    [2003] = "epg_gqxq_icon07",
    [2004] = "epg_gqxq_icon09"
  }
  self.petElementIcon = {
    [1] = "spirit_shuxing2_icon",
    [2] = "spirit_shuxing3_icon",
    [3] = "spirit_shuxing1_icon",
    [4] = "spirit_shuxing4_icon"
  }
  self._atlasPetElement = self:GetAsset("UIPetElement.spriteatlas", LoadType.SpriteAtlas)
  self._uiSeasonMazeModule = self:GetUIModule(SeasonMazeModule)
  local missionModule = GameGlobal.GetModule(MissionModule)
  local context = missionModule:TeamCtx()
  context:InitSeasonMazeTeam(self._comInfo.m_formation_list)
  context:Init(TeamOpenerType.SeasonMaze, {})
  self:SetDispatchRound()
  self:SetDispatchRewardDesc()
  self:ShowLeaveBtn()
  self:_CheckGuide()
end

function UISeasonMazeRoomMining:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUIShare.UISeasonMazeRoomMining)
end

function UISeasonMazeRoomMining:GetMiningCfg()
  local cfgs = Cfg.cfg_component_season_maze_room_ore({
    ID = self.cfgId
  })
  if cfgs and 0 < #cfgs then
    return cfgs[1]
  end
end

function UISeasonMazeRoomMining:InitWidget()
  self.professionImg = self:GetUIComponent("Image", "profession")
  self.mainElementImg = self:GetUIComponent("Image", "MainElement")
  self.RewardDescText = self:GetUIComponent("UILocalizationText", "RewardDesc")
  self.petHeadIcon = self:GetUIComponent("RawImageLoader", "petIcon")
  self.petHeadIconObj = self:GetGameObject("petIcon")
  self.txtDispach = self:GetUIComponent("UILocalizationText", "txtDispach")
  self._rountSelectPool = self:GetUIComponent("UISelectObjectPath", "roundSelect")
end

function UISeasonMazeRoomMining:SetDispatchRound()
  local cfgNums = self.miningCfg.RoundCount
  local len = #cfgNums
  self._roundWidget = self._rountSelectPool:SpawnObjects("UISeasonMazeRoundSelBtn", len)
  for i, subWiget in ipairs(self._roundWidget) do
    subWiget:SetData(cfgNums[i], function(num)
      self:_OnRoundNumSelect(num)
    end)
  end
  self._selectRoundNum = 0
  self._hasResourceEffect = 0 < self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Resource_Percent)
  if self._hasResourceEffect then
    self:_OnRoundNumSelect(cfgNums[len])
  end
  self:RefreshReward()
end

function UISeasonMazeRoomMining:_OnRoundNumSelect(num)
  if self._hasResourceEffect and num < self._selectRoundNum then
    ToastManager.ShowToast(StringTable.Get("str_season_maze_ore_room_tips_extra1"))
    return
  end
  self._selectRoundNum = num
  for i, v in ipairs(self._roundWidget) do
    local bSelect = num == v:GetRoundNum()
    v:SetSelect(bSelect)
    if bSelect then
      self._selectRoundServerIndex = i - 1
    end
  end
  self:RefreshReward()
end

function UISeasonMazeRoomMining:SetDispatchRewardDesc()
  self.onceGolds = self.miningCfg.OnceGolds
  self.roundGolds = self.miningCfg.RoundGolds
end

function UISeasonMazeRoomMining:RefreshReward()
  if self._selectRoundNum == 0 then
    self.RewardDescText:SetText(StringTable.Get("str_season_maze_ore_room_tips_choose_round2"))
  else
    local idx = self._selectRoundServerIndex + 1
    local onceGold = self.miningCfg.OnceGolds[idx]
    local roundGold = self.miningCfg.RoundGolds[idx]
    self.RewardDescText:SetText(StringTable.Get("str_season_maze_ore_room_reward", onceGold, roundGold))
  end
end

function UISeasonMazeRoomMining:PetSelectOnClick(go)
  local allPets = self._uiSeasonMazeModule:GetSeasonMazePets()
  self:ShowDialog("UISeasonMazeTeamChangeController", allPets, function(pstid)
    self.curSelectPet = allPets[pstid]
    self.petHeadIconObj:SetActive(true)
    local head = HelperProxy:GetInstance():GetPetHead(self.curSelectPet:GetTemplateID(), self.curSelectPet:GetPetGrade(), self.curSelectPet:GetSkinId(), PetSkinEffectPath.HEAD_ICON_DISPATCH)
    self.petHeadIcon:LoadImage(head)
  end)
end

function UISeasonMazeRoomMining:StartButtonOnClick(go)
  if self._selectRoundNum < 1 then
    ToastManager.ShowToast(StringTable.Get("str_season_maze_ore_room_tips_choose_round2"))
    return
  end
  if not self.curSelectPet then
    ToastManager.ShowToast(StringTable.Get("str_season_maze_ore_room_tips_choose_pet"))
    return
  end
  GameGlobal.TaskManager():StartTask(self.OnReqFinishRoom, self)
end

function UISeasonMazeRoomMining:OnReqFinishRoom(TT)
  local res = AsyncRequestRes:New()
  self:Lock("UISeasonMazeRoomMining:ReqFinishRoom")
  self._response = self._component:HandleSeasonMazeOre(TT, res, self.curSelectPet:GetTemplateID(), true, self._selectRoundServerIndex)
  self:UnLock("UISeasonMazeRoomMining:ReqFinishRoom")
  if res and res:GetSucc() then
    self:OnHideUI(self._response.reward)
  else
    local result = res:GetResult()
    Log.error("###[UISeasonMazeRoomMining] HandleSeasonMazeOre fail ! result : ", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazeRoomMining:GiveUpButtonOnClick(go)
  UISeasonMazeModule.PopMsgBox(StringTable.Get("str_season_maze_room_ore_title"), StringTable.Get("str_season_maze_room_ore_give_up_confirm"), SeasonMazeMsgBoxType.OkCancel, function()
    self:OnHideUI()
  end)
end
