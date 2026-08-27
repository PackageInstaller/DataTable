local base = UIBaseNode
local UICarnivalMemoryFragmentItem = class("UICarnivalMemoryFragmentItem", base)
local UICarnivalMemoryOrderConsumeInfoItem = require("Game.ActivityCarnival24.UI.UICarnivalMemoryOrderConsumeInfoItem")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local eDemandState = require("Game.Task.TaskEnum").eTaskState
local cs_MessageCommon = CS.MessageCommon

function UICarnivalMemoryFragmentItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.btnColors = {}
  self.btnTextColors = {}
  self.toggleColors = {}
  self.memoryFragmentItemPool = UIItemPool.New(UICarnivalMemoryOrderConsumeInfoItem, self.ui.obj_consumeInfoItem)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.UINBaseItemWithCount)
  self.ui.obj_consumeInfoItem:SetActive(false)
  self.ui.UINBaseItemWithCount:SetActive(false)
  self._heroPicMat = UIUtil.GetImageMaterial(self.ui.img_heroPic)
  UIUtil.AddButtonListener(self.ui.btn_Reminisce, self, self.OnClickReminisce)
end

function UICarnivalMemoryFragmentItem:InitCarnivalMemoryFragmentItem(memoryDemandCfg, carnival24Data, resLoader)
  UIUtil.LuaUIBindingTable(self.ui.img_btnBg1.transform, self.btnColors)
  UIUtil.LuaUIBindingTable(self.ui.tex_btnName.transform, self.btnTextColors)
  UIUtil.LuaUIBindingTable(self.ui.obj_Tag.transform, self.toggleColors)
  self.memoryDemandCfg = memoryDemandCfg
  self.carnival24Data = carnival24Data
  self.resLoader = resLoader
  self:Refresh(memoryDemandCfg, carnival24Data)
end

function UICarnivalMemoryFragmentItem:Refresh(memoryDemandCfg, carnival24Data)
  self:RefrshTag(memoryDemandCfg.type_id == 1)
  self.demandState = carnival24Data:GetMemoryFragMentDemandState(memoryDemandCfg.stage_id, memoryDemandCfg.demand_id)
  local isDemandcompleted = self.demandState == eDemandState.Completed
  local isPicked = self.demandState == eDemandState.Picked
  self:RefreshFrameStyle(isPicked)
  self:RefreshHeroPic(memoryDemandCfg.hero_id, isPicked)
  self:RefreshConsume(isPicked, memoryDemandCfg.consume_ids, memoryDemandCfg.consume_nums)
  self:RefreshRewards(isPicked, memoryDemandCfg.reward_ids, memoryDemandCfg.reward_nums)
  self:RefreshReminisceBtnState(isPicked, isDemandcompleted)
end

function UICarnivalMemoryFragmentItem:RefrshTag(isKeyOrder)
  self.ui.img_Tag.color = isKeyOrder and self.toggleColors.keyToggleColor or self.toggleColors.commonToggleColor
  self.ui.tex_TagName:SetIndex(isKeyOrder and 0 or 1)
  self.ui.obj_Tag:SetActive(isKeyOrder)
end

function UICarnivalMemoryFragmentItem:RefreshFrameStyle(isPicked)
  self.ui.obj_frame2:SetActive(not isPicked)
end

function UICarnivalMemoryFragmentItem:RefreshHeroPic(heroId, isPicked)
  if heroId ~= self._heroId then
    local heroCfg = ConfigData.hero_data[heroId]
    local skinId = heroCfg.default_skin
    local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
    local resModelCfg = skinCtrl:GetResModel(heroId, skinId)
    local path = PathConsts:GetCharacterPicPath(resModelCfg.src_id_pic)
    self.resLoader:LoadABAssetAsync(path, function(image)
      if IsNull(image) or IsNull(self.transform) then
        return
      end
      self.ui.img_heroPic.texture = image
      self._heroId = heroId
    end)
    self._heroId = heroId
  end
  self.ui.img_heroPic.material:SetFloat("_CoverColorRate", isPicked and 0 or 1)
end

function UICarnivalMemoryFragmentItem:RefreshConsume(isPicked, consumeItemIds, consumeItemNums)
  self.memoryFragmentItemPool:HideAll()
  self.ui.obj_consumeInfoItem.transform.parent.gameObject:SetActive(not isPicked)
  if isPicked then
    return
  end
  for index, itemId in pairs(consumeItemIds) do
    local item = self.memoryFragmentItemPool:GetOne()
    local itemCount = PlayerDataCenter:GetItemCount(itemId)
    item:InitCarnivalMemoryOrderConsumeInfoItem(itemId, itemCount, consumeItemNums[index])
  end
end

function UICarnivalMemoryFragmentItem:RefreshRewards(isPicked, rewardItemIds, rewardItemNums)
  self.rewardItemPool:HideAll()
  self.ui.UINBaseItemWithCount.transform.parent.gameObject:SetActive(not isPicked)
  if isPicked then
    return
  end
  for index, itemId in pairs(rewardItemIds) do
    local itemCfg = ConfigData.item[itemId]
    local item = self.rewardItemPool:GetOne()
    item:InitItemWithCount(itemCfg, rewardItemNums[index])
  end
end

function UICarnivalMemoryFragmentItem:RefreshReminisceBtnState(isPicked, isCompleted)
  self.ui.img_btnBg1.gameObject:SetActive(not isPicked)
  self.ui.img_btnBg2.gameObject:SetActive(isPicked)
  if not isPicked then
    self.ui.img_btnBg1.color = isCompleted and self.btnColors.CompletedColor or self.btnColors.notCompletedColor
    self.ui.tex_btnName:SetIndex(0)
  else
    self.ui.tex_btnName:SetIndex(1)
  end
  self.ui.tex_btnName.text.color = (isCompleted or isPicked) and self.btnTextColors.coundCompletedColor or self.btnTextColors.notCompletedColor
end

function UICarnivalMemoryFragmentItem:OnClickReminisce()
  if self.demandState == eDemandState.InProgress then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(56001))
    return
  end
  if self.demandState == eDemandState.Completed then
    local actFrameNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
    local memoryDemandCfg = self.memoryDemandCfg
    actFrameNetCtrl:CS_ACTIVITY_Carnival24_Demand(memoryDemandCfg.stage_id, memoryDemandCfg.demand_id, function(msg)
      ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, memoryDemandCfg.avg_id, function()
        if msg.rewards ~= nil then
          UIUtil.ShowCommonReward(msg.rewards, nil, function()
            local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
            if ctrl then
              ctrl:TryChangeLobby(self.carnival24Data:GetActId())
            end
          end)
        end
      end)
    end)
    return
  elseif self.demandState == eDemandState.Picked then
    ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, self.memoryDemandCfg.avg_id)
    return
  end
end

function UICarnivalMemoryFragmentItem:OnDelete()
  self.memoryFragmentItemPool:DeleteAll()
  self.memoryFragmentItemPool = nil
  self.rewardItemPool:DeleteAll()
  self.rewardItemPool = nil
  DestroyUnityObject(self._heroPicMat)
end

return UICarnivalMemoryFragmentItem
