local SectorUtil = {}
local cs_MessageCommon = CS.MessageCommon
local ShopEnum = require("Game.Shop.ShopEnum")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function SectorUtil.SectorChapterUnlockShowComplete(chapterId)
  NetworkManager:GetNetwork(NetworkTypeID.Object):CS_User_ModifySectorUnlockVideo(chapterId)
  PlayerDataCenter.sectorStage:SetSectorChapterUnlockShow(chapterId)
end

function SectorUtil.OnClickSectorItem(sctChaptData, isFocus, mainSectorCtrl)
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  if sectorCtrl and sectorCtrl:IsDisableClick() then
    return
  end
  local sectorId = sctChaptData:GetSctChaptSectorId()
  
  local function EnterSelectLevelFunc()
    if sctChaptData:IsSctChapterUnlockSkipped() and not sctChaptData:IsSectorChapterUnlock(false, true) and PlayerDataCenter.cacheSaveData:GetSectorChapterAvgSkipConfirm() then
      local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
      window:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(345), function()
        PlayerDataCenter.sectorEntranceHandler:EnterSctChapter(sectorId)
      end)
      window:ShowDontRemindTog(function(isOn)
        PlayerDataCenter.cacheSaveData:SetSectorChapterAvgSkipConfirm(not isOn)
      end, true)
      return
    end
    PlayerDataCenter.sectorEntranceHandler:EnterSctChapter(sectorId)
  end
  
  local unlockCostOk, costItemId, costItemNum = sctChaptData:IsSectorChapterUnlockCostOk()
  if not unlockCostOk then
    local costItemName = ConfigData:GetItemName(costItemId)
    
    local function buyFunc()
      if PlayerDataCenter:GetItemCount(costItemId) < costItemNum then
        local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
        shopCtrl:GetShopData(ShopEnum.ShopId.resident, function(shopData)
          if shopData ~= nil then
            local goodsData = shopData:GetShopGoodDataByItemId(costItemId)
            if goodsData ~= nil and goodsData:GetShopGoodCouldBuyNum() > 0 then
              do
                local msg = string.format(ConfigData:GetTipContent(340), costItemName)
                cs_MessageCommon.ShowMessageBox(msg, function()
                  UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
                    if win == nil then
                      return
                    end
                    local resIds = {}
                    table.insert(resIds, goodsData.currencyId)
                    win:SlideIn()
                    win:ShieldPopRewardWindow(true)
                    win:InitBuyTarget(goodsData, function()
                      NetworkManager:GetNetwork(NetworkTypeID.Sector):CS_SECTOR_Resident_Unlock(sectorId, function()
                        if isFocus then
                          mainSectorCtrl:DetectedGeneralSector(sectorId)
                        end
                        MsgCenter:Broadcast(eMsgEventId.SectorChapterUnlockSuccess, sectorId, EnterSelectLevelFunc)
                      end)
                    end, true, resIds)
                    win:OnClickAdd(true)
                  end)
                end, nil)
                return
              end
            end
          end
          cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(165))
        end)
        return
      end
      NetworkManager:GetNetwork(NetworkTypeID.Sector):CS_SECTOR_Resident_Unlock(sectorId, function()
        if isFocus then
          mainSectorCtrl:DetectedGeneralSector(sectorId)
        end
        MsgCenter:Broadcast(eMsgEventId.SectorChapterUnlockSuccess, sectorId, EnterSelectLevelFunc)
      end)
    end
    
    local chapterId, relevancyFunc, ignoreActDic = PlayerDataCenter.sectorEntranceHandler:Sector2ActData(sectorId)
    if not SectorStageDetailHelper.IsSectorNoActCollide(relevancyFunc, nil, ignoreActDic or table.emptytable) then
      return
    end
    local msg = string.format(ConfigData:GetTipContent(339), costItemNum, costItemName)
    UIManager:ShowWindow(UIWindowTypeID.MessageCommon):ShowItemCost(msg, costItemId, costItemNum, buyFunc)
    return
  end
  EnterSelectLevelFunc()
end

return SectorUtil
