




local this = {
    vm = nil,
    callBackFun = nil,
}

local data = {
   ChessRewardList = {
        {
            canget = false,
            notget = false,
            alreadyget = false,
            notGeted = true,
            item_1 = false,
            itemicon_1 = DefaultTexture,
            itemRare_1 = DefaultSprite,
            itemNum_1 = "",
            item_2 = false,
            itemicon_2 = DefaultTexture,
            itemRare_2 = DefaultSprite,
            itemNum_2 = "",
            description = "",

        }
    },
}
local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.ConnectFourRewardViewModel)
        end
    },
    getRewardItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local canGet = this.vm.data.ChessRewardList[param + 1].canget
            if canGet then
                local type = this.vm.data.ChessRewardList[param + 1].type
                local count = this.vm.data.ChessRewardList[param + 1].cnt
                this.GetConnectFourReward(type, count)
            end
        end
    },
    ClickItemShow_1 = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local goodsId
            goodsId = this.vm.data.ChessRewardList[param + 1].rewardTab[1].id
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, goodsId, false, false, false)
        end
    },
    ClickItemShow_2 = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local goodsId
            goodsId = this.vm.data.ChessRewardList[param + 1].rewardTab[2].id
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, goodsId, false, false, false)
        end
    },
}
local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            this.callBackFun = vm.behaviour.Params[0]
            this.InitChessReward()
        end
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then
        end
    end,
    before_destroy = function(vm)
        if vm.behaviour.Params ~= nil then
        end
    end
}


this.InitChessReward = function()
    local data = ConfigMgr.Config.FourInLineVicMap
    local PlayerAchievedata = DataMgr.Player.fourInLine.vicInfo
    local GetRewardTab = DataMgr.Player.fourInLine.award
    local tempet = {}
    local AlreadyNum = 0
    local totolData = 0
    for index, value in pairs(data) do
        local rewardtab = value.VicItem
        if  type(rewardtab) == type(table)  then
            local itemLength = #rewardtab
            local rare1 = itemLength >= 1 and ConfigHelper.GetItemById(rewardtab[1].id).rare or ""
            local rare2 = itemLength == 2 and ConfigHelper.GetItemById(rewardtab[2].id).rare or ""
            local valueType = tostring(value.VicType)
            local RewardTag = tostring(value.VicType) .. "_" .. tostring(value.VicCount)
            local CompletedNum = GetRewardTab[RewardTag] ~= nil and 1 or 0
            AlreadyNum = AlreadyNum + CompletedNum
            totolData = totolData + 1
            local rewardItem = {
                id = value.Id,
                type = valueType,
                cnt = value.VicCount,
                rewardTab = rewardtab,
                canget = (PlayerAchievedata[valueType] ~= nil and PlayerAchievedata[valueType] >= value.VicCount and GetRewardTab[RewardTag] == nil),
                notget = (PlayerAchievedata[valueType] ~= nil and PlayerAchievedata[valueType] < value.VicCount),
                alreadyget = GetRewardTab[RewardTag] ~= nil,
                notGeted = GetRewardTab[RewardTag] == nil,
                item_1 = itemLength == 1,
                itemicon_1 = itemLength >= 1 and ConfigHelper.GetItemTexture(rewardtab[1].id) or DefaultTexture,
                itemRare_1 = itemLength >= 1 and ConfigHelper.GetRareSprite(rare1) or DefaultSprite,
                itemNum_1 = tostring(rewardtab[1].count),
                item_2 = itemLength == 2,
                itemicon_2 = itemLength == 2 and ConfigHelper.GetItemTexture(rewardtab[2].id) or DefaultTexture,
                itemRare_2 = itemLength == 2 and ConfigHelper.GetRareSprite(rare2) or DefaultSprite,
                itemNum_2 = itemLength == 2 and tostring(rewardtab[2].count) or "",
                description = value.VicCountDes,
            }
            table.insert(tempet, rewardItem)
        else
            print("rewardtab not table")
        end
    end
    if this.callBackFun~=nil then
        this.callBackFun(AlreadyNum == totolData)
    end


    table.sort(tempet, function(a, b)
        return tonumber(a.id) < tonumber(b.id)
    end)
    this.vm.data.ChessRewardList = tempet
end

this.GetConnectFourReward = function(type, cnt, fun)
    local data = { Type = type, Cnt = cnt }
    local Url = "fourInLine/getReward"
    ApiMgr.Request(Url, data, true,
    function(result)
        local re = json.decode(result)

        if re.code == 0 then
            local tools = re.result
            local data = json.decode(result);
            if (data ~= nil and data.result ~= nil) then
                if (not IsNull(data.result)) then
                    local reward = json.encode(data.result);
                    LuaMgr.ShowItemRewared(reward);
                    this.InitChessReward()
                    return;
                end
            end
        end
    end,
    function(failCode)
        print("EnterDungeonError,ErrorCode:", failCode)
    end,
    true
    )
end

return vm(
{
    data = data,
    command = command,
    hook = hook
}
)