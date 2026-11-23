




require("ViewModel/CardPool/WishItem")


local this = {
    vm = nil,wishScroll = nil,wishTemplate = nil,cardPoolData = nil,curIndex = -1,
    heroId = nil,isClickActive = true,
}

local data = {
    titleText = "",confirmText = "",
    confirmBtn = false,tipText = "",
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.CardPoolWishPopup)
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.curIndex == -1 or this.curIndex == nil then return end
            if this.isClickActive then
                this.isClickActive = false
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["17210"].NameLan)
                LuaMgr.ShowPanel
                (
                        UIName.ConfirmSmallViewModel,tipStr,
function()
                            local tempData = {}
                            tempData["cardPool"] = this.cardPoolData.id
                            tempData["character"] = this.heroId
                            ApiMgr.Request("draw_card_select", tempData,true,function(result)
                                local re = json.decode(result)
                                if re.code == 0 then
                                    this.isClickActive = true
                                    LuaMgr.InvokeUIEventListeners(UIEventConst.CardPoolSelectWish)
                                    LuaMgr.HidePanel(UIName.CardPoolWishPopup)
                                end
                            end,nil,true)
                        end,
function()
                            this.isClickActive = true
                        end
                )
            end
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.wishTemplate = vm.behaviour.transform:Find("template/WishItem").gameObject
        this.wishScroll = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/WishList").gameObject)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("WishItem")
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()
    this.wishScroll:Clear()
end


this.InitParameter = function()
    if this.vm.behaviour.Params.Length <= 0 then
        return
    end
    this.isClickActive = true
    local cardId = this.vm.behaviour.Params[0]
    this.cardPoolData = ConfigMgr.Config.cardPools[cardId]
    if TableIsNull(DataMgr.Player.drawCard.drawCharacterSelect) or DataMgr.Player.drawCard.drawCharacterSelect[cardId] == nil then
        this.curIndex = -1
    else
        for i = 1, #this.cardPoolData.changeList do
            if this.cardPoolData.changeList[i] == DataMgr.Player.drawCard.drawCharacterSelect[cardId][1] then
                this.curIndex = i
                break
            end
        end
    end
    this.vm.data.confirmBtn = true
    this.SetMissionData()
    this.SetLanguageText()
end


this.SetMissionData = function(index)
    this.wishScroll:Clear(false)
    if TableIsNull(this.cardPoolData.changeList) then
        return
    end
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    for i = 1, #this.cardPoolData.changeList do
        groupData = {}
        groupData.data = this.cardPoolData.changeList[i]
        groupData.index = i
        groupData.chooseState = this.curIndex == i
        groupData.callBack = this.WishChoose
        scrollData = UIScrollData.GetData(this.wishTemplate,"WishItem",120 + 30,236,groupData)
        table.insert(scrollDatas,scrollData)
    end
    this.wishScroll:SetParams(838,292)
    this.wishScroll:SetPadding(5,0,0,0)
    this.wishScroll:SetData(scrollDatas, true)
end

this.WishChoose = function(index)
    if index == nil then return end
    for i = 1, #this.wishScroll.dataList do
        if i == index and this.curIndex ~= index then
            this.heroId = this.wishScroll.dataList[i].data.data
            this.wishScroll.dataList[i].data.chooseState = true
        else
            this.wishScroll.dataList[i].data.chooseState = false
        end
    end
    this.curIndex = this.curIndex == index and -1 or index
    local curCharacterId = ""
    if not TableIsNull(DataMgr.Player.drawCard.drawCharacterSelect) and DataMgr.Player.drawCard.drawCharacterSelect[this.cardPoolData.id] ~= nil then
        curCharacterId = DataMgr.Player.drawCard.drawCharacterSelect[this.cardPoolData.id][1]
    end
    this.vm.data.confirmBtn = this.curIndex == -1 or curCharacterId == this.heroId
    this.wishScroll:Refresh()
end


this.SetLanguageText = function()
    this.vm.data.titleText = ConfigMgr.LangGlobal("17204")
    this.vm.data.confirmText = ConfigMgr.LangGlobal("17205")
    local count = ConfigMgr.Config.constants.CardPoolChangeNum
    this.vm.data.tipText = count <= 1 and ConfigMgr.LangGlobal("17210") or ""
end

return vm({
    data = data,
    command = command,
    hook = hook
})