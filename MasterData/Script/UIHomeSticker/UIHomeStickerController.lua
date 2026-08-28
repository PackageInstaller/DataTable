local View = require("UIHomeSticker/UIHomeStickerView")
local DataModel = require("UIHomeSticker/UIHomeStickerDataModel")
local Controller = {}
local UI_Need_Hide
local checkTipParam = {
  checkTipType = 1,
  checkTipKey = "HomeSticker"
}

function Controller:Init()
  DataModel.Init()
  UI_Need_Hide = {
    View.Btn_Take,
    View.Img_MoneyCostTip,
    View.Group_InviteMember,
    View.Group_Album
  }
  View.SpineAnimation_ClickCamera:SetActive(false)
  View.Group_InviteMember.ScrollGrid_MemberList.grid.self:SetDataCount(#DataModel.allCheckInCharacters)
  View.Group_InviteMember.ScrollGrid_MemberList.grid.self:RefreshAllElement()
  View.Group_InviteMember.ScrollGrid_MemberList.grid.self.ScrollRect.verticalNormalizedPosition = 1
  View.Btn_HS.Txt_Num:SetText(PlayerData:GetUserInfo().gold or 0)
  View.Img_HBP.Txt_Num:SetText(math.ceil(PlayerData:GetSpecialCurrencyById(11400100) or 0))
  Controller:Select(1)
  Controller:SetUIVisible(true)
  Controller.isCameraAnime = false
  local placeId = HomeStationStoreManager:GetCurStationPlace()
  local stationPlaceCA = PlayerData:GetFactoryData(placeId, "HomeStationPlaceFactory")
  if stationPlaceCA.bgPhoto ~= nil and stationPlaceCA.bgPhoto ~= "" then
    View.Img_Bg:SetSprite(stationPlaceCA.bgPhoto)
  end
end

function Controller:Select(idx)
  local characterInfo = DataModel.allCheckInCharacters[idx]
  local data = DataModel.allCheckInCharacters[DataModel.curSelectCharacterIdx].profilePhotoList
  View.Group_Album.ScrollGrid_AlbumList.grid.self:SetDataCount(#data)
  View.Group_Album.ScrollGrid_AlbumList.grid.self:RefreshAllElement()
  View.Group_Album.ScrollGrid_AlbumList.grid.self.ScrollRect.verticalNormalizedPosition = 1
  local groupHomeCharacter = View.Img_Frame.SpineAnimation_
  if characterInfo ~= nil then
    local characterId = characterInfo.homeCharacter
    if characterId ~= 70000067 and characterId ~= 70000063 then
      local spinePath = characterInfo.spinePath
      groupHomeCharacter:SetSpineInit(spinePath, "dorm_stand")
      groupHomeCharacter:SetActive(true)
    else
      ChangeSkinUtil.InitUICaptainSpineSkin(groupHomeCharacter, "dorm_stand")
    end
  else
    groupHomeCharacter:SetActive(false)
  end
end

function Controller:Take()
  if DataModel.curSelectCharacterIdx == 0 then
    return
  end
  local info = DataModel.allCheckInCharacters[DataModel.curSelectCharacterIdx]
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local costId = homeConfig.stickerCost[1].id
  local costNum = homeConfig.stickerCost[1].num
  checkTipParam.isCheckTip = true
  local curNum = PlayerData:GetGoodsById(costId).num
  if costNum > curNum then
    local ca = PlayerData:GetFactoryData(costId, DataManager:GetFactoryNameById(costId))
    CommonTips.OpenTips(string.format(GetText(80600367), ca.name))
    return
  end
  UIManager:Open("UI/HomeSticker/HomeStickerPromptTimes", Json.encode({
    info = info,
    costId = costId,
    costNum = costNum
  }))
end

function Controller:DoTakePhoto(info, costId, costNum, costTime)
  local curNum = PlayerData:GetGoodsById(costId).num
  if curNum < costNum * costTime then
    local ca = PlayerData:GetFactoryData(costId, DataManager:GetFactoryNameById(costId))
    CommonTips.OpenTips(string.format(GetText(80600367), ca.name))
    return
  end
  Net:SendProto("hero.photo", function(json)
    Controller:SetUIVisible(false)
    local cameraSpine = View.SpineAnimation_ClickCamera
    cameraSpine:SetActive(true)
    Controller.isCameraAnime = true
    cameraSpine:SetAction("CameraClick", false, true, function()
      local reward = json.reward
      local rewardDic = {}
      for i = 1, #reward do
        local rewardData = reward[i]
        if rewardDic[rewardData.id] == nil then
          rewardDic[rewardData.id] = rewardData
        elseif rewardDic[rewardData.id].num ~= nil and rewardData.num ~= nil then
          rewardDic[rewardData.id].num = rewardDic[rewardData.id].num + rewardData.num
        end
      end
      local rewardList = {}
      for k, v in pairs(rewardDic) do
        rewardList[#rewardList + 1] = v
      end
      UIManager:Open("UI/HomeSticker/HomeStickerAcquire", Json.encode(json.reward))
      Controller.isCameraAnime = false
      DataModel.UpdataAvatarData(json.reward.avatar or {})
      View.Group_Album.ScrollGrid_AlbumList.grid.self:RefreshAllElement()
      View.Btn_HS.Txt_Num:SetText(PlayerData:GetUserInfo().gold or 0)
      View.Img_HBP.Txt_Num:SetText(math.ceil(PlayerData:GetSpecialCurrencyById(11400100) or 0))
      cameraSpine:SetActive(false)
    end)
    cameraSpine:StartPlaySound()
  end, info.id, costTime)
end

function Controller:SetUIVisible(isVisible)
  for i = 1, #UI_Need_Hide do
    UI_Need_Hide[i]:SetActive(isVisible)
  end
end

return Controller
