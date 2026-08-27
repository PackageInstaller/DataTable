local HomeBannerManager = {}
local cs_HttpDownloadHelper = CS.HttpDownloadHelper.Instance
local rapidjson = require("rapidjson")
local HomeBannerData = require("Game.Home.Banner.HomeBannerData")
local CS_ClientConsts = CS.ClientConsts

function HomeBannerManager:Init()
  self.getJsonUrl = nil
  self.bannerDataList = {}
  self.__isRequested = false
end

function HomeBannerManager:OnResUrlLoadOver()
  if CS.MicaSDKManager.Instance:IsUseSdk() then
    self.getJsonUrl = CS.MicaSDKManager.Instance.gameResUrls.GetBannerUrl
  end
end

function HomeBannerManager:RefreshBannerDataList(refreshOverCallback)
  if not Consts.GameChannelType.IsInland() and CS_ClientConsts.IsAudit then
    return
  end
  if self.getJsonUrl == nil then
    if CS.MicaSDKManager.Instance:IsUseSdk() then
      self.getJsonUrl = CS.MicaSDKManager.Instance.gameResUrls.GetBannerUrl
    end
    if self.getJsonUrl == nil then
      refreshOverCallback()
      return
    end
  end
  if self.__isRequested then
    return
  end
  self.__isRequested = true
  self.bannerDataList = {}
  local usefulNameList = {}
  self:GetBannerJsonFromURL(self.getJsonUrl, function(bannerDataJson)
    self.__isRequested = false
    if bannerDataJson == nil or bannerDataJson.code ~= 0 or bannerDataJson.data == nil then
      refreshOverCallback()
      return
    end
    for _, bannerJsonData in pairs(bannerDataJson.data) do
      local bannerData = HomeBannerData.CreateNewBannerData(bannerJsonData)
      if not bannerData:GetBannerIsOutOfData() and not bannerData:GetIsLotteryOrShopItemClosed() then
        if #self.bannerDataList == 0 then
          table.insert(self.bannerDataList, bannerData)
        else
          local isInserted = false
          for index, bannerDataInList in ipairs(self.bannerDataList) do
            if bannerDataInList.sort < bannerData.sort then
              table.insert(self.bannerDataList, index, bannerData)
              isInserted = true
              break
            elseif bannerDataInList.sort == bannerData.sort and bannerDataInList.id > bannerData.id then
              warn("banners have same sort")
              table.insert(self.bannerDataList, index, bannerData)
              isInserted = true
              break
            end
          end
          if not isInserted then
            table.insert(self.bannerDataList, #self.bannerDataList + 1, bannerData)
          end
        end
        table.insert(usefulNameList, bannerData.pic_name)
      end
    end
    self:TryDeleteOutOfDataImg(usefulNameList)
    refreshOverCallback(self.bannerDataList)
  end)
end

function HomeBannerManager:GetNextBannerData(curIndex)
  local listSize = #self.bannerDataList
  if listSize == 0 then
    return nil
  end
  if curIndex > #self.bannerDataList or curIndex == nil then
    return self.bannerDataList[1]
  end
  return self.bannerDataList[curIndex + 1]
end

function HomeBannerManager:GetBannerJsonFromURL(url, callback)
  cs_HttpDownloadHelper:GetStringFromUrl(url, function(str)
    if str == nil or string.IsNullOrEmpty(str) then
      if isGameDev then
        warn("banner error url:" .. tostring(url))
      end
      callback(nil)
      return
    end
    local tab = rapidjson.decode(str)
    callback(tab)
  end)
end

function HomeBannerManager:GetBannerPicFromHTTP(url, fileName, callback)
  cs_HttpDownloadHelper:GetImgFromUrl(url, PathConsts:GetPersistentBannerCachePath(fileName), function(Sprite)
    if Sprite == nil then
      if isGameDev then
        error("banner error url:" .. tostring(url) .. " sprite fileName:" .. tostring(fileName))
      end
      callback(nil)
      return
    end
    callback(Sprite)
  end)
end

function HomeBannerManager:TryDeleteOutOfDataImg(useFulfileNameList)
  cs_HttpDownloadHelper:DeleteImgNotUseful(PathConsts.PersistentBannerCachePath, useFulfileNameList)
end

HomeBannerManager:Init()
return HomeBannerManager
