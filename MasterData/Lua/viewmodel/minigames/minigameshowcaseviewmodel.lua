



local this = { vm = nil }
local RewardObj
local RememberCard = {}
local characterPath
local ITEM_ICON_PATH = "Assets/_BundleResources/Images/ItemIcons/itemicon_%s.png";
local data = {
    showcaseItem = {
        {
            itemId = "",
            Icon = DefaultTexture,
        }
    },
}
local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.MiniGameShowcaseViewModel)
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
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            this.InitShowCase()

        end
    end,
    before_deactive = function(vm)

    end
}

this.InitShowCase = function()
    local tempList = {}

    characterPath = Path.Character_PATH .. "W0051" .. "/Drawing/" .. "W0051001" .. ".png";
    for i = 1, 9, 1 do

        local case = {
            itemId = "1",
            Icon = LuaMgr.GetTexture(characterPath),
        }
        table.insert(tempList, case)
    end
    this.vm.data.showcaseItem = tempList
end




return vm({
    data = data,
    command = command,
    hook = hook
})