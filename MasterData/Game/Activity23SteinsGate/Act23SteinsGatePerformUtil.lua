local Act23SteinsGateEnum = require("Game.Activity23SteinsGate.Data.Act23SteinsGateEnum")
local Act23SteinsGatePerformUtil = {}

local function OpenTimeLineMap(storyLineCfg, isInteract, id)
  local eActInteract = require("Game.ActivityLobby.Activity.2023SteinsGate.eActInteract")
  local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  local func = ctrl.actLbIntrctCtrl:GetActLbIntrctActionFunc(eActInteract.eLbIntrctActionId.Main)
  local para
  if isInteract then
    para = storyLineCfg.interact_para
  else
    para = storyLineCfg.win_para
  end
  if func ~= nil then
    func(nil, {
      performData = {id = id, para = para}
    })
  end
end

Act23SteinsGatePerformUtil.PerformFuncDic = {
  [Act23SteinsGateEnum.performType.OpenStoryLine] = function(storyLineCfg, isInteract)
    print("OpenStoryLine")
    OpenTimeLineMap(storyLineCfg, isInteract, Act23SteinsGateEnum.performType.OpenStoryLine)
  end,
  [Act23SteinsGateEnum.performType.OpenAndExtendStoryLine] = function(storyLineCfg, isInteract)
    print("OpenAndExtendStoryLine")
    OpenTimeLineMap(storyLineCfg, isInteract, Act23SteinsGateEnum.performType.OpenAndExtendStoryLine)
  end,
  [Act23SteinsGateEnum.performType.ReturnStoryLine] = function(storyLineCfg)
    print("ReturnStoryLine")
    local eActInteract = require("Game.ActivityLobby.Activity.2023SteinsGate.eActInteract")
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    local func = ctrl.actLbIntrctCtrl:GetActLbIntrctActionFunc(eActInteract.eLbIntrctActionId.Main)
    if func ~= nil then
      func()
    end
  end,
  [Act23SteinsGateEnum.performType.ChangeLobby] = function(storyLineCfg, isInteract)
    local para = isInteract and storyLineCfg.interact_para or storyLineCfg.win_para
    local lobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    lobbyCtrl:SetLobbyBgmPause(true)
    local actSGCtrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate)
    local paraList = {}
    paraList[1] = para[1]
    paraList[2] = para[2]
    actSGCtrl:TryChangeSteinsGate23(paraList, nil)
  end,
  [Act23SteinsGateEnum.performType.WorldLineSwitchAndChangeLobby] = function(storyLineCfg, isInteract)
    local para = isInteract and storyLineCfg.interact_para or storyLineCfg.win_para
    local lobbyId = para[1]
    local worldLineId = para[2]
    local resetBron = para[3]
    local lobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    if not isInteract and (lobbyCtrl == nil or lobbyCtrl:GetActLobbyIndex() == lobbyId) then
      return
    end
    local movieWin = UIManager:ShowWindow(UIWindowTypeID.MoviePlayer)
    if movieWin then
      movieWin:SetWindowPermanent(true)
    end
    local CameraEffectUtil = require("Game.Exploration.Util.CameraEffectUtil")
    local CameraEffectEnum = CameraEffectUtil.CameraEffectEnum
    local resLoader = CS.ResLoader.Create()
    lobbyCtrl:SetLobbyBgmPause(true)
    CameraEffectUtil.CameraEffectFunction[CameraEffectEnum.SteinLineChange](worldLineId, resLoader, function()
      resLoader:Put2Pool()
      local movieWin = UIManager:GetWindow(UIWindowTypeID.MoviePlayer)
      if movieWin then
        movieWin:SetWindowPermanent(false)
      end
      if lobbyCtrl:GetIsInLoading() then
        UIUtil.AddOneCover("ChangeLobby", SafePack(nil, nil, nil, Color.black, false))
      end
    end)
    TimerManager:StartTimer(5.3, function()
      local lobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
      local actCtrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate)
      if lobbyCtrl == nil or actCtrl == nil then
        return
      end
      local movieWin = UIManager:GetWindow(UIWindowTypeID.MoviePlayer)
      if movieWin and movieWin.active then
        movieWin:SetUIMaskOpen(true)
      end
      local paraList = {}
      paraList[1] = lobbyId
      paraList[2] = resetBron
      actCtrl:TryChangeSteinsGate23(paraList, true)
    end, nil, true)
  end,
  [Act23SteinsGateEnum.performType.ChangeHeroState] = function(storyLineCfg)
  end
}
return Act23SteinsGatePerformUtil
