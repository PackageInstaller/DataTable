local FixedRoguelikeRewardGachaCtrl = class("FixedRoguelikeRewardGachaCtrl", BaseCtrl)
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
FixedRoguelikeRewardGachaCtrl._mapNodeConfig = {
  uieffectBg = {sComponentName = "GameObject"},
  goGacha = {sComponentName = "GameObject"},
  btnClose = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  rtContent = {
    sComponentName = "RectTransform"
  },
  ItemRoot = {
    sComponentName = "RectTransform"
  }
}
FixedRoguelikeRewardGachaCtrl._mapEventConfig = {}
local HULF_PAGE = 6
local FULL_PAGE = 12
local FALLIN_TIME = 0.03
local LINE_SPACE_TIME = 0.1
local OPEN_R_TIME = 0.2
local OPEN_SSR_TIME = 1
local FALLIN_ALL_TIME = 0.5
local RewardGachaIconType = {
  A = "a",
  B = "b",
  C = "c",
  D = "d"
}

function FixedRoguelikeRewardGachaCtrl:ProcessResult(mapResult)
  local tbRarityItem = self:ReallocateRarity(mapResult.tbItem)
  local tbRarityPresents = self:ReallocateRarity(mapResult.tbPresents)
  local tbRarityOutfit = self:ReallocateRarity(mapResult.tbOutfit)
  local tbRarityGacha = mapResult.tbRarityCount
  local tbAllRarity = {}
  for nRarity, _ in pairs(tbRarityGacha) do
    table.insert(tbAllRarity, nRarity)
  end
  table.sort(tbAllRarity, function(a, b)
    return a < b
  end)
  local nAllRarity = #tbAllRarity
  for j = 1, nAllRarity - 1 do
    local nRarity = tbAllRarity[j]
    local nItem = 0
    for _, mapItem in pairs(tbRarityItem[nRarity]) do
      nItem = nItem + mapItem.nCount
    end
    local nPresents = #tbRarityPresents[nRarity]
    local nOutfit = #tbRarityOutfit[nRarity]
    local nNeed = tbRarityGacha[nRarity] - nItem - nPresents - nOutfit
    nNeed = 0 < nNeed and nNeed or 0
    if tbRarityItem[nRarity + 1] and #tbRarityItem[nRarity + 1] > 0 and 0 < nNeed then
      local nCount = #tbRarityItem[nRarity + 1]
      for i = nCount, 1, -1 do
        if nNeed <= 0 then
          break
        end
        local mapItem = tbRarityItem[nRarity + 1][i]
        if nNeed < mapItem.nCount then
          table.insert(tbRarityItem[nRarity], {
            nTid = mapItem.nTid,
            nCount = nNeed
          })
          mapItem.nCount = mapItem.nCount - nNeed
          nNeed = 0
        else
          table.insert(tbRarityItem[nRarity], mapItem)
          table.remove(tbRarityItem[nRarity + 1], i)
          nNeed = nNeed - mapItem.nCount
        end
      end
    end
    if tbRarityPresents[nRarity + 1] and #tbRarityPresents[nRarity + 1] > 0 and 0 < nNeed then
      local nCount = #tbRarityPresents[nRarity + 1]
      for i = nCount, 1, -1 do
        if nNeed <= 0 then
          break
        end
        local mapItem = tbRarityPresents[nRarity + 1][i]
        table.insert(tbRarityPresents[nRarity], mapItem)
        table.remove(tbRarityPresents[nRarity + 1], i)
        nNeed = nNeed - 1
      end
    end
    if tbRarityOutfit[nRarity + 1] and #tbRarityOutfit[nRarity + 1] > 0 and 0 < nNeed then
      local nCount = #tbRarityOutfit[nRarity + 1]
      for i = nCount, 1, -1 do
        if nNeed <= 0 then
          break
        end
        local mapItem = tbRarityOutfit[nRarity + 1][i]
        table.insert(tbRarityOutfit[nRarity], mapItem)
        table.remove(tbRarityOutfit[nRarity + 1], i)
        nNeed = nNeed - 1
      end
    end
  end
  local tbRarityReward = {}
  local tbPresentsToNext = {}
  local tbOutfitToNext = {}
  local tbItemToNext = {}
  for i = 5, 1, -1 do
    local nRarity = i
    if not tbRarityGacha[nRarity] then
      local function add_next(tbItem, tbNext)
        if not tbItem then
          return
        end
        for _, mapItem in pairs(tbItem) do
          table.insert(tbNext, mapItem)
        end
      end
      
      add_next(tbRarityPresents[nRarity], tbPresentsToNext)
      add_next(tbRarityOutfit[nRarity], tbOutfitToNext)
      add_next(tbRarityItem[nRarity], tbItemToNext)
    else
      tbRarityReward[nRarity] = {}
      do
        local nItem = #tbRarityItem[nRarity]
        local nPresents = #tbRarityPresents[nRarity]
        local nOutfit = #tbRarityOutfit[nRarity]
        local nHas = nItem + nPresents + nOutfit + #tbPresentsToNext + #tbOutfitToNext + #tbItemToNext
        local bFull = nHas >= tbRarityGacha[nRarity]
        
        local function add_previous(tbNext)
          for _, mapItem in pairs(tbNext) do
            table.insert(tbRarityReward[nRarity], mapItem)
            tbRarityGacha[nRarity] = tbRarityGacha[nRarity] - 1
          end
        end
        
        add_previous(tbPresentsToNext)
        tbPresentsToNext = {}
        add_previous(tbOutfitToNext)
        tbOutfitToNext = {}
        if bFull then
          add_previous(tbItemToNext)
        else
          for _, mapItem in pairs(tbItemToNext) do
            table.insert(tbRarityItem[nRarity], mapItem)
          end
        end
        tbItemToNext = {}
        local bClear = false
        
        local function add_cur(tbItem, tbNext)
          for _, mapItem in pairs(tbItem) do
            if 0 < tbRarityGacha[nRarity] then
              table.insert(tbRarityReward[nRarity], mapItem)
              tbRarityGacha[nRarity] = tbRarityGacha[nRarity] - 1
            else
              bClear = true
            end
            if bClear then
              table.insert(tbNext, mapItem)
            end
          end
        end
        
        add_cur(tbRarityPresents[nRarity], tbPresentsToNext)
        add_cur(tbRarityOutfit[nRarity], tbOutfitToNext)
        if bFull then
          add_cur(tbRarityItem[nRarity], tbItemToNext)
        else
          do
            local tbAfter = self:ReallocateGacha(tbRarityItem[nRarity], tbRarityGacha[nRarity])
            for _, mapItem in pairs(tbAfter) do
              table.insert(tbRarityReward[nRarity], mapItem)
            end
          end
        end
      end
    end
  end
  local tbReward = {}
  for _, nRarity in pairs(tbAllRarity) do
    local tbRandom = self:RandomTable(tbRarityReward[nRarity])
    for _, mapItem in ipairs(tbRandom) do
      table.insert(tbReward, {
        nTid = mapItem.nTid,
        nCount = mapItem.nCount,
        nRarity = nRarity
      })
    end
  end
  return tbReward
end

function FixedRoguelikeRewardGachaCtrl:ReallocateRarity(tbItem)
  local tbRarity = {}
  for i = 1, 5 do
    if not tbRarity[i] then
      tbRarity[i] = {}
    end
  end
  for _, mapItem in pairs(tbItem) do
    local mapCfg = ConfigTable.GetData_Item(mapItem.nTid)
    local nRarity = mapCfg.Rarity
    table.insert(tbRarity[nRarity], mapItem)
  end
  return tbRarity
end

function FixedRoguelikeRewardGachaCtrl:ReallocateGacha(tbItem, nAllGachaCount)
  if nAllGachaCount == nil or nAllGachaCount == 0 then
    return {}
  end
  for _, mapItem in ipairs(tbItem) do
    mapItem.nRarity = ConfigTable.GetData_Item(mapItem.nTid).Rarity
  end
  
  local function comp(a, b)
    if a.nRarity ~= b.nRarity then
      return a.nRarity < b.nRarity
    else
      return a.nTid > b.nTid
    end
  end
  
  table.sort(tbItem, comp)
  local tbAllocation = {}
  local nTypeCount = #tbItem
  local nRemainGacha = nAllGachaCount - nTypeCount
  for i = 1, nTypeCount do
    if not tbAllocation[i] then
      tbAllocation[i] = 0
    end
  end
  local bFail = false
  local nFailTimes = 0
  while 0 < nRemainGacha do
    if nFailTimes == 2 then
      nRemainGacha = 0
      printError("掉落扭蛋分配错误")
    end
    if bFail then
      nFailTimes = nFailTimes + 1
    end
    bFail = true
    for i = 1, nTypeCount do
      if tbItem[i].nCount > tbAllocation[i] + 1 and 0 < nRemainGacha then
        tbAllocation[i] = tbAllocation[i] + 1
        nRemainGacha = nRemainGacha - 1
        bFail = false
      end
    end
  end
  local tbAfter = {}
  for i = 1, nTypeCount do
    local nItemCount = tbItem[i].nCount
    local tbItemCount = {nItemCount}
    for _ = 1, tbAllocation[i] do
      table.sort(tbItemCount, function(a, b)
        return b < a
      end)
      local nMax = tbItemCount[1]
      local nAllocation = math.random(math.ceil(nMax / 4), math.floor(nMax / 2))
      tbItemCount[1] = nMax - nAllocation
      table.insert(tbItemCount, nAllocation)
    end
    for _, value in pairs(tbItemCount) do
      table.insert(tbAfter, {
        nTid = tbItem[i].nTid,
        nCount = value
      })
    end
  end
  return tbAfter
end

function FixedRoguelikeRewardGachaCtrl:RandomTable(tb)
  local tbRandom = {}
  local nCount = #tb
  while 0 < nCount do
    local nRandomIndex = math.random(1, nCount)
    local mapItem = tb[nRandomIndex]
    table.insert(tbRandom, mapItem)
    table.remove(tb, nRandomIndex)
    nCount = nCount - 1
  end
  return tbRandom
end

function FixedRoguelikeRewardGachaCtrl:ProcessListData(tbReward)
  self.tbRewardList = {}
  local nAllRewardCount = #tbReward
  local nFullListCount = math.floor(nAllRewardCount / FULL_PAGE)
  for _ = 1, nFullListCount do
    local tbSubReward = {}
    for _ = 1, FULL_PAGE do
      table.insert(tbSubReward, tbReward[1])
      table.remove(tbReward, 1)
    end
    table.insert(self.tbRewardList, tbSubReward)
  end
  table.insert(self.tbRewardList, tbReward)
end

function FixedRoguelikeRewardGachaCtrl:RefreshListItem(tbReward, bHulfPage)
  local bHasItem = true
  if self.tbGoItem == nil then
    self.tbGoItem = {}
    bHasItem = false
  end
  for key, v in ipairs(tbReward) do
    local nItemId = v.nTid
    local cfgDataItem = ConfigTable.GetData_Item(nItemId)
    local goItem
    if bHasItem then
      goItem = self.tbGoItem[key].go
    elseif bHulfPage then
      goItem = instantiate(self._mapNode.goGacha, self._mapNode.ItemRoot)
    else
      goItem = instantiate(self._mapNode.goGacha, self._mapNode.rtContent)
    end
    local tr = goItem.transform
    local imgFrame = tr:Find("goIcon/imgFrame"):GetComponent("Image")
    local imgIcon = tr:Find("goIcon/imgFrame/imgIcon"):GetComponent("Image")
    local imgFull = tr:Find("imgFull"):GetComponent("Image")
    local imgSplitB = tr:Find("goSplit/imgSplitB"):GetComponent("Image")
    local imgSplitC = tr:Find("goSplit/imgSplitB/imgSplitC"):GetComponent("Image")
    local imgSplitD = tr:Find("goSplit/imgSplitD"):GetComponent("Image")
    local txtCount = tr:Find("goIcon/imgFrame/ItemCount"):GetComponent("TMP_Text")
    self:SetAtlasSprite(imgFrame, "12_rare", AllEnum.FrameType_New.Item .. AllEnum.FrameColor_New[cfgDataItem.Rarity], true)
    if cfgDataItem.Type == GameEnum.itemType.Outfit or cfgDataItem.Type == GameEnum.itemType.Disc then
      self:SetPngSprite(imgIcon, cfgDataItem.Icon .. AllEnum.OutfitIconSurfix.Item)
    else
      self:SetPngSprite(imgIcon, cfgDataItem.Icon)
    end
    self:SetPngSprite(imgFull, "UI/big_sprites/" .. string.format(AllEnum.RewardGachaType[v.nRarity], RewardGachaIconType.A))
    self:SetPngSprite(imgSplitB, "UI/big_sprites/" .. string.format(AllEnum.RewardGachaType[v.nRarity], RewardGachaIconType.B))
    self:SetPngSprite(imgSplitC, "UI/big_sprites/" .. string.format(AllEnum.RewardGachaType[v.nRarity], RewardGachaIconType.C))
    self:SetPngSprite(imgSplitD, "UI/big_sprites/" .. string.format(AllEnum.RewardGachaType[v.nRarity], RewardGachaIconType.D))
    NovaAPI.SetTMPText(txtCount, v.nCount > 1 and "×" .. v.nCount or "")
    if not bHasItem then
      table.insert(self.tbGoItem, {
        go = goItem,
        bSSR = cfgDataItem.Rarity == GameEnum.itemRarity.SSR
      })
    else
      self.tbGoItem[key].bSSR = cfgDataItem.Rarity == GameEnum.itemRarity.SSR
    end
    NovaAPI.SetCanvasGroupAlpha(tr:GetComponent("CanvasGroup"), 0)
    goItem:SetActive(true)
  end
end

function FixedRoguelikeRewardGachaCtrl:PlayListAni(nPageCount, bLast, bOnePage, callback)
  local nLine = math.ceil(nPageCount / HULF_PAGE)
  local nLastLine = math.fmod(nPageCount, HULF_PAGE)
  if nLastLine == 0 then
    nLastLine = HULF_PAGE
  end
  self.sequence = DOTween.Sequence()
  if nLine == 1 then
    local nTime = 0
    if bOnePage then
      nTime = FALLIN_ALL_TIME / nLastLine
    else
      nTime = FALLIN_TIME
    end
    for i = 1, nLastLine do
      self.sequence:AppendCallback(function()
        NovaAPI.SetCanvasGroupAlpha(self.tbGoItem[i].go.transform:GetComponent("CanvasGroup"), 1)
        self.tbGoItem[i].go:GetComponent("Animator"):Play("gacha_fall_in")
        if i == 1 then
          if nLastLine == 1 then
            WwiseAudioMgr:PlaySound("ui_roguelike_gacha_fall_1")
          elseif nLastLine == 2 then
            WwiseAudioMgr:PlaySound("ui_roguelike_gacha_fall_2")
          elseif 2 < nLastLine and nLastLine <= 6 then
            WwiseAudioMgr:PlaySound("ui_roguelike_gacha_fall_3")
          end
        end
      end)
      self.sequence:AppendInterval(nTime)
    end
  elseif nLine == 2 then
    local nTime = 0
    if bOnePage then
      nTime = FALLIN_ALL_TIME / nPageCount
    else
      nTime = FALLIN_TIME
    end
    for i = 1, HULF_PAGE do
      self.sequence:AppendCallback(function()
        NovaAPI.SetCanvasGroupAlpha(self.tbGoItem[i].go.transform:GetComponent("CanvasGroup"), 1)
        self.tbGoItem[i].go:GetComponent("Animator"):Play("gacha_fall_in")
        if i == 1 then
          WwiseAudioMgr:PlaySound("ui_roguelike_gacha_fall_4")
        end
      end)
      self.sequence:AppendInterval(nTime)
    end
    self.sequence:AppendInterval(LINE_SPACE_TIME)
    for i = HULF_PAGE + 1, HULF_PAGE + nLastLine do
      self.sequence:AppendCallback(function()
        NovaAPI.SetCanvasGroupAlpha(self.tbGoItem[i].go.transform:GetComponent("CanvasGroup"), 1)
        self.tbGoItem[i].go:GetComponent("Animator"):Play("gacha_fall_in")
      end)
      self.sequence:AppendInterval(nTime)
    end
  end
  for i = 1, nPageCount do
    self.sequence:AppendCallback(function()
      if self.tbGoItem[i].bSSR then
        WwiseAudioMgr:PlaySound("ui_roguelike_gacha_specialOpen")
      else
        WwiseAudioMgr:PlaySound("ui_roguelike_gacha_commonOpen")
      end
    end)
    self.sequence:AppendInterval(0.05)
    self.sequence:AppendCallback(function()
      if self.tbGoItem[i].bSSR then
        self.tbGoItem[i].go:GetComponent("Animator"):Play("gacha_open_ssr")
      else
        self.tbGoItem[i].go:GetComponent("Animator"):Play("gacha_open_r")
      end
    end)
    self.sequence:AppendInterval(self.tbGoItem[i].bSSR and OPEN_SSR_TIME or OPEN_R_TIME)
  end
  self.sequence:AppendInterval(bLast and 1 or 0.5)
  self.sequence:Append(self._mapNode.rtContent:DOAnchorPos(Vector2(0, 1000), 0.3))
  for i = 1, nPageCount do
    self.sequence:AppendCallback(function()
      NovaAPI.SetCanvasGroupAlpha(self.tbGoItem[i].go.transform:GetComponent("CanvasGroup"), 0)
    end)
  end
  
  function self.sequence.onComplete()
    callback()
  end
  
  self.sequence:SetUpdate(true)
end

function FixedRoguelikeRewardGachaCtrl:ShowReward(mapResult)
  local tbReward = self:ProcessResult(clone(mapResult))
  if #tbReward == 0 then
    self:OnBtnClick_Close(nil, false)
    return
  end
  local nListCount = math.ceil(#tbReward / FULL_PAGE)
  self:ProcessListData(tbReward)
  self.gameObject:SetActive(true)
  self:ShowList(nListCount)
end

function FixedRoguelikeRewardGachaCtrl:ShowList(nListCount)
  local nShowOrder = 0
  
  local function func_ShowList()
    nShowOrder = nShowOrder + 1
    if nShowOrder > nListCount then
      self:OnBtnClick_Close(nil, false)
      return
    end
    local bHulfPage = nListCount == 1 and #self.tbRewardList[1] <= HULF_PAGE
    local bOnePage = nListCount == 1
    self:RefreshListItem(self.tbRewardList[nShowOrder], bHulfPage)
    self:PlayListAni(#self.tbRewardList[nShowOrder], nShowOrder == nListCount, bOnePage, func_ShowList)
  end
  
  func_ShowList()
end

function FixedRoguelikeRewardGachaCtrl:Awake()
  self.gameObject:SetActive(false)
  self.tbGoItem = nil
  self.tbRewardList = nil
end

function FixedRoguelikeRewardGachaCtrl:OnEnable()
end

function FixedRoguelikeRewardGachaCtrl:OnDisable()
end

function FixedRoguelikeRewardGachaCtrl:OnDestroy()
end

function FixedRoguelikeRewardGachaCtrl:OnBtnClick_Close(btn, bNeedStop)
  if self.sequence then
    self.sequence:Kill()
  end
  if bNeedStop then
    WwiseAudioMgr:PlaySound("ui_roguelike_gacha_allStop")
  end
  self.gameObject:SetActive(false)
  self.tbGoItem = nil
  self.tbRewardList = nil
  delChildren(self._mapNode.rtContent)
  EventManager.Hit("CloseRewardGacha")
end

return FixedRoguelikeRewardGachaCtrl
