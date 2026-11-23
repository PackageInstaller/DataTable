







local this = {

    roundItems = nil
}

local objs = {
    roundItem = {path = "template/RoundItem", type = BalatroUtil.GameObject},
    closeBtn = {path = "root/Middle/ExitBtn", type = BalatroUtil.Button},
    continueBtn = {path = "root/Middle/_FixObj/_BG/ContinueBtn", type = BalatroUtil.Button},
    titleText = {path = "root/Middle/TitleText", type = BalatroUtil.Text},
    titleText1 = {path = "root/Middle/TitleText1", type = BalatroUtil.Text},
    roundText = {path = "root/Middle/RoundText", type = BalatroUtil.Text},
    roundGroup = {path = "root/Middle/RoundGroup", type = BalatroUtil.Transform}
}

this.before_awake = function()
    LuaMgr.AddClick(this.closeBtn, this.OnClickClose)
    LuaMgr.AddClick(this.continueBtn, this.OnClickClose)
    this.roundItems = {}
    for i = 1, 3 do
        local roundItem = BalatroRoundItem.New(this.roundItem, this.roundGroup)
        table.insert(this.roundItems, roundItem)
    end
end

this.before_active = function()
    local itemsLen = #this.roundItems
    local roundDatas, phaseNum = BalatroStepMgr.GetCurPhaseData()
    if not roundDatas then
        return
    end
    local curRound = BalatroStepMgr.GetCurRoundData()
    local curRoundNum = curRound:GetRound()
    for i = 1, itemsLen do
        local roundData = roundDatas[i]
        local item = this.roundItems[i]
        local sceneEffect = roundData:GetSceneEffect()
        local sceneDes = sceneEffect and sceneEffect:GetDes() or ""
        local data = {
            roundIndex = roundData:GetRound(),
            sceneEffectDes = sceneDes,
            goalScore = roundData:GetRealGoalScore(),
            curRoundIndex = curRoundNum
        }
        item:SetRoundData(data)
        SetActive(item.gameObject, true)
    end
    local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20019")
    this.titleText.text = string.format(tipsContent, phaseNum)
    this.titleText1.text = this.titleText.text
    this.roundText.text = string.format("%d/3", curRoundNum)
end

this.OnClickClose = function()
    LuaMgr.HidePanel(UIName.BalatroPhasePreviewPopup)
    if BalatroStepMgr.CheckNewPhase() == true then
        BalatroStepMgr.PhaseStart()
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroStartNewRound)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
    end,
    before_active = function(vm)
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose)
        LuaMgr.RemoveClick(this.continueBtn, this.OnClickClose)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)