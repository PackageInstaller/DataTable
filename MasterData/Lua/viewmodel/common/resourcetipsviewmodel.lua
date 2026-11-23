



local this = {vm = nil}
local bgPosDefault = Vector2.zero
local offsetX = 0
local bgWidth = 0
local tsMiddle = nil
local tsTip = nil
local bgScale = Vector3.one

local data = {
    pos = Vector2.one,
    bgPos = Vector2.zero,
    bgScale = Vector3.one,
    tip = ""
}

local command = {
    clickMask = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.Back()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        
        bgScale = Vector3.one
        tsMiddle = vm.behaviour.transform:Find('root/Middle'):GetComponent('RectTransform')
        tsTip = vm.behaviour.transform:Find('root/Middle/Tip')
        local tsBottom = tsTip:Find('Bottom')
        local tsBg = tsBottom:Find("Bg")

        offsetX = tsBottom.anchoredPosition.x
        bgPosDefault = tsBottom.anchoredPosition

        bgWidth = tsBg:GetComponent('RectTransform').sizeDelta.x
    end,

    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        local tarPos = vm.behaviour.Params[0]
        local offset = vm.behaviour.Params[1]
        local tip = vm.behaviour.Params[2]

        local screenWidth = UnityEngine.Screen.width / UnityEngine.Screen.height * 720 
        if(screenWidth < 1280) then
            screenWidth = 1280
        end

        local uiPos = LuaMgr.World2Local(tarPos, tsMiddle)
        
        uiPos = uiPos + offset
        uiPos.y = uiPos.y - 10

        this.vm.data.pos = uiPos
        this.vm.data.tip = tip

        local minX = -(screenWidth / 2) + bgWidth / 2 - offsetX + 20
        local maxX = screenWidth / 2 - bgWidth / 2 - offsetX - 20
        local result = bgPosDefault
        local x = tsTip.anchoredPosition.x
        local bgX = offsetX
        if (x > maxX) then
            bgX = maxX - x + offsetX
        end
        if (x < minX) then
            bgX = minX - x + offsetX
        end
        result.x = bgX     

        if(bgX > 0) then
            bgScale.x = -1
        else
            bgScale.x = 1
        end
        this.vm.data.bgPos = result
        this.vm.data.bgScale = bgScale
    end,
    after_destroy = function(vm)
        bgPosDefault = nil
        tsMiddle = nil
        tsTip = nil
        bgScale = nil
    end
}

return vm({
    data = data,
    command = command,
    hook = hook,
})