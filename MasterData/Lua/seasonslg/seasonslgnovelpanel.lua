local objs = {
    animator = { path = "root", type = UITool.Animator },
    recollectionBtn = { path = "root/Bg/NovelBtn", type = UITool.Button },
    novelBtnBg1 = { path = "root/Bg/NovelBtn/bg1", type = UITool.GameObject },
    novelBtnBg2 = { path = "root/Bg/NovelBtn/bg2", type = UITool.GameObject },
    novelBtnText1 = { path = "root/Bg/NovelBtn/bg1/Text", type = UITool.Text },
    novelBtnText2 = { path = "root/Bg/NovelBtn/bg2/Text", type = UITool.Text },
    itemGroup = { path = "root/Bg/Item", type = UITool.Transform },
    bigItemGroup = { path = "root/Bg/BigItem", type = UITool.Transform },
}

local this = {
    NovelConfigs = nil,
    allDatas = {},
    mapItems = {},
    bigItems = {},
    isRecollectionMode = false,
}

this.CheckFinish = function(config)
    return DataHelper.CheckNovelComplete(config.eventParam)
end

this.CheckUnlock = function(config)
    if config.unlockParam == nil or config.unlockParam == "" then
        return true, ""
    end
    local isUnlock = DataHelper.CheckNovelComplete(config.unlockParam)
    local unlockDesc = ""
    if not isUnlock then
        unlockDesc = LuaMgr.GetLangText(config.tipsLan or config.tipslan)
    end
    return isUnlock, unlockDesc
end

this.before_awake = function()
    this.InitMapItems()
    RedMgr.Singleton:RegisterViewModel(UIName.SeasonSLGNovelPanel)
end

this.GetRecollectionModeKey = function()
    local uid = ""
    if DataMgr ~= nil and DataMgr.Player ~= nil and DataMgr.Player.uid ~= nil then
        uid = tostring(DataMgr.Player.uid)
    end
    return uid .. "SeasonSLGNovelRecollectionMode"
end

this.GetRecollectionMode = function()
    local key = this.GetRecollectionModeKey()
    return PlayerPrefs.GetInt(key, 0) == 1
end

this.SaveRecollectionMode = function(isMode)
    local key = this.GetRecollectionModeKey()
    PlayerPrefs.SetInt(key, isMode and 1 or 0)
end

this.before_active = function()
    this.animator:Rebind()
    this.animator:Play("ani_SeasonSLGNovelPanel_root_01")
    local isMode = this.GetRecollectionMode()
    this.isRecollectionMode = isMode
    this.RefreshNovelPage()
    this.SetRecollectionMode(isMode, false)
    if JZQWData ~= nil and JZQWData.CheckRedPoint ~= nil then
        JZQWData.CheckRedPoint()
    end
end

this.SetRecollectionMode = function(isMode, needSave)
    this.isRecollectionMode = isMode == true
    if needSave ~= false then
        this.SaveRecollectionMode(this.isRecollectionMode)
    end
    if (this.isRecollectionMode) then
        this.animator:Rebind()
        this.animator:Play("ani_SeasonSLGNovelPanel_root_01")
    end
    if this.novelBtnBg1 ~= nil then
        SetActive(this.novelBtnBg1, not this.isRecollectionMode)
    end
    if this.novelBtnBg2 ~= nil then
        SetActive(this.novelBtnBg2, this.isRecollectionMode)
    end

    if this.mapItems ~= nil then
        for i, itemObj in pairs(this.mapItems) do
            local data = itemObj.data or (this.allDatas ~= nil and this.allDatas[i])
            local isGot = false
            if data ~= nil then
                if data.Status == CommonRewardItem.Status.Got then
                    isGot = true
                elseif this.CheckFinish ~= nil and this.CheckFinish(data) == true then
                    isGot = true
                end
            elseif this.NovelConfigs ~= nil and this.NovelConfigs[i] ~= nil then
                if this.CheckFinish ~= nil and this.CheckFinish(this.NovelConfigs[i]) == true then
                    isGot = true
                end
            end

            if isGot then
                if itemObj.point ~= nil then
                    SetActive(itemObj.point, this.isRecollectionMode)
                end
                if itemObj.unShowPoint ~= nil then
                    SetActive(itemObj.unShowPoint, not this.isRecollectionMode)
                end
                if itemObj.readBg ~= nil then
                    SetActive(itemObj.readBg, this.isRecollectionMode)
                end
                if itemObj.unReadBg ~= nil then
                    SetActive(itemObj.unReadBg, false)
                end
                local btnObj = itemObj.btnGo or (itemObj.btn ~= nil and itemObj.btn.gameObject)
                if btnObj ~= nil then
                    SetActive(btnObj, this.isRecollectionMode)
                end
            end
        end
    end
end

this.InitMapItems = function()
    if this.itemGroup == nil then
        return
    end

    this.mapItems = {}
    for i = 1, 20 do
        local itemTran = this.itemGroup:Find("Item" .. i)
        if itemTran ~= nil then
            local itemObj = {
                index = i,
                transform = itemTran,
                gameObject = itemTran.gameObject,
                point = nil,
                unShowPoint = nil,
                pointBtn = nil,
                readBg = nil,
                readText = nil,
                unReadBg = nil,
                unReadText = nil,
                imgNew = nil,
                imgSelect = nil,
                btn = nil,
                btnGo = nil,
                onClick = nil,
                onClickPoint = nil,
            }

            local pointTF = itemTran:Find("Point")
            if pointTF ~= nil then
                itemObj.point = pointTF.gameObject
            end

            local unShowPointTF = itemTran:Find("UnShowPoint")
            if unShowPointTF ~= nil then
                itemObj.unShowPoint = unShowPointTF.gameObject
                local pBtnTF = unShowPointTF:Find("PointBtn")
                if pBtnTF ~= nil then
                    itemObj.pointBtn = pBtnTF:GetComponent(typeof(CS.UnityEngine.UI.Button))
                    if itemObj.pointBtn == nil then
                        itemObj.pointBtn = pBtnTF.gameObject:AddComponent(typeof(CS.UnityEngine.UI.Button))
                    end
                end
            end

            local readBgTF = itemTran:Find("ReadBg")
            if readBgTF ~= nil then
                itemObj.readBg = readBgTF.gameObject
                local txtTF = readBgTF:Find("TextName")
                if txtTF ~= nil then
                    itemObj.readText = txtTF:GetComponent(typeof(CS.UnityEngine.UI.Text))
                end
            end

            local unReadBgTF = itemTran:Find("UnReadBg")
            if unReadBgTF ~= nil then
                itemObj.unReadBg = unReadBgTF.gameObject
                local txtTF = unReadBgTF:Find("TextName")
                if txtTF ~= nil then
                    itemObj.unReadText = txtTF:GetComponent(typeof(CS.UnityEngine.UI.Text))
                end
                local imgNewTF = unReadBgTF:Find("ImgNew")
                if imgNewTF ~= nil then
                    itemObj.imgNew = imgNewTF.gameObject
                end
                local imgSelectTF = unReadBgTF:Find("ImgSelect")
                if imgSelectTF ~= nil then
                    itemObj.imgSelect = imgSelectTF.gameObject
                end
            end

            local btnTF = itemTran:Find("Btn")
            if btnTF ~= nil then
                itemObj.btn = btnTF:GetComponent(typeof(CS.UnityEngine.UI.Button))
                if itemObj.btn == nil then
                    itemObj.btn = btnTF.gameObject:AddComponent(typeof(CS.UnityEngine.UI.Button))
                end
                itemObj.btnGo = btnTF.gameObject
            end

            local itemIndex = i
            itemObj.onClick = function()
                this.OnClickNovelNode(itemIndex)
            end
            itemObj.onClickPoint = function()
                this.OnClickNovelNode(itemIndex)
            end

            if itemObj.btn ~= nil then
                LuaMgr.AddClick(itemObj.btn, itemObj.onClick)
            end




            this.mapItems[i] = itemObj
        end
    end

    this.bigItems = {}
    local bigToNodeMap = { [1] = 4, [2] = 9, [3] = 13, [4] = 16, [5] = 18 }
    if this.bigItemGroup ~= nil then
        for i = 1, 5 do
            local bigTran = this.bigItemGroup:Find("BigItem" .. i)
            if bigTran ~= nil then
                local bigObj = {
                    index = i,
                    transform = bigTran,
                    gameObject = bigTran.gameObject,
                    btn = bigTran:GetComponent(typeof(CS.UnityEngine.UI.Button)),
                    text = nil,
                    targetNodeIndex = bigToNodeMap[i],
                    onClick = nil,
                }
                if bigObj.btn == nil then
                    bigObj.btn = bigTran.gameObject:AddComponent(typeof(CS.UnityEngine.UI.Button))
                end

                local txtTF = bigTran:Find("Text")
                if txtTF ~= nil then
                    bigObj.text = txtTF:GetComponent(typeof(CS.UnityEngine.UI.Text))
                end

                if bigObj.btn ~= nil and bigObj.targetNodeIndex ~= nil then




                end
                this.bigItems[i] = bigObj
            end
        end
    end
end

this.ClearClickEvents = function()
    if this.mapItems ~= nil then
        for i, itemObj in pairs(this.mapItems) do
            if itemObj.btn ~= nil and itemObj.onClick ~= nil then
                LuaMgr.RemoveClick(itemObj.btn, itemObj.onClick)
            end
            if itemObj.pointBtn ~= nil and itemObj.onClickPoint ~= nil then
                LuaMgr.RemoveClick(itemObj.pointBtn, itemObj.onClickPoint)
            end
        end
        this.mapItems = {}
    end

    if this.bigItems ~= nil then
        for i, bigObj in pairs(this.bigItems) do
            if bigObj.btn ~= nil and bigObj.onClick ~= nil then
                LuaMgr.RemoveClick(bigObj.btn, bigObj.onClick)
            end
        end
        this.bigItems = {}
    end
end

this.RefreshNovelPage = function()
    local finishDatas, allDatas = this.GetAllNovelDatas()
    this.allDatas = allDatas
    this.RefreshPointItem(allDatas)
end

this.GetAllNovelDatas = function()
    if this.NovelConfigs == nil then
        this.NovelConfigs = DataExHelper.EX_GetEventListByArea("JYSH4")
        table.sort(this.NovelConfigs, function(a, b)
            return a.id < b.id
        end)
    end

    local finishDatas = {}
    local allDatas = {}
    local firstUnlockData = nil

    if this.NovelConfigs ~= nil then
        for i = 1, #this.NovelConfigs do
            local data = this.NovelConfigs[i]
            data.Index = i
            data.IsFirst = i == 1
            data.IsLast = i == #this.NovelConfigs
            data.Name = LuaMgr.GetLangText(data.nameLan or data.namelan)

            if this.CheckFinish(data) == true then
                data.Status = CommonRewardItem.Status.Got
            else
                local isUnlock, unlockDesc = this.CheckUnlock(data)
                if isUnlock == true then
                    data.Status = CommonRewardItem.Status.None
                else
                    data.Status = CommonRewardItem.Status.Lock
                    data.UnlockDesc = unlockDesc
                end
            end

            data.EventType = "JYSH4"

            if data.Status == CommonRewardItem.Status.Got then
                table.insert(finishDatas, data)
            elseif data.Status == CommonRewardItem.Status.None and firstUnlockData == nil then
                firstUnlockData = data
            end
            table.insert(allDatas, data)
        end
    end

    return finishDatas, allDatas, firstUnlockData
end

this.UpdateBigItemState = function(itemObj, data)
    if data.Status == CommonRewardItem.Status.Lock then
        if itemObj.gameObject ~= nil then
            SetActive(itemObj.gameObject, false)
        end
    else
        if itemObj.gameObject ~= nil then
            SetActive(itemObj.gameObject, true)
        end
    end
end

this.UpdateItemState = function(itemObj, data, isSelected)
    if itemObj == nil or data == nil then
        return
    end

    local name = data.Name

    if data.Status == CommonRewardItem.Status.Got then
        local isShow = this.isRecollectionMode == true
        if itemObj.point ~= nil then
            SetActive(itemObj.point, isShow)
        end
        if itemObj.unShowPoint ~= nil then
            SetActive(itemObj.unShowPoint, not isShow)
        end
        if itemObj.readBg ~= nil then
            SetActive(itemObj.readBg, isShow)
        end
        if itemObj.readText ~= nil then
            itemObj.readText.text = name
        end
        if itemObj.unReadBg ~= nil then
            SetActive(itemObj.unReadBg, false)
        end
        local btnObj = itemObj.btnGo or (itemObj.btn ~= nil and itemObj.btn.gameObject)
        if btnObj ~= nil then
            SetActive(btnObj, isShow)
        end
    elseif data.Status == CommonRewardItem.Status.None then
        if itemObj.point ~= nil then
            SetActive(itemObj.point, true)
        end
        if itemObj.unShowPoint ~= nil then
            SetActive(itemObj.unShowPoint, false)
        end
        if itemObj.readBg ~= nil then
            SetActive(itemObj.readBg, false)
        end
        if itemObj.unReadBg ~= nil then
            SetActive(itemObj.unReadBg, true)
        end
        if itemObj.unReadText ~= nil then
            itemObj.unReadText.text = name
        end
        if itemObj.imgNew ~= nil then
            SetActive(itemObj.imgNew, true)
        end
        if itemObj.imgSelect ~= nil then
            SetActive(itemObj.imgSelect, isSelected == true)
        end
        local btnObj = itemObj.btnGo or (itemObj.btn ~= nil and itemObj.btn.gameObject)
        if btnObj ~= nil then
            SetActive(btnObj, true)
        end
    else

        if itemObj.point ~= nil then
            SetActive(itemObj.point, false)
        end
        if itemObj.unShowPoint ~= nil then
            SetActive(itemObj.unShowPoint, false)
        end
        if itemObj.readBg ~= nil then
            SetActive(itemObj.readBg, false)
        end
        if itemObj.unReadBg ~= nil then
            SetActive(itemObj.unReadBg, false)
        end
        local btnObj = itemObj.btnGo or (itemObj.btn ~= nil and itemObj.btn.gameObject)
        if btnObj ~= nil then
            SetActive(btnObj, false)
        end
    end
end

this.RefreshPointItem = function(allDatas)
    if this.mapItems == nil or #this.mapItems == 0 then
        this.InitMapItems()
    end

    local firstUnlockIndex = 0
    if allDatas ~= nil then
        for i, data in ipairs(allDatas) do
            if data.Status == CommonRewardItem.Status.None and firstUnlockIndex == 0 then
                firstUnlockIndex = i
            end
            local itemObj = this.mapItems[i]
            if itemObj ~= nil then
                itemObj.data = data
                this.UpdateItemState(itemObj, data, firstUnlockIndex == i)
            end
        end

        local bigToNodeMap = { [1] = 4, [2] = 9, [3] = 13, [4] = 16, [5] = 18 }
        for bigIdx, nodeIdx in pairs(bigToNodeMap) do
            local bigObj = this.bigItems[bigIdx]
            local nodeData = allDatas[nodeIdx]
            if bigObj ~= nil and nodeData ~= nil then
                bigObj.data = nodeData
                this.UpdateBigItemState(bigObj, nodeData)
            end
        end
    end
end

this.OnClickRecollectionBtn = function()
    this.SetRecollectionMode(not this.isRecollectionMode, true)
end

this.OnClickNovelNode = function(index)
    local itemObj = this.mapItems[index]
    if itemObj == nil or itemObj.data == nil then
        if this.allDatas ~= nil and this.allDatas[index] ~= nil then
            this.OnClickIntroBtn(this.allDatas[index])
        end
        return
    end
    this.OnClickIntroBtn(itemObj.data)
end

this.OnClickIntroBtn = function(item)
    local data = (type(item) == "table" and item.data) or item
    if data == nil then
        return
    end

    if data.Status == CommonRewardItem.Status.Lock then
        local desc = data.UnlockDesc
        if PopUpMgr ~= nil and PopUpMgr.ShowTips ~= nil then
            PopUpMgr.ShowTips(desc)
        elseif LuaMgr ~= nil and LuaMgr.ShowPanel ~= nil and UIName ~= nil and UIName.MessageTipsViewModel ~= nil then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, desc)
        end
        return
    end

    local playNovelCallback = function()
        LuaMgr.Back()
    end

    local eventParam = data.eventParam
    if eventParam ~= nil and eventParam ~= "" and LuaMgr ~= nil and LuaMgr.PlayNovel ~= nil then
        LuaMgr.PlayNovel(eventParam, playNovelCallback)
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        if this.recollectionBtn ~= nil then
            LuaMgr.AddClick(this.recollectionBtn, this.OnClickRecollectionBtn)
        end
    end,
    before_active = function(vm)
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function()
        this.ClearClickEvents()
        if this.recollectionBtn ~= nil then
            LuaMgr.RemoveClick(this.recollectionBtn, this.OnClickRecollectionBtn)
        end
        RedMgr.Singleton:RemoveViewModel(UIName.SeasonSLGNovelPanel);
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)