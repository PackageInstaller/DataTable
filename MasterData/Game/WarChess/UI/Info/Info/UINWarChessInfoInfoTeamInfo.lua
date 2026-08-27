local base = require("Game.WarChess.UI.Info.Info.UINWarChessInfoInfoBase")
local UINWarChessInfoInfoTeamInfo = class("UINWarChessInfoInfoTeamInfo", base)
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")

function UINWarChessInfoInfoTeamInfo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWarChessInfoInfoTeamInfo:SetWCIITeamInfo(teamData, curAP, maxAP)
  self.ui.tex_TeamName.text = teamData:GetWCTeamName()
  self.ui.tex_Point.text = tostring(curAP) .. "/" .. tostring(maxAP)
  if WarChessSeasonManager:GetIsInWCSeasonIsInLobby() then
    self.ui.img_teamAP.gameObject:SetActive(false)
    return
  else
    self.ui.img_teamAP.gameObject:SetActive(true)
  end
  if curAP <= 0 then
    self.ui.img_teamAP.color = self.ui.color_teamAPEmpty
  else
    self.ui.img_teamAP.color = self.ui.color_teamAPDefault
  end
end

function UINWarChessInfoInfoTeamInfo:SetWCIITeamInfoIsSelected(isSelected)
  self.ui.obj_img_Target:SetActive(isSelected)
end

function UINWarChessInfoInfoTeamInfo:SetWCIITeamInfoOverraHeadIconId(iconAtlas, headIconId)
  if headIconId == nil then
    self.ui.img_TeamHeadIcon.gameObject:SetActive(false)
    return
  end
  self.ui.img_TeamHeadIcon.gameObject:SetActive(true)
  if headIconId == nil then
    error("headIconId is nil")
    return
  end
  if self.__headIconId == headIconId then
    return
  end
  self.__headIconId = headIconId
  local headIconCfg = ConfigData.warchess_icon_res[headIconId]
  if headIconCfg == nil then
    error("headIconCfg is nil:" .. tostring(headIconId))
    return
  end
  local iconName = headIconCfg.res_name
  self.ui.img_TeamHeadIcon.sprite = AtlasUtil.GetResldSprite(iconAtlas, iconName)
end

function UINWarChessInfoInfoTeamInfo:ShowWCIITeamInfoApReduceTip(changeTeam, diffAp)
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local teamIndex = changeTeam:GetWCTeamIndex()
  if diffAp ~= nil then
    self.ui.tex_Tip:SetIndex(0, tostring(diffAp))
  end
  if self._timer ~= nil then
    TimerManager:StopTimer(self._timer)
    self._timer = nil
    self.ui.obj_APReduceTip:SetActive(false)
    if wcCtrl.state == eWarChessEnum.eWarChessState.play then
      wcCtrl.curState:SetIsWaitingAPReduceAnimation(self._teamIndex, false)
    end
  end
  self.ui.obj_APReduceTip:SetActive(true)
  if wcCtrl.state == eWarChessEnum.eWarChessState.play then
    wcCtrl.curState:SetIsWaitingAPReduceAnimation(teamIndex, true)
  end
  self._teamIndex = teamIndex
  self._timer = TimerManager:StartTimer(0.8, function(obj_img_Target)
    if wcCtrl.state == eWarChessEnum.eWarChessState.play then
      wcCtrl.curState:SetIsWaitingAPReduceAnimation(teamIndex, false)
    end
    if IsNull(obj_img_Target) then
      return
    end
    obj_img_Target:SetActive(false)
  end, self.ui.obj_APReduceTip, true)
end

function UINWarChessInfoInfoTeamInfo:OnDelete()
  base.OnDelete(self)
  if self._timer ~= nil then
    TimerManager:StopTimer(self._timer)
    self._timer = nil
  end
end

return UINWarChessInfoInfoTeamInfo
