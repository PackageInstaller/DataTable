local base = UIBaseWindow
local UIActCommonMonsterCard = class("UIActCommonMonsterCard", base)
local UINCommonActivityBG = require("Game.ActivityFrame.UI.UINCommonActivityBG")
local UINActCommonMonsterCardLeftNode = require("Game.ActivityFrame.ActivityMonsterCard.UI.UINActCommonMonsterCardLeftNode")
local UINActCommonMonsterCardRightNode = require("Game.ActivityFrame.ActivityMonsterCard.UI.UINActCommonMonsterCardRightNode")
local UINActCommonMonsterCardCardInfoNode = require("Game.ActivityFrame.ActivityMonsterCard.UI.UINActCommonMonsterCardCardInfoNode")
local cs_ResLoader = CS.ResLoader
local cs_DoTween = CS.DG.Tweening.DOTween
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType

function UIActCommonMonsterCard:OnInit()
  UIUtil.SetTopStatus(self, self.Delete)
  self._actBgNode = UINCommonActivityBG.New()
  self._actBgNode:Init(self.ui.UI_CommonActivityBG)
  self._LeftNode = UINActCommonMonsterCardLeftNode.New()
  self._LeftNode:Init(self.ui.obj_Left)
  self._RightNode = UINActCommonMonsterCardRightNode.New()
  self._RightNode:Init(self.ui.obj_Right)
  self._infoNode = UINActCommonMonsterCardCardInfoNode.New()
  self._infoNode:Init(self.ui.obj_InfoNode)
  self.resloader = cs_ResLoader.Create()
end

function UIActCommonMonsterCard:InitActCommonMonsterCardUI(monsterCardPlayData, closeCallback)
  self.monsterCardPlayData = monsterCardPlayData
  self.closeCallback = closeCallback
  self.__oldInstalledList = table.deepCopy(self.monsterCardPlayData:ActMCPD_GetSelectedCardList())
  self._LeftNode:InitACMCLeftNode(monsterCardPlayData)
  self._RightNode:InitACMCRightNode(monsterCardPlayData, self)
  self._infoNode:Hide()
  self:__PlayEnterDoTween()
  self.monsterCardPlayData:ActMCPD_CleanBlueDotWhenEnterUI()
  self._actBgNode:InitActivityBG(self.monsterCardPlayData:ActMCPD_GetActFrameId(), self.resloader)
end

function UIActCommonMonsterCard:ACM_ShowCardInfo(cardData, transform)
  self._infoNode:FloatTo(transform, HAType.autoTightLeft, VAType.autoAlignUp)
  self._infoNode:InitACMCCInfoNode(cardData, self.monsterCardPlayData, self)
  self._infoNode:Show()
end

function UIActCommonMonsterCard:ACM_RefreshInstalledCards()
  self._LeftNode:ACML_RefreshNode()
  self._RightNode:ACMR_RefreshActiveList()
  self._RightNode:ACMR_RefreshSelectedList(true)
end

function UIActCommonMonsterCard:ACM_TrySendInstalledCardInfo()
  local curInstalledList = self.monsterCardPlayData:ActMCPD_GetSelectedCardList()
  local isNeedUpdate = false
  if #curInstalledList ~= #self.__oldInstalledList then
    isNeedUpdate = true
  end
  if not isNeedUpdate then
    for index, monCardId in ipairs(curInstalledList) do
      if monCardId ~= self.__oldInstalledList[index] then
        isNeedUpdate = true
        break
      end
    end
  end
  if isNeedUpdate then
    local activityFrameNetwork = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
    local actFrameId = self.monsterCardPlayData:ActMCPD_GetActFrameId()
    activityFrameNetwork:CS_Activity_MonsterCard_Save(actFrameId, curInstalledList, function()
      self.__oldInstalledList = table.deepCopy(self.monsterCardPlayData:ActMCPD_GetSelectedCardList())
    end)
  end
end

function UIActCommonMonsterCard:__PlayEnterDoTween()
  local trans_left = self.ui.obj_Left.transform
  local trans_right = self.ui.obj_Right.transform
  local w_left = trans_left.rect.width
  local w_right = trans_right.rect.width
  local sequence = cs_DoTween.Sequence():Append(trans_left:DOLocalMoveX(-w_left, 0.3):From(true)):Join(self.ui.cg_left:DOFade(0, 0.2):From()):Join(trans_right:DOLocalMoveX(w_left, 0.3):From(true)):Join(self.ui.cg_right:DOFade(0, 0.2):From()):SetLink(self.gameObject)
end

function UIActCommonMonsterCard:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self:ACM_TrySendInstalledCardInfo()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  base.OnDelete(self)
end

return UIActCommonMonsterCard
