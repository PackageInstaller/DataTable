




require("ViewModel/Home/MailItemModel")
local this = {vm = nil,mailIndex = nil,jumpMailId=nil,txtContent = nil,hrefInfos = {},
              ITEM_ICON_PATH = "Assets/_BundleResources/Images/ItemIcons/itemicon_",mailList = nil,
              viewPortRect=nil,mailItemScroll = nil,mailTemplate = nil,tableInsert = table.insert,
              topIndex=1,
}

local data = {
    notMail = false,
    haveMial = false,
    mailCount = "",
    mailName = "",
    mailSend = "",
    mailTime = "",
    mailContent = "",
    getBtn = Vector3.zero,
    alreadyGet = Vector3.zero,
    mialScroll = 0.0,
    contentWidth = Vector2.zero,
    rewardScroll = 0.0,


    rewardList = {{itemId = "",rare = DefaultSprite,icon = DefaultTexture,rewardCount = ""}},
    

    topRawImgURL="",
    mailTextBool=true,
    mailImgBool=false,
    offset=Vector2(0,0);
    

    topAllActive=false;
    topLikeActive=false;
    mailLikeGray=false;
    mailLikeActive=false;
    mailDeleteBtnActive=false;
}

local command = {

    getRewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OperationMail(2)
        end
    },

    deleteCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.curMailData~=nil and this.curMailData.isFavorite then

                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,ConfigMgr.LangGlobal("22611"),nil)
                return;
            end
            if this.CheckMailReward() then
                this.OperationMail(3)
            else
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2002"].NameLan)
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tipStr,nil)
            end
        end
    },

    allGetCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.CheckAllMailStatus(2) > 0 then
                this.OperationAllMail(2)
            else
                AudioMgr.Singleton:PlayVoice(Path.audio_PATH.."newUI/Click_special_1.mp3")
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2174"].NameLan)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
            end
        end
    },

    allDeleteCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.CheckAllMailStatus(3) > 0 then
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2003"].NameLan)
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tipStr,function()
                    this.OperationAllMail(3)
                end,nil)
            else
                AudioMgr.Singleton:PlayVoice(Path.audio_PATH.."newUI/Click_special_1.mp3")
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2175"].NameLan)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
            end
        end
    },
    rewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local id = this.vm.data.rewardList[param + 1].itemId
            local type = ConfigMgr.Config.itemMap[id].type
            if type == 9 then
                LuaMgr.ShowPanel(UIName.WeaponTipsViewModel, id)
            elseif type == 11 then
                LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,id,false,false,false,0)
            else
                LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,id,false,false,false)
            end
        end
    },
    topRawImgLinkCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.jumpMailId = this.mailItemScroll.dataList[this.mailIndex].data.data.mailId
            local mailData = DataMgr.Player.mails[this.jumpMailId]
            if mailData.jumpUrl~=nil and mailData.jumpUrl~="" then
                NoticeMgr.GoToPanel(mailData.jumpUrl);
            end
        end
    },
    TopAllOrLikeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index=tonumber(param);
            if this.topIndex==index then return end;
            this.topIndex=index;
            this.SetTopState();
        end
    },
    MailLikeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OperationMailFavorite();
        end
    },
    MailCancelLikeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OperationMailFavorite(-2);
        end
    },
}


local OnPointerText = function(url)    
    LuaMgr.MailClickLink(this.mailItemScroll.dataList[this.mailIndex].data.data.mailId)
    LuaMgr.OpenURL(url)
end

local hook = {
    before_awake = function(vm)
        this.vm = vm
        local tf = vm.behaviour.transform
        this.txtContent = tf:Find("root/Middle/Content/MailInfo/offSet/ContentText/Viewport/Text"):GetComponent(typeof(CS.HyperlinkText))
        this.viewPortRect=tf:Find("root/Middle/Content/MailInfo/offSet/ContentText/Viewport"):GetComponent("RectTransform");
        this.mailTemplate = tf:Find("template/MailItem").gameObject
        this.mailItemScroll = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Content/MailView").gameObject)
        this.txtContent.onHrefClick:AddListener(OnPointerText)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.ScreenMonitorType("t_5");
        this.AddUIEvent()
        vm.behaviour:UpdateTopBar("", this.OnBack)
        this.mailIndex = 1
        this.topIndex=1;
        this.GetMailList()
        this.SetTopState();

    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.mailList = {}
        this.favoriteList={};
        this.RemoveUIEvent()
        this.mailItemScroll:Clear(false)
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("MailItemModel")
        this = nil
    end,
}

this.AddUIEvent = function()
    LuaMgr.AddUIEventListener(UIEventConst.MailItemChoose, this.ItemClickEvent)
end
this.RemoveUIEvent = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.MailItemChoose, this.ItemClickEvent)
end


this.SetTopState=function()
    this.vm.data.topAllActive=this.topIndex==1;
    this.vm.data.topLikeActive=this.topIndex==2;
    this.vm.data.mailLikeGray=false;
    this.vm.data.mailLikeActive=false;
    this.mailIndex=1;
    this.SetMailViewData(true)
    this.CalculateMailCount();
end


this.SetMailViewData = function(scroll)
    local isShow = false
    this.mailItemScroll:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local mailTypeList={};
    if this.topIndex==1 then
        mailTypeList=this.mailList;
    else
        mailTypeList=this.favoriteList;
    end
    for i = 1, #mailTypeList do
        isShow = true
        groupData = {}
        groupData.item = this.mailTemplate
        groupData.data = DataMgr.Player.mails[mailTypeList[i].mailId]
        groupData.index = i
        groupData.select = false
        scrollData = UIScrollData.GetData(this.mailTemplate,"MailItemModel",368,85 + 10,groupData)
        this.tableInsert(scrollDatas,scrollData)
    end
    this.mailItemScroll:SetParams(400,519)
    this.mailItemScroll:SetPadding(0,0,-5,0)
    this.mailItemScroll:SetData(scrollDatas, scroll)
    this.CheckMailIndex();
    this.vm.data.haveMial = isShow
    this.curMailData=nil;
    if isShow then
        if this.mailIndex>#mailTypeList then
            this.mailIndex=#mailTypeList;
        end
        this.SetItemChoose(this.mailIndex)
    end
    this.vm.data.notMail = not isShow
end

this.MailItemSort = function(tempData)
    table.sort(tempData,function(a, b)
        if a.status == b.status then
            return a.startTime > b.startTime
        else
            return a.status < b.status
        end
    end)
end

this.ItemClickEvent = function(args)
    if args.Length == 0 then return end
    local index = args[0]
    this.SetItemChoose(index)
end

this.SetItemChoose = function(index)
    if this.mailItemScroll.itemMap[this.mailIndex] ~= nil then
        this.mailItemScroll.itemMap[this.mailIndex]:CloseChoose()
    end
    this.mailItemScroll.dataList[this.mailIndex].data.select = false
    this.mailIndex = index
    if this.mailItemScroll.itemMap[this.mailIndex] == nil then
        this.mailItemScroll:MoveToIndex(this.mailIndex)
    end
    this.mailItemScroll.itemMap[this.mailIndex]:OpenChoose()
    this.mailItemScroll.dataList[this.mailIndex].data.select = true
    
    this.MailDetails()
end


this.MailDetails = function()
    local mailId = this.mailItemScroll.dataList[this.mailIndex].data.data.mailId
    local mailData = DataMgr.Player.mails[mailId]
    if mailData == nil then 
        this.curMailData=nil;
        return
    end
    this.curMailData=mailData;
    this.vm.data.mailLikeGray=not mailData.isFavorite;
    this.vm.data.mailLikeActive=mailData.isFavorite;
    this.vm.data.mailDeleteBtnActive=not mailData.isFavorite;
    if mailData.imgUrl~=nil and mailData.imgUrl~="" then
        this.vm.data.mailImgBool=true;
        this.vm.data.mailTextBool=false;
        this.vm.data.topRawImgURL=mailData.imgUrl;
        this.vm.data.offset=Vector2(0,-70);
        this.viewPortRect.offsetMin=Vector2(0,70)
    else
        this.vm.data.mailImgBool=false;
        this.vm.data.mailTextBool=true;
        this.vm.data.topRawImgURL="";
        this.vm.data.offset=Vector2(0,0);
        this.viewPortRect.offsetMin=Vector2(0,5)
    end
    this.vm.data.mailName = mailData.theme
    this.vm.data.mailSend = LuaMgr.GetLangText("MailViewModel_0")..ConfigMgr.Config.senders[mailData.sender].nickname
    this.vm.data.mailTime = LuaMgr.GetLangText("MailViewModel_1")..os.date("%Y/%m/%d  %H:%M",mailData.startTime)
    this.vm.data.mailContent = mailData.content
    local preferredHeight = this.txtContent.preferredHeight + 20
    this.txtContent.transform.sizeDelta = Vector2(this.txtContent.transform.sizeDelta.x,preferredHeight)

    coroutine_runner.start(function()
        coroutine_runner.waitForEndOfFrame()
        for i = 1, #this.hrefInfos do
            local info = this.hrefInfos[i]
            local result = GetPosAtText(info.startIndex, info.endIndex)
            if #result > 0 then
                for k = 1, #result do               
                    table.insert(info.boxes, result[k])
                end
            end
        end
    end)
    if type(mailData.items) == "function" then
        mailData.items = {}
    end

    local tempList = {}
    local tempReward = nil
    for key,value in pairs(mailData.items) do
        if value.id ~= "undefined" and value.count ~= 0 then
            local itemData = ConfigMgr.Config.itemMap[key]
            if nil ~= itemData then
                tempReward = {itemId = "",rare = DefaultSprite,icon = DefaultTexture,rewardCount = ""}
                tempReward.itemId = key
                tempReward.rare = LuaMgr.GetSprite("ItemRare","itemRare"..itemData.rare)
                tempReward.icon = LuaMgr.GetTexture(this.ITEM_ICON_PATH..key..".png")
                tempReward.rewardCount = tostring(value.count)
                table.insert(tempList,tempReward)
            end
        end
    end
    table.sort(tempList,function(a, b) return tonumber(a.itemId)<tonumber(b.itemId) end)
    this.RewardsScroll(#tempList)
    this.vm.data.rewardList = tempList
    if #tempList > 0 and mailData.status < 2 then
        this.vm.data.getBtn = Vector3.one
        this.vm.data.alreadyGet = Vector3.zero
    elseif #tempList > 0 and mailData.status == 2 then
        this.vm.data.getBtn = Vector3.zero
        this.vm.data.alreadyGet = Vector3.one
    elseif #tempList == 0 then
        this.vm.data.getBtn = Vector3.zero
        this.vm.data.alreadyGet = Vector3.zero
    end
    if mailData.status == 0 then this.OperationMail(1) end
end


this.CheckMailIndex=function()
    if this.jumpMailId==nil then return end;
    for i,v in ipairs(this.mailItemScroll.dataList) do
        if v.data.data.mailId==this.jumpMailId then
            this.mailIndex=i;
            break;
        end
    end
    this.jumpMailId=nil;
end


this.RewardsScroll = function(count)
    local width = count * 100 + (count - 1) * 10
    local scrollWidth = 740 + LuaMgr.GetScreenAddWidth()
    if width < scrollWidth then
        width = scrollWidth
    end
    this.vm.data.contentWidth = Vector2(width,100)
    this.vm.data.rewardScroll = 0
end

this.OperationMail = function(status)
    local tempData = {}
    tempData.MailID = this.mailItemScroll.dataList[this.mailIndex].data.data.mailId
    tempData.OpType = status
    ApiMgr.Request("op_mail", tempData, true, function(result)
        local re = json.decode(result)
        local results = json.encode(re.result)
        if re.code == 0 then
if status == 1 then
                this.SetMailViewData(false)
elseif status == 2 then
                LuaMgr.ShowMailRewared(results)
                this.SetMailViewData(false)
elseif status == 3 then
                this.GetMailList()
                this.CalculateMailCount()
                this.OpMailResult()
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2176"].NameLan)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
            end
        end
    end, this.OpMailResult, true)
end


this.OperationAllMail = function(status)
    local tempData = {}
    tempData.MailID = ""
    tempData.OpType = status
    tempData.Type=status==2 and 0 or 1;
    ApiMgr.Request("op_mail", tempData, true, function(result)
        local re = json.decode(result)
        local results = json.encode(re.result)
if re.code == 0 and status == 2 then
            LuaMgr.ShowMailRewared(results)
            this.SetMailViewData(false)
elseif re.code == 0 and status == 3 then
            this.GetMailList()
            this.CalculateMailCount()
            this.OpMailResult()
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2176"].NameLan)
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
        end
    end, this.OpMailResult, true)
end


this.OperationMailFavorite=function(opType)
    if this.curMailData==nil then return end;
    local tempData = {}
    tempData.MailID = this.curMailData.mailId
    if opType~=nil then

        tempData.OpType=opType;
        if not this.curMailData.isFavorite then

            return
        end
    else
        tempData.OpType = not this.curMailData.isFavorite and -1 or -2;
    end
    if tempData.OpType==-1 and #this.favoriteList>= ConfigMgr.Config.constants.maxCollectrMails then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("22650"));
        return;
    end
    ApiMgr.Request("op_mail", tempData, true, function(result)
        local re = json.decode(result)
        if re.code == 0 then
                this.GetMailList()
                this.SetMailViewData(false)
                this.CalculateMailCount()
               
        end
    end, this.OpMailResult, true)
end


this.CheckMailReward = function()
    local status = this.mailItemScroll.dataList[this.mailIndex].data.data.status
    if #this.vm.data.rewardList == 0 then return true end
    if status == 2 then return true end
    return false
end


this.CheckAllMailStatus = function(type)
    local count = 0
    if type == 2 then
        for key,value in pairs(DataMgr.Player.mails) do
            if value.status == 0 and next(value.items) ~= nil then
                count = count + 1
            end
            if value.status == 1 and next(value.items) ~= nil then
                count = count + 1
            end
        end
    elseif type == 3 then
        for key,value in pairs(DataMgr.Player.mails) do
            if not value.isFavorite then
                if value.status == 2 then
                    count = count + 1
                end
                if value.status == 1 and next(value.items) == nil then
                    count = count + 1
                end
                if  value.expireTime < LuaMgr.Timestamp() then
                    count = count + 1
                end
            end
        end
    end
    return count
end


this.CalculateMailCount = function()

    local count = 0
    if this.topIndex==2 then
        count=#this.favoriteList;
        this.vm.data.mailCount = "<color=#2cf2f0>"..count.."</color>/"..ConfigMgr.Config.constants.maxCollectrMails
        return;
    end
    for key,value in pairs(DataMgr.Player.mails) do
        if value.status ~= 3 and value.status ~= 4 then
            if value.isFavorite or value.expireTime > LuaMgr.Timestamp() then
                count = count + 1
            end
        end
    end
    this.vm.data.mailCount = "<color=#2cf2f0>"..count.."</color>/"..ConfigMgr.Config.constants.maxPlayerMails
end
this.GetMailList = function()
    this.mailList = {}
    this.favoriteList={};
    local index = 1
    for key,value in pairs(DataMgr.Player.mails) do
        if value.status ~= 3 and value.status ~= 4 then
            if value.isFavorite or value.expireTime > LuaMgr.Timestamp() then
                if type(value.items) == "function" then
                    value.items = {}
                end
                this.tableInsert(this.mailList,index,value)
                if value.isFavorite then

                    this.tableInsert(this.favoriteList,value);
                end
                index = index + 1
            end
        end
    end
    this.MailItemSort(this.mailList)
    this.MailItemSort(this.favoriteList);
end
this.OnBack=function()
    this.jumpMailId=nil;
    LuaMgr.Back();
end
this.OpMailResult = function()
    this.mailIndex = 1
    mialScroll = 1.0
    this.SetMailViewData(true)
end
return vm({
    data = data,
    command = command,
    hook = hook
})