require("ViewModel/BossDummy3/ActivityBossDummy3DelegateBattleResultPopupItem")

local this =
{
    vm = nil,
}

local data = 
{
    text_score = "1",
    text_count = "1",
}

local objs = 
{
    score_list_go   = { path = "root/Middle/ui_scroll_item/Viewport/Content", type = "GameObject" },
    item_go         = { path = "template/score_item", type = "GameObject" },
}

local command =
{
    on_click_back_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_back_btn()
        end
    },
}

local hook =
{
    before_awake = function(vm)
        this.vm = vm
        this.gameObject = this.vm.behaviour.gameObject
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then 
            return 
        end
        this.on_before_active()
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params == nil then 
            return 
        end
        this.on_before_deactive()
    end, 
}

function this.on_before_active()
    UITool.Parse(this.gameObject, this, objs)
    local params = this.vm.behaviour.Params
    local count = params[0]

    this.vm.data.text_count = LuaMgr.GetLangText("ActivityBossDummy3DelegateBattleResultPopupViewModel_0") .. string.format("<color=#B47240>%s</color>/%s", tostring(BossDummy3Mgr.GetBossDummy3TodayEffectScoreCount()), tostring(BossDummy3Mgr.GetBossDummy3TodayLimitScoreCount()))
    this.vm.data.text_score = tostring(BossDummy3Mgr.GetBossDummy3HighestScore() * count)

    this.score_list = UIListView.New(this.score_list_go.transform)
    local data_list = {}
    for i = 1, count, 1 do
        local element = {}
        element.index = i
        element.score = BossDummy3Mgr.GetBossDummy3HighestScore()

        local data = UIListData.GetData(this.item_go, "ActivityBossDummy3DelegateBattleResultPopupItem", element)
        table.insert(data_list, data)
    end
    this.score_list:SetData(data_list, true)
end

function this.on_before_deactive()
    this.score_list:Clear()
    UIListView.ClearItem("ActivityBossDummy3DelegateBattleResultPopupItem")
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.ActivityBossDummy3DelegateBattleResultPopupViewModel)
end

return vm
(
    {
        data    = data,
        command = command,
        hook    = hook
    }
)