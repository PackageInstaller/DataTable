local InfinityTowerRewardList = class("InfinityTowerRewardList", BaseCtrl)
local texNameColor = {
  Color(0.6980392156862745, 0.6588235294117647, 0.7647058823529411, 1),
  Color(0.4196078431372549, 0.2901960784313726, 0.6627450980392157, 1),
  Color(0.4196078431372549, 0.2901960784313726, 0.6627450980392157, 0.6980392156862745)
}
InfinityTowerRewardList._mapNodeConfig = {
  obj_rewardPoint_1 = {},
  obj_rewardPoint_2 = {},
  obj_RewardDone_1 = {},
  obj_RewardDone_2 = {},
  obj_RewardDone_3 = {},
  tex_RewardLayerCount = {sComponentName = "TMP_Text"},
  tex_RewardLayer = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Layer"
  },
  rewardItemRoot = {sComponentName = "Transform"},
  objRewardItem = {}
}
InfinityTowerRewardList._mapEventConfig = {}

function InfinityTowerRewardList:Awake()
  self.rewardItem = {}
end

function InfinityTowerRewardList:UnbindAllGrids()
  for go, ctrl in ipairs(self.rewardItem) do
    self:UnbindCtrlByNode(ctrl)
  end
  self.rewardItem = {}
end

function InfinityTowerRewardList:OnDestroy()
end

function InfinityTowerRewardList:InitRewardList(towerId, floor, passLv, rewardLv)
  local isGet = floor <= rewardLv
  local isCan = floor <= passLv and rewardLv < floor
  local isDont = passLv < floor
  local cg = self.gameObject:GetComponent("CanvasGroup")
  if isGet then
    NovaAPI.SetCanvasGroupAlpha(cg, 0.6)
  else
    NovaAPI.SetCanvasGroupAlpha(cg, 1)
  end
  self._mapNode.obj_RewardDone_1:SetActive(isGet)
  self._mapNode.obj_RewardDone_2:SetActive(isCan)
  self._mapNode.obj_RewardDone_3:SetActive(isDont)
  if isGet then
    NovaAPI.SetTMPColor(self._mapNode.tex_RewardLayerCount, texNameColor[1])
    NovaAPI.SetTMPColor(self._mapNode.tex_RewardLayer, texNameColor[1])
  elseif isCan then
    NovaAPI.SetTMPColor(self._mapNode.tex_RewardLayerCount, texNameColor[2])
    NovaAPI.SetTMPColor(self._mapNode.tex_RewardLayer, texNameColor[2])
  else
    NovaAPI.SetTMPColor(self._mapNode.tex_RewardLayerCount, texNameColor[3])
    NovaAPI.SetTMPColor(self._mapNode.tex_RewardLayer, texNameColor[3])
  end
  local tmpLv = "0"
  if floor < 10 then
    tmpLv = "00" .. floor
  elseif 10 <= floor and floor < 100 then
    tmpLv = "0" .. floor
  else
    tmpLv = tostring(floor)
  end
  NovaAPI.SetTMPText(self._mapNode.tex_RewardLayerCount, tmpLv)
  local lvData = PlayerData.InfinityTower:GetTowerLayerData(towerId, floor)
  local tbItem = {}
  local _base = decodeJson(lvData.BaseAwardPreview)
  for k, v in ipairs(_base) do
    table.insert(tbItem, {
      id = v[1],
      count = UTILS.ParseRewardItemCount(v)
    })
  end
  self:SetRewardItem(tbItem, isGet)
  self._mapNode.obj_rewardPoint_1:SetActive(lvData.LevelFunc ~= GameEnum.fixedRoguelikeFunc0.Boss)
  self._mapNode.obj_rewardPoint_2:SetActive(lvData.LevelFunc == GameEnum.fixedRoguelikeFunc0.Boss)
end

function InfinityTowerRewardList:SetRewardItem(tabItem, isGet)
  local childCount = self._mapNode.rewardItemRoot.childCount
  for i = 1, childCount do
    self._mapNode.rewardItemRoot:GetChild(i - 1).gameObject:SetActive(false)
  end
  local index = 1
  for i, v in pairs(tabItem) do
    local objItem
    if index > self._mapNode.rewardItemRoot.childCount then
      objItem = instantiate(self._mapNode.objRewardItem, self._mapNode.rewardItemRoot)
    else
      objItem = self._mapNode.rewardItemRoot:GetChild(index - 1).gameObject
    end
    local btn = objItem:GetComponent("UIButton")
    btn.onClick:RemoveAllListeners()
    
    local function clickCb()
      self:ShowItemTips(v.id, btn.gameObject)
    end
    
    btn.onClick:AddListener(clickCb)
    objItem:SetActive(true)
    self.rewardItem[objItem] = self:BindCtrlByNode(objItem, "Game.UI.TemplateEx.TemplateItemCtrl")
    self.rewardItem[objItem]:SetItem(v.id, nil, v.count, nil, isGet, nil, nil, true)
    index = index + 1
  end
end

function InfinityTowerRewardList:ShowItemTips(nTid, rtBtn)
  UTILS.ClickItemGridWithTips(nTid, rtBtn, false, true, false)
end

function InfinityTowerRewardList:OnDisable()
  self:UnbindAllGrids()
end

return InfinityTowerRewardList
