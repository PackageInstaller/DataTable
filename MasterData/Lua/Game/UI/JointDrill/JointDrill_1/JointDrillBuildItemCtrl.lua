local JointDrillBuildItemCtrl = class("JointDrillBuildItemCtrl", BaseCtrl)
JointDrillBuildItemCtrl._mapNodeConfig = {
  goBuildItem = {},
  txtBuildTitle = {sComponentName = "TMP_Text"},
  txtBattleTime = {sComponentName = "TMP_Text"},
  txtScoreCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Build_Score_Text"
  },
  imgBuildScore = {sComponentName = "Image"},
  charItem = {nCount = 3},
  imgItemIcon = {nCount = 3, sComponentName = "Image"},
  imgItemRare = {nCount = 3, sComponentName = "Image"},
  txtRank = {nCount = 3, sComponentName = "TMP_Text"},
  txtDamage = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Build_Damage_Text"
  },
  txtDamageValue = {sComponentName = "TMP_Text"},
  txtLeaderCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtSubCn = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Sub"
  },
  imgEmpty = {}
}
JointDrillBuildItemCtrl._mapEventConfig = {}
JointDrillBuildItemCtrl._mapRedDotConfig = {}

function JointDrillBuildItemCtrl:GetBuildRank(nScore)
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

function JointDrillBuildItemCtrl:SetItem(nIndex, mapBuild, nLevelId)
  self._mapNode.goBuildItem.gameObject:SetActive(mapBuild ~= nil)
  self._mapNode.imgEmpty.gameObject:SetActive(mapBuild == nil)
  if mapBuild == nil then
    return
  end
  self.nLevelId = nLevelId
  NovaAPI.SetTMPText(self._mapNode.txtBuildTitle, orderedFormat(ConfigTable.GetUIText("JointDrill_Build_Index"), nIndex))
  
  local function setBuildData(mapData)
    local tbChar = {}
    local nScore = 0
    if mapData == nil then
      for _, v in ipairs(mapBuild.Chars) do
        table.insert(tbChar, v.CharId)
      end
      nScore = self:GetBuildRank(mapBuild.BuildScore)
    else
      for _, mapChar in ipairs(mapData.tbChar) do
        table.insert(tbChar, mapChar.nTid)
      end
      nScore = mapData.mapRank.Id
    end
    for i = 1, 3 do
      local mapCharCfg = ConfigTable.GetData_Character(tbChar[i])
      local nCharSkinId = PlayerData.Char:GetCharSkinId(tbChar[i])
      local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
      if mapCharCfg ~= nil and mapCharSkin ~= nil then
        local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapCharCfg.Grade]
        self:SetPngSprite(self._mapNode.imgItemIcon[i], mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.XXL)
        self:SetAtlasSprite(self._mapNode.imgItemRare[i], "12_rare", sFrame)
        local nLevel = PlayerData.Char:GetCharLv(tbChar[i])
        NovaAPI.SetTMPText(self._mapNode.txtRank[i], nLevel)
      end
    end
    local sScore = "Icon/BuildRank/BuildRank_" .. nScore
    self:SetPngSprite(self._mapNode.imgBuildScore, sScore)
  end
  
  PlayerData.Build:GetBuildDetailData(setBuildData, mapBuild.BuildId)
  NovaAPI.SetTMPText(self._mapNode.txtDamageValue, self:ThousandsNumber(mapBuild.Damage))
  local nMin = math.floor(mapBuild.Time / 60000)
  local nRemain = mapBuild.Time % 60000
  local nSec = math.floor(nRemain / 1000)
  local nMs = mapBuild.Time % 1000
  local sTime = string.format("%02d:%02d:%03d", nMin, nSec, nMs)
  NovaAPI.SetTMPText(self._mapNode.txtBattleTime, orderedFormat(ConfigTable.GetUIText("JointDrill_Build_Time_Text"), sTime))
end

function JointDrillBuildItemCtrl:Awake()
end

function JointDrillBuildItemCtrl:OnEnable()
end

function JointDrillBuildItemCtrl:OnDisable()
end

function JointDrillBuildItemCtrl:OnDestroy()
end

return JointDrillBuildItemCtrl
