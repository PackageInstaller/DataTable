local WeaponBackTrackCom, Super = System.NewComponent("WeaponBackTrackCom")

function WeaponBackTrackCom:ctor(uiNode, model)
  Super.ctor(self)
  self.ui = uiNode
  self.model = model
  DBGTeamDataUtils.ReqShowTeam(CommonDefine.TeamType.Special)
end

function WeaponBackTrackCom:OnBind(binder)
  binder:BindZ1Button(self.ui.Btn_Overlay, function()
    local isLock = ItemDataUtils.GetItemLocked(self.model.weapon.uid)
    if isLock then
      Alert.Show(20127)
      return
    end
    self:LevelBackTrackConfirm(function()
      local weaponName = self.model:GetWeaponName()
      local weaponUid = self.model.weapon.uid
      local isTogetherWithSSR = ItemDataUtils.CheckIsMaxLvSSRWeapon(weaponUid) and DBGTeamDataUtils.IsTogetherWithSSRWeapon(weaponUid)
      
      local function confirmFunc()
        EventMgr.Instance.OpenReqMask:Dispatch()
        ProtoManager.Instance:ReqServer("GameRequest", "OnWeaponBacktrackAdvance", function(data)
          BackTrackDataUtils.SetTidHasBackTrack(self.model.weapon.tid)
          if isTogetherWithSSR then
            self:_RemoveWeaponFromAllTeams(weaponUid)
          end
          EventMgr.Instance.OnWeaponBacktrackAdvance:Dispatch(weaponUid)
        end, function(_, code)
          Logger.Error("[命轮叠位回溯] 失败！错误码: %s", code.code)
        end, weaponUid)
      end
      
      if isTogetherWithSSR then
        Alert.ShowWithParams(20214, {weaponName}, nil, confirmFunc)
      else
        Alert.ShowWithParams(20121, {weaponName}, nil, confirmFunc)
      end
    end)
  end, function()
    local lv = self.model.weapon.level
    return lv > 0 and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
  end)
  binder:BindZ1Button(self.ui.Btn_Blackpool, function()
    local weaponUid = self.model.weapon.uid
    local isLock = ItemDataUtils.GetItemLocked(weaponUid)
    if isLock then
      Alert.Show(20127)
      return
    end
    print("--------------weapon ", weaponUid, self.model.weapon.tid or "nil")
    local weaponName = self.model:GetWeaponName()
    print("--------------weapon name ", weaponName)
    
    local function confirmFunc()
      EventMgr.Instance.OpenReqMask:Dispatch()
      ProtoManager.Instance:ReqServer("GameRequest", "OnWeaponBacktrackAll", function(data)
        BackTrackDataUtils.SetTidHasBackTrack(self.model.weapon.tid)
        if self.callBack then
          FrameWaiter.OnNextFrame(function()
            self.callBack()
            PvPTeamBuildDataUtils.ReqOnOpenTeam()
            EventMgr.Instance.WeaponBacktrack:Dispatch(weaponUid)
          end, 1)
        end
      end, function(_, code)
        Logger.Error("[命轮黑池归还] 失败！错误码: %s", code.code)
      end, weaponUid)
    end
    
    if ItemDataUtils.CheckIsMaxLvSSRWeapon(weaponUid) and DBGTeamDataUtils.IsTogetherWithSSRWeapon(weaponUid) then
      Alert.ShowWithParams(20215, {weaponName}, nil, confirmFunc)
    else
      Alert.ShowWithParams(20122, {weaponName}, nil, confirmFunc)
    end
  end, nil, function()
    do return LT.Text end
    return LT.Text, "BlackPoolBackTrack"
  end)
  binder:BindZ1Button(self.ui.Btn_Observe_2, function()
    self:LevelBackTrackConfirm(function()
      self:PreviewRewardByTag(CommonDefine.BackTrackWeaponType.Advance)
    end)
  end)
  binder:BindZ1Button(self.ui.Btn_Observe_1, function()
    self:PreviewRewardByTag(CommonDefine.BackTrackWeaponType.Weapon)
  end)
  
  local function tickFunc()
    local endTime = BackTrackDataUtils.GetEndTime()
    local tickStr = TimeUtils.format(endTime - TimeUtils.GetServerTime(), CommonDefine.TimeParseType.dhms)
    local str = LT.Textf("BacktrackTimesLeft", tickStr)
    binder:SetText(self.ui.Text_Deadline, str)
  end
  
  tickFunc()
  binder:BindTimer(1, -1, function()
    tickFunc()
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Question, function()
    UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("RuleTipsTitle"), LT.Text("BacktrackWeapon_Rules"))
  end)
end

function WeaponBackTrackCom:SetBackTrackCallBack(func)
  self.callBack = func
end

function WeaponBackTrackCom:PreviewRewardByTag(tag)
  local function callback()
    local list = self.model:GetRewardPreview(tag)
    
    UIManager.Instance:Reopen(Urls.BackTrackAwardPreviewPanel, list)
  end
  
  self.model:ReqPreviewWeaponBacktrackItems(callback)
end

function WeaponBackTrackCom:LevelBackTrackConfirm(callback)
  local lv = self.model.weapon.level
  if lv <= 0 then
    Alert.Show(20125)
  elseif callback then
    callback()
  end
end

function WeaponBackTrackCom:_RemoveWeaponFromAllTeams(weaponUid)
  local QualitySSR = cd.CommonQuality.Orange
  for _, teamType in pairs({
    CommonDefine.TeamType.Normal,
    CommonDefine.TeamType.Special
  }) do
    local teamsData = DBGTeamDataUtils.GetDBGTeams(teamType)
    for _, teamData in pairs(teamsData) do
      if teamData and teamData.awakers then
        for _, awakerData in pairs(teamData.awakers) do
          local weaponSlotList = AwakerDataUtils.GetWeaponSlotData(awakerData)
          local hasOtherNonMaxSSR = false
          local hasSelf = false
          for _, weaponSlot in pairs(weaponSlotList) do
            if weaponSlot and weaponSlot.weaponUid then
              if weaponSlot.weaponUid == weaponUid then
                hasSelf = true
              else
                local otherWeaponData = ItemDataUtils.GetWeaponByUid(weaponSlot.weaponUid)
                local otherTid = otherWeaponData and otherWeaponData.tid or 0
                local otherCfg = ItemDataUtils.GetItemConfig(otherTid)
                if otherCfg and otherCfg.Quality == QualitySSR and not ItemDataUtils.IsMaxLevelWeapon(weaponSlot.weaponUid) then
                  hasOtherNonMaxSSR = true
                end
              end
            end
          end
          if hasSelf and hasOtherNonMaxSSR and awakerData.weaponSlots then
            for _, weaponSlot in pairs(awakerData.weaponSlots) do
              if weaponSlot and weaponSlot.weaponUid == weaponUid then
                weaponSlot.weaponUid = 0
              end
            end
          end
        end
      end
    end
  end
end

function WeaponBackTrackCom:OnUnbind()
  Super.OnUnbind(self)
end

return WeaponBackTrackCom
