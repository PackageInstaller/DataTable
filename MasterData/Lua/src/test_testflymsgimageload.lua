local TestFlyMsgImageLoad = {}

function TestFlyMsgImageLoad.testAchievement()
  AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.achievement, 4010007)
  print("[TestFlyMsg] 已触发成就弹窗测试")
end

function TestFlyMsgImageLoad.testActivity()
  local popup = {
    describe = "测试活跃任务",
    count = 5,
    reward = "100经验",
    maxStage = 3,
    curStage = 2,
    targetCount = 10
  }
  AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.activity, popup)
  print("[TestFlyMsg] 已触发活跃任务弹窗测试")
end

function TestFlyMsgImageLoad.testHomeContentUnlock()
  AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.homeContentUnlock, L_HomeConst.HomeLevelUnlockModuleType.Building)
  print("[TestFlyMsg] 已触发家园内容解锁弹窗测试")
end

function TestFlyMsgImageLoad.testPetEatFinish()
  local petList = L_PetStore:getPetList()
  if petList and 0 < #petList then
    local petEatInfo = CS.Protocal.Cs.PetEatInfo()
    petEatInfo.petGuid = petList[#petList].guid
    petEatInfo.foodId = 355005
    AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.petEatFinishMsg, petEatInfo)
    print("[TestFlyMsg] 已触发宠物进食完成弹窗测试")
  else
    print("[TestFlyMsg] 没有可用的宠物，跳过宠物进食测试")
  end
end

function TestFlyMsgImageLoad.testPetFavorLevelUp()
  local petList = L_PetStore:getPetList()
  local petId = 500026
  for i = 1, #petList do
    if petList[i].id == petId then
      local info = CS.Lens.Gameplay.UI.FlymsgPetFavorLevelUp.PetFavorLevelUpMsg()
      info.petGuid = petList[i].guid
      info.isLeft = true
      AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.petFavorLevelUpMsg, info)
      print("[TestFlyMsg] 已触发宠物羁绊升级弹窗测试")
      return
    end
  end
  print("[TestFlyMsg] 没有可用的宠物，跳过宠物羁绊升级测试")
end

function TestFlyMsgImageLoad.testMountRidingUnlock()
  local petList = L_PetStore:getPetList()
  local petId = 500026
  for i = 1, #petList do
    if petList[i].id == petId then
      AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.mountRidingUnlock, petList[i].guid)
      print("[TestFlyMsg] 已触发骑乘解锁弹窗测试")
      return
    end
  end
  print("[TestFlyMsg] 没有可用的宠物，跳过骑乘解锁测试")
end

function TestFlyMsgImageLoad.testGetPet()
  local petList = L_PetStore:getPetList()
  if petList and 0 < #petList then
    local petItem = petList[#petList]
    AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.getPet, petItem)
  else
    print("[TestFlyMsg] 没有可用的宠物，跳过获取宠物测试")
  end
end

function TestFlyMsgImageLoad.testPetCatalog()
  local petList = L_PetStore:getPetList()
  if petList and 0 < #petList then
    local petItem = petList[1]
    local tipInfo = {
      pet = petItem,
      petId = petItem.id,
      isGetPet = true,
      isLvChange = false,
      oldLv = 1,
      catalogLv = 2,
      oldExp = 50,
      newExp = 100,
      newTaskTxt = "测试任务"
    }
    AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.petCatalog, tipInfo)
    print("[TestFlyMsg] 已触发宠物图鉴弹窗测试")
  else
    print("[TestFlyMsg] 没有可用的宠物，跳过宠物图鉴测试")
  end
end

function TestFlyMsgImageLoad.testPetGeneMutation()
  local petList = L_PetStore:getPetList()
  if petList and 0 < #petList then
    local petItem = petList[1]
    local info = {
      guid = petItem.guid,
      isNew = true
    }
    AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.petGeneMutation, info)
    print("[TestFlyMsg] 已触发宠物基因突变弹窗测试")
  else
    print("[TestFlyMsg] 没有可用的宠物，跳过宠物基因突变测试")
  end
end

function TestFlyMsgImageLoad.testRewardMsg()
  local itemType = L_Const.resType.commonItem
  local itemId = 313011
  local itemNum = 10
  L_FlyMsgManager:showCommonRewardMsg(itemType, itemId, itemNum)
  print("[TestFlyMsg] 已触发奖励弹窗测试")
end

function TestFlyMsgImageLoad.testRewardManager()
  local itemType = L_Const.resType.commonItem
  local itemId = 313011
  local itemNum = 10
  L_FlyMsgManager:showCommonRewardMsg(itemType, itemId, itemNum)
  print("[TestFlyMsg] 已触发奖励弹窗测试")
end

function TestFlyMsgImageLoad.testNormalMsg()
  L_FlyMsgManager:showNormalMsg("这是一条测试消息")
  print("[TestFlyMsg] 已触发普通消息弹窗测试")
end

function TestFlyMsgImageLoad.testJourneyTaskComplete()
  local taskId = 992002
  AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.journeyTaskComplete, taskId)
  print("[TestFlyMsg] 已触发旅途任务完成弹窗测试")
end

function TestFlyMsgImageLoad.testJourneyUnlock()
  AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.journeyUnlock, 101)
  print("[TestFlyMsg] 已触发旅途解锁弹窗测试")
end

function TestFlyMsgImageLoad.testScienceExpTip()
end

function TestFlyMsgImageLoad.testPetFavorable()
end

function TestFlyMsgImageLoad.testTaskTip()
  AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.taskTip, {taskId = 816023, isOver = false})
  print("[TestFlyMsg] 已触发任务提示弹窗测试")
end

function TestFlyMsgImageLoad.testLibrarybook()
  local libraryReadingsId = 10002
  AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.libraryBook, libraryReadingsId)
  print("[TestFlyMsg] 已触发图书馆书籍弹窗测试")
end

function TestFlyMsgImageLoad.testPetLaborGrade()
  local petList = L_PetStore:getPetList()
  if petList and 0 < #petList then
    local petItem = petList[1]
    local tipInfo = {
      guid = petItem.guid,
      laborId = 1,
      laborInfo = {laborGrade = 3},
      petId = petItem.id,
      lastExp = 50,
      laborGrade = 3,
      laborGradeAdd = 1,
      upperLaborGrade = 100
    }
    AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.petLaborGrade, tipInfo)
    print("[TestFlyMsg] 已触发宠物劳动等级弹窗测试")
  else
    print("[TestFlyMsg] 没有可用的宠物，跳过宠物劳动等级测试")
  end
end

function TestFlyMsgImageLoad.testAllSequential()
  local tests = {
    {
      name = "NormalMsg",
      func = TestFlyMsgImageLoad.testNormalMsg
    },
    {
      name = "Achievement",
      func = TestFlyMsgImageLoad.testAchievement
    },
    {
      name = "Activity",
      func = TestFlyMsgImageLoad.testActivity
    },
    {
      name = "HomeContentUnlock",
      func = TestFlyMsgImageLoad.testHomeContentUnlock
    },
    {
      name = "GetPet",
      func = TestFlyMsgImageLoad.testGetPet
    },
    {
      name = "RewardMsg",
      func = TestFlyMsgImageLoad.testRewardMsg
    },
    {
      name = "MountRidingUnlock",
      func = TestFlyMsgImageLoad.testMountRidingUnlock
    },
    {
      name = "JourneyTaskComplete",
      func = TestFlyMsgImageLoad.testJourneyTaskComplete
    },
    {
      name = "JourneyUnlock",
      func = TestFlyMsgImageLoad.testJourneyUnlock
    },
    {
      name = "PetFavorable",
      func = TestFlyMsgImageLoad.testPetFavorable
    },
    {
      name = "TaskTip",
      func = TestFlyMsgImageLoad.testTaskTip
    },
    {
      name = "Librarybook",
      func = TestFlyMsgImageLoad.testLibrarybook
    },
    {
      name = "PetLaborGrade",
      func = TestFlyMsgImageLoad.testPetLaborGrade
    }
  }
  local index = 1
  
  local function runNext()
    if index > #tests then
      print("[TestFlyMsg] ========== 所有测试完成 ==========")
      return
    end
    local test = tests[index]
    print(string.format("[TestFlyMsg] ========== 开始测试 %s (%d/%d) ==========", test.name, index, #tests))
    local success, err = pcall(test.func)
    if not success then
      print(string.format("[TestFlyMsg] %s 测试失败: %s", test.name, tostring(err)))
    end
    index = index + 1
    Timer.once(3, runNext)
  end
  
  runNext()
end

function TestFlyMsgImageLoad.testAllParallel()
  print("[TestFlyMsg] ========== 开始并行测试 ==========")
  pcall(TestFlyMsgImageLoad.testAchievement)
  pcall(TestFlyMsgImageLoad.testJourneyTaskComplete)
  pcall(TestFlyMsgImageLoad.testJourneyUnlock)
  pcall(TestFlyMsgImageLoad.testPetFavorable)
  pcall(TestFlyMsgImageLoad.testTaskTip)
  pcall(TestFlyMsgImageLoad.testLibrarybook)
  pcall(TestFlyMsgImageLoad.testPetLaborGrade)
  pcall(TestFlyMsgImageLoad.testPetEatFinish)
  pcall(TestFlyMsgImageLoad.testPetFavorLevelUp)
  pcall(TestFlyMsgImageLoad.testMountRidingUnlock)
  pcall(TestFlyMsgImageLoad.testGetPet)
  pcall(TestFlyMsgImageLoad.testPetCatalog)
  pcall(TestFlyMsgImageLoad.testPetGeneMutation)
  pcall(TestFlyMsgImageLoad.testRewardMsg)
  pcall(TestFlyMsgImageLoad.testNormalMsg)
  print("[TestFlyMsg] ========== 并行测试触发完成 ==========")
end

return TestFlyMsgImageLoad
