local UINBattleResultWeekly = class("UINBattleResultWeekly", UIBaseNode)
local base = UIBaseNode
local UINMonsterLevel = require("Game.Exploration.UI.MonsterLevel.UINMonsterLevel")

function UINBattleResultWeekly:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.monsterLevelNode = UINMonsterLevel.New()
  self.monsterLevelNode:Init(self.ui.monsterLevel)
  self.ui.btn_CCInterstInfo.onPress:AddListener(BindCallback(self, self.__OnCCInterestPress))
  self.ui.btn_CCInterstInfo.onPressUp:AddListener(BindCallback(self, self.__OnCCInterestOnPressUp))
end

function UINBattleResultWeekly:InitBattleResultWeekly(roomMoneyNum)
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local allAddCC = dynPlayer:GetEpMoneyLastAddNum()
  self.ui.obj_DetailList[1]:SetActive(0 < roomMoneyNum)
  self.ui.tex_DetailList[1].text = tostring(roomMoneyNum)
  if dynPlayer:IsInterestDepress() then
    self.ui.obj_DetailList[2]:SetActive(false)
  else
    local interestAdd = allAddCC - roomMoneyNum
    if interestAdd <= 0 then
      interestAdd = math.floor(dynPlayer:GetMoneyCount() * ConfigData.game_config.intrerestConstNum[1] / 1000)
      if interestAdd > ConfigData.game_config.intrerestConstNum[2] then
        interestAdd = ConfigData.game_config.intrerestConstNum[2]
      end
    end
    self.ui.obj_DetailList[2]:SetActive(0 < interestAdd)
    self.ui.tex_DetailList[2].text = tostring(interestAdd)
  end
  local lastStoreAddExp = ExplorationManager.epCtrl.residentStoreCtrl:GetResidentStoreLastAddExp()
  self.ui.obj_DetailList[3]:SetActive(0 < lastStoreAddExp)
  self.ui.tex_DetailList[3].text = tostring(lastStoreAddExp)
  local lastMonsterExpAdd = dynPlayer:GetEpMonsterLevelLastExpAdd()
  self.ui.obj_DetailList[4]:SetActive(0 < lastMonsterExpAdd)
  self.ui.tex_DetailList[4].text = tostring(lastMonsterExpAdd)
end

function UINBattleResultWeekly:__OnCCInterestPress()
  local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(nil, ConfigData:GetTipContent(TipContent.WCCCInterst))
  win:FloatTo(self.ui.obj_DetailList[2].transform, FloatAlignEnum.HAType.center, FloatAlignEnum.VAType.up, nil, nil, UIManager:GetMainCamera())
end

function UINBattleResultWeekly:__OnCCInterestOnPressUp()
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

function UINBattleResultWeekly:OnDelete()
  base.OnDelete(self)
end

return UINBattleResultWeekly
