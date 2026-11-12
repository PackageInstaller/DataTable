local JointDrillTeamItemCtrl = class("JointDrillTeamItemCtrl", BaseCtrl)
local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
JointDrillTeamItemCtrl._mapNodeConfig = {
  goCharItem = {nCount = 3},
  imgItemIcon = {nCount = 3, sComponentName = "Image"},
  imgItemRare = {nCount = 3, sComponentName = "Image"},
  txtRank = {nCount = 3, sComponentName = "TMP_Text"},
  imgScoreIcon = {sComponentName = "Image"},
  txtBuildTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Rank_Build_Score"
  },
  txtTeam = {sComponentName = "TMP_Text"},
  txtLeaderCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtSubCn = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Sub"
  },
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  }
}
JointDrillTeamItemCtrl._mapEventConfig = {}
JointDrillTeamItemCtrl._mapRedDotConfig = {}

function JointDrillTeamItemCtrl:GetBuildRank(nScore)
  local curIdx = -1
  
  local function forEachReward(mapData)
    if nScore >= mapData.MinGrade and curIdx < mapData.Id then
      curIdx = mapData.Id
    end
  end
  
  ForEachTableLine(DataTable.StarTowerBuildRank, forEachReward)
  if curIdx < 0 then
    curIdx = 1
  end
  return curIdx
end

function JointDrillTeamItemCtrl:RefreshItem(mapTeam, nIndex)
  self.mapTeam = mapTeam
  local sIndex = ConfigTable.GetUIText("JointDrill_Battle_Time_" .. nIndex)
  NovaAPI.SetTMPText(self._mapNode.txtTeam, orderedFormat(ConfigTable.GetUIText("JointDrill_Rank_Build_Count"), sIndex))
  for i = 1, 3 do
    local nCharId = mapTeam.Chars[i].Id
    local mapChar = ConfigTable.GetData_Character(nCharId)
    if mapChar ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txtRank[i], mapTeam.Chars[i].Level)
      local nCharSkinId = mapChar.DefaultSkinId
      local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
      self:SetPngSprite(self._mapNode.imgItemIcon[i], mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.XXL)
      local nRarity = mapChar.Grade
      local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[nRarity]
      self:SetAtlasSprite(self._mapNode.imgItemRare[i], "12_rare", sFrame, true)
    end
  end
  local nScore = self:GetBuildRank(mapTeam.BuildScore)
  self:SetPngSprite(self._mapNode.imgScoreIcon, "Icon/BuildRank/BuildRank_" .. nScore)
end

function JointDrillTeamItemCtrl:OnBtnClick_Detail()
  if self.mapTeam.Discs == nil or #self.mapTeam.Discs == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Rank_Build_Detail_Unavailable"))
    return
  end
  EventManager.Hit("OpenRankBuildDetail")
  EventManager.Hit(EventId.OpenPanel, PanelId.RankBuildDetail, self.mapTeam)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    EventManager.Hit(EventId.ClosePanel, JointDrillContext.GetPanelId(PlayerData.JointDrill_2.nActId, "RankDetail"))
  end
  
  cs_coroutine.start(wait)
end

function JointDrillTeamItemCtrl:Awake()
end

function JointDrillTeamItemCtrl:OnEnable()
end

function JointDrillTeamItemCtrl:OnDisable()
end

function JointDrillTeamItemCtrl:OnDestroy()
end

return JointDrillTeamItemCtrl
