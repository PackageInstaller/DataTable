_class("UIFavourPetHelper", Object)
UIFavourPetHelper = UIFavourPetHelper

function UIFavourPetHelper.ComponentId_Quest(idx)
  local tb = {
    ECampaignVoteComponentID.ECAMPAIGN_QUEST1,
    ECampaignVoteComponentID.ECAMPAIGN_QUEST2
  }
  return tb[idx]
end

function UIFavourPetHelper.Component_Quest(campaign, idx)
  local cmptId = UIFavourPetHelper.ComponentId_Quest(idx)
  local component = campaign:GetComponent(cmptId)
  local componentInfo = campaign:GetComponentInfo(cmptId)
  return cmptId, component, componentInfo
end

function UIFavourPetHelper.PetSort(tb)
  table.sort(tb, function(a, b)
    local star_a = UIFavourPetHelper.GetPetStar(a)
    local star_b = UIFavourPetHelper.GetPetStar(b)
    if star_a ~= star_b then
      return star_a > star_b
    end
    return a < b
  end)
end

function UIFavourPetHelper.GetFilterType()
  local tb = {
    PetFilterType.None,
    PetFilterType.BaiYeCheng,
    PetFilterType.BaiYeXiaCheng,
    PetFilterType.QiGuang,
    PetFilterType.BeiJing,
    PetFilterType.HongYouBanShou,
    PetFilterType.TaiYangJiaoTuan,
    PetFilterType.YouMin,
    PetFilterType.LongZhou
  }
  return tb
end

function UIFavourPetHelper.GetFilterTitle(type)
  if not type or type == PetFilterType.None then
    return StringTable.Get("str_common_backpack_all")
  end
  local cfg = Cfg.cfg_pet_tags[type]
  local strId = (cfg or {}).Name
  return StringTable.Get(strId)
end

function UIFavourPetHelper.GetFilterPet(tb, type)
  if not type or type == PetFilterType.None then
    return tb
  end
  local tb_out = {}
  for _, v in ipairs(tb) do
    local haveTag = UIFavourPetHelper.CheckPetTags(v, type)
    if haveTag then
      table.insert(tb_out, v)
    end
  end
  return tb_out
end

function UIFavourPetHelper.GetPetCgInfo(component, petId)
  local componentCfgId = component:GetComponentCfgId()
  local cfgs = Cfg.cfg_favour_pet_cg_offset({ComponentID = componentCfgId, ItemId = petId}) or {}
  local cfg = cfgs[1]
  if not cfg then
    Log.exception("UIFavourPetHelper.GetPetCgInfo() cfg_favour_pet_cg_offset = nil, ComponentID = ", componentCfgId, ", petId = ", petId)
    return
  end
  local tb_out = {}
  tb_out.rawImageName = cfg.CgName
  local width = cfg.Size[1] or 100
  local height = cfg.Size[2] or 100
  tb_out.size = Vector2(width, height)
  local s1 = cfg.Scale[1] or 100
  local s2 = cfg.Scale[2] or 100
  tb_out.scale = Vector3(s1 / 100, s2 / 100, 1)
  local p1 = cfg.Pos[1] or 0
  local p2 = cfg.Pos[2] or 0
  tb_out.pos = Vector3(p1, p2, 0)
  return tb_out
end

function UIFavourPetHelper.GetPetCfg(petId)
  local cfg = Cfg.cfg_pet[petId]
  if not cfg then
    Log.exception("UIFavourPetHelper.GetPetCfg() cfg_pet = nil, petId = ", petId)
  end
  return cfg or {}
end

function UIFavourPetHelper.GetPetName(petId)
  local cfgPet = UIFavourPetHelper.GetPetCfg(petId)
  local name = cfgPet.Name
  return StringTable.Get(name)
end

function UIFavourPetHelper.CheckPetTags(petId, tag)
  local cfgPet = UIFavourPetHelper.GetPetCfg(petId)
  local tags = cfgPet.Tags or {}
  for _, v in pairs(tags) do
    if v == tag then
      return true
    end
  end
  return false
end

function UIFavourPetHelper.GetPetFirstElement(petId)
  local cfgPet = UIFavourPetHelper.GetPetCfg(petId)
  local element = cfgPet.FirstElement
  if not element then
    Log.error("UIFavourPetHelper.GetPetFirstElement() element = nil, petId = ", petId)
    return
  end
  local boxName = {
    "obtain_huodong_bing",
    "obtain_huodong_huo",
    "obtain_huodong_sen",
    "obtain_huodong_lei"
  }
  local atlas1 = "UIDrawCard.spriteatlas"
  local sprite1 = boxName[element]
  local cfgPetElement = Cfg.cfg_pet_element({})
  local atlas2 = "Property.spriteatlas"
  local sprite2 = cfgPetElement[element].IconWhite
  sprite2 = UIPropertyHelper:GetInstance():GetColorBlindSprite(sprite2)
  return atlas1, sprite1, atlas2, sprite2
end

function UIFavourPetHelper.GetPetStar(petId)
  local cfgPet = UIFavourPetHelper.GetPetCfg(petId)
  return cfgPet.Star
end

function UIFavourPetHelper.GetSkinInfo(component, voteId)
  local componentCfgId = component:GetComponentCfgId()
  local cfgs = Cfg.cfg_favour_pet_cg_offset({ComponentID = componentCfgId, ItemId = voteId}) or {}
  local cfg = cfgs[1]
  if not cfg then
    Log.exception("UIFavourPetHelper.GetPetCgInfo() cfg_favour_pet_cg_offset = nil, ComponentID = ", componentCfgId, ", voteId = ", voteId)
    return
  end
  return cfg
end

function UIFavourPetHelper.NotEnoughVoteItem(component)
  local costItemId = component:GetVoteCostItemId()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local count = itemModule:GetItemCount(costItemId)
  Log.debug("UIFavourPetHelper.NotEnoughVoteItem() costItemId =", costItemId, " count = ", count)
  return count == 0
end

function UIFavourPetHelper.GetSexFilterPet(tb, sex)
  if not sex or sex == 0 then
    return tb
  end
  local tb_out = {}
  for _, v in ipairs(tb) do
    local haveTag = UIFavourPetHelper.CheckPetSex(v, sex)
    if haveTag then
      table.insert(tb_out, v)
    end
  end
  return tb_out
end

function UIFavourPetHelper.CheckPetSex(petId, sex)
  local cfgPet = UIFavourPetHelper.GetPetCfg(petId)
  local petSex = cfgPet.PetProperty
  if petSex == nil then
    petSex = 0
  end
  if sex == 0 or sex == 3 then
    return true
  elseif petSex == sex then
    return true
  else
    return false
  end
end
