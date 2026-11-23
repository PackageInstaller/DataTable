






local this = {
    vm=nil,
    data= {
        color_red = UnityEngine.Color(173 / 255, 36 / 255, 30 / 255, 1),
        color_green = UnityEngine.Color(0 / 255, 141 / 255, 122 / 255, 1),
        color_yellow = UnityEngine.Color(195 / 255, 144 / 255, 55 / 255, 1),
        cardContentRect=nil,
        tweener=nil,
        dungeonNameSpriteStr = "",
        dungeonNameImg = nil,
        dungeonNameWheelImg = nil,
        page4Tr = nil,
        themeName = "",
    }
};

local dataTowerRecords={};
local dataTower={};
local dataRewards={};
local isUnlockWeek=false;
local isWheeling=false;
local weekLeftTime = 0
local isShowSwitchBtn = false

local towerCfgMultiList = { {}, {}, {}, {} }
local curTowerCfgList = { nil, nil, nil, nil }
local curTowerIndex = { nil, nil, nil, nil }
local curPageIndex = 0
local curWeekDungeonIdList = {}

local data = {
  norList={
      {isLock=false,isNor=false,isHigh=false,pos=Vector2(546,0),fxPos=Vector2(510,0)},
      {isLock=false,isNor=false,isHigh=false,pos=Vector2(682,0),fxPos=Vector2(660,0)},
      {isLock=false,isNor=false,isHigh=false,pos=Vector2(827,0),fxPos=Vector2(827,0)},
      {isLock=false,isNor=false,isHigh=false,pos=Vector2(1034,0),fxPos=Vector2(990,0)},
      {isLock=false,isNor=false,isHigh=false,pos=Vector2(1114,0),fxPos=Vector2(1114,0)},
      {isLock=false,isNor=false,isHigh=false,pos=Vector2(1242,0),fxPos=Vector2(1230,0)},
      {isLock=false,isNor=false,isHigh=false,pos=Vector2(1304,0),fxPos=Vector2(1320,0)},
      {isLock=false,isNor=false,isHigh=false,pos=Vector2(1445,0),fxPos=Vector2(1440,0)},
      {isLock=false,isNor=false,isHigh=false,pos=Vector2(1576,0),fxPos=Vector2(1590,0)},
      {isLock=false,isNor=false,isHigh=false,pos=Vector2(1723,0),fxPos=Vector2(1700,0)},
      {isLock=false,isNor=false,isHigh=false,pos=Vector2(1870,0),fxPos=Vector2(1850,0)},
      {isLock=false,isNor=false,isHigh=false,pos=Vector2(2045,0),fxPos=Vector2(2045,0)},
  },
  norList_2={
      {isHigh=false},
      {isHigh=false},
  },
  upLevelName="",
  downLevelName="",
  timer="",
  leftTime = "",
  isUpLevel=true;
  isDownLevel=true;
  isWheel=false,
  isNotWheel=true,
  isEnter = false,
  curDungeonName="",
  isSwitchFx=false,
  isScrollRect_Inertia=true,
  curDungeonSprite=DefaultSprite,
  curDungeonBigSprite=DefaultSprite,
  curDungeonNumSprite=DefaultSprite,
  heroList={
      {
          iconTexture = DefaultTexture,
          jobSprite = DefaultSprite,
          level = "",
          hpSlider = 0.0,
          isUp = false,
          isDown = false,
          isUpDown=false,
          lockSprite = DefaultSprite,
          isLock = false,
          isHp=false,
          color=this.data.color_green,
          isPro=false;
          proList={};
      }
  },
  proItemList={
      {
          isOn=false;
          sizeData=Vector2.zero;
      }
  },
  
  cardFx_Pos=Vector2(0,0),
  
  isShowSwitchBtn = false,
  isShowSwitchList = false,
  isShowPage_1 = false,
  isShowPage_2 = false,
  isShowPage_3 = false,
  isShowPage_4 = false,
  isShowPage_23 = false,
  isNotShowPage_1 = false,
  switchBtnList = {
      { active = false, select = false, lock = false },
      { active = false, select = false, lock = false },
      { active = false, select = false, lock = false },
      { active = false, select = false, lock = false },
  },
  
  switchBtnWeeklyIcon = DefaultSprite,
  
  showCommonEffect = false,
  showStageRewardBtn = false,
}

local command = {
    upLevelBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if isWheeling then return end;
            curTowerIndex[curPageIndex]=curTowerIndex[curPageIndex]-1;
            this.vm.data.isScrollRect_Inertia=false;
            this.UpdateTowerListState();
        end
    },
    downLevelBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if isWheeling then return end;
            curTowerIndex[curPageIndex]=curTowerIndex[curPageIndex]+1;
            this.vm.data.isScrollRect_Inertia=false;
            this.UpdateTowerListState();
        end
    },
    levelItemBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param);
            local curIndex = curTowerIndex[curPageIndex]
            if curIndex==index then return end;
            if isWheeling then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrainingTowerViewModel_3"));
                return
            end
            curTowerIndex[curPageIndex] = index
            math.randomseed(os.time());
            local index=math.random(1,4)
            local audioName=string.format("newUI/climb_click-00%s.mp3",index);
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. audioName);
            this.UpdateTowerListState();
        end
    },
    enterBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local groupId, curIndex
            if curPageIndex == 1 then
                if this.vm.data.norList[curTowerIndex[curPageIndex]].isLock then
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TrainingTowerViewModel_0"))
                    return;
                end
            end
            curIndex = curTowerIndex[curPageIndex]
            groupId = towerCfgMultiList[curPageIndex][curIndex].GroupId

            if curPageIndex == 3 then
                curIndex = 3 - curIndex
            end
            if groupId==nil then return end;
            LuaMgr.ShowLuaPanel(UIName.TrainingTowerChoiceViewModel, groupId, this.data.dungeonNameSpriteStr);
            TrainingTowerHelper.curPageIndex = curPageIndex
            TrainingTowerHelper.curTowerCfgList = curTowerCfgList
        end
    },
    resetBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,LuaMgr.GetLangText("TrainingTowerViewModel_1"),function()
                local askData={};
                ApiMgr.Request("tower2/drop",askData,true,function(re)
                    isWheeling=false;
                    TrainingTowerHelper.ClearCurTowerCache()
                    this.ParseData();
                end,nil,true)
                HeroParameter.trainingBattleDungeonId=nil;
            end,function()  end)
        end
    },
    
    continueBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          local groupId=DataMgr.Player.Tower.GroupId;
          if groupId==nil then return end;
          local curIndex = curTowerIndex[curPageIndex]

          if curPageIndex == 3 then
              curIndex = 3 - curIndex
          end
          TrainingTowerHelper.ClearCurTowerCache()
          LuaMgr.ShowLuaPanel(UIName.TrainingTowerLevelViewModel,groupId,this.data.dungeonNameSpriteStr);
      end
    },
    switchBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.isShowSwitchList = not this.vm.data.isShowSwitchList
            this.vm.data.isShowSwitchBtn = not this.vm.data.isShowSwitchList
            local redCount,redID = TrainingTowerHelper.GetTimeRedCount()
            RedMgr.Singleton:SetRedState(redID, redCount)
        end
    },
    switchListItemBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param);
            curPageIndex = index
            for i,v in ipairs(this.vm.data.switchBtnList) do
                v.select = i==curPageIndex;
            end
            local redID, redID1 = "15110", "15110_1"
            RedMgr.Singleton:FrushRedCondition(redID)
            RedMgr.Singleton:FrushRedCondition(redID1)
            RedMgr.Singleton:UpdateClientRedData(redID, 0)
            RedMgr.Singleton:UpdateClientRedData(redID1, 0)
            RedMgr.Singleton:SetRedState(redID, 0)
            this.ShowCurPage()
        end
    },
    stageRewardCommand={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if #curWeekDungeonIdList > 0 then
                LuaMgr.ShowLuaPanel(UIName.TrainingTowerStageRewardPopup, curWeekDungeonIdList)
            end
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        local tf=vm.behaviour.transform;
        this.data.cardContentRect=vm.behaviour.transform:Find("root/page_1/Scroll View/Viewport/Content"):GetComponent("RectTransform");
        this.data.page4Tr = vm.behaviour.transform:Find("root/page_4/content")
        this.data.dungeonNameImg = vm.behaviour.transform:Find("root/Middle/week/Name/X"):GetComponent("Image");
        this.data.dungeonNameWheelImg = vm.behaviour.transform:Find("root/Left_1/wheel/weekInfo/name_week/X"):GetComponent("Image");
        RedMgr.Singleton:RegisterViewModel(UIName.TrainingTowerViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.Init()
        local isWeekExpired = TrainingTowerHelper.CheckWeekTowerExpired()
        if isWeekExpired then
            if isWeekExpired ~= TrainingTowerHelper.isWeekExpired then
                TrainingTowerHelper.ClearCurTowerCache()
            end
            TrainingTowerHelper.OnAskGetCurrentRotation(function()
                this.ParseData();
            end)
        else
            this.ParseData();
        end
        local redCount = TrainingTowerHelper.GetTimeRedCount()
        RedMgr.Singleton:SetRedState("15110", redCount)
        TrainingTowerHelper.isWeekExpired = isWeekExpired
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.TrainingLeftTimer)
    end,
    before_destroy=function(vm)
        towerCfgMultiList = { {}, {}, {}, {} }
        curTowerCfgList = { nil, nil, nil, nil }
        curTowerIndex = { nil, nil, nil, nil }
        curWeekDungeonIdList = {}
        this.data=nil;
    end
}

this.Init = function()
    if TrainingTowerHelper~=nil then
        TrainingTowerHelper.ClearCache();
    end
    this.vm.data.isShowSwitchBtn = false
    this.vm.data.isShowSwitchList = false
    this.vm.data.isShowPage_1 = false
    this.vm.data.isShowPage_2 = false
    this.vm.data.isShowPage_3 = false
    this.vm.data.isShowPage_4 = false
    this.vm.data.isNotWheel = false
    this.vm.data.isWheel = false
    this.vm.data.showStageRewardBtn = false
end

this.InitTowerList = function()
    towerCfgMultiList = { {}, {}, {}, {} }
    local cfgTower=ConfigMgr.Config.BattleTowerMap
    for i,v in pairs(cfgTower) do
        if v.RotationType == 1 then
            table.insert(towerCfgMultiList[1], v)
        end
    end
    for i = 1, #towerCfgMultiList do
        table.sort(towerCfgMultiList[i], function(a, b) return a.GroupId<b.GroupId end)
    end
    local isPassPage_1 = this.CheckPassPage_1();
    towerCfgMultiList = { {}, {}, {}, {} }
    for i,v in pairs(cfgTower) do
        if v.RotationType == 1 then
            table.insert(towerCfgMultiList[1], v)
        elseif v.RotationType == 2 and LuaMgr.Timestamp() - v.Opentime >= 0 and isPassPage_1 then
            table.insert(towerCfgMultiList[2], v)
        elseif v.RotationType == 3 and LuaMgr.Timestamp() - v.Opentime >= 0 and isPassPage_1 then
            table.insert(towerCfgMultiList[3], v)
        elseif v.RotationType == 4 and TrainingTowerHelper.weekTowerData ~= nil and TrainingTowerHelper.weekTowerData.RotationId ~= nil and v.RotationId == TrainingTowerHelper.weekTowerData.RotationId then
            table.insert(towerCfgMultiList[4], v)
        end
    end
    for i = 1, #towerCfgMultiList do
        table.sort(towerCfgMultiList[i], function(a, b) return a.GroupId<b.GroupId end)
    end
end

this.ParseData=function()
    dataTower=DataMgr.Player.Tower;
    dataTowerRecords=DataMgr.Player.TowerRecords;
    dataRewards=DataMgr.Player.TowerRewards;
    
    this.InitTowerList()

    isWheeling=dataTower.Dungeon~="";
    local isPassPage_1 = this.CheckPassPage_1();
    isUnlockWeek = isPassPage_1 and not TrainingTowerHelper.CheckWeekTowerExpired()
    if TrainingTowerHelper.curTowerCfgList == nil or TrainingTowerHelper.curPageIndex == nil then
        curPageIndex = this.GetCurrentTower()
        TrainingTowerHelper.curTowerCfgList = curTowerCfgList
        TrainingTowerHelper.curPageIndex = curPageIndex
    else
        curPageIndex = TrainingTowerHelper.curPageIndex 
        curTowerCfgList = TrainingTowerHelper.curTowerCfgList
    end

    this.vm.data.isWheel=isWheeling;
    this.vm.data.isNotWheel = not isWheeling
    isShowSwitchBtn = not isWheeling and (isPassPage_1 or (not isPassPage_1 and not TrainingTowerHelper.CheckWeekTowerExpired()));
    
    this.vm.data.isEnter = not isWheeling;
    this.vm.data.isScrollRect_Inertia=true;
    
    this.InitSwitchBtn()
    this.CheckWeekTowerTheme()
    this.ShowCurPage()
end

this.CheckPassPage_1=function()
    local norTowerList = towerCfgMultiList[1]
    local lastNorTower = norTowerList[#norTowerList]
    local isUnlock =dataTowerRecords[lastNorTower.GroupId] ~= nil
    return isUnlock
end

this.GetCurrentTower=function()
    local pageIndex = -1
    curTowerCfgList = { nil, nil, nil, nil }
    if isWheeling then
        for i, k in ipairs(towerCfgMultiList) do
            for j, v in ipairs(k) do
                if v.GroupId==dataTower.GroupId then
                    curTowerCfgList[i] = v
                    pageIndex = i
                    break
                end
            end
            if pageIndex ~= -1 then
                break
            end
        end
    else
        for i = #towerCfgMultiList, 1, -1 do
            for k, v in ipairs(towerCfgMultiList[i]) do
                if (i == 1 and dataTowerRecords[v.GroupId]==nil) or
                        ((i == 2 or i == 3) and LuaMgr.Timestamp() - v.Opentime >= 0 and dataTowerRecords[v.GroupId]==nil) or
                        (i == 4 and (dataTowerRecords[v.GroupId]==nil or dataTowerRecords[v.GroupId] - LuaMgr.Timestamp() <= 0)) or dataTowerRecords[v.GroupId]==nil then
                    curTowerCfgList[i] = v
                    pageIndex = i
                    break
                end
            end
        end
        
        for i = #towerCfgMultiList, 1, -1 do
            if curTowerCfgList[i] == nil then
                for k, v in ipairs(towerCfgMultiList[i]) do
                    if k == #towerCfgMultiList[i] then
                        curTowerCfgList[i] = v
                        if pageIndex == -1 and (i ~= 4 or (i == 4 and isUnlockWeek)) then
                            pageIndex = i
                            break
                        end
                    end
                end
            end
        end
        
        if isUnlockWeek and curTowerCfgList[4] ~= nil then
            pageIndex = 4
        end
    end

    if pageIndex <= 0 then
        pageIndex = 1
    end
    return pageIndex
end

this.ParseTowerData_1 = function()
    if isWheeling then
        this.InitWheelTowerList();
    end
    this.InitNorTowerList();
    this.CheckRewards();
end

this.ParseTowerData_2 = function()
    if isWheeling then
        this.InitWheelTowerList();
    end
    this.InitNorTowerList_2(false);
    this.CheckRewards();
end

this.ParseWeekTowerData=function()
    if isWheeling then
        this.InitWheelTowerList();
    end
    this.InitNorTowerList_2(true);
    this.CheckRewards();
    this.SetExpiresTime()
end


this.InitNorTowerList = function()
    local unlock=true;
    if curTowerIndex[curPageIndex] == nil then
        local curTowerGroupId = ""
        if curTowerCfgList[curPageIndex] ~= nil then
            curTowerGroupId = curTowerCfgList[curPageIndex].GroupId
        end
        for i,v in ipairs(towerCfgMultiList[curPageIndex]) do
            this.vm.data.norList[i].isHigh=v.GroupId==curTowerGroupId;
            this.vm.data.norList[i].isNor=unlock;
            this.vm.data.norList[i].isLock=not unlock;
            unlock=unlock and dataTowerRecords[v.GroupId]~=nil;
            if v.GroupId==curTowerGroupId then
                curTowerIndex[curPageIndex]=i;
            end
        end
    end
    if this.vm.data.norList[curTowerIndex[curPageIndex]] ~= nil then
        this.vm.data.cardFx_Pos=this.vm.data.norList[curTowerIndex[curPageIndex]].fxPos;
    end
    this.SetNorTextInfo();
    this.SetCardAnchor(true);
end

this.InitNorTowerList_2 = function(isWeek)
    if curTowerIndex[curPageIndex] == nil then
        if curPageIndex~=nil then
            for i, v in ipairs(towerCfgMultiList[curPageIndex]) do
                if i <= #this.vm.data.norList_2 then
                    this.vm.data.norList_2[i].isHigh=v.GroupId==curTowerCfgList[curPageIndex].GroupId;
                    if v.GroupId==curTowerCfgList[curPageIndex].GroupId then
                        curTowerIndex[curPageIndex] = i;
                    end
                end
            end
        end
    else
        this.UpdateTowerListState()
    end
    if isWeek then
        this.SetNorTextInfo_4()
    else
        this.SetNorTextInfo_2()
    end
end

this.InitSwitchBtn = function()
    for i = 1, #towerCfgMultiList do
        local towerListCount = #towerCfgMultiList[i];
        this.vm.data.switchBtnList[i].active = towerListCount > 0
        this.vm.data.switchBtnList[i].select = i == curPageIndex
        
        local isGetAllReward = true
        for j = 1, towerListCount do
            local record = DataMgr.Player.TowerRewards[towerCfgMultiList[i][j].GroupId]
            local isReward = record ~= nil and not record;
            isGetAllReward = isGetAllReward and isReward
        end
        this.vm.data.switchBtnList[i].lock = isGetAllReward
    end
end


this.UpdateTowerListState=function()
    if curPageIndex == 2 or curPageIndex == 3 then
        for i,v in ipairs(this.vm.data.norList_2) do
            v.isHigh=i==curTowerIndex[curPageIndex];
        end
        this.SetNorTextInfo_2()
    elseif curPageIndex == 4 then
        for i,v in ipairs(this.vm.data.norList_2) do
            v.isHigh=i==curTowerIndex[curPageIndex];
        end
        this.SetNorTextInfo_4()
    else
        for i,v in ipairs(this.vm.data.norList) do
            v.isHigh=i==curTowerIndex[curPageIndex];
        end
        this.vm.data.cardFx_Pos=this.vm.data.norList[curTowerIndex[curPageIndex]].fxPos;
        this.SetNorTextInfo();
        this.SetCardAnchor(true);
    end
end

this.SetCardAnchor=function(isAnima)
    local pos=this.vm.data.norList[curTowerIndex[curPageIndex]].pos
    local tarPos=Vector2(LuaMgr.ScreenWidth()/2-pos.x,360);
    if not isAnima then
        this.data.cardContentRect.anchoredPosition=tarPos
        return;
    end
    if this.data.tweener~=nil then
        this.data.tweener:Kill()
    end
    this.data.tweener=DOTWeen.To(function()return  this.data.cardContentRect.anchoredPosition end,function(vector)
        this.data.cardContentRect.anchoredPosition=vector
end,tarPos,0.5);
    this.data.tweener.onComplete=function()
        this.vm.data.isScrollRect_Inertia=true;
    end
end


this.SetNorTextInfo=function()
    if curTowerIndex[curPageIndex] == nil then
        curTowerIndex[curPageIndex] = 1
    end
    
    local norTowerList = towerCfgMultiList[1]
    this.data.dungeonNameSpriteStr = "ui_pt_btz"..curTowerIndex[curPageIndex]
    this.vm.data.curDungeonSprite=LuaMgr.GetSprite("TrainingTower","ui_pt_btz"..curTowerIndex[curPageIndex])
    this.vm.data.curDungeonBigSprite=LuaMgr.GetSprite("TrainingTower","ui_pt_btzz"..curTowerIndex[curPageIndex])
    this.SetDungeonNameSpriteNativeSize()
    if curTowerIndex[curPageIndex]<#norTowerList and this.vm.data.norList[curTowerIndex[curPageIndex]+1].isNor then
        this.vm.data.isDownLevel=true;
    else
        this.vm.data.isDownLevel=false;
    end
    if curTowerIndex[curPageIndex]>1 and this.vm.data.norList[curTowerIndex[curPageIndex]-1].isNor then
        this.vm.data.isUpLevel=true;
    else
        this.vm.data.isUpLevel=false;
    end
end

this.SetNorTextInfo_2 = function()
    local index = curTowerIndex[curPageIndex]
    if curPageIndex == 3 then
        index = 3 - index
    end
    this.data.dungeonNameSpriteStr = "ui_pt_btz"..(index + 15)
    this.vm.data.curDungeonSprite=LuaMgr.GetSprite("TrainingTower","ui_pt_btz"..(index + 15))
    this.vm.data.curDungeonBigSprite=LuaMgr.GetSprite("TrainingTower","ui_pt_btzz"..(index + 15))
    this.SetDungeonNameSpriteNativeSize()
end

this.SetNorTextInfo_4 = function()
    if TrainingTowerHelper.NameSpriteStrMap[this.data.themeName] == nil then
        return
    end
    local index = curTowerIndex[curPageIndex]

    this.data.dungeonNameSpriteStr = TrainingTowerHelper.NameSpriteStrMap[this.data.themeName][index == 1 and 1 or 2]
    this.vm.data.curDungeonSprite=LuaMgr.GetSprite("TrainingTower", this.data.dungeonNameSpriteStr)
    this.vm.data.curDungeonBigSprite=LuaMgr.GetSprite("TrainingTower", this.data.dungeonNameSpriteStr)
    this.SetDungeonNameSpriteNativeSize()
end

this.InitWheelTowerList=function()
    local index=TrainingTowerHelper.GetDungeonIndexFromList(dataTower.GroupId,dataTower.Dungeon)
    this.vm.data.curDungeonNumSprite=LuaMgr.GetSprite("TrainingTower","ui_pt_jxz_btsz"..index);
    
    local towerCharAttrs={};
    for i,v in pairs(DataMgr.Player.TowerCharAttrs) do
        table.insert(towerCharAttrs,v);
    end
    table.sort(towerCharAttrs,function(a, b) return a.ID<b.ID end);
    local list={};
    local heroItem=nil;
    local isShowTiredBuff=TrainingTowerHelper.CheckIsTiredBuff(dataTower.GroupId);
    if TrainingTowerHelper.CheckIsPassBattle(dataTower.GroupId) then
        isShowTiredBuff=false;
    end
    for i,v in ipairs(towerCharAttrs) do
        heroItem=TrainingTowerHelper.CreateHeroItem(v,isShowTiredBuff);
        if heroItem.hpSlider<0.2 then
            heroItem.color=this.data.color_red
        elseif heroItem.hpSlider<0.5 then
            heroItem.color=this.data.color_yellow
        else
            heroItem.color=this.data.color_green;
        end
        if heroItem.isLock then
            heroItem.lockSprite=LuaMgr.GetSprite("TrainingTower","ui_pt_jxz_tx_zbz"..v.LockRound)
        end
        table.insert(list,heroItem);
    end
    this.vm.data.heroList=list;
end


this.OnAskGetRewards=function()
    local askData={GroupID=dataTower.GroupId}
    ApiMgr.Request("tower2/getRewards",askData,true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result.Rewards);
        LuaMgr.ShowItemRewared(data);
        this.InitSwitchBtn();
    end,nil,true);
end

this.CheckRewards=function()
    if dataTower.GroupId~="" and dataRewards[dataTower.GroupId]~=nil and dataRewards[dataTower.GroupId] then
        this.OnAskGetRewards();
    end

    this.vm.data.showStageRewardBtn = #curWeekDungeonIdList > 0 and curPageIndex == 4

    TrainingTowerHelper.GetTowerStageRewardsRedCount(function(trainingTowerRed)
        RedMgr.Singleton:UpdateClientRedData("15101", trainingTowerRed);
        RedMgr.Singleton:Refresh();
    end )
end

this.CheckWeekTowerTheme = function()
    this.data.themeName = ""
    if towerCfgMultiList[4] ~= nil and #towerCfgMultiList[4] > 0 then
        this.data.themeName = towerCfgMultiList[4][1].RotationUI
    end
    
    this.vm.data.showCommonEffect = true
    local switchBtnWeeklyIconStr = "ui_pt_qh6"
    local themeGroupName = TrainingTowerHelper.GetThemeGroupNameByThemeName(this.data.themeName)
    local themeGroupCfg = TrainingTowerHelper.UiThemeMap[themeGroupName]
    if themeGroupCfg ~= nil then
        switchBtnWeeklyIconStr = themeGroupCfg.weeklyIconStr
        if themeGroupCfg.hideCommonEffect ~= nil and themeGroupCfg.hideCommonEffect then
            this.vm.data.showCommonEffect = false
        end
    end
    this.vm.data.switchBtnWeeklyIcon=LuaMgr.GetSprite("TrainingTower", switchBtnWeeklyIconStr)

    for i = 1, this.data.page4Tr.childCount do
        local child = this.data.page4Tr:GetChild(i - 1)
        child.gameObject:SetActive(child.name == themeGroupName)
        if child.name == themeGroupName and themeGroupName ~= this.data.themeName then
            child.gameObject:SetActive(true)
            local themeContent = child:Find("content")
            for j = 1, themeContent.childCount do
                local tempChild = themeContent:GetChild(j - 1)
                tempChild.gameObject:SetActive(tempChild.name == this.data.themeName);
            end
        end
    end
    
    this.GetCurWeekDungeonIdList()
end

this.GetCurWeekDungeonIdList = function()
    curWeekDungeonIdList = {}
    if towerCfgMultiList[#towerCfgMultiList] == nil then
        return
    end
    for i, v in ipairs(towerCfgMultiList[#towerCfgMultiList]) do
        if not IsNull(v.StageReward) and next(v.StageReward) ~= nil then
            local tempDungeonList = TrainingTowerHelper.GetDungeonListByGroupId(v.GroupId)
            for index,dungeonCfg in ipairs(tempDungeonList) do
                table.insert(curWeekDungeonIdList, {dungeonId = dungeonCfg.id, reward = v.StageReward[index]})
            end
        end
    end
end

this.ShowCurPage = function()
    this.vm.data.isShowPage_1 = curPageIndex == 1
    this.vm.data.isShowPage_2 = curPageIndex == 2
    this.vm.data.isShowPage_3 = curPageIndex == 3
    this.vm.data.isShowPage_4 = curPageIndex == 4
    this.vm.data.isShowPage_23 = curPageIndex == 2 or curPageIndex == 3
    this.vm.data.isNotShowPage_1 = curPageIndex ~= 1
    
    if curPageIndex == 1 then
        this.ParseTowerData_1();
    elseif curPageIndex == 2 or curPageIndex == 3 then
        this.ParseTowerData_2();
    else
        this.ParseWeekTowerData();
        this.SetExpiresTime()
    end
    
    this.vm.data.isShowSwitchList = false
    this.vm.data.isShowSwitchBtn = isShowSwitchBtn
end

this.SetExpiresTime=function()
    local str = os.date("%Y-%m-%d", TrainingTowerHelper.weekTowerData.Expires)
    this.vm.data.timer = str
    weekLeftTime = TrainingTowerHelper.weekTowerData.Expires - LuaMgr.Timestamp()
    LuaMgr.AddTimer(TimerConst.TrainingLeftTimer, this.UpdateLeftTimer, 1, -1, true)
end

this.UpdateLeftTimer=function()
    if weekLeftTime <= 0 then
        LuaMgr.HidePanel(UIName.TrainingTowerViewModel)
        return
    end
    
    local leftTimeStr = ""
    if weekLeftTime <= 60 then
        leftTimeStr = "1" .. ConfigMgr.LangGlobal("10317")
    else
        local day, hour, minute = GetTimeDHM2(weekLeftTime)
        if day > 0 then
            leftTimeStr = string.format(ConfigMgr.LangGlobal("15011"), day, hour);
        elseif hour > 0 then
            leftTimeStr = string.format(LuaMgr.GetLangText("TrainingTowerViewModel_4"), hour)
        else
            leftTimeStr = minute .. ConfigMgr.LangGlobal("10317")
        end
    end
    this.vm.data.leftTime = LuaMgr.GetLangText("TrainingTowerViewModel_5") .. leftTimeStr
    weekLeftTime = weekLeftTime - 1
end

this.SetDungeonNameSpriteNativeSize = function()
    this.data.dungeonNameImg:SetNativeSize();
    this.data.dungeonNameWheelImg:SetNativeSize();
    local dungeonNameImgRect = this.data.dungeonNameImg:GetComponent("RectTransform")
    local dungeonNameWheelImgRect = this.data.dungeonNameWheelImg:GetComponent("RectTransform")
    local oldSizeDelta = this.vm.data.isNotWheel and dungeonNameImgRect.sizeDelta or dungeonNameWheelImgRect.sizeDelta
    local ratio = oldSizeDelta.y / 48
    local newSizeDelta = Vector2((oldSizeDelta.x / ratio), 48)
    dungeonNameImgRect.sizeDelta = newSizeDelta
    dungeonNameWheelImgRect.sizeDelta = newSizeDelta
end

return vm({
    data = data,
    command = command,
    hook = hook
})