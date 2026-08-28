local DataModel = require("UIBossMenu/UIBossMenuDataModel")
local View = require("UIBossMenu/UIBossMenuView")
local BtnItem = require("Common/BtnItem")
local MonopolyManager = require("UIMonopoly/LuaMonopolyManager")
local UIBossMenuController = {curOpenPanelIndex = 0}

function UIBossMenuController.Init(isHelpBoss)
  View.Img_RightBG.Img_FightRewards:SetSprite((GetResPath(88300169)))
  View.Img_RightBG.Img_KillRewards:SetSprite((GetResPath(88300170)))
  View.Group_Help.Img_BG.Btn_HelpFriends.Img_:SetSprite((GetResPath(88300174)))
  View.Group_Help.Img_BG.Btn_AskHelp.Img_:SetSprite((GetResPath(88300172)))
  View.Group_Help.Img_BG.Group_HelpFriends.Img_.Img_:SetSprite((GetResPath(88300173)))
  View.Group_Help.Img_BG.Group_AskHelp.Img_.Img_:SetSprite((GetResPath(88300171)))
  if isHelpBoss then
    UIBossMenuController.RefreshFriendHelpShow()
  else
    UIBossMenuController.RefreshMyBossShow()
  end
  local sound = SoundManager:CreateSound(30006353)
  if sound then
    sound:Play()
  end
end

function UIBossMenuController.Release()
end

function UIBossMenuController.OnQuitBtnClick()
  if UIBossMenuController.curOpenPanelIndex == 1 then
    UIManager:ClosePanel()
  else
    UIBossMenuController.RefreshMyBossShow()
  end
end

function UIBossMenuController.RefreshMyBossShow()
  UIBossMenuController.curOpenPanelIndex = 1
  View.Group_Help:SetActive(false)
  local unitConfig = DataModel.GetBossUnitConfig()
  if not unitConfig then
    return
  end
  View.Img_RightBG.Img_Info.Txt_Name:SetText(unitConfig.name)
  View.Img_RightBG.Img_Info.Img_Lv.Txt_LV:SetText(string.format(GetText(80609744), PlayerData:GetUserInfo().lv))
  View.Img_RightBG.Txt_Des:SetText(DataModel.LevelDesc())
  View.Img_LeftBG.Img_Pedestal.Group_Live.Spine_Boss:SetAction("stand", true)
  local bossKillRewList = DataModel.GetBossKillRewardList() or {}
  if table.count(bossKillRewList) > 0 then
    View.Img_RightBG.Img_KillRewards:SetActive(true)
    View.Img_RightBG.Img_KillRewards.ScrollGrid_Reward.grid.self:SetDataCount(#bossKillRewList)
    View.Img_RightBG.Img_KillRewards.ScrollGrid_Reward.grid.self:RefreshAllElement()
  else
    View.Img_RightBG.Img_KillRewards:SetActive(false)
  end
  local fightRewList = DataModel.GetFightRewardList() or {}
  if table.count(fightRewList) > 0 then
    View.Img_RightBG.Img_FightRewards:SetActive(true)
    View.Img_RightBG.Img_FightRewards.ScrollGrid_Reward.grid.self:SetDataCount(#fightRewList)
    View.Img_RightBG.Img_FightRewards.ScrollGrid_Reward.grid.self:RefreshAllElement()
  else
    View.Img_RightBG.Img_FightRewards:SetActive(false)
  end
  Net:SendProto("monopoly.boss_info", function(json)
    if string.nilorempty(json.rc) then
      DataModel.SetBossSerInfo(json.bossHp, json.boss_time)
      DataModel.SetAskBossTime(json.ask_boss_time)
      DataModel.SetHelpBossTime(json.help_boss_time)
      DataModel.SetHadAskedList(json.had_asked)
      View.Img_LeftBG.Img_Pedestal.Group_Live.Img_Damage.Txt_Num:SetText(tostring(json.last_attach_hp))
      local bossMaxHp = DataModel.GetBossMaxHp()
      local bossHp = json.bossHp or 0
      View.Img_RightBG.Img_HP.Img_Txt.Txt_Num:SetText(tostring(json.bossHp) .. "/" .. tostring(bossMaxHp))
      local ratio = bossHp / (bossMaxHp == 0 and 1 or bossMaxHp)
      View.Img_RightBG.Img_HP.Img_ProgressBar:SetFilledImgAmount(ratio)
      if 0 < bossHp then
        View.Img_RightBG.Btn_Fight.Txt_Num:SetText(string.format(GetText(80609750), json.boss_time))
        View.Img_RightBG.Btn_Fight.Txt_:SetText(GetText(80609749))
        View.Img_LeftBG.Img_Pedestal.Group_Live:SetActive(true)
        View.Img_LeftBG.Img_Pedestal.Img_Kill:SetActive(false)
        View.Img_RightBG.Img_FightRewards.Img_Mask:SetActive(false)
        View.Img_RightBG.Btn_Fight.Img_Rewards:SetActive(false)
      else
        View.Img_RightBG.Btn_Fight.Txt_Num:SetText(GetText(80609769))
        View.Img_LeftBG.Img_Pedestal.Group_Live:SetActive(true)
        View.Img_LeftBG.Img_Pedestal.Group_Live.Img_Damage:SetActive(false)
        View.Img_LeftBG.Img_Pedestal.Group_Live.Img_Mask:SetActive(true)
        View.Img_RightBG.Img_FightRewards.Img_Mask:SetActive(true)
        View.Img_RightBG.Btn_Fight.Img_Rewards:SetActive(true)
        if not json.boss_recv or not json.boss_recv[DataModel.GetBossLevelId()] then
          DataModel.myBossKillRewIsRec = false
          View.Img_RightBG.Btn_Fight.Txt_:SetActive(true)
          View.Img_RightBG.Btn_Fight.Txt_:SetText(GetText(80607084))
          View.Img_RightBG.Btn_Fight.Img_Mask:SetActive(false)
        else
          DataModel.myBossKillRewIsRec = true
          View.Img_RightBG.Btn_Fight.Txt_:SetActive(false)
          View.Img_RightBG.Btn_Fight.Img_Mask:SetActive(true)
        end
      end
    end
  end, DataModel.GetBossLevelId(), function(json)
    MonopolyManager.CheckTimeIsOverAndBack()
  end)
end

function UIBossMenuController.RefreshBossKillRewardElement(element, elementIndex)
  local bossKillRewList = DataModel.GetBossKillRewardList() or {}
  if bossKillRewList[elementIndex] then
    BtnItem:SetItem(element.Group_Item, {
      id = bossKillRewList[elementIndex].id,
      num = bossKillRewList[elementIndex].num
    })
    element.Group_Item.Btn_Item:SetClickParam(bossKillRewList[elementIndex].id)
  end
end

function UIBossMenuController.RefreshFightRewardElement(element, elementIndex)
  local fightRewList = DataModel.GetFightRewardList() or {}
  if fightRewList[elementIndex] then
    BtnItem:SetItem(element.Group_Item, {
      id = fightRewList[elementIndex].id,
      num = fightRewList[elementIndex].num
    })
    element.Group_Item.Btn_Item:SetClickParam(fightRewList[elementIndex].id)
  end
end

function UIBossMenuController.OnMyBossFightAndGetBtnClick()
  local bossSerInfo = DataModel.GetBossSerInfo()
  if not bossSerInfo then
    return
  end
  if bossSerInfo.bossHp <= 0 then
    UIBossMenuController.OnMyBossGetBtnClick()
  else
    UIBossMenuController.OnMyBossFightBtnClick()
  end
end

function UIBossMenuController.OnMyBossFightBtnClick()
  local bossSerInfo = DataModel.GetBossSerInfo()
  if not bossSerInfo then
    return
  end
  if bossSerInfo.bossTime <= 0 then
    CommonTips.OpenTips(80609361)
    return
  end
  if 0 >= bossSerInfo.bossHp then
    CommonTips.OpenTips(80609362)
    return
  end
  local ca = PlayerData:GetFactoryData(PlayerData.GetUserMonopolyId(), "MonopolyGameMapFactory")
  if ca then
    local nowTime = TimeUtil:GetServerTimeStamp() or 0
    local mpyEndTime = TimeUtil:TimeStamp(ca.endTime) or 0
    local signEndTime = TimeUtil:TimeStamp(PlayerData.GetMonopolySignEnd()) or 0
    if nowTime >= mpyEndTime then
      CommonTips.OpenLoading(function()
        CBus:ChangeScene("Main")
      end)
      return
    elseif nowTime >= signEndTime then
      CommonTips.OpenLoading(function()
        CBus:ChangeScene("Main")
      end)
      return
    end
  end
  UIBossMenuController.OnQuitBtnClick()
  UIBossMenuController.SetBoxBossFightState(true, false)
  local status = {
    levelId = tonumber(DataModel.GetBossLevelId()) or 0,
    Current = "Monopoly",
    extraUIParamData = {scene = "Monopoly"}
  }
  PlayerData.BattleCallBackPage = "UI/Monopoly/Monopoly"
  UIManager:Open("UI/Squads/Squads", Json.encode(status))
end

function UIBossMenuController.OnMyBossGetBtnClick()
  local bossSerInfo = DataModel.GetBossSerInfo()
  if not bossSerInfo then
    return
  end
  if bossSerInfo.bossHp > 0 then
    CommonTips.OpenTips(80609363)
    return
  end
  if DataModel.myBossKillRewIsRec then
    return
  end
  Net:SendProto("monopoly.recv_boss", function(json)
    if string.nilorempty(json.rc) then
      DataModel.myBossKillRewIsRec = true
      View.Img_RightBG.Btn_Fight.Txt_:SetText(GetText(80609079))
      View.Img_RightBG.Btn_Fight.Img_Mask:SetActive(true)
      if json.reward and table.count(json.reward) > 0 then
        CommonTips.OpenShowItem(json.reward)
      end
    end
  end, DataModel.GetBossLevelId(), function(json)
    MonopolyManager.CheckTimeIsOverAndBack()
  end)
end

function UIBossMenuController.RefreshFriendHelpShow()
  UIBossMenuController.curOpenPanelIndex = 2
  View.Group_Help:SetActive(true)
  View.Group_Help.Img_BG.Group_HelpFriends:SetActive(true)
  View.Group_Help.Img_BG.Group_AskHelp:SetActive(false)
  Net:SendProto("monopoly.help_boss_info", function(json)
    if string.nilorempty(json.rc) and json.help_info then
      UIBossMenuController.RefreshHelpBossTimeShow()
      DataModel.SetHelpFriendList(json.help_info)
      local listCount = table.count(json.help_info) or 0
      View.Group_Help.Img_BG.Group_HelpFriends.Img_Limit.Txt_Limit:SetText(string.format(GetText(80609763), listCount, DataModel.GetHelpFightLimit()))
      if 0 < listCount then
        View.Group_Help.Img_BG.Group_HelpFriends.ScrollGrid_User.self.gameObject:SetActive(true)
        View.Group_Help.Img_BG.Group_HelpFriends.ScrollGrid_User.grid.self:SetDataCount(listCount)
        View.Group_Help.Img_BG.Group_HelpFriends.ScrollGrid_User.grid.self:RefreshAllElement()
        View.Group_Help.Img_BG.Group_HelpFriends.ScrollGrid_User.grid.self:MoveToTop()
        View.Group_Help.Img_BG.Img_EmptyIcon:SetActive(false)
      else
        View.Group_Help.Img_BG.Group_HelpFriends.ScrollGrid_User.self.gameObject:SetActive(false)
        View.Group_Help.Img_BG.Img_EmptyIcon:SetActive(true)
      end
    end
  end, function(json)
    MonopolyManager.CheckTimeIsOverAndBack()
  end)
  Net:SendProto("monopoly.boss_info", function(json)
    if string.nilorempty(json.rc) then
      DataModel.SetHelpBossTime(json.help_boss_time)
      UIBossMenuController.RefreshHelpBossTimeShow()
    end
  end, DataModel.GetBossLevelId(), function(json)
    MonopolyManager.CheckTimeIsOverAndBack()
  end)
end

function UIBossMenuController.RefreshFriendHelpElement(element, elementIndex)
  if element == nil then
    return
  end
  local friendHelpList = DataModel.GetHelpFriendList() or {}
  local info = friendHelpList[elementIndex]
  if not info then
    return
  end
  element.Btn_Help:SetClickParam(elementIndex)
  local bossMaxHp = DataModel.GetBossMaxHp()
  local bossHp = info.bossHp or 0
  element.Img_HP.Txt_Num:SetText(tostring(bossHp) .. "/" .. tostring(bossMaxHp))
  local ratio = bossHp / (bossMaxHp == 0 and 1 or bossMaxHp)
  element.Img_HP.Img_Num:SetFilledImgAmount(ratio)
  if 0 < bossHp then
    element.Btn_Help:SetActive(true)
    element.Img_Mask:SetActive(false)
  else
    element.Btn_Help:SetActive(false)
    element.Img_Mask:SetActive(true)
  end
  local headPath
  if info.avatar then
    local photoCA = PlayerData:GetFactoryData(info.avatar, "ProfilePhotoFactory")
    headPath = photoCA.imagePath
    CommonTips:SetPlayerHeadShader(element.Img_HeadBG.Img_HeadMask.Img_spAdd, photoCA)
  else
    local configCA = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    headPath = configCA.playerHeadList[info.gender + 1].playerHeadPath
  end
  if headPath then
    element.Img_HeadBG.Img_HeadMask.Img_Head:SetSprite(headPath)
  end
  element.Img_HeadBG.Img_Info.Txt_Name:SetText(string.nilorempty(info.remark) and info.role_name or info.remark)
  element.Img_HeadBG.Img_Info.Txt_LV:SetText(string.format(GetText(80609843), info.lv))
  element.Img_BossIcon:SetSprite(DataModel.GetBossIcon())
  local levelConfig = PlayerData:GetFactoryData(info.boss_id, "LevelFactory")
  if levelConfig then
    local unitConfig = PlayerData:GetFactoryData(levelConfig.bossId, "unitFactory")
    if unitConfig then
      element.Img_HP.Txt_BossName:SetText(unitConfig.name)
    end
  end
end

function UIBossMenuController.RefreshHelpBossTimeShow()
  View.Group_Help.Img_BG.Group_HelpFriends.Txt_Num:SetText(string.format(GetText(80610011), DataModel.GetHelpBossTime(), DataModel.GetHelpBossLimitTime()))
end

function UIBossMenuController.SetBoxBossFightState(isFighting, isHelpBoss)
  MonopolyManager.SetBoxBossFightState(isFighting, isHelpBoss)
end

function UIBossMenuController.RefreshAskHelpShow()
  UIBossMenuController.curOpenPanelIndex = 3
  View.Group_Help:SetActive(true)
  View.Group_Help.Img_BG.Group_HelpFriends:SetActive(false)
  View.Group_Help.Img_BG.Group_AskHelp:SetActive(true)
  Net:SendProto("friend.get_lists", function(json)
    if string.nilorempty(json.rc) and json.friends then
      DataModel.SetAskFriendList(json.friends)
      UIBossMenuController.RefreshAskHelpTimeShow()
      local listCount = table.count(json.friends) or 0
      if 0 < listCount then
        View.Group_Help.Img_BG.Group_AskHelp.ScrollGrid_User.grid.self.gameObject:SetActive(true)
        View.Group_Help.Img_BG.Group_AskHelp.ScrollGrid_User.grid.self:SetDataCount(listCount)
        View.Group_Help.Img_BG.Group_AskHelp.ScrollGrid_User.grid.self:RefreshAllElement()
        View.Group_Help.Img_BG.Group_AskHelp.ScrollGrid_User.grid.self:MoveToTop()
        View.Group_Help.Img_BG.Img_EmptyIcon:SetActive(false)
      else
        View.Group_Help.Img_BG.Group_AskHelp.ScrollGrid_User.grid.self.gameObject:SetActive(false)
        View.Group_Help.Img_BG.Img_EmptyIcon:SetActive(true)
      end
    end
  end)
end

function UIBossMenuController.RefreshAskHelpElement(element, elementIndex)
  if element == nil then
    return
  end
  local friendList = DataModel.GetAskFriendList() or {}
  local friendInfo = friendList[elementIndex]
  if not friendInfo then
    return
  end
  element.Btn_AskHelp:SetClickParam(elementIndex)
  element.Txt_Name:SetText(friendInfo.role_name)
  element.Txt_Login.Txt_Value:SetText(TimeUtil:GetFriendDesc(friendInfo.login_time))
  element.Txt_LV:SetText(string.format(GetText(80601968), friendInfo.lv))
  local headPath
  if friendInfo.avatar then
    local photoCA = PlayerData:GetFactoryData(friendInfo.avatar, "ProfilePhotoFactory")
    if photoCA then
      headPath = photoCA.imagePath
      CommonTips:SetPlayerHeadShader(element.Img_HeadBG.Img_HeadMask.Img_spAdd, photoCA)
    else
      local configCA = PlayerData:GetFactoryData(99900001, "ConfigFactory")
      headPath = configCA.playerHeadList[friendInfo.gender + 1].playerHeadPath
    end
  else
    local configCA = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    headPath = configCA.playerHeadList[friendInfo.gender + 1].playerHeadPath
  end
  if headPath then
    element.Img_HeadBG.Img_HeadMask.Img_Head:SetSprite(headPath)
  end
  local canAsk, desc = DataModel.GetAskFriendHelpState(friendInfo)
  if canAsk then
    element.Img_Mask:SetActive(false)
  else
    element.Img_Mask:SetActive(true)
    element.Img_Mask.Txt_Status:SetText(desc)
  end
end

function UIBossMenuController.RefreshAskHelpTimeShow()
  View.Group_Help.Img_BG.Group_AskHelp.Txt_Num:SetText(string.format(GetText(80609764), DataModel.GetAskBossTime(), DataModel.GetAskHelpLimit()))
end

function UIBossMenuController.CheckMPYIsOver()
  MonopolyManager.CheckTimeIsOverAndBack()
end

return UIBossMenuController
