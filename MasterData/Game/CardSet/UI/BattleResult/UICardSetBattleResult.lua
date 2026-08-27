local base = UIBaseWindow
local UICardSetBattleResult = class("UICardSetBattleResult", base)
local UINHeroHeadWithStarItem = require("Game.CommonUI.Hero.UINHeroHeadWithStarItem")
local UINCardSetBaseCardItem = require("Game.CardSet.UI.BattleResult.UINCardSetBaseCardItem")
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")
local SkinEnum = require("Game.Skin.SkinEnum")
local EpMvpData = require("Game.Exploration.Data.EpMvpData")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local UINCardSetBtFloat = require("Game.CardSet.UI.BattleResult.UINCardSetBtFloat")
local UINFairyHeadItem = require("Game.Fairy.UI.Common.UINFairyHeadItem")
local CS_ResLoader = CS.ResLoader

function UICardSetBattleResult:OnInit()
  self.ui.timerBg:SetActive(fase)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickConfirm)
  self._heroItemPool = UIItemPool.New(UINHeroHeadWithStarItem, self.ui.uINHeroHeadWithStar, false)
  self._envItemPool = UIItemPool.New(UINCardSetBaseCardItem, self.ui.envItem, false)
  self._cardItemPool = UIItemPool.New(UINCardSetBaseCardItem, self.ui.cardItem, false)
  self._resloader = CS_ResLoader.Create()
  self._clickCardFunc = BindCallback(self, self._OnCardClick)
  self.ui.obj_Details:SetActive(false)
  DestroyUnityObject(self.img_ResultBG_Material)
  self.img_ResultBG_Material = nil
  self.img_ResultBG_Material = UIUtil.GetImageMaterial(self.ui.img_ResultBG)
  local material = self.img_ResultBG_Material
  material:SetFloat("_Decoloration", 0)
  self.fairyHead = UINFairyHeadItem.New()
  self.fairyHead:Init(self.ui.fairyHeadItem)
  self.fairyHead:SetFairyHeadItemLvShow(true)
end

function UICardSetBattleResult:InitCardSetBattleResult(battleFrame, dynHeroList, dynFairyData, confirmFunc)
  self._confirmFunc = confirmFunc
  local cardSetData = BattleDungeonManager.dunInterfaceData:GetCardSetData()
  local playType = cardSetData:GetCardSetCurPlayType()
  local diffData = cardSetData:GetCardSetCurDiffData()
  local diffLv = diffData:GetCardSetDiffName()
  self.ui.tex_Lvl.text = diffLv
  self.ui.obj_NewRecord:SetActive(false)
  self.ui.obj_StandardMode:SetActive(false)
  self.ui.obj_RankMode:SetActive(false)
  local addReate, pointNum = cardSetData:GenCardSetNum()
  if playType == CardSetEnum.eSetType.normal or playType == CardSetEnum.eSetType.rewind then
    self.ui.tex_PointType:SetIndex(0)
    self.ui.obj_StandardMode:SetActive(true)
  elseif playType == CardSetEnum.eSetType.rank then
    self.ui.tex_PointType:SetIndex(1)
    pointNum = pointNum + cardSetData:GenCardSetRankScoreAdd(battleFrame)
    local hightestScore = cardSetData:GetCsRankCurRoundHighestScore()
    local curRoundData = cardSetData:GetCsRankCurRoundData()
    if curRoundData:CardSetRankScoreIsVerify(pointNum) then
      self.ui.obj_NewRecord:SetActive(true)
      self.ui.tex_NewRecord:SetIndex(1)
    else
      self.ui.obj_NewRecord:SetActive(pointNum > hightestScore)
      self.ui.tex_NewRecord:SetIndex(0)
    end
    self:_ShowPassTime(battleFrame)
    self.ui.obj_RankMode:SetActive(true)
    self.ui.tex_BestRank:SetIndex(0, tostring(hightestScore))
  end
  self.ui.tex_Addtion:SetIndex(0, tostring(addReate / 10))
  self.ui.tex_Point.text = tostring(pointNum)
  local mvpData = EpMvpData.New(dynHeroList)
  mvpData:AddBattleStatisticsData()
  local heroId, MvpType, diggestRate = mvpData:GetEpMvpData()
  local mvpHeroData
  self.ui.tex_MvpType:SetIndex(MvpType)
  self.ui.tex_Rate:SetIndex(0, GetPreciseDecimalStr(diggestRate * 100, 0))
  for k, dynHero in ipairs(dynHeroList) do
    local heroItem = self._heroItemPool:GetOne()
    heroItem:InitHead(dynHero.heroData, true)
    if dynHero.dataId == heroId then
      mvpHeroData = dynHero.heroData
    end
  end
  if dynFairyData == nil then
    self.fairyHead:Hide()
  else
    self.fairyHead:InitFairyHeadItem(dynFairyData, self._resloader)
    self.fairyHead:Show()
    self.fairyHead.transform:SetAsLastSibling()
  end
  self:_LoadMvpPic(mvpHeroData)
  local cardListDic = cardSetData:GetSelectedCardListDic()
  for cardType, cardDataList in pairs(cardListDic) do
    for k, cardData in ipairs(cardDataList) do
      local item
      if cardType == CardSetEnum.eCardType.Buff then
        item = self._cardItemPool:GetOne()
      else
        item = self._envItemPool:GetOne()
      end
      item:InitCardSetBaseCardItem(cardData, self._resloader)
      item:SetCardSetBaseCardItemClickFunc(self._clickCardFunc)
    end
  end
  local itemCfg = cardSetData:GetCurCardSetScoreItemCfg()
  self.ui.img_ScoreIcon.sprite = CRH:GetSprite(itemCfg.small_icon)
end

function UICardSetBattleResult:_LoadMvpPic(heroData)
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
  end
  self.bigImgResloader = CS_ResLoader.Create()
  local picName = heroData:GetResPicName()
  local skinId = heroData:GetCurrentUseSkinId()
  local isHaveSkin = PlayerDataCenter.skinData:IsHaveSkin(skinId)
  local isHaveL2d = PlayerDataCenter.skinData:IsHaveL2d(skinId)
  local rectifyL2d = not PlayerDataCenter.skinData:IsSkinL2dCouldShow(skinId) and not isHaveSkin
  if isHaveSkin and isHaveL2d and not rectifyL2d then
    HeroCubismInteration.DestroyInterationInstance(self.bigImgGameObject)
    local resPath = PathConsts:GetCharacterLive2DPath(picName, SkinEnum.fromWhere.mpv)
    self.bigImgResloader:LoadABAssetAsync(resPath, function(l2dModelAsset)
      self.bigImgGameObject = l2dModelAsset:Instantiate(self.ui.heroHolder.transform)
      self.bigImgGameObject.transform:SetLayer(LayerMask.UI)
      local cs_CubismInterationController = self.bigImgGameObject.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
      if cs_CubismInterationController ~= nil then
        self.heroCubismInteration = HeroCubismInteration.New()
        local heroId = heroData.dataId
        local skinId = heroData.skinId
        self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
        self.heroCubismInteration:SetInterationOpenWait(false)
        self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
        local sortingLayerName = self:GetWindowSortingLayer()
        self.heroCubismInteration:SetRenderControllerSetting(sortingLayerName, self.ui.heroHolder, -500, true)
        self.ui.background.overrideSorting = true
        self.ui.background.sortingLayerName = sortingLayerName
        self.ui.background.sortingOrder = -501
        self.heroCubismInteration:SetL2DPosType("HeroList", false)
      end
    end)
  else
    local resPath = PathConsts:GetCharacterBigImgPrefabPath(picName, SkinEnum.fromWhere.mpv)
    HeroCubismInteration.DestroyInterationInstance(self.bigImgGameObject)
    self.bigImgResloader:LoadABAssetAsync(resPath, function(prefab)
      self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder.transform)
      local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
      commonPicCtrl:SetPosType("HeroList")
    end)
  end
end

function UICardSetBattleResult:_ShowPassTime(battleFrame)
  self.ui.timerBg:SetActive(true)
  self.ui.tex_PassTime:SetIndex(0, BattleUtil.FrameToTimeString(battleFrame))
end

function UICardSetBattleResult:_OnClickConfirm()
  if self._confirmFunc then
    self._confirmFunc()
  end
end

function UICardSetBattleResult:_OnCardClick(cardItem, cardData)
  if self._floatNode == nil then
    self._floatNode = UINCardSetBtFloat.New()
    self._floatNode:Init(self.ui.obj_Details)
  end
  self._floatNode:InitCardSetBtFloat(cardItem.transform, cardData, self._resloader)
  self._floatNode:Show()
end

function UICardSetBattleResult:OnDelete()
  self._heroItemPool:DeleteAll()
  self.fairyHead:Delete()
  DestroyUnityObject(self.img_ResultBG_Material)
  self.img_ResultBG_Material = nil
  if self._resloader then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  if self.bigImgResloader then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  if self._floatNode then
    self._floatNode:Delete()
  end
  base.OnDelete(self)
end

return UICardSetBattleResult
