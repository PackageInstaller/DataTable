local PenguinCardStartCtrl = class("PenguinCardStartCtrl", BaseCtrl)
local PenguinCardUtils = require("Game.UI.Play_PenguinCard.PenguinCardUtils")
local WwiseManger = CS.WwiseAudioManager.Instance
PenguinCardStartCtrl._mapNodeConfig = {
  txtLevelDesc = {sComponentName = "TMP_Text"},
  txtSubLevelDesc = {sComponentName = "TMP_Text"},
  txtTurnDesc = {sComponentName = "TMP_Text"},
  txtStartTitle = {sComponentName = "TMP_Text"},
  txtAim = {sComponentName = "TMP_Text"},
  txtTurnLimit = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Endless_LevelBuff"
  },
  btnStart = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Start"
  },
  txtBtnStart = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Btn_Start"
  },
  imgBuff = {nCount = 4, sComponentName = "Image"},
  txtClick = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  }
}
PenguinCardStartCtrl._mapEventConfig = {}

function PenguinCardStartCtrl:Refresh()
  WwiseManger:PostEvent("Mode_Card_nextlevel")
  local nScore = math.floor(self._panel.mapLevel:GetAimScore())
  NovaAPI.SetTMPText(self._mapNode.txtAim, orderedFormat(ConfigTable.GetUIText("PenguinCard_Endless_AimScoreTitle"), self:ThousandsNumber(nScore)))
  NovaAPI.SetTMPText(self._mapNode.txtLevelDesc, self._panel.mapLevel.sLevelDesc)
  NovaAPI.SetTMPText(self._mapNode.txtSubLevelDesc, self._panel.mapLevel.sSubLevelDesc)
  NovaAPI.SetTMPText(self._mapNode.txtTurnDesc, self._panel.mapLevel.sEndlessDesc)
  NovaAPI.SetTMPText(self._mapNode.txtStartTitle, orderedFormat(ConfigTable.GetUIText("PenguinCard_Endless_LevelTittle"), self._panel.mapLevel.nEndlessLevel))
  self._mapNode.btnStart[1].gameObject:SetActive(self._panel.mapLevel.nEndlessLevel == 1)
  self._mapNode.btnStart[2].gameObject:SetActive(self._panel.mapLevel.nEndlessLevel > 1)
  self._mapNode.txtClick.gameObject:SetActive(self._panel.mapLevel.nEndlessLevel > 1)
  local tbAll = ConfigTable.GetConfigNumberArray("PenguinCardEndlessDebuffShowList")
  local nBuffId = self._panel.mapLevel.tbEndlessLevelBuffId[1]
  if nBuffId ~= nil then
    local function getRandom(arr, x, n)
      local list = {}
      
      for _, v in ipairs(arr) do
        if v ~= x then
          table.insert(list, v)
        end
      end
      for i = #list, 2, -1 do
        local j = math.random(i)
        list[i], list[j] = list[j], list[i]
      end
      local result = {}
      n = math.min(n, #list)
      for i = 1, n do
        table.insert(result, list[i])
      end
      return result
    end
    
    local tbShow = getRandom(tbAll, nBuffId, 3)
    table.insert(tbShow, 1, nBuffId)
    for i = 1, 4 do
      if tbShow[i] ~= nil then
        local mapCfg = ConfigTable.GetData("PenguinCardBuff", tbShow[i])
        self:SetSprite(self._mapNode.imgBuff[i], "UI/Play_PenguinCard/SpriteAtlas/Sprite/" .. mapCfg.Icon)
      end
    end
    local nWaitTime = 1.5
    NovaAPI.SetButtonInteractable(self._mapNode.btnStart[1], false)
    NovaAPI.SetButtonInteractable(self._mapNode.btnStart[2], false)
    self._mapNode.txtTurnDesc.alpha = 0
    self:AddTimer(1, nWaitTime, function()
      NovaAPI.SetButtonInteractable(self._mapNode.btnStart[1], true)
      NovaAPI.SetButtonInteractable(self._mapNode.btnStart[2], true)
      self._mapNode.txtTurnDesc:DOFade(1, 0.3):SetUpdate(true)
    end, true, true, true)
  else
    NovaAPI.SetButtonInteractable(self._mapNode.btnStart[1], true)
    NovaAPI.SetButtonInteractable(self._mapNode.btnStart[2], true)
  end
end

function PenguinCardStartCtrl:PlayOutAni()
  self.animator:Play("PengUinCard_Start_out", 0, 0)
end

function PenguinCardStartCtrl:Awake()
  self.animator = self.gameObject:GetComponent("Animator")
end

function PenguinCardStartCtrl:OnEnable()
end

function PenguinCardStartCtrl:OnDisable()
end

function PenguinCardStartCtrl:OnBtnClick_Start(btn)
  self._panel.mapLevel:SwitchGameState()
end

return PenguinCardStartCtrl
