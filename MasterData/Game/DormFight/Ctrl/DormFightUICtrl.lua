local DormFightCtrlBase = require("Game.Fight.Ctrl.DormFightCtrlBase")
local DormFightUICtrl = class("DormFightUICtrl", DormFightCtrlBase)
local CS_pvpFightManager_ins = CS.PvpFightManager.Instance

function DormFightUICtrl:ctor()
end

function DormFightUICtrl:OnPrepareDormFightUI(dormFightCtrl)
  self.dormFightCtrl = dormFightCtrl
  self.resLoader = CS.ResLoader.Create()
  self.fightUI = UIManager:ShowWindow(UIWindowTypeID.DormFightMain)
  self.fightUI:InitDormFightMain(dormFightCtrl, self.resLoader)
  self.fightUI:Hide()
  self.pvpFightUiController = CS_pvpFightManager_ins.PvpFightUiController
  self.characterInfoWindow = self.pvpFightUiController:CreateCharacterInfoWindow()
  self.characterInfoWindow:Hide()
end

function DormFightUICtrl:OnEnterDormFightScene()
  self:ShowVSUI(function()
    self.fightUI:Show()
    self.characterInfoWindow:Show()
  end)
end

function DormFightUICtrl:ShowVSUI(callback)
  self.vsUI = UIManager:ShowWindow(UIWindowTypeID.DOrmFightVS)
  self.vsUI:InitDormFightVS(self.dormFightCtrl, self.resLoader, callback)
end

function DormFightUICtrl:OnCreateFighter(fighterController)
  local netCharacter = fighterController.NetCharacter
  if netCharacter.IsOwnedBySelf then
    self:SetMainCharacter(fighterController)
  end
end

function DormFightUICtrl:OnDestroyFighter(pvpFightController, fighterController)
  local netCharacter = fighterController.NetCharacter
  local retiredUserId = netCharacter.NetId.userId
  local killerRoomPlayer, retiredRoomPlayer
  local userList = pvpFightController.RoomInfo.userList
  for i = 0, userList.Count - 1 do
    if userList[i].userId == retiredUserId then
      retiredRoomPlayer = userList[i]
    else
      killerRoomPlayer = userList[i]
    end
  end
  local killerIndex = killerRoomPlayer.CurrentFighterIndex + 1
  local retiredindex = retiredRoomPlayer.CurrentFighterIndex
  self.fightUI:OnFighterRetired(netCharacter.IsOwnedBySelf, killerIndex, retiredindex)
end

function DormFightUICtrl:FightSecondsChanged(pvpFightController, dormFightInGameState, seconds)
  self.fightUI:UpDateCountDown(seconds, dormFightInGameState.fightTimeLimit)
end

function DormFightUICtrl:SetMainCharacter(fighterController)
  if IsNull(self.fightUI) then
    return
  end
  self.fightUI:SetMainFighterController(fighterController)
end

function DormFightUICtrl:OnUpdateBtnWeapon(netCharacter)
  self.fightUI:OnUpdateBtnWeapon(netCharacter)
end

function DormFightUICtrl:OnUpdateBtnRun(netCharacter)
  self.fightUI:OnUpdateBtnRun(netCharacter)
end

function DormFightUICtrl:OnFightStart()
end

function DormFightUICtrl:OnFightEnd(winnerUserData, mvpFighter, killCount, exitCallback)
  if self.characterInfoWindow == nil then
    return
  end
  self.characterInfoWindow:Hide()
  UIManager:HideWindow(UIWindowTypeID.DormFightMain)
  UIManager:ShowWindowAsync(UIWindowTypeID.DormFightResult, function(win)
    if win == nil then
      return
    end
    win:InitDormFightResult(killCount, mvpFighter.heroId, mvpFighter.skinId, winnerUserData, function()
      UIManager:DeleteAllWindow()
      CS.GSceneManager.Instance:LoadSceneAsyncByAB(Consts.SceneName.Main, function(ok)
        ControllerManager:GetController(ControllerTypeId.HomeController, true):OnEnterHome()
        UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
          if window == nil then
            return
          end
          window:SetFrom2Home(AreaConst.Sector, true)
        end)
        if exitCallback ~= nil then
          exitCallback()
        end
      end)
    end)
  end)
end

function DormFightUICtrl:Delete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self:ClearDormFightLuaWindow()
  self:ClearAllCSharpWindow()
end

function DormFightUICtrl:ClearDormFightLuaWindow()
  UIManager:DeleteWindow(UIWindowTypeID.DormFightMain)
  self.fightUI = nil
end

function DormFightUICtrl:ClearAllCSharpWindow()
  if not IsNull(self.pvpFightUiController) then
    self.pvpFightUiController:DestroyCharacterInfoWindow()
    self.characterInfoWindow = nil
  end
end

return DormFightUICtrl
