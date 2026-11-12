local HeartStoneListCtrl = class("HeartStoneListCtrl", BaseCtrl)
local HeartStoneTypeEnum = {
  [1] = {
    HeartStoneIndex = 1,
    icon = "zs_heartstone_lv_a",
    selecticon = "zs_heartstone_1"
  },
  [2] = {
    HeartStoneIndex = 2,
    icon = "zs_heartstone_lv_b",
    selecticon = "zs_heartstone_2"
  },
  [3] = {
    HeartStoneIndex = 3,
    icon = "zs_heartstone_lv_c",
    selecticon = "zs_heartstone_3"
  },
  [4] = {
    HeartStoneIndex = 4,
    icon = "zs_heartstone_lv_d",
    selecticon = "zs_heartstone_4"
  },
  [5] = {
    HeartStoneIndex = 5,
    icon = "zs_heartstone_lv_e",
    selecticon = "zs_heartstone_5"
  },
  [6] = {
    HeartStoneIndex = 6,
    icon = "zs_heartstone_lv_f",
    selecticon = "zs_heartstone_6"
  },
  [7] = {
    HeartStoneIndex = 7,
    icon = "zs_heartstone_lv_g",
    selecticon = "zs_heartstone_7"
  },
  [8] = {
    HeartStoneIndex = 8,
    icon = "zs_heartstone_lv_h",
    selecticon = "zs_heartstone_8"
  },
  [9] = {
    HeartStoneIndex = 9,
    icon = "zs_heartstone_lv_i",
    selecticon = "zs_heartstone_9"
  },
  [10] = {
    HeartStoneIndex = 10,
    icon = "zs_heartstone_lv_j",
    selecticon = "zs_heartstone_10"
  },
  [11] = {
    HeartStoneIndex = 11,
    icon = "zs_heartstone_lv_k",
    selecticon = "zs_heartstone_11"
  },
  [12] = {
    HeartStoneIndex = 12,
    icon = "zs_heartstone_lv_l",
    selecticon = "zs_heartstone_12"
  },
  [13] = {
    HeartStoneIndex = 13,
    icon = "zs_heartstone_lv_m",
    selecticon = "zs_heartstone_13"
  },
  [14] = {
    HeartStoneIndex = 14,
    icon = "zs_heartstone_lv_n",
    selecticon = "zs_heartstone_14"
  },
  [15] = {
    HeartStoneIndex = 15,
    icon = "zs_heartstone_lv_o",
    selecticon = "zs_heartstone_15"
  },
  [16] = {
    HeartStoneIndex = 16,
    icon = "zs_heartstone_lv_p",
    selecticon = "zs_heartstone_16"
  }
}
HeartStoneListCtrl._mapNodeConfig = {
  rtHeartStoneGrid = {nCount = 6, sComponentName = "Transform"}
}
HeartStoneListCtrl._mapEventConfig = {}

function HeartStoneListCtrl:Awake()
end

function HeartStoneListCtrl:FadeIn()
end

function HeartStoneListCtrl:FadeOut()
end

function HeartStoneListCtrl:OnEnable()
end

function HeartStoneListCtrl:OnDisable()
end

function HeartStoneListCtrl:OnDestroy()
end

function HeartStoneListCtrl:OnRelease()
end

function HeartStoneListCtrl:Refresh(nCharId)
  self.nCharId = nCharId
  local HeartStoneType = ConfigTable.GetData_Character(self.nCharId).HeartStone
  self.mapHeartStoneType = HeartStoneTypeEnum[HeartStoneType]
  local rootPath = "Icon/ZZZOther/"
  local sybolType = 3
  for i = 1, 6 do
    local SymbolPath = rootPath .. self.mapHeartStoneType.icon .. tostring(i) .. tostring(sybolType)
    self:SetGrid(self._mapNode.rtHeartStoneGrid[i], self.nCharId * 100 + i, SymbolPath)
  end
end

function HeartStoneListCtrl:SetGrid(rtGrid, nHeartStoneId, sPath)
  local mapHeartStone = ConfigTable.GetData("CharacterHeartStone", nHeartStoneId)
  if mapHeartStone == nil then
    rtGrid.gameObject:SetActive(false)
    return
  end
  rtGrid.gameObject:SetActive(true)
  local imgIcon = rtGrid:Find("imgTitleBg/imgHeartStoneIcon"):GetComponent("Image")
  local TMPTitle = rtGrid:Find("imgTitleBg/TMPTitle"):GetComponent("TMP_Text")
  local TMPDesc = rtGrid:Find("srHeartStoneDesc/TMPDesc"):GetComponent("TMP_Text")
  self:SetPngSprite(imgIcon, sPath)
  NovaAPI.SetTMPText(TMPTitle, orderedFormat(ConfigTable.GetUIText("HeartStone_Level"), mapHeartStone.Level))
  NovaAPI.SetTMPText(TMPDesc, mapHeartStone.Desc)
end

return HeartStoneListCtrl
