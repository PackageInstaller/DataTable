_class("PetModule", GameModule)
PetModule = PetModule

function PetModule:Constructor()
  self._pets = {}
  self._petTabs = {}
  self._petskins = {}
  self._tmpSnapShoot = {}
  self._leftAffinityAddCount = 0
  self._maxAffinityAddCount = 0
  self._newPetList = {}
  self.petSkillRes = ResourceHelper:GetInstance():GetPetSKill()
  self.PetSortChooseSecondAttribute = false
  self.PetSortElementIndex = 0
  self._equipRefineNew = false
  self._property_cultivate_data = {}
end

function PetModule:Init()
  self.caller:RegisterPushHandler(CEventNotifyPetChange, self.HandlePetChange, self)
  self.caller:RegisterPushHandler(CEventNotifyAffinityAddCount, self.HandleAffinityAddCount, self)
  self.caller:RegisterPushHandler(CEventUpdateNewPetList, self.HandleUpdateNewPetList, self)
  self.caller:RegisterPushHandler(CEventNotifyPetSkinChange, self.HandlePetSkinChange, self)
end

function PetModule:Update()
end

function PetModule:GetPets()
  return self._pets
end

function PetModule:GetPetTabs()
  return self._petTabs
end

function PetModule:GetAllPetsSnapshoot()
  self._tmpSnapShoot = {}
  for k, v in pairs(self._pets) do
    self._tmpSnapShoot[v:GetTemplateID()] = 1
  end
  return
end

function PetModule:BeInSnapshoot(templateId)
  if self._tmpSnapShoot[templateId] == nil then
    self._tmpSnapShoot[templateId] = 1
    return false
  end
  return true
end

function PetModule:GetMaxStarResult()
  self:GetAllPetsSnapshoot()
  for k, v in pairs(self._pets) do
    if v._cfg_pet.Star == 6 then
      return true
    end
  end
  return false
end

function PetModule:GetPet(pstid)
  return self._pets[pstid]
end

function PetModule:GetPetByTemplateId(template_id)
  if template_id == nil then
    return nil
  end
  return self._petTabs[template_id]
end

function PetModule:HasPet(template_id)
  if template_id == nil then
    return nil
  end
  if self._petTabs[template_id] ~= nil then
    return true
  end
  return false
end

function PetModule:IsPetID(tmpID)
  return tmpID >= RoleAssetID.RoleAssetPetBegin and tmpID <= RoleAssetID.RoleAssetPetEnd
end

function PetModule:GetLeftAffinityAddCount()
  return self._leftAffinityAddCount
end

function PetModule:GetMaxAffinityAddCount()
  return self._maxAffinityAddCount
end

function PetModule.GetIntersection(count1, s1, count2, s2)
  if count1 == 0 and count2 ~= 0 then
    return s2
  elseif count2 == 0 and count1 ~= 0 then
    return s1
  end
  local out = {}
  for _, e in pairs(s1) do
    if table.icontains(s2, e) then
      table.insert(out, e)
    end
  end
  return out
end

function PetModule:ComparePetMood(args)
  if args.a_mood == args.b_mood then
    if args.a_star == args.b_star then
      return args.a_tpl_id < args.b_tpl_id
    else
      return args.a_star > args.b_star
    end
  elseif args.mood_order then
    return args.a_mood > args.b_mood
  else
    return args.a_mood < args.b_mood
  end
end

function PetModule:ComparePet(args)
  if args.a_skill_related and args.b_skill_related then
    return self:ComparePetMood(args)
  elseif args.a_skill_related == false and args.b_skill_related == false then
    return self:ComparePetMood(args)
  else
    return args.a_skill_related
  end
end

function PetModule:CompareEntertainPet(args)
  if args.a_mood == 0 then
    if args.a_mood == args.b_mood then
      return self:ComparePet(args)
    end
    return self:ComparePetMood(args)
  elseif args.b_mood == 0 then
    return self:ComparePetMood(args)
  else
    return self:ComparePet(args)
  end
end

function PetModule:IsContainsPet(room_pets, pet_id)
  for j, BigPet in pairs(room_pets) do
    if BigPet.Pet:GetPstID() == pet_id then
      return true
    end
  end
  return false
end

local PetStatus = {Selected = 0, NotSelected = 1}

function PetModule:GetOtherNoRoomPets(room_pets)
  local other_no_room_pets = {}
  local allpets = self:GetPets()
  local c = 1
  for _i, pet in pairs(allpets) do
    if not self:IsContainsPet(room_pets, pet:GetPstID()) then
      other_no_room_pets[c] = {
        Status = PetStatus.NotSelected,
        SpaceID = -1,
        RoomType = -1,
        Pet = pet
      }
      c = c + 1
    end
  end
  return other_no_room_pets
end

function PetModule:GetChoosePet(pets, choose_types)
  if choose_types == nil or #choose_types == 0 then
    return pets
  end
  local choose_pets = {}
  local i = 1
  for _, pet in pairs(pets) do
    if pet.Pet:HaveType(choose_types) then
      choose_pets[i] = pet
      i = i + 1
    end
  end
  return choose_pets
end

function PetModule:MergeTables(...)
  local tabs = {
    ...
  }
  if not tabs then
    return {}
  end
  local origin = tabs[1]
  for i = 2, #tabs do
    if origin then
      if tabs[i] then
        for k, v in pairs(tabs[i]) do
          table.insert(origin, v)
        end
      end
    else
      origin = tabs[i]
    end
  end
  return origin
end

function PetModule:GetSortPets(pets)
  local res_pets = {}
  local i = 1
  for _, pet in pairs(pets) do
    if pet.SpaceID == -1 and pet.Status ~= PetStatus.Selected then
      res_pets[i] = pet
      i = i + 1
    end
  end
  return res_pets
end

function PetModule:SortPetsForAircraft(room, sortCls, petlist)
  local room_pets = {}
  local other_room_pets = {}
  local space_id = room:SpaceId()
  local room_type_id = room:GetRoomType()
  local aricraft = GameGlobal.GetModule(AircraftModule)
  room_pets, other_room_pets = aricraft:GetPets(space_id)
  local all_room_pets = {}
  all_room_pets = self:MergeTables(all_room_pets, room_pets, other_room_pets)
  local other_no_room_pets = self:GetOtherNoRoomPets(all_room_pets)
  local all_pets = {}
  if petlist == nil then
    for i, pet in pairs(room_pets) do
      pet.Status = PetStatus.Selected
    end
    all_pets = self:MergeTables(all_pets, room_pets, other_room_pets, other_no_room_pets)
  else
    local all_pets = self:MergeTables(all_pets, all_room_pets, other_no_room_pets)
    for i, pet in pairs(all_pets) do
      for i, pet_id in pairs(petlist) do
        if pet.Pet:GetPstID() == pet_id then
          pet.Status = PetStatus.Selected
        end
      end
    end
  end
  local out = {}
  if table.icontains(sortCls._chooseType, AircraftEnterChooseType.None) then
    out = all_pets
  else
    local select_pets = {}
    local i = 1
    for _, pet in pairs(all_pets) do
      if pet.Status == PetStatus.Selected then
        select_pets[i] = pet
        i = i + 1
      end
    end
    if table.icontains(sortCls._chooseType, AircraftEnterChooseType.NotEnter) then
      out = self:GetSortPets(other_no_room_pets)
    else
      local other_choose_pets = self:GetChoosePet(all_pets, sortCls._chooseType)
      out = self:GetSortPets(other_choose_pets)
    end
    out = self:MergeTables(out, select_pets)
  end
  local mood_order = true
  if sortCls._sortType == AircraftEnterSortType.Mood and sortCls._sortOrder == AircraftEnterSortOrder.DownToUp then
    mood_order = false
  end
  local compare_func = self.ComparePet
  if room:GetRoomType() == AirRoomType.EntertainRoom then
    compare_func = self.CompareEntertainPet
  end
  table.sort(out, function(a, b)
    local args = {}
    args.a_skill_related = a.Pet:SkillRelated(room_type_id)
    args.b_skill_related = b.Pet:SkillRelated(room_type_id)
    args.a_tpl_id = a.Pet:GetTemplateID()
    args.b_tpl_id = b.Pet:GetTemplateID()
    args.a_star = a.Pet:GetPetStar()
    args.b_star = b.Pet:GetPetStar()
    args.mood_order = mood_order
    if a.Status == PetStatus.Selected and b.Status == PetStatus.Selected then
      return compare_func(self, args)
    elseif a.Status ~= PetStatus.Selected and b.Status ~= PetStatus.Selected then
      if sortCls._sortType == AircraftEnterSortType.Mood then
        return compare_func(self, args)
      elseif sortCls._sortType == AircraftEnterSortType.WorkState then
        if a.SpaceID == -1 then
          if a.SpaceID == b.SpaceID then
            return compare_func(self, args)
          end
          return sortCls._sortOrder == AircraftEnterSortOrder.UpToDown
        elseif b.SpaceID == -1 then
          return sortCls._sortOrder == AircraftEnterSortOrder.DownToUp
        else
          return compare_func(self, args)
        end
      end
    else
      return a.Status == PetStatus.Selected
    end
  end)
  return out
end

function PetModule:SortPets(filters)
  local out = {}
  local out_element = {}
  local out_first_tags = {}
  local out_second_tags = {}
  if next(self._pets) == nil then
    return out
  end
  local elements = filters.element_list
  local first_tags = filters.tag_list
  local seconde_tags = filters.secondeTag_list
  if #elements + #first_tags + #seconde_tags == 0 then
    for pstid, pet in pairs(self._pets) do
      table.insert(out, pet)
    end
  else
    for pstid, pet in pairs(self._pets) do
      local es = pet:GetPetElements()
      for _, e in pairs(es) do
        if table.icontains(elements, e) then
          table.insert(out_element, pet)
          break
        end
      end
      local ts = pet:GetPetTags()
      if table.icontains(first_tags, ts[1]) then
        table.insert(out_first_tags, pet)
      end
      if 2 <= #ts then
        for i = 2, #ts do
          if table.icontains(seconde_tags, ts[i]) then
            table.insert(out_second_tags, pet)
            break
          end
        end
      end
    end
    local temp = self.GetIntersection(#elements, out_element, #first_tags, out_first_tags)
    temp = self.GetIntersection(#elements + #first_tags, temp, #seconde_tags, out_second_tags)
    if temp ~= nil then
      table.append(out, temp)
    end
  end
  local sort_type = filters.sort_type
  local sort_order = filters.sort_order
  local default_order = PetSortOrder.Descending
  if PetSortType.Element == sort_type then
    default_order = PetSortOrder.Ascending
  end
  table.sort(out, function(a, b)
    if sort_order == default_order then
      return a:GetSortValue(sort_type) < b:GetSortValue(sort_type) or a:GetSortValue(sort_type) == b:GetSortValue(sort_type) and a:GetPetStar() > b:GetPetStar() or a:GetSortValue(sort_type) == b:GetSortValue(sort_type) and a:GetPetStar() == b:GetPetStar() and a:GetTemplateID() < b:GetTemplateID()
    else
      return a:GetSortValue(sort_type) > b:GetSortValue(sort_type) or a:GetSortValue(sort_type) == b:GetSortValue(sort_type) and a:GetPetStar() > b:GetPetStar() or a:GetSortValue(sort_type) == b:GetSortValue(sort_type) and a:GetPetStar() == b:GetPetStar() and a:GetTemplateID() < b:GetTemplateID()
    end
  end)
  return out
end

function PetModule:GetPetExpItems(pet_pstid, filter)
  local pet = self:GetPet(pet_pstid)
  if pet == nil then
    Log.fatal("Not find pet, pstid=", pet_pstid)
    return {}
  end
  local itemMd = self:GetModule(ItemModule)
  local items = itemMd:GetItemListBySubType(ItemSubType.ItemSubType_PetExp)
  if items == nil or #items == 0 then
    return items
  end
  local element = pet:GetPetFirstElement()
  if filter then
    local temp = {}
    local cfg = Cfg.cfg_item_pet_exp
    for index, value in ipairs(items) do
      if cfg[value:GetTemplateID()].Element == element or cfg[value:GetTemplateID()].Element == 0 then
        table.insert(temp, value)
      end
    end
    items = temp
  end
  table.sort(items, function(a, b)
    local ea = Cfg.cfg_item_pet_exp[a:GetTemplateID()].Element
    local eb = Cfg.cfg_item_pet_exp[b:GetTemplateID()].Element
    if ea == element and eb == element then
      if a:GetTemplate().Color == b:GetTemplate().Color then
        return ea < eb
      end
      return a:GetTemplate().Color > b:GetTemplate().Color
    elseif ea == element then
      return true
    elseif eb == element then
      return false
    elseif ea == eb then
      if a:GetTemplate().Color == b:GetTemplate().Color then
        return ea < eb
      end
      return a:GetTemplate().Color > b:GetTemplate().Color
    end
    return ea < eb
  end)
  return items
end

function PetModule:IsPetSkinID(tmpID)
  return tmpID >= RoleAssetID.RoleAssetPetSkinBegin and tmpID <= RoleAssetID.RoleAssetPetSkinEnd
end

function PetModule:GetSkinIDFromItemID(tmpID)
  return tmpID - RoleAssetID.RoleAssetPetSkinBegin
end

function PetModule:GetItemIDFromSkinID(tmpID)
  return tmpID + RoleAssetID.RoleAssetPetSkinBegin
end

function PetModule:AddPetSkins(petskin_list)
  if petskin_list == nil or #petskin_list == 0 then
    return
  end
  for _, petskin_data in pairs(petskin_list) do
    self._petskins[petskin_data.pet_template_id] = petskin_data
  end
end

function PetModule:GetPetSkinsData(pet_id)
  return self._petskins[pet_id]
end

function PetModule:GetCurrentSkinId(pet_id)
  local skindata = self:GetPetSkinsData(pet_id)
  if skindata == nil then
    return 0
  end
  return skindata.current_skin
end

function PetModule:HaveSkin(skinId)
  local skinCfg = Cfg.cfg_pet_skin[skinId]
  if not skinCfg then
    return false
  end
  local petId = skinCfg.PetId
  local skindata = self:GetPetSkinsData(petId)
  if skindata == nil then
    return false
  end
  for index, value in ipairs(skindata.skin_info) do
    if value.skin_id == skinId then
      return true
    end
  end
  return false
end

function PetModule:AddPets(pet_list, equip_refine_new)
  self._equipRefineNew = equip_refine_new
  if pet_list == nil or #pet_list == 0 then
    return
  end
  for _, pet_data in pairs(pet_list) do
    self:AddPet(pet_data)
  end
end

function PetModule:InitNewPetList(new_pet_list)
  self._newPetList = new_pet_list
end

function PetModule:AddPet(pet_data)
  local pet = self:GetPet(pet_data.pet_pstid)
  if pet ~= nil then
    pet:SetData(pet_data)
  else
    pet = Pet:New(pet_data)
    self._pets[pet_data.pet_pstid] = pet
    self._petTabs[pet:GetTemplateID()] = pet
  end
  return pet
end

function PetModule:HandlePetChange(msg)
  local pstid_list = {}
  for pstid, pet_data in pairs(msg.data) do
    local pet = self:AddPet(pet_data)
    pstid_list[#pstid_list + 1] = pstid
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PetDataChangeEvent, pstid_list)
end

function PetModule:HandleUpdateNewPetList(msg)
  self._newPetList = msg.new_pet_list
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CheckCardNew)
end

function PetModule:GetNewPetList()
  return self._newPetList
end

function PetModule:CheckNewPetForMainUI()
  local star = 4
  local active = false
  for i = 1, #self._newPetList do
    local tid = self._newPetList[i]
    local cfg_pet = Cfg.cfg_pet[tid]
    if cfg_pet and star <= cfg_pet.Star then
      active = true
      break
    end
  end
  return active
end

function PetModule:CheckRefineRedForMainUI()
  for k, v in pairs(self._pets) do
    if UIPetEquipHelper.CheckRefineRed(v) then
      return true
    end
  end
  return false
end

function PetModule:RequestPetAddExp(TT, pstid, items)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventPetAddExp)
  request.pet_pstid = pstid
  request.items = items
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  local replyEvent = reply.msg
  res:SetResult(replyEvent.nRet)
  return res
end

function PetModule:GetErrorMsg(errorcode)
  Log.error("###[GetErrorMsg] errorcode --> ", errorcode)
  if errorcode == PET_RESULT_CODE.PET_GET_EXP_ERR then
    return StringTable.Get("str_pet_config_error_get_exp_err")
  elseif errorcode == PET_RESULT_CODE.PET_ITEM_NOT_FOUND then
    return StringTable.Get("str_pet_config_pet_error_item_not_found")
  elseif errorcode == PET_RESULT_CODE.PET_DID_NOT_TRIGGERED_STORY then
    return StringTable.Get("str_pet_config_pet_error_faild19")
  else
    return StringTable.Get("str_pet_config_pet_error_faild") .. errorcode
  end
end

function PetModule:RequestPetBreak(TT, pstid)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventPetBreak)
  request.pet_pstid = pstid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-3)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.nRet)
  return res
end

function PetModule:RequestPetAwake(TT, pstid, awakening)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventPetAwake)
  request.pet_pstid = pstid
  request.awakening = awakening
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-3)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.nRet)
  return res
end

function PetModule:CanSkillPreview(_skillId)
  local b = BattleSkillCfg(_skillId)
  if b then
    return b.UICanPreview or false
  end
  return false
end

function PetModule:HandleAffinityAddCount(msg)
  self._leftAffinityAddCount = msg.left_count
  self._maxAffinityAddCount = msg.max_count
end

function PetModule:RequestPetAddAffinity(TT, pstid)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestPetAddAffinity)
  request.pet_pstid = pstid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.m_result)
  return res, replyEvent.m_aff_add_count
end

function PetModule:RequestPetViewTriggeredStory(TT, pstid, story_event_type, story_event_id)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestPetViewTriggeredStory)
  request.pet_pstid = pstid
  request.story_event_type = story_event_type
  request.story_event_id = story_event_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.m_result)
  return res, replyEvent.m_story_id
end

function PetModule:RequestPetFinishTriggeredStory(TT, pstid, story_event_type, story_event_id)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestPetFinishTriggeredStory)
  request.pet_pstid = pstid
  request.story_event_type = story_event_type
  request.story_event_id = story_event_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.m_result)
  return res, replyEvent
end

function PetModule:RequestPetViewTriggeredTask(TT, pstid)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestPetViewTriggeredTask)
  request.pet_pstid = pstid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.m_result)
  return res, replyEvent.m_story_id
end

function PetModule:RequestPetAcceptTriggeredTask(TT, pstid)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestPetAcceptTriggeredTask)
  request.pet_pstid = pstid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.m_result)
  return res, replyEvent
end

function PetModule:RequestCEventRequestPetTaskReward(TT, pstid, taskuid)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestPetTaskReward)
  request.pet_pstid = pstid
  request.task_uid = taskuid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.m_result)
  return res, replyEvent
end

function PetModule:RequestGivePetPresent(TT, pstid, items)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestGivePetPresent)
  request.pet_pstid = pstid
  request.items = items
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.m_result)
  if replyEvent.trigger_story_event_id > 0 then
    local aricraft = GameGlobal.GetModule(AircraftModule)
    aricraft:SetPetStoryEvent(EStoryTriggerType.GiveGift, pstid, replyEvent.trigger_story_event_id)
  end
  return res, replyEvent
end

function PetModule:DelNewPetMark(TT, templateId)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventDelNewpetMark)
  request.template_id = templateId
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  self._newPetList = replyEvent.new_pet_list
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CheckCardNew)
  return res
end

function PetModule:BeNewPet(templateId)
  for k, v in pairs(self._newPetList) do
    if v == templateId then
      return true
    end
  end
  return false
end

function PetModule:HaveNewPet()
  return next(self._newPetList) ~= nil
end

function PetModule:GetPetDefaultSkills(tmpID)
  local skillinfo = self.petSkillRes:GetSKill(tmpID, 0, 0)
  if skillinfo == nil then
    return nil
  end
  return skillinfo.ActiveSkill, skillinfo.ChainSkill1, skillinfo.PassiveSkill
end

function PetModule:GetTaskVec(pId)
  local pet = self._pets[pId]
  if pet == nil then
    return nil
  end
  return pet:GetTaskInfoVec()
end

function PetModule:GetFirstTask(pId)
  local pet = self._pets[pId]
  if pet == nil then
    return nil
  end
  return pet:GetFirstTaskInfo()
end

function PetModule:ReqUpEquipLv(TT, pstID)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventPetEquip)
  request.pet_pstid = pstID
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.nRet)
  return res
end

function PetModule:ReqUpEquipRefineLvUp(TT, pstID)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventEquipRefineLevelUp)
  request.pet_pstid = pstID
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.nRet)
  return res
end

function PetModule:ClickPetEquipRefine()
  self._equipRefineNew = false
  local msg = NetMessageFactory:GetInstance():CreateMessage(CEventClickPetEquipRefine)
  self:Push(msg)
end

function PetModule:HandlePetLike(TT, pstID, isLike)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventPetLike)
  request.pet_pstid = pstID
  request.b_like = isLike
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.nRet)
  return res
end

function PetModule:PetEquipRefineNew()
  return self._equipRefineNew
end

function PetModule:SavePetSortInfo(filter, sortOrder, sortType, sortParam)
  self.PetSortFilter = filter
  self.PetSortType = sortType
  self.PetSortOrder = sortOrder
  self._sortParam = sortParam
end

function PetModule:SavePetSecondAttributeFilterParam(state)
  self.PetSortChooseSecondAttribute = state
end

function PetModule:SavePetSortElementIndex(index)
  self.PetSortElementIndex = index
end

function PetModule:ClearPetSortFilterInfo()
  self.PetSortFilter = nil
  self.PetSortChooseSecondAttribute = false
end

function PetModule:ClearAllPetSortInfo()
  self.PetSortFilter = nil
  self.PetSortType = nil
  self.PetSortOrder = nil
  self.PetSortChooseSecondAttribute = false
  self.PetSortElementIndex = 0
  self._sortParam = nil
end

function PetModule:CheckHasCachePetSortInfo(isTower)
  if isTower then
    return self.PetSortFilter ~= nil and table.count(self.PetSortFilter) > 1
  else
    return self.PetSortFilter ~= nil and table.count(self.PetSortFilter) > 0
  end
end

function PetModule:UnlockSkinCG(TT, skinID)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventPetUnlockCG)
  request.skin_id = skinID
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  if replyEvent.nRet == PET_RESULT_CODE.PET_SUCCEED then
    skindata = self:GetPetSkinsData(replyEvent.pet_template_id)
    if skindata ~= nil then
      for k, v in pairs(skindata.skin_info) do
        if v.skin_id == replyEvent.pet_skin_id then
          v.unlock_CG = 1
        end
      end
    end
  end
  res:SetResult(replyEvent.nRet)
  return res
end

function PetModule:PetSkinChange(TT, skinID)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventPetSkinChange)
  request.skin_id = skinID
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  if replyEvent.nRet == PET_RESULT_CODE.PET_SUCCEED then
    local skindata = self:GetPetSkinsData(replyEvent.pet_template_id)
    if skindata ~= nil then
      skindata.current_skin = replyEvent.pet_current_skin_id
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPetSkinChange)
    end
  end
  res:SetResult(replyEvent.nRet)
  return res
end

function PetModule:HandlePetSkinChange(msg)
  for k, v in pairs(msg.data) do
    self._petskins[k] = v
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPetSkinChange)
end

function PetModule:GetBindPet(petTmpID)
  local cfgs = Cfg.cfg_pet({BinderPetID = petTmpID})
  if not cfgs or #cfgs == 0 then
    cfgs = Cfg.cfg_pet({
      BinderPetID = Cfg.cfg_pet[petTmpID].BinderPetID
    })
  end
  if not cfgs or #cfgs == 0 then
    return nil
  end
  local spPet
  for _, cfg in ipairs(cfgs) do
    if cfg.ID ~= petTmpID then
      spPet = cfg.ID
      break
    end
  end
  if spPet then
    local pet = self:GetPetByTemplateId(spPet)
    if pet then
      return pet
    end
  end
  return nil
end

function PetModule:HandlePropertyCultivateInfo(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventPropertyCultivateInfo)
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  self._property_cultivate_data = reply.msg.info
  return reply.msg
end

function PetModule:HandlePropertyCultivateLv(TT, itemlist, idlist)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventPropertyCultivateLv)
  request.smelts = itemlist
  request.cfg_id = idlist
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  self._property_cultivate_data = reply.msg.info
  if reply.msg.ret == PET_RESULT_CODE.PET_SUCCEED then
    local data = self:GetUIEducationData()
    local dataProperty = self:GetPropertyCultivateData()
    for k, v in pairs(dataProperty) do
      local element = data:Get(k)
      local stage = v.phase
      local level = v.lv
      element:SetCurrentLevel(stage, level)
      Log.info("[PetModule:HandlePropertyCultivateLv] elementType, stage, level ->: ", k, stage, level)
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.EducationChanged)
  end
  return res, reply.msg
end

function PetModule:ReqAwakeLock(TT, pstID, lv)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventLockAwake)
  request.pet_pstid = pstID
  request.lv = lv
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res
end

function PetModule:GetPropertyCultivateData()
  return self._property_cultivate_data.type_lv
end

function PetModule:GetUIEducationData(reset)
  if self._educationData == nil or reset then
    self._educationData = UIEducationData:New()
  end
  return self._educationData
end

function PetModule:GetPetIndexStr()
  local str = ""
  if next(self._pets) == nil then
    return str
  end
  local pets = Cfg.cfg_pet({})
  local kvPets = {}
  for k, v in pairs(pets) do
    table.insert(kvPets, k)
  end
  table.sort(kvPets)
  for pstid, pet_data in pairs(self._pets) do
    local index = table.ikey(kvPets, pet_data._cfg_pet.ID)
    str = str .. index .. ","
  end
  return string.sub(str, 1, -2)
end

function PetModule:GetPetSkinIndexStr()
  local str = ""
  if next(self._petskins) == nil then
    return str
  end
  local petskins = Cfg.cfg_pet_skin({})
  local kvPetskins = {}
  for k, v in pairs(petskins) do
    table.insert(kvPetskins, k)
  end
  table.sort(kvPetskins)
  for pstid, pet_data in pairs(self._petskins) do
    for i, v in pairs(pet_data.skin_info) do
      local index = table.ikey(kvPetskins, v.skin_id)
      str = str .. index .. ","
    end
  end
  return string.sub(str, 1, -2)
end

function PetModule:AddPetsByID(pet_list)
  if pet_list == nil or #pet_list == 0 then
    return
  end
  for _, pet_id in pairs(pet_list) do
    local pet_data = pet_data:New()
    pet_data.template_id = pet_id
    pet_data.pet_pstid = pet_id
    local pet = Pet:New(pet_data)
    local maxGrade = pet:GetMaxGrade()
    pet_data.grade = maxGrade
    pet_data.level = pet:GetMaxLevel()
    pet_data.awakening = pet:GetMaxAwakening()
    pet_data.equip_lv = ResourceHelper:GetInstance():GetPetEquip():GetMaxLv(pet:GetTemplateID())
    pet_data.affinity_level = pet:GetPetAffinityMaxLevel()
    pet_data.equip_refine_lv = pet:GetEquipRefineMaxLv()
    pet:SetData(pet_data)
    self._pets[pet_data.pet_pstid] = pet
    self._petTabs[pet:GetTemplateID()] = pet
  end
end

function PetModule:AddPetSkinsDJ(petskin_list)
  if petskin_list == nil or #petskin_list == 0 then
    return
  end
  for _, petskin_id in pairs(petskin_list) do
    local _petSkinCfg = Cfg.cfg_pet_skin[petskin_id]
    if self._petskins[_petSkinCfg.PetId] == nil then
      local pet_skin_data = pet_skin_data:New()
      pet_skin_data.current_skin = 0
      pet_skin_data.owner_pstid = _petSkinCfg.PetId
      pet_skin_data.pet_template_id = _petSkinCfg.PetId
      pet_skin_data.skin_info = {}
      self._petskins[_petSkinCfg.PetId] = pet_skin_data
    end
    local skinInfo = PetSkinInfo:New()
    skinInfo.skin_id = petskin_id
    skinInfo.unlock_CG = 1
    skinInfo.gain_time = 0
    table.insert(self._petskins[_petSkinCfg.PetId].skin_info, skinInfo)
  end
  for k, v in pairs(self._pets) do
    if self._petskins[k] ~= nil and self._petskins[k].skin_info ~= nil then
      local haveSkinTwo = false
      local awakeningSkinID = v._cfg_pet.SkinId + 1
      self._petskins[k].current_skin = tonumber(PlayerPrefsGetPersonString("PetSkin_" .. k, v._cfg_pet.SkinId))
      local _petSkinCfg = Cfg.cfg_pet_skin[awakeningSkinID]
      if _petSkinCfg ~= nil then
        for index, skinInfoTemp in pairs(self._petskins[k].skin_info) do
          if skinInfoTemp.skin_id == awakeningSkinID then
            haveSkinTwo = true
          end
        end
        if not haveSkinTwo then
          local skinInfo = PetSkinInfo:New()
          skinInfo.skin_id = awakeningSkinID
          skinInfo.unlock_CG = 1
          skinInfo.gain_time = 0
          table.insert(self._petskins[k].skin_info, skinInfo)
        end
      end
    end
  end
end

function PetModule:HandlePetSingleData(msg)
  self._pets = {}
  self._petTabs = {}
  self._petskins = {}
  local strList = string.split(msg, "|")
  local strpet = strList[1]
  local strpetSkin = strList[2]
  local petIndexList = string.split(strpet, ",")
  local petSkinIndexList = string.split(strpetSkin, ",")
  local pets = Cfg.cfg_pet({})
  local kvPets = {}
  for k, v in pairs(pets) do
    table.insert(kvPets, k)
  end
  table.sort(kvPets)
  local testPet = {}
  for i = 1, #petIndexList do
    table.insert(testPet, kvPets[tonumber(petIndexList[i])])
  end
  self:AddPetsByID(testPet)
  local petskins = Cfg.cfg_pet_skin({})
  local kvPetskins = {}
  for k, v in pairs(petskins) do
    table.insert(kvPetskins, k)
  end
  table.sort(kvPetskins)
  local testSkin = {}
  for i = 1, #petSkinIndexList do
    table.insert(testSkin, kvPetskins[tonumber(petSkinIndexList[i])])
  end
  self:AddPetSkinsDJ(testSkin)
end
