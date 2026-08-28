local NPCDialog = require("Common/NPCDialog")
local HomeDrinkPanel = {}

local function SetActive(node, active)
  if node == nil then
    return
  end
  if node.self ~= nil then
    node.self:SetActive(active)
  elseif node.SetActive ~= nil then
    node:SetActive(active)
  end
end

local function GetDrinkGroup(ctx)
  if ctx.drinkGroup ~= nil then
    return ctx.drinkGroup
  end
  return ctx.View.Group_Main.Group_Drink
end

local function SetMainActive(ctx, active)
  if ctx.mainGroup ~= nil then
    SetActive(ctx.mainGroup, active)
  end
  if ctx.mainButtons ~= nil then
    for i = 1, #ctx.mainButtons do
      SetActive(ctx.mainButtons[i], active)
    end
  end
end

local function PlayAnim(ctx, animName)
  if animName ~= nil and ctx.View.self ~= nil and ctx.View.self.PlayAnim ~= nil then
    ctx.View.self:PlayAnim(animName)
  end
end

local function ShowNPCTalk(ctx, dialogEnum)
  if ctx.Controller ~= nil and ctx.Controller.ShowNPCTalk ~= nil then
    ctx.Controller:ShowNPCTalk(dialogEnum)
  end
end

function HomeDrinkPanel.CheckTimeDrinkCountRefresh()
  local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
  local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
  local m = tonumber(string.sub(defaultConfig.dailyRefreshTime, 4, 5))
  local s = tonumber(string.sub(defaultConfig.dailyRefreshTime, 7, 8))
  if PlayerData.TempCache.drinkRefresh == nil then
    PlayerData.TempCache.drinkRefresh = PlayerData.ServerData.login_time
  end
  local targetTime = TimeUtil:GetNextSpecialTimeStamp(h, m, s, PlayerData.TempCache.drinkRefresh)
  if targetTime <= TimeUtil:GetServerTimeStamp() then
    PlayerData.TempCache.drinkRefresh = TimeUtil:GetServerTimeStamp()
    PlayerData:GetHomeInfo().free_drink = 0
    PlayerData:GetHomeInfo().drink_num = 0
    PlayerData:GetHomeInfo().extra_drink = 0
    return true
  end
  return false
end

function HomeDrinkPanel.IsDrinkCountExhausted()
  HomeDrinkPanel.CheckTimeDrinkCountRefresh()
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local useCount = PlayerData:GetHomeInfo().drink_num or 0
  local extraCount = PlayerData:GetHomeInfo().extra_drink or 0
  return extraCount == 0 and useCount >= homeConfig.drinkLimitNum
end

function HomeDrinkPanel.OpenDrink(ctx)
  HomeDrinkPanel.CheckTimeDrinkCountRefresh()
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local useCount = PlayerData:GetHomeInfo().drink_num or 0
  local extraCount = PlayerData:GetHomeInfo().extra_drink or 0
  if extraCount == 0 and useCount >= homeConfig.drinkLimitNum then
    local stationCA = PlayerData:GetFactoryData(ctx.DataModel.StationId, "HomeStationFactory")
    if 0 < (stationCA.recoverItem or 0) then
      local t = {}
      t.itemId = stationCA.recoverItem
      t.useNum = 1
      local itemCA = PlayerData:GetFactoryData(t.itemId)
      CommonTips.OnItemPrompt(string.format(GetText(80601345), itemCA.name), t, function()
        if PlayerData:GetGoodsById(t.itemId).num < t.useNum then
          CommonTips.OpenTips(80600062)
          return
        end
        Net:SendProto("station.replenish", function()
          local use = {}
          use[t.itemId] = t.useNum
          PlayerData:RefreshUseItems(use)
          PlayerData:GetHomeInfo().extra_drink = extraCount + 1
          CommonTips.OpenTips(80601363)
        end)
      end)
    else
      ShowNPCTalk(ctx, ctx.DataModel.NPCDialogEnum.upperText)
    end
    return
  end
  ShowNPCTalk(ctx, ctx.DataModel.NPCDialogEnum.OneText)
  SetMainActive(ctx, false)
  SetActive(GetDrinkGroup(ctx), true)
  HomeDrinkPanel.RefreshDrinkInfo(ctx)
  PlayAnim(ctx, ctx.openAnim)
end

function HomeDrinkPanel.DrinkReturnToMain(ctx)
  SetMainActive(ctx, true)
  SetActive(GetDrinkGroup(ctx), false)
  PlayAnim(ctx, ctx.closeAnim)
  if ctx.onReturnToMain ~= nil then
    ctx.onReturnToMain()
  end
end

function HomeDrinkPanel.RefreshDrinkInfo(ctx)
  local homeCommon = require("Common/HomeCommon")
  local maxTired = homeCommon.GetMaxHomeEnergy()
  local curTired = PlayerData:GetUserInfo().move_energy
  local drinkGroup = GetDrinkGroup(ctx)
  drinkGroup.Group_Energy.Txt_Num:SetText(curTired .. "/" .. maxTired)
  drinkGroup.Group_Energy.Img_PB:SetFilledImgAmount(0 < maxTired and curTired / maxTired or 0)
  local stationConfig = PlayerData:GetFactoryData(ctx.DataModel.StationId, "HomeStationFactory")
  ctx.DataModel.DrinkInfo = stationConfig.drinkCost or {}
  ctx.DataModel.DrinkCurCount = (PlayerData:GetHomeInfo().drink_num or 0) + 1
  drinkGroup.StaticGrid_Drink.grid.self:RefreshAllElement()
end

function HomeDrinkPanel.RefreshDrinkElement(ctx, element, elementIndex)
  local info = ctx.DataModel.DrinkInfo and ctx.DataModel.DrinkInfo[elementIndex]
  if info == nil then
    return
  end
  local listCA = PlayerData:GetFactoryData(info.id, "ListFactory")
  if listCA == nil or listCA.drinkList == nil then
    return
  end
  local select = ctx.DataModel.DrinkCurCount
  if select > #listCA.drinkList then
    select = #listCA.drinkList
  end
  local costInfo = listCA.drinkList[select]
  if costInfo == nil then
    return
  end
  local itemCA = PlayerData:GetFactoryData(costInfo.id, "ItemFactory")
  element.Txt_Name:SetText(info.name)
  if costInfo.num == 0 or PlayerData:GetHomeInfo().free_drink == 0 then
    element.Img_Item:SetActive(false)
    element.Txt_Cost:SetActive(false)
    element.Txt_Free:SetActive(true)
  else
    element.Img_Item:SetActive(true)
    element.Txt_Cost:SetActive(true)
    element.Txt_Free:SetActive(false)
    element.Img_Item:SetSprite(itemCA.buyPath or itemCA.iconPath)
    element.Txt_Cost:SetText(costInfo.num)
  end
  element.Img_Item:SetSprite(itemCA.buyPath or itemCA.iconPath)
  element.Txt_Cost:SetText(costInfo.num)
  element.Btn_Click:SetClickParam(elementIndex)
end

function HomeDrinkPanel.Drink(ctx, idx)
  HomeDrinkPanel.CheckTimeDrinkCountRefresh()
  ctx.DataModel.DrinkIdx = idx
  local info = ctx.DataModel.DrinkInfo and ctx.DataModel.DrinkInfo[idx]
  if info == nil then
    return
  end
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local useCount = PlayerData:GetHomeInfo().drink_num or 0
  local extraCount = PlayerData:GetHomeInfo().extra_drink or 0
  if extraCount == 0 and useCount >= homeConfig.drinkLimitNum then
    ShowNPCTalk(ctx, ctx.DataModel.NPCDialogEnum.upperText)
    CommonTips.OpenTips(80600462)
    HomeDrinkPanel.DrinkReturnToMain(ctx)
    return
  end
  if 0 < PlayerData:GetHomeInfo().free_drink then
    local listCA = PlayerData:GetFactoryData(info.id, "ListFactory")
    local select = ctx.DataModel.DrinkCurCount
    if select > #listCA.drinkList then
      select = #listCA.drinkList
    end
    local costInfo = listCA.drinkList[select]
    if PlayerData:GetGoodsById(costInfo.id).num < costInfo.num then
      local itemCA = PlayerData:GetFactoryData(costInfo.id, "ItemFactory")
      local t = {
        [1] = itemCA.name
      }
      NPCDialog.HandleNPCTxtSpecialTable(ctx.DataModel.NPCDialogEnum.ItemText, t)
      ShowNPCTalk(ctx, ctx.DataModel.NPCDialogEnum.ItemText)
      return
    end
  end
  
  local function detailDo()
    if HomeDrinkPanel.CheckShowDrinkBuffReplace(ctx) then
      return
    end
    HomeDrinkPanel.ConfirmDrink(ctx)
  end
  
  local curMoveEnergy = PlayerData:GetUserInfo().move_energy
  if curMoveEnergy == 0 then
    CommonTips.OnPrompt(80600957, nil, nil, function()
      detailDo()
    end)
  else
    detailDo()
  end
end

function HomeDrinkPanel.ConfirmDrink(ctx)
  local oldMoveEnergy = PlayerData:GetUserInfo().move_energy
  Net:SendProto("station.drink", function(json)
    local recoverEnergy = oldMoveEnergy - PlayerData:GetUserInfo().move_energy
    local curDrinkNum = PlayerData:GetHomeInfo().drink_num or 0
    PlayerData:GetHomeInfo().drink_num = curDrinkNum + 1
    local extraCount = PlayerData:GetHomeInfo().extra_drink or 0
    if 0 < extraCount then
      PlayerData:GetHomeInfo().extra_drink = extraCount - 1
    end
    ShowNPCTalk(ctx, ctx.DataModel.NPCDialogEnum.drinkText)
    if 0 < PlayerData:GetHomeInfo().free_drink then
      local info = ctx.DataModel.DrinkInfo and ctx.DataModel.DrinkInfo[ctx.DataModel.DrinkIdx]
      local listCA = PlayerData:GetFactoryData(info.id, "ListFactory")
      local select = ctx.DataModel.DrinkCurCount
      if select > #listCA.drinkList then
        select = #listCA.drinkList
      end
      local costInfo = listCA.drinkList[select]
      PlayerData:RefreshUseItems({
        [costInfo.id] = costInfo.num
      })
    end
    HomeDrinkPanel.RefreshDrinkInfo(ctx)
    if PlayerData:GetHomeInfo().free_drink == 0 then
      PlayerData:GetHomeInfo().free_drink = 1
    end
    local buffId = 0
    if json.home_skills ~= nil then
      local serverData = PlayerData.ServerData.home_skills
      local drinkBuff = PlayerData:GetCurDrinkBuff()
      if drinkBuff ~= nil then
        local buffCA = PlayerData:GetFactoryData(drinkBuff.id, "HomeBuffFactory")
        if serverData[buffCA.buffType] ~= nil then
          serverData[buffCA.buffType].temp = nil
        end
      end
      for k, v in pairs(json.home_skills) do
        if serverData[k] == nil then
          serverData[k] = {}
        end
        serverData[k].temp = v.temp
        local t = {}
        for k1, v1 in pairs(v.temp) do
          if v1.obtain == "drink" then
            buffId = k1
            t.id = k1
            for k2, v2 in pairs(v1) do
              t[k2] = v2
            end
            break
          end
        end
        PlayerData:SetDrinkBuff(t)
        break
      end
    end
    local isShowVideo = HomeDrinkPanel.ShowVideo(ctx, function()
      HomeDrinkPanel.ShowDrinkBuff(ctx, buffId, recoverEnergy)
    end)
    if not isShowVideo then
      HomeDrinkPanel.ShowDrinkBuff(ctx, buffId, recoverEnergy)
    end
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    extraCount = PlayerData:GetHomeInfo().extra_drink or 0
    if extraCount == 0 and (PlayerData:GetHomeInfo().drink_num or 0) >= homeConfig.drinkLimitNum then
      HomeDrinkPanel.DrinkReturnToMain(ctx)
    end
  end, ctx.DataModel.DrinkIdx - 1)
end

function HomeDrinkPanel.CheckShowDrinkBuffReplace(ctx)
  if ctx.enableReplaceTip == false then
    return false
  end
  local checkTime = PlayerData:GetPlayerPrefs("int", "ShowReplaceDrinkBuffTip")
  if checkTime ~= 0 then
    local recordDay = TimeUtil:GetTimeStampTotalDays(checkTime)
    local curTime = TimeUtil:GetServerTimeStamp()
    local curTotalDay = TimeUtil:GetTimeStampTotalDays(curTime)
    if recordDay == curTotalDay then
      return false
    end
    PlayerData:SetPlayerPrefs("int", "ShowReplaceDrinkBuffTip", 0)
  end
  local drinkBuff = PlayerData:GetCurDrinkBuff()
  if drinkBuff ~= nil and ctx.View.Group_TishiWindow ~= nil then
    if ctx.replaceTipPrefabPath ~= nil then
      UIManager:LoadSplitPrefab(ctx.View, ctx.replaceTipPrefabPath, "Group_TishiWindow")
    end
    if ctx.View.Group_TishiWindow.self == nil then
      return false
    end
    ctx.View.Group_TishiWindow.self:SetActive(true)
    local buffCA = PlayerData:GetFactoryData(drinkBuff.id, "HomeBuffFactory")
    local oneForAll = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.OneForAll)
    local desc = buffCA.desc
    if 0 < oneForAll then
      desc = buffCA.intensifyDesc
    end
    ctx.View.Group_TishiWindow.Group_1.Txt_Dec:SetText(desc)
    local min = (drinkBuff.endTime - TimeUtil:GetServerTimeStamp()) / 60
    ctx.View.Group_TishiWindow.Group_1.Txt_Time:SetText(string.format(GetText(80600773), math.ceil(min)))
    ctx.View.Group_TishiWindow.Txt_1:SetText(string.format(GetText(80612499), buffCA.name))
    return true
  end
  return false
end

function HomeDrinkPanel.ConfirmReplaceBuff(ctx)
  if ctx.View.Group_TishiWindow == nil or ctx.View.Group_TishiWindow.self == nil then
    return
  end
  if ctx.View.Group_TishiWindow.Txt_NoReminded.Btn_Check.Txt_Check.IsActive then
    PlayerData:SetPlayerPrefs("int", "ShowReplaceDrinkBuffTip", TimeUtil:GetServerTimeStamp())
  end
  HomeDrinkPanel.ConfirmDrink(ctx)
  ctx.View.Group_TishiWindow.self:SetActive(false)
end

function HomeDrinkPanel.ShowDrinkBuff(ctx, buffId, recoverEnergy)
  if buffId == 0 then
    return
  end
  local t = {}
  t.buffId = buffId
  t.recoverEnergy = recoverEnergy
  UIManager:Open(ctx.drinkBuffUiPath or "UI/Home/BarStore/DrinkBuff", Json.encode(t))
end

function HomeDrinkPanel.ShowVideo(ctx, cb)
  if ctx.enableVideo == false then
    return false
  end
  if ctx.View.Video_Drink == nil or ctx.View.Video_Drink.self == nil then
    return false
  end
  ctx.View.Video_Drink.self:SetActive(true)
  SetActive(ctx.View.Img_IpadTop, true)
  SetActive(ctx.View.Img_IpadBtm, true)
  SetActive(ctx.View.Btn_Skip, true)
  local stationCA = PlayerData:GetFactoryData(ctx.DataModel.StationId, "HomeStationFactory")
  local video = ctx.View.Video_Drink.transform and ctx.View.Video_Drink.transform:GetChild(0)
  if video ~= nil then
    local videoPlayer = video:GetComponent(typeof(CS.UnityEngine.Video.VideoPlayer))
    if videoPlayer ~= nil then
      videoPlayer.controlledAudioTrackCount = 1
      videoPlayer:EnableAudioTrack(0, true)
      videoPlayer:SetTargetAudioSource(0, video:GetComponent(typeof(CS.UnityEngine.AudioSource)))
    end
  end
  ctx.View.Video_Drink.self:Play(stationCA.drinkVideo, false, false, true, function()
    cb()
    SetActive(ctx.View.Img_IpadTop, false)
    SetActive(ctx.View.Img_IpadBtm, false)
    SetActive(ctx.View.Group_Skip, false)
    SetActive(ctx.View.Btn_Skip, false)
  end)
  return true
end

function HomeDrinkPanel.VideoSkip(ctx)
  if ctx.View.Group_Skip ~= nil and ctx.View.Group_Skip.self ~= nil and ctx.View.Group_Skip.self.IsActive and ctx.View.Group_Skip.Group_Tip.Btn_Tip.Group_On.self.IsActive then
    PlayerData:SetPlayerPrefs("int", "ShowDrinkVideo", TimeUtil:GetServerTimeStamp())
  end
  SetActive(ctx.View.Group_Skip, false)
  if ctx.View.Video_Drink ~= nil and ctx.View.Video_Drink.self ~= nil then
    ctx.View.Video_Drink.self:VideoOver()
    ctx.View.Video_Drink.self:SetActive(false)
  end
end

function HomeDrinkPanel.CloseSkip(ctx)
  SetActive(ctx.View.Group_Skip, false)
end

return HomeDrinkPanel
