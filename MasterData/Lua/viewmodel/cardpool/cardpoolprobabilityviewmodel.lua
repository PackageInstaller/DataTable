




require("ViewModel/CardPool/NewHeadItemModel")
require("ViewModel/CardPool/HeadTitleModel")
require("ViewModel/CardPool/HeadGroupModel")
require("ViewModel/CardPool/HeadItemModel")

local this = {
    vm = nil,headList = nil,totalWidth = nil,columnCount = nil,spaceX = nil,
    cardPoolData = nil,curLabel = 0,labelType = {head = 1,rules = 2,record = 3},
    poolName = nil,typeText = nil,ssrProbability = nil,srProbability = nil,rProbability = nil,
    newHeadList = nil,newHead = nil,newHeadText = nil,newHeadScroll = nil,newHeadTemplate = nil,
    headMask = nil,headView = nil,headScroll = nil,headTitle = nil,headGroup = nil,headTemplate = nil,
    rulesMask = nil,rulesView = nil,rulesScroll = nil,introText = nil,middleRect = nil,
    recordMask = nil,recordView = nil,tipText = nil,notRecord = nil,pageIndex = nil,totalPage = nil,
    pageBtn = nil,recordTextRoot = nil,numPageBtnRoot = nil,typeContent = nil,
    typeLabel = 0,typeEnum = {time = 1,normal = 2,oldTime = 3,limited = 4}, typeLabelText = nil,
    typeBtnText_1 = nil,typeBtnChoose_1 = nil,typeBtnChooseText_1 = nil,
    typeBtnText_2 = nil,typeBtnChoose_2 = nil,typeBtnChooseText_2 = nil,
    typeBtnText_3 = nil,typeBtnChoose_3 = nil,typeBtnChooseText_3 = nil,
    typeBtnText_4 = nil,typeBtnChoose_4 = nil,typeBtnChooseText_4 = nil,
    tableInsert = table.insert,tableRemove = table.remove,toString = tostring,
recordsList = nil,
    callBack = nil,
}

local data = {

}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.CardPoolProbabilityViewModel)
        end
    },
    headCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.curLabel == this.labelType.head then return end
            this.curLabel = this.labelType.head
            this.SwitchLabel()
        end
    },
    rulesCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.curLabel == this.labelType.rules then return end
            this.curLabel = this.labelType.rules
            this.SwitchLabel()
        end
    },
    recordCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.curLabel == this.labelType.record then return end
            this.recordsList = {}
            this.curLabel = this.labelType.record
            this.SwitchLabel()
        end
    },
    typeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.UpdateTypeContent(not this.typeContent.activeSelf)
        end
    },
    drawCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.recordsList = {}
            this.typeLabel = this.typeEnum.time
            this.pageIndex = 1
            this.GetDrawCardHistory()
            this.UpdateTypeLabel()
            this.UpdateTypeContent(false)
        end
    },
    searchCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.recordsList = {}
            this.typeLabel = this.typeEnum.normal
            this.pageIndex = 1
            this.GetDrawCardHistory()
            this.UpdateTypeLabel()
            this.UpdateTypeContent(false)
        end
    },
    oldTimeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.recordsList = {}
            this.typeLabel = this.typeEnum.oldTime
            this.pageIndex = 1
            this.GetDrawCardHistory()
            this.UpdateTypeLabel()
            this.UpdateTypeContent(false)
        end
    },
    limitedCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.recordsList = {}
            this.typeLabel = this.typeEnum.limited
            this.pageIndex = 1
            this.GetDrawCardHistory()
            this.UpdateTypeLabel()
            this.UpdateTypeContent(false)
        end
    },
    foreCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.pageIndex - 1 > 0 then
                this.pageIndex = this.pageIndex - 1
                this.GetDrawCardHistory()
            end
        end
    },
    nextCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.pageIndex + 1 <= this.totalPage then
                this.pageIndex = this.pageIndex + 1
                this.GetDrawCardHistory()
            end
        end
    },
    numberCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param)
            local pageNum = this.numPageBtnRoot[index].pageNum
            this.pageIndex = pageNum
            this.GetDrawCardHistory()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitGetView()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.InitParameter()
        this.UpdateScreenSize()
        if this.cardPoolData ~= nil then
            this.SetNewAddHead()
            this.SetLanguageText()
            this.SwitchLabel()
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if this.callBack ~= nil then
            this.callBack()
        end
        this.SetRecordView({})
        this.newHeadScroll:Clear()
        this.headScroll:Clear()
        this.headList = nil
        this.recordsList = {}
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("NewHeadItemModel")
        UIScrollView.ClearItem("HeadTitleModel")
        UIScrollView.ClearItem("HeadGroupModel")
        this = nil
    end,
}


this.InitParameter = function()
    this.curLabel = this.labelType.head
    local cardId = this.vm.behaviour.Params[0]
    this.callBack = this.vm.behaviour.Params[1]
    this.cardPoolData = ConfigMgr.Config.cardPools[cardId]
end

this.UpdateScreenSize = function()
    local addWidth = LuaMgr.GetScreenAddWidth()
    if addWidth > 0 then
        this.middleRect.sizeDelta = Vector2(1460,720)
    else
        this.middleRect.sizeDelta = Vector2(1280,720)
    end
    this.totalWidth = this.headView.transform.rect.width
    this.columnCount = math.floor(this.totalWidth / 112)
    this.spaceX = math.floor((this.totalWidth - (this.columnCount * 112)) / this.columnCount)
end


this.SetNewAddHead = function()
    SetActive(this.newHead,#this.cardPoolData.newCardTip > 0)
    this.newHeadList = {}
    if #this.cardPoolData.newCardTip <= 0 then return end
    this.newHeadScroll:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    for i = 1, #this.cardPoolData.newCardTip do
        groupData = {}
        groupData.data = this.cardPoolData.newCardTip[i]
        scrollData = UIScrollData.GetData(this.newHeadTemplate,"NewHeadItemModel",200,56 + 5,groupData)
        this.tableInsert(scrollDatas,scrollData)
        if this.newHeadList[this.cardPoolData.newCardTip[i]] == nil then
            this.newHeadList[this.cardPoolData.newCardTip[i]] = 1
        end
    end
    this.newHeadScroll:SetParams(180,207)
    this.newHeadScroll:SetData(scrollDatas, false)
end

this.SetLanguageText = function()
    this.poolName.text = LuaMgr.GetLangText(this.cardPoolData.nameLan)
    this.typeText.text = LuaMgr.GetLangText(this.cardPoolData.kindNameLan)
    local day = ConfigMgr.Config.constants.DrawCardRecordTime
    this.tipText.text = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2187"].NameLan),day)
    this.newHeadText.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2483"].NameLan)
    this.rProbability.text = (this.cardPoolData.probMsg.starProb[3] * 100).."%"
    this.srProbability.text = (this.cardPoolData.probMsg.starProb[4] * 100).."%"
    this.ssrProbability.text = (this.cardPoolData.probMsg.starProb[5] * 100).."%"
    this.typeBtnText_1.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2484"].NameLan)
    this.typeBtnChooseText_1.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2484"].NameLan)
    this.typeBtnText_2.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2485"].NameLan)
    this.typeBtnChooseText_2.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2485"].NameLan)
    this.typeBtnText_3.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2486"].NameLan)
    this.typeBtnChooseText_3.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2486"].NameLan)
    this.typeBtnText_4.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2489"].NameLan)
    this.typeBtnChooseText_4.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2489"].NameLan)
end


this.SetHeadView = function()
    this.HeadClassify()
    if this.headList == nil or #this.headList == 0 then return end
    this.headScroll:Clear(true)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local index = 1
    for i = 1, #this.headList do
        if #this.headList[i] > 0 then
            groupData = {}
            groupData.type = i
            groupData.item = this.headTitle
            scrollData = UIScrollData.GetData(this.headTitle,"HeadTitleModel",this.totalWidth,30,groupData)
            this.tableInsert(scrollDatas,scrollData)
            index = 1
            while (index <= #this.headList[i]) do
                groupData = {}
                groupData.spaceX = this.spaceX
                groupData.item = this.headTemplate
                groupData.head = {}
                for j = 1, this.columnCount do
                    if this.headList[i][index + j - 1] ~= nil then
                        if this.newHeadList[this.headList[i][index + j - 1].cardID] == nil then
                            this.headList[i][index + j - 1].isNew = false
                        else
                            this.headList[i][index + j - 1].isNew = true
                        end
                        this.tableInsert(groupData.head,this.headList[i][index + j - 1])
                    else
                        break
                    end
                end
                scrollData = UIScrollData.GetData(this.headGroup,"HeadGroupModel",this.totalWidth,130 + 10,groupData)
                this.tableInsert(scrollDatas,scrollData)
                index = index + this.columnCount
            end
        end
    end
    this.headScroll:SetParams(this.totalWidth,480)
    this.headScroll:SetData(scrollDatas, false)
    this.headScroll.content.sizeDelta = Vector2(this.headScroll.content.sizeDelta.x,this.headScroll.content.sizeDelta.y + 20)
end


this.HeadClassify = function()
    if this.headList == nil then
        this.headList = {}
        this.tableInsert(this.headList,1,{})

        local cardGroup = table.Copy(this.cardPoolData.cardGroups)
        local currentTime = LuaMgr.Timestamp()
        for i = #cardGroup,1,-1 do
            for j = #cardGroup[i], 1,-1 do
                if cardGroup[i][j].StartTime <= currentTime then
                    if cardGroup[i][j].isUP then
                        this.tableInsert(this.headList[1],cardGroup[i][j])
                        this.tableRemove(cardGroup[i],j)
                    end
                else
                    this.tableRemove(cardGroup[i],j)
                end
            end
            this.tableInsert(this.headList,cardGroup[i])
        end
        if this.cardPoolData.kind == "choiceness" or this.cardPoolData.kind == "choicenessJob" then
            this.headList[2] = {}
            local drawCharacterSelect = DataMgr.Player.drawCard.drawCharacterSelect
            if not TableIsNull(drawCharacterSelect) and drawCharacterSelect[this.cardPoolData.id] ~= nil then
                local tempList = drawCharacterSelect[this.cardPoolData.id]
                if not TableIsNull(tempList) then
                    for i = 1, #tempList do
                        if this.cardPoolData.kind == "choiceness" then
                            this.tableInsert(this.headList[1],{cardID = tempList[i],isUP = true})
                        elseif this.cardPoolData.kind == "choicenessJob" then
                            this.tableInsert(this.headList[2],{cardID = tempList[i],isUP = false})
                        end
                    end
                end
            end
        end
        cardGroup,drawCharacterSelect = nil,nil
    end
end


this.SetRulesView = function()
    this.rulesScroll.verticalNormalizedPosition = 1.0
    this.introText.text = LuaMgr.GetLangText(this.cardPoolData.cardpoolTextLan)
end


this.GetDrawCardHistory = function()
    if this.recordsList[this.toString(this.pageIndex)] == nil then
        local tempData = {}
        tempData["Page"] = this.pageIndex
        tempData["PageSize"] = 10
        if this.typeLabel == this.typeEnum.time then
            tempData["PoolTypes"] = {"time"}
        elseif this.typeLabel == this.typeEnum.normal then
            tempData["PoolTypes"] = {"normal"}
        elseif this.typeLabel == this.typeEnum.oldTime or this.typeLabel == 0 then
            tempData["PoolTypes"] = {"oldtime","newPlayer"}
        elseif this.typeLabel == this.typeEnum.limited then
            tempData["PoolTypes"] = {"limited"}
        end
        ApiMgr.Request("get_draw_card_history", tempData,true,function(result)
            local re = json.decode(result)
            if re.code == 0 then
                this.totalPage = math.ceil(re.result.Total / 10)
                SetActive(this.notRecord,re.result.Total <= 0)
                SetActive(this.pageBtn,this.totalPage > 0)
                if type(re.result.List) ~= "function" and #re.result.List > 0 then
                    this.recordsList[this.toString(this.pageIndex)] = re.result.List
                    this.SetRecordView(re.result.List)
                    this.UpdatePageBtn()
                else
                    this.recordsList[this.toString(this.pageIndex)] = {}
                    this.SetRecordView({})
                end
            end
        end,nil,true)
    else
        this.SetRecordView(this.recordsList[this.toString(this.pageIndex)])
        if not TableIsNull(this.recordsList[this.toString(this.pageIndex)]) then
            this.UpdatePageBtn()
        end
    end
end

this.SetRecordView = function(records)
    local heroConfig = nil
    local poolConfig = nil
    for i = 1, 10 do
        if #records >= i then
            heroConfig = ConfigMgr.Config.characterTable[records[i].Card]
            poolConfig = ConfigMgr.Config.cardPools[records[i].Pool]
            this.recordTextRoot[i].rareText.text = this.GetHeroRareStr(i,records[i].Rare)
            this.recordTextRoot[i].nameText.text = LuaMgr.GetLangText(heroConfig.namelan)
            local typeName,name = "",LuaMgr.GetLangText(poolConfig.nameLan)
            if records[i].PoolType == "time" then
                typeName = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2494"].NameLan)
            elseif records[i].PoolType == "normal" then
                typeName = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2495"].NameLan)
            elseif records[i].PoolType == "oldtime" or records[i].PoolType == "newPlayer" then
                typeName = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2496"].NameLan)
            elseif records[i].PoolType == "limited" then
                typeName = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2497"].NameLan)
            end
            this.recordTextRoot[i].poolNameText.text = typeName.."/"..name
            this.recordTextRoot[i].timeText.text = LuaMgr.UnixToDateTimeStr(records[i].Time)
        else
            this.recordTextRoot[i].rareText.text = ""
            this.recordTextRoot[i].nameText.text = ""
            this.recordTextRoot[i].poolNameText.text = ""
            this.recordTextRoot[i].timeText.text = ""
        end
    end
end
this.GetHeroRareStr = function(index,rare)
    if rare == 2 then
        this.recordTextRoot[index].rareText.color = UnityEngine.Color(33 / 225, 155 / 225, 161 / 225, 1)
        return LuaMgr.GetLangText("CardPoolProbabilityViewModel_2")
    elseif rare == 3 then
        this.recordTextRoot[index].rareText.color = UnityEngine.Color(216 / 225, 187 / 225, 70 / 225, 1)
        return LuaMgr.GetLangText("CardPoolProbabilityViewModel_3")
    elseif rare == 4 then
        this.recordTextRoot[index].rareText.color = UnityEngine.Color(210 / 225, 56 / 225, 55 / 225, 1)
        return LuaMgr.GetLangText("CardPoolProbabilityViewModel_4")
    end
end

this.UpdatePageBtn = function()
    local index = 2
    local btnNum = 1
    local numStr = ""
    local isClick = true
    this.numPageBtnRoot[1].pageNum = btnNum
    this.numPageBtnRoot[1].pageText.text = "1"

    SetActive(this.numPageBtnRoot[1].btnObj,true)
    SetActive(this.numPageBtnRoot[1].rectRoot.gameObject,true)
    while(index <= #this.numPageBtnRoot) do
        btnNum = btnNum + 1
        if btnNum > this.totalPage then
            index = 2
            btnNum = this.totalPage - 7
            if btnNum <= 1 then break else goto continue end
        end
        numStr = btnNum
        isClick = true
        if index == 2 and this.pageIndex - 1 >= 5 and this.totalPage > 9 then
            btnNum = this.pageIndex - 3
            numStr = "..."
            isClick = false
        end
        if index == 8 and this.totalPage - this.pageIndex >= 5 and this.totalPage > 9 then
            btnNum = 0
            numStr = "..."
            isClick = false
        end
        if index == 9 and this.totalPage > 9 then
            btnNum = this.totalPage
            numStr = btnNum
        end
        this.numPageBtnRoot[index].pageNum = btnNum
        this.numPageBtnRoot[index].pageText.text = numStr

        SetActive(this.numPageBtnRoot[index].btnObj,isClick)
        ::continue::
        index = index + 1
    end
    for i = 1, #this.numPageBtnRoot do
        local isShow = this.numPageBtnRoot[i].pageNum == this.pageIndex
        SetActive(this.numPageBtnRoot[i].mask,isShow)
        SetActive(this.numPageBtnRoot[i].rectRoot.gameObject,i <= this.totalPage)
    end
end
this.UpdateTypeLabel = function()
    if this.typeLabel == this.typeEnum.time then
        this.typeLabelText.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2484"].NameLan)
    elseif this.typeLabel == this.typeEnum.normal then
        this.typeLabelText.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2485"].NameLan)
    elseif this.typeLabel == this.typeEnum.oldTime then
        this.typeLabelText.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2486"].NameLan)
    elseif this.typeLabel == this.typeEnum.limited then
        this.typeLabelText.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2489"].NameLan)
    else
        this.typeLabelText.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2486"].NameLan)
    end
end
this.UpdateTypeContent = function(isShow)
    SetActive(this.typeBtnChoose_1,this.typeLabel == this.typeEnum.time)
    SetActive(this.typeBtnChoose_2,this.typeLabel == this.typeEnum.normal)
    SetActive(this.typeBtnChoose_3,this.typeLabel == this.typeEnum.oldTime or this.typeLabel == 0)
    SetActive(this.typeBtnChoose_4,this.typeLabel == this.typeEnum.limited)
    SetActive(this.typeContent,isShow)
end

this.SwitchLabel = function()
    this.UpdateTypeContent(false)
    SetActive(this.headMask,this.curLabel == this.labelType.head)
    SetActive(this.headView,this.curLabel == this.labelType.head)
    SetActive(this.rulesMask,this.curLabel == this.labelType.rules)
    SetActive(this.rulesView,this.curLabel == this.labelType.rules)
    SetActive(this.recordMask,this.curLabel == this.labelType.record)
    SetActive(this.recordView,this.curLabel == this.labelType.record)
    if this.curLabel == this.labelType.head then
        this.SetHeadView()
        this.SetRecordView({})
        SetActive(this.pageBtn,false)
    elseif this.curLabel == this.labelType.rules then
        this.SetRulesView()
        this.SetRecordView({})
        SetActive(this.pageBtn,false)
    elseif this.curLabel == this.labelType.record then
        this.pageIndex = 1
        if this.cardPoolData.type == "time" then
            this.typeLabel = this.typeEnum.time
        elseif this.cardPoolData.type == "normal" then
            this.typeLabel = this.typeEnum.normal
        elseif this.cardPoolData.type == "oldtime" or this.cardPoolData.type == "newPlayer" then
            this.typeLabel = this.typeEnum.oldTime
        elseif this.cardPoolData.type == "limited" then
            this.typeLabel = this.typeEnum.limited
        end
        this.GetDrawCardHistory()
        this.UpdateTypeLabel()
    end
end


this.InitGetView = function()
    this.poolName = this.vm.behaviour.transform:Find("root/_Middle/PoolInfo/PoolName"):GetComponent("Text")
    this.typeText = this.vm.behaviour.transform:Find("root/_Middle/PoolInfo/Type/Text"):GetComponent("Text")
    this.ssrProbability = this.vm.behaviour.transform:Find("root/_Middle/PoolInfo/SSR/Probability"):GetComponent("Text")
    this.srProbability = this.vm.behaviour.transform:Find("root/_Middle/PoolInfo/SR/Probability"):GetComponent("Text")
    this.rProbability = this.vm.behaviour.transform:Find("root/_Middle/PoolInfo/R/Probability"):GetComponent("Text")
    this.newHead = this.vm.behaviour.transform:Find("root/_Middle/PoolInfo/NewHead").gameObject
    this.newHeadText = this.vm.behaviour.transform:Find("root/_Middle/PoolInfo/NewHead/Text"):GetComponent("Text")
    this.newHeadScroll = UIScrollView.New(this.vm.behaviour.transform:Find("root/_Middle/PoolInfo/NewHead/Scroll").gameObject)
    this.newHeadTemplate = this.vm.behaviour.transform:Find("template/NewHeadItem").gameObject

    this.middleRect = this.vm.behaviour.transform:Find("root/_Middle"):GetComponent("RectTransform")
    this.headMask = this.vm.behaviour.transform:Find("root/_Middle/Labels/Head/Mask").gameObject
    this.headView = this.vm.behaviour.transform:Find("root/_Middle/HeadView").gameObject
    this.headScroll = UIScrollView.New(this.vm.behaviour.transform:Find("root/_Middle/HeadView/Scroll").gameObject)
    this.headTitle = this.vm.behaviour.transform:Find("template/HeadTitle").gameObject
    this.headGroup = this.vm.behaviour.transform:Find("template/HeadGroup").gameObject
    this.headTemplate = this.vm.behaviour.transform:Find("template/HeadItem").gameObject
    
    this.rulesMask = this.vm.behaviour.transform:Find("root/_Middle/Labels/Rules/Mask").gameObject
    this.rulesView = this.vm.behaviour.transform:Find("root/_Middle/RulesView").gameObject
    this.rulesScroll = this.vm.behaviour.transform:Find("root/_Middle/RulesView/Scroll"):GetComponent("ScrollRect")
    this.introText = this.vm.behaviour.transform:Find("root/_Middle/RulesView/Scroll/Viewport/IntroText"):GetComponent("Text")
    
    this.recordMask = this.vm.behaviour.transform:Find("root/_Middle/Labels/Record/Mask").gameObject
    this.recordView = this.vm.behaviour.transform:Find("root/_Middle/RecordView").gameObject
    this.tipText = this.vm.behaviour.transform:Find("root/_Middle/RecordView/TipText"):GetComponent("Text")
    this.notRecord = this.vm.behaviour.transform:Find("root/_Middle/RecordView/NotRecord").gameObject
    this.pageBtn = this.vm.behaviour.transform:Find("root/_Middle/RecordView/PageBtn").gameObject
    this.typeContent = this.vm.behaviour.transform:Find("root/_Middle/RecordView/TypeContent").gameObject
    this.typeLabelText = this.vm.behaviour.transform:Find("root/_Middle/RecordView/Type/Text"):GetComponent("Text")
    
    this.typeBtnText_1 = this.vm.behaviour.transform:Find("root/_Middle/RecordView/TypeContent/Time/Text"):GetComponent("Text")
    this.typeBtnChoose_1 = this.vm.behaviour.transform:Find("root/_Middle/RecordView/TypeContent/Time/Choose").gameObject
    this.typeBtnChooseText_1 = this.vm.behaviour.transform:Find("root/_Middle/RecordView/TypeContent/Time/Choose/Text"):GetComponent("Text")
    this.typeBtnText_2 = this.vm.behaviour.transform:Find("root/_Middle/RecordView/TypeContent/Normal/Text"):GetComponent("Text")
    this.typeBtnChoose_2 = this.vm.behaviour.transform:Find("root/_Middle/RecordView/TypeContent/Normal/Choose").gameObject
    this.typeBtnChooseText_2 = this.vm.behaviour.transform:Find("root/_Middle/RecordView/TypeContent/Normal/Choose/Text"):GetComponent("Text")
    this.typeBtnText_3 = this.vm.behaviour.transform:Find("root/_Middle/RecordView/TypeContent/OldTime/Text"):GetComponent("Text")
    this.typeBtnChoose_3 = this.vm.behaviour.transform:Find("root/_Middle/RecordView/TypeContent/OldTime/Choose").gameObject
    this.typeBtnChooseText_3 = this.vm.behaviour.transform:Find("root/_Middle/RecordView/TypeContent/OldTime/Choose/Text"):GetComponent("Text")
    this.typeBtnText_4 = this.vm.behaviour.transform:Find("root/_Middle/RecordView/TypeContent/Limited/Text"):GetComponent("Text")
    this.typeBtnChoose_4 = this.vm.behaviour.transform:Find("root/_Middle/RecordView/TypeContent/Limited/Choose").gameObject
    this.typeBtnChooseText_4 = this.vm.behaviour.transform:Find("root/_Middle/RecordView/TypeContent/Limited/Choose/Text"):GetComponent("Text")
    
    local nodeRoot = this.vm.behaviour.transform:Find("root/_Middle/RecordView/Content"):GetComponent("RectTransform")
    this.GetHistoryTextNode(nodeRoot)
    nodeRoot = this.vm.behaviour.transform:Find("root/_Middle/RecordView/PageBtn"):GetComponent("RectTransform")
    this.GetPageBtnNode(nodeRoot)
    nodeRoot = nil
end


local historyTextNode = {
    rareText = {path = "Image/Text",type = "Text"},
    nameText = {path = "Image/Text/Text",type = "Text"},
    poolNameText = {path = "Image/Text/Text/Image/Text",type = "Text"},
    timeText = {path = "Image/Text/Text/Image/Text/Text",type = "Text"},
}
this.GetHistoryTextNode = function(transform)
    this.recordTextRoot = {}
    local object,item = nil,{}
    local length = transform.childCount - 2
    for i = 1, length do
        object = transform:Find("Record"..i)
        item = {}
        UITool.Parse(object,item,historyTextNode)
        if this.recordTextRoot[i] == nil then
            item.rectRoot = object
            this.tableInsert(this.recordTextRoot,item)
        end
    end
    historyTextNode,object,item,length = nil,nil,nil,nil
end


local pageBtnNode = {
    mask = {path = "Mask",type = "GameObject"},
    pageText = {path = "Text",type = "Text"},
    btnObj = {path = "Btn",type = "GameObject"},
}
this.GetPageBtnNode = function(transform)
    this.numPageBtnRoot = {}
    local object,item = nil,{}
    local length = transform.childCount - 2
    for i = 1, length do
        object = transform:Find("NumPage"..i)
        item = {}
        UITool.Parse(object,item,pageBtnNode)
        if this.numPageBtnRoot[i] == nil then
            item.rectRoot = object
            item.pageNum = 0
            this.tableInsert(this.numPageBtnRoot,item)
        end
    end
    pageBtnNode,object,item,length = nil,nil,nil,nil
end

return vm({
    data = data,
    command = command,
    hook = hook
})