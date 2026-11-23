



local this = { vm = nil }

local Currentquestion = "1003"

local QSpineChatar
local clickItem = 0
local fish

local data = {
    fishPosPower = Vector3.zero,
    fishPos = Vector2.zero,
    PowerSlider = 0,
    BombItemList = {
        {
            name = "",
            showText = "",
            object = false
        }
    },
    QuestionStateShow = {
        {
            stateicon = DefaultSprite,
            selectLight = DefaultSprite,
            currentSate = false,
            playAnimation = false,
            stateName = ""
        }
    },
}
local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.MiniGameBombViewModel)
        end
    },
    clickBombItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            clickItem = param + 1
            local ShowTest = tonumber(this.vm.data.BombItemList[clickItem].showText)
            local currentlive = this.vm.data.BombItemList[clickItem].object
            if currentlive then
                if ShowTest + 1 > 4 then
                    this.vm.data.BombItemList[clickItem].object = false
                    this.getRoundIndex(clickItem)
                else
                    this.vm.data.BombItemList[clickItem].showText = tostring(tonumber(ShowTest) + 1)
                end
            end


        end
    }

}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            this.InitQuestionAnswer()
            LuaMgr.AddUpdate(this.OnUpdate);
            this.initData()

        end
    end,
    before_deactive = function(vm)
    end
}

this.OnUpdate = function()

end

this.initData = function()
    local tempList = {}
    for i = 1, 16, 1 do
        local showText = math.random(0, 4)
        local Novelitem = {
            name = tostring(i),
            showText = "1",
            object = true
        }
        table.insert(tempList, Novelitem)
    end
    this.vm.data.BombItemList = tempList
end

this.getRoundIndex = function(index)
    local round = {}
    local Line = 4
    local MaxtrowNum = 4
    local MaxLineNum = 4
    local LineNum = index % Line
    local throwNum = math.modf(index / Line) + 1
    if LineNum == 0 then
        LineNum = Line
        throwNum = throwNum - 1
    end
    LuaDebug.error(throwNum .. "行" .. LineNum .. "列")
    if LineNum + 1 <= MaxLineNum then
        local numgroups = { throwNum, LineNum + 1 }
        table.insert(round, numgroups)
    end
    if LineNum - 1 > 0 then
        local numgroups = { throwNum, LineNum - 1 }
        table.insert(round, numgroups)
    end
    if throwNum + 1 <= MaxtrowNum then
        local numgroups = { throwNum + 1, LineNum }
        table.insert(round, numgroups)
    end
    if throwNum - 1 > 0 then
        local numgroups = { throwNum - 1, LineNum }
        table.insert(round, numgroups)
    end
    for index, value in ipairs(round) do

        local indexs = Line * (value[1] - 1) + value[2]
        LuaDebug.error(value[1] .. "临近行" .. value[2] .. "临近列" .. indexs .. "第几个")
        local ShowTest = tonumber(this.vm.data.BombItemList[indexs].showText)
        local currshow = this.vm.data.BombItemList[indexs].object
        if currshow then
            if ShowTest + 1 > 4 then
                this.vm.data.BombItemList[indexs].object = false
                coroutine_runner.start(
                function()
                    coroutine_runner.wait(1)
                    this.getRoundIndex(indexs)
                end
                )
            else
                this.vm.data.BombItemList[indexs].showText = tostring(ShowTest + 1)
            end
        end


    end

end


this.InitQuestionAnswer = function()
    local characterId, skinId = "W0079", "W0051001"
    local pos = Vector3(0, 0, 0)

    QSpineChatar = this.vm.behaviour.transform:Find("root/Middle/HeroPos/QSpine/Spine/3DObject"):GetComponent(
    "UISpineCharacter"
    )
    QSpineChatar:Clear()
    QSpineChatar:SetBattle(characterId, "W0079001", "", ConfigMgr.Config.characterTable[characterId].job)

end



return vm({
    data = data,
    command = command,
    hook = hook
})