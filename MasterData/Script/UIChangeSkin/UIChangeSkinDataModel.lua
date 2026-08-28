local View = require("UIChangeSkin/UIChangeSkinView")
local DataModel = {}
DataModel.characterId = nil
DataModel.unitId = nil
DataModel.isBack = false
DataModel.skinTypes = {}
DataModel.defaultSkinType = nil
DataModel.curSkinType = nil
DataModel.allSkins = {}
DataModel.curSkins = {}
DataModel.allHairColorItems = {}

function DataModel.Init()
  for i, v in ipairs(PlayerData:GetFactoryData(99900014, "ConfigFactory").dressTypeOrder) do
    table.insert(DataModel.skinTypes, v.id)
  end
  DataModel.defaultSkinType = PlayerData:GetFactoryData(99900014, "ConfigFactory").defaultDressType
end

function DataModel.SetJsonData(json)
  if not json then
    return
  end
  local data = Json.decode(json)
end

function DataModel.InitData()
  DataModel.isBack = false
  DataModel.characterId = PlayerData.CaptainSkinSystem.characterId
  DataModel.unitId = PlayerData.CaptainSkinSystem.unitId
  DataModel.allSkins = {}
  local dressData = PlayerData.CaptainSkinSystem:GetAllSkinData()
  local skinCA
  for skinUid, skinData in pairs(dressData) do
    skinCA = PlayerData:GetFactoryData(skinData.id, "HomeCharacterSkinFactory")
    local canWear = false
    for _, v in pairs(skinCA.character) do
      if v.id == DataModel.unitId then
        canWear = true
        break
      end
    end
    if canWear then
      DataModel.allSkins[skinCA.skinType] = DataModel.allSkins[skinCA.skinType] or {}
      table.insert(DataModel.allSkins[skinCA.skinType], ChangeSkinUtil.GenerateSkinItem(skinData.id, skinUid))
    end
  end
  DataModel.allSkins[EnumDefine.ESkinType.Hair] = DataModel.allSkins[EnumDefine.ESkinType.Hair] or {}
  local defaultHairId = PlayerData.CaptainSkinSystem.defaultHairId
  local hairSkinItem = ChangeSkinUtil.GenerateSkinItem(defaultHairId)
  table.insert(DataModel.allSkins[EnumDefine.ESkinType.Hair], hairSkinItem)
  PlayerData.CaptainSkinSystem:InitChangeSkinCacheData()
end

function DataModel.RefreshOnShow()
  local characterCA = PlayerData:GetFactoryData(DataModel.characterId, "HomeCharacterFactory")
  ChangeSkinUtil.InitUICaptainSpineSkin(View.Group_Character.SpineAnimation_, "dorm_stand")
  View.Group_RightPanel.Img_Bg.Img_Gender:SetSprite(characterCA.bgPath)
  View.Group_RightPanel.Img_Bg.Txt_Title:SetActive(not CommonTips.IsResEN())
  View.Group_Character.Btn_Save.Txt_EN:SetActive(not CommonTips.IsResEN())
  if DataModel.defaultSkinType then
    DataModel.SetCurSkinListByType(DataModel.defaultSkinType)
  end
  DataModel.skinTypeElements = {}
  View.Group_RightPanel.Group_Top.ScrollGrid_SkinType.grid.self:SetDataCount(#DataModel.skinTypes)
  View.Group_RightPanel.Group_Top.ScrollGrid_SkinType.grid.self:RefreshAllElement()
  View.Group_Character.Group_Fashion.Txt_Num:SetText(PlayerData.GetTotalFashion())
  DataModel.HideHairColorPanel()
  View.Btn_Rank.self:SetActive(true)
end

local QualitySortIndex = {
  White = 1,
  Blue = 2,
  PurPle = 3,
  Golden = 4
}

local function GetCustomSort(skinItem)
  local isDefault = ChangeSkinUtil.IsDefaultSkin(skinItem.itemId)
  if isDefault then
    return 0
  end
  local isWear = PlayerData.CaptainSkinSystem:IsSkinCurShow(skinItem)
  if isWear then
    return -1
  end
  return -2
end

function DataModel.SetCurSkinListByType(skinType)
  DataModel.curSkins = DataModel.allSkins[skinType] or {}
  DataModel.curSkinType = skinType
  table.sort(DataModel.curSkins, function(a, b)
    local customSort1 = GetCustomSort(a)
    local customSort2 = GetCustomSort(b)
    if customSort1 == customSort2 then
      local skinCA1 = PlayerData:GetFactoryData(a.itemId, "HomeCharacterSkinFactory")
      local skinCA2 = PlayerData:GetFactoryData(b.itemId, "HomeCharacterSkinFactory")
      local quality1 = QualitySortIndex[skinCA1.quality]
      local quality2 = QualitySortIndex[skinCA2.quality]
      if quality1 == quality2 then
        return a.itemId > b.itemId
      else
        return quality1 > quality2
      end
    else
      return customSort1 > customSort2
    end
  end)
  View.Group_RightPanel.Group_Middle.ScrollGrid_Skin.grid.self:SetDataCount(#DataModel.curSkins)
  View.Group_RightPanel.Group_Middle.ScrollGrid_Skin.grid.self:RefreshAllElement()
  View.Group_RightPanel.Group_Middle.Img_NoCloth:SetActive(#DataModel.curSkins == 0)
  View.Group_Character.Btn_HairColor:SetActive(false)
end

function DataModel.TakeOnSkinPlayAnim(itemId)
  local skinCA = PlayerData:GetFactoryData(itemId, "HomeCharacterSkinFactory")
  local particle = View.Group_Character.transform:Find("UI_clothes"):GetComponent(typeof(CS.UnityEngine.ParticleSystem))
  particle:Play()
  local skinTypeCA = PlayerData:GetFactoryData(skinCA.skinType, "TagFactory")
  local animCA = PlayerData:GetFactoryData(skinTypeCA.animId, "ListFactory")
  if not animCA then
    return
  end
  local anims = DataModel.isBack and animCA.backAnimList or animCA.frontAnimList
  local index = math.random(1, table.count(anims))
  View.Group_Character.SpineAnimation_:SetActionWithoutMix(anims[index].animName, true, true)
  DataModel.sound = SoundManager:CreateSound(30002649)
  if DataModel.sound ~= nil then
    DataModel.sound:Play()
  end
end

function DataModel.ChangeSkin(skinItem, takeOn)
  return PlayerData.CaptainSkinSystem:ChangeSkin(View.Group_Character.SpineAnimation_, skinItem, takeOn)
end

function DataModel.SaveDress()
  local function SaveDressesCallBack()
    ChangeSkinUtil.InitHomeCaptainSpineSkin()
    
    local HomeTradeDataModel = require("UIHome/UIHomeTradeDataModel")
    local stationCA = PlayerData:GetFactoryData(HomeTradeDataModel.CurStayCity)
    for k, timeline in pairs(stationCA.timeLineList) do
      ChangeSkinUtil.InitTimeLineCaptainSpineSkin(timeline.id)
    end
  end
  
  PlayerData.CaptainSkinSystem:ReqSaveDress(SaveDressesCallBack)
end

function DataModel.SaveHairColor()
  local function callBack()
    ChangeSkinUtil.InitHomeCaptainSpineHairColor()
    
    if MainManager.bgSceneName == "Main" then
      local HomeTradeDataModel = require("UIHome/UIHomeTradeDataModel")
      local stationCA = PlayerData:GetFactoryData(HomeTradeDataModel.CurStayCity)
      for k, timeline in pairs(stationCA.timeLineList) do
        ChangeSkinUtil.InitTimeLineCaptainSpineHairColor(timeline.id)
      end
    end
  end
  
  PlayerData.CaptainSkinSystem:ReqSaveHairColor(callBack)
end

function DataModel.ClickRankType(_type)
  if DataModel.rankType == _type then
    return
  end
  DataModel.rankType = _type
  local rankListCount = #DataModel.rankList[_type].listData
  View.Group_Rank.Group_List.ScrollGrid_List.grid.self:SetDataCount(DataModel.tempRankData[_type].showRankNum)
  View.Group_Rank.Group_List.ScrollGrid_List.grid.self:RefreshAllElement()
  View.Group_Rank.Group_List.ScrollGrid_List.grid.self:MoveToTop()
  View.Group_Rank.Group_Empty:SetActive(rankListCount <= 0)
  View.Group_Rank.Group_Pick.Btn_Friend.Group_On.self:SetActive(_type == 1)
  View.Group_Rank.Group_Pick.Btn_All.Group_On.self:SetActive(_type == 0)
  if 0 < table.count(DataModel.rankList[_type].selfData) then
    DataModel.SetRankElement(View.Group_Rank.Group_Oneself, DataModel.rankList[_type].selfData)
  end
end

function DataModel.ShowRankPanel(value, rankType)
  if not value then
    DataModel.requestNet = {}
    DataModel.rankType = nil
    DataModel.rankList = {}
    DataModel.tempRankData = {}
    View.Group_Rank.self:SetActive(false)
    View.Group_Character.Btn_HairColor:SetActive(false)
    return
  end
  View.Group_Character.Btn_HairColor:SetActive(false)
  if View.Group_HairColor.self.IsActive then
    local index = View.Group_HairColor.self.transform:GetSiblingIndex()
    View.Group_Rank.self.transform:SetSiblingIndex(index + 1)
  end
  rankType = rankType or 1
  DataModel.rankList = DataModel.rankList or {}
  DataModel.requestNet = DataModel.requestNet or {}
  local requestNet = not DataModel.requestNet[rankType]
  
  local function callBack()
    View.Group_Rank.self:SetActive(true)
    if DataModel.rankBgList == nil then
      DataModel.rankBgList = {
        [1] = "UI/ChangeSkin/FashionRank/bg_rank1",
        [2] = "UI/ChangeSkin/FashionRank/bg_rank2",
        [3] = "UI/ChangeSkin/FashionRank/bg_rank3",
        [4] = "UI/ChangeSkin/FashionRank/bg_rank4"
      }
      DataModel.defaultRankBg = "UI/ChangeSkin/FashionRank/bg_rank4"
    end
    DataModel.ClickRankType(rankType)
  end
  
  if requestNet then
    local rankCA = PlayerData:GetFactoryData(84300057)
    DataModel.tempRankData = DataModel.tempRankData or {}
    DataModel.tempRankData[rankType] = DataModel.tempRankData[rankType] or {}
    Net:SendProto("main.roll_rank", function(json)
      DataModel.tempRankData[rankType] = {
        has_more = json.has_more,
        request_id = json.request_id,
        next_index = json.next_index,
        totalRankNum = json.total_members,
        showRankNum = 0
      }
      DataModel.requestNet[rankType] = true
      DataModel.rankList[rankType] = {
        selfData = json.my_rank["fashion:forever"] or json.my_rank,
        listData = json.rank_list
      }
      local curNum = #DataModel.rankList[rankType].listData
      DataModel.tempRankData[rankType].showRankNum = curNum
      if json.has_more then
        local remainNum = DataModel.tempRankData[rankType].totalRankNum - curNum
        local limitNum = 5 <= remainNum and 5 or remainNum
        DataModel.tempRankData[rankType].showRankNum = curNum + limitNum
      end
      callBack()
    end, rankCA.rankType, rankCA.timeType, "", rankCA.peopleNum, DataModel.tempRankData[rankType].request_id, DataModel.tempRankData[rankType].next_index, nil, rankType)
  else
    callBack()
  end
end

function DataModel.ReGetRankNetData()
  local rankType = DataModel.rankType
  local rankCA = PlayerData:GetFactoryData(84300057)
  DataModel.tempRankData = DataModel.tempRankData or {}
  DataModel.tempRankData[rankType] = DataModel.tempRankData[rankType] or {}
  Net:SendProto("main.roll_rank", function(json)
    DataModel.tempRankData[rankType] = {
      has_more = json.has_more,
      request_id = json.request_id,
      next_index = json.next_index,
      totalRankNum = DataModel.tempRankData[rankType].totalRankNum,
      showRankNum = 0
    }
    for k, v in ipairs(json.rank_list) do
      table.insert(DataModel.rankList[rankType].listData, v)
    end
    local curNum = #DataModel.rankList[rankType].listData
    if json.has_more then
      local remainNum = DataModel.tempRankData[rankType].totalRankNum - curNum
      local limitNum = 5 <= remainNum and 5 or remainNum
      DataModel.tempRankData[rankType].showRankNum = curNum + limitNum
    else
      DataModel.tempRankData[rankType].showRankNum = curNum
    end
    View.Group_Rank.Group_List.ScrollGrid_List.grid.self:SetDataCount(DataModel.tempRankData[rankType].showRankNum)
    View.Group_Rank.Group_List.ScrollGrid_List.grid.self:RefreshAllElement()
  end, rankCA.rankType, rankCA.timeType, "", rankCA.peopleNum, DataModel.tempRankData[rankType].request_id, DataModel.tempRankData[rankType].next_index, nil, rankType)
end

function DataModel.GetHeadPath(avatar, gender)
  avatar = avatar or PlayerData:GetUserInfo().avatar
  if avatar == "" then
    gender = gender or PlayerData:GetUserInfo().gender
    local head = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    if head ~= nil and head.playerHeadList ~= nil then
      return head.playerHeadList[gender + 1].playerHeadPath, nil
    end
  end
  local photoFactory = PlayerData:GetFactoryData(avatar, "ProfilePhotoFactory")
  if photoFactory ~= nil then
    return photoFactory.imagePath, photoFactory
  end
  return "", nil
end

function DataModel.SetRankElement(element, rankData)
  local isSelf = rankData.uid == nil or rankData.uid == PlayerData:GetUserInfo().uid
  local bgPath = DataModel.rankBgList[rankData.rank] or DataModel.defaultRankBg
  element.Img_BG:SetSprite(bgPath)
  if rankData.rank >= #DataModel.rankBgList then
    element.Txt_Order:SetText(rankData.rank)
  end
  element.Txt_Order:SetActive(rankData.rank >= #DataModel.rankBgList)
  local headPath, photoFactory = DataModel.GetHeadPath(rankData.avatar, rankData.gender)
  if headPath then
    element.Btn_ProfilePhoto.Img_Head:SetSprite(headPath)
    CommonTips:SetPlayerHeadShader(element.Btn_ProfilePhoto.Img_spAdd, photoFactory)
  end
  element.Group_NameGrade.Group_Grade.Txt_Grade:SetText(rankData.lv or PlayerData:GetUserInfo().lv)
  element.Group_NameGrade.Txt_Name:SetText(rankData.role_name or PlayerData:GetUserInfo().role_name)
  element.Group_Content.Txt_Num:SetText(math.floor(rankData.val))
  if element.Img_Oneself then
    element.Img_Oneself:SetActive(isSelf)
  end
  element.Group_Likes:SetActive(not isSelf)
  element.Group_Likes:SetEnableAnimator(false)
  if element.Group_Likes.IsActive then
    local isGiveLike = PlayerData.IsGiveLike(rankData.uid)
    element.Group_Likes.Group_Unlike:SetActive(not isGiveLike)
    element.Group_Likes.Group_Liked:SetActive(isGiveLike)
    element.Group_Likes.Group_Unlike.Btn_:SetClickParam(rankData.rank)
    element.Group_Likes.Group_Liked.Group_Likes_effect:SetOrder(View.self.CurrOrder)
    element.Group_Likes.Group_Liked.Group_Likes_effect:SetActive(false)
  end
  element.Img_LikesNum.Txt_:SetText(rankData.being_like_count)
end

function DataModel.RefreshHairColorEnter(skinType)
  View.Group_Character.Btn_HairColor:SetActive(false)
end

function DataModel.OpenHairColorPanel()
  local normalSelectSkins = PlayerData.CaptainSkinSystem.curShowNormalSkinItems
  local faceCoverSkin = normalSelectSkins[EnumDefine.ESkinType.FaceCover]
  if faceCoverSkin then
    DataModel.ChangeSkin(faceCoverSkin, false)
  end
  View.Group_HairColor:SetActive(true)
  View.Group_Character.Btn_Save:SetActive(false)
  DataModel.RefreshHairColorPanel()
end

function DataModel.HideHairColorPanel()
  View.Group_HairColor:SetActive(false)
  View.Group_Character.Btn_Save:SetActive(true)
end

function DataModel.RefreshHairColorPanel()
  local hairSkinCA = PlayerData:GetFactoryData(PlayerData.CaptainSkinSystem.curShowHairSkinItem.itemId, "HomeCharacterSkinFactory")
  DataModel.allHairColorItems = {}
  for i, v in ipairs(hairSkinCA.hairColorList) do
    table.insert(DataModel.allHairColorItems, v.id)
  end
  table.insert(DataModel.allHairColorItems, 1, hairSkinCA.defaultColor)
  View.Group_HairColor.ScrollGrid_.grid.self:SetDataCount(#DataModel.allHairColorItems)
  View.Group_HairColor.ScrollGrid_.grid.self:RefreshAllElement()
  DataModel.RefreshHairColorLock()
end

function DataModel.RefreshHairColorLock()
  local hairColor = PlayerData.CaptainSkinSystem.curShowHairColor
  local have = PlayerData.CaptainSkinSystem:IsCurShowHairHaveColor(hairColor)
  View.Group_HairColor.Group_Lock:SetActive(not have)
  View.Group_HairColor.Group_Confirm:SetActive(have)
  if not have then
    local tagCA = PlayerData:GetFactoryData(hairColor, "TagFactory")
    local unLockItem = tagCA.hairColorItem
    local CommonItem = require("Common/BtnItem")
    local itemData = {
      id = unLockItem,
      num = PlayerData:GetItemById(tagCA.hairColorItem).num
    }
    CommonItem.SetItem(self, View.Group_HairColor.Group_Lock.Group_Item, itemData)
    View.Group_HairColor.Group_Lock.Group_ColorOn:SetActive(itemData.num > 0)
    View.Group_HairColor.Group_Lock.Group_ColorOff:SetActive(itemData.num == 0)
    View.Group_HairColor.Group_Lock.Group_ColorOn.Btn_:SetClickParam(unLockItem)
    View.Group_HairColor.Group_Lock.Group_Item.Btn_Item:SetClickParam(unLockItem)
    View.Group_HairColor.Group_Lock.Txt_Own:SetText(itemData.num)
  end
end

DataModel.Init()
return DataModel
