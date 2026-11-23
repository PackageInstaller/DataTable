







local this = {
    roundStatus = BalatroUtil.RoundStatus.Other,

    dropBrandItems = {}
}

local objs = {
    dropBrandPrefab = {path = "template/BrandShowItem", type = BalatroUtil.GameObject},
    newGameBtn = {path = "root/Middle/ConfirmBtn", type = BalatroUtil.Button},
    backBtn = {path = "root/Middle/BackBtn", type = BalatroUtil.Button},
    remainPlaycardScore = {path = "root/Middle/RemainPlaycardScoreImage/RemainPlaycardScoreText", type = BalatroUtil.Text},
    remainPlaycardScore1 = {path = "root/Middle/RemainPlaycardScoreImage/RemainPlaycardScoreText/RemainPlaycardScoreText1", type = BalatroUtil.Text},
    bestPlayCardScore = {path = "root/Middle/BestPlayCardScoreText", type = BalatroUtil.Text},
    usualBrandTypeInfo = {path = "root/Middle/UsualBrandTypeInfoText", type = BalatroUtil.Text},
    totalPlaycardCount = {path = "root/Middle/TotalPlaycardCountText", type = BalatroUtil.Text},
    totalChangeBrand = {path = "root/Middle/TotalChangeBrandText", type = BalatroUtil.Text},
    totalDiscardCount = {path = "root/Middle/TotalDiscardCountText", type = BalatroUtil.Text},
    totalPropBrandCount = {path = "root/Middle/TotalPropBrandCountText", type = BalatroUtil.Text},
    phaseNum = {path = "root/Middle/PhaseNumText", type = BalatroUtil.Text},
    roundCount = {path = "root/Middle/RoundCountText", type = BalatroUtil.Text},

    defeatObj1 = {path = "root/Middle/_FixObj/_Title/image_01", type = BalatroUtil.GameObject},
    defeatObj2 = {path = "root/Middle/_FixObj/_Title/image_03", type = BalatroUtil.GameObject},
    defeatObj3 = {path = "root/Middle/_FixObj/_Title/image_04", type = BalatroUtil.GameObject},
    victoryObj = {path = "root/Middle/_FixObj/_Title/VictoryObj", type = BalatroUtil.GameObject},
    dropBrandParent = {path = "root/Middle/DropBrandGroup/Content", type = BalatroUtil.RectTransform},
    dropBrandParentLayout = {path = "root/Middle/DropBrandGroup/Content", type = BalatroUtil.HorizontalLayoutGroup},
    evaluateText = {path = "root/Middle/EvaluateText", type = BalatroUtil.Text}
}

this.before_awake = function()
    local zeroStr = "0"
    this.remainPlaycardScore.text = zeroStr
    this.remainPlaycardScore1.text = zeroStr
    this.bestPlayCardScore.text = zeroStr
    this.usualBrandTypeInfo.text = zeroStr
    this.totalPlaycardCount.text = zeroStr
    this.totalChangeBrand.text = zeroStr
    this.totalDiscardCount.text = zeroStr
    this.totalPropBrandCount.text = zeroStr
    this.phaseNum.text = zeroStr
    this.roundCount.text = zeroStr
    this.evaluateText.text = zeroStr
end

this.before_active = function()
    if this.roundStatus == BalatroUtil.RoundStatus.Other then
        return
    end
    local isDefeat = this.roundStatus == BalatroUtil.RoundStatus.Defeat or this.roundStatus == BalatroUtil.RoundStatus.GameOverDefeat
    SetActive(this.defeatObj1, isDefeat)
    SetActive(this.defeatObj2, isDefeat)
    SetActive(this.defeatObj3, isDefeat)
    SetActive(this.victoryObj, this.roundStatus == BalatroUtil.RoundStatus.GameOverVictory)

    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroIntoCalView)
    local statisticsData = BalatroDataMgr.GetStatisticsData()
    if not statisticsData then
        return
    end
    this.remainPlaycardScore.text = BalatroUtil.ToScientific(statisticsData.totalScore)
    this.remainPlaycardScore1.text = BalatroUtil.ToScientific(statisticsData.totalScore)
    local constStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20027")
    this.bestPlayCardScore.text = string.format(constStr, BalatroUtil.ToScientific(statisticsData.bestBrandScore))
    local usualBrandTypeData = BalatroDataMgr.GetBrandTypeDataByID(statisticsData.frequentBrandtype)
    if usualBrandTypeData ~= nil then
        this.usualBrandTypeInfo.text = string.format(LuaMgr.GetLangText("BalatroGameEndPopUp_0"), usualBrandTypeData:GetName(), statisticsData.frequentBrandtypeCount)
    else
        this.usualBrandTypeInfo.text = ""
    end
    this.totalPlaycardCount.text = statisticsData.totalPlaybrand
    this.totalChangeBrand.text = statisticsData.totalChangeBrand
    this.totalDiscardCount.text = statisticsData.totalDisbrand
    this.totalPropBrandCount.text = statisticsData.totalPropsBrand
    this.phaseNum.text = statisticsData.phaseNum
    this.roundCount.text = statisticsData.totalRound
    this.evaluateText.text = statisticsData.evaluateID
    this.SetDropBrand()
end

this.SetDropBrand = function()
    for key, value in pairs(this.dropBrandItems) do
        value:SetVisible(false)
    end
    local allDropBrands = BalatroDataMgr.GetDropBrand()
    local len = #allDropBrands
    for i = 1, len do
        local data = allDropBrands[i]
        local item = this.GetDropItem()
        item:SetSiblingIndex(i)
        item:SetBalatroData(data)
        item:SetVisible(true)
        data:SetOwnStatus(BalatroUtil.BalatroOwnStatus.Old)
    end
    local sizeDelta = this.dropBrandParent.sizeDelta
    local spacing = 9
    local cellSizeX = 88.8
    local maxContentWidth = 860
    if len <= 9 then
        local width = (len - 2) * spacing + cellSizeX * len
        this.dropBrandParent.sizeDelta = Vector2(width, sizeDelta.y)
        this.dropBrandParentLayout.spacing = spacing
    else
        local a = -0.030050505050596144
        local b = 1.647619047623266
        local c = -33.045707070763456
        local d = 193.00627705648702
        spacing = a * len * len * len + b * len * len + c * len + d
        this.dropBrandParent.sizeDelta = Vector2(maxContentWidth, sizeDelta.y)
        this.dropBrandParentLayout.spacing = spacing
    end
end

this.GetDropItem = function()
    for key, value in pairs(this.dropBrandItems) do
        if value:IsVisible() == false then
            return value
        end
    end
    local item = BalatroBrandShowItem.New(this.dropBrandPrefab, this.dropBrandParent, BalatroBrandShowItem.ItemType.Balatro, #this.dropBrandItems + 1)
    table.insert(this.dropBrandItems, item)
    return item
end

this.OnClickReplay = function()
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroReplay)
    LuaMgr.HidePanel(UIName.BalatroGameEndPopUp)
end

this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.BalatroGameEndPopUp)
    LuaMgr.HidePanel(UIName.BalatroMainViewModel)
    LuaMgr.ShowLuaPanel(UIName.BalatroLaunchPanel)
    BalatroDataMgr.Destroy()
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.newGameBtn, this.OnClickReplay)
        LuaMgr.AddClick(this.backBtn, this.OnClickBack)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length < 1 then
            return
        end
        this.roundStatus = vm.behaviour.Params[0].RoundStatus
        vm.behaviour:PopupBack(this.OnClickBack)
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.newGameBtn, this.OnClickReplay)
        LuaMgr.RemoveClick(this.backBtn, this.OnClickBack)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)