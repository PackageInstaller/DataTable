



local this = { vm = nil }
local heroIconPath = "Assets/_BundleResources/Character/"
local GALLERY_PAth = "Assets/_BundleResources/Images/CollectorGallery/";
local spineUICharacter
local characterId
local TrammelTotolData = {}
local TrammelChildData = {}

local totolTrammelNum = 0

local seleTrammelKey = ""

local completeCollector = false

local currentSelectindex = 0

this.TrammelParentposGrop_Num_6 = {
    { rotation = 20, scale = 0.8, pos = {-349.5, 133 } },
    { rotation = 10, scale = 0.9, pos = {-546, 3 } },
    { rotation = 0, scale = 1, pos = {-336, -154 } },
    { rotation = 0, scale = 1, pos = { 345, -154 } },
    { rotation = 0, scale = 0.9, pos = { 545, 5 } },
    { rotation = -20, scale = 0.8, pos = { 358, 133 } },
}

this.TrammelParentposGrop_Num_5 = {
    { rotation = 0, scale = 1, pos = {-336, -154 } },
    { rotation = 0, scale = 1, pos = { 345, -154 } },
    { rotation = 0, scale = 0.9, pos = { 545, 5 } },
    { rotation = -20, scale = 0.8, pos = { 358, 133 } },
    { rotation = 20, scale = 0.8, pos = {-349.5, 133 } },

}

this.TrammelChildposGrop_Type_6 = {
    { pos = { 265, 191 }, scale = 0.6 }, { pos = { 438, 24 }, scale = 0.7 }, { pos = { 246, -93 }, scale = 0.8 },
    { pos = {-279, 191 }, scale = 0.6 }, { pos = {-450, 24 }, scale = 0.7 }, { pos = {-258, -93 }, scale = 0.8 }
}

this.TrammelChildposGrop_Type_8 = {
    { pos = { 258, -130 }, scale = 0.64 }, { pos = { 429.5, -66 }, scale = 0.56 }, { pos = { 387, 151 }, scale = 0.48 }, { pos = { 239, 201 }, scale = 0.48 },
    { pos = {-270, -130 }, scale = 0.64 }, { pos = {-444.5, -66 }, scale = 0.56 }, { pos = {-387, 151 }, scale = 0.48 }, { pos = {-239, 201 }, scale = 0.48 }
}

this.TrammelChildposGrop_Type_9 = {
    { pos = { 147, -116 }, scale = 0.51 }, { pos = { 293.5, -55 }, scale = 0.45 }, { pos = { 427.7, 28.3 }, scale = 0.38 }, { pos = { 294, 153 }, scale = 0.38 },
    { pos = {-7.5, -166 }, scale = 0.51 },
    { pos = {-161, -116 }, scale = 0.51 }, { pos = {-310, -55 }, scale = 0.45 }, { pos = {-444.6, 29.7 }, scale = 0.38 }, { pos = {-321.8, 151 }, scale = 0.38 }
}

this.TrammelChildposGrop_Type_10 = {
    { pos = { 147, -136 }, scale = 0.51 }, { pos = { 294, -75.5 }, scale = 0.45 }, { pos = { 428, -15 }, scale = 0.38 }, { pos = { 378, 158.5 }, scale = 0.38 }, { pos = { 249.5, 208 }, scale = 0.38 },
    { pos = {-162, -136 }, scale = 0.51 }, { pos = {-309.5, -75.5 }, scale = 0.45 }, { pos = {-444, -15 }, scale = 0.38 }, { pos = {-394, 158 }, scale = 0.38 }, { pos = {-267, 208.5 }, scale = 0.38 }
}

this.TrammelChildposGrop_Type_12 = {
    { pos = { 147, -165 }, scale = 0.51 }, { pos = { 294, -105.5 }, scale = 0.45 }, { pos = { 428, -45 }, scale = 0.38 }, { pos = { 477.5, 128.5 }, scale = 0.38 }, { pos = { 350, 178.5 }, scale = 0.38 }, { pos = { 222, 229 }, scale = 0.38 },
    { pos = {-162, -165 }, scale = 0.51 }, { pos = {-309.5, -105.5 }, scale = 0.45 }, { pos = {-444, -45 }, scale = 0.38 }, { pos = {-494, 129.5 }, scale = 0.38 }, { pos = {-366.5, 179.5 }, scale = 0.38 }, { pos = {-238, 229 }, scale = 0.38 }
}

this.TrammelChildposGrop_Type_13 = {
    { pos = { 147, -165 }, scale = 0.51 }, { pos = { 294, -105.5 }, scale = 0.45 }, { pos = { 428, -45 }, scale = 0.38 }, { pos = { 477.5, 128.5 }, scale = 0.38 }, { pos = { 350, 178.5 }, scale = 0.38 }, { pos = { 222, 229 }, scale = 0.38 },
    { pos = {-7, -166.5 }, scale = 0.51 },
    { pos = {-162, -165 }, scale = 0.51 }, { pos = {-309.5, -105.5 }, scale = 0.45 }, { pos = {-444, -45 }, scale = 0.38 }, { pos = {-494, 129.5 }, scale = 0.38 }, { pos = {-366.5, 179.5 }, scale = 0.38 }, { pos = {-238, 229 }, scale = 0.38 }
}


local data = {
    spineheroPath = "",
    heroTexture = DefaultTexture,
    TrammelParentPanelShow = true,
    TrammelChildPanelShow = false,
    heroMainTexture = DefaultTexture,
    TrammelParentPanel = true,
    TrammelChildItemunlock = false,
    ui_common_fx_lock_break=false,
    ui_common_fx_lock_loop=false,
TrammelChildActiveRedPoint=false,
TrammelChildRedId="",
    TrammelChildItemlock = false,
    TrammelChildItemname = "",
    TrammelChildItemmessage = "",
    TrammelChildItemnumShow = "",
    TrammelChildItemicon = DefaultSprite,
    TrammelChildskill1message = "",
    TrammelChildskill2message = "",
    TrammelChildskill3message = "",
    TrammelChildIconOneshow = false,
    TrammelChildIcontwoshow = false,
    TrammelChildIcontthreeshow = false,
    TrammelChildskillIconOne = DefaultSprite,
    TrammelChildskillIcontweo = DefaultSprite,
    TrammelChildskillIconthree = DefaultSprite,
    longDescription = "",
    TrammelParentList = {
        {
            pos = Vector3.zero,
            unlock = false,
            lock = false,
            name = "",
            numShow = "",
            scale = Vector3.zero,
            icon = DefaultSprite,
            rotation = Vector3.zero,
            skill1message = "",
            skill2message = "",
            skill3message = "",
            IconOneshow = false,
            Icontwoshow = false,
            Icontthreeshow = false,
            skillIconOne = DefaultSprite,
            skillIcontweo = DefaultSprite,
            skillIconthree = DefaultSprite,
            effectPos=Vector3.zero,
            ui_common_fx_lock_loop=false,
            activeRedPoint=false,
            redId="",
        }
    },
}

require("CollectorPractice/Common/UICollectorCardItem")

local tarGameObject = nil;
local tarRect = nil;
local btnRight = nil;
local btnLeft = nil;
local rectChildList = nil;
local goChildBugsShow=nil;
local cardItems={};
local goDescriptionBg=nil;
local rawImageTotolBgs=nil;
this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    btnRight = uiLink:Get("btnRight");
    btnLeft = uiLink:Get("btnLeft");
    rectChildList=uiLink:Get("rectChildList"):GetComponent("RectTransform");
    goChildBugsShow=uiLink:Get("goChildBugsShow");
    goDescriptionBg=uiLink:Get("goDescriptionBg");
    rawImageTotolBgs=uiLink:Get("rawImageTotolBgs"):GetComponent("RawImage");
    SetActive(goDescriptionBg,false)
    
    SetActive(btnRight,false)
    SetActive(btnLeft,false)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    btnRight = nil;
    btnLeft = nil;
    rectChildList=nil;
    goChildBugsShow=nil;
    goDescriptionBg=nil;
    rawImageTotolBgs=nil;
    for i = 1, #cardItems do
        cardItems[i]:Destroy();
    end
    
    cardItems=nil;
end


local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.Back()
        end
    },
    clickTrammelParentItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local ChildData = this.vm.data.TrammelParentList[param + 1]
            this.vm.data.longDescription = LuaMgr.GetLangText(ChildData.ShowOtDes)
            currentSelectindex = param + 1
            completeCollector = ChildData.CanActive
            seleTrammelKey = ChildData.key
            TrammelChildData = TrammelTotolData[ChildData.key]
            this.InitTrammeChildPanellList()
            this.changeTrammelData(ChildData)
            this.vm.behaviour:UpdateTopBar("TrammelsChildren", this.OnBack)
            LuaMgr.NextFrame(function()
                this.vm.data.TrammelParentPanel = false
                this.vm.data.ui_common_fx_lock_break = false
                SetActive(btnRight,currentSelectindex < totolTrammelNum)
                SetActive(btnLeft,currentSelectindex > 1)
                SetActive(rectChildList.gameObject,true);
                SetActive(goChildBugsShow,true);
                RedMgr.Singleton:Refresh();
                SetActive(goDescriptionBg,true);
            end)
        end
    },
    clickTrammelChildItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local tabs = TrammelChildData[param + 1]
            local activeCard = tabs.Achieve
            if not activeCard then
                return
            end
            LuaMgr.ShowLuaPanel(UIName.CollectorPracticeGalleryTipViewModel, tabs, activeCard and 2 or 1)
        end
    },

    clickActiveTrammel = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if completeCollector then
                this.TrammelNet(seleTrammelKey);
            end
        end
    },
    clickToLeft = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            currentSelectindex = currentSelectindex - 1

            if currentSelectindex > 0 then
                local ChildData = this.vm.data.TrammelParentList[currentSelectindex]
                this.vm.data.longDescription = LuaMgr.GetLangText(ChildData.ShowOtDes)
                this.changePage(ChildData)

                LuaMgr.NextFrame(function()
                    this.vm.data.TrammelParentPanel = false
                    this.vm.data.ui_common_fx_lock_break = false

                    SetActive(btnRight,currentSelectindex < totolTrammelNum)
                    SetActive(btnLeft,currentSelectindex > 1)
                    SetActive(rectChildList.gameObject,true);
                    SetActive(goChildBugsShow,true);
                    SetActive(goDescriptionBg,true);
                end)
            else
                currentSelectindex = 1
            end

        end
    }, clickRight = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            currentSelectindex = currentSelectindex + 1
            if currentSelectindex > totolTrammelNum then
                currentSelectindex = totolTrammelNum
                return
            else
                local ChildData = this.vm.data.TrammelParentList[currentSelectindex]
                this.vm.data.longDescription = LuaMgr.GetLangText(ChildData.ShowOtDes)
                this.changePage(ChildData)
                
                LuaMgr.NextFrame(function()
                    this.vm.data.TrammelParentPanel = false
                    this.vm.data.ui_common_fx_lock_break = false

                    SetActive(btnRight,currentSelectindex < totolTrammelNum)
                    SetActive(btnLeft,currentSelectindex > 1)
                    SetActive(rectChildList.gameObject,true);
                    SetActive(goChildBugsShow,true);
                    SetActive(goDescriptionBg,true);
                end)
            end
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.Init(vm.behaviour.gameObject)
        RedMgr.Singleton:RegisterViewModel(UIName.CollectorPracticeTrammelsViewModel);
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            if DataMgr.Player.sex == 1 then
                rawImageTotolBgs.texture=LuaMgr.GetTexture(
                    "Assets/_BundleResources/Images/CollectorAchieve/ui_yx_cg_man.png"
                    )
            else
                rawImageTotolBgs.texture=LuaMgr.GetTexture(
                    "Assets/_BundleResources/Images/CollectorAchieve/ui_yx_cg_woman.png"
                    )
            end


            this.InitTrammelData()

        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            TrammelTotolData = {}
            TrammelChildData = {}
            completeCollector = false
            this.vm.data.ui_common_fx_lock_break = false
            totolTrammelNum = 0
            currentSelectindex = 0
            if this.vm.data.TrammelChildPanel then
                this.BackToParentPanel()
            end
        end
    end,
    before_destroy = function(vm)
        this.Clear();
    end,
}

this.changeTrammelData = function(tabdata)
    this.vm.data.TrammelChildItemunlock = tabdata.unlock
    this.vm.data.TrammelChildItemlock = tabdata.lock
    this.vm.data.ui_common_fx_lock_loop = tabdata.ui_common_fx_lock_loop
    this.vm.data.TrammelChildActiveRedPoint = tabdata.activeRedPoint
    this.vm.data.TrammelChildRedId = "1220"
    this.vm.data.TrammelChildItemname = tabdata.name
    this.vm.data.TrammelChildItemmessage = tabdata.skill1message
    this.vm.data.TrammelChildItemnumShow = tabdata.numShow
    this.vm.data.TrammelChildItemicon = tabdata.icon
    this.vm.data.TrammelChildskill1message = tabdata.skill1message
    this.vm.data.TrammelChildskill2message = tabdata.skill2message
    this.vm.data.TrammelChildskill3message = tabdata.skill3message
    this.vm.data.TrammelChildIconOneshow = tabdata.IconOneshow
    this.vm.data.TrammelChildIcontwoshow = tabdata.Icontwoshow
    this.vm.data.TrammelChildIcontthreeshow = tabdata.Icontthreeshow
    this.vm.data.TrammelChildskillIconOne = tabdata.skillIconOne
    this.vm.data.TrammelChildskillIcontweo = tabdata.skillIcontweo
    this.vm.data.TrammelChildskillIconthree = tabdata.skillIconthree
end

this.changePage = function(ChildData)
    completeCollector = ChildData.CanActive
    seleTrammelKey = ChildData.key
    TrammelChildData = TrammelTotolData[ChildData.key]
    this.InitTrammeChildPanellList()
    this.changeTrammelData(ChildData)
end

this.InitTrammelList = function()
    local tempList = {}

    for i = 1, 6, 1 do
        local Trammel = {
            pos = Vector3(this.TrammelParentposGrop_Num_6[i].pos[1], this.TrammelParentposGrop_Num_6[i].pos[2], 0),
            lock = false,
            name = "",
            message = "",
            scale = this.TrammelParentposGrop_Num_6[i].scale,
            icon = DefaultSprite,
            rotation = Vector3(0, 0, this.TrammelParentposGrop_Num_6[i].rotation),
            ui_common_fx_lock_loop=false,
            activeRedPoint=false,
            redId="1219",
        }
        table.insert(tempList, Trammel)
    end
    this.vm.data.TrammelParentList = tempList
end












local testdata = { 6, 8, 9, 10, 12, 13 }
this.chanGeData = function()
    for index, value in ipairs(testdata) do
        local PosData = this["TrammelChildposGrop_Type_" .. value] ~= nil and this["TrammelChildposGrop_Type_" .. value] or {}
        for _index, _value in ipairs(PosData) do
            PosData[_index].pos[1] = PosData[_index].pos[1] - 11
            PosData[_index].pos[2] = PosData[_index].pos[2] + 13
        end
    end
end

this.OnBack = function()
    if currentSelectindex~=0 then
        this.BackToParentPanel();
    else
        LuaMgr.Back();
    end
end

this.BackToParentPanel = function()
    currentSelectindex = 0
    this.vm.data.TrammelParentPanel = true
    SetActive(btnRight,false)
    SetActive(btnLeft,false)
    SetActive(rectChildList.gameObject,false);
    SetActive(goChildBugsShow,false);
    SetActive(goDescriptionBg,false);
    this.InitParentData()
end

this.InitTrammeChildPanellList = function()
    local data = #TrammelChildData
    local PosData = this["TrammelChildposGrop_Type_" .. data] ~= nil and this["TrammelChildposGrop_Type_" .. data] or {}

    if #PosData ~= #TrammelChildData then
        return
    end
    
    local len=#TrammelChildData;
    for i = 1, len, 1 do
        if i>#cardItems then
            table.insert(cardItems,UICollectorCardItem.New(rectChildList,Vector3(0.6,0.6,0.6)))
        end
        
        SetActive(cardItems[i].gameObject,true)
        cardItems[i].transform.anchoredPosition=Vector2(PosData[i].pos[1], PosData[i].pos[2]);
        cardItems[i]:SetData(TrammelChildData[i])

    end

    for i = len+1, #cardItems do
        cardItems[i]:Clear();
    end
end

local  StartPositionList = {
    {5.91, -0.12, -6658.2 }, {8.72, 2.19,-6658.2 }, {5.74, 4.37, -6658.2 }, {-3.73, 3.86, -6658.2 }, {-6.5, 1.65, -6658.2 }, {-3.9, -0.12, -6658.2 }
}

local  EndPositionList = {
    {1.1, 0.41, -6658.2 }, {1.1, 0.41, -6658.2 },  {1.1, 0.41, -6658.2 },   {1.1, 0.41, -6658.2 },  {1.1, 0.41, -6658.2 },   {1.1, 0.41, -6658.2 },  {1.1, 0.41, -6658.2 }
}

this.MovePos = function(trammelChildItem, targetIndex)
    if trammelChildItem.lock then
        return;
    end
    
    local startPos = Vector3(StartPositionList[targetIndex][1], StartPositionList[targetIndex][2],StartPositionList[targetIndex][3])
    local targetpos = Vector3(EndPositionList[targetIndex][1], EndPositionList[targetIndex][2], EndPositionList[targetIndex][3])
    local tween= DOTWeen.To(
           function()
               return startPos
           end,
           function(vector)
               trammelChildItem.effectPos = vector
           end,
           targetpos,
           1.5
   )
end

this.InitTrammelData = function()
    local Currentdata = ConfigMgr.Config.OriginsTalentMap
    if CollectorPracticeMgr.HomeGrlleryData == nil or next(CollectorPracticeMgr.HomeGrlleryData) == nil then
        CollectorPracticeMgr.InitGalleryData()
    end
    for index, value in ipairs(CollectorPracticeMgr.HomeGrlleryData) do
        if value.OriginsID == nil then
            break
        else
        end
        local NeedData = table.Copy(value)
        if TrammelTotolData[value.OriginsID] == nil then

            TrammelTotolData[value.OriginsID] = {}
            table.insert(TrammelTotolData[value.OriginsID], NeedData)
        else
            table.insert(TrammelTotolData[value.OriginsID], NeedData)
        end
    end
    for index, value in pairs(TrammelTotolData) do
        totolTrammelNum = totolTrammelNum + 1
    end
    this.InitParentData()
end

this.InitParentData = function()
    local teleten = ConfigMgr.Config.talentBankMap
    local Currentdata = ConfigMgr.Config.OriginsTalentMap
    local playeData = DataMgr.Player.originsTalent
    local tempList = {}
    local PosTab = {}
    PosTab = this["TrammelParentposGrop_Num_" .. totolTrammelNum] ~= nil and this["TrammelParentposGrop_Num_" .. totolTrammelNum] or {}
    local KeyIndex = 0
    local sortList = {}
    for key, value in pairs(Currentdata) do
        local childata = table.Copy(value)
        table.insert(sortList, childata)
    end
    table.sort(sortList, function(a, b)
        local astr, anum = a.OriginsID:gsub("%D+", "")
        local bstr, bnum = b.OriginsID:gsub("%D+", "")
        return tonumber(astr) < tonumber(bstr)
    end)
    for key, value in ipairs(sortList) do
        KeyIndex = KeyIndex + 1
        local completeNum = 0
        local complete = false
        local NumText
        local CanActiveData = false
        if TrammelTotolData[value.OriginsID] ~= nil then

            local ChildTab = TrammelTotolData[value.OriginsID]

            for _Index, _value in ipairs(ChildTab) do
                if _value.Achieve then
                    completeNum = completeNum + 1
                end
            end
            local messageData = {}
            for index, value in ipairs(value.TalentId) do
                local str = LuaMgr.GetLangText(teleten[value].DescriptionLan)
                local spritedata = LuaMgr.GetSprite("AttributeIcon", teleten[value].showTypeIcon)
                local Itemmessagge = { des = str, sprite = spritedata }
                table.insert(messageData, Itemmessagge)
            end
            local totolItemHave = #messageData
            complete = playeData[value.OriginsID] ~= nil
            CanActiveData = completeNum == #ChildTab

            local canUnLock=(completeNum>= #ChildTab)and not complete;
            NumText = string.format("<size=30><color=#FFFFFF>%s<size=18><color=#AD9F87>/%s</color></size></color></size>", completeNum, #ChildTab)
            local Trammel = {}
            Trammel = {
                pos = Vector3(PosTab[KeyIndex].pos[1], PosTab[KeyIndex].pos[2], 0),
                key = value.OriginsID,
                lock = not complete,
                unlock = complete,
                name = LuaMgr.GetLangText(value.OtNameLan),
                numShow = NumText,
                CanActive = CanActiveData,
                scale = PosTab[KeyIndex].scale,
                icon = DefaultSprite,
                rotation = Vector3(0, 0, PosTab[KeyIndex].rotation),
                skill1message = totolItemHave >= 1 and messageData[1].des or "",
                skill2message = totolItemHave >= 2 and messageData[2].des or "",
                skill3message = totolItemHave >= 3 and messageData[3].des or "",
                IconOneshow = totolItemHave >= 1,
                Icontwoshow = totolItemHave >= 2,
                Icontthreeshow = totolItemHave >= 3,
                ShowOtDes = value.OtDesLan,
                skillIconOne = totolItemHave >= 1 and messageData[1].sprite or DefaultSprite,
                skillIcontweo = totolItemHave >= 2 and messageData[2].sprite or DefaultSprite,
                skillIconthree = totolItemHave >= 3 and messageData[3].sprite or DefaultSprite,
                effectPos = Vector3(StartPositionList[KeyIndex][1], StartPositionList[KeyIndex][2],StartPositionList[KeyIndex][3]),
                ui_common_fx_lock_loop=canUnLock,
                activeRedPoint=canUnLock,
                redId="1219",
            }
            table.insert(tempList, Trammel)

        end
    end
    this.vm.data.TrammelParentList = tempList


    local itemCount=#this.vm.data.TrammelParentList

    for i = 1, itemCount do
        this.MovePos(this.vm.data.TrammelParentList[i],i)
    end
end

this.TrammelNet = function(id)
    local matchData = { OriginsId = id }
    ApiMgr.Request("fetter/activate", matchData, true, function(result)
        local re = json.decode(result);
        if re.code == 0 then
            this.vm.data.TrammelChildItemunlock = true
            this.vm.data.TrammelChildItemlock = false
            this.vm.data.ui_common_fx_lock_break = true
            this.vm.data.TrammelChildActiveRedPoint=false;
            if TrammelTotolData[id] ~= nil then
                TrammelTotolData[id].unlock = true
                TrammelTotolData[id].lock = false
                this.vm.data.TrammelParentList[currentSelectindex].unlock = true
                this.vm.data.TrammelParentList[currentSelectindex].lock = false
                this.vm.data.TrammelParentList[currentSelectindex].ui_common_fx_lock_loop = false
                this.vm.data.TrammelParentList[currentSelectindex].activeRedPoint=false;
                this.vm.data.TrammelParentList[currentSelectindex].redId="1219";
            end
            DataMgr.Player.originsTalent[id] = DataMgr.Player.originsTalent[id] == nil and LuaMgr.Timestamp() or DataMgr.Player.originsTalent[id]
        end
    end, nil, true)
end

return vm({
    data = data,
    command = command,
    hook = hook
})