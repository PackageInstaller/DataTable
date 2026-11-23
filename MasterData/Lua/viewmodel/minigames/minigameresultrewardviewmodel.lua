



local this = { vm = nil }
local RewardObj
local RememberCard = {}
local ITEM_ICON_PATH = "Assets/_BundleResources/Images/ItemIcons/itemicon_%s.png";
local data = {
    isBest = false,
    isBatter = false,
    isMiddle = false,
    isFail = false,
    itemnum = "",
    itemIcon = DefaultTexture,
    showRewardPanel = false,
    miniCardList = {
        {
            itemId = "",
            cardIcon = DefaultTexture,
            animatorname = "",
            objactive = false,
        }
    },
    FailStateShow = {
        {
            fail = false,
            unfail = true,
            indexNum = "",
        }
    },
}
local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.MiniGameResultRewardViewModel)
            LuaMgr.InvokeUIEventListeners(UIEventConst.CollectorEventPanelClose);
            local fun = this.vm.behaviour.Params[1]
            fun()
        end
    }, ClickBackToFont = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

        end
    }
    , ClickFontToBack = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.miniCardList[param + 1].animatorname = "MiniGameAnimationBack"
            this.removeCard(param + 1)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        RewardObj = this.vm.behaviour.transform:Find("root/RewardShow"):GetComponent("Animator")
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            local types = tonumber(vm.behaviour.Params[0])
            this.vm.data.isBest = types == 0
            this.vm.data.isBatter = types == 1
            this.vm.data.isMiddle = types == 2
            this.vm.data.isFail = types == 3
            if vm.behaviour.Params[2] ~= nil then
                local id, num = vm.behaviour.Params[2], vm.behaviour.Params[3]
                this.showRewardAnimation(id, num)
            end

        end
    end,
    before_deactive = function(vm)
        this.vm.data.showRewardPanel = false
    end
}

this.showRewardAnimation = function(id, num)
    this.vm.data.itemnum = "+" .. num
    this.vm.data.itemIcon = LuaMgr.GetTexture(string.format(ITEM_ICON_PATH, id));
    this.vm.data.showRewardPanel = true
    RewardObj:Play("MiniGamesRewardTip_1", 0, 0)
end



return vm({
    data = data,
    command = command,
    hook = hook
})