local module = class("moduleHomeBagBuildInfo", G_UIModuleBase)
local _BuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _BuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()
local _BuildingTypeTpl = L_GameTpl:getHomeBuildingTypeTpl()
local _ProductBuildingTpl = L_GameTpl:getHomeBuildingProductionTpl()
local _HomeLaborCapacityTpl = L_GameTpl:getHomeLaborCapacityTpl()
local _PetHomeSizeTpl = L_GameTpl:getPetHomeSizeTpl()
local _BlockTpl = L_GameTpl:getHomeBlockTpl()

function module.bind()
  return {
    txt_num = "0",
    img_icon = "",
    txt_name = "",
    txt_type = "",
    txt_desc = "",
    active_petTag = false,
    img_laborType = "",
    txt_petSize = ""
  }
end

function module.methods()
  return {
    onClickBuild = function(self)
      local currBlockId, currGridId = AzurWorld.HomeMgr:GetInteractBlockIdAndGridIdWithPlayerByOffset()
      local blockTpl = _BlockTpl:getTplById(currBlockId)
      if not blockTpl or _BlockTpl:getBlockType(blockTpl) ~= L_HomeConst.blockType.BUILD or not C_HomeUtil.GetIsBlockUnlock(currBlockId) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_homeProduction_13"))
        return
      end
      if self._buildId then
        local placeUnlock = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.homePlace)
        if not placeUnlock then
          return
        end
        L_UI:close("pageHomeBag", nil, function()
          if L_DeviceTpl:getIsPc() then
            L_UI:open("pageHomePlayerEditCS", {
              buildingId = self._buildId
            })
          else
            L_UI:open("pageHomePlayerEditMobile", {
              buildingId = self._buildId
            })
          end
        end)
      end
    end
  }
end

function module:setBuildId(buildId, isIn, forceAni)
  self._buildId = buildId
  local buildingInBag = L_HomeStore:getBuildingInBag(buildId)
  self.bind.txt_num = tostring(buildingInBag.total_num - buildingInBag.used_num)
  local buildingTpl = _BuildingTpl:getTplById(buildId)
  local productTpl = _ProductBuildingTpl:getTplById(buildId)
  if productTpl and not math.isEmpty(_ProductBuildingTpl:getPetHomeAttribute(productTpl)) then
    local laborId = _ProductBuildingTpl:getPetHomeAttribute(productTpl)
    local petSize = _ProductBuildingTpl:getPetSize(productTpl)
    self.bind.active_petTag = true
    local txt = ""
    for i, v in ipairs(petSize) do
      local tpl_size = _PetHomeSizeTpl:getTplById(v)
      txt = string.concat(txt, _PetHomeSizeTpl:getSizeName(tpl_size))
      if i < #petSize then
        txt = string.concat(txt, "/")
      end
    end
    self.bind.txt_petSize = txt
    local tpl_capacity = _HomeLaborCapacityTpl:getTplById(laborId)
    self.bind.img_laborType = _HomeLaborCapacityTpl:getIconLight(tpl_capacity)
  else
    self.bind.active_petTag = false
  end
  local groupTpl = _BuildingGroupTpl:getTplById(_BuildingTpl:getGroupId(buildingTpl))
  local typeTpl = _BuildingTypeTpl:getTplById(_BuildingGroupTpl:getType(groupTpl))
  local conf = L_ItemTplManager:getBuildingItem(buildId)
  self.bind.txt_type = _BuildingTypeTpl:getTypeName(typeTpl)
  self.bind.img_icon = conf.icon
  self.bind.txt_name = conf.name
  self.bind.txt_desc = conf.desc
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.buildTag)
end

return module
