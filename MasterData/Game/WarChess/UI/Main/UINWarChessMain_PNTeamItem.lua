local base = UIBaseNode
local UINWarChessMain_PNTeamItem = class("UINWarChessMain_PNTeamItem", base)
local notSelected_HeroPicColor = Color.New(1, 1, 1, 0.6)
local notSelected_BgColor = Color.New(0.1254902, 0.1254902, 0.1254902, 0.8)
local notSelected_textColor = Color.New(0.8156863, 0.8156863, 0.8156863, 0.7)
local notSelected_actionBGColor = Color.New(0.3, 0.3, 0.3, 0.5)
local noAP_actionBGColor = Color.New(0.5188679, 0.005896227, 0, 0.8)
local noAP_textColor = Color.New(1, 1, 1, 1)
local selected_BgColor = Color.New(1, 1, 1, 0.8)
local selected_actionBGColor = Color.New(0.1098039, 0.4039216, 0.04705882, 0.8)
local selected_actionTextColor = Color.New(0.6352941, 1, 0.5568628)
local unSelectedSacle = Vector3.New(0.9, 0.9, 1)
local selectedSize = Vector2.New(440, 112)
local unSelectedSize = Vector2.New(396, 112)

function UINWarChessMain_PNTeamItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_bottom, self, self.__OnClick)
end

function UINWarChessMain_PNTeamItem:InitWCPlayTeamItem(teamData, wcCtrl, resloader)
  self.teamData = teamData
  self.resloader = resloader
  self.wcCtrl = wcCtrl
  self.__preHpRate = nil
  local index = self.teamData:GetWCTeamIndex()
  self.gameObject.name = tostring(index)
  self.teamAP = teamData:GetTeamActionPoint()
  self:RefreshTeamLeaderPic()
  self:RefreshTeamPower(self.teamData)
  self:RefreshTeamAP(self.teamData)
  self:RefreshTeamHp(self.teamData)
end

function UINWarChessMain_PNTeamItem:SetWCPNTeamItemOnClickFunc(callback)
  self.__OnClickCallback = callback
end

function UINWarChessMain_PNTeamItem:RefreshTeamLeaderPic()
  self.ui.tex_TeamName.text = self.teamData:GetWCTeamName()
  local firstHeroId = self.teamData:GetFirstHeroId()
  local dynHeroData = self.wcCtrl.teamCtrl:GetHeroDynDataById(firstHeroId)
  if dynHeroData == nil then
    error("team leader data not exist")
    return
  end
  self.resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(dynHeroData:GetResPicName()), function(texture)
    if IsNull(self.transform) or IsNull(texture) then
      return
    end
    self.ui.img_TeamHeroPic.texture = texture
  end)
end

function UINWarChessMain_PNTeamItem:RefreshTeamAP(teamData)
  if WarChessSeasonManager:GetIsInWCSeasonIsInLobby() then
    self.ui.obj_action:SetActive(false)
    return
  else
    self.ui.obj_action:SetActive(true)
  end
  self.teamAP = teamData:GetTeamActionPoint()
  self.ui.tex_ActionPoint.text = tostring(self.teamAP)
  self:RefreshTeamAPText()
end

function UINWarChessMain_PNTeamItem:RefreshTeamPower(teamData)
  local pow = teamData:GetWCTeamPower()
  self.ui.tex_Power.text = tostring(pow)
  self:RefreshTeamHp(teamData)
end

function UINWarChessMain_PNTeamItem:RefreshTeamAPText()
  if self.teamAP > 0 then
    if self.__isNotSeleted then
      self.ui.tex_actionTip.text = ConfigData:GetTipContent(8501)
      self.ui.tex_actionTip.color = notSelected_HeroPicColor
      self.ui.img_actionBg.color = notSelected_actionBGColor
      self.ui.obj_actionArrow:SetActive(false)
    else
      self.ui.tex_actionTip.text = ConfigData:GetTipContent(8502)
      self.ui.tex_actionTip.color = selected_actionTextColor
      self.ui.img_actionBg.color = selected_actionBGColor
      self.ui.obj_actionArrow:SetActive(true)
    end
  else
    self.ui.tex_actionTip.text = ConfigData:GetTipContent(8503)
    self.ui.tex_actionTip.color = Color.New(1, 1, 1, 0.8)
    self.ui.obj_actionArrow:SetActive(false)
    self.ui.img_actionBg.color = noAP_actionBGColor
  end
end

function UINWarChessMain_PNTeamItem:RefreshTeamHp(teamData)
  local hpRate = teamData:GetWCTeamHP()
  if not self.__preHpRate then
    self.ui.img_HP.fillAmount = hpRate
  else
    local distance = Mathf.Abs(self.__preHpRate - hpRate)
    if 0.01 <= distance then
      local lerpSeconds = 0.3
      local lerpSpeed = distance / lerpSeconds
      if self.__TeamHpLerpTimer then
        TimerManager:StopTimer(self.__TeamHpLerpTimer)
        self.__TeamHpLerpTimer = nil
      end
      self.__TeamHpLerpTimer = TimerManager:StartTimer(0, function()
        if Mathf.Abs(self.ui.img_HP.fillAmount - hpRate) < 0.05 then
          self.ui.img_HP.fillAmount = hpRate
          TimerManager:StopTimer(self.__TeamHpLerpTimer)
          self.__TeamHpLerpTimer = nil
          return
        end
        self.ui.img_HP.fillAmount = Mathf.Lerp(self.ui.img_HP.fillAmount, hpRate, lerpSpeed * Time.unscaledDeltaTime)
      end, self, false, true, true)
    end
  end
  self.__preHpRate = hpRate
end

function UINWarChessMain_PNTeamItem:ChangeWCPNTeamApperance(isNotSeleted)
  if self.__isNotSeleted == isNotSeleted then
    return false
  end
  self.__isNotSeleted = isNotSeleted
  if isNotSeleted then
    self.ui.img_bottom.color = notSelected_BgColor
    self.ui.img_TeamHeroPic.color = notSelected_HeroPicColor
    self.ui.tex_TeamName.color = notSelected_textColor
    self.ui.tex_Power.color = notSelected_textColor
    self.ui.img_APIcon.color = notSelected_textColor
    self:RefreshTeamAPText()
    self.transform.sizeDelta = unSelectedSize
    self.ui.teamScale.localScale = unSelectedSacle
  else
    self.ui.img_bottom.color = selected_BgColor
    self.ui.img_TeamHeroPic.color = Color.white
    self.ui.tex_TeamName.color = Color.black
    self.ui.tex_Power.color = Color.black
    self.ui.img_APIcon.color = Color.black
    self:RefreshTeamAPText()
    self.transform.sizeDelta = selectedSize
    self.ui.teamScale.localScale = Vector3.one
  end
  return true
end

function UINWarChessMain_PNTeamItem:__OnClick()
  if self.__OnClickCallback ~= nil then
    self.__OnClickCallback(self)
  end
end

function UINWarChessMain_PNTeamItem:OnDelete()
  if self.__TeamHpLerpTimer then
    TimerManager:StopTimer(self.__TeamHpLerpTimer)
    self.__TeamHpLerpTimer = nil
  end
end

return UINWarChessMain_PNTeamItem
