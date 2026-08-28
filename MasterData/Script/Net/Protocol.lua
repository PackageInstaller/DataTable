local Protocol = {}
Protocol["main.index"] = function()
  return {}
end
Protocol["main.notice"] = function()
  return {}
end
Protocol["deck.set_deck"] = function(squadIndex, roles, hid, failCb)
  return {
    squadIndex = squadIndex,
    roleId = roles,
    hid = hid,
    failCb = failCb
  }
end
Protocol["deck.set_name"] = function(squadIndex, squadName)
  return {squadIndex = squadIndex, squadName = squadName}
end
Protocol["deck.auto_deck"] = function(isOpen, autoCode, autoId)
  return {
    isOpen = isOpen,
    autoCode = autoCode,
    autoId = autoId
  }
end
Protocol["hero.breakthrough"] = function(roleId)
  return {roleId = roleId}
end
Protocol["hero.awakening"] = function(roleId)
  return {roleId = roleId}
end
Protocol["hero.resonance"] = function(roleId, itemArr)
  return {roleId = roleId, itemArr = itemArr}
end
Protocol["hero.resonance_skill"] = function(roleId, resoLv)
  return {roleId = roleId, resoLv = resoLv}
end
Protocol["hero.resonance_attribute"] = function(roleId, resoLv, attributeIndex)
  return {
    roleId = roleId,
    resoLv = resoLv,
    attributeIndex = attributeIndex
  }
end
Protocol["hero.upgrade_skill"] = function(roleId, skillIndex)
  return {roleId = roleId, skillIndex = skillIndex}
end
Protocol["equip.forging"] = function(forgeId)
  return {forgeId = forgeId}
end
Protocol["equip.resolve"] = function(equipmentId)
  return {equipmentId = equipmentId}
end
Protocol["hero.set_equips"] = function(roleId, equipId, index)
  return {
    roleId = roleId,
    equipId = equipId,
    index = index
  }
end
Protocol["shop.info"] = function(shopIds)
  return {shopIds = shopIds}
end
Protocol["shop.buy"] = function(shopId, itemIndex, num, itemId)
  return {
    shopId = shopId,
    itemIndex = itemIndex,
    num = num,
    itemId = itemId or ""
  }
end
Protocol["shop.buy_list"] = function(shopId, itemInfo)
  return {shopId = shopId, itemInfo = itemInfo}
end
Protocol["shop.recycle_list"] = function(shopId, itemInfo)
  return {shopId = shopId, itemInfo = itemInfo}
end
Protocol["shop.items_refresh_pet_shop"] = function(petIndex)
  return {petIndex = petIndex}
end
Protocol["item.recycle_material"] = function(materialIds)
  return {materialIds = materialIds}
end
Protocol["shop.refresh"] = function(shopId)
  return {shopId = shopId}
end
Protocol["battle.start_battle"] = function(levelId, eventId, squadIndex, levelType, levelIndex, isEvent, eventIndex, sid, levelKey, failCb, difficulty, next_distance, areaId, coreId, ttbSid, ttbIndex, ttbId, rids, pgUniqueId, autoDiff, dialogId, friendId, gridId, rbIndex, csActivityId, csIndex, pgUid, activityId, serverRwIdx, helpRole)
  local hbId, hbRid
  if helpRole then
    hbId = helpRole.playerId
    hbRid = helpRole.id
  end
  if eventIndex then
    if areaId then
      return {
        levelId = tostring(levelId),
        sid = sid,
        eventId = eventId == nil and "" or tostring(eventId),
        squadIndex = math.floor(squadIndex),
        eventIndex = eventIndex,
        levelType = levelType,
        isEvent = isEvent,
        failCb = failCb,
        difficulty = difficulty or 1,
        areaId = areaId,
        coreId = coreId,
        hbId = hbId,
        hbRid = hbRid
      }
    else
      return {
        levelId = tostring(levelId),
        sid = sid,
        eventId = eventId == nil and "" or tostring(eventId),
        squadIndex = math.floor(squadIndex),
        eventIndex = eventIndex,
        levelType = levelType,
        isEvent = isEvent,
        failCb = failCb,
        difficulty = difficulty or 1,
        coreId = coreId,
        hbId = hbId,
        hbRid = hbRid
      }
    end
  else
    return {
      levelId = tostring(levelId),
      eventId = eventId == nil and "" or tostring(eventId),
      squadIndex = math.floor(squadIndex),
      levelType = levelType,
      levelIndex = levelIndex,
      isEvent = isEvent,
      levelKey = levelKey,
      failCb = failCb,
      difficulty = difficulty or 1,
      coreId = coreId,
      ttbSid = ttbSid,
      ttbIndex = ttbIndex,
      ttbId = ttbId,
      rids = rids,
      pgUniqueId = pgUniqueId,
      auto_diff = autoDiff,
      dialogId = dialogId,
      friendId = friendId,
      gridId = gridId,
      rbIndex = rbIndex,
      csActivityId = csActivityId,
      csIndex = csIndex,
      pgUid = pgUid,
      activityId = activityId,
      rwIndex = serverRwIdx,
      hbId = hbId,
      hbRid = hbRid
    }
  end
end
Protocol["battle.end_battle"] = function(levelUid, score, b_json, failCb, currentHP, completed, cores)
  return {
    levelUid = tostring(levelUid),
    score = tostring(score),
    bJson = b_json,
    failCb = failCb,
    currentHP = currentHP,
    completed = completed,
    cores = cores
  }
end
Protocol["battle.skip_battle"] = function(levelId, eventId, squadIndex, levelType, levelIndex, isEvent, eventIndex, sid, levelKey, failCb, difficulty, areaId, coreId, ttbSid, ttbIndex, ttbId, rids, pgUniqueId, autoDiff, dialogId, friendId, gridId, rbIndex, csActivityId, csIndex, pgUid, activityId, serverRwIdx, levelUid, score, b_json, currentHP, completed, cores)
  if eventIndex then
    if areaId then
      return {
        levelId = tostring(levelId),
        sid = sid,
        eventId = eventId == nil and "" or tostring(eventId),
        squadIndex = math.floor(squadIndex),
        eventIndex = eventIndex,
        levelType = levelType,
        isEvent = isEvent,
        failCb = failCb,
        difficulty = difficulty or 1,
        areaId = areaId,
        coreId = coreId,
        levelUid = tostring(levelUid),
        score = tostring(score),
        bJson = b_json,
        currentHP = currentHP,
        completed = completed,
        cores = cores
      }
    else
      return {
        levelId = tostring(levelId),
        sid = sid,
        eventId = eventId == nil and "" or tostring(eventId),
        squadIndex = math.floor(squadIndex),
        eventIndex = eventIndex,
        levelType = levelType,
        isEvent = isEvent,
        failCb = failCb,
        difficulty = difficulty or 1,
        coreId = coreId,
        levelUid = tostring(levelUid),
        score = tostring(score),
        bJson = b_json,
        currentHP = currentHP,
        completed = completed,
        cores = cores
      }
    end
  else
    return {
      levelId = tostring(levelId),
      eventId = eventId == nil and "" or tostring(eventId),
      squadIndex = math.floor(squadIndex),
      levelType = levelType,
      levelIndex = levelIndex,
      isEvent = isEvent,
      levelKey = levelKey,
      failCb = failCb,
      difficulty = difficulty or 1,
      coreId = coreId,
      ttbSid = ttbSid,
      ttbIndex = ttbIndex,
      ttbId = ttbId,
      rids = rids,
      pgUniqueId = pgUniqueId,
      auto_diff = autoDiff,
      dialogId = dialogId,
      friendId = friendId,
      gridId = gridId,
      rbIndex = rbIndex,
      csActivityId = csActivityId,
      csIndex = csIndex,
      pgUid = pgUid,
      activityId = activityId,
      rwIndex = serverRwIdx,
      levelUid = tostring(levelUid),
      score = tostring(score),
      bJson = b_json,
      currentHP = currentHP,
      completed = completed,
      cores = cores
    }
  end
end
Protocol["main.set_receptionist"] = function(receptionistId, index)
  return {receptionistId = receptionistId, index = index}
end
Protocol["main.set_adjutant"] = function(adjutantId, index)
  return {adjutantId = adjutantId, index = index}
end
Protocol["main.set_room_back"] = function(roomBackId)
  return {
    roomBackId = tostring(roomBackId)
  }
end
Protocol["main.unlock_room_back"] = function(itemId, index)
  return {
    itemId = tostring(itemId),
    index = tostring(index)
  }
end
Protocol["main.add_show"] = function(index)
  return {index = index}
end
Protocol["main.delete_board"] = function(bType, index)
  return {bType = bType, index = index}
end
Protocol["item.use_items"] = function(itemId, num, choice, itemType)
  return {
    itemId = itemId,
    num = num,
    choice = choice,
    itemType = itemType
  }
end
Protocol["meal.takeout"] = function(num)
  return {num = num}
end
Protocol["item.sell_items"] = function(itemId, num)
  return {itemId = itemId, num = num}
end
Protocol["main.set_rolename"] = function(role_name, failCb)
  return {role_name = role_name, failCb = failCb}
end
Protocol["main.paid_name"] = function(role_name, failCb)
  return {role_name = role_name, failCb = failCb}
end
Protocol["main.set_sign"] = function(sign)
  return {sign = sign}
end
Protocol["main.query_ip_address"] = function()
  return {}
end
Protocol["main.set_property"] = function(coin)
  return {
    attrs = "gold=" .. coin
  }
end
Protocol["recruit.do_recruit"] = function(poolID, num, failCb)
  return {
    poolID = poolID,
    num = num,
    failCb = failCb
  }
end
Protocol["battle.info"] = function()
  return {}
end
Protocol["mail.get"] = function()
  return {}
end
Protocol["mail.accredit"] = function(key)
  return {key = key}
end
Protocol["mail.read"] = function(key)
  return {key = key}
end
Protocol["mail.delete"] = function(key, del_all)
  return {
    key = key,
    del_all = del_all or 0
  }
end
Protocol["mail.receive_award"] = function(key, recv_all)
  return {
    key = key,
    recv_all = recv_all or 0
  }
end
Protocol["friend.get_lists"] = function()
  return {}
end
Protocol["friend.search"] = function(content)
  return {
    content = tostring(content)
  }
end
Protocol["friend.add_request"] = function(uid, re_word)
  return {
    uid = tostring(uid),
    re_word = tostring(re_word)
  }
end
Protocol["friend.accept_request"] = function(uid)
  return {
    uid = tostring(uid)
  }
end
Protocol["friend.refuse_request"] = function(uid)
  return {
    uid = tostring(uid)
  }
end
Protocol["friend.delete"] = function(uid)
  return {
    uid = tostring(uid)
  }
end
Protocol["friend.add_blacklist"] = function(uid)
  return {
    uid = tostring(uid)
  }
end
Protocol["friend.remove_blacklist"] = function(uid)
  return {
    uid = tostring(uid)
  }
end
Protocol["zone.get_msg"] = function(uid)
  return {
    uid = tostring(uid)
  }
end
Protocol["zone.leave_msg"] = function(uid, content)
  return {
    uid = tostring(uid),
    content = tostring(content)
  }
end
Protocol["zone.reply_msg"] = function(content, m_index)
  return {
    content = tostring(content),
    m_index = tostring(m_index)
  }
end
Protocol["zone.del_msg"] = function(m_index)
  return {
    m_index = tostring(m_index)
  }
end
Protocol["zone.set_permission"] = function(set_type)
  return {set_type = set_type}
end
Protocol["quest.recv_rewards"] = function(qid)
  return {
    qid = tostring(qid)
  }
end
Protocol["quest.accumulate"] = function(index)
  return {index = index}
end
Protocol["quest.receive_quests"] = function(quests)
  return {quests = quests}
end
Protocol["quest.multi_pass_rec_quests_rewards"] = function(passKind)
  return {passKind = passKind}
end
Protocol["quest.accept"] = function(qid)
  return {qid = qid}
end
Protocol["pass.rec_pass_rewards"] = function()
  return {}
end
Protocol["hero.add_exp_by_material"] = function(roleId, itemArr)
  return {roleId = roleId, itemArr = itemArr}
end
Protocol["hero.add_exp_multi"] = function(roleJson)
  return {roleJson = roleJson}
end
Protocol["item.recv_liveness_rewards"] = function(index, rec_all)
  return {
    index = math.floor(index),
    rec_all = rec_all
  }
end
Protocol["item.rec_weekly_rewards"] = function(index)
  return {
    index = math.floor(index)
  }
end
Protocol["battle_pass.multi_pass_rewards"] = function(passKind, passType, passIndex, rec_all)
  return {
    passKind = passKind,
    passType = passType,
    passIndex = passIndex,
    rec_all = rec_all
  }
end
Protocol["battle_pass.bs_pass_rewards"] = function(passType, passIndex, rec_all)
  return {
    passType = passType,
    passIndex = passIndex,
    rec_all = rec_all
  }
end
Protocol["battle_pass.multi_buy"] = function(passKind, index)
  return {passKind = passKind, index = index}
end
Protocol["battle_pass.bs_buy"] = function(index)
  return {index = index}
end
Protocol["battle_pass.multi_upgrade"] = function(passKind, num)
  return {passKind = passKind, num = num}
end
Protocol["battle_pass.bs_upgrade"] = function(num)
  return {num = num}
end
Protocol["battle_pass.bp_info"] = function()
  return {}
end
Protocol["main.set_real_info"] = function(id_card, real_name)
  return {id_card = id_card, real_name = real_name}
end
Protocol["battle.source_chapter"] = function()
  return {}
end
Protocol["battle.academy_awards"] = function(levelId)
  return {
    levelId = tostring(levelId)
  }
end
Protocol["main.verify_user"] = function(access_token)
  return {access_token = access_token}
end
Protocol["main.sign_in"] = function(activeSigninId)
  return {
    activeSigninId = tostring(activeSigninId)
  }
end
Protocol["shop.receive_awards"] = function(shopId, awardIndex)
  return {
    shopId = tostring(shopId),
    awardIndex = tostring(awardIndex)
  }
end
Protocol["shop.shop_card"] = function(itemId)
  return {
    itemId = tostring(itemId)
  }
end
Protocol["shop.purchase"] = function(itemId, shopId)
  return {
    itemId = tostring(itemId),
    shopId = tostring(shopId)
  }
end
Protocol["item.recycled"] = function(materialId, num)
  return {
    materialId = tostring(materialId),
    num = math.floor(num)
  }
end
Protocol["main.set_gender"] = function(genderId)
  return {gender = genderId}
end
Protocol["level_chain.open"] = function(LCId)
  return {levelChainId = LCId}
end
Protocol["level_chain.close"] = function()
  return {}
end
Protocol["card.update"] = function(roleId, skillCount)
  return {roleId = roleId, skillCount = skillCount}
end
Protocol["level_chain.set_buff"] = function(levelIndex, buffIndex)
  return {
    levelIndex = tostring(levelIndex),
    buffIndex = tostring(buffIndex)
  }
end
Protocol["level_chain.buff"] = function()
  return {}
end
Protocol["level_chain.finish"] = function()
  return {}
end
Protocol["home.study"] = function(coachId)
  return {coachId = coachId}
end
Protocol["home.build"] = function(coachId)
  return {coachId = coachId}
end
Protocol["home.decorate"] = function(furnitures, squadIndex, duration)
  return {
    furnitures = furnitures,
    squadIndex = squadIndex,
    duration = duration
  }
end
Protocol["home.open"] = function()
  return {}
end
Protocol["home.update_name"] = function(squadName)
  return {squadName = squadName}
end
Protocol["home.save_template"] = function(squadIndex, template)
  return {squadIndex = squadIndex, template = template}
end
Protocol["home.rename"] = function(squadIndex, squadName)
  return {squadIndex = squadIndex, squadName = squadName}
end
Protocol["deck.preset"] = function(roleId, skillCount, equipList, failCb)
  return {
    roleId = roleId,
    skillCount = skillCount,
    equipList = equipList,
    failCb = failCb
  }
end
Protocol["deck.update_hero"] = function(squadIndex, roleId, skills, equips, roleIndex, failCb)
  return {
    roleId = roleId,
    squadIndex = squadIndex,
    skills = skills,
    equips = equips,
    roleIndex = roleIndex,
    failCb = failCb
  }
end
Protocol["main.set_avatar"] = function(avatarId)
  return {avatar = avatarId}
end
Protocol["home.unlock_battery"] = function(squadIndex, batteryIndex)
  return {squadIndex = squadIndex, batteryIndex = batteryIndex}
end
Protocol["home.set_train_weapon"] = function(coachWeaponId, isUnset, weaponIndex, coachId)
  return {
    coachWeaponId = coachWeaponId,
    isUnset = isUnset,
    weaponIndex = weaponIndex,
    coachId = coachId
  }
end
Protocol["home.unset_battery"] = function(squadIndex, batteryIndex, batteryId)
  return {
    squadIndex = squadIndex,
    batteryIndex = batteryIndex,
    batteryId = batteryId
  }
end
Protocol["station.start_drive"] = function(terminus)
  return {terminus = terminus}
end
Protocol["station.drive"] = function(sid, coachSkins)
  return {sid = sid, coachSkins = coachSkins}
end
Protocol["station.arrive"] = function(sid, isBack, arrive_type, aJson)
  return {
    sid = sid,
    isBack = isBack or 0,
    arrive_type = arrive_type or "normal",
    aJson = aJson or nil
  }
end
Protocol["station.stop"] = function(sid, next_distance, failCb)
  return {
    sid = sid,
    next_distance = next_distance,
    failCb = failCb
  }
end
Protocol["station.auto_arrived"] = function(failCb, isBack)
  return {
    isBack = isBack or 0,
    failCb = failCb
  }
end
Protocol["home.refuel"] = function(buy_num)
  return {buy_num = buy_num}
end
Protocol["station.accelerate"] = function(failCb)
  return {failCb = failCb}
end
Protocol["station.back_home_to_station"] = function()
  return {}
end
Protocol["home.update_electric"] = function()
  return {}
end
Protocol["home.open_electric_slot"] = function()
  return {}
end
Protocol["station.get_awards"] = function()
  return {}
end
Protocol["meal.info"] = function()
  return {}
end
Protocol["meal.pet_food"] = function()
  return {}
end
Protocol["meal.eat"] = function(mealId, orderIndex, isAll)
  return {
    mealId = mealId,
    orderIndex = orderIndex,
    isAll = isAll
  }
end
Protocol["meal.mark_score"] = function(mealId, score)
  return {mealId = mealId, score = score}
end
Protocol["meal.take_out"] = function()
  return {}
end
Protocol["meal.sale"] = function(mealId)
  return {mealId = mealId}
end
Protocol["station.info"] = function(sid)
  return {sid = sid}
end
Protocol["station.up_price"] = function()
  return {}
end
Protocol["station.down_price"] = function()
  return {}
end
Protocol["station.buy"] = function(goodsArr)
  return {goodsArr = goodsArr}
end
Protocol["station.sell"] = function(goodsArr)
  return {goodsArr = goodsArr}
end
Protocol["building.clean"] = function(bdId)
  return {bdId = bdId}
end
Protocol["building.env_reward"] = function(index, bdId)
  return {index = index, bdId = bdId}
end
Protocol["station.get_quest"] = function(questIds)
  return {questIds = questIds}
end
Protocol["station.complete_quest"] = function(questIds)
  return {questIds = questIds}
end
Protocol["station.add_quest"] = function(num)
  return {num = num}
end
Protocol["station.reset_quest"] = function(questIds)
  return {questIds = questIds}
end
Protocol["creature.place"] = function(uFid, creatureIds)
  return {uFid = uFid, creatureIds = creatureIds}
end
Protocol["creature.rec_rewards"] = function(uFid, cancel)
  return {uFid = uFid, cancel = cancel}
end
Protocol["creature.place_fish"] = function(uFid, fishIds, uSkin, failCb)
  return {
    uFid = uFid,
    fishIds = fishIds,
    uSkin = uSkin,
    failCb = failCb
  }
end
Protocol["playground.place_fish"] = function(fishIds, uFid, pgId)
  return {
    uFid = uFid,
    fishIds = fishIds,
    pgId = pgId
  }
end
Protocol["recruit.cap_info"] = function(poolID)
  return {poolID = poolID}
end
Protocol["recruit.do_caps"] = function(poolID, num)
  return {poolID = poolID, num = num}
end
Protocol["creature.plant"] = function(uFid, plantId, plantIndex)
  return {
    uFid = uFid,
    plantId = tostring(plantId),
    plantIndex = plantIndex
  }
end
Protocol["creature.remove_plant"] = function(uFid, plantIndex, uproot)
  return {
    uFid = uFid,
    plantIndex = plantIndex,
    uproot = uproot
  }
end
Protocol["hero.check_in"] = function(uFid, roleId, failCb)
  return {
    uFid = uFid,
    roleId = roleId,
    failCb = failCb
  }
end
Protocol["hero.photo"] = function(hid, num)
  return {hid = hid, num = num}
end
Protocol["hero.update_skin"] = function(typeId, skinId)
  return {typeId = typeId, skinId = skinId}
end
Protocol["home.update_skin"] = function(coachSkins, skinTag)
  return {coachSkins = coachSkins, skin_tag = skinTag}
end
Protocol["home.load_template"] = function(preIndex)
  return {preIndex = preIndex}
end
Protocol["home.save_coach"] = function(preIndex, coachIds)
  return {preIndex = preIndex, coachIds = coachIds}
end
Protocol["home.collect_waste"] = function(coachId, uFid)
  return {coachId = coachId, uFid = uFid}
end
Protocol["battle.adventure"] = function(levelId)
  return {levelId = levelId}
end
Protocol["adventure.adv_info"] = function()
  return {}
end
Protocol["adventure.end_adv"] = function(advReward)
  return {advReward = advReward}
end
Protocol["pet.feed"] = function(petId)
  return {petId = petId}
end
Protocol["pet.interact"] = function(petId)
  return {petId = petId}
end
Protocol["pet.add_pet_favor"] = function(petId, itemAttr)
  return {petId = petId, itemAttr = itemAttr}
end
Protocol["pet.upgrade"] = function(petId)
  return {petId = petId}
end
Protocol["station.drink"] = function(index)
  return {index = index}
end
Protocol["main.add_energy"] = function(num)
  return {num = num}
end
Protocol["station.refresh"] = function(sid)
  return {sid = sid}
end
Protocol["station.security"] = function(levelId)
  return {levelId = levelId}
end
Protocol["building.level"] = function(buildingId)
  return {buildingId = buildingId}
end
Protocol["quest.list"] = function(type, sid)
  return {type = type, sid = sid}
end
Protocol["station.rep_reward"] = function(index)
  return {index = index}
end
Protocol["station.goods_info"] = function()
  return {}
end
Protocol["station.purchase_order"] = function(useNum, itemId)
  return {useNum = useNum, itemId = itemId}
end
Protocol["station.refresh_dicker"] = function()
  return {}
end
Protocol["equip.lock"] = function(lockedIds, unlockIds)
  return {lockedIds = lockedIds, unlockIds = unlockIds}
end
Protocol["equip.upgrade"] = function(equipId, costExp, equipList)
  return {
    equipId = equipId,
    costExp = costExp,
    equipList = equipList
  }
end
Protocol["equip.set_affix"] = function(equipId, affixIndex)
  return {equipId = equipId, affixIndex = affixIndex}
end
Protocol["equip.set_item_affix"] = function(equipId, itemId)
  return {equipId = equipId, itemId = itemId}
end
Protocol["hero.set_equip"] = function(roleId, equipId, unset)
  return {
    roleId = roleId,
    equipId = equipId,
    unset = unset
  }
end
Protocol["hero.save"] = function(roleId, equipList, preIndex)
  return {
    roleId = roleId,
    equipList = equipList,
    preIndex = preIndex
  }
end
Protocol["hero.load"] = function(roleId, preIndex)
  return {roleId = roleId, preIndex = preIndex}
end
Protocol["main.newbie_step"] = function()
  return {}
end
Protocol["station.invest"] = function(index)
  return {index = index}
end
Protocol["station.refresh_invest"] = function()
  return {}
end
Protocol["furniture.upgrade"] = function(uFid)
  return {uFid = uFid}
end
Protocol["main.rec_trust"] = function(index)
  return {index = index}
end
Protocol["main.read"] = function(anyId, type, failCb)
  return {
    anyId = anyId,
    type = type,
    failCb = failCb
  }
end
Protocol["furniture.redecorate"] = function(uFid, uSkin)
  return {uFid = uFid, uSkin = uSkin}
end
Protocol["home.update_auto"] = function(auto_repair, auto_maintain, auto_wash, auto_fuel)
  return {
    auto_repair = auto_repair,
    auto_maintain = auto_maintain,
    auto_wash = auto_wash,
    auto_fuel = auto_fuel
  }
end
Protocol["home.repair"] = function()
  return {}
end
Protocol["home.skip"] = function()
  return {}
end
Protocol["home.get_coach"] = function()
  return {}
end
Protocol["home.expand"] = function()
  return {}
end
Protocol["home.maintain"] = function()
  return {}
end
Protocol["home.wash"] = function()
  return {}
end
Protocol["plot.info"] = function()
  return {}
end
Protocol["plot.dialog"] = function(paragraphId)
  return {paragraphId = paragraphId}
end
Protocol["plot.note"] = function(paragraphId)
  return {paragraphId = paragraphId}
end
Protocol["pet.check_in"] = function(petId, uFid)
  return {petId = petId, uFid = uFid}
end
Protocol["pet.bind"] = function(petId, roleId)
  return {petId = petId, roleId = roleId}
end
Protocol["pet.food"] = function(material, uFid)
  return {material = material, uFid = uFid}
end
Protocol["pet.feed"] = function(petId, material)
  return {material = material, petId = petId}
end
Protocol["pet.interact"] = function(petId, uFid)
  return {uFid = uFid, petId = petId}
end
Protocol["pet.rename"] = function(petId, name)
  return {petId = petId, name = name}
end
Protocol["furniture.rename"] = function(uFid, name)
  return {uFid = uFid, name = name}
end
Protocol["home.update_coach_name"] = function(coachName, userCid)
  return {coachName = coachName, userCid = userCid}
end
Protocol["station.expand_warehouse"] = function(num)
  return {num = num}
end
Protocol["station.build_extra_warehouse"] = function(num, index)
  return {num = num, index = index}
end
Protocol["station.deal_with_goods"] = function(storageArr, getArr)
  return {storageArr = storageArr, getArr = getArr}
end
Protocol["station.special_goods"] = function()
  return {}
end
Protocol["meal.fried_chicken"] = function(foodId, roleId)
  return {foodId = foodId, roleId = roleId}
end
Protocol["hero.change_skin"] = function(hid, skinId, isSpan2)
  return {
    hid = hid,
    skinId = skinId,
    isSpan2 = isSpan2
  }
end
Protocol["hero.change_span"] = function(hid, spineId)
  return {hid = hid, spanId = spineId}
end
Protocol["building.plot"] = function(buildingId)
  return {buildingId = buildingId}
end
Protocol["home.update_fuel"] = function()
  return {}
end
Protocol["events.happen"] = function(eventId, sid, index, failCb)
  return {
    eventId = eventId,
    sid = sid,
    selectIndex = index,
    failCb = failCb
  }
end
Protocol["events.assault"] = function(eventId, sid, currentSpeed, failCb)
  return {
    eventId = eventId,
    sid = sid,
    currentSpeed = currentSpeed,
    failCb = failCb
  }
end
Protocol["home.rank_reward"] = function(index)
  return {index = index}
end
Protocol["building.reward_level"] = function(buildingId, num)
  return {buildingId = buildingId, num = num}
end
Protocol["shop.recycle"] = function(shopId, goodId, itemId, num)
  return {
    shopId = shopId,
    goodId = goodId,
    itemId = itemId,
    num = num
  }
end
Protocol["home.refresh_coach"] = function()
  return {}
end
Protocol["home.rec_coach_waste"] = function(coachId)
  return {coachId = coachId}
end
Protocol["station.psg_source_info"] = function()
  return {}
end
Protocol["station.overprint_leaflet"] = function(num)
  return {num = num}
end
Protocol["station.attract_psg"] = function(sourceType, terminus, leaflet_num, cityPid, poolId)
  return {
    sourceType = sourceType,
    terminus = terminus,
    leaflet_num = leaflet_num,
    cityPid = cityPid,
    poolId = poolId
  }
end
Protocol["station.complete_order"] = function(orderIndex)
  return {orderIndex = orderIndex}
end
Protocol["station.get_stage_reward"] = function(conIndex, index, rewardType)
  return {
    conIndex = conIndex,
    index = index,
    rewardType = rewardType
  }
end
Protocol["station.refresh_order"] = function(orderIndex)
  return {orderIndex = orderIndex}
end
Protocol["station.mark_order"] = function(orderIndex)
  return {orderIndex = orderIndex}
end
Protocol["main.rank"] = function(rank_type, time_type, lv_sec, sid, peopleNum, friend, grid, bossId)
  if bossId == nil then
    bossId = ""
  end
  return {
    rank_type = rank_type,
    time_type = time_type,
    lv_sec = lv_sec,
    sid = sid,
    peopleNum = peopleNum,
    friend = friend,
    grid = grid,
    bossId = bossId
  }
end
Protocol["unification.world_pollute"] = function()
  return {}
end
Protocol["main.use_code"] = function(code, failCb)
  return {code = code, failCb = failCb}
end
Protocol["home.clean_status"] = function()
  return {}
end
Protocol["plot.note_noun"] = function(nounIds)
  return {nounIds = nounIds}
end
Protocol["home.cultivate"] = function(cultivate_choose)
  return {cultivate_choose = cultivate_choose}
end
Protocol["station.replenish"] = function()
  return {}
end
Protocol["adventure.set_flag"] = function(operId)
  return {opeId = operId}
end
Protocol["adventure.get_group"] = function(groupId)
  return {groupId = groupId}
end
Protocol["building.report_level"] = function(levelId)
  return {levelId = levelId}
end
Protocol["building.report_levels"] = function(buildingId)
  return {buildingId = buildingId}
end
Protocol["building.share_level"] = function(levelKey, payNum)
  return {levelKey = levelKey, payNum = payNum}
end
Protocol["building.cancel_share"] = function(levelKey)
  return {levelKey = levelKey}
end
Protocol["building.recommend_levels"] = function(buildingId)
  return {buildingId = buildingId}
end
Protocol["main.add_like"] = function(levelKey, receiver)
  return {levelKey = levelKey, receiver = receiver}
end
Protocol["building.receive"] = function(levelKey)
  return {levelKey = levelKey}
end
Protocol["station.park_reward"] = function(sid, isReceive)
  return {sid = sid, isReceive = isReceive}
end
Protocol["station.donate"] = function(index)
  return {index = index}
end
Protocol["station.get_stage_reward"] = function(conIndex, index, rewardType, rec_all)
  return {
    conIndex = conIndex,
    index = index,
    rewardType = rewardType,
    rec_all = rec_all
  }
end
Protocol["station.construction_info"] = function()
  return {}
end
Protocol["pay.biligame_order_str"] = function(productId, shopId, osType)
  return {
    productId = productId,
    shopId = shopId,
    osType = osType
  }
end
Protocol["pay.common_order_str"] = function(channelFg, productId, productName, accessToken, openId, ujoyChannel, steamId, language, currency, ptype)
  return {
    channelFg = channelFg,
    productId = productId,
    productName = productName,
    access_token = accessToken,
    openid = openId,
    ujoy_channel = ujoyChannel,
    steamid = steamId,
    language = language,
    currency = currency,
    ptype = ptype
  }
end
Protocol["pay.create_oid"] = function(productId, shopId, payType, needRealInfo)
  return {
    productId = productId,
    shopId = shopId,
    payType = payType,
    needRealInfo = needRealInfo
  }
end
Protocol["pay.dmm_charge_refresh"] = function(receipt, signature, failCb)
  return {
    receipt = receipt,
    signature = signature,
    failCb = failCb
  }
end
Protocol["pay.gp_charge_refresh"] = function(receipt, signature, failCb)
  return {
    receipt = receipt,
    signature = signature,
    failCb = failCb
  }
end
Protocol["pay.ios_charge_refresh"] = function(receipt, out_trade_no, transactionId, failCb)
  return {
    receipt = receipt,
    out_trade_no = out_trade_no,
    transactionId = transactionId,
    failCb = failCb
  }
end
Protocol["pay.steam_charge_refresh"] = function(out_trade_no)
  return {out_trade_no = out_trade_no}
end
Protocol["pay.order_str"] = function(productId, shopId)
  return {productId = productId, shopId = shopId}
end
Protocol["pay.query_oid"] = function(out_trade_no)
  return {out_trade_no = out_trade_no}
end
Protocol["pay.wx_query_appid"] = function(channelFg)
  return {channelFg = channelFg}
end
Protocol["pay.wx_order_str"] = function(productId, shopId, channelFg)
  return {
    productId = productId,
    shopId = shopId,
    channelFg = channelFg
  }
end
Protocol["pay.wcoin_charge_result"] = function(productId)
  return {productId = productId}
end
Protocol["home.make_train_weapon"] = function(trainWeaponId, coachWeaponId)
  return {trainWeaponId = trainWeaponId, coachWeaponId = coachWeaponId}
end
Protocol["building.expel_reward"] = function(listId, index)
  return {listId = listId, index = index}
end
Protocol["events.money_through"] = function(eventId)
  return {
    eventId = tostring(eventId)
  }
end
Protocol["main.festival_reward"] = function(index)
  return {index = index}
end
Protocol["main.cancel"] = function()
  return {}
end
Protocol["main.derive_account_gen"] = function()
  return {}
end
Protocol["main.derive_account_bind"] = function(password, password1)
  return {password = password, password1 = password1}
end
Protocol["events.bait_through"] = function(fail, eventId, num, itemId)
  return {
    failcb = fail,
    eventId = tostring(eventId),
    num = tostring(num),
    itemId = tostring(itemId)
  }
end
Protocol["hero.dress"] = function(hid, dresses)
  return {hid = hid, dresses = dresses}
end
Protocol["furniture.compound"] = function(uFid, formulaId, num)
  return {
    uFid = uFid,
    formulaId = formulaId,
    num = num
  }
end
Protocol["core.upgrade"] = function(coreId)
  return {coreId = coreId}
end
Protocol["station.note_pointer"] = function(id)
  return {pointerId = id}
end
Protocol["main.overview"] = function(kind, pgId)
  return {kind = kind, pgId = pgId}
end
Protocol["home.unlock_skin"] = function(skinId, coachId)
  return {skinId = skinId, coachId = coachId}
end
Protocol["hero.info"] = function(roleId)
  return {roleId = roleId}
end
Protocol["main.monthly_card"] = function()
  return {}
end
Protocol["home.upgrade_train_weapon"] = function(coachWeaponId)
  return {coachWeaponId = coachWeaponId}
end
Protocol["station.req_back"] = function(sid, select, coachSkins)
  return {
    sid = sid,
    select = select,
    coachSkins = coachSkins
  }
end
Protocol["hero.read"] = function(roleId)
  return {roleId = roleId}
end
Protocol["hero.open_resonance"] = function(hid, hStatus)
  return {r_status = hStatus, hid = hid}
end
Protocol["hero.open_awake"] = function(hid, hStatus)
  return {a_status = hStatus, hid = hid}
end
Protocol["book.read_enemy"] = function(enemyId)
  return {enemyId = enemyId}
end
Protocol["item.bargain"] = function(itemId)
  return {itemId = itemId}
end
Protocol["core.rec_reward"] = function(coreId, index)
  return {coreId = coreId, index = index}
end
Protocol["recruit.records"] = function(tagId, pageSize, pageNum)
  return {
    tagId = tagId,
    pageSize = pageSize,
    pageNum = pageNum
  }
end
Protocol["main.participate"] = function(activityId)
  return {activityId = activityId}
end
Protocol["main.red"] = function(activityId)
  return {activityId = activityId}
end
Protocol["book.top_card"] = function(packId)
  return {packId = packId}
end
Protocol["main.recv_activity"] = function(activityId, questId)
  return {qid = questId, activityId = activityId}
end
Protocol["main.get_activity_stage"] = function(activityId, stageType, stageIndex)
  return {
    activityId = activityId,
    stageType = stageType,
    stageIndex = stageIndex
  }
end
Protocol["home.unlock_drive_setup"] = function(setUpType)
  return {setUpType = setUpType}
end
Protocol["home.update_drive_setup"] = function(setUpType, status)
  return {setUpType = setUpType, status = status}
end
Protocol["pet.info"] = function(petIds)
  return {petIds = petIds}
end
Protocol["building.activity"] = function(buildingId)
  return {buildingId = buildingId}
end
Protocol["building.delivery"] = function(buildingId, itemId)
  return {buildingId = buildingId, itemId = itemId}
end
Protocol["prison.arrest_prisoner"] = function(wave_list, ticketNum)
  return {
    wave_list = wave_list,
    ticket_num = tonumber(ticketNum)
  }
end
Protocol["prison.imprisonment"] = function(u_pid_list)
  return {
    u_pid_list = Json.encode(u_pid_list)
  }
end
Protocol["prison.release"] = function(u_pid_list)
  return {
    u_pid_list = Json.encode(u_pid_list)
  }
end
Protocol["prison.modify_front"] = function(upload_master_info, upload_front_info, upload_programme_info)
  return {
    upload_master_info = upload_master_info,
    upload_front_info = upload_front_info,
    upload_programme_info = upload_programme_info
  }
end
Protocol["station.turntable_battle"] = function(sid)
  return {sid = sid}
end
Protocol["prison.refresh"] = function()
  return {}
end
Protocol["home.upgrade_back"] = function()
  return {}
end
Protocol["prison.unlock_front"] = function(workShopId)
  return {workShopId = workShopId}
end
Protocol["prison.up_ware"] = function(wareType, wareNum)
  return {wareType = wareType, wareNum = wareNum}
end
Protocol["main.store_client"] = function(logInfo)
  return {s_info = logInfo}
end
Protocol["prison.unload"] = function(materials, products)
  return {materials = materials, products = products}
end
Protocol["main.monthly_sign"] = function(signId, roles)
  return {signId = signId, roles = roles}
end
Protocol["main.sign_record"] = function(month)
  return {month = month}
end
Protocol["prison.in_production"] = function()
  return {}
end
Protocol["prison.open"] = function()
  return {}
end
Protocol["prison.building_orders"] = function(buildingId)
  return {buildingId = buildingId}
end
Protocol["prison.orders"] = function()
  return {}
end
Protocol["prison.record"] = function(buildingId, oIndex, status)
  return {
    buildingId = buildingId,
    oIndex = oIndex,
    status = status
  }
end
Protocol["prison.deliver"] = function(buildingId, oIndex)
  return {buildingId = buildingId, oIndex = oIndex}
end
Protocol["prison.refresh_order"] = function(buildingId, oIndex)
  return {buildingId = buildingId, oIndex = oIndex}
end
Protocol["prison.order_cost"] = function(buildingId, oIndex, refreshType)
  return {
    buildingId = buildingId,
    oIndex = oIndex,
    refreshType = refreshType
  }
end
Protocol["prison.big_orders_mian"] = function()
  return {}
end
Protocol["prison.remark_big_orders"] = function(op, orderId)
  return {op = op, orderId = orderId}
end
Protocol["prison.select_big_orders"] = function(orderId)
  return {orderId = orderId}
end
Protocol["prison.big_deliver"] = function(orderId, addNum)
  return {orderId = orderId, addNum = addNum}
end
Protocol["prison.recv_big_orders"] = function()
  return {}
end
Protocol["prison.unlock_workshop"] = function(buildingId, oIndex)
  return {}
end
Protocol["prison.solve_event"] = function(workShopId, gradId)
  return {workShopId = workShopId, gradId = gradId}
end
Protocol["prison.see_the_doctor"] = function(uPidList)
  return {uPidList = uPidList}
end
Protocol["prison.margin"] = function(addNum, isAuto)
  return {addNum = addNum, isAuto = isAuto}
end
Protocol["prison.margin_switch"] = function(margin_switch)
  return {margin_switch = margin_switch}
end
Protocol["quest.accept_quest"] = function(qid)
  return {qid = qid}
end
Protocol["quest.suspend_quest"] = function(qid)
  return {qid = qid}
end
Protocol["playground.decorate"] = function(pgId, ucId, locations)
  return {
    pgId = pgId,
    ucId = ucId,
    locations = locations
  }
end
Protocol["playground.upgrade"] = function(uFid, pgId)
  return {uFid = uFid, pgId = pgId}
end
Protocol["battle.dur_reward"] = function(levelId, index, sid)
  return {
    levelId = levelId,
    index = index,
    sid = sid
  }
end
Protocol["home.dismantle_coach"] = function(coachId)
  return {coachId = coachId}
end
Protocol["building.remove_level"] = function(buildingId, index)
  return {buildingId = buildingId, index = index}
end
Protocol["prison.employ_relieve_lawyer"] = function(operation, lawyerId)
  return {operation = operation, lawyerId = lawyerId}
end
Protocol["prison.refresh_lawyer_list"] = function()
  return {}
end
Protocol["prison.parole"] = function(uPidList)
  return {uPidList = uPidList}
end
Protocol["prison.start_build_room"] = function(roomTypeId, nextLv)
  return {roomTypeId = roomTypeId, nextLv = nextLv}
end
Protocol["prison.complete_build_room"] = function(roomTypeId, timeFaster)
  return {roomTypeId = roomTypeId, timeFaster = timeFaster}
end
Protocol["prison.faster_build_room"] = function(roomTypeId, cardItem)
  return {roomTypeId = roomTypeId, cardItem = cardItem}
end
Protocol["prison.parole"] = function(uPidList)
  return {uPidList = uPidList}
end
Protocol["prison.frisk"] = function(uPidList)
  return {uPidList = uPidList}
end
Protocol["prison.reset_report"] = function(filedName)
  return {filedName = filedName}
end
Protocol["battle.abyss_reward"] = function(abyssPeriod, index)
  return {abyssPeriod = abyssPeriod, index = index}
end
Protocol["playground.extend"] = function(pgId)
  return {pgId = pgId}
end
Protocol["prison.unlock_route"] = function(cityId)
  return {cityId = cityId}
end
Protocol["prison.unlock_fleet"] = function()
  return {}
end
Protocol["prison.transport_goods"] = function(cityId, fleetId, takeRawMaterial, takeProduct)
  return {
    cityId = cityId,
    fleetId = fleetId,
    takeRawMaterial = takeRawMaterial,
    takeProduct = takeProduct
  }
end
Protocol["prison.transport_prisoner"] = function(fleetId, uPidList)
  return {fleetId = fleetId, uPidList = uPidList}
end
Protocol["playground.levels"] = function(pgId)
  return {pgId = pgId}
end
Protocol["prison.gen_order"] = function(u_oid_list, operate_type)
  return {u_oid_list = u_oid_list, operate_type = operate_type}
end
Protocol["prison.add_purchase_order"] = function(useItems)
  return {useItems = useItems}
end
Protocol["playground.end_mini_game"] = function(uFid, completed, failCall)
  return {
    gameUid = uFid,
    completed = completed,
    fail = failCall
  }
end
Protocol["playground.playground_info"] = function(pgId)
  return {pgId = pgId}
end
Protocol["playground.publicity"] = function(pgId, pubPos, pubType, pubNum)
  return {
    pgId = pgId,
    pubPos = pubPos,
    pubType = pubType,
    pubNum = pubNum
  }
end
Protocol["playground.park_reward"] = function(isReceive, pgId)
  return {isReceive = isReceive, pgId = pgId}
end
Protocol["playground.invest"] = function(index)
  return {index = index}
end
Protocol["playground.start_mini_game"] = function(gameType, roles)
  return {gameType = gameType, roles = roles}
end
Protocol["prison.set_product_plant"] = function(workShopId, formulaGroupId, gradIdList, productCount)
  return {
    workShopId = workShopId,
    formulaGroupId = formulaGroupId,
    gradIdList = gradIdList,
    productCount = productCount
  }
end
Protocol["prison.pre_receive_product_plant"] = function(workShopId, gradIdList)
  return {workShopId = workShopId, gradIdList = gradIdList}
end
Protocol["prison.receive_product_plant"] = function(workShopId, gradIdList)
  return {workShopId = workShopId, gradIdList = gradIdList}
end
Protocol["activity.rec_return"] = function(activityId)
  return {activityId = activityId}
end
Protocol["activity.activate_buff"] = function(activityId, buffIds)
  return {activityId = activityId, buffIds = buffIds}
end
Protocol["activity.process_return"] = function(activityId, index)
  return {activityId = activityId, index = index}
end
Protocol["playground.add_mini_game_times"] = function(gameType, num)
  return {gameType = gameType, num = num}
end
Protocol["playground.refresh_coach"] = function(pgId)
  return {pgId = pgId}
end
Protocol["playground.rec_coach_waste"] = function(coachId, pgId)
  return {coachId = coachId, pgId = pgId}
end
Protocol["playground.clean_status"] = function(pgId)
  return {pgId = pgId}
end
Protocol["playground.clean"] = function(pgId, rec_all)
  return {pgId = pgId, rec_all = rec_all}
end
Protocol["prison.lv_awards"] = function(lv)
  return {lv = lv}
end
Protocol["prison.speed_product_plant"] = function(workShopId, speedItem)
  return {workShopId = workShopId, speedItem = speedItem}
end
Protocol["prison.complete_product_plant"] = function(workShopId, timeFaster)
  return {workShopId = workShopId, timeFaster = timeFaster}
end
Protocol["prison.speed_per_product_plant"] = function(workShopId, gradId, speedItem)
  return {
    workShopId = workShopId,
    gradId = gradId,
    speedItem = speedItem
  }
end
Protocol["prison.unlock_cell"] = function()
  return {}
end
Protocol["prison.unlock_cell_room"] = function(cellId, cellRoomId)
  return {cellId = cellId, cellRoomId = cellRoomId}
end
Protocol["prison.modify_front_raw_material"] = function(roomTypeId, uPidList)
  return {roomTypeId = roomTypeId, uPidList = uPidList}
end
Protocol["prison.start_product_raw_material"] = function(roomTypeId, formulaGroupId)
  return {roomTypeId = roomTypeId, formulaGroupId = formulaGroupId}
end
Protocol["prison.speed_product_raw_material"] = function(roomTypeId, speedItem)
  return {roomTypeId = roomTypeId, speedItem = speedItem}
end
Protocol["prison.stop_product_raw_material"] = function(roomTypeId)
  return {roomTypeId = roomTypeId}
end
Protocol["prison.pre_receive_raw_material"] = function(roomTypeId)
  return {roomTypeId = roomTypeId}
end
Protocol["prison.receive_raw_material"] = function(roomTypeId)
  return {roomTypeId = roomTypeId}
end
Protocol["prison.set_gold_raw_material"] = function(roomTypeId, gold)
  return {roomTypeId = roomTypeId, gold = gold}
end
Protocol["prison.set_power_socket"] = function()
  return {}
end
Protocol["building.entrust"] = function(entrustIds, index, roles)
  return {
    entrustIds = entrustIds,
    index = index,
    roles = roles
  }
end
Protocol["building.rec_entrust"] = function(entrustIds)
  return {entrustIds = entrustIds}
end
Protocol["building.cancel_entrust"] = function(entrustId)
  return {entrustId = entrustId}
end
Protocol["building.recall_entrust"] = function(entrustId)
  return {entrustId = entrustId}
end
Protocol["prison.release_settlement"] = function()
  return {}
end
Protocol["prison.up_extra_ware"] = function(wareType, wareNum)
  return {wareType = wareType, wareNum = wareNum}
end
Protocol["battle.chapter_level"] = function()
  return {}
end
Protocol["quest.stage_quests"] = function()
  return {}
end
Protocol["quest.rec_stage"] = function(index, stageId)
  return {index = index, stageId = stageId}
end
Protocol["friend.friends"] = function(pageSize, pageNum)
  return {pageSize = pageSize, pageNum = pageNum}
end
Protocol["friend.search"] = function(content)
  return {content = content}
end
Protocol["friend.add_request"] = function(uid)
  return {uid = uid}
end
Protocol["friend.delete"] = function(uid)
  return {uid = uid}
end
Protocol["friend.accept_request"] = function(uid)
  return {uid = uid}
end
Protocol["friend.refuse_request"] = function(uid)
  return {uid = uid}
end
Protocol["friend.recommend"] = function()
  return {}
end
Protocol["friend.remark"] = function(uid, content)
  return {uid = uid, content = content}
end
Protocol["friend.bond_other"] = function(invitationStr)
  return {invitationStr = invitationStr}
end
Protocol["friend.rcv_invitation_reward"] = function(uidList)
  return {uidList = uidList}
end
Protocol["friend.coach"] = function(uid)
  return {uid = uid}
end
Protocol["friend.steal_blocks"] = function(uid)
  return {uid = uid}
end
Protocol["friend.open_block"] = function(open)
  return {isOpen = open}
end
Protocol["friend.interact_pet"] = function(petId, uid, material)
  return {
    petId = petId,
    uid = uid,
    material = material
  }
end
Protocol["friend.detail"] = function(uid)
  return {uid = uid}
end
Protocol["main.contact"] = function(contact)
  return {contact = contact}
end
Protocol["main.set_card"] = function(cards)
  return {cards = cards}
end
Protocol["home.switch_sound"] = function(id)
  return {soundId = id}
end
Protocol["home.unlock_sound"] = function(id)
  return {soundId = id}
end
Protocol["prison.set_raw_workshop_pre_prisoner"] = function(roomTypeId, uPidList)
  return {roomTypeId = roomTypeId, uPidList = uPidList}
end
Protocol["prison.del_leave_replace"] = function(roomTypeId)
  return {roomTypeId = roomTypeId}
end
Protocol["prison.items_up_ware"] = function(wareType, useItem)
  return {wareType = wareType, useItem = useItem}
end
Protocol["station.update_goods_lock"] = function(lockedIds, unlockIds)
  return {lockedIds = lockedIds, unlockIds = unlockIds}
end
Protocol["station.get_warehouse_info"] = function()
  return {}
end
Protocol["main.revenue_record"] = function(otherUid)
  return {otherUid = otherUid}
end
Protocol["recruit.pool_info"] = function()
  return {}
end
Protocol["main.give_like"] = function(otherUid, likeType)
  return {otherUid = otherUid, likeType = likeType}
end
Protocol["prison.escape"] = function()
  return {}
end
Protocol["monopoly.monopoly_map"] = function(failCb)
  return {failCb = failCb}
end
Protocol["monopoly.use_dice"] = function(diceType, step, failCb)
  return {
    diceType = diceType,
    step = step,
    failCb = failCb
  }
end
Protocol["monopoly.move_position"] = function(gridMove, isTrap, failCb)
  return {
    gridMove = gridMove,
    isTrap = isTrap,
    failCb = failCb
  }
end
Protocol["monopoly.trigger_dialog_event"] = function(dialogId, gameResult, failCb)
  return {
    dialogId = dialogId,
    gameResult = gameResult,
    failCb = failCb
  }
end
Protocol["monopoly.com_grid"] = function(dialogId, failCb)
  return {dialogId = dialogId, failCb = failCb}
end
Protocol["monopoly.monopoly_invest"] = function(index, failCb)
  return {index = index, failCb = failCb}
end
Protocol["monopoly.grid_output"] = function(isReceive, failCb)
  return {isReceive = isReceive, failCb = failCb}
end
Protocol["monopoly.monopoly_rank_reward"] = function(isReceive, failCb)
  return {isReceive = isReceive, failCb = failCb}
end
Protocol["monopoly.get_subsidy"] = function(index, failCb)
  return {index = index, failCb = failCb}
end
Protocol["monopoly.monopoly_room"] = function(failCb)
  return {failCb = failCb}
end
Protocol["monopoly.boss_info"] = function(bossId, failCb)
  return {bossId = bossId, failCb = failCb}
end
Protocol["monopoly.recv_boss"] = function(bossId, failCb)
  return {bossId = bossId, failCb = failCb}
end
Protocol["monopoly.ask_boss_help"] = function(friendId, bossId, failCb)
  return {
    friendId = friendId,
    bossId = bossId,
    failCb = failCb
  }
end
Protocol["monopoly.help_boss_info"] = function(failCb)
  return {failCb = failCb}
end
Protocol["monopoly.recv_monopoly_lv_reward"] = function(index, failCb)
  return {index = index, failCb = failCb}
end
Protocol["monopoly.sign_up"] = function(isLater, failCb)
  return {isLater = isLater, failCb = failCb}
end
Protocol["monopoly.add_degree"] = function(num, failCb)
  return {num = num, failCb = failCb}
end
Protocol["monopoly.deal_box"] = function(isAbandon, failCb)
  return {isAbandon = isAbandon, failCb = failCb}
end
Protocol["monopoly.use_items"] = function(num, itemId, userId, boss_id, failCb)
  return {
    num = num,
    itemId = itemId,
    userId = userId,
    boss_id = boss_id,
    failCb = failCb
  }
end
Protocol["monopoly.grid_shop_buy"] = function(itemId, num)
  return {itemId = itemId, num = num}
end
Protocol["monopoly.mpy_refresh"] = function()
  return {}
end
Protocol["battle.end_challenge"] = function(gameUID, gameScore, trainDurable, goodsCosts, fuelNum, dur, failCall)
  return {
    kidUid = gameUID,
    score = gameScore,
    durable = trainDurable,
    goodsArr = goodsCosts,
    fuel = fuelNum,
    duration = dur,
    failCb = failCall
  }
end
Protocol["battle.start_challenge"] = function(kid, repair)
  return {kid = kid, repair = repair}
end
Protocol["battle.auto_repair"] = function(isOpen)
  return {isOpen = isOpen}
end
Protocol["main.after_index"] = function()
  return {}
end
Protocol["battle.melee"] = function()
  return {}
end
Protocol["battle.abandon"] = function()
  return {}
end
Protocol["battle.chose"] = function(roleIds, equipIds, header)
  return {
    roleIds = roleIds,
    equipIds = equipIds,
    header = header
  }
end
Protocol["battle.init_melee"] = function(num)
  return {num = num}
end
Protocol["battle.replace_equip"] = function(equipId, roleId, rbIndex)
  return {
    equipId = equipId,
    roleId = roleId,
    rbIndex = rbIndex
  }
end
Protocol["battle.box_reward"] = function(index)
  return {index = index}
end
Protocol["battle.add_help"] = function(roleStr)
  return {roles = roleStr}
end
Protocol["battle.help_list"] = function(pageSize, pageNum)
  return {pageNum = pageNum, pageSize = pageSize}
end
Protocol["battle.rec_help_reward"] = function()
  return {}
end
Protocol["battle.help_info"] = function(fid)
  return {fid = fid}
end
Protocol["activity.info"] = function(activityId)
  return {activityId = activityId}
end
Protocol["endless.activity_main"] = function(activityId)
  return {activityId = activityId}
end
Protocol["endless.rest_fail_team"] = function(activityId)
  return {activityId = activityId}
end
Protocol["endless.save_team"] = function(activityId, newTeam)
  return {activityId = activityId, newTeam = newTeam}
end
Protocol["activity.get_cs_activity"] = function()
  return {}
end
Protocol["station.off_line_drive"] = function()
  return {}
end
Protocol["activity.rec_cs_reward"] = function(activityId)
  return {activityId = activityId}
end
Protocol["cube.info"] = function()
  return {}
end
Protocol["cube.rotate"] = function(nextface)
  return {nextFace = nextface}
end
Protocol["cube.delete"] = function()
  return {}
end
Protocol["cube.move"] = function(pos)
  return {coord = pos}
end
Protocol["cube.event"] = function(pos)
  return {coord = pos}
end
Protocol["cube.trigger"] = function(opid)
  return {oplId = opid}
end
Protocol["cube.lose_bf"] = function(orderID, data)
  return {optionId = orderID, buffs = data}
end
Protocol["cube.lose_eq"] = function(orderID, data)
  return {optionId = orderID, equips = data}
end
Protocol["cube.refresh_buff"] = function(opid)
  return {packageId = opid}
end
Protocol["cube.select_package"] = function(packID, data)
  return {packageId = packID, choices = data}
end
Protocol["cube.start_round"] = function()
  return {}
end
Protocol["cube.replace_item"] = function(index)
  return {index = index}
end
Protocol["cube.option_pack"] = function(packID)
  return {oplId = packID}
end
Protocol["cube.deck"] = function(rids, header)
  return {rids = rids, header = header}
end
Protocol["cube.debuff"] = function(buffIds)
  return {buffIds = buffIds}
end
Protocol["cube.open_ui"] = function()
  return {}
end
Protocol["cube.chose_role"] = function(rids)
  return {rids = rids}
end
Protocol["cube.intensify"] = function(id)
  return {buffId = id}
end
Protocol["cube.team"] = function(teamId)
  return {
    team = tostring(teamId)
  }
end
Protocol["cube.end_rest"] = function()
  return {}
end
Protocol["cube.end_cube"] = function(isWin)
  return {
    fail = isWin and "0" or "1"
  }
end
Protocol["cube.difficulty"] = function(difficulty)
  return {
    difficulty = tostring(difficulty)
  }
end
Protocol["cube.rebirth"] = function(rids)
  return {rids = rids}
end
Protocol["cube.awake"] = function(hid)
  return {hid = hid}
end
Protocol["home.recv_train_weapon"] = function(weapon)
  return {weaponType = weapon}
end
Protocol["playground.fg_get_friend_list"] = function(pgId)
  return {pgId = pgId}
end
Protocol["playground.fg_friend_me_record"] = function(pgId)
  return {pgId = pgId}
end
Protocol["playground.fg_look"] = function(otherUid, pgId)
  return {otherUid = otherUid, pgId = pgId}
end
Protocol["playground.fg_give_like"] = function(otherUid, pgId)
  return {otherUid = otherUid, pgId = pgId}
end
Protocol["playground.fg_steal"] = function(otherUid, pgId)
  return {otherUid = otherUid, pgId = pgId}
end
Protocol["playground.fg_reward_list"] = function(receive)
  return {receive = receive}
end
Protocol["home.study"] = function(studyId)
  return {studyId = studyId}
end
Protocol["home.skip_study"] = function()
  return {}
end
Protocol["home.complete_studying"] = function()
  return {}
end
Protocol["activity.req_join"] = function(activityId, limitItem)
  return {activityId = activityId, limitItem = limitItem}
end
Protocol["activity.witches_info"] = function(cbFail)
  return {cbFail = cbFail}
end
Protocol["activity.buy_ticket"] = function(num)
  return {num = num}
end
Protocol["activity.select_init"] = function(initIndex)
  return {initIndex = initIndex}
end
Protocol["activity.left_func"] = function(funcType)
  return {funcType = funcType}
end
Protocol["activity.move_position"] = function(gridId)
  return {
    terminusGrid = tostring(gridId)
  }
end
Protocol["activity.deal_witches_events"] = function(dialogId, terminusGrid)
  return {dialogId = dialogId, terminusGrid = terminusGrid}
end
Protocol["activity.com_grid"] = function(dialogId)
  return {dialogId = dialogId}
end
Protocol["activity.select_reward"] = function(rewardType, selectIndex, num)
  return {
    rewardType = rewardType,
    selectIndex = selectIndex,
    num = num
  }
end
Protocol["activity.give_up_dialog"] = function(dialogId, levelId)
  return {dialogId = dialogId, levelId = levelId}
end
Protocol["activity.use_items"] = function(itemId, num, terminusGrid, dialogId, levelId)
  return {
    num = num,
    itemId = itemId,
    terminusGrid = terminusGrid,
    dialogId = dialogId,
    levelId = levelId
  }
end
Protocol["activity.buy_and_use_items"] = function(buyType, dialogId, levelId)
  return {
    buyType = buyType,
    dialogId = dialogId,
    levelId = levelId
  }
end
Protocol["activity.upgrade"] = function(gukaId)
  return {
    gukaId = tostring(gukaId)
  }
end
Protocol["activity.decorate"] = function(gukaLoc)
  return {gukaLoc = gukaLoc}
end
Protocol["activity.refresh_select"] = function()
  return {}
end
Protocol["activity.replace_seal"] = function(sealStr)
  return {
    sealStr = tostring(sealStr)
  }
end
Protocol["book.buff_reward"] = function(index)
  return {
    index = tostring(index)
  }
end
Protocol["book.equip_reward"] = function(index)
  return {
    index = tostring(index)
  }
end
Protocol["book.event_reward"] = function(index)
  return {
    index = tostring(index)
  }
end
Protocol["book.item_reward"] = function(index)
  return {
    index = tostring(index)
  }
end
Protocol["cube.books"] = function(cbFail)
  return {cbFail = cbFail}
end
Protocol["main.cumulative_reward"] = function(index, rec_all, activityId)
  return {
    index = index,
    rec_all = rec_all,
    activityId = activityId
  }
end
Protocol["activity.deal_guka_upgrade"] = function()
  return {}
end
Protocol["cube.unlock_outside"] = function(index)
  return {index = index}
end
Protocol["future.main"] = function()
  return {}
end
Protocol["future.lock_normal"] = function(orderUid, lockVal)
  return {
    orderUid = tostring(orderUid),
    lockVal = lockVal
  }
end
Protocol["future.being_invite_list"] = function()
  return {}
end
Protocol["future.can_invite_list"] = function(orderUid)
  return {
    orderUid = tostring(orderUid)
  }
end
Protocol["future.hall"] = function(sortType)
  return {orderType = sortType}
end
Protocol["future.join_my_order"] = function(orderUid)
  return {
    orderUid = tostring(orderUid)
  }
end
Protocol["future.join_other_order"] = function(orderUid, op)
  return {
    orderUid = tostring(orderUid),
    op = op
  }
end
Protocol["future.deliver_grad_normal_order"] = function(orderUid)
  return {
    orderUid = tostring(orderUid)
  }
end
Protocol["future.deliver_team_order"] = function(orderUid, itemList)
  return {
    orderUid = tostring(orderUid),
    itemList = itemList
  }
end
Protocol["future.invite"] = function(orderUid, fidList)
  return {
    orderUid = tostring(orderUid),
    fidList = fidList
  }
end
Protocol["future.open"] = function(orderUid, isOpen)
  return {
    orderUid = tostring(orderUid),
    isOpen = isOpen
  }
end
Protocol["future.reset_order"] = function(gradId, itemType)
  return {
    gradId = tostring(gradId),
    itemType = itemType
  }
end
Protocol["future.rec_reward_team_order"] = function(orderUid)
  return {
    orderUid = tostring(orderUid)
  }
end
Protocol["cube.lv_reward"] = function()
  return {}
end
Protocol["cube.weekly_reward"] = function()
  return {}
end
Protocol["main.rec_activity_month_card"] = function()
  return {}
end
Protocol["cube.use_items"] = function(itemId, index)
  return {itemId = itemId, index = index}
end
Protocol["activity.rec_weekly_act"] = function(activityId, index, rec_all)
  return {
    activityId = activityId,
    index = index,
    rec_all = rec_all
  }
end
Protocol["quest.rec_all_daily_quests"] = function()
  return {}
end
Protocol["main.roll_rank"] = function(rank_type, time_type, lv_sec, people_num, request_id, next_index, bossId, friend)
  if bossId == nil then
    bossId = ""
  end
  if friend == nil then
    friend = 0
  end
  return {
    rank_type = rank_type,
    time_type = time_type,
    lv_sec = lv_sec,
    people_num = people_num,
    request_id = request_id,
    next_index = next_index,
    bossId = bossId,
    friend = friend
  }
end
Protocol["future.levy_activity_main"] = function(activityId)
  return {
    activityId = tostring(activityId)
  }
end
Protocol["future.levy_exchange"] = function(activityId)
  return {
    activityId = tostring(activityId)
  }
end
Protocol["future.levy_rec"] = function(activityId, rewardPos)
  return {
    activityId = tostring(activityId),
    rewardPos = tonumber(rewardPos)
  }
end
Protocol["future.kick_queue"] = function(orderUid, kickUid)
  return {
    orderUid = tostring(orderUid),
    kickUid = tostring(kickUid)
  }
end
Protocol["future.exit_queue"] = function(orderUid)
  return {
    orderUid = tostring(orderUid)
  }
end
Protocol["future.remove_being_kick_order"] = function(orderUid)
  return {
    orderUid = tostring(orderUid)
  }
end
Protocol["prison.solve_event_all"] = function()
  return {}
end
Protocol["friend.block_record"] = function()
  return {}
end
Protocol["activity.get_boss_info"] = function(id)
  return {activityId = id}
end
Protocol["activity.buy_boss_times"] = function(aid, num)
  return {activityId = aid, num = num}
end
Protocol["activity.recv_boss"] = function(aid, bid, idx)
  return {
    activityId = aid,
    bossId = bid,
    r_index = idx
  }
end
Protocol["main.package_reward"] = function()
  return {}
end
Protocol["monopoly.property_purchase"] = function()
  return {}
end
Protocol["monopoly.build"] = function(buildingId)
  return {buildingId = buildingId}
end
Protocol["monopoly.upgrade_building"] = function()
  return {}
end
Protocol["monopoly.abandon_land"] = function(gridId)
  return {gridId = gridId}
end
Protocol["main.sign_values"] = function()
  return {}
end
Protocol["main.value_reward"] = function(productId, index, rec_all)
  return {
    productId = productId,
    index = index,
    rec_all = rec_all
  }
end
Protocol["main.set_music_attitude"] = function(id, op)
  return {music_id = id, like = op}
end
Protocol["main.main"] = function()
  return {}
end
Protocol["turntable.info"] = function()
  return {}
end
Protocol["turntable.turn"] = function(num, activityId)
  return {num = num, activityId = activityId}
end
Protocol["hero.lv_break"] = function(hid, lvNum)
  return {hid = hid, lvNum = lvNum}
end
Protocol["station.good_lv_up"] = function(goodQuotationId, nextLv)
  return {goodQuotationId = goodQuotationId, nextLv = nextLv}
end
Protocol["station.goods"] = function(sid, goodId)
  return {sid = sid, goodId = goodId}
end
Protocol["station.good_lv_dt"] = function()
  return {}
end
Protocol["furniture.furniture"] = function()
  return {}
end
Protocol["deck.deck_equip"] = function(equipCode, equipKey)
  return {equipCode = equipCode, equipKey = equipKey}
end
Protocol["unification.world_event"] = function()
  return {}
end
Protocol["unification.refresh_scan"] = function()
  return {}
end
Protocol["wasteland.info"] = function()
  return {}
end
Protocol["wasteland.solve"] = function(coord, eventId)
  return {coord = coord, eventId = eventId}
end
Protocol["wasteland.move"] = function(coord, direction)
  return {coord = coord, direction = direction}
end
Protocol["deck.deck_equip"] = function(equipCode, equipKey)
  return {equipCode = equipCode, equipKey = equipKey}
end
Protocol["shop.bar_shop"] = function(failCb)
  return {failCb = failCb}
end
Protocol["equip.eq_break"] = function(equipId, costs)
  return {equipId = equipId, costs = costs}
end
Protocol["hero.hair_dye"] = function(itemId, dressId, defaultId)
  return {
    itemId = itemId,
    dressId = dressId,
    defaultId = defaultId
  }
end
Protocol["hero.hair_use"] = function(hairTag, dressId, defaultId)
  return {
    hairTag = hairTag,
    dressId = dressId,
    defaultId = defaultId
  }
end
Protocol["station.query_goods"] = function(sid, goodIds)
  return {sid = sid, goodIds = goodIds}
end
Protocol["quest.complete_quest"] = function(qid)
  return {qid = qid}
end
Protocol["equip.eq_break"] = function(equipId, costs)
  return {equipId = equipId, costs = costs}
end
return Protocol
