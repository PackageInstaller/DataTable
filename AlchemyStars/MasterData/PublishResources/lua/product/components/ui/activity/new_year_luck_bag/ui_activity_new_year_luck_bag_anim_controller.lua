require("entity")
_class("UIActivityNewYearLuckBagAnimController", UIController)
UIActivityNewYearLuckBagAnimController = UIActivityNewYearLuckBagAnimController

function UIActivityNewYearLuckBagAnimController:OnShow(uiParams)
  self._randomLotteryComponentInfo = uiParams[1]
  self.drawList = self._randomLotteryComponentInfo.m_draw
  self.uiCtrl = uiParams[2]
  self._storyComp = uiParams[3]
  self._curLevel = self.drawList[#self.drawList].random_type
  self:GetComponents()
  self:InitComponents()
end

function UIActivityNewYearLuckBagAnimController:GetComponents()
  self._levelObjs = {}
  self._levelObjs[1] = self:GetGameObject("level1")
  self._levelObjs[2] = self:GetGameObject("level2")
  self._levelObjs[3] = self:GetGameObject("level3")
end

function UIActivityNewYearLuckBagAnimController:InitComponents()
  self._levelObjs[self._curLevel]:SetActive(true)
  self:StartTask(function(TT)
    self:Lock("UIActivityNewYearLuckBagAnimController:InitComponents")
    YIELD(TT, 2000)
    self:ShowDialog("UIActivityNewYearLuckBagController", self._randomLotteryComponentInfo, self.uiCtrl, self._storyComp)
    self:CloseDialog()
    self:UnLock("UIActivityNewYearLuckBagAnimController:InitComponents")
  end)
end
