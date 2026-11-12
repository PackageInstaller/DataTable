local SoldierSandtablePanel = class("SoldierSandtablePanel", BasePanel)
SoldierSandtablePanel._bIsMainPanel = true
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
SoldierSandtablePanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Level/SoldierSandtablePanel.prefab",
    sCtrlName = "Game.UI.Soldier.Sandtable.SoldierSandtableCtrl"
  }
}

function SoldierSandtablePanel:Awake()
  self.MainChessList = {}
  self.SupportChessList = {}
  self.WaitingChessList = {}
  self.OtherChessList = {}
  self.bFirstRefreshed = false
  self.tbGamepadUINode = {}
end

function SoldierSandtablePanel:AddGamepadUINode(tbNode)
  for _, v in ipairs(tbNode) do
    table.insert(self.tbGamepadUINode, v)
  end
end

function SoldierSandtablePanel:InitChessList()
  for i = 1, 3 do
    self.MainChessList[i] = {
      nId = 0,
      nStar = 0,
      nUid = 0,
      nPositionType = GameEnum.SoldierPositionType.FightPosition,
      nIndex = i
    }
  end
  for i = 1, 6 do
    self.SupportChessList[i] = {
      nId = 0,
      nStar = 0,
      nUid = 0,
      nPositionType = GameEnum.SoldierPositionType.SupportPosition,
      nIndex = i
    }
  end
  for i = 1, 9 do
    self.WaitingChessList[i] = {
      nId = 0,
      nStar = 0,
      nUid = 0,
      nPositionType = 3,
      nIndex = i
    }
  end
end

function SoldierSandtablePanel:OnEnable()
  GamepadUIManager.EnterAdventure(true)
  GamepadUIManager.EnableGamepadUI("SoldierSandtable", self.tbGamepadUINode, nil, true)
end

function SoldierSandtablePanel:OnDisable()
  GamepadUIManager.DisableGamepadUI("SoldierSandtable")
  GamepadUIManager.QuitAdventure()
  self.tbGamepadUINode = {}
end

function SoldierSandtablePanel:OnDestroy()
end

return SoldierSandtablePanel
