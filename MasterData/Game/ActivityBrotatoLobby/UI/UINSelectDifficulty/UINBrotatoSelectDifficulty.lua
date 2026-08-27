local UINBrotatoSelectDifficulty = class("UINBrotatoSelectDifficulty", UIBaseNode)
local base = UIBaseNode
local UINBrotatoDifficultyTipItem = require("Game.ActivityBrotatoLobby.UI.UINSelectDifficulty.UINBrotatoDifficultyTipItem")

function UINBrotatoSelectDifficulty:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.tipItemPool = UIItemPool.New(UINBrotatoDifficultyTipItem, self.ui.obj_TipItem, false)
  UIUtil.AddButtonListener(self.ui.btn_Left, self, self.OnClickBrotatoDifficultyLeft)
  UIUtil.AddButtonListener(self.ui.btn_Right, self, self.OnClickBrotatoDifficultyRight)
  UIUtil.AddButtonListener(self.ui.btn_Start, self, self.OnClickBrotatoDifficultyStart)
end

function UINBrotatoSelectDifficulty:InitBrotatoSelectDifficultyNode(difficultyCfg, clickStartCallback)
  self.difficultyCfg = difficultyCfg
  self.clickStartCallback = clickStartCallback
  self.currentDifficultyId = 1
  self:RefreshBrotatoSelectDifficultyUI()
end

function UINBrotatoSelectDifficulty:RefreshBrotatoSelectDifficultyUI()
  if self.difficultyCfg == nil then
    return
  end
  local currentCfg = self.difficultyCfg[self.currentDifficultyId]
  if currentCfg == nil then
    return
  end
  self.tipItemPool:HideAll()
  for _, desString in ipairs(currentCfg.des) do
    local tipItem = self.tipItemPool:GetOne()
    tipItem:InitBrotatoDifficultyTipItem(LanguageUtil.GetLocaleText(desString))
  end
  self.ui.tex_Mode.text = LanguageUtil.GetLocaleText(currentCfg.name)
  self.ui.btn_Left.gameObject:SetActive(self.currentDifficultyId ~= 1)
  self.ui.btn_Right.gameObject:SetActive(self.currentDifficultyId ~= #self.difficultyCfg)
end

function UINBrotatoSelectDifficulty:OnClickBrotatoDifficultyLeft()
  if self.difficultyCfg == nil then
    return
  end
  if self.currentDifficultyId > 1 then
    self.currentDifficultyId = self.currentDifficultyId - 1
  end
  self:RefreshBrotatoSelectDifficultyUI()
end

function UINBrotatoSelectDifficulty:OnClickBrotatoDifficultyRight()
  if self.difficultyCfg == nil then
    return
  end
  if self.currentDifficultyId < #self.difficultyCfg then
    self.currentDifficultyId = self.currentDifficultyId + 1
  end
  self:RefreshBrotatoSelectDifficultyUI()
end

function UINBrotatoSelectDifficulty:OnClickBrotatoDifficultyStart()
  local currentCfg = self.difficultyCfg[self.currentDifficultyId]
  if currentCfg == nil then
    return
  end
  if self.clickStartCallback ~= nil then
    self.clickStartCallback(currentCfg.stage_id)
  end
end

return UINBrotatoSelectDifficulty
